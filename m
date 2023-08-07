Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C75772764
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12m-0003Hp-Fl; Mon, 07 Aug 2023 10:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT118-0000B1-VM
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005UB-EN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe5695b180so12752105e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417722; x=1692022522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fPUvCziy6lhHDDMmfmybg6TLiyhiL/Fc4MTynATEnX0=;
 b=QgO+KSNtbuHjCyUPFYGSDYE1ttW8+KPbQbVYx50RkeUQbxt+voN9VYEBOOWfy/44Cm
 NE+W1vzKeDPpIjQuFbb6NzkO+zYTJYAOyuIbl5YsUY4lWvbt6ZU+l8dWn4PiY41auOp1
 PCkdeFfN5Y63jwF6cqcXm7q1+whrc1F//x0TyUi8qdo+Fe/gYomak701z7Jh30OMjqip
 vLYibZhN5rKhtWZkLaaGxsVpChO7Vrt8Zy8xLefAPC3rNxNQx+tlYCgmsqI5lQ70jlEF
 mEjiCwxAsh/qfN1xBD6wNdDP4WIlxg1hTkran9Bld/GmpkQK5ru00Uc17i3g79UvIxPa
 v4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417722; x=1692022522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPUvCziy6lhHDDMmfmybg6TLiyhiL/Fc4MTynATEnX0=;
 b=fipN4iesILJDheedklymzzGukn7HiB58lj1MYScGRD+sLBV+o+XMj2FcsTDGjRsARr
 /QA1GfORUUxhicEnwLfEMt+ZtewjXpDI9HCxjdPyDcdaVjgEA6zl+W7RUyz5UymsdbWb
 ++0vRZNTRr6UINyuKSh4iA1hhhHGAhexknzoebrst9dM2e/R/ifUKWHsLZ8z3Zkl1vWW
 13UKPymChgnVsrZ0yyU+7TPOWdAE+hlGDVPdlxtM024w00jPBl8jn9AeQhXmNpsNAXWt
 n/XdJ/WX+3dt+cz6TeActMA4aDl9XlJTFLlE2UY3MJBs/6v7PGG7TsKbzqe0ufQ4Dra1
 T4Xw==
X-Gm-Message-State: AOJu0YydiaCx79lGu5UcoU5OKWh6gl9qYsGZUrHSu+2+F1AnkJvRzpSu
 xqYf9int8C9KSXObWU6qG6cheQ==
X-Google-Smtp-Source: AGHT+IF1dAVR+56XiaPYG+wSwSmtQt0hvxje3msMTuFrO9c+wb/cCBZFif1ea3AuRUK71iJkiIVrhg==
X-Received: by 2002:a7b:c453:0:b0:3f8:fc2a:c7eb with SMTP id
 l19-20020a7bc453000000b003f8fc2ac7ebmr5779539wmi.5.1691417721878; 
 Mon, 07 Aug 2023 07:15:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 10/15] target/arm/ptw: Remove S1Translate::in_secure
Date: Mon,  7 Aug 2023 15:15:09 +0100
Message-Id: <20230807141514.19075-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1ca25438c3c..78bc679deef 100644
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
@@ -547,7 +540,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
-            .in_secure = arm_space_is_secure(s2_space),
             .in_space = s2_space,
             .in_debug = true,
         };
@@ -1784,7 +1776,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
         ptw->in_ptw_idx += 1;
-        ptw->in_secure = false;
         ptw->in_space = ARMSS_NonSecure;
     }
 
@@ -3167,7 +3158,6 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
     ptw->in_s1_is_el0 = ptw->in_mmu_idx == ARMMMUIdx_Stage1_E0;
     ptw->in_mmu_idx = ipa_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
-    ptw->in_secure = ipa_secure;
     ptw->in_space = ipa_space;
     ptw->in_ptw_idx = ptw_idx_for_stage_2(env, ptw->in_mmu_idx);
 
@@ -3403,7 +3393,6 @@ bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
-        .in_secure = is_secure,
         .in_space = arm_secure_to_space(is_secure),
     };
     return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
@@ -3475,7 +3464,6 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
     }
 
     ptw.in_space = ss;
-    ptw.in_secure = arm_space_is_secure(ss);
     return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
 }
 
@@ -3489,7 +3477,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = ss,
-        .in_secure = arm_space_is_secure(ss),
         .in_debug = true,
     };
     GetPhysAddrResult res = {};
-- 
2.34.1


