Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8015786C0E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ez-0000gp-FV; Thu, 24 Aug 2023 05:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006J2-0D
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00050x-Gd
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so13595155e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869328; x=1693474128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PcqjEcLAFKPxq5704Gj2dDNs6SkxXicqwmg10sRrS5w=;
 b=W7KikZRPIKvTE86rd6Xt6PmD4KsDFsnXKY1qFAzB8r2E8qHo/YK6+ZUMJTEqOnlOCj
 qYGAA/5tOaw1rQMR5zmmdYClcbqU0JN4/yXxDh/95f/gq3WW2ihMw7/KmqR5FIbb7uqX
 yh/cggJ4V6ef4EwtMX1x67CNlyLGXfrdVdIwjt9gF/Q1MnMP1GxMFXRcfWDyrnlcz/TP
 VyvnLJzBA0oXlitWyqT3CG67JTjLMtd0FL92oP/EtAyIhypTgOLf2UAyp1biwKED9/vD
 CplmF571RoD3yBXZEZEFXwVoIw0DMQeYBsWZTbiNKtmHtrGKm/Wm8cWdjAbyTLRJqdkI
 qdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869328; x=1693474128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PcqjEcLAFKPxq5704Gj2dDNs6SkxXicqwmg10sRrS5w=;
 b=Qw/gc2OSYw2lli62MGBPrp4nMWwjlqlQs053JSFCorIQPQx2AcOZOdaX1lWladeMZF
 NNTA+hJPVU5khNKoyhwR/16dd/gueGWCk8LeKcc73g1i0Bn0c+hu7QbPGJ+yu4T7Ao8K
 7NTt0Pn5R3c6ZBUrTzpPoz4XSWx+oe9NAukjoc8/F4ES3iZGL6u65XdCLaDaI5ZZwRdM
 Mk0aEOh31cpsnSdLqTaiRKxxVfjj7fmyxPRuDU9Jdj++v5ccbs0fyl5khP1V4xgvlz44
 S2v0fOkfJNuEg/5uUTMnofeAwMcYIshOihyzrArn/oK9NapPpexdw61yIVIFByg9KdZQ
 /L7Q==
X-Gm-Message-State: AOJu0Yw9zML1j1NujPxV4JrNoi8GYglXiX8SXS/93umAtEg0bdYnCJY8
 l/jdEslsEuY7Nw2Gfonw1Zi3onElHj9/soArKEA=
X-Google-Smtp-Source: AGHT+IElSaA36lLKVFPkzJl3SDfuxvbZc4LjAJmAZtoPmoDSSXvFlysq0+L5LFLqnsMtwMY3BXfXKA==
X-Received: by 2002:a7b:c4c9:0:b0:3fe:2b8c:9f0b with SMTP id
 g9-20020a7bc4c9000000b003fe2b8c9f0bmr11077207wmk.23.1692869328330; 
 Thu, 24 Aug 2023 02:28:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/35] target/arm/ptw: Remove last uses of ptw->in_secure
Date: Thu, 24 Aug 2023 10:28:22 +0100
Message-Id: <20230824092836.2239644-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace the last uses of ptw->in_secure with appropriate
checks on ptw->in_space.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-10-peter.maydell@linaro.org
---
 target/arm/ptw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6e736bacd77..1ca25438c3c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3249,7 +3249,6 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       ARMMMUFaultInfo *fi)
 {
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_secure = ptw->in_secure;
     ARMMMUIdx s1_mmu_idx;
 
     /*
@@ -3257,8 +3256,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      * cannot upgrade a NonSecure translation regime's attributes
      * to Secure or Realm.
      */
-    result->f.attrs.secure = is_secure;
     result->f.attrs.space = ptw->in_space;
+    result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
@@ -3272,8 +3271,12 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
-        /* First stage lookup uses second stage for ptw. */
-        ptw->in_ptw_idx = is_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
+        /*
+         * First stage lookup uses second stage for ptw; only
+         * Secure has both S and NS IPA and starts with Stage2_S.
+         */
+        ptw->in_ptw_idx = (ptw->in_space == ARMSS_Secure) ?
+            ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
         break;
 
     case ARMMMUIdx_Stage2:
-- 
2.34.1


