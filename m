Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFD7D176A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP5-00023k-73; Fri, 20 Oct 2023 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP0-0001zx-KR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOz-0001DQ-2A
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so1097609b3a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834844; x=1698439644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCTK88xBMWfzmeJbduNmhzzftWpNcH9Bxr7XmbIVZL8=;
 b=YjbxEmzZt/zxrb7CfWIjD25Q85GP5N3krRbvjFZOfYdTiWxxacblKkjjsdXdWPylHR
 oY5XZqWtIgHrJ9/rr5F0fF68PnAt4GAubVXW6OTHZCaqGj75xHB8iXNY5YAy44sThldj
 vqN2Kgz9ucaLDe+4icbxxcyt+4VnQWzCCG8u0xz7L1zLXQY8KQLICfAJGfNZ7eevE2xD
 +obgeJDHLYACzyOSHeZgv59obNeE6kHpgAOr7S1Su9KPozoiixr4OGEdgFDza/4zHpY9
 LNG8BQbt/bF91WQI+Mapf7u/vXNX5IRv/YYKjBCl7VdhTHBCXIbTX2pmj7I5GINQ0zTx
 1I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834844; x=1698439644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCTK88xBMWfzmeJbduNmhzzftWpNcH9Bxr7XmbIVZL8=;
 b=Hdzf60m6BMTovHXY/fbNSXKnyWJHYkm4ZEfANTCndrV6pzWnTkePsJj8E3+A9uTfGL
 nSkJsxkTdXECi352Vrv+xEgHg6JEvhllvFP6kBPN/UNkXkutRNB1hwBLQn3NGfg6p1KQ
 RjnVNPr155FOVh8xEXtTZtaK9gpdisIWduETKS7JI/F9IZeWWRMyH+cUHhu6WIYp7mlX
 iUk0vQCV9y0FpKhObgzhJAEGZ3+OnZ5rmSoiNLJl4IHAAus8J/Lb7knAnshWgZAkMdfM
 m1jHXaj+1vKRCL2SsWrGS0WrnrYiPzdsiY4Ij15CxvSw7gKLvUVb0Ye64QVcOivdMGTB
 FgIQ==
X-Gm-Message-State: AOJu0YzbLyr/EUfvZa1JsyZOruxysS4ivfVereRhZLGX8LY5WGCeR78m
 vLyCpARi97aK+ZwmXmzBqIFSRrn7l+oKNCamnPQ=
X-Google-Smtp-Source: AGHT+IEOMh+dGtmeduejz/EqK+OYyBRyNJmpByBBywhAIXg9pxkxNkcetH+LLyeTrWBwjIlmWZSwSw==
X-Received: by 2002:a05:6a00:2da7:b0:68f:fa05:b77a with SMTP id
 fb39-20020a056a002da700b0068ffa05b77amr2982313pfb.31.1697834843851; 
 Fri, 20 Oct 2023 13:47:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 58/65] target/hppa: Implement PERMH
Date: Fri, 20 Oct 2023 13:43:24 -0700
Message-Id: <20231020204331.139847-59-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  2 ++
 target/hppa/translate.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 323e9275bf..c8f4317576 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -238,6 +238,8 @@ mixh_r          111110 ..... ..... 1 10 00100000 .....  @rrr
 mixw_l          111110 ..... ..... 1 00 00000000 .....  @rrr
 mixw_r          111110 ..... ..... 1 10 00000000 .....  @rrr
 
+permh           111110 r1:5  r2:5  0 c0:2 0 c1:2 c2:2 c3:2 0 t:5
+
 ####
 # Index Mem
 ####
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 57761a7bed..a79cf52fcc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2918,6 +2918,35 @@ static bool trans_mixw_r(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_mixw_r);
 }
 
+static bool trans_permh(DisasContext *ctx, arg_permh *a)
+{
+    TCGv_i64 r, t0, t1, t2, t3;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r = load_gpr(ctx, a->r1);
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    t3 = tcg_temp_new_i64();
+
+    tcg_gen_extract_i64(t0, r, (3 - a->c0) * 16, 16);
+    tcg_gen_extract_i64(t1, r, (3 - a->c1) * 16, 16);
+    tcg_gen_extract_i64(t2, r, (3 - a->c2) * 16, 16);
+    tcg_gen_extract_i64(t3, r, (3 - a->c3) * 16, 16);
+
+    tcg_gen_deposit_i64(t0, t1, t0, 16, 48);
+    tcg_gen_deposit_i64(t2, t3, t2, 16, 48);
+    tcg_gen_deposit_i64(t0, t2, t0, 32, 32);
+
+    save_gpr(ctx, a->t, t0);
+    return nullify_end(ctx);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


