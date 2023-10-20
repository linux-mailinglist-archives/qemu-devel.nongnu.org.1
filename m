Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE67D179B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP2-00020v-C3; Fri, 20 Oct 2023 16:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP0-0001zc-0R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOy-0001D9-Bl
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so1178783b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834843; x=1698439643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eagFRPY1VSjyYYNRpnFw4I3TM7g/2HuCoJQHp1cHX38=;
 b=CNsgA/8imnsNqfhJ2qDttRHHtHtDvSyxLKXkt77RoJktsEcp0t6ekm9do8gWShT0P3
 Tra5+5EHfhQIfMIl2SXi+PqDjebMvUGykqH2plaVQVtUV7KP2N7Oyk+KNRGzGAsJhiGC
 +QmH1arWSemmWHSBqMkR0pFgJrM2bKtR2jLWfaFIEZr+ZUnceSByWxrkFUdqgaGsi9Rs
 HrrYGcq5AhtiTmxVFVZxSjm34HjMaIysQLQheFQFd0h6cf00pm1jSoHOeap6disqrG8e
 kpla21IUK9fd9m/lKXya6xsBn2JAUSHRViPUEsPvcVdORWpK+HL0UNW3jNGTT0TaGlvu
 dcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834843; x=1698439643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eagFRPY1VSjyYYNRpnFw4I3TM7g/2HuCoJQHp1cHX38=;
 b=FyViUQBE9CDPK7FkSpa2ISG44X2kUA785HipuUjmOOLVRWwwJpSuktVToXf2uJNe0q
 emErCMvNirfVpJt9PGAcTQSi+cK2UTLCFXyVJHTzhsUVCpkC3bQZKGl7eLIXKGb8rgof
 zhs27V4WXMCgsmEJkIuienmXB0qM8S0b8u2uGwDeziXh+YOUtd2KZi1LB0XtVIBqeOBM
 Mpd5U6Jvcd1AipUzJz8jDzxdKZql9VWNrSKu1PGdTW8UvixszRrEcBWlQFrZZQaXJqHL
 cKiyE3+AJlH7ecFqYd0vjbwD2flQ1ZWxaKeGaoAuHiWEm5nM4vD2f0mLNyFM9vifUHvP
 H+/A==
X-Gm-Message-State: AOJu0YzIiu6iRhCCD5Ib6hZFd2mNA3X59wVUn4EUgVF3NTsMQhItgXba
 kwgrSaGJObeVzIKHBwSLD/+tRZuhprE3VN6qrP4=
X-Google-Smtp-Source: AGHT+IEKkJTE11zvIiWEAtN3xAY5QikKG4RorIFM4r6pARMOCWmDKpK4ti3d3dQnaRY2Ne2/bIX7PA==
X-Received: by 2002:aa7:9718:0:b0:6be:25c5:4f74 with SMTP id
 a24-20020aa79718000000b006be25c54f74mr2685255pfg.13.1697834843140; 
 Fri, 20 Oct 2023 13:47:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 57/65] target/hppa: Implement MIXH, MIXW
Date: Fri, 20 Oct 2023 13:43:23 -0700
Message-Id: <20231020204331.139847-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/hppa/insns.decode |  5 ++++
 target/hppa/translate.c  | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index d7befbf73d..323e9275bf 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -233,6 +233,11 @@ hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
 
+mixh_l          111110 ..... ..... 1 00 00100000 .....  @rrr
+mixh_r          111110 ..... ..... 1 10 00100000 .....  @rrr
+mixw_l          111110 ..... ..... 1 00 00000000 .....  @rrr
+mixw_r          111110 ..... ..... 1 10 00000000 .....  @rrr
+
 ####
 # Index Mem
 ####
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 47abed1662..57761a7bed 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2863,6 +2863,61 @@ static bool trans_hsub_us(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_hsub_us);
 }
 
+static void gen_mixh_l(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    uint64_t mask = 0xffff0000ffff0000ull;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(tmp, r2, mask);
+    tcg_gen_andi_i64(dst, r1, mask);
+    tcg_gen_shri_i64(tmp, tmp, 16);
+    tcg_gen_or_i64(dst, dst, tmp);
+}
+
+static bool trans_mixh_l(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixh_l);
+}
+
+static void gen_mixh_r(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    uint64_t mask = 0x0000ffff0000ffffull;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(tmp, r1, mask);
+    tcg_gen_andi_i64(dst, r2, mask);
+    tcg_gen_shli_i64(tmp, tmp, 16);
+    tcg_gen_or_i64(dst, dst, tmp);
+}
+
+static bool trans_mixh_r(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixh_r);
+}
+
+static void gen_mixw_l(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(tmp, r2, 32);
+    tcg_gen_deposit_i64(dst, r1, tmp, 0, 32);
+}
+
+static bool trans_mixw_l(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixw_l);
+}
+
+static void gen_mixw_r(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    tcg_gen_deposit_i64(dst, r2, r1, 32, 32);
+}
+
+static bool trans_mixw_r(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixw_r);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


