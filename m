Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6E79146E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Yz-0003tX-A2; Mon, 04 Sep 2023 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yl-0003bJ-Ey; Mon, 04 Sep 2023 05:07:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yh-0003t1-KX; Mon, 04 Sep 2023 05:07:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN812Z9nz4wy1;
 Mon,  4 Sep 2023 19:07:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7z1vfXz4wxN;
 Mon,  4 Sep 2023 19:07:43 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 26/35] tests/avocado: reverse-debugging cope with re-executing
 breakpoints
Date: Mon,  4 Sep 2023 11:06:21 +0200
Message-ID: <20230904090630.725952-27-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

From: Nicholas Piggin <npiggin@gmail.com>

The reverse-debugging test creates a trace, then replays it and:

1. Steps the first 10 instructions and records their addresses.
2. Steps backward and verifies their addresses match.
3. Runs to (near) the end of the trace.
4. Sets breakpoints on the first 10 instructions.
5. Continues backward and verifies execution stops at the last
   breakpoint.

Step 5 breaks if any of the other 9 breakpoints are re-executed in the
trace after the 10th instruction is run, because those will be
unexpectedly hit when reverse continuing. This situation does arise
with the ppc pseries machine, the SLOF bios branches to its own entry
point.

Deal with this by switching steps 3 and 4, so the trace will be run to
the end *or* one of the breakpoints being re-executed. Step 5 then
reverses from there to the 10th instruction will not hit a breakpoint in
between, by definition.

Another step is added between steps 2 and 3, which steps forward over
the first 10 instructions and verifies their addresses, to support this.

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 tests/avocado/reverse_debugging.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 680c314cfccf..7d1a478df143 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -150,16 +150,33 @@ def reverse_debugging(self, shift=7, args=None):
             self.check_pc(g, addr)
             logger.info('found position %x' % addr)
 
-        logger.info('seeking to the end (icount %s)' % (last_icount - 1))
-        vm.qmp('replay-break', icount=last_icount - 1)
-        # continue - will return after pausing
-        g.cmd(b'c', b'T02thread:01;')
+        # visit the recorded instruction in forward order
+        logger.info('stepping forward')
+        for addr in steps:
+            self.check_pc(g, addr)
+            self.gdb_step(g)
+            logger.info('found position %x' % addr)
 
+        # set breakpoints for the instructions just stepped over
         logger.info('setting breakpoints')
         for addr in steps:
             # hardware breakpoint at addr with len=1
             g.cmd(b'Z1,%x,1' % addr, b'OK')
 
+        # this may hit a breakpoint if first instructions are executed
+        # again
+        logger.info('continuing execution')
+        vm.qmp('replay-break', icount=last_icount - 1)
+        # continue - will return after pausing
+        # This could stop at the end and get a T02 return, or by
+        # re-executing one of the breakpoints and get a T05 return.
+        g.cmd(b'c')
+        if self.vm_get_icount(vm) == last_icount - 1:
+            logger.info('reached the end (icount %s)' % (last_icount - 1))
+        else:
+            logger.info('hit a breakpoint again at %x (icount %s)' %
+                        (self.get_pc(g), self.vm_get_icount(vm)))
+
         logger.info('running reverse continue to reach %x' % steps[-1])
         # reverse continue - will return after stopping at the breakpoint
         g.cmd(b'bc', b'T05thread:01;')
-- 
2.41.0


