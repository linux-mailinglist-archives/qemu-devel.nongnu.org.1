Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E067383A3
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo8-0006mh-J4; Wed, 21 Jun 2023 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnv-0006eF-Ow
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:21 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnt-0000Lz-1y
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:19 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso6151790a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349953; x=1689941953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1z7ZijI3noWzsrc+wKPRkU7wte4eSKNmnXzrL2G2aM=;
 b=lBMODMeTg+hkkn1GjjmH97sp2IKxM4gKQuMkdF6Ats712MlbtTnZeHgMaBjBHmD1CJ
 3qRhjx4HgX4I3e/PTBCNGDjquVryQxbaSpSn4f4wb+nGTyZ94qltqv20rXS3v/Iuu6ro
 X/uxEca+FMStJYQwqO4lNOd9k5U930zX5U4BcsWiDHy87tFMKIrmSUPuVx/k+YNhoDbF
 0AlYwjNBvn2U9Q0aXCxbHIcP8qUHuyEbxyjEX0jXr/E9jUgpNRpTqV3ue9w3rD0vcz7M
 3QqAL8VxZNvyEBQFrSpoOKFv75Q1nJtl0B7F7uHWXQQW7jFKSqYe6clunBzHQFDhMK8k
 1xZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349953; x=1689941953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1z7ZijI3noWzsrc+wKPRkU7wte4eSKNmnXzrL2G2aM=;
 b=EE3YltcYJ+FXYSjQWIPY1xNQzIvSKylaycD77P7Ie4DpaT0e6gYFp55qWSu/RkVjO5
 xcqffbU7RA0zPhfviJhuhZYiwRehTRBtVEHGaLNj9gVSt6IBl9CFzbJ3R8VVDMSWxJfx
 LjHc9s+hgJ8Uf31TF0rWThEbyDiHsRDObkpOEoovAqWtZojIkBwrpW4wAPuAP+jy02QG
 +Mp69PCXM19Q83rXQp6Y0F3P/V7mtZ5wGqE6WeCFyH3Dzf49zE/jiVvZ+STZabPcnVtg
 5QnPwTVEvb5Oc+o7bQfST6I+96gItEWrPArLeOcLXD+y1t10uRFtv5W6n75Mbdu7duKD
 TzgQ==
X-Gm-Message-State: AC+VfDxA/QGXMMcC6WFyJnonmDLDflkR0XMbHa/S7D0S5O/lvhDxBZni
 TfJ4DDzY+BWz2p2uS58y3iuO4G79jcix8L8/cUJn9I3W
X-Google-Smtp-Source: ACHHUZ4fGhD66VDZIm4GR4CthH6WkQjodUZDM+Ad4pYP5LcRTqVozPPKESriUB9ydNO7uKQZ8YF6vg==
X-Received: by 2002:aa7:d78d:0:b0:51a:4557:2caf with SMTP id
 s13-20020aa7d78d000000b0051a45572cafmr6666542edq.34.1687349953386; 
 Wed, 21 Jun 2023 05:19:13 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 9/9] target/arm: Do memory type alignment check when
 translation enabled
Date: Wed, 21 Jun 2023 14:19:02 +0200
Message-Id: <20230621121902.1392277-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52f.google.com
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

If translation is enabled, and the PTE memory type is Device,
enable checking alignment via TLB_CHECK_ALIGNMENT.  While the
check is done later than it should be per the ARM, it's better
than not performing the check at all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 37bcb17a9e..8dcd5d80ce 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -227,6 +227,16 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
 }
 
+static bool S1_attrs_are_device(uint8_t attrs)
+{
+    /*
+     * This slightly under-decodes the MAIR_ELx field:
+     * 0b0000dd01 is Device with FEAT_XS, otherwise UNPREDICTABLE;
+     * 0b0000dd1x is UNPREDICTABLE.
+     */
+    return (attrs & 0xf0) == 0;
+}
+
 static bool S2_attrs_are_device(uint64_t hcr, uint8_t attrs)
 {
     /*
@@ -1274,6 +1284,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     bool aarch64 = arm_el_is_aa64(env, el);
     uint64_t descriptor, new_descriptor;
     bool nstable;
+    bool device;
 
     /* TODO: This code does not support shareability levels. */
     if (aarch64) {
@@ -1623,6 +1634,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     if (regime_is_stage2(mmu_idx)) {
         result->cacheattrs.is_s2_format = true;
         result->cacheattrs.attrs = extract32(attrs, 2, 4);
+        device = S2_attrs_are_device(arm_hcr_el2_eff_secstate(env, is_secure),
+                                     result->cacheattrs.attrs);
     } else {
         /* Index into MAIR registers for cache attributes */
         uint8_t attrindx = extract32(attrs, 2, 3);
@@ -1635,6 +1648,21 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         if (aarch64 && cpu_isar_feature(aa64_bti, cpu)) {
             result->f.guarded = extract64(attrs, 50, 1); /* GP */
         }
+        device = S1_attrs_are_device(result->cacheattrs.attrs);
+    }
+
+    /*
+     * Enable alignment checks on Device memory.
+     *
+     * Per R_XCHFJ, this check is mis-ordered, in that this alignment check
+     * should have priority 30, while the permission check should be next at
+     * priority 31 and stage2 translation faults come after that.
+     * Due to the way the TCG softmmu TLB operates, we will have implicitly
+     * done the permission check and the stage2 lookup in finding the TLB
+     * entry, so the alignment check cannot be done sooner.
+     */
+    if (device) {
+        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
     }
 
     /*
-- 
2.34.1


