Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F9A1BAE0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 17:47:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdu-0000Zz-MA; Fri, 24 Jan 2025 11:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYu-0005VJ-D0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYs-0005hC-HE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso23699145e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736177; x=1738340977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U0j6vRTPpETqpomxsJi6W+TLpbdYei71WZ9Mhto3dnA=;
 b=o7LvzkYCRis4MNGikRj3QZtusYAyxCPmH3/QGMhHSqCJVleMzICav91bzqs5HK00Ns
 2xFY8oAfqgZ/kTdrFB+ye4+uJa3n17UoGU178cS1XyrbKtoB4rlxPQwFXdot/uQLbBBT
 hayJIb1HIIRBz2+PCZ64N9Si2LPOPM8pkVkHDdKa25CJIHOsrOl4jLvrjXV5W+1dXJ/2
 ge48MOlHby6p+CJPIS4BAw91AeV8WJXspnrOnF+d7Lv9KXSeEDpUCRLijosx5mqDJkfR
 Z4u0iuPqkkKH8BRmr9K2mBiquYQs4ShOqZAFffyDAKAUyx4yi6gHoT/gdeuRioxARREO
 Jrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736177; x=1738340977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U0j6vRTPpETqpomxsJi6W+TLpbdYei71WZ9Mhto3dnA=;
 b=fFhS5EsVREW4428+/1rkNc/34qG+AE3YqCT7tAUx+SeXu5m7Tz7Ps6E7Ki5NpUVuYe
 syVLBnX06OHP8gmP08/GvZbqbmiRsik0E4MJPaRb2aBepMlI6NDqhluvIqTnrAOZsxTV
 r4oaMy+CYL5JRUTmVAAE03cQc4KldBjks6+l+hSR9nLHOgB4ekoi+j6/FgkH3I1V/tot
 pk+h+FqAZtZO2nfYBTgloKebXn7V85cRNfv+kTJv1BuriWW9XF17Nb9iC8cxiL0/rHZP
 qh2nSPmPsw9em1UAhzsul7gcD8oquVnivYZWESlQN7XxDeQ6STUlAFsEt6s6XCNJn9SN
 UpIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8Xe2NsMCVOPI28m3nuVtoKgBj8Z5ZhRw3FgiRKtsRX5fJast4G5cg90iNhkL6DE25r6kByy9t9x3J@nongnu.org
X-Gm-Message-State: AOJu0Yyb2isHSkzFMfT63BBqHeXZ5zEWjUxo2eFQ6kHRZYGDZQdrdhB8
 UKWOIV7J2zGJBX2WMcty65uKcfL11kLiD/UX4d2dcJU2iUHq37iK16kf8LSB1Cg=
X-Gm-Gg: ASbGncusvK3XDa3Mbyegn9pR+vyZy5gdvD3hHRL6TXtt8KJ6O/3uooolh1kBBmJBZJ3
 aZADE8pfE91gvatkHlnxPS0I4kkZ5+3WMOK+Vlr8g9qhPpmq05CrtnBhoiLzGvjeO3Yc5oPpdF4
 woIz5d04jbaKpdb8JoU6T4P+0qM//uZfPdapdKDmXt5ublB9ejZob1Tighx6xfS2h2G5IBvf7zy
 CfI6P/ieRhacYQHhFN+LZed0ZKRfG30bcHVMWT+ow0eaHSIVl5U5RcvM2ODn+ZjnKY2403veT9F
 uwXZ/Lvefd0=
X-Google-Smtp-Source: AGHT+IEesI84H+z7I9KF8z2S8kHDLJ/QahAj0mDv+v46cjnKpR9uQ3FsxB1YUDz4mOvzTaoFbL3h1g==
X-Received: by 2002:a05:600c:3149:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4389144eee4mr250975805e9.26.1737736176994; 
 Fri, 24 Jan 2025 08:29:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 48/76] target/arm: Implement FPCR.AH semantics for FMINP and
 FMAXP
Date: Fri, 24 Jan 2025 16:28:08 +0000
Message-Id: <20250124162836.2332150-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Implement the FPCR.AH semantics for the pairwise floating
point minimum/maximum insns FMINP and FMAXP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 target/arm/tcg/vec_helper.c    | 10 ++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index f1b4606f763..8349752e99b 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -986,6 +986,20 @@ DEF_HELPER_FLAGS_5(gvec_ah_fmin_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ah_fmin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c07e22bad31..9d164b80c22 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5776,14 +5776,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxp[3] = {
     gen_helper_gvec_fmaxp_s,
     gen_helper_gvec_fmaxp_d,
 };
-TRANS(FMAXP_v, do_fp3_vector, a, 0, f_vector_fmaxp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fmaxp[3] = {
+    gen_helper_gvec_ah_fmaxp_h,
+    gen_helper_gvec_ah_fmaxp_s,
+    gen_helper_gvec_ah_fmaxp_d,
+};
+TRANS(FMAXP_v, do_fp3_vector_2fn, a, 0, f_vector_fmaxp, f_vector_ah_fmaxp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminp[3] = {
     gen_helper_gvec_fminp_h,
     gen_helper_gvec_fminp_s,
     gen_helper_gvec_fminp_d,
 };
-TRANS(FMINP_v, do_fp3_vector, a, 0, f_vector_fminp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fminp[3] = {
+    gen_helper_gvec_ah_fminp_h,
+    gen_helper_gvec_ah_fminp_s,
+    gen_helper_gvec_ah_fminp_d,
+};
+TRANS(FMINP_v, do_fp3_vector_2fn, a, 0, f_vector_fminp, f_vector_ah_fminp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnmp[3] = {
     gen_helper_gvec_fmaxnump_h,
@@ -6775,9 +6785,16 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
     return true;
 }
 
+static bool do_fp3_scalar_pair_2fn(DisasContext *s, arg_rr_e *a,
+                                   const FPScalar *fnormal,
+                                   const FPScalar *fah)
+{
+    return do_fp3_scalar_pair(s, a, s->fpcr_ah ? fah : fnormal);
+}
+
 TRANS(FADDP_s, do_fp3_scalar_pair, a, &f_scalar_fadd)
-TRANS(FMAXP_s, do_fp3_scalar_pair, a, &f_scalar_fmax)
-TRANS(FMINP_s, do_fp3_scalar_pair, a, &f_scalar_fmin)
+TRANS(FMAXP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmax, &f_scalar_fmax_ah)
+TRANS(FMINP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmin, &f_scalar_fmin_ah)
 TRANS(FMAXNMP_s, do_fp3_scalar_pair, a, &f_scalar_fmaxnm)
 TRANS(FMINNMP_s, do_fp3_scalar_pair, a, &f_scalar_fminnm)
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index c7af9a04a27..d3f2eaa807e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2444,6 +2444,16 @@ DO_3OP_PAIR(gvec_fminnump_h, float16_minnum, float16, H2)
 DO_3OP_PAIR(gvec_fminnump_s, float32_minnum, float32, H4)
 DO_3OP_PAIR(gvec_fminnump_d, float64_minnum, float64, )
 
+#ifdef TARGET_AARCH64
+DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
+DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, )
+
+DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
+DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, )
+#endif
+
 #undef DO_3OP_PAIR
 
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
-- 
2.34.1


