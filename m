Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB120736C2F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:46:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiw-0001dg-4I; Tue, 20 Jun 2023 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBais-0001ar-IS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:38 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaip-0001zw-PA
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:38 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b470330145so39309591fa.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265072; x=1689857072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7nEO8a+eNnzXCBeEFSRpz3ImKrw9b1VGkr4avGc3a4=;
 b=SRihU2uAkzw0YirSFTyAp6lcyfylQw2F5+lN1rDhIN5kAO/dBDH17lPdnk1LIdKCc7
 3TB0rCdpFRQOcrbx1et3ORlsVElnyJAg+bJl+ainSx57sCdLykj7iaVPTVUEL8f6JCyT
 zbopTJEB+q7sGRfithUHUBUmkpUuhNy5oJhSU+wsrzugcC1CUxmCOsacRiIHpQHJYujQ
 iE059JagO8kr3mB8DP8a7OgUiNySAlMUNYMhCrcnWKGhrtSaufKffLjfrED3S9vlwI1m
 g8RREXU8lzroV9HWamZpCifg8oseMpO/u+USuX868oXOXZ08tI6WGcMS6XhQgjWTeZVC
 RZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265072; x=1689857072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7nEO8a+eNnzXCBeEFSRpz3ImKrw9b1VGkr4avGc3a4=;
 b=K6DGh/ZV6/ymE3F9XL9UTh243NJVilLIlh+5JgjbHKCVHYq2EcWn/gf4T0akxbTMFp
 0UZiJd7N5nb5hRHqLm+uzsx7bRXPubWCXMWGwLSsgGzj+GODGHR9X9CjC1pL6gJGZwbx
 LmJWEgHfRYTOCLVCuKm3TZPjRMetgKo92aR53Fs78uT33TcDCGB0VmjZPuSgIubf7gfJ
 oYYKF2I63B6bFLqQgXMnbuxRR+2n2U00oJiTfSImSke4Fmev1y5yKoYOpncZx6dpoh8h
 oJyGIbplgRFu3S46bC0IZPfIw9mRyLjeb5vZ+6f3EqHmp/ZAVaLIzFU2fm4C7H3UXwkh
 iTHA==
X-Gm-Message-State: AC+VfDx4Xn2u3sAW/TDChDnKqgkMov2q8K7N4U3LIFgWoivNplAekhBV
 UyiKDoiwvt5Tt1OHFF15bPkbt2X3sBGNOh7P1OmZyK2j
X-Google-Smtp-Source: ACHHUZ5wjRvVxXuY63LGEXkjkZ0SDLGftgiqsLzkT94zAXkheYUBvDFdpjKj6kIqBc9ZabesKxQdFQ==
X-Received: by 2002:a2e:9b08:0:b0:2b1:be84:5496 with SMTP id
 u8-20020a2e9b08000000b002b1be845496mr8004776lji.12.1687265072452; 
 Tue, 20 Jun 2023 05:44:32 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 12/20] target/arm: Handle Block and Page bits for security
 space
Date: Tue, 20 Jun 2023 14:44:10 +0200
Message-Id: <20230620124418.805717-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x233.google.com
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
---
 target/arm/ptw.c | 89 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ea0ad56f13..bbae432861 100644
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


