Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D13B7063B1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:13:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDBS-0000FW-SW; Wed, 17 May 2023 05:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBO-0000C4-Rn; Wed, 17 May 2023 05:10:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBL-0006Nn-7K; Wed, 17 May 2023 05:10:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F5E66830;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E905E5EFD;
 Wed, 17 May 2023 12:10:43 +0300 (MSK)
Received: (nullmailer pid 3626696 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7.2.3 10/30] hw/arm/raspi: Use arm_write_bootloader() to
 write boot code
Date: Wed, 17 May 2023 12:10:22 +0300
Message-Id: <20230517091042.3626593-10-mjt@msgid.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

When writing the secondary-CPU stub boot loader code to the guest,
use arm_write_bootloader() instead of directly calling
rom_add_blob_fixed().  This fixes a bug on big-endian hosts, because
arm_write_bootloader() will correctly byte-swap the host-byte-order
array values into the guest-byte-order to write into the guest
memory.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230424152717.1333930-4-peter.maydell@linaro.org
(cherry picked from commit 0acbdb4c4ab6b0a09f159bae4899b0737cf64242)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/arm/raspi.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 92d068d1f9..a7d287b1a8 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -16,6 +16,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
@@ -124,20 +125,22 @@ static const char *board_type(uint32_t board_rev)
 
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
-    static const uint32_t smpboot[] = {
-        0xe1a0e00f, /*    mov     lr, pc */
-        0xe3a0fe00 + (BOARDSETUP_ADDR >> 4), /* mov pc, BOARDSETUP_ADDR */
-        0xee100fb0, /*    mrc     p15, 0, r0, c0, c0, 5;get core ID */
-        0xe7e10050, /*    ubfx    r0, r0, #0, #2       ;extract LSB */
-        0xe59f5014, /*    ldr     r5, =0x400000CC      ;load mbox base */
-        0xe320f001, /* 1: yield */
-        0xe7953200, /*    ldr     r3, [r5, r0, lsl #4] ;read mbox for our core*/
-        0xe3530000, /*    cmp     r3, #0               ;spin while zero */
-        0x0afffffb, /*    beq     1b */
-        0xe7853200, /*    str     r3, [r5, r0, lsl #4] ;clear mbox */
-        0xe12fff13, /*    bx      r3                   ;jump to target */
-        0x400000cc, /* (constant: mailbox 3 read/clear base) */
+    static const ARMInsnFixup smpboot[] = {
+        { 0xe1a0e00f }, /*    mov     lr, pc */
+        { 0xe3a0fe00 + (BOARDSETUP_ADDR >> 4) }, /* mov pc, BOARDSETUP_ADDR */
+        { 0xee100fb0 }, /*    mrc     p15, 0, r0, c0, c0, 5;get core ID */
+        { 0xe7e10050 }, /*    ubfx    r0, r0, #0, #2       ;extract LSB */
+        { 0xe59f5014 }, /*    ldr     r5, =0x400000CC      ;load mbox base */
+        { 0xe320f001 }, /* 1: yield */
+        { 0xe7953200 }, /*    ldr     r3, [r5, r0, lsl #4] ;read mbox for our core */
+        { 0xe3530000 }, /*    cmp     r3, #0               ;spin while zero */
+        { 0x0afffffb }, /*    beq     1b */
+        { 0xe7853200 }, /*    str     r3, [r5, r0, lsl #4] ;clear mbox */
+        { 0xe12fff13 }, /*    bx      r3                   ;jump to target */
+        { 0x400000cc }, /* (constant: mailbox 3 read/clear base) */
+        { 0, FIXUP_TERMINATOR }
     };
+    static const uint32_t fixupcontext[FIXUP_MAX] = { 0 };
 
     /* check that we don't overrun board setup vectors */
     QEMU_BUILD_BUG_ON(SMPBOOT_ADDR + sizeof(smpboot) > MVBAR_ADDR);
@@ -145,9 +148,8 @@ static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
     QEMU_BUILD_BUG_ON((BOARDSETUP_ADDR & 0xf) != 0
                       || (BOARDSETUP_ADDR >> 4) >= 0x100);
 
-    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
-                          info->smp_loader_start,
-                          arm_boot_address_space(cpu, info));
+    arm_write_bootloader("raspi_smpboot", arm_boot_address_space(cpu, info),
+                         info->smp_loader_start, smpboot, fixupcontext);
 }
 
 static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
@@ -161,26 +163,28 @@ static void write_smpboot64(ARMCPU *cpu, const struct arm_boot_info *info)
      * the primary CPU goes into the kernel. We put these variables inside
      * a rom blob, so that the reset for ROM contents zeroes them for us.
      */
-    static const uint32_t smpboot[] = {
-        0xd2801b05, /*        mov     x5, 0xd8 */
-        0xd53800a6, /*        mrs     x6, mpidr_el1 */
-        0x924004c6, /*        and     x6, x6, #0x3 */
-        0xd503205f, /* spin:  wfe */
-        0xf86678a4, /*        ldr     x4, [x5,x6,lsl #3] */
-        0xb4ffffc4, /*        cbz     x4, spin */
-        0xd2800000, /*        mov     x0, #0x0 */
-        0xd2800001, /*        mov     x1, #0x0 */
-        0xd2800002, /*        mov     x2, #0x0 */
-        0xd2800003, /*        mov     x3, #0x0 */
-        0xd61f0080, /*        br      x4 */
+    static const ARMInsnFixup smpboot[] = {
+        { 0xd2801b05 }, /*        mov     x5, 0xd8 */
+        { 0xd53800a6 }, /*        mrs     x6, mpidr_el1 */
+        { 0x924004c6 }, /*        and     x6, x6, #0x3 */
+        { 0xd503205f }, /* spin:  wfe */
+        { 0xf86678a4 }, /*        ldr     x4, [x5,x6,lsl #3] */
+        { 0xb4ffffc4 }, /*        cbz     x4, spin */
+        { 0xd2800000 }, /*        mov     x0, #0x0 */
+        { 0xd2800001 }, /*        mov     x1, #0x0 */
+        { 0xd2800002 }, /*        mov     x2, #0x0 */
+        { 0xd2800003 }, /*        mov     x3, #0x0 */
+        { 0xd61f0080 }, /*        br      x4 */
+        { 0, FIXUP_TERMINATOR }
     };
+    static const uint32_t fixupcontext[FIXUP_MAX] = { 0 };
 
     static const uint64_t spintables[] = {
         0, 0, 0, 0
     };
 
-    rom_add_blob_fixed_as("raspi_smpboot", smpboot, sizeof(smpboot),
-                          info->smp_loader_start, as);
+    arm_write_bootloader("raspi_smpboot", as, info->smp_loader_start,
+                         smpboot, fixupcontext);
     rom_add_blob_fixed_as("raspi_spintables", spintables, sizeof(spintables),
                           SPINTABLE_ADDR, as);
 }
-- 
2.39.2


