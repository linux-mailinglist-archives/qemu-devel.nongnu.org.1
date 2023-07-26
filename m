Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D597D763EB3
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjN0-0000nL-Iv; Wed, 26 Jul 2023 14:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMu-0000mB-IX; Wed, 26 Jul 2023 14:36:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMr-0008LO-2l; Wed, 26 Jul 2023 14:36:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bb81809ca8so652025ad.3; 
 Wed, 26 Jul 2023 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396570; x=1691001370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfyXIMhke3pUYlVdSvBeKeV9PKI5Be14OsNtsHaMr9Q=;
 b=fsVibz+aKHEfU6mih+EcUqPOZ0gjuiVfGyztemTQ+p5CrnHsQkzwA9WgymKugHPdd1
 7bi/uLj5GS6OeiFQATINQL4mQGqgMnpjKd4Oy/UAHqlL+CMjr/IeqN27nnbawke7HhWa
 k4XCDQYOj5gCTMDy1QKP0OxGqJCAUcah6UxGD1W5mYeYs/1NQuYjJrZkgjBTPonCUyZX
 TsIAVhlmUtIc8Xj8tbBbPL3fYsbNWnbqom9TIm2gErD3yNzWZ79Bqd4i4VYNVpPnKIJX
 8Bn7fI/bxxjquBhCdyVi4i73z/THZhXX6ouhSEERM9biCfa5ceZuTGNBA65RDpuOnnY6
 cF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396570; x=1691001370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfyXIMhke3pUYlVdSvBeKeV9PKI5Be14OsNtsHaMr9Q=;
 b=TsNMgKK6czCj5/FcIX5B6kF0BIS9ydm9hm1F7aOEiMH4iJZ5GR/ZGMEwWAoEIZnvAy
 pVkHLX1fysiQEjeT41GMVEi+7ICBHseukAbKtZvvfKI6W198L1zNtLQ+N7odksTgTlUj
 zM5UbUNEdXjE7pqIVt2dE74Xnvsc0XEGrlxdS4XilYTIEZAFB5iPyb9etZyQeyRRTqpa
 BRZYAgnJGA3saNTYSI9s6LZInXNkSuByQTXwvo+ajFQV5sR3jvvubJErsQj/t9SggZt1
 SD2n5W7KE75sMkudmgoDaqtzykTi0CUsOOR9MiqVZYTb4rwrtFeh1R/LkFVZjMRGZyZl
 9Pnw==
X-Gm-Message-State: ABy/qLYezQUt+IXhSPcxAgBsZ2MTYiGc7lG4jfEI+gUp+Oo6MtnwgWPq
 a7T0e/M2pG2l0uAs8hJDsaQ=
X-Google-Smtp-Source: APBJJlE9mhOBSplNZQD7aAqsYFFWCpeIURRCNNcdbZ4SX5zRJJozI/Qb1hzpwIWfNVTeLQWwTsmi4g==
X-Received: by 2002:a17:902:f546:b0:1bb:ce4a:5893 with SMTP id
 h6-20020a170902f54600b001bbce4a5893mr2627072plf.30.1690396570611; 
 Wed, 26 Jul 2023 11:36:10 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:36:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 6/7] tests/avocado: reverse-debugging cope with re-executing
 breakpoints
Date: Thu, 27 Jul 2023 04:35:31 +1000
Message-Id: <20230726183532.434380-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Permit this breakpoint re-execution by switching steps 4 and 5, so that
the trace will be run to the end *or* the next breakpoint hit.
Reversing from there to the 10th intsruction will not hit another
breakpoint, by definition.

Another step is added between steps 2 and 3, which steps forward over
the first 10 instructions and verifies their addresses, to support this.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
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


