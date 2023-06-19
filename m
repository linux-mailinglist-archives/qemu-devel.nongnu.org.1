Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B64B735BBE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEt-0006ps-3D; Mon, 19 Jun 2023 11:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEi-0006jR-Uz
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:14 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEe-0004zm-AJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:12 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f766777605so4609498e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190166; x=1689782166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVptJPns2mYZcaoOxrCgGGkSdCqldtsGo4pcdEcI3M8=;
 b=my+ydlrMkZR3PzKPXRg0NrFzO1wqozErDCGDQO/hc1O0NZ/+h1w+ytvv5HjKtIw5wm
 0TGZenvs/suS9QnDRGGlTxg/yzRzjK/OUK5tZxfrX0HRNINeZu899V7AoT8KnnKfF8AO
 T3k0MHPK9f8XYSw69bZH478YwvTArlXQZJrgpzsQ6tTK9J5uIrbgm291ugAlp+si6uyr
 H+hLebhXP3tI7dtAjJ7zfYzsLiWi8XIyyW0yrsquvl4uWUj+GxuLQIdzZSuQtAfslDaF
 CQiUiHb8WERgxtjRun/LnvtTVCyx0CjrIpX0EPyLFE6f7XO2VunIkA/McjjcYHWbzWJC
 ztFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190166; x=1689782166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVptJPns2mYZcaoOxrCgGGkSdCqldtsGo4pcdEcI3M8=;
 b=QWkfh9FUp2peBYiG2qKFhaME3XI06hTMavSWLaszujblfr7Y4bNa9cXupnNl7kU87g
 GcWK4t0106Xvu2TGwi8WShGIVK0LVHDWtLnTde+UdhrxxpHCVGNwFKyrGigny9MEOKic
 ZSk9OrCKJA5I5rDqJkr50p2DIE12O+cAqcRpLQPO0NuUK0uJ8nwO+7h7rAWREh7NGocM
 AuYu6TPhYx9PeXAWtWgEvuB9R4jE32fSCQbXgnByg8uKIHXiCs7GLDJ31PTnsbYMaP3p
 NjGtFzfSJtPZT05aYg9dW+ukmtliFZtOm6HCulnUOZLwmH8JyYmEjLNiT2esw3vSLP40
 Z/3g==
X-Gm-Message-State: AC+VfDydgTfZLSMz9OX6VHnZ9rvjE2vTry5Fo1Ac7O3UfRjkj84uqKBo
 AlYSs49ScnEnOy9mwC+dbWV6r9L2QpMr5cYPKDfGfw==
X-Google-Smtp-Source: ACHHUZ5cu1zU975biEDnJuzPSR9nQKx/VJNJUSx0YmFJde3T3CKPFBURqO89IigNy89LCjvuUoXbxw==
X-Received: by 2002:a05:6512:556:b0:4f8:4a86:3d82 with SMTP id
 h22-20020a056512055600b004f84a863d82mr6096452lfl.51.1687190165401; 
 Mon, 19 Jun 2023 08:56:05 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 v24-20020aa7d818000000b005184165f1fasm451331edq.5.2023.06.19.08.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/34] target/arm/tcg: Extract gvec definitions to
 'helper-gvec.h.inc'
Date: Mon, 19 Jun 2023 17:54:53 +0200
Message-Id: <20230619155510.80991-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

helper.h is used by all units, but not all require the generic
vector definitions. Move them to a new header; the next commit
will remove it from the common helper.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h              | 380 +------------------------------
 target/arm/tcg/helper-gvec.h.inc | 378 ++++++++++++++++++++++++++++++
 2 files changed, 379 insertions(+), 379 deletions(-)
 create mode 100644 target/arm/tcg/helper-gvec.h.inc

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 819d27d597..df22f1a117 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -146,15 +146,6 @@ DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
-DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_5(sve2_sqrdmlah_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_b, TCG_CALL_NO_RWG,
@@ -172,336 +163,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sudot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(gvec_fcmlah, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlas, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqadd_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uqsub_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sqsub_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_clt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_clt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cle0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cgt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cge0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_cge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_smulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_smulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_umulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_umulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_ssra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ssra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_usra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_srsra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_srsra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_ursra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_sri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_3(gvec_sli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_sabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_sabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_uabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_saba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_saba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_uaba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_uaba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -531,50 +192,11 @@ DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_smmla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_bfdot, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_bfdot_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_sclamp_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
-DEF_HELPER_FLAGS_5(gvec_uclamp_b, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_h, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h.inc"
 #include "tcg/helper-sve.h.inc"
 #include "tcg/helper-sme.h.inc"
 #endif
 
+#include "tcg/helper-gvec.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/helper-gvec.h.inc b/target/arm/tcg/helper-gvec.h.inc
new file mode 100644
index 0000000000..6143221428
--- /dev/null
+++ b/target/arm/tcg/helper-gvec.h.inc
@@ -0,0 +1,378 @@
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sdot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_udot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sudot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_idx_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcaddh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(gvec_fcmlah, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlas, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_tosszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_tosizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_touszh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrint_rm_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_vrintx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcgt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fcge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcge0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fceq0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fcle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fcle0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_fclt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_fclt0_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fcgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_facge_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facge_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_facgt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_facgt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_recps_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_ceq0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ceq0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_clt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_clt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cle0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cle0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cgt0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cge0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_cge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_smulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_umulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_ushl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_pmul_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_pmull_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_ssra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ssra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_usra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_usra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_srshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_urshr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_urshr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_srsra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_srsra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_ursra_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursra_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_sli_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_sli_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uabd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_saba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_saba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_uaba_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_uaba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_smmla_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_bfdot, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_bfdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_bfmmla, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(gvec_bfmlal, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmlal_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_sclamp_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sclamp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sclamp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sclamp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_uclamp_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uclamp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
-- 
2.38.1


