Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC307DEA31
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMbs-000749-3f; Wed, 01 Nov 2023 21:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbA-0006YT-3B
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-00022C-4d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cacde97002so3130785ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888852; x=1699493652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z97fFY7Wn9zj1ZAonEuX35kI8FxyV8+JUDBvaH54V24=;
 b=g2wQE7J4/4/rUswXZYAM8IzBJaHolz8LrpA/6Id0hKZ6lzFIPD14SAbbo7sBULTlpe
 3yVQJbgu1owcUyZ8Ix8cKbaqSBcq7sCcIjvKErdMC3W0CR3U+9q6V4s+90zbgCRbMP0H
 tU3qroAGR/el3Zax2d3wBhMv9mrOYJe1B8OyJiMy1DjhTPr5jsukbYo66MEaVhPh81Lj
 S2VvkKm9aeKxQr/8pRr/8mnPbVqTfjnQy1uvSMso1IKQafq1qkGFfHWVPwkbTHzjuC9u
 S2xKNMl7pKFu4ds9Yl29RvBATqru3TDGxBYl+d7iFhUm1GEbBGha+ol98oEzq9/Mf9Ic
 VLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888852; x=1699493652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z97fFY7Wn9zj1ZAonEuX35kI8FxyV8+JUDBvaH54V24=;
 b=HiscghbQF+04/p+T0IUk19ZpcUmMEvtVN0l81BniDpsNJjIcAf5sba1f/u1WshuYu5
 4/TGwZgNp6ClQCOpAnF6A1q/3T4f68pCLaqQ511xbiAc17nXGOBG0+9N4XUypgnotWog
 MTcBG5BMxJ57SnLQybUxmiC4gaDsfDCoU2aJin9Se4cnh2Kw3K8OJI36ZcEIKbUWFiz4
 m27YE0bF7ZJfYsGWdGDslVubdbbFSP2Gvbo2tZGmizwzP8a7a7tOvu+4x7P1pavv5Y0Y
 yLiSMB5gGggyQkGyHO3VyGh93DbGTgfj53LMaIhf8nJ9hjDPdsGRQFKA2FHjciBHnLEy
 cnSw==
X-Gm-Message-State: AOJu0YwRXHbo5wQLZg/zACtGzOfpopSCWdc9lFTSjcifVh8U4sTMr1eM
 aqAzkX3Tip4XXlJmS6/SkB7NZiMbvD7vyTX0KGs=
X-Google-Smtp-Source: AGHT+IF1xe0auhJWYE5mRhPNkTxq7u7aaNUOrsoRE1hEnOSLsNTeGWpOzOsHzcO70e/LZuKuQQ9h7w==
X-Received: by 2002:a17:902:f550:b0:1cc:62d0:6008 with SMTP id
 h16-20020a170902f55000b001cc62d06008mr8882741plf.55.1698888852662; 
 Wed, 01 Nov 2023 18:34:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 64/88] target/hppa: Implement HSUB
Date: Wed,  1 Nov 2023 18:29:52 -0700
Message-Id: <20231102013016.369010-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/hppa/helper.h     |  2 ++
 target/hppa/insns.decode |  4 ++++
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 15 +++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index b3c961b50d..02798aa105 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,8 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 4bcfc94b1c..29b49c6cf4 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -214,6 +214,10 @@ hadd            000010 ..... ..... 00000011 11 0 .....  @rrr
 hadd_ss         000010 ..... ..... 00000011 01 0 .....  @rrr
 hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
+hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
+hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
+hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
+
 ####
 # Index Mem
 ####
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a230a3a0c3..ece523bea0 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -409,3 +409,35 @@ uint64_t HELPER(hadd_us)(uint64_t r1, uint64_t r2)
     }
     return ret;
 }
+
+uint64_t HELPER(hsub_ss)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = sextract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 - f2;
+
+        fr = MIN(fr, INT16_MAX);
+        fr = MAX(fr, INT16_MIN);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
+
+uint64_t HELPER(hsub_us)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = extract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 - f2;
+
+        fr = MIN(fr, UINT16_MAX);
+        fr = MAX(fr, 0);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f564aea8fb..2f1333b91c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2804,6 +2804,21 @@ static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_hadd_us);
 }
 
+static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
+}
+
+static bool trans_hsub_ss(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hsub_ss);
+}
+
+static bool trans_hsub_us(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hsub_us);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


