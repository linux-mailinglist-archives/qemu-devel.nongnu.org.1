Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6516F73B78E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfxH-00029j-Ek; Fri, 23 Jun 2023 08:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx6-0001ca-Dq
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx2-0000gY-GG
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fa71db4208so6679505e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523503; x=1690115503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kxtNiq+I2c3YFpGyQ+IkSBdS2EDpw32G/XAY9b0bkas=;
 b=r9wEoJ0NlnW8/v0AJXEavZsJZy40uLhhY1wPIob9FNjv9meRWPld9p2aMi+a3X8QL+
 aP8/j0epv0Au/rDEa+kRWqp/qTvM9Imj79U3ju+a+S98FSNACuMpiXCqOd+iWqT6sdLW
 SIvQaXpw0kfqb0xvZFH90UA5ozmYtTYjbhHdtiW4CbWmQDdZYBlDuBs9w3Ip0Nyaq9uw
 nprTkLk1Ph69ECpPuD3P/kv0Rry5Ra3dmqODOOrOtylrftXzSOvrHuxElHA/mNYYrvE4
 VLGU0J4yAXzmVNsmRN/qZyiqrYHTFf3O/PVBWTrqezO5fn1/Pyd2VQn2qWxV7RB8CfnA
 UN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523503; x=1690115503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxtNiq+I2c3YFpGyQ+IkSBdS2EDpw32G/XAY9b0bkas=;
 b=RUiiyCUCBf5pDv7HwH+mCTg0jFA/fcbB1Hs7655XRVoQCmUAb8zZQLqDP/0AqTnT2A
 VzCauXO+dmW6R7yxTy9VmeVe5C+7OnnJLgT1w7yficPC472n0mJRZANCWFlSXjK4T99x
 V8PWXzBsIiLMgY8u63Qwd0MsJ5sMYwao0nqLOY6ZgrT140YGR7QTVnhmZY7bYnewLU9v
 JIt+WiNpYoYH8Gzl19ELRw21TDERPZPzoo7/oe+tlad0RTrDnZPsmAHRa4gyylG3lnVe
 xyDe78UfrzditVUbmJuHFgL+mHso6srY56YFoKvmF6tY5tnt5CBCfHp8fHvABViNbbLi
 JI9A==
X-Gm-Message-State: AC+VfDzZrJKmq0U7gawg6sT4wPeHprc6fWTNLBYHzh2MI+1diLrVMFBd
 b5WI14xMSnkF7e3zIE6TsOxEa3jswvvc9sdKWSo=
X-Google-Smtp-Source: ACHHUZ4q5w5KZ4+NY2DPzi3XjXh62edPS8DVBv1mUFkIsov+ooKBpkxWuOuRPVeIl7iDBIcJt9oMBg==
X-Received: by 2002:a7b:cbd3:0:b0:3f9:b3ec:35d0 with SMTP id
 n19-20020a7bcbd3000000b003f9b3ec35d0mr8793216wmi.10.1687523503161; 
 Fri, 23 Jun 2023 05:31:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] target/arm: Handle Block and Page bits for security space
Date: Fri, 23 Jun 2023 13:31:21 +0100
Message-Id: <20230623123135.1788191-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

With Realm security state, bit 55 of a block or page descriptor during
the stage2 walk becomes the NS bit; during the stage1 walk the bit 5
NS bit is RES0.  With Root security state, bit 11 of the block or page
descriptor during the stage1 walk becomes the NSE bit.

Rather than collecting an NS bit and applying it later, compute the
output pa space from the input pa space and unconditionally assign.
This means that we no longer need to adjust the output space earlier
for the NSTable bit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 89 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ea0ad56f13e..bbae432861f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -990,12 +990,14 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
  * @mmu_idx: MMU index indicating required translation regime
  * @is_aa64: TRUE if AArch64
  * @ap:      The 2-bit simple AP (AP[2:1])
- * @ns:      NS (non-secure) bit
  * @xn:      XN (execute-never) bit
  * @pxn:     PXN (privileged execute-never) bit
+ * @in_pa:   The original input pa space
+ * @out_pa:  The output pa space, modified by NSTable, NS, and NSE
  */
 static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
