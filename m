Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D593259E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 13:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgKP-00006y-1O; Tue, 16 Jul 2024 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKM-0008U0-V2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKF-0003dP-6t
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZNYAGbIPyRsOwVWWlqiOVUa84ONQUbH1ubPK+l47OlA=;
 b=VKbwolrP5KFst4+0sZL+v7XxzghpH3ly1dQmyvf34xSxCrC1JDKqfWHlUVJr11kqldLBVC
 IzBqX664pP2QYEU/FugTFDLt7u5jq1dScXSnbzrr3VlhF+GO2MdE1T2CMH8/or9oBxoqCD
 oHG886kdjTZ8+89HFBAd46R34gkfp/g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-bJa1TgmGNpeG2rPVtJk-XQ-1; Tue,
 16 Jul 2024 07:26:26 -0400
X-MC-Unique: bJa1TgmGNpeG2rPVtJk-XQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D60191042F; Tue, 16 Jul 2024 11:26:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A96FB1955F40; Tue, 16 Jul 2024 11:26:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 01/11] tests/functional: Add base classes for the upcoming
 pytest-based tests
Date: Tue, 16 Jul 2024 13:26:04 +0200
Message-ID: <20240716112614.1755692-2-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
file with some adjustments to get rid of the Avocado dependencies (i.e.
we also have to drop the LinuxSSHMixIn and LinuxTest for now).

The emulator binary and build directory are now passed via
environment variables that will be set via meson.build later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py | 326 +++++++++++++++++++++++++
 1 file changed, 326 insertions(+)
 create mode 100644 tests/functional/qemu_test/__init__.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
