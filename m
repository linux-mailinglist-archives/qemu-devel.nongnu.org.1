Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034FBE492C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 18:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QoT-0003Aw-Ia; Thu, 16 Oct 2025 12:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoF-0002yl-U5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Qo9-000502-AL
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtN1gEVENajxWp6NZhSyM1+vgWcBVX2W5yJs8hO3NZU=;
 b=F2A6bk9tQ0XNq0Q4JPadHpw7CydpV2zCaZp/ptf+1wIY2NYlrEIYq9XSv8u2YK8q3IOPwP
 0ZlHvsBfyizfXQu3VMNWwkYljkOEm6eI5DNBSjMYNRS2bXvia9dzlo8qRgq5OUyn5PpADI
 SxRqelWPRjfGfJiJa0vaOcjLhOYZPBo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-G9CHJ8P9MyK5GrqNJfsICw-1; Thu,
 16 Oct 2025 12:26:22 -0400
X-MC-Unique: G9CHJ8P9MyK5GrqNJfsICw-1
X-Mimecast-MFC-AGG-ID: G9CHJ8P9MyK5GrqNJfsICw_1760631981
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6773B180057A; Thu, 16 Oct 2025 16:26:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4E931956056; Thu, 16 Oct 2025 16:26:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/10] tests/functional: remove use of getLogger in reverse
 debuging
Date: Thu, 16 Oct 2025 18:25:58 +0200
Message-ID: <20251016162601.442557-8-thuth@redhat.com>
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
References: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This fixes the gap left by

  commit 8a44d8c2ac0921c8064fbfd00ef28e3a2588918e
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Fri Sep 12 19:22:00 2025 +0100

    tests/functional: use self.log for all logging

ensuring that log message from the reverse debugging test actually
make it into the logfile on disk.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251014140047.385347-2-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/reverse_debugging.py | 49 ++++++++++++---------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index 68cfcb39856..2c37a62cd06 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -36,14 +36,13 @@ class ReverseDebugging(LinuxKernelTest):
     STEPS = 10
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
-        logger = logging.getLogger('replay')
         vm = self.get_vm(name='record' if record else 'replay')
         vm.set_console()
         if record:
-            logger.info('recording the execution...')
+            self.log.info('recording the execution...')
             mode = 'record'
         else:
-            logger.info('replaying the execution...')
+            self.log.info('replaying the execution...')
             mode = 'replay'
             vm.add_args('-gdb', 'tcp::%d' % port, '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
@@ -68,10 +67,8 @@ def vm_get_icount(vm):
     def reverse_debugging(self, gdb_arch, shift=7, args=None):
         from qemu_test import GDB
 
-        logger = logging.getLogger('replay')
-
         # create qcow2 for snapshots
-        logger.info('creating qcow2 image for VM snapshots')
+        self.log.info('creating qcow2 image for VM snapshots')
         image_path = os.path.join(self.workdir, 'disk.qcow2')
         qemu_img = get_qemu_img(self)
         if qemu_img is None:
@@ -79,7 +76,7 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
                           'create the temporary qcow2 image')
         out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
                            encoding='utf8')
-        logger.info("qemu-img: %s" % out)
+        self.log.info("qemu-img: %s" % out)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
 
@@ -90,7 +87,7 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
         last_icount = self.vm_get_icount(vm)
         vm.shutdown()
 
-        logger.info("recorded log with %s+ steps" % last_icount)
+        self.log.info("recorded log with %s+ steps" % last_icount)
 
         # replay and run debug commands
         with Ports() as ports:
@@ -98,9 +95,9 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
             vm = self.run_vm(False, shift, args, replay_path, image_path, port)
 
         try:
-            logger.info('Connecting to gdbstub...')
+            self.log.info('Connecting to gdbstub...')
             self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
-            logger.info('Test passed.')
+            self.log.info('Test passed.')
         except GDB.TimeoutError:
             # Convert a GDB timeout exception into a unittest failure exception.
             raise self.failureException("Timeout while connecting to or "
@@ -111,8 +108,6 @@ def reverse_debugging(self, gdb_arch, shift=7, args=None):
             raise
 
     def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
-        logger = logging.getLogger('replay')
-
         gdb_cmd = os.getenv('QEMU_TEST_GDB')
         gdb = GDB(gdb_cmd)
 
@@ -135,43 +130,43 @@ def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
 
         gdb.cli("set debug remote 0")
 
-        logger.info('stepping forward')
+        self.log.info('stepping forward')
         steps = []
         # record first instruction addresses
         for _ in range(self.STEPS):
             pc = self.get_pc(gdb)
-            logger.info('saving position %x' % pc)
+            self.log.info('saving position %x' % pc)
             steps.append(pc)
             gdb.cli("stepi")
 
         # visit the recorded instruction in reverse order
-        logger.info('stepping backward')
+        self.log.info('stepping backward')
         for addr in steps[::-1]:
-            logger.info('found position %x' % addr)
+            self.log.info('found position %x' % addr)
             gdb.cli("reverse-stepi")
             pc = self.get_pc(gdb)
             if pc != addr:
-                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.log.info('Invalid PC (read %x instead of %x)' % (pc, addr))
                 self.fail('Reverse stepping failed!')
 
         # visit the recorded instruction in forward order
-        logger.info('stepping forward')
+        self.log.info('stepping forward')
         for addr in steps:
-            logger.info('found position %x' % addr)
+            self.log.info('found position %x' % addr)
             pc = self.get_pc(gdb)
             if pc != addr:
-                logger.info('Invalid PC (read %x instead of %x)' % (pc, addr))
+                self.log.info('Invalid PC (read %x instead of %x)' % (pc, addr))
                 self.fail('Forward stepping failed!')
             gdb.cli("stepi")
 
         # set breakpoints for the instructions just stepped over
-        logger.info('setting breakpoints')
+        self.log.info('setting breakpoints')
         for addr in steps:
             gdb.cli(f"break *{hex(addr)}")
 
         # this may hit a breakpoint if first instructions are executed
         # again
-        logger.info('continuing execution')
+        self.log.info('continuing execution')
         vm.qmp('replay-break', icount=last_icount - 1)
         # continue - will return after pausing
         # This can stop at the end of the replay-break and gdb gets a SIGINT,
@@ -180,12 +175,12 @@ def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
         gdb.cli("continue")
 
         if self.vm_get_icount(vm) == last_icount - 1:
-            logger.info('reached the end (icount %s)' % (last_icount - 1))
+            self.log.info('reached the end (icount %s)' % (last_icount - 1))
         else:
-            logger.info('hit a breakpoint again at %x (icount %s)' %
+            self.log.info('hit a breakpoint again at %x (icount %s)' %
                         (self.get_pc(gdb), self.vm_get_icount(vm)))
 
-        logger.info('running reverse continue to reach %x' % steps[-1])
+        self.log.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
         gdb.cli("reverse-continue")
 
@@ -195,8 +190,8 @@ def reverse_debugging_run(self, vm, port, gdb_arch, last_icount):
         if pc != steps[-1]:
             self.fail("'reverse-continue' did not hit the first PC in reverse order!")
 
-        logger.info('successfully reached %x' % steps[-1])
+        self.log.info('successfully reached %x' % steps[-1])
 
-        logger.info('exiting gdb and qemu')
+        self.log.info('exiting gdb and qemu')
         gdb.exit()
         vm.shutdown()
-- 
2.51.0


