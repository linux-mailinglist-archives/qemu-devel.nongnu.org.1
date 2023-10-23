Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFE7D3BD5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVS-000164-Ic; Mon, 23 Oct 2023 12:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVK-0000zp-Oa
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVH-0001dy-Ts
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4083f613275so28729795e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077405; x=1698682205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLtOMzuv0VPHT9a9CaWKn6byerFC4jGbzx/kTIVLUc4=;
 b=lngf9Pmfuuj1TvMW0n1He+xaLJAT6ND1xi8ubpoCT0jVecp9EKyBV/eqiyW3eE7qn4
 q0HaRLGUHyqurMeRNhoQZM73/RFjOmCTHsiewn4sasnq709HTl4k1JeMJl8oDpDRewmU
 hjSAhw5B+uV7Q/DqsQ4Yu++/5wJ9/lI05ydreY30h0UCy4/2oiAV4LZlrbByQX3A4BbL
 l2rsgL1e8bZ16jCWrhso3gmlftrMIZQdpJu6iJkua636FV2AkDw6ua5KkOU535zDocon
 9Ww4e8cKGPRANz8pUciAxSYqmVIb6nNUxBnRhUyjrKvul80GeZ+LOmkNMgWXMLUW7ahT
 Ev+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077405; x=1698682205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLtOMzuv0VPHT9a9CaWKn6byerFC4jGbzx/kTIVLUc4=;
 b=RH+Eavog9lJEmyvvhXxpGWL+zfd3gFf8K6NVwVlC8nnJs/Dbl0HYjzwcetjuYCN0He
 B/+kKElKl5pLwm6Tckz1k8uXX8kuKEkBp0AMDsQKdUZ1pfPw94ohKgX/w4sUp+2xKp5s
 ejsyXOz5pRvX24syQFVOqBLhSWfAc1IYpkqgfSpBp7jDXL0CR3u3hLNKM5NURZhQ/tIj
 6895dIC8RTYo8ZDtWivNghJ2EQVFWWWF2LYyCFOemwbLJJv2XhO0Tw0GcYsar+rrNnV4
 lC9uj3lx5WMlVaBOpA7+Vbwfqbe7+aIjjkN7/D8kVGON7DneUa8raEUiboaqreGo5lk5
 N22A==
X-Gm-Message-State: AOJu0YxKHI6Fdm7phtvH8qtVmmrbgLyslHqDox63CLVBt0W7lfh+fWF9
 v75KBT4XxN1wFTjbu1PUM24n7bzi8oxEIBL38f4=
X-Google-Smtp-Source: AGHT+IF0/HQDXxUND6G4f3fLMuoouTBRZ1G64EWp1slzKf+qKGrSxCRzjpccDU56gLLMVjPc1ml4eQ==
X-Received: by 2002:a5d:5c0d:0:b0:32d:ad8b:29fd with SMTP id
 cc13-20020a5d5c0d000000b0032dad8b29fdmr9502431wrb.11.1698077405487; 
 Mon, 23 Oct 2023 09:10:05 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b0032dab20e773sm8060112wrm.69.2023.10.23.09.10.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 3/9] target/mips: Use tcg_gen_extract_i32
Date: Mon, 23 Oct 2023 18:09:38 +0200
Message-ID: <20231023160944.10692-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..2586d9c85a 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1269,8 +1269,7 @@ static inline void gen_load_srsgpr(int from, int to)
         TCGv_ptr addr = tcg_temp_new_ptr();
 
         tcg_gen_ld_i32(t2, tcg_env, offsetof(CPUMIPSState, CP0_SRSCtl));
-        tcg_gen_shri_i32(t2, t2, CP0SRSCtl_PSS);
-        tcg_gen_andi_i32(t2, t2, 0xf);
+        tcg_gen_extract_i32(t2, t2, CP0SRSCtl_PSS, 4);
         tcg_gen_muli_i32(t2, t2, sizeof(target_ulong) * 32);
         tcg_gen_ext_i32_ptr(addr, t2);
         tcg_gen_add_ptr(addr, tcg_env, addr);
@@ -1289,8 +1288,7 @@ static inline void gen_store_srsgpr(int from, int to)
 
         gen_load_gpr(t0, from);
         tcg_gen_ld_i32(t2, tcg_env, offsetof(CPUMIPSState, CP0_SRSCtl));
-        tcg_gen_shri_i32(t2, t2, CP0SRSCtl_PSS);
-        tcg_gen_andi_i32(t2, t2, 0xf);
+        tcg_gen_extract_i32(t2, t2, CP0SRSCtl_PSS, 4);
         tcg_gen_muli_i32(t2, t2, sizeof(target_ulong) * 32);
         tcg_gen_ext_i32_ptr(addr, t2);
         tcg_gen_add_ptr(addr, tcg_env, addr);
@@ -8981,13 +8979,11 @@ static void gen_compute_branch1(DisasContext *ctx, uint32_t op,
         tcg_gen_extu_i32_tl(bcond, t0);
         goto likely;
     case OPC_BC1T:
-        tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-        tcg_gen_andi_i32(t0, t0, 1);
+        tcg_gen_extract_i32(t0, fpu_fcr31, get_fp_bit(cc), 1);
         tcg_gen_extu_i32_tl(bcond, t0);
         goto not_likely;
     case OPC_BC1TL:
-        tcg_gen_shri_i32(t0, fpu_fcr31, get_fp_bit(cc));
-        tcg_gen_andi_i32(t0, t0, 1);
+        tcg_gen_extract_i32(t0, fpu_fcr31, get_fp_bit(cc), 1);
         tcg_gen_extu_i32_tl(bcond, t0);
     likely:
         ctx->hflags |= MIPS_HFLAG_BL;
-- 
2.41.0


