Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE4770844
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwE-0002HP-J3; Fri, 04 Aug 2023 14:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwB-0002GB-NF; Fri, 04 Aug 2023 14:54:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzw9-00087a-Kd; Fri, 04 Aug 2023 14:54:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F09A518409;
 Fri,  4 Aug 2023 21:54:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8253C1B880;
 Fri,  4 Aug 2023 21:53:57 +0300 (MSK)
Received: (nullmailer pid 1874209 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 John Reiser <jreiser@BitWagon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 19/36] linux-user/armeb: Fix __kernel_cmpxchg() for
 armeb
Date: Fri,  4 Aug 2023 21:53:32 +0300
Message-Id: <20230804185350.1874133-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
content, but missed to endianess-swap the oldval and newval values when
emulating an armeb CPU, which expects words to be stored in big endian in
the guest memory.

The bug can be verified with qemu >= v7.0 on any little-endian host, when
starting the armeb binary of the upx program, which just hangs without
this patch.

Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reported-by: John Reiser <jreiser@BitWagon.com>
Closes: https://github.com/upx/upx/issues/687
Message-Id: <ZMQVnqY+F+5sTNFd@p100>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 38dd78c41eaf08b490c9e7ec68fc508bbaa5cb1d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index c0790f3246..85804c367a 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -117,8 +117,9 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *env)
 {
     uint32_t oldval, newval, val, addr, cpsr, *host_addr;
 
-    oldval = env->regs[0];
-    newval = env->regs[1];
+    /* Swap if host != guest endianness, for the host cmpxchg below */
+    oldval = tswap32(env->regs[0]);
+    newval = tswap32(env->regs[1]);
     addr = env->regs[2];
 
     mmap_lock();
@@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
         return;
     }
 
+    /* Swap if host != guest endianness, for the host cmpxchg below */
+    oldval = tswap64(oldval);
+    newval = tswap64(newval);
+
 #ifdef CONFIG_ATOMIC64
     val = qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
     cpsr = (val == oldval) * CPSR_C;
-- 
2.39.2


