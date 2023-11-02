Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27F97DEA0B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:32:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXj-0005iP-02; Wed, 01 Nov 2023 21:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXh-0005hs-7r
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0001ZC-6d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso382112b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888636; x=1699493436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBkHVGjqIu3LTEV2zzgvwaws1GKhji4cesKfRpz1I/k=;
 b=ua+mQrmmJjck9B4ZG64z/Bxmt97A3n6uyO8u/0jvXU4sR1HNQ/UtWz9LC6ZYYcpaGE
 s7XM4F8EJ75dRB/ahrIEk93VOx7LJpv+D/3cVXgi59cH9p3Z/NJzc7TNPSvbT22zwKp4
 tzS3ZIp0+GaiB4r3AfTV68fm82en0r61XZDxTRx7+jjmc838a4xu9zSI5/1UCEAYwtQ2
 7DHma6C+3UmJKuHUvrjdFPKxueSOezO2IyLTBQ+nmjHgTyx1VBhEw+9nzknqaoD1cENv
 jkOjfcQmpbGcJmHyN4Ur+taP3aSSGMFJ5lUb8gojRXgxnqyEMgqYkALLknm7JJ/DHiei
 ++Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888636; x=1699493436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBkHVGjqIu3LTEV2zzgvwaws1GKhji4cesKfRpz1I/k=;
 b=u4Z2TOErNK469fu4ILyfuKC6hf5udkFu75rcNi5pQo2/VdO6baIuUlp1Nb+sKnPW9P
 yOY/CRrDcxYQabmE+7CrlzwazWrj/XyPIJh0JtTFiE+o//qhDUsDdzwcszoQ6Wj+mF6b
 nONiSMZuXbAYyRp5hNltbTkEzqOx//ZF77ZO8rcIwBzNV/gAW0BsWMsv7zub34t+OxzB
 uamiw7aOKzTknwGu2hJrRy/87JjFbcSmIKyUT+I96Ed86TvOpm5ZGjPqi4ZrrEr5Kt9W
 Au6MjwB9BGwqMyLRvogb/nV+Yd6sA9kq1FEAZ1kaUbsdqzpOb2z86ZyFS3tnqPbutt6N
 KBxg==
X-Gm-Message-State: AOJu0YybLgNEjMi1tDexa/Fdre4mqnw3Y58vEZMUxeyXqH5VlMNn3jLz
 xsdH5i0XMHpjU6KBDB+5cGWZZlptU55j8HnyGcI=
X-Google-Smtp-Source: AGHT+IEHzWXNZs3QZXaWYDC1XkJlE7Bl7Dwu+8eBHUlS16TNaJczpBZ42wiQ48MtovOWZAgoyVe8OA==
X-Received: by 2002:a05:6a00:1f13:b0:68a:48e7:9deb with SMTP id
 be19-20020a056a001f1300b0068a48e79debmr6582000pfb.2.1698888631779; 
 Wed, 01 Nov 2023 18:30:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 17/88] target/hppa: Fix bb_sar for hppa64
Date: Wed,  1 Nov 2023 18:29:05 -0700
Message-Id: <20231102013016.369010-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
---
 target/hppa/translate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b0cd12a2d0..ffa367b91f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3073,14 +3073,21 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    if (cond_need_ext(ctx, d)) {
+        /* Force shift into [32,63] */
+        tcg_gen_ori_reg(tmp, cpu_sar, 32);
+        tcg_gen_shl_reg(tmp, tcg_r, tmp);
+    } else {
+        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    }
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3088,12 +3095,15 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
+    int p;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shli_reg(tmp, tcg_r, a->p);
+    p = a->p | (cond_need_ext(ctx, d) ? 32 : 0);
+    tcg_gen_shli_reg(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
-- 
2.34.1


