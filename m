Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13A87D794D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6N-0001Tp-Nb; Wed, 25 Oct 2023 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-00015U-U9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo63-0006dk-Ou
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so287053b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279574; x=1698884374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=70Ansy+qoBySZPBjDOmIfy2SuZzlDjYJIwvEAx7FQ7k=;
 b=UxdnknKc2UdpsNtVa/eZj4gSW5imARaL6UR9CkddUZq15cpAoqwqEtnbZfTT4PKf7A
 kQxIJ2g88OU046/tw2M/NYH+yfatxOQpme5BuwNyJhGZegSFyDAV79aup6wRsCXNAbt/
 Wq7YxvaiC4dG0TCmJB9gFW6orNS4u2s+x7h61+FzYKv/kQuieaUtaHlomx/KLENpga73
 Hg7eQNgdqNHIfNkKWbK74zeNtv5BFtD5YZNpvZXuVjwoMF6cHO7XolDkQUKk9H9Lu4Du
 0PKJvB9xUqZmbk6bYF5IdnR89BMYtD8sBTktVFe+KYOZNTTHWOkPPn6nscgwUOX62rMH
 N7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279574; x=1698884374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70Ansy+qoBySZPBjDOmIfy2SuZzlDjYJIwvEAx7FQ7k=;
 b=R4GzoD79Jq8BwVLiGUKEijYMApDMBt+bCVZc2cEgl0jKjfB62mYElzQCdELVsRygAJ
 NrKjpjCRqd+vz5rxHT20IsTrPaOHNFfvbhbo6ssa/iUYtRwugdseevbpCFbuVAzkDcZu
 ZcMIuxoaGQd8nm3o2bpssBBjuK07a/KbX9/2tGNwaszSn2VvJNn4cGIwf4DUb/nbERQU
 0yYlVEhWgKawqVbeOdAwrhbIZeUXTJEQUX1fzxsQM9LMFldDYYA9o7qVzLRN3OVQ7T1I
 +BlW6sUapfZ2EvqJ64E0LHtxSqMa0n+DXD0rt78Yp0Bd68E8BtZnhfX2nePqi+W39jzj
 rk0A==
X-Gm-Message-State: AOJu0YzfvSAdTqp8HSPJp/QzWWUqcdY0c2UkiGwaYEWHiX/57QdceFtR
 RfB6+BttpPkzQ2W3InB65veB6B6cs1H3oTPCkYU=
X-Google-Smtp-Source: AGHT+IGw/vl4AnYVG4huI6OuxKvwYpTDjAu9reWI6xUxr1PtBZkoNb5USAKXb5Q7JprHxAtAndPU9w==
X-Received: by 2002:a05:6a21:4984:b0:179:fbe5:f535 with SMTP id
 ax4-20020a056a21498400b00179fbe5f535mr6310504pzc.58.1698279573841; 
 Wed, 25 Oct 2023 17:19:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/94] target/sparc: Remove cpu_tick_cmpr, cpu_stick_cmpr,
 cpu_hstick_cmpr
Date: Wed, 25 Oct 2023 17:14:39 -0700
Message-Id: <20231026001542.1141412-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/sparc/translate.c | 41 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 096cbb869f..65b71dd931 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -82,18 +82,14 @@ static TCGv cpu_cond;
 #ifdef TARGET_SPARC64
 static TCGv_i32 cpu_xcc, cpu_fprs;
 static TCGv cpu_gsr;
-static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
 #else
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_hintp              ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_hstick_cmpr        ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_htba               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_hver               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_ssr                ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_stick_cmpr         ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_tick_cmpr          ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_ver                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #endif
 /* Floating point registers */
@@ -3307,7 +3303,8 @@ TRANS(RDSOFTINT, 64, do_rd_special, supervisor(dc), a->rd, do_rdsoftint)
 
 static TCGv do_rdtick_cmpr(DisasContext *dc, TCGv dst)
 {
-    return cpu_tick_cmpr;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(tick_cmpr));
+    return dst;
 }
 
 /* TODO: non-priv access only allowed when enabled. */
