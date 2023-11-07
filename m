Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E117E3406
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:15:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRq-0005VA-VA; Mon, 06 Nov 2023 22:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRe-0004sq-AW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:02 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRZ-0001PY-It
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:01 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2800c221af2so4894654a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326475; x=1699931275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x/TE698ywtHdA3gVYYtl+C+Go48OI3wLjkE0v/DYttA=;
 b=zfpRPrw8paOJLnrvYy1LUTvC00J1mb/ddcFndNkzYk2h+jZKwb4RuofkHVPN2N7YkD
 BZDJGBzwZ6z9DYOklQ/R/1QbMt3wmU2oQpeQss+mnBLXFRRzJWxXFXqcFUsWecXmKvcq
 bYW8x6fFIngkQHIih1yg0ppwLvH4EIEC4elqvzqufJ8Xr1Fs/ie97f0tQXnevv3EqsJh
 ipEepiV7aObyrnaVEqNs6Uc8rIK4r1QhW02+tfY8Y2B2ltQ9pWvV5KRHd4j0bo6ikL2z
 yypa89/xQo2gH8GMMm5QJG8x1q2+QTSFgMxvjRPYT4/szcRfw4LT19dbRU975pZ5J4On
 ahIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326475; x=1699931275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/TE698ywtHdA3gVYYtl+C+Go48OI3wLjkE0v/DYttA=;
 b=DolDylqJzcwlyd/mtSk/N52ugFwsFsBW+yJIrcvoqXc9gp4nsqbLxWtVFV07PLogPc
 VDnToTjqcSmWrQHAouYfdxu1nTAEYfjyM5nx9VOkBT0Z1/hAm6dVXR/u2JvYu4X45dRS
 4clqZoysqUgO5co0NgyJVttZTeToLZ+nb8rlvrWhHCnMkjnb1wmFQmgcOUZ5iDLu/jXT
 DXK1QfqbWj7wucfbLQChh40U3Ev7ERpnbF2BZZS8+WlwBHo1s72t6l2zo+FVQjPD4Ok+
 LNBdX4zUVZAKoD2GFyRqo6lBLv6Gko29k+i4uLEOhkL+M0yD+DL8KQlCsN4fVzX5JDPM
 QAbw==
X-Gm-Message-State: AOJu0Yy2ygB7pPU31FRl7FcWbNXOK52fOShoP7/zdTst0TEOEJPdyOSX
 r7VEvoDrm+U8NoQvPKdmlQRArPVkj9HvaBdBwQo=
X-Google-Smtp-Source: AGHT+IFITPaK1RQmrGFAzs0y3Cdg4+HzBKVucbFntOwU0OWug7L4cznrYAnDo1WALfxGF0gm7oJoVA==
X-Received: by 2002:a17:90a:fe13:b0:280:2652:d45 with SMTP id
 ck19-20020a17090afe1300b0028026520d45mr21115348pjb.20.1699326475164; 
 Mon, 06 Nov 2023 19:07:55 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/85] target/hppa: Implement HSUB
Date: Mon,  6 Nov 2023 19:03:44 -0800
Message-Id: <20231107030407.8979-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
index db662f0c33..64fd1ef1ef 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,8 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
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
index d93801ca47..de51905428 100644
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
index dc8e37f99c..e5a3873d25 100644
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


