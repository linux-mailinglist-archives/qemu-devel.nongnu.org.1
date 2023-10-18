Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 609797CEA7B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESm-0001z7-RW; Wed, 18 Oct 2023 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESL-00018s-8U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESJ-0004Qw-Gp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso4677528b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665914; x=1698270714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGDc36lTRQBdhZQkVmDvdtL0QhZmZu6PdPoUP7sd7r8=;
 b=JyXQtQsOMxFSd5Mxfs9hY4yueiVg6NpOyncv513blOTqoKCy0/MMxkC9T5jzf63iSv
 fjaj7PyrkBIuYKB/rxViAZfN1T931RdYVc7+hzJ6goPalEiZyiErWXLuAHKJWEHnLoC1
 R69fwuezVcD5eDiT/KUxnfy8/ejpkzozyLZrg85xZDsYThjlQdNd786j0OPSI3PRzYG+
 NRL9nhjL8vex9cKIMA7CxSFH8vaSIPM4TRMxT1laGtVbf5pLl+9yWKNeQJieTQaSz/sf
 yPNqThE7FL1Dd3xruX/XDWW/bk6+ifwEIcyyQIbLcZSf1u5pKVZbWcOZslGRGybt5ynH
 SaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665914; x=1698270714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGDc36lTRQBdhZQkVmDvdtL0QhZmZu6PdPoUP7sd7r8=;
 b=s116RtT1sM+l4/LKIDAT6a8+LL3Fw9a72fEPmi933hM/W0EsreSGgUM+q5C7rX+gkB
 qJSzRI0OiyzDO/iicHEDuRzVfIy6N30ykmDmfxpUZj/53eWqMpr+6L4KJMOTs3Y9ncUg
 6gTjouNbVp6nMHeNUx5AXXj7cHZRodeKN36tZ1oYBA8CAfTVInrMkyekkkjNCoohpYlK
 I2DCDKfobPvSx02P9ymTVkCW5bPnaEnrvv5wn479VGYVuyTCR89qKmTQfhpKfuHQjosk
 rdF8Yupli3dtZu5YvjT9uir3HT9Sjapc8LPho4wYS2kKKbjcOdMJvtqL3aWiO4SPvK1m
 YZbw==
X-Gm-Message-State: AOJu0YyJBUwXuC6NuLz5BJgFhW91Q0daeVm1vIR+m22MSwx1YHDl/zUr
 DLwZ6aDklqjac18g7OoVgRWNI0wJbmy+qrhaOBI=
X-Google-Smtp-Source: AGHT+IGY1/0H/YhgR4r3ZRahYmGlmzSo6MjIN0To9YHigpUkvDMMhtdMZKlh44KxRBVq3+N3DKqihg==
X-Received: by 2002:a05:6a20:6a1f:b0:162:ee29:d3c0 with SMTP id
 p31-20020a056a206a1f00b00162ee29d3c0mr393529pzk.42.1697665914139; 
 Wed, 18 Oct 2023 14:51:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 21/61] target/hppa: sar register allows only 5 bits on 32-bit
 CPU
Date: Wed, 18 Oct 2023 14:50:55 -0700
Message-Id: <20231018215135.1561375-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index ace6fb0ab2..e2b692a6c5 100644
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