@@ -3331,7 +3328,8 @@ TRANS(RDSTICK, 64, do_rd_special, true, a->rd, do_rdstick)
 
 static TCGv do_rdstick_cmpr(DisasContext *dc, TCGv dst)
 {
-    return cpu_stick_cmpr;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(stick_cmpr));
+    return dst;
 }
 
 /* TODO: supervisor access only allowed when enabled by hypervisor. */
@@ -3406,7 +3404,8 @@ TRANS(RDHPR_hver, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhver)
 
 static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
 {
-    return cpu_hstick_cmpr;
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(hstick_cmpr));
+    return dst;
 }
 
 TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
@@ -3696,18 +3695,14 @@ TRANS(WRSOFTINT, 64, do_wr_special, a, supervisor(dc), do_wrsoftint)
 
 static void do_wrtick_cmpr(DisasContext *dc, TCGv src)
 {
-#ifdef TARGET_SPARC64
     TCGv_ptr r_tickptr = tcg_temp_new_ptr();
 
-    tcg_gen_mov_tl(cpu_tick_cmpr, src);
-    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, tick));
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(tick_cmpr));
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(tick));
     translator_io_start(&dc->base);
-    gen_helper_tick_set_limit(r_tickptr, cpu_tick_cmpr);
+    gen_helper_tick_set_limit(r_tickptr, src);
     /* End TB to handle timer interrupt */
     dc->base.is_jmp = DISAS_EXIT;
-#else
-    qemu_build_not_reached();
-#endif
 }
 
 TRANS(WRTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrtick_cmpr)
@@ -3731,18 +3726,14 @@ TRANS(WRSTICK, 64, do_wr_special, a, supervisor(dc), do_wrstick)
 
 static void do_wrstick_cmpr(DisasContext *dc, TCGv src)
 {
-#ifdef TARGET_SPARC64
     TCGv_ptr r_tickptr = tcg_temp_new_ptr();
 
-    tcg_gen_mov_tl(cpu_stick_cmpr, src);
-    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, stick));
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(stick_cmpr));
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(stick));
     translator_io_start(&dc->base);
-    gen_helper_tick_set_limit(r_tickptr, cpu_stick_cmpr);
+    gen_helper_tick_set_limit(r_tickptr, src);
     /* End TB to handle timer interrupt */
     dc->base.is_jmp = DISAS_EXIT;
-#else
-    qemu_build_not_reached();
-#endif
 }
 
 TRANS(WRSTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrstick_cmpr)
@@ -3984,10 +3975,10 @@ static void do_wrhstick_cmpr(DisasContext *dc, TCGv src)
 {
     TCGv_ptr r_tickptr = tcg_temp_new_ptr();
 
-    tcg_gen_mov_tl(cpu_hstick_cmpr, src);
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(hstick_cmpr));
     tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(hstick));
     translator_io_start(&dc->base);
-    gen_helper_tick_set_limit(r_tickptr, cpu_hstick_cmpr);
+    gen_helper_tick_set_limit(r_tickptr, src);
     /* End TB to handle timer interrupt */
     dc->base.is_jmp = DISAS_EXIT;
 }
@@ -5951,10 +5942,6 @@ void sparc_tcg_init(void)
     static const struct { TCGv *ptr; int off; const char *name; } rtl[] = {
 #ifdef TARGET_SPARC64
         { &cpu_gsr, offsetof(CPUSPARCState, gsr), "gsr" },
-        { &cpu_tick_cmpr, offsetof(CPUSPARCState, tick_cmpr), "tick_cmpr" },
-        { &cpu_stick_cmpr, offsetof(CPUSPARCState, stick_cmpr), "stick_cmpr" },
-        { &cpu_hstick_cmpr, offsetof(CPUSPARCState, hstick_cmpr),
-          "hstick_cmpr" },
         { &cpu_hintp, offsetof(CPUSPARCState, hintp), "hintp" },
         { &cpu_htba, offsetof(CPUSPARCState, htba), "htba" },
         { &cpu_hver, offsetof(CPUSPARCState, hver), "hver" },
-- 
2.34.1


