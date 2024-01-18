Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA66831389
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:58:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNGk-00083P-Jq; Thu, 18 Jan 2024 02:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGX-0007Uv-1n; Thu, 18 Jan 2024 02:56:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNGU-0007zD-KT; Thu, 18 Jan 2024 02:56:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F2AF64504B;
 Thu, 18 Jan 2024 10:54:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 27862661B3;
 Thu, 18 Jan 2024 10:54:07 +0300 (MSK)
Received: (nullmailer pid 2381726 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 32/38] target/hppa: Fix PDC address translation on
 PA2.0 with PSW.W=0
Date: Thu, 18 Jan 2024 10:52:59 +0300
Message-Id: <20240118075404.2381519-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

Fix the address translation for PDC space on PA2.0 if PSW.W=0.
Basically, for any address in the 32-bit PDC range from 0xf0000000 to
0xf1000000 keep the lower 32-bits and just set the upper 32-bits to
0xfffffff0.

This mapping fixes the emulated power button in PDC space for 32- and
64-bit machines and is how the physical C3700 machine seems to map
PDC.

Figures H-10 and H-11 in the parisc2.0 spec [1] show that the 32-bit
region will be mapped somewhere into a higher and bigger 64-bit PDC
space.  The start and end of this 64-bit space is defined by the
physical address bits. But the figures don't specifiy where exactly the
mapping will start inside that region. Tests on a real HP C3700
regarding the address of the power button indicate, that the lower
32-bits will stay the same though.
[1] https://parisc.wiki.kernel.org/images-parisc/7/73/Parisc2.0.pdf

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Bruno Haible <bruno@clisp.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 6ce18d530638f6e4eb87ef8737c634e34362ad2b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 4c6ecda618..e4eac85880 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 4c6ecda618f2066707f50c53f31419244fd7f77a
+Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 08abd1a9f9..4c28c58ee9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -55,8 +55,14 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
         /* I/O address space */
         addr = (int32_t)addr;
     } else {
-        /* PDC address space */
-        addr &= MAKE_64BIT_MASK(0, 24);
+        /*
+         * PDC address space:
+         * Figures H-10 and H-11 of the parisc2.0 spec do not specify
+         * where to map into the 64-bit PDC address space.
+         * We map with an offset which equals the 32-bit address, which
+         * is what can be seen on physical machines too.
+         */
+        addr = (uint32_t)addr;
         addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
     }
     return addr;
-- 
2.39.2


