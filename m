Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB1706224
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6J-0001yu-De; Wed, 17 May 2023 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC5z-0001s8-7q; Wed, 17 May 2023 04:01:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC5t-0000Yh-Ma; Wed, 17 May 2023 04:01:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F4426755;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 13EBC5E0D;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: (nullmailer pid 3624114 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8.0.1 12/36] hw/arm/aspeed: Use arm_write_bootloader() to
 write the bootloader
Date: Wed, 17 May 2023 11:00:32 +0300
Message-Id: <20230517080056.3623993-12-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cédric Le Goater <clg@kaod.org>

When writing the secondary-CPU stub boot loader code to the guest,
use arm_write_bootloader() instead of directly calling
rom_add_blob_fixed().  This fixes a bug on big-endian hosts, because
arm_write_bootloader() will correctly byte-swap the host-byte-order
array values into the guest-byte-order to write into the guest
memory.

Cc: qemu-stable@nongnu.org
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230424152717.1333930-3-peter.maydell@linaro.org
[PMM: Moved the "make arm_write_bootloader() function public" part
 to its own patch; updated commit message to note that this fixes
 an actual bug; adjust to the API changes noted in previous commit]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 902bba549fc386b4b9805320ed1a2e5b68478bdd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/arm/aspeed.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c1f2b9cfca..0b29028fe1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -200,33 +200,35 @@ struct AspeedMachineState {
 static void aspeed_write_smpboot(ARMCPU *cpu,
                                  const struct arm_boot_info *info)
 {
-    static const uint32_t poll_mailbox_ready[] = {
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+    static const ARMInsnFixup poll_mailbox_ready[] = {
         /*
          * r2 = per-cpu go sign value
          * r1 = AST_SMP_MBOX_FIELD_ENTRY
          * r0 = AST_SMP_MBOX_FIELD_GOSIGN
          */
-        0xee100fb0,  /* mrc     p15, 0, r0, c0, c0, 5 */
-        0xe21000ff,  /* ands    r0, r0, #255          */
-        0xe59f201c,  /* ldr     r2, [pc, #28]         */
-        0xe1822000,  /* orr     r2, r2, r0            */
-
-        0xe59f1018,  /* ldr     r1, [pc, #24]         */
-        0xe59f0018,  /* ldr     r0, [pc, #24]         */
-
-        0xe320f002,  /* wfe                           */
-        0xe5904000,  /* ldr     r4, [r0]              */
-        0xe1520004,  /* cmp     r2, r4                */
-        0x1afffffb,  /* bne     <wfe>                 */
-        0xe591f000,  /* ldr     pc, [r1]              */
-        AST_SMP_MBOX_GOSIGN,
-        AST_SMP_MBOX_FIELD_ENTRY,
-        AST_SMP_MBOX_FIELD_GOSIGN,
+        { 0xee100fb0 },  /* mrc     p15, 0, r0, c0, c0, 5 */
+        { 0xe21000ff },  /* ands    r0, r0, #255          */
+        { 0xe59f201c },  /* ldr     r2, [pc, #28]         */
+        { 0xe1822000 },  /* orr     r2, r2, r0            */
+
+        { 0xe59f1018 },  /* ldr     r1, [pc, #24]         */
+        { 0xe59f0018 },  /* ldr     r0, [pc, #24]         */
+
+        { 0xe320f002 },  /* wfe                           */
+        { 0xe5904000 },  /* ldr     r4, [r0]              */
+        { 0xe1520004 },  /* cmp     r2, r4                */
+        { 0x1afffffb },  /* bne     <wfe>                 */
+        { 0xe591f000 },  /* ldr     pc, [r1]              */
+        { AST_SMP_MBOX_GOSIGN },
+        { AST_SMP_MBOX_FIELD_ENTRY },
+        { AST_SMP_MBOX_FIELD_GOSIGN },
+        { 0, FIXUP_TERMINATOR }
     };
+    static const uint32_t fixupcontext[FIXUP_MAX] = { 0 };
 
-    rom_add_blob_fixed("aspeed.smpboot", poll_mailbox_ready,
-                       sizeof(poll_mailbox_ready),
-                       info->smp_loader_start);
+    arm_write_bootloader("aspeed.smpboot", as, info->smp_loader_start,
+                         poll_mailbox_ready, fixupcontext);
 }
 
 static void aspeed_reset_secondary(ARMCPU *cpu,
-- 
2.39.2


