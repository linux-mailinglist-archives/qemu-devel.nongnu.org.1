Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF863729762
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zfj-0003wf-48; Fri, 09 Jun 2023 06:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfh-0003pQ-6J
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:45 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZfS-0001VU-Qv
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:44 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f62d93f38aso2032123e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307706; x=1688899706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy6B+HGnLvUCt52zauCrOX2+GWZbEEYb+TIAEI5ra1s=;
 b=CpXQqS28Ai0rykCnivOZYwfFBzrMlgZ775mkM/VLjySHzK9FxCF+Xj62CcoxmCiU/i
 V1S0KZ7wXQ7+djg5MgjW41Ld0M8EZj3/4yBty+XZesGNqPoSSKHufKDZFkfQYsOAOLkE
 o2ZGuIStzC6dafvl49yiM+9uXC8xSQSM9yBIwVGJFEvW2QZu6hg7wc4VfCObr4HZeF3u
 oUQpbZFSoeAHFFMVQ07LAiuDT1rebnZYYpOQYSoxHQzJMGMpmqaGBZKD3s6e2+80WGTN
 5MbPn9uDs46CrqvuNtvfXqHf4U8L2LvCUOO+pENrdSZFPh3w1qimwnK2bpvI8/A1X0IL
 eKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307706; x=1688899706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fy6B+HGnLvUCt52zauCrOX2+GWZbEEYb+TIAEI5ra1s=;
 b=fYfODEb5WmbCJbYX3KGra+/s0ItZcuZdXIEg87ZpSjUhAS1JKb/6tV+nRQCoKsQWNo
 Jh8iiQ/1rssammTlcS1hvfRguKIBAJr4aGVqWnqBe5Qm/zyjzyEgnSv40v6czGSRsaAB
 rK8PDc2HMR03eamhZHSZv7EGmw6TMnPnPGWZpQ2Etk626ISu9wpoooguwpWAX3MLwU5V
 N1ahoBRBRHQzptZFhEUMPSrSQJ8xsZnc3QQ6u+bN6V+S7RvpvIa4W3eekXWac9DBrk8d
 lb4T50SY2/H8fk84DX8CdmHauevJnPUKW73tapejUYUmEdFzKQdIkDzF4/mgUUu+ViYA
 2CCA==
X-Gm-Message-State: AC+VfDxJSSHgx9sAyt/Iku3+hlcqYlBhALPxBf4wJp2DujDo8iHxthXb
 uNoh4pPuZv6x3E9QGJ+cYm8wyPCZIdWAf8nRgffCbg==
X-Google-Smtp-Source: ACHHUZ5bhMo14qrQg2fR8TFIVh5AkbxMqYpt57fEA8sE2mOvYYJ09WKgKj8kE5XW+dDY87EGlHqCqA==
X-Received: by 2002:a19:d609:0:b0:4f4:bbfc:3615 with SMTP id
 n9-20020a19d609000000b004f4bbfc3615mr576306lfg.68.1686307706186; 
 Fri, 09 Jun 2023 03:48:26 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c021000b003f7f6827ab9sm2279075wmi.31.2023.06.09.03.48.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/22] target/arm/tcg: Extract VFP definitions to
 'helper-vfp.h.inc'
Date: Fri,  9 Jun 2023 12:47:05 +0200
Message-Id: <20230609104717.95555-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

helper.h is used by all units, but not all require the VFP
definitions. Move them to a new header; the next commit will
remove it from the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 137 +-------------------------------
 target/arm/tcg/helper-vfp.h.inc | 136 +++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 136 deletions(-)
 create mode 100644 target/arm/tcg/helper-vfp.h.inc

