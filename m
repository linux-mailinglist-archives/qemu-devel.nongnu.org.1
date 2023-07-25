Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6787610C6
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFFA-00010E-M9; Tue, 25 Jul 2023 06:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE7-0000Gf-BD
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOFE5-0007Vd-Bj
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:25:11 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fbaef9871cso8046729e87.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690280706; x=1690885506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LnZsXBbIrTDKV2igH/1OazM17WZlfyrZZU/qtmoKHRk=;
 b=ZvYu7mZqBJG9XkWG7bzaqOpKSXZ6lwggmnmsExjR3r3e7tOJk+7Wgi3jm30EwTW4pC
 oTbEmX5MrOU1HcnhaaBjI8YNfjVyLnZRyBiduV0UENuGXpRqgx0WBr9f+mVDMQPz1Dxj
 mYTBYkqlrs8v0wqN74F+OPUnle0XHLDQsSF3uoYQ9m4vg/CMbG9Rz6WREse1PNu4pbK6
 AoQVj7wJLv5KV5GT4yjuBN9VXP8U2ZsH7uCUhwTddC3l3QAv1HwaSzYx4wwTFZ7QijFm
 d2mva17VOoenhWDjcA3s/r74lBE5QUmbdAuzLCd5ZEHCATXKnUn5EnTTtAVPVk3kZtK1
 B+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690280706; x=1690885506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnZsXBbIrTDKV2igH/1OazM17WZlfyrZZU/qtmoKHRk=;
 b=fHIpJv/IoUDbZx3jn9Tcf3w6bRBRVb66YBBAti+uXlV86fmec3w+kZgRXTtN7aKCSt
 gkVbe/L8seQyFJSrUM5xPPKEim4KhYnWh41jatrZusMZglwF/Bf7gydhj5umYIgzxK4O
 crRpI8ytQ50sK/E9EV5Ojd2KkP9geT6hyLZOxRv/9ofrfZcwCU2idYcfCHrd4NkzKKsg
 Wet29/DAPDRQWxxtT81dOFMRTvSqSU8RsjS/OZxypLdIxYeKkLfkWzcItO180K73awWk
 oi1pxsQjQTOjdv4lfuGzSmd204K1qBrhebzyYbJoTqi8857Vd6Q1QHoiVtumIoiQvWOy
 ZXMA==
X-Gm-Message-State: ABy/qLas4U+eNYXeOpP8towNKctDALQ7KA46DmdeJa1nOaZy5oDWlhic
 rk1VcnoPY/5ytTGCHjBlkxCtUDUyt1K33r1UbCo=
X-Google-Smtp-Source: APBJJlFDZ1q7Md7EICCrhFDpFQH+Yt1xYYr1MpL5EUwBGxUPT41wohAgcuO7G9VfC9l0708WaD8vQQ==
X-Received: by 2002:a05:6512:39c5:b0:4f9:69af:9857 with SMTP id
 k5-20020a05651239c500b004f969af9857mr7786560lfu.51.1690280706469; 
 Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c211300b003fbc30825fbsm12567185wml.39.2023.07.25.03.25.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:25:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] target/arm: Special case M-profile in debug_helper.c code
Date: Tue, 25 Jul 2023 11:25:01 +0100
Message-Id: <20230725102503.2283907-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725102503.2283907-1-peter.maydell@linaro.org>
References: <20230725102503.2283907-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

A lot of the code called from helper_exception_bkpt_insn() is written
assuming A-profile, but we will also call this helper on M-profile
CPUs when they execute a BKPT insn.  This used to work by accident,
but recent changes mean that we will hit an assert when some of this
code calls down into lower level functions that end up calling
arm_security_space_below_el3(), arm_el_is_aa64(), and other functions
that now explicitly assert that the guest CPU is not M-profile.

Handle M-profile directly to avoid the assertions:
 * in arm_debug_target_el(), M-profile debug exceptions always
   go to EL1
 * in arm_debug_exception_fsr(), M-profile always uses the short
   format FSR (compare commit d7fe699be54b2, though in this case
   the code in arm_v7m_cpu_do_interrupt() does not need to
   look at the FSR value at all)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1775
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230721143239.1753066-1-peter.maydell@linaro.org
---
 target/arm/debug_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 8362462a07e..abe72e35ae6 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -21,6 +21,10 @@ static int arm_debug_target_el(CPUARMState *env)
     bool secure = arm_is_secure(env);
     bool route_to_el2 = false;
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return 1;
+    }
+
     if (arm_is_el2_enabled(env)) {
         route_to_el2 = env->cp15.hcr_el2 & HCR_TGE ||
                        env->cp15.mdcr_el2 & MDCR_TDE;
@@ -434,18 +438,20 @@ static uint32_t arm_debug_exception_fsr(CPUARMState *env)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Debug };
     int target_el = arm_debug_target_el(env);
-    bool using_lpae = false;
+    bool using_lpae;
 
-    if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        using_lpae = false;
+    } else if (target_el == 2 || arm_el_is_aa64(env, target_el)) {
         using_lpae = true;
     } else if (arm_feature(env, ARM_FEATURE_PMSA) &&
                arm_feature(env, ARM_FEATURE_V8)) {
         using_lpae = true;
+    } else if (arm_feature(env, ARM_FEATURE_LPAE) &&
+               (env->cp15.tcr_el[target_el] & TTBCR_EAE)) {
+        using_lpae = true;
     } else {
-        if (arm_feature(env, ARM_FEATURE_LPAE) &&
-            (env->cp15.tcr_el[target_el] & TTBCR_EAE)) {
-            using_lpae = true;
-        }
+        using_lpae = false;
     }
 
     if (using_lpae) {
-- 
2.34.1


