Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF877E341B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRr-0005XB-EK; Mon, 06 Nov 2023 22:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRe-0004sm-6Z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:02 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRZ-0001Pm-So
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:01 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4abf80eab14so1672784e0c.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326477; x=1699931277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dAZM/UBRCOcMeq2kl2cfwsll2RBxvI7X8DJv5H5jrUs=;
 b=txNFZwEOQNVoY7RJLYS+yHd4YMWhf5/hsfjCA5c4r1Ef9VjkihMpeBbKxtMTow9HYf
 IlBJMhx1wpNT7M4az4KApEUmT3SohojIDLLoDI+HY1thOu1cBP/j5H1WjUMOTe8DduIy
 t0gtmyw5M8c913uguVzgyqoM1+gSVstbdFt7bkuoaZGP8yFxsABIuUl/uqBulQH1HaSH
 H61fENRd6zGzyvtEO31JYwzPw/RJGucMuvtGhfRgmtEY9SStlw2TJj3OjWQsOrJy1w8G
 k4/lCASoeRNO98bo5hjgpKGIMvq0Sz5aZ0YOTHpQYF4hDyCAHWqMs36xb763YY20nxcX
 uYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326477; x=1699931277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAZM/UBRCOcMeq2kl2cfwsll2RBxvI7X8DJv5H5jrUs=;
 b=WThJb28IUT2LcUj5+er5TTSYcab4IFYYPFhJOeaBwbvJP38nVHXmWx+29FdMGwFwR0
 cTGEsGcx2phvb2amImPFdpqC1vWXjLXlR/erBniC2aLqLGbE7vBKc15uKFk30Zb7+bk+
 zPZxmNqk70roOwaV8i8O0/9NbrvlUSqoZzF04LnYLlM8fnsTSBr9nA0ZzE9chJi6EWUh
 EdNBL9VY09XDh/Vznui06QqtZZUrU/JszUUVHIpMasAOjCWndPHx39357wR+6uVoXBeG
 RyrldePYSKmnk7IjZe9ckO56zliarcW7RcHuj7LepmyonVjcrLB6hRCjaAX2JuVhYsgr
 MZ5w==
X-Gm-Message-State: AOJu0Yxg8N5eJxrVKDBzjZZzmS5+7DeqdnxEhrHQXOW1E2NGfiMHknpI
 sVBag+RxaOks3XErXqcUlQeTk+JH51rapP79+sU=
X-Google-Smtp-Source: AGHT+IGhwG+6tPhwOiRxuVbMd0l/VLw1LAIQ9REnuGkR+C+GfNK+m8QkjtWXDof88GLE2GNzvJnVQg==
X-Received: by 2002:a1f:4c07:0:b0:4ac:593b:e9f4 with SMTP id
 z7-20020a1f4c07000000b004ac593be9f4mr3225323vka.9.1699326476714; 
 Mon, 06 Nov 2023 19:07:56 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/85] target/hppa: Implement HSHL, HSHR
Date: Mon,  6 Nov 2023 19:03:46 -0800
Message-Id: <20231107030407.8979-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2c.google.com
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
 target/hppa/insns.decode |  5 +++++
 target/hppa/translate.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 6959555bf3..bb5cd267b0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -69,6 +69,7 @@
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_d_sh    t r1 r2 cf d sh
+&rri            t r i
 &rri_cf         t r i cf
 &rri_cf_d       t r i cf d
 
@@ -216,6 +217,10 @@ hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
 havg            000010 ..... ..... 00000010 11 0 .....  @rrr
 
+hshl            111110 00000 r:5   100010 i:4  0 t:5    &rri
+hshr_s          111110 r:5   00000 110011 i:4  0 t:5    &rri
+hshr_u          111110 r:5   00000 110010 i:4  0 t:5    &rri
+
 hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e20ce40fe3..a3a12d63f8 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2789,6 +2789,26 @@ static bool do_multimedia(DisasContext *ctx, arg_rrr *a,
     return nullify_end(ctx);
 }
 
+static bool do_multimedia_sh(DisasContext *ctx, arg_rri *a,
+                             void (*fn)(TCGv_i64, TCGv_i64, int64_t))
+{
+    TCGv_i64 r, dest;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r = load_gpr(ctx, a->r);
+    dest = dest_gpr(ctx, a->t);
+
+    fn(dest, r, a->i);
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
 static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
@@ -2809,6 +2829,21 @@ static bool trans_havg(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_havg);
 }
 
+static bool trans_hshl(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shl16i_i64);
+}
+
+static bool trans_hshr_s(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_sar16i_i64);
+}
+
+static bool trans_hshr_u(DisasContext *ctx, arg_rri *a)
+{
+    return do_multimedia_sh(ctx, a, tcg_gen_vec_shr16i_i64);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


