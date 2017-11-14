# -*- coding: utf-8 -*-

# Import python libs
from __future__ import absolute_import
import logging
import os
import re

# Import salt libs
import salt.utils
import salt.utils.files
from salt.exceptions import (
    SaltInvocationError,
    CommandExecutionError,
)

log = logging.getLogger(__name__)


def __virtual__():
    if salt.utils.is_windows():
        return (False, 'The module cannot be loaded on windows.')
    return True


def host_keys(keydir=None, private=True, certs=True):
    '''
    Return the minion's host keys
    CLI Example:
    .. code-block:: bash
        salt '*' ssh.host_keys
        salt '*' ssh.host_keys keydir=/etc/ssh
        salt '*' ssh.host_keys keydir=/etc/ssh private=False
        salt '*' ssh.host_keys keydir=/etc/ssh certs=False
    '''
    # TODO: support parsing sshd_config for the key directory
    if not keydir:
        if __grains__['kernel'] == 'Linux':
            keydir = '/etc/ssh'
        else:
            # If keydir is None, os.listdir() will blow up
            raise SaltInvocationError('ssh.host_keys: Please specify a keydir')
    keys = {}
    fnre = re.compile(
        r'ssh_host_(?P<type>.+)_key(?P<pub>(?P<cert>-cert)?\.pub)?')
    for fn_ in os.listdir(keydir):
        m = fnre.match(fn_)
        if m:
            if not m.group('pub') and private is False:
                log.info(
                    'Skipping private key file {0} as private is set to False'
                    .format(fn_)
                )
                continue
            if m.group('cert') and certs is False:
                log.info(
                    'Skipping key file {0} as certs is set to False'
                    .format(fn_)
                )
                continue

            kname = m.group('type')
            if m.group('pub'):
                kname += m.group('pub')
            try:
                with salt.utils.files.fopen(os.path.join(keydir, fn_), 'r') as _fh:
                    # As of RFC 4716 "a key file is a text file, containing a
                    # sequence of lines", although some SSH implementations
                    # (e.g. OpenSSH) manage their own format(s).  Please see
                    # #20708 for a discussion about how to handle SSH key files
                    # in the future
                    keys[kname] = _fh.readline()
                    # only read the whole file if it is not in the legacy 1.1
                    # binary format
                    if keys[kname] != "SSH PRIVATE KEY FILE FORMAT 1.1\n":
                        keys[kname] += _fh.read()
                    keys[kname] = keys[kname].strip()
            except (IOError, OSError):
                keys[kname] = ''
    return keys
