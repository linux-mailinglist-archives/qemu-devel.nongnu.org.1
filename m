Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0BC7D2704
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtV-0007DY-Ju; Sun, 22 Oct 2023 19:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtT-0007CO-6U
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:03 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtR-0006oi-ES
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:02 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2ec9a79bdso2107843b6e.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017400; x=1698622200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qScZs44s00L/oLLs4eIUKTqGk+BatBxWrSAikGLStjw=;
 b=TbeSocEqVMhXk0MKZKCeVG3BzYW6xc4JrHA/fKb/IOPRHgmiChTyQEcfhpsgttidGQ
 Q80x/3MBdU8ZBL04+7+NVLQxsUzfD2uknjbq4vBGIfye5ryiNyP3QNnybHS13fOyTuPW
 KOL+axEVyyGP8zKi9WlbkcC+Yk0V8YR+nXG2eY4kQeWeqbqhKD6n07VqRGf1LgLQ6Bf2
 UaWPaYDwjyIZXD5UPyXhVMVJptsH3/xqtAu8Hg8lG48QyN3Ip/wnXe7lYURyFWmG8ZEt
 13E2BdGimOikSs6UXcbchWpSd0lZTWoh3iw+BAertljHNvByXsYL2sYAsP4gAuCOHGw6
 Nqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017400; x=1698622200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qScZs44s00L/oLLs4eIUKTqGk+BatBxWrSAikGLStjw=;
 b=GhcDfvy29smjbG4RyF3LzlFUz7buIBDhyz03xagbRuBgIbiop09Dq2k22oy4zmK+ip
 CZy44smThwJ2peG18QB4XVFQNNai/ASIvPs5261UCi8A+/Pt5CZXFmdxL5NP9XvIsqIs
 iFzPwAWehbEs1SYmTJh+6Z4kB+K2hqVsZk/hJAFVFWg2TmaQOYtSsRE6f5RAhqJDEj0r
 PlBPvhZtI8vrSDrYyi1sFx+SPrwd7GF7SOYHKG3YY9qmp3ebzL/vePzFUsCNEl+quHFO
 rIl0uzSlJg/mHyx/QZ1rwfwtaLgyBs7iF4HmbAtmLXMb7ZCxhFQYyWy9F0VoXbhk+VFR
 /xnQ==
X-Gm-Message-State: AOJu0Yxq2cRvppUzDqBBlblZihGJQJYeKCuZiDOX7yWkAZoAJjYnV5Yn
 9c+q8qMWV5Cz1K1Ppjzsthhyw4qbWrou89YJM3Q=
X-Google-Smtp-Source: AGHT+IF2pAmdXkNLPu+Fl+h7gXxznKGIjDmmslHc7bGWRO3mx7jDHTCUlpBzMRgF2XW2UJvxkmvxmw==
X-Received: by 2002:a05:6808:190d:b0:3af:71cf:2b52 with SMTP id
 bf13-20020a056808190d00b003af71cf2b52mr10682853oib.27.1698017400248; 
 Sun, 22 Oct 2023 16:30:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 30/94] target/sparc: Remove cpu_wim
Date: Sun, 22 Oct 2023 16:28:28 -0700
Message-Id: <20231022232932.80507-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 target/sparc/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d87c08c18c..096cbb869f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -84,9 +84,7 @@ static TCGv_i32 cpu_xcc, cpu_fprs;
 static TCGv cpu_gsr;
 static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
-# define cpu_wim                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #else
-static TCGv cpu_wim;
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_hintp              ({ qemu_build_not_reached(); (TCGv)NULL; })
@@ -103,8 +101,10 @@ static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
 #define env_field_offsetof(X)     offsetof(CPUSPARCState, X)
 #ifdef TARGET_SPARC64
+# define env32_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 # define env64_field_offsetof(X)  env_field_offsetof(X)
 #else
+# define env32_field_offsetof(X)  env_field_offsetof(X)
 # define env64_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 #endif
 
@@ -3414,7 +3414,8 @@ TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
 
 static TCGv do_rdwim(DisasContext *dc, TCGv dst)
 {
-    return cpu_wim;
+    tcg_gen_ld_tl(dst, tcg_env, env32_field_offsetof(wim));
+    return dst;
 }
 
 TRANS(RDWIM, 32, do_rd_special, supervisor(dc), a->rd, do_rdwim)
@@ -3767,7 +3768,10 @@ TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
 static void do_wrwim(DisasContext *dc, TCGv src)
 {
     target_ulong mask = MAKE_64BIT_MASK(0, dc->def->nwindows);
-    tcg_gen_andi_tl(cpu_wim, src, mask);
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_andi_tl(tmp, src, mask);
+    tcg_gen_st_tl(tmp, tcg_env, env32_field_offsetof(wim));
 }
 
 TRANS(WRWIM, 32, do_wr_special, a, supervisor(dc), do_wrwim)
@@ -5939,8 +5943,6 @@ void sparc_tcg_init(void)
 #ifdef TARGET_SPARC64
         { &cpu_xcc, offsetof(CPUSPARCState, xcc), "xcc" },
         { &cpu_fprs, offsetof(CPUSPARCState, fprs), "fprs" },
-#else
-        { &cpu_wim, offsetof(CPUSPARCState, wim), "wim" },
 #endif
         { &cpu_cc_op, offsetof(CPUSPARCState, cc_op), "cc_op" },
         { &cpu_psr, offsetof(CPUSPARCState, psr), "psr" },
-- 
2.34.1


