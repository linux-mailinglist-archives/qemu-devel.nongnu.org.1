Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E014F7DEA0D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:32:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYW-00062W-Aj; Wed, 01 Nov 2023 21:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXq-0005mi-9P
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXo-0001dO-4H
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso500265b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888647; x=1699493447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlmvaxlY9UgjcMmC1xCbzus1zwL6bLCGJMO5gWkqRLs=;
 b=qiwUXYx/W0Z13RljaDqgRYxfmufbNCF+bB7VIddFWrNptqda0sYxf0s/xrUxWko0nc
 iQC37zNUBZwQFUzAu2oViHvIEyeZCsscBtjQSUz3Iu9ZJN54ZZXxEVJL95f3ZP2rjsq9
 c4jRyluifzeExS2zhHo3iLGJh7xCDDE1KKVKEgglh9ijx7JFISc/t6Q2LPtOsy2NGn6S
 rqVuap9OoHoGUzDrSvROC2+Spyt9DjCoj+1ploJCZ3OxwtI6/btEOmCxpGOo8jqDykk3
 J5IsqyvNVRI9UBkjckykWJLhKvIgD94jLCNZzaRKzlMEw04QUaKcC8ArHa5F9sf/ctVG
 NtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888647; x=1699493447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlmvaxlY9UgjcMmC1xCbzus1zwL6bLCGJMO5gWkqRLs=;
 b=O3cGKU45lIYYzrGk9B87GF6GrarR2PA97JbxGfP26GpgYGVq9OwZXJBoaxuQhK2wyh
 DSgLTORmLbi2/zV18xXx6lCwV7dUUslTefRl9HurZ+XEQR/MIw49CZQHQgQKtDOgirTL
 wr1Sb78E8yyUIvg9Y0UWYIzgjljIstNTtCuZMK6eb7f+Bo/r0GxizmalalWaj6v+STOS
 oDPkmabNAZWhXNLCRfS7Arywc1RbZrWVTHzws/MOY+jHsUM8zYZ/EYa2ZXMxlCQvQV3l
 ck278WmvxBSVSdNzDzeXLLR9MaVhSfbK7NZOq6UX2xxOz6EUcNRKxobKiw5LgtBQHC9x
 aiog==
X-Gm-Message-State: AOJu0YzbcVVTMQOetQ8pbEIr4Md9gTr43BpVfFXCWvOIMi59+rcNJoI1
 5gVvQUxMkkauJuQFleQ8nIwh42LA8cSuah4Wskk=
X-Google-Smtp-Source: AGHT+IGraFL37779A0fEyqXuH0i3kodJHKHSlW17QYJYwUUUvsVqIyTy/iWue32BmgrWvxItD0NE/g==
X-Received: by 2002:a05:6a00:c82:b0:6bf:50df:2df5 with SMTP id
 a2-20020a056a000c8200b006bf50df2df5mr20242459pfv.13.1698888646711; 
 Wed, 01 Nov 2023 18:30:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 31/88] target/hppa: sar register allows only 5 bits on
 32-bit CPU
Date: Wed,  1 Nov 2023 18:29:19 -0700
Message-Id: <20231102013016.369010-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


