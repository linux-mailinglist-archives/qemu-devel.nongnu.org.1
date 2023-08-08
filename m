Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B87737E6
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEE4-0000yx-1T; Tue, 08 Aug 2023 00:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEE0-0000eP-OH; Tue, 08 Aug 2023 00:21:40 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDz-0007rH-0X; Tue, 08 Aug 2023 00:21:40 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686f1240a22so5071786b3a.0; 
 Mon, 07 Aug 2023 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468497; x=1692073297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUxtws3efJ/zcMLuM2mcZXvJskxwLw3PDsxQvmIrbn0=;
 b=LjM2pNRekJYwK7hy7FKjtTZ1riuTzOeLtC3XJOXWIEM/Gsa6d8s/Q/dt2UElkSWoS0
 1Ak8/Q/5qxK51YT/0/X80zaVfCnZIK/Nm+RQ0KGF4ma06g/0GZOtOHLO3tUe39+8oNAB
 IJunZ56aHV+LBedhV/1cOfzxA3U7LTnYXYrNiYm+TREB3P4l7fQTGMIrVRUUQN1eCxqX
 +UCjf0inpxpQvRlDiK1Oth1br+KB0F/BDoiYXyFGHPaQAhYLcrYM8l86PLC7+baj9S9c
 q6rb4b/uMnLlWItPOp3mJ8huJ9JM14Z86Jl0AxM+tRcgt+yW5RmNIlA0ZU0eXfWoqIdj
 SXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468497; x=1692073297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUxtws3efJ/zcMLuM2mcZXvJskxwLw3PDsxQvmIrbn0=;
 b=FGs2LVPYzC80M7FeKrIHgho3IH4eGX66LWcw0didlNjVu3KSFD4bVMbU5062P3saF7
 7vW/RA2Ehr3EFkso7MU24TamwiAQknjNRXcKncU084VIjLrLAbfX6od42AgmPqckBFhz
 MZPTWuEDaEahoWqdFO/eECYWRbf4EWyyJT1XMmb+gXTunc4KF52HvmaHJsqfU/PeBuqq
 kJGE9vKoprsT2JQDpdle+90OKNJtvk6T9PCzP6vCtr+GEdAyagyCZZjHk8W9wApCwDS0
 4h+nWU+XUVHcUdh31lbpRgFoNe6rtvyCZkCLXXge3xXCKNw/7JBOgUuPo63EV7D/+X9B
 l5OQ==
X-Gm-Message-State: AOJu0YxV68hTaB+U0pc/RaHDKId9ywhl708ESi3W7Y6xWXYhCYBmBCFj
 N6t/cROWle+Lp3Qf4ScTNu8=
X-Google-Smtp-Source: AGHT+IHjv4Gc16NkZgpaPjtLvgzcVJ/gFSkDdV7hiAqvJ+ypUA/RfGOHEbNdBGzP+bkBDqbRpY1/5g==
X-Received: by 2002:a05:6a00:b90:b0:681:50fd:2b98 with SMTP id
 g16-20020a056a000b9000b0068150fd2b98mr14446971pfj.31.1691468497333; 
 Mon, 07 Aug 2023 21:21:37 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 18/19] tests/avocado: reverse-debugging cope with
 re-executing breakpoints
Date: Tue,  8 Aug 2023 14:20:00 +1000
Message-Id: <20230808042001.411094-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 tests/avocado/reverse_debugging.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 680c314cfc..7d1a478df1 100644
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
2.40.1