-                      int ap, int ns, int xn, int pxn)
+                      int ap, int xn, int pxn,
+                      ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
     bool is_user = regime_is_user(env, mmu_idx);
@@ -1028,7 +1030,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         }
     }
 
-    if (ns && arm_is_secure(env) && (env->cp15.scr_el3 & SCR_SIF)) {
+    if (out_pa == ARMSS_NonSecure && in_pa == ARMSS_Secure &&
+        (env->cp15.scr_el3 & SCR_SIF)) {
         return prot_rw;
     }
 
@@ -1285,11 +1288,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap, ns, xn, pxn;
+    int ap, xn, pxn;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
+    ARMSecuritySpace out_space;
 
     /* TODO: This code does not support shareability levels. */
     if (aarch64) {
@@ -1592,15 +1596,75 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     }
 
     ap = extract32(attrs, 6, 2);
+    out_space = ptw->in_space;
     if (regime_is_stage2(mmu_idx)) {
-        ns = mmu_idx == ARMMMUIdx_Stage2;
+        /*
+         * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
+         * The bit remains ignored for other security states.
+         */
+        if (out_space == ARMSS_Realm && extract64(attrs, 55, 1)) {
+            out_space = ARMSS_NonSecure;
+        }
         xn = extract64(attrs, 53, 2);
         result->f.prot = get_S2prot(env, ap, xn, s1_is_el0);
     } else {
-        ns = extract32(attrs, 5, 1);
+        int nse, ns = extract32(attrs, 5, 1);
+        switch (out_space) {
+        case ARMSS_Root:
+            /*
+             * R_GVZML: Bit 11 becomes the NSE field in the EL3 regime.
+             * R_XTYPW: NSE and NS together select the output pa space.
+             */
+            nse = extract32(attrs, 11, 1);
+            out_space = (nse << 1) | ns;
+            if (out_space == ARMSS_Secure &&
+                !cpu_isar_feature(aa64_sel2, cpu)) {
+                out_space = ARMSS_NonSecure;
+            }
+            break;
+        case ARMSS_Secure:
+            if (ns) {
+                out_space = ARMSS_NonSecure;
+            }
+            break;
+        case ARMSS_Realm:
+            switch (mmu_idx) {
+            case ARMMMUIdx_Stage1_E0:
+            case ARMMMUIdx_Stage1_E1:
+            case ARMMMUIdx_Stage1_E1_PAN:
+                /* I_CZPRF: For Realm EL1&0 stage1, NS bit is RES0. */
+                break;
+            case ARMMMUIdx_E2:
+            case ARMMMUIdx_E20_0:
+            case ARMMMUIdx_E20_2:
+            case ARMMMUIdx_E20_2_PAN:
+                /*
+                 * R_LYKFZ, R_WGRZN: For Realm EL2 and EL2&1,
+                 * NS changes the output to non-secure space.
+                 */
+                if (ns) {
+                    out_space = ARMSS_NonSecure;
+                }
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+        case ARMSS_NonSecure:
+            /* R_QRMFF: For NonSecure state, the NS bit is RES0. */
+            break;
+        default:
+            g_assert_not_reached();
+        }
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
-        result->f.prot = get_S1prot(env, mmu_idx, aarch64, ap, ns, xn, pxn);
+
+        /*
+         * Note that we modified ptw->in_space earlier for NSTable, but
+         * result->f.attrs retains a copy of the original security space.
+         */
+        result->f.prot = get_S1prot(env, mmu_idx, aarch64, ap, xn, pxn,
+                                    result->f.attrs.space, out_space);
     }
 
     if (!(result->f.prot & (1 << access_type))) {
@@ -1627,15 +1691,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (ns) {
-        /*
-         * The NS bit will (as required by the architecture) have no effect if
-         * the CPU doesn't support TZ or this is a non-secure translation
-         * regime, because the attribute will already be non-secure.
-         */
-        result->f.attrs.secure = false;
-        result->f.attrs.space = ARMSS_NonSecure;
-    }
+    result->f.attrs.space = out_space;
+    result->f.attrs.secure = arm_space_is_secure(out_space);
 
     if (regime_is_stage2(mmu_idx)) {
         result->cacheattrs.is_s2_format = true;
-- 
2.34.1


