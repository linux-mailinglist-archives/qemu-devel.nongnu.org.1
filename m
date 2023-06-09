Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34C729767
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zfq-0004jN-Tp; Fri, 09 Jun 2023 06:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfo-0004X5-4R
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:52 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zfj-0001Xv-Sp
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:51 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f6195d2b3fso2023066e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307725; x=1688899725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TL2KBHzTOjD65QC7kN6aiMgnziSl4jZ9xzNyVd6EGI=;
 b=pF81EE+bkXIVYLco9uB7FdIxAxHkouvLR2lYciM4ryd/uutn7sLj4Z7WxiqgtSfV1f
 D+wENujzwAHxwZXFqnWpTujcaBxqvmC+phSQZNUwX0uKtOV61R5IbDMHKny0hXjvm/ma
 RH1jzFb2lerk+a1dl3PQqMYrc7twI6lA0GIpElkNVCxl7UMyBYKDrDO4Q0ZdBaZLdmGB
 +/oOVXPXfW3GL9+ZAxT/lvvw2+1nIHHTEFNGgvA2GFIWIIs/nN2/rlPCd98fSFIS5BxA
 NkIu/aXSz5xOv8C/5au6KFVt7TvNKfe7aNZ2MOZZnPmn4gJJSC5GoY1fILQJQbpnhZ/c
 Oy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307725; x=1688899725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TL2KBHzTOjD65QC7kN6aiMgnziSl4jZ9xzNyVd6EGI=;
 b=dsl3JLk7gxGSJqFD1rtzFjp2bfOnRxH59JOJiy3yIgl/VXTAqAtABmt+gMDGNbRXFN
 DjQ6N7fbFu6e7aHRAo4UrXFl0EZNlrTGukTv9S57KTWLR5M4ngYYPlJhFeu5GTv5BOtP
 CUQoJqbqAfKnTh495SAqeqkGYKdBH+Fcz2sSWZhg0J3vAT5YlUCqt4e55MDpC7b4U5NT
 KrLpJKSiaWhkdrySdEyqAsDZcfEYeKKg05ZHu6yxTzVunYM06dfGq2SJ8NpmDK4ieZZ/
 lcSoGVinFKEbkHoLKWtRkXTh/LK5q90eAoxPk6oG/JlY3TO8eP4SMp+oZJCy6kqP++Qx
 EvTA==
X-Gm-Message-State: AC+VfDxRDlei0Kbti5F1idcfiEqIriG9IhexUx6Huhm1mjXXRc3BOumi
 JXGaT51f2gi8qGrfCzY5li4/KANzSURkNLJ59HWS1Q==
X-Google-Smtp-Source: ACHHUZ7oiVUxAxIApIE6LxlyauFlALrtcAaMOmRIpQ1G2UWxXTFlWrz/lFg3K6VJi7DwCLmFmDGiJQ==
X-Received: by 2002:a05:6512:547:b0:4f4:cacb:4b4b with SMTP id
 h7-20020a056512054700b004f4cacb4b4bmr690691lfl.18.1686307724547; 
 Fri, 09 Jun 2023 03:48:44 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003f17848673fsm2287813wmj.27.2023.06.09.03.48.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/22] target/arm/tcg: Extract NEON definitions to
 'helper-neon.h.inc'
Date: Fri,  9 Jun 2023 12:47:08 +0200
Message-Id: <20230609104717.95555-14-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

helper.h is used by all units, but not all require the NEON
definitions. Move them to a new header; the next commit will
remove it from the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h              | 206 +------------------------------
 target/arm/tcg/helper-neon.h.inc | 205 ++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 205 deletions(-)
 create mode 100644 target/arm/tcg/helper-neon.h.inc

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4d1b7ec6b4..2cf25f0605 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -116,7 +116,6 @@ DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
-DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
 DEF_HELPER_3(shr_cc, i32, env, i32, i32)
@@ -135,191 +134,6 @@ DEF_HELPER_FLAGS_2(fjcvtzs, TCG_CALL_NO_RWG, i64, f64, ptr)
 
 DEF_HELPER_FLAGS_3(check_hcr_el2_trap, TCG_CALL_NO_WG, void, env, i32, i32)
 
