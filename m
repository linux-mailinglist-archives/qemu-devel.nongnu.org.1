Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257B7E3385
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPJ-0008IV-Ob; Mon, 06 Nov 2023 22:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COS-0006ve-0L
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gx-4n
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:43 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so47703225ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326270; x=1699931070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlmvaxlY9UgjcMmC1xCbzus1zwL6bLCGJMO5gWkqRLs=;
 b=Uu6a+Yz0/xHITig+4XFllgz1mnlMYkosI7mOmVHWdKpJEF1slUKx3jRi9I59KfzBhG
 ApfGu/gG0iPzMpkx+Dm2/8YQp2XO3i0p9Ubv+7NyZXTbQCNB3WWJWrSlq64feqa3mv8K
 wzOWsGkTDQxN9vWiVtIvwT2CweMjYjUWznOxGsE4vakIhJWUjbk4Jn/Sm2rObqAijdgc
 QRao9NhQEOdxRtAFEDZ791zyd4SiMgT62MMZd5MSXpiLOMf+kvdNDJLMgd243RBgZDnp
 9+INjd6o1lcX5wCaAtoh5T252yT10uHEna/ff0eeHb5wEFTI5JJ9lkltgsljdGYNN0ej
 2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326270; x=1699931070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlmvaxlY9UgjcMmC1xCbzus1zwL6bLCGJMO5gWkqRLs=;
 b=rhrT0T+QH5iQa1oMBTpDJlPZCVF5N/hhE3AUhGFE206uUJmIpjqVBJ0HFvVygp4Zpw
 xynhU/omln3iHlPNlVTwo8BSKaKNEP9yWWG+1Z4XHgcar9udnS2sLxwZ4BDKcHqdmMg+
 7sZO5BYn6nCbuO23O7lLdU4TrDm5qOm8KxFr5iiMTQOtQiiVfvsoahpGAOs0mdda/bLq
 7rROCFwxfGcSdXhhX+JHeKa4iayNj6heNpqRBaTTV5bUqkOW0wNlM/JtMCLTf7X9WQ1i
 LQM/8GASWDiu6W/tLFw07YUJ4T9BjOd2mvomv7E+pDb4CPGL6CfrDERWCPGJpq19M7Nn
 lhTQ==
X-Gm-Message-State: AOJu0YzcOvr8Zz8o40YNiiE9vzQQPb8OleopqQpsVHN3aDVW3kUYH1EE
 koq/I8eKJcI8HneCvKwBxPYohjBQxJRHuULgUBI=
X-Google-Smtp-Source: AGHT+IGqsKo83btWlblvNrXg1eJXv6Q4GgW+QgeQ/ds+HhMDdrgQIui00SL2VFZY7NGUiWrFM2lnlg==
X-Received: by 2002:a17:902:d144:b0:1ca:28f3:5690 with SMTP id
 t4-20020a170902d14400b001ca28f35690mr28691841plt.46.1699326270462; 
 Mon, 06 Nov 2023 19:04:30 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 29/85] target/hppa: sar register allows only 5 bits on 32-bit
 CPU
Date: Mon,  6 Nov 2023 19:03:11 -0800
Message-Id: <20231107030407.8979-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index cf05d8b6e4..1694b988ae 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2176,7 +2176,7 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
     if (ctl == CR_SAR) {
         reg = load_gpr(ctx, a->r);
         tmp = tcg_temp_new();
-        tcg_gen_andi_reg(tmp, reg, TARGET_REGISTER_BITS - 1);
+        tcg_gen_andi_reg(tmp, reg, ctx->is_pa20 ? 63 : 31);
         save_or_nullify(ctx, cpu_sar, tmp);
 
         cond_free(&ctx->null_cond);
@@ -2237,7 +2237,7 @@ static bool trans_mtsarcm(DisasContext *ctx, arg_mtsarcm *a)
     TCGv_reg tmp = tcg_temp_new();
 
     tcg_gen_not_reg(tmp, load_gpr(ctx, a->r));
-    tcg_gen_andi_reg(tmp, tmp, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(tmp, tmp, ctx->is_pa20 ? 63 : 31);
     save_or_nullify(ctx, cpu_sar, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.34.1


