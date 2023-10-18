Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AC37CEADD
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVj-0002EN-7R; Wed, 18 Oct 2023 17:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVg-0002Da-Q3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:24 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVf-00054H-5t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:24 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c4d625da40so5051105a34.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666122; x=1698270922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAcoAZN0zZMn9SMNjn5rzCUBcFL8BPxCVl2F5+s0D30=;
 b=iYL1p3KvUuZ5gg45XF3bNb8T81y14Yse/85G3cvAg2q8l9IE37E3X5SfqK0tHeBQ1+
 Z80BGaeNAJWmPHoRAdVsA1lEF4HrtGWXFXES3/NEazISocKtix16YtOZM7JQsxIRSmBl
 58wUk3Uid21p2xxH53fdZMxNqR6q/fIRPZ50Bzcqv/PHOI3B4xO/1nkim3gZwnKFFPIW
 TjLFDfVubdyC7KINR+Jzh7VTanrtA7bROYSQdOGwZ+/NWE5bqMo1wnAKqLg2jX0t8LJS
 mfbCI+P+0eHAtEeCvwZfBEB8zJDGRkNSsCXWs+fg24AIPzI4xy4m2JPr7TK47m6/D01y
 wJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666122; x=1698270922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAcoAZN0zZMn9SMNjn5rzCUBcFL8BPxCVl2F5+s0D30=;
 b=h92G1EBNsQoDvL48kVSZF/2AG8KFolpEA+Hfu+9VkFifBU6HojfTj0C1Rm7oOBNZ+/
 83pVjEeP1UfK5+S1f5+30Atyf1Rmi28n2h2NF6mjOWLwEJDrciQd47H3/h0fe4TZUAC6
 8puRcIO65JWwFFQoBdYTE9ouplC12UMlKS/L+RzHYR/rhlu7vidQcvNrybB8QCOoL2rs
 nStaORjjj5GFIJ+iUqP4EYCyRcnOARmT3MNm96XQ5eUOxmQcOnNiCQq/HWlgyZnWKADk
 gHNGfL9f0HtP7sdqoICcmKINFST6HmgXHyNMyATf1+pVnE2Ng0/Bie/NIWFGic/anEKq
 YuFg==
X-Gm-Message-State: AOJu0YwtGzmvoMYIk1ycyy0zKZiAxM8vhhLWoptY7AJ78qn0UO+PBs5M
 9vcpMem83SkTMJesinX5aqI+oGKwvN1n5sgm8IE=
X-Google-Smtp-Source: AGHT+IGX+rHDh8TNPsVdfWdPsE3K/vrpRbN79ZyJwDI7JC4xyI1jiWyhE3F14N1hzMGVusj0uPm78A==
X-Received: by 2002:a05:6830:13d0:b0:6c6:4843:2abc with SMTP id
 e16-20020a05683013d000b006c648432abcmr566384otq.18.1697666122038; 
 Wed, 18 Oct 2023 14:55:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 52/61] target/hppa: Implement HSUB
Date: Wed, 18 Oct 2023 14:51:26 -0700
Message-Id: <20231018215135.1561375-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
index bbf216fcde..97d27cb2a9 100644
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


