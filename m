Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E57D794B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6m-0002C7-Sc; Wed, 25 Oct 2023 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6F-00017x-CO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo64-0006do-H9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:47 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso2058865ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279574; x=1698884374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZI9/ICpEQ1X/D+ks7TjhuKKwZOzznFfbKaTh1LluXE=;
 b=FVpbBpIIeEjPGHqcohu0CzvZ7pohimPQ5hsuZD4zqukdaqn1QCzeYFcBSfkM+8c361
 ce94p7D8ED9fRLFd0GChdyKI8TN8cxF78FatHJVJa98JyTc6kNIBFO2Arn3fLo8mjcPo
 WAAxzdaN/CZleILv/GgSZnFhFrLyq9DXsB1RfC4aZIZkriJWzboshr5SX3P7RjbO7BgU
 j4JHVCajvqabxV8j2N+k5ZPZFM3zAjGwpQwoSYmdNWNfOxhhs6dNRPkd8Pa1rZs24VCf
 ywT/1S2q3CmR1BmNjQerXZypCmP4lfWBiRc0OYJqH+wEm+0JibSapiAPMjMXNR3oGH4S
 QY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279574; x=1698884374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZI9/ICpEQ1X/D+ks7TjhuKKwZOzznFfbKaTh1LluXE=;
 b=VPZ7gfL8shkkv9NNaVlY9kXm4IQgJpemvOxYxDvs7fmcJ23kyca6x2PU0LU1c9u5U5
 dGOSSwKcyLgelWApzwDJHgIPW3b7slr3WX9Pq+sLMLN0P+8MbQYSXO56ZvB6wGrrEohZ
 gqMZqNHVSbjhBMT9MVCsD6a8EaV6ohc/9ZPhcaIY3gzKU9IL0yOrCQ9AU82f97lCKkZG
 +yWufXV1fvZKLeAVSMtKuQdIMkvKfxljNKiTbkLFCWxFYOwLoQAH6mf2PiUsvcgm1cvL
 nDZviCo5PnpVrsR6UVyHW8vLgAq/r9+Ep94eYOMTO6mDArDAXb3bFTjoVh/yJOCgLwgU
 bypA==
X-Gm-Message-State: AOJu0YyRGNZ8bQvhq894aiDnNW8D+iyYVpP1hQP8UXcKbW0sn0hzv+lj
 UMR00u9jefWF2JxfmwZHOFx0GujATl6Cl6HIdVM=
X-Google-Smtp-Source: AGHT+IEVuD59T7krfTxF0o6GAoI7XSTNSb9iqO2qN/nKDvlmJuJOXYqZkZEkopSbVTR/EBgffs/wVw==
X-Received: by 2002:a17:902:b48d:b0:1c5:de4c:f079 with SMTP id
 y13-20020a170902b48d00b001c5de4cf079mr13419776plr.33.1698279574561; 
 Wed, 25 Oct 2023 17:19:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/94] target/sparc: Remove cpu_hintp, cpu_htba, cpu_hver,
 cpu_ssr, cpu_ver
Date: Wed, 25 Oct 2023 17:14:40 -0700
Message-Id: <20231026001542.1141412-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use direct loads and stores to env instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 65b71dd931..7b83803b6b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -82,15 +82,9 @@ static TCGv cpu_cond;
 #ifdef TARGET_SPARC64
 static TCGv_i32 cpu_xcc, cpu_fprs;
 static TCGv cpu_gsr;
-static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
 #else
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_hintp              ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_htba               ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_hver               ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_ssr                ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_ver                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #endif
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
@@ -3383,21 +3377,24 @@ TRANS(RDHPR_htstate, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtstate)
 
 static TCGv do_rdhintp(DisasContext *dc, TCGv dst)
 {
-    return cpu_hintp;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(hintp));
+    return dst;
 }
 
 TRANS(RDHPR_hintp, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhintp)
 
 static TCGv do_rdhtba(DisasContext *dc, TCGv dst)
 {
-    return cpu_htba;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(htba));
+    return dst;
 }
 
 TRANS(RDHPR_htba, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtba)
 
 static TCGv do_rdhver(DisasContext *dc, TCGv dst)
 {
-    return cpu_hver;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(hver));
+    return dst;
 }
 
 TRANS(RDHPR_hver, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhver)
@@ -3572,14 +3569,16 @@ TRANS(RDPR_gl, GL, do_rd_special, supervisor(dc), a->rd, do_rdgl)
 /* UA2005 strand status */
 static TCGv do_rdssr(DisasContext *dc, TCGv dst)
 {
-    return cpu_ssr;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(ssr));
+    return dst;
 }
 
 TRANS(RDPR_strand_status, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdssr)
 
 static TCGv do_rdver(DisasContext *dc, TCGv dst)
 {
-    return cpu_ver;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(version));
+    return dst;
 }
 
 TRANS(RDPR_ver, 64, do_rd_special, supervisor(dc), a->rd, do_rdver)
@@ -3926,7 +3925,7 @@ TRANS(WRPR_gl, GL, do_wr_special, a, supervisor(dc), do_wrgl)
 /* UA2005 strand status */
 static void do_wrssr(DisasContext *dc, TCGv src)
 {
-    tcg_gen_mov_tl(cpu_ssr, src);
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(ssr));
 }
 
 TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
@@ -3959,14 +3958,14 @@ TRANS(WRHPR_htstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtstate)
 
 static void do_wrhintp(DisasContext *dc, TCGv src)
 {
-    tcg_gen_mov_tl(cpu_hintp, src);
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(hintp));
 }
 
 TRANS(WRHPR_hintp, HYPV, do_wr_special, a, hypervisor(dc), do_wrhintp)
 
 static void do_wrhtba(DisasContext *dc, TCGv src)
 {
-    tcg_gen_mov_tl(cpu_htba, src);
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(htba));
 }
 
 TRANS(WRHPR_htba, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtba)
@@ -5942,11 +5941,6 @@ void sparc_tcg_init(void)
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
 #ifdef TARGET_SPARC64
         { &cpu_gsr, offsetof(CPUSPARCState, gsr), "gsr" },
-        { &cpu_hintp, offsetof(CPUSPARCState, hintp), "hintp" },
-        { &cpu_htba, offsetof(CPUSPARCState, htba), "htba" },
-        { &cpu_hver, offsetof(CPUSPARCState, hver), "hver" },
-        { &cpu_ssr, offsetof(CPUSPARCState, ssr), "ssr" },
-        { &cpu_ver, offsetof(CPUSPARCState, version), "ver" },
 #endif
         { &cpu_cond, offsetof(CPUSPARCState, cond), "cond" },
         { &cpu_cc_src, offsetof(CPUSPARCState, cc_src), "cc_src" },
-- 
2.34.1