-/* neon_helper.c */
-DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_qadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_uqadd_s64, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_FLAGS_3(neon_sqadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(neon_sqadd_u64, TCG_CALL_NO_RWG, i64, env, i64, i64)
-DEF_HELPER_3(neon_qsub_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qsub_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qadd_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qadd_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qsub_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qsub_s64, i64, env, i64, i64)
-
-DEF_HELPER_2(neon_hadd_s8, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_s16, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_hadd_s32, s32, s32, s32)
-DEF_HELPER_2(neon_hadd_u32, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_s8, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_rhadd_s32, s32, s32, s32)
-DEF_HELPER_2(neon_rhadd_u32, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u8, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_u16, i32, i32, i32)
-DEF_HELPER_2(neon_hsub_s32, s32, s32, s32)
-DEF_HELPER_2(neon_hsub_u32, i32, i32, i32)
-
-DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
-DEF_HELPER_2(neon_pmin_s16, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_u8, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_s8, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_u16, i32, i32, i32)
-DEF_HELPER_2(neon_pmax_s16, i32, i32, i32)
-
-DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
-DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s16, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u32, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_s32, i32, i32, i32)
-DEF_HELPER_2(neon_rshl_u64, i64, i64, i64)
-DEF_HELPER_2(neon_rshl_s64, i64, i64, i64)
-DEF_HELPER_3(neon_qshl_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshl_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qshl_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qshlu_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qshlu_s64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qrshl_u8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s8, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
-DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
-
-DEF_HELPER_2(neon_add_u8, i32, i32, i32)
-DEF_HELPER_2(neon_add_u16, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u16, i32, i32, i32)
-DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
-DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
-DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
-DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
-
-DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
-DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
-DEF_HELPER_2(neon_tst_u32, i32, i32, i32)
-
-DEF_HELPER_1(neon_clz_u8, i32, i32)
-DEF_HELPER_1(neon_clz_u16, i32, i32)
-DEF_HELPER_1(neon_cls_s8, i32, i32)
-DEF_HELPER_1(neon_cls_s16, i32, i32)
-DEF_HELPER_1(neon_cls_s32, i32, i32)
-DEF_HELPER_1(neon_cnt_u8, i32, i32)
-DEF_HELPER_FLAGS_1(neon_rbit_u8, TCG_CALL_NO_RWG_SE, i32, i32)
-
-DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
-DEF_HELPER_4(neon_qrdmlah_s16, i32, env, i32, i32, i32)
-DEF_HELPER_4(neon_qrdmlsh_s16, i32, env, i32, i32, i32)
-DEF_HELPER_3(neon_qdmulh_s32, i32, env, i32, i32)
-DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
-DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
-DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
-
-DEF_HELPER_1(neon_narrow_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_u16, i32, i64)
-DEF_HELPER_2(neon_unarrow_sat8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s8, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s16, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s32, i32, env, i64)
-DEF_HELPER_1(neon_narrow_high_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_high_u16, i32, i64)
-DEF_HELPER_1(neon_narrow_round_high_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_round_high_u16, i32, i64)
-DEF_HELPER_1(neon_widen_u8, i64, i32)
-DEF_HELPER_1(neon_widen_s8, i64, i32)
-DEF_HELPER_1(neon_widen_u16, i64, i32)
-DEF_HELPER_1(neon_widen_s16, i64, i32)
-
-DEF_HELPER_2(neon_addl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_addl_u32, i64, i64, i64)
-DEF_HELPER_2(neon_paddl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_paddl_u32, i64, i64, i64)
-DEF_HELPER_2(neon_subl_u16, i64, i64, i64)
-DEF_HELPER_2(neon_subl_u32, i64, i64, i64)
-DEF_HELPER_3(neon_addl_saturate_s32, i64, env, i64, i64)
-DEF_HELPER_3(neon_addl_saturate_s64, i64, env, i64, i64)
-DEF_HELPER_2(neon_abdl_u16, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s16, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_u32, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s32, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_u64, i64, i32, i32)
-DEF_HELPER_2(neon_abdl_s64, i64, i32, i32)
-DEF_HELPER_2(neon_mull_u8, i64, i32, i32)
-DEF_HELPER_2(neon_mull_s8, i64, i32, i32)
-DEF_HELPER_2(neon_mull_u16, i64, i32, i32)
-DEF_HELPER_2(neon_mull_s16, i64, i32, i32)
-
-DEF_HELPER_1(neon_negl_u16, i64, i64)
-DEF_HELPER_1(neon_negl_u32, i64, i64)
-
-DEF_HELPER_FLAGS_2(neon_qabs_s8, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s16, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s32, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qabs_s64, TCG_CALL_NO_RWG, i64, env, i64)
-DEF_HELPER_FLAGS_2(neon_qneg_s8, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
-DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
-
-DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, ptr)
-DEF_HELPER_3(neon_acge_f64, i64, i64, i64, ptr)
-DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, ptr)
-
-DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qunzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_zip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_zip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
-DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
-
 DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
