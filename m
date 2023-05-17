Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF650706232
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6d-0002Sb-Dc; Wed, 17 May 2023 04:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6H-00021H-Gf; Wed, 17 May 2023 04:01:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6E-0000Yg-Oj; Wed, 17 May 2023 04:01:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6738E6754;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E343F5E0C;
 Wed, 17 May 2023 11:00:57 +0300 (MSK)
Received: (nullmailer pid 3624111 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8.0.1 11/36] hw/arm/boot: Make write_bootloader() public as
 arm_write_bootloader()
Date: Wed, 17 May 2023 11:00:31 +0300
Message-Id: <20230517080056.3623993-11-mjt@msgid.tls.msk.ru>
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

The arm boot.c code includes a utility function write_bootloader()
which assists in writing a boot-code fragment into guest memory,
including handling endianness and fixing it up with entry point
addresses and similar things.  This is useful not just for the boot.c
code but also in board model code, so rename it to
arm_write_bootloader() and make it globally visible.

Since we are making it public, make its API a little neater: move the
AddressSpace* argument to be next to the hwaddr argument, and allow
the fixupcontext array to be const, since we never modify it in this
function.

Cc: qemu-stable@nongnu.org
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230424152717.1333930-2-peter.maydell@linaro.org
[PMM: Split out from another patch by Cédric, added doc comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 0fe43f0abf19bbe24df3dbf0613bb47ed55f1482)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/arm/boot.c         | 35 +++++++------------------------
 include/hw/arm/boot.h | 49 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 54f6a3e0b3..720f22531a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -60,26 +60,6 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
     return cpu_get_address_space(cs, asidx);
 }
 
-typedef enum {
-    FIXUP_NONE = 0,     /* do nothing */
-    FIXUP_TERMINATOR,   /* end of insns */
-    FIXUP_BOARDID,      /* overwrite with board ID number */
-    FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code address */
-    FIXUP_ARGPTR_LO,    /* overwrite with pointer to kernel args */
-    FIXUP_ARGPTR_HI,    /* overwrite with pointer to kernel args (high half) */
-    FIXUP_ENTRYPOINT_LO, /* overwrite with kernel entry point */
-    FIXUP_ENTRYPOINT_HI, /* overwrite with kernel entry point (high half) */
-    FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
-    FIXUP_BOOTREG,      /* overwrite with boot register address */
-    FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
-    FIXUP_MAX,
-} FixupType;
-
-typedef struct ARMInsnFixup {
-    uint32_t insn;
-    FixupType fixup;
-} ARMInsnFixup;
-
 static const ARMInsnFixup bootloader_aarch64[] = {
     { 0x580000c0 }, /* ldr x0, arg ; Load the lower 32-bits of DTB */
     { 0xaa1f03e1 }, /* mov x1, xzr */
@@ -150,9 +130,10 @@ static const ARMInsnFixup smpboot[] = {
     { 0, FIXUP_TERMINATOR }
 };
 
-static void write_bootloader(const char *name, hwaddr addr,
-                             const ARMInsnFixup *insns, uint32_t *fixupcontext,
-                             AddressSpace *as)
+void arm_write_bootloader(const char *name,
+                          AddressSpace *as, hwaddr addr,
+                          const ARMInsnFixup *insns,
+                          const uint32_t *fixupcontext)
 {
     /* Fix up the specified bootloader fragment and write it into
      * guest memory using rom_add_blob_fixed(). fixupcontext is
@@ -214,8 +195,8 @@ static void default_write_secondary(ARMCPU *cpu,
         fixupcontext[FIXUP_DSB] = CP15_DSB_INSN;
     }
 
-    write_bootloader("smpboot", info->smp_loader_start,
-                     smpboot, fixupcontext, as);
+    arm_write_bootloader("smpboot", as, info->smp_loader_start,
+                         smpboot, fixupcontext);
 }
 
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
@@ -1186,8 +1167,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        write_bootloader("bootloader", info->loader_start,
-                         primary_loader, fixupcontext, as);
+        arm_write_bootloader("bootloader", as, info->loader_start,
+                             primary_loader, fixupcontext);
 
         if (info->write_board_setup) {
             info->write_board_setup(cpu, info);
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index f18cc3064f..80c492d742 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -183,4 +183,53 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
                                             hwaddr mvbar_addr);
 
+typedef enum {
+    FIXUP_NONE = 0,     /* do nothing */
+    FIXUP_TERMINATOR,   /* end of insns */
+    FIXUP_BOARDID,      /* overwrite with board ID number */
+    FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code address */
+    FIXUP_ARGPTR_LO,    /* overwrite with pointer to kernel args */
+    FIXUP_ARGPTR_HI,    /* overwrite with pointer to kernel args (high half) */
+    FIXUP_ENTRYPOINT_LO, /* overwrite with kernel entry point */
+    FIXUP_ENTRYPOINT_HI, /* overwrite with kernel entry point (high half) */
+    FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
+    FIXUP_BOOTREG,      /* overwrite with boot register address */
+    FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
+    FIXUP_MAX,
+} FixupType;
+
+typedef struct ARMInsnFixup {
+    uint32_t insn;
+    FixupType fixup;
+} ARMInsnFixup;
+
+/**
+ * arm_write_bootloader - write a bootloader to guest memory
+ * @name: name of the bootloader blob
+ * @as: AddressSpace to write the bootloader
+ * @addr: guest address to write it
+ * @insns: the blob to be loaded
+ * @fixupcontext: context to be used for any fixups in @insns
+ *
+ * Write a bootloader to guest memory at address @addr in the address
+ * space @as. @name is the name to use for the resulting ROM blob, so
+ * it should be unique in the system and reasonably identifiable for debugging.
+ *
+ * @insns must be an array of ARMInsnFixup structs, each of which has
+ * one 32-bit value to be written to the guest memory, and a fixup to be
+ * applied to the value. FIXUP_NONE (do nothing) is value 0, so effectively
+ * the fixup is optional when writing a struct initializer.
+ * The final entry in the array must be { 0, FIXUP_TERMINATOR }.
+ *
+ * All other supported fixup types have the semantics "ignore insn
+ * and instead use the value from the array element @fixupcontext[fixup]".
+ * The caller should therefore provide @fixupcontext as an array of
+ * size FIXUP_MAX whose elements have been initialized for at least
+ * the entries that @insns refers to.
+ */
+void arm_write_bootloader(const char *name,
+                          AddressSpace *as, hwaddr addr,
+                          const ARMInsnFixup *insns,
+                          const uint32_t *fixupcontext);
+
 #endif /* HW_ARM_BOOT_H */
-- 
2.39.2


