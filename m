Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B17D178E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM2-0007yH-Tm; Fri, 20 Oct 2023 16:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLh-0007kb-H9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLc-0008Bt-Qa
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:00 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso1102640b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834631; x=1698439431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKFMtzklc2r0hLRnVa0CHOkIqsensBgIOA/UoJLswZ8=;
 b=n+vv0XYaVqyTsUQorrO2xte/AXynlK78uJjPYUpgjDxEPO89urosIvSTgz1f4112vD
 z5Fp61HzLGZ3p0QdtiffK8EUo5yqzCoOUFZW8qxDZ298JKb1mmhheEioGdWiypadY0mj
 Ma2eptDMgYc+ohB7TlYp6a0eaqmAHjCCfMkuFjl4I+AGog9A3erHh1qszZdHhzXvWm87
 BBBE+KGL7YJ4prU8496zDifMJhXCF77wttrGJadV54zf0/KBnGXwedeDRZWzuMJACiJN
 pSku9bvyI4/6MUMIhoB9qaU94NOYbXHoPJldWI8lCgvpAWhARbrMsNyhPuz8pDouEMPF
 qLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834631; x=1698439431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DKFMtzklc2r0hLRnVa0CHOkIqsensBgIOA/UoJLswZ8=;
 b=MZE+Z/lxQ1gMMFH97VkJ1NnyAKZGr0I/+0f73vBru1ldx6ZqUfzzJ47cDngMkmnAXR
 3x+W2m+Z+3LvIGBslHfzO8vgMlExCCDmmP8WHHzTEDJrhjoVO/ZY07FkQrTB5cvb1ZCC
 RhzFcgomynAZ33FpVh1SLY2KZPNusV2Dv+yO8ErZKx72I1/NgUPKq7IypXrSJNfCaE1N
 I2AMnnR/aoZZRXLA2Rm/tWyOEzNr0GqhnAHhqOy7FuphKqMMNKBmPbeCI3mOnrG6qWZD
 Bx1xN1U+hI/3Q0wMyag9dDxMxVGHSNnuO2540DOXhmBoct+ep6AJqDn3cUg4v3ZeelOx
 Gazw==
X-Gm-Message-State: AOJu0YzU/wrJrgJluJBEyjd9pfLph5Ix9+Lhizv8kld0JZP9vdhPxg5o
 2yaFEh9hfK47FlSG8bQtjzDm0xKxnwU6v7vUklI=
X-Google-Smtp-Source: AGHT+IHsArr4eNcWg5ZDi9MKJsqplA/+pJkOd4kenAcVTUBX+3f1XOMOKQVad0FtSDFV7hRYW9GHyA==
X-Received: by 2002:a05:6a20:cea3:b0:174:af85:954b with SMTP id
 if35-20020a056a20cea300b00174af85954bmr3091205pzb.22.1697834631577; 
 Fri, 20 Oct 2023 13:43:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 21/65] target/hppa: sar register allows only 5 bits on
 32-bit CPU
Date: Fri, 20 Oct 2023 13:42:47 -0700
Message-Id: <20231020204331.139847-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The sar shift amount register is limited to 5 bits when running
a 32-bit CPU. Strip off the remaining bits.

The interesting part is, that this register allows to detect at runtime
if a physical CPU is capable to execute PA2.0 (64-bit) instructions.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c7d17900f1..cb60485cbb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2155,7 +2155,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     if (ctl == CR_SAR) {
         reg = load_gpr(ctx, a->r);
         tmp = tcg_temp_new();
-        tcg_gen_andi_reg(tmp, reg, TARGET_REGISTER_BITS - 1);
+        tcg_gen_andi_reg(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
         cond_free(&ctx->null_cond);
@@ -2216,7 +2216,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     TCGv_reg tmp = tcg_temp_new();
 
     tcg_gen_not_reg(tmp, load_gpr(ctx, a->r));
-    tcg_gen_andi_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.34.1


