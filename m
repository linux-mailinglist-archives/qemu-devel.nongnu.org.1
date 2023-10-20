Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDC7D1780
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP0-0001yX-3v; Fri, 20 Oct 2023 16:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOx-0001tm-O5
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOv-0001C7-TU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so1109407b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834840; x=1698439640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2B6dMamMnRVER/FMmJuOoUUmNaPsvlpsYZS/xeL1qA=;
 b=ieUUD//7IfQJ2odz+gSHb2wXU3BH1Q0JrOl9J7HWl6BkHbQ1NLrX+/y0+8YcycUaV7
 /5cuXvutvTZ8gkTU4icXbjAqs2HS1TIZuxoPPVvc63gDKagnsGXNAdBLzObWWtcvdMWd
 3oX3yq7c5P15WLiVL4Kl/lj/hg3+MserEAoAzIdb8aDLEomJ9Sx3jKkza++2/7K2UNwe
 0jKveXWOe6nAdYPH472yNlIWBXFluwQQRN97kNXqzSK0Em9Sm1a0CLqU4jZ5AivFcrr9
 Wy9hrrYUIzOTK+CvSP5H5lMNoqk+A3AAJjQD+qlaV3c9Cm3F+T2/4ktj731Y9qEFnA6+
 PrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834840; x=1698439640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2B6dMamMnRVER/FMmJuOoUUmNaPsvlpsYZS/xeL1qA=;
 b=QmgJ4118kkHldChEpGYzHzz6w+UXI7j9TqGjZzVVFmbdxiURsI0ZDMXVFxeONdknEY
 BriLMHEIFQ4REW0BNt2tQsZEz/uEWHzMfXhQjn5LZKYdKVAVI56IPa30nm2SEDCQ0ziO
 4eA0/NegkPD0JQNTPweul4fIugxXCrRpKqtcWq5SGFT9aQ5SUzNU+KuXYh+lJCPPYQwy
 OoLlyTt4vh5tk8F3lVMDRPEImtKYVAvgsK8qsKmoYbGmjxoB6OgMO/qwE43GHDXgKDLQ
 xyg2JB6A/vP4S85OzUbMIGxFaVI5fhR4TwIAT055/xdMzgP2jBckclEvrz5ntOl7loLB
 UrpQ==
X-Gm-Message-State: AOJu0Yz2GRDiseQtiFWbVJoB3sk6lF4dPdqhGSYoJtDvXelTYjL4hmAq
 5WEGG5IW6i5PeS91eFNdUcJGjL/92mFntWQRcro=
X-Google-Smtp-Source: AGHT+IEqpStvILltC3LW/YgeQFBvIbEPANvQ/lasPcu0DKkDBDPL02USkwQspg4SPbI/Lz7J1ZatVg==
X-Received: by 2002:a05:6a21:66c7:b0:163:2dc7:d077 with SMTP id
 ze7-20020a056a2166c700b001632dc7d077mr1415795pzb.55.1697834840189; 
 Fri, 20 Oct 2023 13:47:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 53/65] target/hppa: Implement HSUB
Date: Fri, 20 Oct 2023 13:43:19 -0700
Message-Id: <20231020204331.139847-54-richard.henderson@linaro.org>
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
 target/hppa/helper.h     |  2 ++
 target/hppa/insns.decode |  4 ++++
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 15 +++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index ff2695797e..99486f4cf8 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,8 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 88248ed3e2..1830b06c76 100644
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
index 0d72c96fd5..63c6a28cef 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2776,6 +2776,21 @@ static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
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


