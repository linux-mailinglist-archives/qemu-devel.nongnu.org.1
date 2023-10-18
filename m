Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E07CEA9A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:00:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVm-0002Gq-NQ; Wed, 18 Oct 2023 17:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVk-0002G3-T4
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVj-00057s-BA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so125255b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666126; x=1698270926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iHWuCbXcxtsog6Wn/6KwP1Awc1ANERXzKnjfdaTViQ=;
 b=DR1k9OB+d+8E9zg50Iwdtk0DA1ENq28y5Dggn0JsULl2wrlVan86cJTxudcEBHwPvL
 5e2ziTLZZ8FVzMJ6OZmd98XREArLcbKOsUufNwgPqYlWuml6JWi7wGGAzAedbgiJhESQ
 7JLzsgYzeI4yqJa2uJOkDib2JLkTda+8yDnmUv/xRvb/DPCRg+w+WjMPbpRXf1EeOF/Z
 CxYPb+cYhna704b+87PjFihVKj+dAqXvT4NUorbW0DDdQWkATL2AyM4H6Q6bmEh3Vd6A
 T8EJ5oLQqcSoVsUwc0oEBdVTA9rn9UI3JSn1Tb919raHSt7vFPCGU9TkqK2BqIrYoZx0
 rcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666126; x=1698270926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7iHWuCbXcxtsog6Wn/6KwP1Awc1ANERXzKnjfdaTViQ=;
 b=ZqH3n5XMinIEiBhpalsRlb1CdN4DiOGOiBoxSpR/JLYou5iygDjOjWWo8rdzqlKTUp
 agvGesWBDAYOX5SDYq2vnSlEcinLytxa8rw5RY7+pyBzQJmpjooEzoGKIt+njzsOfOZu
 nC9VzJcLvhQvT4jFtpwSiy103rkb9jatj94aiHi3C7mnmprkVhJe3voh8pHFdZyhtvgA
 ithnaJfVv68SnDzSlthsPDBhN7d2+oksJYGyrOSPG9Z50MSFsBXwcd7hphwADXT7GXYz
 25LY1SZM2jMhwxsZBoTztICawrw4STuUshDTTS9Pe9AzexfwQ2ShAFIFySRZDxRZ2dV7
 iYuQ==
X-Gm-Message-State: AOJu0YzQnVmFVndJgY4Wh/+5WJO+3XaWPezazdNOE4UuS2cgCwnomVMu
 NCSh5D5sZGD43E8mu65P/r7Iz3fNOhCZfQBqJ20=
X-Google-Smtp-Source: AGHT+IFLnxLa8rFwoum5nz0N7XXrDxCjhaGLJsdIwr5GwyDdmtwyZvHg6XXnfjGq1LcWKcPyObUs0A==
X-Received: by 2002:a05:6a20:4424:b0:13a:dd47:c31a with SMTP id
 ce36-20020a056a20442400b0013add47c31amr132734pzb.20.1697666126014; 
 Wed, 18 Oct 2023 14:55:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 57/61] target/hppa: Implement PERMH
Date: Wed, 18 Oct 2023 14:51:31 -0700
Message-Id: <20231018215135.1561375-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index bd8a858da6..40b5a3d8c3 100644
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