new file mode 100644
index 0000000000..e73705d40a
--- /dev/null
+++ b/tests/functional/qemu_test/__init__.py
@@ -0,0 +1,326 @@
+# Test class and utilities for functional tests
+#
+# Copyright 2018, 2024 Red Hat, Inc.
+#
+# Original Author (Avocado-based tests):
+#  Cleber Rosa <crosa@redhat.com>
+#
+# Adaption for standalone version:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+import os
+import pycotap
+import shutil
+import subprocess
+import sys
+import tempfile
+import time
+import uuid
+import unittest
+
+from pathlib import Path
+from qemu.machine import QEMUMachine
+from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
+                        tcg_available)
+
+def _source_dir():
+    # Determine top-level directory of the QEMU sources
+    return Path(__file__).parent.parent.parent.parent
+
+def _build_dir():
+    root = os.getenv('QEMU_BUILD_ROOT')
+    if root is not None:
+        return Path(root)
+    # Makefile.mtest only exists in build dir, so if it is available, use CWD
+    if os.path.exists('Makefile.mtest'):
+        return Path(os.getcwd())
+
+    root = os.path.join(_source_dir(), 'build')
+    if os.path.exists(root):
+        return Path(root)
+
+    raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
+
+def has_cmd(name, args=None):
+    """
+    This function is for use in a @skipUnless decorator, e.g.:
+
+        @skipUnless(*has_cmd('sudo -n', ('sudo', '-n', 'true')))
+        def test_something_that_needs_sudo(self):
+            ...
+    """
+
+    if args is None:
+        args = ('which', name)
+
+    try:
+        _, stderr, exitcode = run_cmd(args)
+    except Exception as e:
+        exitcode = -1
+        stderr = str(e)
+
+    if exitcode != 0:
+        cmd_line = ' '.join(args)
+        err = f'{name} required, but "{cmd_line}" failed: {stderr.strip()}'
+        return (False, err)
+    else:
+        return (True, '')
+
+def has_cmds(*cmds):
+    """
+    This function is for use in a @skipUnless decorator and
+    allows checking for the availability of multiple commands, e.g.:
+
+        @skipUnless(*has_cmds(('cmd1', ('cmd1', '--some-parameter')),
+                              'cmd2', 'cmd3'))
+        def test_something_that_needs_cmd1_and_cmd2(self):
+            ...
+    """
+
+    for cmd in cmds:
+        if isinstance(cmd, str):
+            cmd = (cmd,)
+
+        ok, errstr = has_cmd(*cmd)
+        if not ok:
+            return (False, errstr)
+
+    return (True, '')
+
+def run_cmd(args):
+    subp = subprocess.Popen(args,
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.PIPE,
+                            universal_newlines=True)
+    stdout, stderr = subp.communicate()
+    ret = subp.returncode
+
+    return (stdout, stderr, ret)
+
+def is_readable_executable_file(path):
+    return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
+
+def _console_interaction(test, success_message, failure_message,
+                         send_string, keep_sending=False, vm=None):
+    assert not keep_sending or send_string
+    if vm is None:
+        vm = test.vm
+    console = vm.console_file
+    console_logger = logging.getLogger('console')
+    while True:
+        if send_string:
+            vm.console_socket.sendall(send_string.encode())
+            if not keep_sending:
+                send_string = None # send only once
+        try:
+            msg = console.readline().decode().strip()
+        except UnicodeDecodeError:
+            msg = None
+        if not msg:
+            continue
+        console_logger.debug(msg)
+        if success_message is None or success_message in msg:
+            break
+        if failure_message and failure_message in msg:
+            console.close()
+            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
+                    (failure_message, success_message)
+            test.fail(fail)
+
+def interrupt_interactive_console_until_pattern(test, success_message,
+                                                failure_message=None,
+                                                interrupt_string='\r'):
+    """
+    Keep sending a string to interrupt a console prompt, while logging the
+    console output. Typical use case is to break a boot loader prompt, such:
+
+        Press a key within 5 seconds to interrupt boot process.
+        5
+        4
+        3
+        2
+        1
+        Booting default image...
+
+    :param test: a  test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    :param interrupt_string: a string to send to the console before trying
+                             to read a new line
+    """
+    _console_interaction(test, success_message, failure_message,
+                         interrupt_string, True)
+
+def wait_for_console_pattern(test, success_message, failure_message=None,
+                             vm=None):
+    """
+    Waits for messages to appear on the console, while logging the content
+
+    :param test: a test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, None, vm=vm)
+
+def exec_command(test, command):
+    """
+    Send a command to a console (appending CRLF characters), while logging
+    the content.
+
+    :param test: a test containing a VM.
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param command: the command to send
+    :type command: str
+    """
+    _console_interaction(test, None, None, command + '\r')
+
+def exec_command_and_wait_for_pattern(test, command,
+                                      success_message, failure_message=None):
+    """
+    Send a command to a console (appending CRLF characters), then wait
+    for success_message to appear on the console, while logging the.
+    content. Mark the test as failed if failure_message is found instead.
+
+    :param test: a test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`qemu_test.QemuSystemTest`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, command + '\r')
+
+class QemuBaseTest(unittest.TestCase):
+
+    qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
+
+    BUILD_DIR = _build_dir()
+
+    workdir = None
+    log = logging.getLogger('qemu-test')
+
+    def setUp(self, bin_prefix):
+        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
+
+        self.workdir = os.path.join(self.BUILD_DIR, 'tests/functional')
+        self.workdir = os.path.join(self.workdir, self.id())
+        if not os.path.exists(self.workdir):
+            os.makedirs(self.workdir)
+
+    def main():
+        tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
+                                   test_output_log = pycotap.LogMode.LogToError)
+        unittest.main(testRunner = tr)
+
+
+class QemuSystemTest(QemuBaseTest):
+    """Facilitates system emulation tests."""
+
+    cpu = None
+    machine = None
+    _machinehelp = None
+
+    def setUp(self):
+        self._vms = {}
+
+        super().setUp('qemu-system-')
+
+    def set_machine(self, machinename):
+        # TODO: We should use QMP to get the list of available machines
+        if not self._machinehelp:
+            self._machinehelp = run_cmd([self.qemu_bin, '-M', 'help'])[0];
+        if self._machinehelp.find(machinename) < 0:
+            self.skipTest('no support for machine ' + machinename)
+        self.machine = machinename
+
+    def require_accelerator(self, accelerator):
+        """
+        Requires an accelerator to be available for the test to continue
+
+        It takes into account the currently set qemu binary.
+
+        If the check fails, the test is canceled.  If the check itself
+        for the given accelerator is not available, the test is also
+        canceled.
+
+        :param accelerator: name of the accelerator, such as "kvm" or "tcg"
+        :type accelerator: str
+        """
+        checker = {'tcg': tcg_available,
+                   'kvm': kvm_available}.get(accelerator)
+        if checker is None:
+            self.skipTest("Don't know how to check for the presence "
+                          "of accelerator %s" % accelerator)
+        if not checker(qemu_bin=self.qemu_bin):
+            self.skipTest("%s accelerator does not seem to be "
+                          "available" % accelerator)
+
+    def require_netdev(self, netdevname):
+        netdevhelp = run_cmd([self.qemu_bin,
+                             '-M', 'none', '-netdev', 'help'])[0];
+        if netdevhelp.find('\n' + netdevname + '\n') < 0:
+            self.skipTest('no support for " + netdevname + " networking')
+
+    def require_device(self, devicename):
+        devhelp = run_cmd([self.qemu_bin,
+                           '-M', 'none', '-device', 'help'])[0];
+        if devhelp.find(devicename) < 0:
+            self.skipTest('no support for device ' + devicename)
+
+    def _new_vm(self, name, *args):
+        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
+        self.log.debug('QEMUMachine "%s" created', name)
+        self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
+        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
+        if args:
+            vm.add_args(*args)
+        return vm
+
+    @property
+    def vm(self):
+        return self.get_vm(name='default')
+
+    def get_vm(self, *args, name=None):
+        if not name:
+            name = str(uuid.uuid4())
+        if self._vms.get(name) is None:
+            self._vms[name] = self._new_vm(name, *args)
+            if self.cpu is not None:
+                self._vms[name].add_args('-cpu', self.cpu)
+            if self.machine is not None:
+                self._vms[name].set_machine(self.machine)
+        return self._vms[name]
+
+    def set_vm_arg(self, arg, value):
+        """
+        Set an argument to list of extra arguments to be given to the QEMU
+        binary. If the argument already exists then its value is replaced.
+
+        :param arg: the QEMU argument, such as "-cpu" in "-cpu host"
+        :type arg: str
+        :param value: the argument value, such as "host" in "-cpu host"
+        :type value: str
+        """
+        if not arg or not value:
+            return
+        if arg not in self.vm.args:
+            self.vm.args.extend([arg, value])
+        else:
+            idx = self.vm.args.index(arg) + 1
+            if idx < len(self.vm.args):
+                self.vm.args[idx] = value
+            else:
+                self.vm.args.append(value)
+
+    def tearDown(self):
+        for vm in self._vms.values():
+            vm.shutdown()
+        super().tearDown()
-- 
2.45.2


