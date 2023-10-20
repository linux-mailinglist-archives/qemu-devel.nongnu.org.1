Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEB7D177F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP1-00020N-QM; Fri, 20 Oct 2023 16:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOy-0001v8-2S
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOw-0001CJ-CU
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so1246595b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834841; x=1698439641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sna123inmZqckkeeCG7fnD84UjYEicGgdYJ35WhU9q8=;
 b=ENQOdX3HUt2FlYbRfe0OEx9SCkHd67r5OVAHCwF0Ze5aboGIdd4FZwwwZ2CsmM50U1
 hOewFv32dAUEK9piyShD0puv8aSbE8NYTdWB/rKdsXzpctSwEMtW+GHbvIk2pU4nyJnp
 MVUszJbqHRKTd6OvvxLLGQdzfSZnvZFaaLBrqVx8JuNjfrE6cP97YQaOigd+2BVNo43u
 Zr7lNHJpBgE3R+grwlXYZB53qo2gX2Wq1qOLwFrpH+6L4aTe37LkjWGcgOrCWxUTEcfr
 dv0yOrkoq+KSlszqjOPfMQeo645tp4uKqZ4et2Ki53RmbasVHCfSpYd2Y8FHXtvdZ0nA
 Y0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834841; x=1698439641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sna123inmZqckkeeCG7fnD84UjYEicGgdYJ35WhU9q8=;
 b=afV+sptHw20k4+515YuRBZRBTXreClZe9/SLgbuTLQzh8gUwxizTUNRbvJrrlILEI7
 whTqAGE9oXw+SW+bKWao3oPdU2rHnLbrN8jSFnLmcIBK92gQAdG7+Ae+ahaKpO0Kmrdk
 EblNhQGgKmwp3p+lh2cdd+Hac11GWmUx0RIvhKyX0ILsQOplnWwilpyXr8KFOu1jnA+0
 LJTf7CnsO6aZpkyYOsRAhPVBbwKQSdOirlilt8vlTZa0kPiNc5TsRd7F2Z+QXYe7NChm
 z6hGEBfoecRhiMVCCsZ+7HgidhlWR6efeaf4pyhopOku7u6RdnzZwGal9pYUBDk2YSiF
 zWrg==
X-Gm-Message-State: AOJu0YykDnXGRGZgQSrhEPLzneGFOo7dGTSiR8y8LqX06m1KbEVGxDpw
 GuWRQoGKdcXKoWeroV184M6CHw1kVjSjAIINvBs=
X-Google-Smtp-Source: AGHT+IGlWwN5ZUceen/jDqNh3a1Q1CSUxMrmSuoGglGRhUOrYMpF0Gh952ZZBdyfIDYyf50NQn4o6A==
X-Received: by 2002:a05:6a00:15c2:b0:6bc:c242:7915 with SMTP id
 o2-20020a056a0015c200b006bcc2427915mr3003178pfu.28.1697834840881; 
 Fri, 20 Oct 2023 13:47:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 54/65] target/hppa: Implement HAVG
Date: Fri, 20 Oct 2023 13:43:20 -0700
Message-Id: <20231020204331.139847-55-richard.henderson@linaro.org>
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
 target/hppa/helper.h     |  1 +
 target/hppa/insns.decode |  2 ++
 target/hppa/op_helper.c  | 14 ++++++++++++++
 target/hppa/translate.c  |  5 +++++
 4 files changed, 22 insertions(+)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 99486f4cf8..1feb2fdfc4 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,6 +16,7 @@ DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
 
 DEF_HELPER_FLAGS_2(hadd_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hadd_us, TCG_CALL_NO_RWG, i64, i64, i64)
+DEF_HELPER_FLAGS_2(havg, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_ss, TCG_CALL_NO_RWG, i64, i64, i64)
 DEF_HELPER_FLAGS_2(hsub_us, TCG_CALL_NO_RWG, i64, i64, i64)
 
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 1830b06c76..fb0f9d6dbd 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -214,6 +214,8 @@ hadd            000010 ..... ..... 00000011 11 0 .....  @rrr
 hadd_ss         000010 ..... ..... 00000011 01 0 .....  @rrr
 hadd_us         000010 ..... ..... 00000011 00 0 .....  @rrr
 
+havg            000010 ..... ..... 00000010 11 0 .....  @rrr
+
 hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index ece523bea0..cba610ac75 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -410,6 +410,20 @@ uint64_t HELPER(hadd_us)(uint64_t r1, uint64_t r2)
     return ret;
 }
 
+uint64_t HELPER(havg)(uint64_t r1, uint64_t r2)
+{
+    uint64_t ret = 0;
+
+    for (int i = 0; i < 64; i += 16) {
+        int f1 = extract64(r1, i, 16);
+        int f2 = extract64(r2, i, 16);
+        int fr = f1 + f2;
+
+        ret = deposit64(ret, i, 16, (fr >> 1) | (fr & 1));
+    }
+    return ret;
+}
+
 uint64_t HELPER(hsub_ss)(uint64_t r1, uint64_t r2)
 {
     uint64_t ret = 0;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 63c6a28cef..c1ca4db099 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2776,6 +2776,11 @@ static bool trans_hadd_us(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_hadd_us);
 }
 
+static bool trans_havg(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_helper_havg);
+}
+
 static bool trans_hsub(DisasContext *ctx, arg_rrr *a)
 {
     return do_multimedia(ctx, a, tcg_gen_vec_sub16_i64);
-- 
2.34.1


