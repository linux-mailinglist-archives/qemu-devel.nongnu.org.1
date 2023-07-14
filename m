Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A9753F4D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0Z-0007HI-CW; Fri, 14 Jul 2023 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0X-0007Fo-NL
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0S-00076R-Oz
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so2160674f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349615; x=1691941615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TpDMhnEcDgkB2wr6VipjcrDus/OWGCdiCk/KPC7Pdx8=;
 b=CdX1X31WuehvMrswDZALW7oK2gXLHuROxtrFGLV+VPn4gHVrDf4duKwqQ/qjctDad+
 EzJzTsUfu8jBMLln4gqu7WJ/hAFW9wJIQR0VTlu44PpLN7SkrtZQ6iHB0m8ONi20TRgS
 Xfs3SVEQPefcYVJEPS5aquR5O6a4VRbYZW1rcgUCbenZT5wmYOmAr3MHLLOx2E5MoNbd
 S4jHpLrgeKk2PGZUu/F4RYPrcUvZNYCKdcdjQqaLG7KFcrJvHaiPWPZ6R3dPdx4mgPy6
 42naTXp55YTPC291jhxhpAU1Iyg8tOve/BSLOD/kgc7BRTOQOg6EaKmUzlo9vbiXDa3q
 Nb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349615; x=1691941615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpDMhnEcDgkB2wr6VipjcrDus/OWGCdiCk/KPC7Pdx8=;
 b=YQtk+cuCDLsgxgis0tS7P8WJRySz4iwuKex2CPkus77SRl6XUIpUTeDs/p4RGwOMNv
 8V4ULNUzQypoawZZ3NYo9V/Ad30rf0grjBqY1bMdtPI2ZCSCEWmhnkdO5sgOIq/uvo7z
 7/twaBx+2fS/teev63rFTMoF2As9jqu6QOiCRSI5G4Dp3tlJv9RWPXGTncf4uR6l6jaU
 aQxFki5beVD/eD6QjF+Ccx8QWnYxcvpxENEbUcRJubmkgdm9dLM96b8q2LssR4yrpFrR
 QRXuVCRsDCrr6HmDk+kUAukW7WHbNYPUf2HjB0Qt5dItZFfD9IAfp8ARh7Nt242uXOUV
 8Q9w==
X-Gm-Message-State: ABy/qLZYz5TIPrtHcK44Um1zfYDyUc2TZB+XCfaGrqwmM70mfvMPLniq
 TZwoR9p5BEn03m664kaJvwshUZqusXbHZpRqya0=
X-Google-Smtp-Source: APBJJlFGbDFnFvfh0Qz4sIrdqWDqP0UDZ0gVHQMsO8a+iJ5dg4nomBa69i4unonfdvuPvm9HK8qF6A==
X-Received: by 2002:a05:6000:1a42:b0:30d:d85c:4472 with SMTP id
 t2-20020a0560001a4200b0030dd85c4472mr4044652wry.62.1689349615168; 
 Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/14] target/arm/ptw: Remove S1Translate::in_secure
Date: Fri, 14 Jul 2023 16:46:43 +0100
Message-Id: <20230714154648.327466-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We no longer look at the in_secure field of the S1Translate struct
anyway, so we can remove it and all the code which sets it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bc834675fb2..77b8382ceff 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -51,13 +51,6 @@ typedef struct S1Translate {
      *    value being Stage2 vs Stage2_S distinguishes those.
      */
     ARMSecuritySpace in_space;
-    /*
-     * in_secure: whether the translation regime is a Secure one.
-     * This is always equal to arm_space_is_secure(in_space).
-     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
-     * this field is updated accordingly.
-     */
-    bool in_secure;
     /*
      * in_debug: is this a QEMU debug access (gdbstub, etc)? Debug
      * accesses will not update the guest page table access flags
@@ -545,7 +538,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
-            .in_secure = arm_space_is_secure(s2_space),
             .in_space = s2_space,
             .in_debug = true,
         };
@@ -1782,7 +1774,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
         ptw->in_ptw_idx += 1;
-        ptw->in_secure = false;
         ptw->in_space = ARMSS_NonSecure;
     }
 
@@ -3165,7 +3156,6 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
     ptw->in_s1_is_el0 = ptw->in_mmu_idx == ARMMMUIdx_Stage1_E0;
     ptw->in_mmu_idx = ipa_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
-    ptw->in_secure = ipa_secure;
     ptw->in_space = ipa_space;
     ptw->in_ptw_idx = ptw_idx_for_stage_2(env, ptw->in_mmu_idx);
 
@@ -3401,7 +3391,6 @@ bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_secure = is_secure,
         .in_space = arm_secure_to_space(is_secure),
     };
     return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
@@ -3473,7 +3462,6 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 
     ptw.in_space = ss;
-    ptw.in_secure = arm_space_is_secure(ss);
     return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
 }
 
@@ -3487,7 +3475,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = ss,
-        .in_secure = arm_space_is_secure(ss),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
-- 
2.34.1


