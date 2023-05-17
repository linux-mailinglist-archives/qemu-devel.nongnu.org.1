Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9CF7063CB
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDBj-0000u6-8G; Wed, 17 May 2023 05:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBg-0000sz-Um; Wed, 17 May 2023 05:11:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBf-0006Nm-6d; Wed, 17 May 2023 05:11:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E94A682F;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C234F5EFC;
 Wed, 17 May 2023 12:10:43 +0300 (MSK)
Received: (nullmailer pid 3626693 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7.2.3 09/30] hw/arm/aspeed: Use arm_write_bootloader() to
 write the bootloader
Date: Wed, 17 May 2023 12:10:21 +0300
Message-Id: <20230517091042.3626593-9-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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
index 55f114ef72..97fb1916ec 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -188,33 +188,35 @@ struct AspeedMachineState {
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


