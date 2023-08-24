Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B73786BD4
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ec-0006ui-FZ; Thu, 24 Aug 2023 05:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00047u-Nw
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-00050c-Dc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso3589459f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869327; x=1693474127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=skc8U+gA9LdRonLIVM9I21EP6Eo0baS5zBeu/So/Jqk=;
 b=ws4YU8z9Gw/SMOoc17b7bM+UoQmxi2TNckfOUIVJNs0UtCdpKjXD0TbDzsoOVNNHhu
 AJUNY71NER2ifcTsBUnpJZWUsJoo+P1CAC1Wl1pDLCufjWGGZlu7FCZPEAovigufCx6o
 Bhvw1Ga5yOJsDBaBF10XmqoG+1SwU6fPBC7346j8fw8QjRBIWokJEjMuOv9goEJ6iOHF
 z9UwXMlvXi9V7JBZ6J7NXzdnH6LkPWCWndrY+XTApjeeTyU1zD6kYJzjHOSpBzcuWSSw
 RPobQDF/I2uJbzw8NANCpfkpnYx2C9v10Qpy5LqpydX+l95CmgAfTm+hZbUyEZVoOzu5
 Hhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869327; x=1693474127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skc8U+gA9LdRonLIVM9I21EP6Eo0baS5zBeu/So/Jqk=;
 b=B19YEwNLms+GcNMzFHv6tNBhopXKiChef9inHp/UeS4vrNRCdXyrRySzFgNrcSAUN9
 o6m9bsDMBpzzjADKxpFni6MeHwi6G1AoBbuUH6N88JjE94NYsA9JdJO3gOdyU89dcDxh
 /MBIQ0ey5dLHlFCfgB6MJhywRTVgmVSDt7FEXOlQGrhRJv06V6PgG1X8/9Y3l5NRzo2K
 UHh26koSjbvIoJ18VotUxD0baxye6j3dp8OGW8+X6RkkiS6l2p8MRhNWOsqihBxZLVFQ
 Ke3TEfiKa8EnIkJT+Izc6fKcRIdy27ld9dHGJ6uSy/+OYNew1bw24+VlJSy4J+EDPrrc
 ETZA==
X-Gm-Message-State: AOJu0YxFjqpMUlRoqJs4+zOgsuWubD4BY0jBBkmsyPZgnv1LWGWWV8+T
 lKH9Zis5N9Gmpi2lQCaWDetMVBJJ0fH5vbb4U3o=
X-Google-Smtp-Source: AGHT+IGyiHXIqEq3oak3f2/wc7UILQFA/T5pw9zyFR++Mfw/gZbQyhza0nE7yc2w9BrOi/6pkznVRw==
X-Received: by 2002:a5d:45c6:0:b0:319:854a:9ea1 with SMTP id
 b6-20020a5d45c6000000b00319854a9ea1mr10702410wrs.15.1692869327481; 
 Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/35] target/arm: Pass an ARMSecuritySpace to
 arm_is_el2_enabled_secstate()
Date: Thu, 24 Aug 2023 10:28:20 +0100
Message-Id: <20230824092836.2239644-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Pass an ARMSecuritySpace instead of a bool secure to
arm_is_el2_enabled_secstate(). This doesn't change behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-8-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 13 ++++++++-----
 target/arm/helper.c |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bcd65a63ca0..02bc8f0e8e0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2504,17 +2504,19 @@ static inline bool arm_is_secure(CPUARMState *env)
 
 /*
  * Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
- * This corresponds to the pseudocode EL2Enabled()
+ * This corresponds to the pseudocode EL2Enabled().
  */
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env, bool secure)
+static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+                                               ARMSecuritySpace space)
 {
+    assert(space != ARMSS_Root);
     return arm_feature(env, ARM_FEATURE_EL2)
-           && (!secure || (env->cp15.scr_el3 & SCR_EEL2));
+           && (space != ARMSS_Secure || (env->cp15.scr_el3 & SCR_EEL2));
 }
 
 static inline bool arm_is_el2_enabled(CPUARMState *env)
 {
-    return arm_is_el2_enabled_secstate(env, arm_is_secure_below_el3(env));
+    return arm_is_el2_enabled_secstate(env, arm_security_space_below_el3(env));
 }
 
 #else
@@ -2538,7 +2540,8 @@ static inline bool arm_is_secure(CPUARMState *env)
     return false;
 }
 
-static inline bool arm_is_el2_enabled_secstate(CPUARMState *env, bool secure)
+static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
+                                               ARMSecuritySpace space)
 {
     return false;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9862bc73b52..8290ca0aaad 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5778,7 +5778,7 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
 
     assert(space != ARMSS_Root);
 
-    if (!arm_is_el2_enabled_secstate(env, arm_space_is_secure(space))) {
+    if (!arm_is_el2_enabled_secstate(env, space)) {
         /*
          * "This register has no effect if EL2 is not enabled in the
          * current Security state".  This is ARMv8.4-SecEL2 speak for
-- 
2.34.1