diff --git a/target/arm/helper.h b/target/arm/helper.h
index dd12fee107..9d85675d17 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -106,144 +106,8 @@ DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
-DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
-DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
-DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
-DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_1(vfp_negh, f16, f16)
-DEF_HELPER_1(vfp_negs, f32, f32)
-DEF_HELPER_1(vfp_negd, f64, f64)
-DEF_HELPER_1(vfp_absh, f16, f16)
-DEF_HELPER_1(vfp_abss, f32, f32)
-DEF_HELPER_1(vfp_absd, f64, f64)
-DEF_HELPER_2(vfp_sqrth, f16, f16, env)
-DEF_HELPER_2(vfp_sqrts, f32, f32, env)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
-DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
-DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
-DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
-DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
-
-DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
-DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
-DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, ptr)
-DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, ptr)
-
-DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
-DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
-DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
-DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
-
-DEF_HELPER_2(vfp_touih, i32, f16, ptr)
-DEF_HELPER_2(vfp_touis, i32, f32, ptr)
-DEF_HELPER_2(vfp_touid, i32, f64, ptr)
-DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
-DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
-DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
-DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
-DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
-DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
-DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
-
-DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
-DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
-DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_touhs, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touls, i32, f32, i32, ptr)
-DEF_HELPER_3(vfp_touqs, i64, f32, i32, ptr)
-DEF_HELPER_3(vfp_toshd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosld, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tosqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touhd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_tould, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_touqd, i64, f64, i32, ptr)
-DEF_HELPER_3(vfp_shtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uqtos, f32, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
-DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
-
-DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
-DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
-DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
-DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
-
 DEF_HELPER_FLAGS_2(set_rmode, TCG_CALL_NO_RWG, i32, i32, ptr)
 
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
-DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
-
-DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
-DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
-DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
-
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
@@ -949,4 +813,5 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
+#include "tcg/helper-vfp.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/helper-vfp.h.inc b/target/arm/tcg/helper-vfp.h.inc
new file mode 100644
index 0000000000..0bf74cb81e
--- /dev/null
+++ b/target/arm/tcg/helper-vfp.h.inc
@@ -0,0 +1,136 @@
+
+DEF_HELPER_3(vfp_addh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_adds, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_addd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_subh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_subs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_subd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_mulh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_muls, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_muld, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_divh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_divs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_divd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_maxs, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_maxd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_mins, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_mind, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_maxnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_maxnums, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
+DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
+DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
+DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
+DEF_HELPER_1(vfp_negh, f16, f16)
+DEF_HELPER_1(vfp_negs, f32, f32)
+DEF_HELPER_1(vfp_negd, f64, f64)
+DEF_HELPER_1(vfp_absh, f16, f16)
+DEF_HELPER_1(vfp_abss, f32, f32)
+DEF_HELPER_1(vfp_absd, f64, f64)
+DEF_HELPER_2(vfp_sqrth, f16, f16, env)
+DEF_HELPER_2(vfp_sqrts, f32, f32, env)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
+DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
+DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
+DEF_HELPER_3(vfp_cmpeh, void, f16, f16, env)
+DEF_HELPER_3(vfp_cmpes, void, f32, f32, env)
+DEF_HELPER_3(vfp_cmped, void, f64, f64, env)
+
+DEF_HELPER_2(vfp_fcvtds, f64, f32, env)
+DEF_HELPER_2(vfp_fcvtsd, f32, f64, env)
+DEF_HELPER_FLAGS_2(bfcvt, TCG_CALL_NO_RWG, i32, f32, ptr)
+DEF_HELPER_FLAGS_2(bfcvt_pair, TCG_CALL_NO_RWG, i32, i64, ptr)
+
+DEF_HELPER_2(vfp_uitoh, f16, i32, ptr)
+DEF_HELPER_2(vfp_uitos, f32, i32, ptr)
+DEF_HELPER_2(vfp_uitod, f64, i32, ptr)
+DEF_HELPER_2(vfp_sitoh, f16, i32, ptr)
+DEF_HELPER_2(vfp_sitos, f32, i32, ptr)
+DEF_HELPER_2(vfp_sitod, f64, i32, ptr)
+
+DEF_HELPER_2(vfp_touih, i32, f16, ptr)
+DEF_HELPER_2(vfp_touis, i32, f32, ptr)
+DEF_HELPER_2(vfp_touid, i32, f64, ptr)
+DEF_HELPER_2(vfp_touizh, i32, f16, ptr)
+DEF_HELPER_2(vfp_touizs, i32, f32, ptr)
+DEF_HELPER_2(vfp_touizd, i32, f64, ptr)
+DEF_HELPER_2(vfp_tosih, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosis, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosid, s32, f64, ptr)
+DEF_HELPER_2(vfp_tosizh, s32, f16, ptr)
+DEF_HELPER_2(vfp_tosizs, s32, f32, ptr)
+DEF_HELPER_2(vfp_tosizd, s32, f64, ptr)
+
+DEF_HELPER_3(vfp_toshh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touhh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh_round_to_zero, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshs_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosls_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touhs_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touls_round_to_zero, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_toshd_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosld_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhd_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tould_round_to_zero, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toulh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_toslh, i32, f16, i32, ptr)
+DEF_HELPER_3(vfp_touqh, i64, f16, i32, ptr)
+DEF_HELPER_3(vfp_tosqh, i64, f16, i32, ptr)
+DEF_HELPER_3(vfp_toshs, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosls, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_tosqs, i64, f32, i32, ptr)
+DEF_HELPER_3(vfp_touhs, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touls, i32, f32, i32, ptr)
+DEF_HELPER_3(vfp_touqs, i64, f32, i32, ptr)
+DEF_HELPER_3(vfp_toshd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosld, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tosqd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touhd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_tould, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_touqd, i64, f64, i32, ptr)
+DEF_HELPER_3(vfp_shtos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sqtos, f32, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultos, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uqtos, f32, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_ultod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uqtod, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sqtoh, f16, i64, i32, ptr)
+DEF_HELPER_3(vfp_uqtoh, f16, i64, i32, ptr)
+
+DEF_HELPER_3(vfp_shtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultos_round_to_nearest, f32, i32, i32, ptr)
+DEF_HELPER_3(vfp_shtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_sltod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_uhtod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_ultod_round_to_nearest, f64, i64, i32, ptr)
+DEF_HELPER_3(vfp_shtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_uhtoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_sltoh_round_to_nearest, f16, i32, i32, ptr)
+DEF_HELPER_3(vfp_ultoh_round_to_nearest, f16, i32, i32, ptr)
+
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f32, TCG_CALL_NO_RWG, f32, f16, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f32_to_f16, TCG_CALL_NO_RWG, f16, f32, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f16_to_f64, TCG_CALL_NO_RWG, f64, f16, ptr, i32)
+DEF_HELPER_FLAGS_3(vfp_fcvt_f64_to_f16, TCG_CALL_NO_RWG, f16, f64, ptr, i32)
+
+DEF_HELPER_4(vfp_muladdd, f64, f64, f64, f64, ptr)
+DEF_HELPER_4(vfp_muladds, f32, f32, f32, f32, ptr)
+DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, ptr)
-- 
2.38.1


