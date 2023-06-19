Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65926735B67
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH3h-00061k-2d; Mon, 19 Jun 2023 11:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3Y-0005LC-MQ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH3L-0001Dy-PO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:44:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31122c346f4so4033790f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189464; x=1689781464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEPIN2fkA0XgNRhE78YRhKSUuhDAdH/pZRKK62jA57s=;
 b=WHl/d8SIbkOaqmMh7WSfL+gQmdI/xKJeeVNTeAPTOOneoUjn2do0L2ULMyBppu2Ml3
 VaIHKkfjP1aCJIINOg3Kh9NbPjXPrwRrfolzJdxzh1ckAuLbwXUXN94eP0f6RZDTiX8U
 HREB+BKu9+lfSfNf0AtbJJjIfU7Mx/PSHqFZQqFvbnx5l7HYxtcTvm+BfbNGOASYEuJL
 LpdWWGrL1LO45WplS5CwHZNE0c8S7gxMNdR5LsmI+rcJRkPTlLI9UwT4hnvDZymtn+AY
 sggYC4X+KCjYC6j/VW4snNuu5BOvA9D7wZEbJKTz+yOPOuEvPixVa7tvmo/oI7CKlrvM
 WEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189464; x=1689781464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEPIN2fkA0XgNRhE78YRhKSUuhDAdH/pZRKK62jA57s=;
 b=WhTgMJRQlMnGnm7Q6KL78lWMTuEzjkUdqvxLmytITTB/rMsj/qSXzAbnM2XGQorHuV
 fBjM/n4/K7fGHo1pJ4TKuyz/tU3zbw5BAF/oRoQ4tZfUOsBEs0uyuqhrIgTdDuvSQzAG
 GgVJ2oT67iiflBgbWqmT9uC1HxSA+F1sByEwXrPcJlpiwRq9Jpb4fNDxuC4dhl8Ad7jb
 rA6pJGTN1rKLItSploOCuqUYBMEbH6vIxqb4ROWlj9SUIQKL+/PKHwqi75twMyGoeoDp
 D8Nb+0oVSTvkoyeHJbyj54dQx77pqgpOWKic+uNb5J5lWolJSOuVzGFxDdnLxXbHx/wP
 jMFw==
X-Gm-Message-State: AC+VfDx5Qzhxo98ig1XFfzA/96etUa0viTpzEFyODulyhwGE0avcMjwi
 ct1XS7hjX4eagHsP8Xis6sA7ztaoUkVWM7Q+GfhSGQ==
X-Google-Smtp-Source: ACHHUZ7cJ/Bw4OkFEPkphQXAp4xeokOOq8hW+m91vX0nEb1nYxjHzedNjlCAJiCYbNSBYJdL08pkPg==
X-Received: by 2002:a5d:6987:0:b0:310:b979:d00f with SMTP id
 g7-20020a5d6987000000b00310b979d00fmr8864661wru.45.1687189464409; 
 Mon, 19 Jun 2023 08:44:24 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 z4-20020a5d4d04000000b003112b38fe90sm7431715wrt.79.2023.06.19.08.44.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:44:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/34] target/arm/tcg: Un-inline VFP translation helpers
Date: Mon, 19 Jun 2023 17:42:36 +0200
Message-Id: <20230619154302.80350-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to restrict lookup_cp_reg() and set_rmode() helpers
to VFP translation, un-inline gen_lookup_cp_reg and gen_set /
gen_restore_rmode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.h     | 22 +++-------------------
 target/arm/tcg/translate-vfp.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3d7c55d3b6..d2a98b9f3a 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -680,29 +680,13 @@ static inline void set_disas_label(DisasContext *s, DisasLabel l)
     s->pc_save = l.pc_save;
 }
 
-static inline TCGv_ptr gen_lookup_cp_reg(uint32_t key)
-{
-    TCGv_ptr ret = tcg_temp_new_ptr();
-    gen_helper_lookup_cp_reg(ret, cpu_env, tcg_constant_i32(key));
-    return ret;
-}
+TCGv_ptr gen_lookup_cp_reg(uint32_t key);
 
 /*
  * Set and reset rounding mode around another operation.
  */
-static inline TCGv_i32 gen_set_rmode(ARMFPRounding rmode, TCGv_ptr fpst)
-{
-    TCGv_i32 new = tcg_constant_i32(arm_rmode_to_sf(rmode));
-    TCGv_i32 old = tcg_temp_new_i32();
-
-    gen_helper_set_rmode(old, new, fpst);
-    return old;
-}
-
-static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
-{
-    gen_helper_set_rmode(old, old, fpst);
-}
+TCGv_i32 gen_set_rmode(ARMFPRounding rmode, TCGv_ptr fpst);
+void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst);
 
 /*
  * Helpers for implementing sets of trans_* functions.
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 359b1e3e96..4bfd857141 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -28,6 +28,27 @@
 #include "decode-vfp.c.inc"
 #include "decode-vfp-uncond.c.inc"
 
+TCGv_ptr gen_lookup_cp_reg(uint32_t key)
+{
+    TCGv_ptr ret = tcg_temp_new_ptr();
+    gen_helper_lookup_cp_reg(ret, cpu_env, tcg_constant_i32(key));
+    return ret;
+}
+
+TCGv_i32 gen_set_rmode(ARMFPRounding rmode, TCGv_ptr fpst)
+{
+    TCGv_i32 new = tcg_constant_i32(arm_rmode_to_sf(rmode));
+    TCGv_i32 old = tcg_temp_new_i32();
+
+    gen_helper_set_rmode(old, new, fpst);
+    return old;
+}
+
+void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
+{
+    gen_helper_set_rmode(old, old, fpst);
+}
+
 static inline void vfp_load_reg64(TCGv_i64 var, int reg)
 {
     tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(true, reg));
-- 
2.38.1