@@ -421,13 +235,6 @@ DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -648,8 +455,6 @@ DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_3(gvec_ssra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ssra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_ssra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
@@ -728,16 +533,6 @@ DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(neon_sqdmulh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqdmulh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -813,4 +608,5 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
+#include "tcg/helper-neon.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/helper-neon.h.inc b/target/arm/tcg/helper-neon.h.inc
new file mode 100644
index 0000000000..82d509f929
--- /dev/null
+++ b/target/arm/tcg/helper-neon.h.inc
@@ -0,0 +1,205 @@
+DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i64, env, i32, i64, i64)
+
+/* neon_helper.c */
+DEF_HELPER_FLAGS_3(neon_qadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_qadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_qadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_qadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_qadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_qadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_uqadd_s8, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_uqadd_s16, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_uqadd_s32, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_uqadd_s64, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(neon_sqadd_u8, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_sqadd_u16, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_sqadd_u32, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(neon_sqadd_u64, TCG_CALL_NO_RWG, i64, env, i64, i64)
+DEF_HELPER_3(neon_qsub_u8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qsub_s8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qsub_u16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qsub_s16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qsub_u32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qsub_s32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qadd_u64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qadd_s64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qsub_u64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qsub_s64, i64, env, i64, i64)
+
+DEF_HELPER_2(neon_hadd_s8, i32, i32, i32)
+DEF_HELPER_2(neon_hadd_u8, i32, i32, i32)
+DEF_HELPER_2(neon_hadd_s16, i32, i32, i32)
+DEF_HELPER_2(neon_hadd_u16, i32, i32, i32)
+DEF_HELPER_2(neon_hadd_s32, s32, s32, s32)
+DEF_HELPER_2(neon_hadd_u32, i32, i32, i32)
+DEF_HELPER_2(neon_rhadd_s8, i32, i32, i32)
+DEF_HELPER_2(neon_rhadd_u8, i32, i32, i32)
+DEF_HELPER_2(neon_rhadd_s16, i32, i32, i32)
+DEF_HELPER_2(neon_rhadd_u16, i32, i32, i32)
+DEF_HELPER_2(neon_rhadd_s32, s32, s32, s32)
+DEF_HELPER_2(neon_rhadd_u32, i32, i32, i32)
+DEF_HELPER_2(neon_hsub_s8, i32, i32, i32)
+DEF_HELPER_2(neon_hsub_u8, i32, i32, i32)
+DEF_HELPER_2(neon_hsub_s16, i32, i32, i32)
+DEF_HELPER_2(neon_hsub_u16, i32, i32, i32)
+DEF_HELPER_2(neon_hsub_s32, s32, s32, s32)
+DEF_HELPER_2(neon_hsub_u32, i32, i32, i32)
+
+DEF_HELPER_2(neon_pmin_u8, i32, i32, i32)
+DEF_HELPER_2(neon_pmin_s8, i32, i32, i32)
+DEF_HELPER_2(neon_pmin_u16, i32, i32, i32)
+DEF_HELPER_2(neon_pmin_s16, i32, i32, i32)
+DEF_HELPER_2(neon_pmax_u8, i32, i32, i32)
+DEF_HELPER_2(neon_pmax_s8, i32, i32, i32)
+DEF_HELPER_2(neon_pmax_u16, i32, i32, i32)
+DEF_HELPER_2(neon_pmax_s16, i32, i32, i32)
+
+DEF_HELPER_2(neon_shl_u16, i32, i32, i32)
+DEF_HELPER_2(neon_shl_s16, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_u8, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_s8, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_u16, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_s16, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_u32, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_s32, i32, i32, i32)
+DEF_HELPER_2(neon_rshl_u64, i64, i64, i64)
+DEF_HELPER_2(neon_rshl_s64, i64, i64, i64)
+DEF_HELPER_3(neon_qshl_u8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_s8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_u16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_s16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_u32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_s32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshl_u64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qshl_s64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qshlu_s8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshlu_s16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshlu_s32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qshlu_s64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qrshl_u8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_s8, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_u16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_s16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_u32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_s32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrshl_u64, i64, env, i64, i64)
+DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
+
+DEF_HELPER_2(neon_add_u8, i32, i32, i32)
+DEF_HELPER_2(neon_add_u16, i32, i32, i32)
+DEF_HELPER_2(neon_padd_u8, i32, i32, i32)
+DEF_HELPER_2(neon_padd_u16, i32, i32, i32)
+DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
+DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
+DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
+DEF_HELPER_2(neon_mul_u16, i32, i32, i32)
+
+DEF_HELPER_2(neon_tst_u8, i32, i32, i32)
+DEF_HELPER_2(neon_tst_u16, i32, i32, i32)
+DEF_HELPER_2(neon_tst_u32, i32, i32, i32)
+
+DEF_HELPER_1(neon_clz_u8, i32, i32)
+DEF_HELPER_1(neon_clz_u16, i32, i32)
+DEF_HELPER_1(neon_cls_s8, i32, i32)
+DEF_HELPER_1(neon_cls_s16, i32, i32)
+DEF_HELPER_1(neon_cls_s32, i32, i32)
+DEF_HELPER_1(neon_cnt_u8, i32, i32)
+DEF_HELPER_FLAGS_1(neon_rbit_u8, TCG_CALL_NO_RWG_SE, i32, i32)
+
+DEF_HELPER_3(neon_qdmulh_s16, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrdmulh_s16, i32, env, i32, i32)
+DEF_HELPER_4(neon_qrdmlah_s16, i32, env, i32, i32, i32)
+DEF_HELPER_4(neon_qrdmlsh_s16, i32, env, i32, i32, i32)
+DEF_HELPER_3(neon_qdmulh_s32, i32, env, i32, i32)
+DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
+DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
+DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
+
+DEF_HELPER_1(neon_narrow_u8, i32, i64)
+DEF_HELPER_1(neon_narrow_u16, i32, i64)
+DEF_HELPER_2(neon_unarrow_sat8, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u8, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s8, i32, env, i64)
+DEF_HELPER_2(neon_unarrow_sat16, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u16, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s16, i32, env, i64)
+DEF_HELPER_2(neon_unarrow_sat32, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u32, i32, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s32, i32, env, i64)
+DEF_HELPER_1(neon_narrow_high_u8, i32, i64)
+DEF_HELPER_1(neon_narrow_high_u16, i32, i64)
+DEF_HELPER_1(neon_narrow_round_high_u8, i32, i64)
+DEF_HELPER_1(neon_narrow_round_high_u16, i32, i64)
+DEF_HELPER_1(neon_widen_u8, i64, i32)
+DEF_HELPER_1(neon_widen_s8, i64, i32)
+DEF_HELPER_1(neon_widen_u16, i64, i32)
+DEF_HELPER_1(neon_widen_s16, i64, i32)
+
+DEF_HELPER_2(neon_addl_u16, i64, i64, i64)
+DEF_HELPER_2(neon_addl_u32, i64, i64, i64)
+DEF_HELPER_2(neon_paddl_u16, i64, i64, i64)
+DEF_HELPER_2(neon_paddl_u32, i64, i64, i64)
+DEF_HELPER_2(neon_subl_u16, i64, i64, i64)
+DEF_HELPER_2(neon_subl_u32, i64, i64, i64)
+DEF_HELPER_3(neon_addl_saturate_s32, i64, env, i64, i64)
+DEF_HELPER_3(neon_addl_saturate_s64, i64, env, i64, i64)
+DEF_HELPER_2(neon_abdl_u16, i64, i32, i32)
+DEF_HELPER_2(neon_abdl_s16, i64, i32, i32)
+DEF_HELPER_2(neon_abdl_u32, i64, i32, i32)
+DEF_HELPER_2(neon_abdl_s32, i64, i32, i32)
+DEF_HELPER_2(neon_abdl_u64, i64, i32, i32)
+DEF_HELPER_2(neon_abdl_s64, i64, i32, i32)
+DEF_HELPER_2(neon_mull_u8, i64, i32, i32)
+DEF_HELPER_2(neon_mull_s8, i64, i32, i32)
+DEF_HELPER_2(neon_mull_u16, i64, i32, i32)
+DEF_HELPER_2(neon_mull_s16, i64, i32, i32)
+
+DEF_HELPER_1(neon_negl_u16, i64, i64)
+DEF_HELPER_1(neon_negl_u32, i64, i64)
+
+DEF_HELPER_FLAGS_2(neon_qabs_s8, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qabs_s16, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qabs_s32, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qabs_s64, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(neon_qneg_s8, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qneg_s16, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qneg_s32, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(neon_qneg_s64, TCG_CALL_NO_RWG, i64, env, i64)
+
+DEF_HELPER_3(neon_ceq_f32, i32, i32, i32, ptr)
+DEF_HELPER_3(neon_cge_f32, i32, i32, i32, ptr)
+DEF_HELPER_3(neon_cgt_f32, i32, i32, i32, ptr)
+DEF_HELPER_3(neon_acge_f32, i32, i32, i32, ptr)
+DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, ptr)
+DEF_HELPER_3(neon_acge_f64, i64, i64, i64, ptr)
+DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, ptr)
+
+DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qunzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_zip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_zip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
+DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
+
+DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(neon_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqdmulh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqdmulh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
-- 
2.38.1


