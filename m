Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89267736C36
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:47:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBait-0001aI-Qb; Tue, 20 Jun 2023 08:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiq-0001Yk-NR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:36 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaio-00021W-Or
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:36 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a2c60c529so5723432a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265073; x=1689857073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3vaNoeWOKh3oA6oL5GGZU6lEHzFz6aNnkyZ0kOs9Ug=;
 b=vpa1OMsK3fdWKMiOcyrkmbDccqzuLMaETqOmy9ddzjl0K38WMX3SmvLYYiL402qfpP
 SfIu81l1GiY67iaUdSt9fFfF32FiwqY/H/OxbMqyxjuqejV/iNtgc+tEFpz+9smyKgXO
 aiXQeYbZueQiC1uUL0AnupX09KfQqU28WDFbKEpdZOXTX4eMieXBoVwyp9AwqtCTOLKg
 AREvsPCg8e4oMXeL+9Uj43ICAhu0CPGv6EYWbEn3elIx8NkWGr81B4z1a7QuiRTX18KB
 ZRQxZRyAph16mMoT9sPYl40c8+1EQ1yAOpUJ1JFHSXldczA8LoeCJg5q5j4f6xd/DB45
 3LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265073; x=1689857073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3vaNoeWOKh3oA6oL5GGZU6lEHzFz6aNnkyZ0kOs9Ug=;
 b=jEVz291QiQfVNwyjF91mQDLcjh1ZLMV19bFhF1C+27pWTuUaXbBhgqLbruNJa96wEC
 rsuMsbxZTwMgg28iZy2B22zgX7If+zk3pUUGSO7vKKzPH+6nEkYwFR45xFJLrYCsiHBm
 mFHTTtyt+mNnLhjHDdRKw+j4CPN5e1I1Nu3YT3eL06Mf+TcDVV8GFojTIfQh+2anQJ5c
 UnklZ58cH15vx/b7X3iMALCSLxkge6y+OA63pM+L37pTGAgDFyBtKvv/QtxQJ9CqYSU8
 nF5L3IB0HGALNbVYGcXOzuS2CGT8LcZoa94YjGDAtl7coge+6e4w+hTAWL+6tGk3iW+9
 jjrQ==
X-Gm-Message-State: AC+VfDw63coasQgRIrjPQgLbKF8sqj2prIbqZVIBMM8TOWYUC6BYSvso
 lvs9DvWogdWmvm9WNV9kXl3MDbXNd9R3BI9dmN51hq4u
X-Google-Smtp-Source: ACHHUZ5wwhGofag/U8k8aZCHZ1CL3DjU5F9Za32+/FhnzkDO+dA4Bcev7gVrC6Wfedwl+Dy3viNy6Q==
X-Received: by 2002:aa7:cfc4:0:b0:518:79d7:57be with SMTP id
 r4-20020aa7cfc4000000b0051879d757bemr8092749edy.9.1687265073334; 
 Tue, 20 Jun 2023 05:44:33 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 13/20] target/arm: Handle no-execute for Realm and Root
 regimes
Date: Tue, 20 Jun 2023 14:44:11 +0200
Message-Id: <20230620124418.805717-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

While Root and Realm may read and write data from other spaces,
neither may execute from other pa spaces.

This happens for Stage1 EL3, EL2, EL2&0, and Stage2 EL1&0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 52 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bbae432861..45271d666b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -943,7 +943,7 @@ do_fault:
  * @xn:      XN (execute-never) bits
  * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
+static int get_S2prot_noexecute(int s2ap)
 {
     int prot = 0;
 
@@ -953,6 +953,12 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
     if (s2ap & 2) {
         prot |= PAGE_WRITE;
     }
+    return prot;
+}
+
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
+{
+    int prot = get_S2prot_noexecute(s2ap);
 
     if (cpu_isar_feature(any_tts2uxn, env_archcpu(env))) {
         switch (xn) {
@@ -1030,9 +1036,39 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         }
     }
 
-    if (out_pa == ARMSS_NonSecure && in_pa == ARMSS_Secure &&
-        (env->cp15.scr_el3 & SCR_SIF)) {
-        return prot_rw;
+    if (in_pa != out_pa) {
+        switch (in_pa) {
+        case ARMSS_Root:
+            /*
+             * R_ZWRVD: permission fault for insn fetched from non-Root,
+             * I_WWBFB: SIF has no effect in EL3.
+             */
+            return prot_rw;
+        case ARMSS_Realm:
+            /*
+             * R_PKTDS: permission fault for insn fetched from non-Realm,
+             * for Realm EL2 or EL2&0.  The corresponding fault for EL1&0
+             * happens during any stage2 translation.
+             */
+            switch (mmu_idx) {
+            case ARMMMUIdx_E2:
+            case ARMMMUIdx_E20_0:
+            case ARMMMUIdx_E20_2:
+            case ARMMMUIdx_E20_2_PAN:
+                return prot_rw;
+            default:
+                break;
+            }
+            break;
+        case ARMSS_Secure:
+            if (env->cp15.scr_el3 & SCR_SIF) {
+                return prot_rw;
+            }
+            break;
+        default:
+            /* Input NonSecure must have output NonSecure. */
+            g_assert_not_reached();
+        }
     }
 
     /* TODO have_wxn should be replaced with
@@ -1601,12 +1637,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /*
          * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
          * The bit remains ignored for other security states.
+         * R_YMCSL: Executing an insn fetched from non-Realm causes
+         * a stage2 permission fault.
          */
         if (out_space == ARMSS_Realm && extract64(attrs, 55, 1)) {
             out_space = ARMSS_NonSecure;
+            result->f.prot = get_S2prot_noexecute(ap);
+        } else {
+            xn = extract64(attrs, 53, 2);
+            result->f.prot = get_S2prot(env, ap, xn, s1_is_el0);
         }
-        xn = extract64(attrs, 53, 2);
-        result->f.prot = get_S2prot(env, ap, xn, s1_is_el0);
     } else {
         int nse, ns = extract32(attrs, 5, 1);
         switch (out_space) {
-- 
2.34.1


