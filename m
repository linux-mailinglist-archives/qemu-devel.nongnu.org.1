Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B17537D177C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP0-0001ye-5I; Fri, 20 Oct 2023 16:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOx-0001te-Lb
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOu-0001C0-RV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso1192473b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834839; x=1698439639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyKRvcSVwIZRGZOCNbFmD7+eSOO/DoyIuLiNzQZCvfw=;
 b=r9OCiO4InIq3f0THhRa5t9F4+gtRe/ll3spEh7JzyuwrIjZJzVXmaLCzYtkhnvdqmU
 Z9ghVEZhPkuOqElCs2VV2w+Zrvs/CZ5LI9tpr+dLrU5nIfO6gpem8ZXsP9wKpEiwqYin
 dhdf7Ls0nuxmGqWQc4ptNFTprMnNZqq8d2BPsehOhRLjdrkxDnUZtltqfnxgO8xffXoB
 IOQZvG6yY7nkitJCR2MV0sfiZ2VUvhhpnWmp9/PGoobGlGU4lRe6gwdT535hbJY7dUeu
 2fetmKkJN18y5GRRtDOMaaegnqHut5JcUVOy/lU4LQS+8oHJGInVYk0z1ThxCsplJHjq
 SZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834839; x=1698439639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyKRvcSVwIZRGZOCNbFmD7+eSOO/DoyIuLiNzQZCvfw=;
 b=BnxYKcCPd5j3XLVQWUCSrtuIZuI/apc1Sn61VyuZOAIv3Qu1JJD8q+YdLnP8DPt8BS
 hRt0jg1votU/wVGKs3O8PmhuA5u/zI/r1TaURErg3rHkrNFvVIFF3qnOYqmvBAmnL/nx
 PVjZl72Bdd7yndZmjM0QBzl56k4jnz58ppwyIHeLYCmIPQmlglW4kPsEIhI0GBPNE6q9
 1rFiTqu2xyvd8dqTHaK8PboddjX8IwnRPSXDMpUTU2ZVR+aXCz5L6HXWnyI3FUasMFW/
 QN1pSu2bRavDj2dGvbFreh6frOk0Q21tjCGEly/xfYoJGvJjvzk2LiZArQLPtWwOvaLP
 by9g==
X-Gm-Message-State: AOJu0YxBIwKWFVLmIc+L+n2KTwX+6adwZ6Bn9ooLzGE0x7yuvjFUmSDa
 gyvvMLILbSSGpTW6t5BoWzRyPSVT2KH0Pz5ZuFo=
X-Google-Smtp-Source: AGHT+IFms3Ga8zbK31DLcwiIAaPQLBKd6BuP7M054dCmKfWK/cEegHrD5ZLaSun9aJ7mCUw6YzNXCw==
X-Received: by 2002:a05:6a20:6a04:b0:13a:59b1:c884 with SMTP id
 p4-20020a056a206a0400b0013a59b1c884mr2887164pzk.40.1697834839466; 
 Fri, 20 Oct 2023 13:47:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 52/65] target/hppa: Implement HADD
Date: Fri, 20 Oct 2023 13:43:18 -0700
Message-Id: <20231020204331.139847-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/hppa/helper.h     |  3 +++
 target/hppa/insns.decode |  8 +++++++-
 target/hppa/op_helper.c  | 32 ++++++++++++++++++++++++++++++++
 target/hppa/translate.c  | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 4b2c66316f..ff2695797e 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -14,6 +14,9 @@ DEF_HELPER_FLAGS_3(stdby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
 
 DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
+DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tl, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index db1b9f750f..88248ed3e2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -65,6 +65,7 @@
 &ldst           t b x disp sp m scale size
 
 &rr_cf_d        t r cf d
+&rrr            t r1 r2
 &rrr_cf         t r1 r2 cf
 &rrr_cf_d       t r1 r2 cf d
 &rrr_cf_d_sh    t r1 r2 cf d sh
@@ -81,6 +82,7 @@
 ####
 
 @rr_cf_d        ...... r:5 ..... cf:4 ...... d:1 t:5    &rr_cf_d
+@rrr            ...... r2:5 r1:5 .... ....... t:5       &rrr
 @rrr_cf         ...... r2:5 r1:5 cf:4 ....... t:5       &rrr_cf
 @rrr_cf_d       ...... r2:5 r1:5 cf:4 ...... d:1 t:5    &rrr_cf_d
 @rrr_cf_d_sh    ...... r2:5 r1:5 cf:4 .... sh:2 d:1 t:5 &rrr_cf_d_sh
@@ -208,6 +210,10 @@ subi_tsv        100101 ..... ..... .... 1 ...........   @rri_cf
 
 cmpiclr         100100 ..... ..... .... . ...........   @rri_cf_d
 
+hadd            000010 ..... ..... 00000011 11 0 .....  @rrr
+hadd_ss         000010 ..... ..... 00000011 01 0 .....  @rrr
+hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
+
 ####
 # Index Mem
 ####
@@ -429,7 +435,7 @@ fmpyfadd_d      101110 rm1:5 rm2:5 ... 0 1 ..0 0 0 neg:1 t:5    ra3=%rc32
 
 @f0e_f_3        ...... ..... ..... ... .0 110 ..0 .....    \
                 &fclass3 r1=%ra64 r2=%rb64 t=%rt64
-@f0e_d_3        ...... r1:5  r2:5  ... 01 110 000 t:5
+@f0e_d_3        ...... r1:5  r2:5  ... 01 110 000 t:5      &fclass3
 
 # Floating point class 0
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 0bccca1e11..a230a3a0c3 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -377,3 +377,35 @@ target_ulong HELPER(read_interval_timer)(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >> 2;
 #endif
 }
+
+uint64_t HELPER(hadd_ss)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = sextract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        fr = MIN(fr, INT16_MAX);
+        fr = MAX(fr, INT16_MIN);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
+
+uint64_t HELPER(hadd_us)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = extract64(r1, i, 16);
+        int f2 = sextract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        fr = MIN(fr, UINT16_MAX);
+        fr = MAX(fr, 0);
+        ret = deposit64(ret, i, 16, fr);
+    }
+    return ret;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 16d42ae328..0d72c96fd5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -23,6 +23,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
+#include "tcg/tcg-op-gvec.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
@@ -2739,6 +2740,42 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf_d *a)
     return nullify_end(ctx);
 }
 
+static bool do_multimedia(DisasContext *ctx, arg_rrr *a,
+                          void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 r1, r2, dest;
+
+    if (!ctx->is_pa20) {
+        return false;
+    }
+
+    nullify_over(ctx);
+
+    r1 = load_gpr(ctx, a->r1);
+    r2 = load_gpr(ctx, a->r2);
+    dest = dest_gpr(ctx, a->t);
+
+    fn(dest, r1, r2);
+    save_gpr(ctx, a->t, dest);
+
+    return nullify_end(ctx);
+}
+
+static bool trans_hadd(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, tcg_gen_vec_add16_i64);
+}
+
+static bool trans_hadd_ss(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hadd_ss);
+}
+
+static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_hadd_us);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


