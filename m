Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA27DEA30
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbT-0006g2-Am; Wed, 01 Nov 2023 21:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbE-0006br-LK
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:22 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbC-00025H-87
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:20 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5b8c39a2dceso292149a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888857; x=1699493657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkyljCZpqzWzIh5N8Q5xG0nF40yxIPLXLpPcj7wj9PI=;
 b=qXjXhsdGFvQ/sM1V69tlwpAWY6CkRTB4YQTMArYz/1dRLijgjm8AdkPL2wrTXS66Pt
 5ojtPYcNp+uaIijBTo7GVlM7L++iL5HfnOywGQ1B3iPRJTC2N5htDjRVeeajrXrNgZC2
 vmTRAVd74FQHBiWDdZbtF9yiVK2B79TS9YcVRb+UOO60JCbAHaG6mK+/lUKKqCYYtFzB
 gJQuO64+CnNalwMBPbII8DoG5DiTH3d9OO2Ho0nJ8yPzphub0mlOUJqPBToFC773LZYp
 b2ZMGXKz1y8qw+Jk7xfbpuflkCLEMCW+zvnYixU9JvkcuipktCdonUJWof+PnLcGqXgj
 YIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888857; x=1699493657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkyljCZpqzWzIh5N8Q5xG0nF40yxIPLXLpPcj7wj9PI=;
 b=g6HmzOZumAFP4sT3a8kYgRKFZ3PCs54hL2/Wfqzppd/iX/Os/mMxw+DtA0BgsbZkhU
 xGq+GWc5al1oa1xKfhAKO9L+jl9z9sgs57pEpKckQ9T+E11VaYiNHOQBurXlGbrr4D1q
 NbtHp4YOo7yhT1HEWVutQmHDMT3CGdXww9ALZhIxYw85uIFdepby2gsw2ePyI0ZDMyju
 Z1UnrH5hVN57nleoBINSCYbfPr1k+LATF/xuHOvIMWwBW35vA4r+5u+c/JHkBDYd8C+r
 q1u9V7UswHShX7/KTD935o7uHnT7naMT8+d62hNoVV93BsoKyctvlZD8JGH4kXgvqjxR
 4flg==
X-Gm-Message-State: AOJu0YyPHyJzgwG0CMYaAQfRUaVX6xjVEsAM7UMjEUmo8GUuSLKBOfKP
 sj+bWb7jwdrkqVgQecwISkUAxGB9IC8/FMwIi9w=
X-Google-Smtp-Source: AGHT+IEbXcsWmXo2aP0d+F0cJGW9p7JmAqoVTE9FSS8aX2KRv1VVjuDuu/QSlH3TDU2ZXBQ78RlyMA==
X-Received: by 2002:a17:903:2306:b0:1cc:3fc9:1802 with SMTP id
 d6-20020a170903230600b001cc3fc91802mr11885379plh.61.1698888856753; 
 Wed, 01 Nov 2023 18:34:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 69/88] target/hppa: Implement PERMH
Date: Wed,  1 Nov 2023 18:29:57 -0700
Message-Id: <20231102013016.369010-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/hppa/insns.decode |  2 ++
 target/hppa/translate.c  | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 22ec07f892..19e537df24 100644
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
index 47ca71e2a3..36653486fb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2946,6 +2946,35 @@ static bool trans_mixw_r(DisasContext *ctx, arg_rrr *a)
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


