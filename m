Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648D57DEA27
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXh-0005hI-Fn; Wed, 01 Nov 2023 21:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0005c1-GG
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:38 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXW-0001X2-JF
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:34 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b5714439b3so243894b6e.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888629; x=1699493429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeA0a/Gb8/dUQrnhDd66G5WVnhzf9jbEb4csjTyLblA=;
 b=wADSRQ+fRsb6cmD1ZP9qL76zNb52oL2EGFR/zR4UnNVXco6Fx5A6Aedv1SrNuTJnJD
 wakJkTUtoBqvqb4zM6sjiHJrMGzFSpTtFUe2WkDynW+lDOxCdMNjfm7TOde9WpdMVwUZ
 9+sCVDYaz7anSmttZsQrHKd74TxNO/6vObWNX9XPNujplQHIym1AxGV9lkwnvPM4hL7c
 F2CmYn8n71J7pz3t8tpegZpRiZuLMrpKX81pDNTm3ekj/f3JZaqHXTJEVXxufQTuoSGy
 6jRCkaIPwcg6x3iYFiqpoy5WlsPPWmYf8AHFvI4ua0BNAX6MhoVKD0ACNY2EHEsjiwXb
 Mjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888629; x=1699493429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeA0a/Gb8/dUQrnhDd66G5WVnhzf9jbEb4csjTyLblA=;
 b=aDd8lcHVQx4Tatqny0S+a6G6mBeNVs+CbVBTgD57nj12PYUfzw7IfxwFGb5waLvafT
 snceWPLE2I5Cqm7Oz8fqTDEyrWoQ+RzZaZfqa4I2TyCj9SB7Q+LSuqzCzwJtBaWEm7mM
 A1RmwQq74/twCzfBnwPydNV8Of7eIjC+HZTDN6ROg9tK+O58vSzBJSdwIrINxs2hUIp4
 IuXv1SVwYdlL1TM3TvGgcAUq/ptN8RiTzSgjY6f2vBFxMepftiUQfZ+SgzE3lPXLPLk+
 Xt3J4oxtKy4PkLMNLJAViTQVsi3cD8PCcKZ5pE/fpN5V/KCTxY7RarZlO61C4eq1Ko8/
 VmuA==
X-Gm-Message-State: AOJu0Yy19D4+1K6E3yKvKSeFBrgL2ZRNsOCWbDR8EzeBaUDJeRHBG7TR
 UKr+HmUwN4ndYCx97xzHSXIXLYH0lHMRc5m14hc=
X-Google-Smtp-Source: AGHT+IH+TwSEP3sXTx+vjMcvbmX3Zp/w4kylC23l2M7i+ikopSGHshlqul38PUhQsa8tKYpsDKeNgg==
X-Received: by 2002:a05:6808:1304:b0:3ae:614:a782 with SMTP id
 y4-20020a056808130400b003ae0614a782mr18620419oiv.38.1698888629542; 
 Wed, 01 Nov 2023 18:30:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 14/88] target/hppa: Truncate rotate count in trans_shrpw_sar
Date: Wed,  1 Nov 2023 18:29:02 -0700
Message-Id: <20231102013016.369010-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

When forcing rotate by i32, the shift count must be as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 20e44ed528..d6ccce020a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3105,8 +3105,11 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
         tcg_gen_shr_reg(dest, dest, cpu_sar);
     } else if (a->r1 == a->r2) {
         TCGv_i32 t32 = tcg_temp_new_i32();
+        TCGv_i32 s32 = tcg_temp_new_i32();
+
         tcg_gen_trunc_reg_i32(t32, load_gpr(ctx, a->r2));
-        tcg_gen_rotr_i32(t32, t32, cpu_sar);
+        tcg_gen_trunc_reg_i32(s32, cpu_sar);
+        tcg_gen_rotr_i32(t32, t32, s32);
         tcg_gen_extu_i32_reg(dest, t32);
     } else {
         TCGv_i64 t = tcg_temp_new_i64();
-- 
2.34.1


