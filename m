Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 415967CEA5D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVl-0002GE-NI; Wed, 18 Oct 2023 17:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVk-0002F0-2z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVi-00056v-FL
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso4679475b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666125; x=1698270925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fX4ajZFmvp6CPtzRyMzFGScgJS40L/02z7dwrdi6gaE=;
 b=LdXupNzn2C3Ots7zMuGR37goXOW6fZI6BPK6uClqdg0cRmXP8WncgWrcaJeMU77ASn
 G4XhuUJ3dQ8mpipJSGF5HY5s67N9VQYAVKyMC9szzu44tGRj0PZ8A6V/h8aLnwrWPs7t
 fp9n3huHy8abYjARC1Dx0BPpXy0E3y/K+qm3qS7laiDZhHYC1/Jy9xL3v1jRKnlP+/qd
 zP9HzK8wHengvCzzpngYjJDA982Rhy6GXFAXsvC3xdL/n2wezvC3TVyBlqbd3fGIJVYs
 69FwIjow6cwtcdg5g8fD0jD0ESceY3yUplsNvcZ13xWP745t4iuMmezI2gLnXSrHA1dx
 zHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666125; x=1698270925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fX4ajZFmvp6CPtzRyMzFGScgJS40L/02z7dwrdi6gaE=;
 b=QV1USjRQy7FzxxSXQ6mraeU1+cG4UL4yDlso6ZcnDJnvhXq1geOQkJn3W+mEexx02W
 RDz0eEHHGD/vkJ+t+QVo0ElUyvar66wp/HeMlE1kYFMAGqc4srlL8XryzU3c59dTsIH4
 U4E9nzBw8mrJQSVJfD9JZtG3dQoXF3hhA9wfuwMe2JPuJerxEvXJN+R5SYzEZbrSElIQ
 qx60ORg72Joox8cQfiMDc2la6iMSJZ5NzV64ksxbRrhdoJcgpKN7i5iqT/Xqh9YrvEzK
 rImRPWe/GhnhgohY9b7XsNwX+mLC5HCNKSqty8FnsQy1kfGYIyVtqIIcguR1WM/Pmbiv
 N1Yg==
X-Gm-Message-State: AOJu0YwREn/zMEhwuAJltSl7Dmc/U38lxycpC/kP2PLTK76ITZWoqd++
 rYArZ7gVK28TlOwcx5NQ+sO5CAEBa3ulBB5oa8I=
X-Google-Smtp-Source: AGHT+IGSvpTbx0xJFvzMV+I0cjywGnz6jSFSqSHuZH30fcRZfvTw/Kre/vj6BZP5J/JLOQCrSGPdFg==
X-Received: by 2002:a05:6a00:15d0:b0:690:28d0:b7b3 with SMTP id
 o16-20020a056a0015d000b0069028d0b7b3mr388786pfu.13.1697666125210; 
 Wed, 18 Oct 2023 14:55:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 56/61] target/hppa: Implement MIXH, MIXW
Date: Wed, 18 Oct 2023 14:51:30 -0700
Message-Id: <20231018215135.1561375-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index b0aefecd2e..bd8a858da6 100644
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


