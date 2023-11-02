Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5297DEA68
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:50:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcl-0000UY-86; Wed, 01 Nov 2023 21:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbQ-0006pA-TS
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb9-000230-QM
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cacde97002so3131015ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888854; x=1699493654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dZJ/Avbvd5B1sVDHFkjz0KBLC9YCeO4NBIHCuQT/As=;
 b=OaKkIT44AQB+MWrMxh3aPC3Vwg9cQYYR4Jq25qMrlbcCW0Q1UpL1jPBM3NTDo0Htsa
 52kAnzBC/qtVYub8RXjs5V4MZpclNpUVFs0qnfEUabpahRypOMnK+sjyN8uYUMAGb1ZS
 qI8UBBu8cRBwuR2SvSnwbkUWgvHVwDS9AXQMEDF29x4klPS6W/EWmd/YhnzXZiv+ueQk
 gkQU6hgfVnNvFbY/jvXKlQjYh0dd0nQAF7DfjyvS3rr2wJVyXlwicyMbUBZXleFvReUr
 ZJW0xZAC6sMsinjyAFG3iiWv21AjSBjz5T0IR4tXkjJTfapn8bAd+paesKTaBQx4UuQF
 hXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888854; x=1699493654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dZJ/Avbvd5B1sVDHFkjz0KBLC9YCeO4NBIHCuQT/As=;
 b=vtqwC6I6I6zwfveWf8CGQhtcdiNOm23gcYi65MWsqYd7NGi5NcxojmylyfejgbU9ln
 IZSPhBzzG377hMHFihiwqEdHrcSo2zJdUvfJbbuAAtXo0Xa/SKtAGG88wGPMZQocmYV8
 Is/ZVEw/S1KURTR2A2E+JV6UBRafhB7RM20dKsfw4YERNHLRgGBeKABsMSqdq/wQ0UHy
 hvHMeoUmLJH3d3e4w/fNy2MCNNuJUSSynM6XJi1bsS2kdQmPcrEoCajF2xWKfYulwbO4
 Yb3YRwNlr3kk2TKxs9G0ZaUyI4M784FTgUUCLpwMbmo5Cfdh4yMR44JIsmyR7rq/+3JD
 ukXQ==
X-Gm-Message-State: AOJu0YwHebsmj/R7ViNpzW7RjD0h3HdshPxTVkgmXi4Cgh8JCz1GksMf
 y6yvI71MYxRHk68Hl9LiNJQvPtLaQMa4dG7jJhg=
X-Google-Smtp-Source: AGHT+IFRzIFtPDYRjf1eq3I/zAENUqlHXdIldTCdDCUF3/AVIn8vUCxA+FRTiMpPNeyyDSYHxpX8pA==
X-Received: by 2002:a17:902:d484:b0:1cc:361b:7b28 with SMTP id
 c4-20020a170902d48400b001cc361b7b28mr12470291plg.64.1698888854304; 
 Wed, 01 Nov 2023 18:34:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 66/88] target/hppa: Implement HSHL, HSHR
Date: Wed,  1 Nov 2023 18:29:54 -0700
Message-Id: <20231102013016.369010-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 2fdd4448ae..d342df2dfa 100644
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


