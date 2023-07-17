Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB0756354
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNhp-00031w-TW; Mon, 17 Jul 2023 08:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdu-0008Tn-Ga
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:48:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdn-0008TO-Tf
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so4228516f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uo7Bz898x5rT9AwvwOzRLp/mDtj2e+zf8fXMK+RWos4=;
 b=GYUsfFKR9xT2o6l43WZ+dZODQn7mm/uHx8nxfV0ktVv2Aw76+qDzPhPUAOa8M8+x3q
 pvGOGWHzU3y3EBghgd3O+Qk1vw4JPuxvnis3mF0LLunw4PzaXaD+QboYvYG6QLHSyz+N
 D/DB7yXf4PQvnVbIjCydFzdL5hi6045zux4I19i1z8n+gVMPx/YmkH1waOar/PMZriHp
 531ec87mzNIcTuuUviLokzrTgsH0HArybNwr/tfSQ3oMwUTNrXjcTrMnGe9tgODLelcl
 n3VRvPjzK0e32bBjzHf2H48LRQAWVOzGQYwPpKjJ6/k3O8ex9zy3pFiprfb2NfxQrTZH
 bgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598070; x=1692190070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uo7Bz898x5rT9AwvwOzRLp/mDtj2e+zf8fXMK+RWos4=;
 b=W43XiSl8CEm/qQbzhtbPidhqeUMzlujUfwKs7O+WmVD6wtKozfpL50LD7+fn279A0r
 KuN9NEz6g6Ov1YeYYG2yXKQabt+jxXZ8CpUJUwyPlN2VKK8/6Z1EEv/latVlHgcK9gwh
 cOPc/e/z1ozmEodI8vmkrcH6LfKjNWp8oUlkdgNXzYH3QbncWGuvVaO7AlaBntQF8c9z
 /SxQUyxDmFOewMfwov9NuDzBV/4rICq240BW/1LAHG0zSFDanBBTB7zs6SVbePz6nVph
 zw15TCYWFIte/16bJ58DpmuR0AfJ1gfBjt7Tyd/FSfMPmhIc0Ib3hYwa3HHsMHAuuajp
 TNVg==
X-Gm-Message-State: ABy/qLYC7AzPRrpos0zPSc20FBZcyCDFAlRf6gN5VDqWvLXPVlW4bIEX
 S6R/vh0FVimaZvYcvZcIGif6TEcFDXdyo+1EM/A=
X-Google-Smtp-Source: APBJJlFbeKs33+ZHyvIZSW1ie8luuQoBNXAM1/RvegoEDH6Pdi686wLzUMkF8ulJVnjz6cJI2e202g==
X-Received: by 2002:a5d:4c41:0:b0:316:d887:624a with SMTP id
 n1-20020a5d4c41000000b00316d887624amr9872600wrt.15.1689598070052; 
 Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] target/arm/ptw.c: Account for FEAT_RME when applying {N}SW, SA bits
Date: Mon, 17 Jul 2023 13:47:44 +0100
Message-Id: <20230717124746.759085-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

In get_phys_addr_twostage() the code that applies the effects of
VSTCR.{SA,SW} and VTCR.{NSA,NSW} only updates result->f.attrs.secure.
Now we also have f.attrs.space for FEAT_RME, we need to keep the two
in sync.

These bits only have an effect for Secure space translations, not
for Root, so use the input in_space field to determine whether to
apply them rather than the input is_secure. This doesn't actually
make a difference because Root translations are never two-stage,
but it's a little clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230710152130.3928330-4-peter.maydell@linaro.org
---
 target/arm/ptw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c0b9cee5843..8f94100c61f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3118,6 +3118,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     hwaddr ipa;
     int s1_prot, s1_lgpgsz;
     bool is_secure = ptw->in_secure;
+    ARMSecuritySpace in_space = ptw->in_space;
     bool ret, ipa_secure;
     ARMCacheAttrs cacheattrs1;
     ARMSecuritySpace ipa_space;
@@ -3200,11 +3201,13 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      * Check if IPA translates to secure or non-secure PA space.
      * Note that VSTCR overrides VTCR and {N}SW overrides {N}SA.
      */
-    result->f.attrs.secure =
-        (is_secure
-         && !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
-         && (ipa_secure
-             || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW))));
+    if (in_space == ARMSS_Secure) {
+        result->f.attrs.secure =
+            !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
+            && (ipa_secure
+                || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW)));
+        result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
+    }
 
     return false;
 }
-- 
2.34.1


