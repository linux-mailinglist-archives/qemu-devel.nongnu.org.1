Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E07E33F7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRv-0005kP-Bp; Mon, 06 Nov 2023 22:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRf-0004wW-Sn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0001Q8-OM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:03 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2800bb246ceso3895391a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326478; x=1699931278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JAxoXI7VapsXdw9ZI00wLKc1gQtqsT1pO38/MYDc4c=;
 b=K+IIkbUDHNc2oUL0XZ5N6PuFXb5b+vdI8KV6B0fpFGfIccpiJ7Vy6Dyo89626AjVBI
 ts5aRTAJH1ng2ZQ4MshcCwsjr/PwJgBkGX92PRnWCLDzdIm96/m3W9aaRFazmhlmN201
 jWnqOgt2XaQAQRH+ZRy3vsCeHJ+vO6RVr8N1BIrHJ+bPiz8/neF5Bgi3CdD0eLPN44KI
 YtB8rYkQRsqZpByBC9GL/VuL8NdLpQJu/D8xjjaiZQ55ISqc0F1C1KRXTl6lX+L6YG9g
 rYtF7RDH9nbx0ulF4XJiFqy+o1rcxMhYc1nq3zQg3Sdcivq2dNodQtYBUrUVUTmneB57
 NPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326478; x=1699931278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JAxoXI7VapsXdw9ZI00wLKc1gQtqsT1pO38/MYDc4c=;
 b=qDYU/lxQsx0nb0i+qlyuyqcT17dmgmlD8tFhUcVnFMiK0KJ5IHGi7iUBnh7nQzfqU0
 cH+ADrD4NprGbPLSe1PPl+2vzT+zChN10sA/CLhItyg+mybdP7nm9hFj6m+DwZaVTbNZ
 bsryUj1yPVg5pNCIUcRHqh0/e2+Wq93R0WIIkBTzz+UC2dDil3J2Ztix/U9fWgvHrmg4
 E7XuAX3cx7o8mxc04zknjSejnvbFR3u3IkQornvutBP9U3Pb40SVLge8/Vurx3gvDypd
 fTdY3VvvbSMzAfCN8xXQpS9YdQFgxolxY0VjA5TZ5r9dNfT9aQXFNF+LjpnrZbyVeC+f
 5LWQ==
X-Gm-Message-State: AOJu0Yzb5hKTORkGzN5htdWZ1aQ/sryCSvytJvFSx+4Aq3FMxjDBLhnO
 uvYxPGO6daY08oyD1gwoBs5lgHFGkih4YXMeWAE=
X-Google-Smtp-Source: AGHT+IGFgSwvKBBzRhChfQ5UjXLoSNU3zrtXCYANBDe+FccbpXWVF3cH+BFeYtpRNmcBJ0X2PbqZSg==
X-Received: by 2002:a17:90b:4acb:b0:280:3650:382a with SMTP id
 mh11-20020a17090b4acb00b002803650382amr20588850pjb.16.1699326478123; 
 Mon, 06 Nov 2023 19:07:58 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/85] target/hppa: Implement MIXH, MIXW
Date: Mon,  6 Nov 2023 19:03:48 -0800
Message-Id: <20231107030407.8979-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 target/hppa/insns.decode |  5 ++++
 target/hppa/translate.c  | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 87db726d9e..22ec07f892 100644
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
index 648c37fb28..2b471444d0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2891,6 +2891,61 @@ static bool trans_hsub_us(DisasContext *ctx, arg_rrr *a)
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


