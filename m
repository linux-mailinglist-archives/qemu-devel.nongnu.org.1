Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5897E333A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9U-0008Sp-8v; Mon, 06 Nov 2023 21:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9R-0008R8-Pr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:13 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9Q-0005wr-8q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:13 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b2f5aed39cso3072441b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325351; x=1699930151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1m1R0D87bh0NujvmTIskCL5xHsf6reFL+x/VSt/CM8=;
 b=Zeqx1qG2ZZFXVJ9RGwlPkEvXSRclkIPDym4me/maU1ME5ajAzaxeiGm3c742LYAZox
 Cbo8xGV6yTmhXoxSHZwcDeCF6nlIWGDP+eSK5tTniz/y17ZnN0T46gZbph73bVWWiCjk
 ks7oV1tnCDluV3xCcFWOVRlIuR1ny/y06ueFFhwKhiK1XcJGtDQVsinUo/M61TK38Yso
 k38+H8loA5Hrp07GE9JnYQVIIWRcnLw6pVsF3vXa/gYmOXMyzHz/dkqgjVrxqqBCY1rg
 d6tCKkiHxtus+z7hCIHAwCvyddvQ8H06eSLP3lnr99C7R28ltHycgV3ffAx2u8C8Jfai
 +viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325351; x=1699930151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1m1R0D87bh0NujvmTIskCL5xHsf6reFL+x/VSt/CM8=;
 b=Lt7DRrOxFf0AAiAjhd2tQAUeS4vK1WP875/1FUma7bIDR6/wfKpr7UtMziR5kIv42o
 VsdK+mJN4lCkBoLknZXZoMUpf6aTG0lRa3N67N0AX9VPO1QcSBzG67kBPXJsmtZgiRF9
 2MtG2jbRF4gww0GVquuj0/5CD9nG+xaoDJ/yJve+rbg4me2ylDJSmlYMnqYgHwCbZUI4
 H7DPL9f0KdJoUJfRYtKIIhmdvOwDL4BrloHLZxaZH1UBfwlEHfSGrhcqL+IAJ9GUiLr2
 8g6tqWVrC7gv4F/6hZx4TcHYm01mHCuLIEzKRPjzjACQxokr9Dipg41UJP8YNVY2DTlJ
 bSNA==
X-Gm-Message-State: AOJu0YyY2UkmpDtuep2mLFbXZgMdVJoT1Oth4J2H8Xw37EuWCLfM5Twn
 AckIvmj4Z13VFXHdWL8joFepVvx9M9uzz9sNTsg=
X-Google-Smtp-Source: AGHT+IFFEPzzoXJ/P2W9JH4JdpklQJHsVZn8J6BPGrL5OCJ+cU8mrbI3TzmKu34GEThoXHVtCTBpwA==
X-Received: by 2002:a05:6808:1385:b0:3b2:f54b:8b3a with SMTP id
 c5-20020a056808138500b003b2f54b8b3amr40354171oiw.27.1699325351348; 
 Mon, 06 Nov 2023 18:49:11 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 34/35] tcg/optimize: Canonicalize sub2 with constants to add2
Date: Mon,  6 Nov 2023 18:48:41 -0800
Message-Id: <20231107024842.7650-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231026013945.1152174-4-richard.henderson@linaro.org>
---
 tcg/optimize.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 468f827399..f2d01654c5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1044,8 +1044,10 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
 
 static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
 {
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3]) &&
-        arg_is_const(op->args[4]) && arg_is_const(op->args[5])) {
+    bool a_const = arg_is_const(op->args[2]) && arg_is_const(op->args[3]);
+    bool b_const = arg_is_const(op->args[4]) && arg_is_const(op->args[5]);
+
+    if (a_const && b_const) {
         uint64_t al = arg_info(op->args[2])->val;
         uint64_t ah = arg_info(op->args[3])->val;
         uint64_t bl = arg_info(op->args[4])->val;
@@ -1089,6 +1091,21 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         tcg_opt_gen_movi(ctx, op2, rh, ah);
         return true;
     }
+
+    /* Fold sub2 r,x,i to add2 r,x,-i */
+    if (!add && b_const) {
+        uint64_t bl = arg_info(op->args[4])->val;
+        uint64_t bh = arg_info(op->args[5])->val;
+
+        /* Negate the two parts without assembling and disassembling. */
+        bl = -bl;
+        bh = ~bh + !bl;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_add2_i32 : INDEX_op_add2_i64);
+        op->args[4] = arg_new_constant(ctx, bl);
+        op->args[5] = arg_new_constant(ctx, bh);
+    }
     return false;
 }
 
-- 
2.34.1


