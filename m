Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 507FBA21621
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 02:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx39-0000zE-Ie; Tue, 28 Jan 2025 20:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx36-0000xx-82
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx34-0003cR-Kb
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21654fdd5daso107156955ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114761; x=1738719561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TwSGVoapBQ1ELHLjm2I75YpsBvqgtWnyHQMjjwnBeQ=;
 b=L8LnO6k1sdJo2mAEUjytzF9oP/6RkQgvnGEOr24VkM3nQOzL3jRBuiM0T7c1PpDDmC
 TwVjIwi4blMgRhFyKJ+sDDi5pkM+JBxzhWscTFSuNQfwGdy43Y4Y12Zq3UwgO+bPrcw7
 dckZTH4kM2b3QEUpu4ZTtY5US7PUNiO6DFaXFZv+3wEui/knScD3EXO6JjKiL7+jDZqq
 H5LMYpLpIvfJLQPBjnr03JkK7JEq1Ov9x56h4odh9iyXEzMyAA45e1CaQaBfG96VLvDe
 47nYP1/y8ZsmLMBLL0i403r49+Q+oLDCV+R/wg2arjnHqVYS9OtSqL9LwJZrl7s5x/HM
 xsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114761; x=1738719561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TwSGVoapBQ1ELHLjm2I75YpsBvqgtWnyHQMjjwnBeQ=;
 b=vMNZcrVoyPYMKjmdWVklRH592ztj9gyj0cPwCxNW1OvVdT5hv8rEjCu1jEEsxrgCLT
 52DCoWXB+HO2k/6yOAMuFPhUhFY7fawFWn95ubASq97s+L/e+pLkH+kxBHkaZoetvgM/
 lt6wJdstaHfZrRVpy1V9J1/o7iEFpT8H9t8yhfsv9XDLEjroIrtpMG2OInQlLpWus/Hr
 5PHq8UgNvx8O+dJjaatMHkfFAUq6+wPzIxU8wQyrS9UGUFluRMVQzPjIYyh4HTH2hXgv
 S0k06M/KyvrcFitALTBV1oAwTgABm+p9g62nW9FTpMC3eTCuzTBuUgu5orVMxT6dhiwY
 YYuA==
X-Gm-Message-State: AOJu0YxXgfq7vpqurxdhh+Rzw3o7IKK+7GVR15agcVgCBfEGRxNhIAu/
 wWW2vRoBoX/NAu0/EgjzhJbmkvkOgk9iH+xpnE5RMLkfBLiBy4PmU02yQF20jXB97/LhP86xboe
 u
X-Gm-Gg: ASbGncsorLB/w4p2XGuIkxpKxmZ4MJ3LyFoR2qvZm038aXx5goOcTk44+Ul3eRkoTLU
 UQ9sSUYY8u1IMT5/wzK+A5hxIEMz6Q6EplCdqkzaLPG0RIiaoFqO8xsZRTSnyq4+jOU0O1Ssfje
 a5WvHrfzf80oXGWpV78l1/+GujeCylYJTR7xByUxPhw7Tcl5ZCgMDG2Y+AEXs433ym64WcCOq8S
 oTphoJWpLHR8ZYW9+ef+5HM5KYCIUJ5rnDlxxOu/iMqY78RZmZeoAt4l+UWba4jzQUTtNXlmPlR
 znAzQ9Max4+ws0091f8Mo/Yns4F91BsIQ3HrgQbFBzgbxGIFAA==
X-Google-Smtp-Source: AGHT+IGLiZKOkeehtusuqccKMeOmO4xhHdlAElt/f8RminqM3cXFML8XUoG5HlWJabS6T7xzs4eDqQ==
X-Received: by 2002:a17:903:244d:b0:216:1cf8:8b8 with SMTP id
 d9443c01a7336-21dd7c67e11mr14885335ad.27.1738114761302; 
 Tue, 28 Jan 2025 17:39:21 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 33/34] target/arm: Read fz16 from env->vfp.fpcr
Date: Tue, 28 Jan 2025 17:38:56 -0800
Message-ID: <20250129013857.135256-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Read the bit from the source, rather than from the proxy via
get_flush_inputs_to_zero.  This makes it clear that it does
not matter which of the float_status structures is used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bae98a34b8..03b0a6ebed 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2155,7 +2155,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2173,7 +2173,7 @@ void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+             env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2183,7 +2183,7 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
@@ -2236,7 +2236,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
     uint64_t negx = is_s ? 0x8000800080008000ull : 0;
 
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_STD], negx, 0, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A32_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
@@ -2254,7 +2254,7 @@ void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
         }
     }
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status[FPST_A64], negx, negf, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]));
+                 env->vfp.fpcr & FPCR_FZ16);
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
@@ -2265,7 +2265,7 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
-    bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
     if (is_s) {
-- 
2.43.0


