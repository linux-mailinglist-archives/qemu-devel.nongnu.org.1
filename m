Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC757E3349
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C98-0008Bj-Vq; Mon, 06 Nov 2023 21:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C93-00089r-Rf
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:49 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C91-0005pW-7R
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:49 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3b40d5ea323so3086458b6e.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325325; x=1699930125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1z4N/qwKWQYmS9hD74R6ggk/haC3cfKAEj4YRfVn9dM=;
 b=dbUYSA/YZqDXnJfxk0NDTPVSmK5CidARLsYBEyABUQsQLR/240hYWGNKsilWczVtSK
 zbdQWi8ppnS5+xTsRXJGVYmkOin+pQRo9idk/mIEUFOWN50tSmrFXQqUi1Z93TwwBe/p
 4i+cvQEoOOKC7RSs9ztPLl1k2P7VOIwUSnJvoQc5Hq3M0x+ZQxadJG4uAIp5gEcq5XAR
 QYkmetFcCr9hn6rSH3N/dAaQG3Q4fL10YmJaCnRjg9gnbr1Jpobpi8h3Ejp5Ctxb12hq
 h7u92dgt12A9pzQOSISZEQR2ESDApUq38k/68OTPXVt/ZZwzdKlOPhZom4Z1GYz5D7q/
 RMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325325; x=1699930125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1z4N/qwKWQYmS9hD74R6ggk/haC3cfKAEj4YRfVn9dM=;
 b=WQaXshF6DcEDM8SisWcPo+H1wHwLL5nj61F16hl4zWTFgjYzylXfzSaT5HuYyl/fNJ
 zDLesSEkf9ECWlwr53l7fNhNKF7iwiL9uHTFShv1eYSvA8D2DN6NMnbt7oQahFmXTztQ
 Du+aCzrSZlru8PLMDHgZxcpLaDAEI+qfobAH7QYSJr/cK4iKO1FNtgd5mXh3UNcDzM29
 FNhMpHH36xLx6jbePbqiH/p4NxHGx7Yiow5x4LqOpJh8psKpT0CqHSzWrOcEvFrx0g+o
 TZnVtYibHHjxYIVEGL4/u1ojX1r23VTMBNIP+whOI8b7SsDEVHhnUf3hZurWdcSTTHCS
 scPw==
X-Gm-Message-State: AOJu0Yyb9Mf9wjzFZHwm/KVJL7pXSIdpg1FwTTeZgLKQGRdD6pwNyd2k
 GTavxk4rSQUMsbXxLJku4ZQztccYdTQ/WjNXxaU=
X-Google-Smtp-Source: AGHT+IHDXTRjfdAqgD1IrnqOGdSaEMD24BnKgxNCXzbC6nXurhcoxvSbGBuX7uU9cnPYemLpY4CGhg==
X-Received: by 2002:a05:6808:20a8:b0:3a9:cfb5:4637 with SMTP id
 s40-20020a05680820a800b003a9cfb54637mr33699569oiw.38.1699325325737; 
 Mon, 06 Nov 2023 18:48:45 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 02/35] tcg: Add C_N2_I1
Date: Mon,  6 Nov 2023 18:48:09 -0800
Message-Id: <20231107024842.7650-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

Constraint with two outputs, both in new registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiajie Chen <c@jia.je>
Message-Id: <20230916220151.526140-2-richard.henderson@linaro.org>
---
 tcg/tcg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 847d749a7e..6766b60b8a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -653,6 +653,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
+#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2),
@@ -675,6 +676,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
 #undef C_O2_I3
@@ -694,6 +696,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
 
 #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
+#define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
 
 #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
 #define C_O2_I2(O1, O2, I1, I2)         { .args_ct_str = { #O1, #O2, #I1, #I2 } },
@@ -715,6 +718,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
 #undef C_O2_I3
@@ -734,6 +738,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
+#define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
 #define C_O2_I2(O1, O2, I1, I2)         C_PFX4(c_o2_i2_, O1, O2, I1, I2)
-- 
2.34.1


