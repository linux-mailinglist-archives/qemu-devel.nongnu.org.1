Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881B7063A9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDBl-0000vO-QE; Wed, 17 May 2023 05:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBi-0000u9-6J; Wed, 17 May 2023 05:11:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDBg-0006OT-B6; Wed, 17 May 2023 05:11:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4F076832;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 399035F03;
 Wed, 17 May 2023 12:10:44 +0300 (MSK)
Received: (nullmailer pid 3626702 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7.2.3 12/30] target/arm: Define and use new
 load_cpu_field_low32()
Date: Wed, 17 May 2023 12:10:24 +0300
Message-Id: <20230517091042.3626593-12-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In several places in the 32-bit Arm translate.c, we try to use
load_cpu_field() to load from a CPUARMState field into a TCGv_i32
where the field is actually 64-bit. This works on little-endian
hosts, but gives the wrong half of the register on big-endian.

Add a new load_cpu_field_low32() which loads the low 32 bits
of a 64-bit field into a TCGv_i32. The new macro includes a
compile-time check against accidentally using it on a field
of the wrong size. Use it to fix the two places in the code
where we were using load_cpu_field() on a 64-bit field.

This fixes a bug where on big-endian hosts the guest would
crash after executing an ERET instruction, and a more corner
case one where some UNDEFs for attempted accesses to MSR
banked registers from Secure EL1 might go to the wrong EL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230424153909.1419369-2-peter.maydell@linaro.org
(cherry picked from commit 7f3a3d3dc433dc06c0adb480729af80f9c8e3739)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/arm/translate-a32.h | 7 +++++++
 target/arm/translate.c     | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a32.h b/target/arm/translate-a32.h
index 5339c22f1e..99eea85fa8 100644
--- a/target/arm/translate-a32.h
+++ b/target/arm/translate-a32.h
@@ -61,6 +61,13 @@ static inline TCGv_i32 load_cpu_offset(int offset)
 
 #define load_cpu_field(name) load_cpu_offset(offsetof(CPUARMState, name))
 
+/* Load from the low half of a 64-bit field to a TCGv_i32 */
+#define load_cpu_field_low32(name)                                      \
+    ({                                                                  \
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, name) != 8);        \
+        load_cpu_offset(offsetoflow32(CPUARMState, name));              \
+    })
+
 void store_cpu_offset(TCGv_i32 var, int offset, int size);
 
 #define store_cpu_field(var, name)                              \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1dcaefb8e7..a06da05640 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2886,7 +2886,7 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
             if (arm_dc_feature(s, ARM_FEATURE_AARCH64) &&
                 dc_isar_feature(aa64_sel2, s)) {
                 /* Target EL is EL<3 minus SCR_EL3.EEL2> */
-                tcg_el = load_cpu_field(cp15.scr_el3);
+                tcg_el = load_cpu_field_low32(cp15.scr_el3);
                 tcg_gen_sextract_i32(tcg_el, tcg_el, ctz32(SCR_EEL2), 1);
                 tcg_gen_addi_i32(tcg_el, tcg_el, 3);
             } else {
@@ -6558,7 +6558,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     }
     if (s->current_el == 2) {
         /* ERET from Hyp uses ELR_Hyp, not LR */
-        tmp = load_cpu_field(elr_el[2]);
+        tmp = load_cpu_field_low32(elr_el[2]);
     } else {
         tmp = load_reg(s, 14);
     }
-- 
2.39.2


