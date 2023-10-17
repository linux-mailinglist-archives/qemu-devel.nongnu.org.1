Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C37CBB26
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKP-0000h2-7Z; Tue, 17 Oct 2023 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKL-0000dv-TU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:14 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKI-0003uz-Dt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:13 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5a1d89ff4b9so2949942a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523189; x=1698127989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0oexih9JF9KJvNRfgtVbIFxrwccwBAAHIEbQwnrscQ=;
 b=ArZG68OPBMVC/SZALRwYW2u3FUqPp3O2fG1hdcJGgcibbvhEee+xHiF7rwB+R2itrG
 usIJa5TKLJvquGK3tJMC6DLlRMmH/1CxOsNCLiixiOKxM+wvNP1uToilvR473hO1skyU
 67p0nh5HR/fj1YUDDqzW3f/aWtw24kMRyyoqG8V1l4bwh9ow3QBQ3HCh2ZmXogTH9WTs
 pLoPlNJBf/PZYgT0xf6YuduAGCUyECIjBTEgOayt3HteYUfBvcNrCLDmZMh1hpXPmyL+
 1fe5UJ6GhF2yBGi2OfGnF5rVVvv3uPoCT2sagRyjNxOkF4+r0zyH+P7AJ10mFuRg/F8g
 Tk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523189; x=1698127989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0oexih9JF9KJvNRfgtVbIFxrwccwBAAHIEbQwnrscQ=;
 b=wpKsChpr2C/kOdydUpv1McqV10YPzNixQX4y1RP/uRnbVJ1dUf3MxkKJfHWVuuHrwM
 j976KjcyjPOb/FNnYG/MIYm2ztw5WNElDOGqE5u1S4rVOYRr7rmEoDb+884nf+DTt/iw
 z8mpleymotpVdvbsZB/MVLygJTa+nHPjrQW38W0PPl51QmiqFM/8P5q/jSH6kILjuTK7
 Zrff1doO3emUWg/cJq6yK3VK5a3FQU7G1PBhpeKYpdwla5gP4+BdnTnEHINhCXk2Tr6g
 7iFgJjrQdBMn8qSaV/gvaouOk8y6ig1OTQaqtXeZJ6qtQSPRV1igqnZBpo3JNqeOZUTd
 e9ww==
X-Gm-Message-State: AOJu0YxAHaeE55v9BwcBAkPUGJZiCrJXLDjVX36RgRPvAx0KKRz1JCNw
 60hybT9q2KnsNUBPAntZXmA1J1tVyrBvgOi+S7w=
X-Google-Smtp-Source: AGHT+IFo/PJzdA83zIm2wyVx/GU+HMVhnTTxWCi7xXt8VcXSohGamsPEzGNCkZ3nQep2lFW25Y3W0Q==
X-Received: by 2002:a05:6a20:748d:b0:13f:1622:29de with SMTP id
 p13-20020a056a20748d00b0013f162229demr1243607pzd.7.1697523188732; 
 Mon, 16 Oct 2023 23:13:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 27/90] target/sparc: Move WRWIM, WRPR to decodetree
Date: Mon, 16 Oct 2023 23:11:41 -0700
Message-Id: <20231017061244.681584-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/sparc/insns.decode |  21 +++
 target/sparc/translate.c  | 350 +++++++++++++++++++++++---------------
 2 files changed, 235 insertions(+), 136 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 850b5d58d0..56c04f01a5 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -117,6 +117,27 @@ RDPR_gl             10 rd:5  101010 10000 0 0000000000000
 RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
 RDPR_ver            10 rd:5  101010 11111 0 0000000000000
 
+{
+  WRWIM             10 00000 110010 ..... . .............  @n_r_ri
+  WRPR_tpc          10 00000 110010 ..... . .............  @n_r_ri
+}
+WRPR_tnpc           10 00001 110010 ..... . .............  @n_r_ri
+WRPR_tstate         10 00010 110010 ..... . .............  @n_r_ri
+WRPR_tt             10 00011 110010 ..... . .............  @n_r_ri
+WRPR_tick           10 00100 110010 ..... . .............  @n_r_ri
+WRPR_tba            10 00101 110010 ..... . .............  @n_r_ri
+WRPR_pstate         10 00110 110010 ..... . .............  @n_r_ri
+WRPR_tl             10 00111 110010 ..... . .............  @n_r_ri
+WRPR_pil            10 01000 110010 ..... . .............  @n_r_ri
+WRPR_cwp            10 01001 110010 ..... . .............  @n_r_ri
+WRPR_cansave        10 01010 110010 ..... . .............  @n_r_ri
+WRPR_canrestore     10 01011 110010 ..... . .............  @n_r_ri
+WRPR_cleanwin       10 01100 110010 ..... . .............  @n_r_ri
+WRPR_otherwin       10 01101 110010 ..... . .............  @n_r_ri
+WRPR_wstate         10 01110 110010 ..... . .............  @n_r_ri
+WRPR_gl             10 10000 110010 ..... . .............  @n_r_ri
+WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
+
 {
   FLUSHW    10 00000 101011 00000 0 0000000000000
   RDTBR     10 rd:5  101011 00000 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a5058b5931..6b8dfa7830 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -44,6 +44,10 @@
 #define gen_helper_rdccr(D, E)          qemu_build_not_reached()
 #define gen_helper_rdcwp(D, E)          qemu_build_not_reached()
 #define gen_helper_wrccr(E, S)          qemu_build_not_reached()
+#define gen_helper_wrcwp(E, S)          qemu_build_not_reached()
+#define gen_helper_wrgl(E, S)           g_assert_not_reached()
+#define gen_helper_wrpil(E, S)          qemu_build_not_reached()
+#define gen_helper_wrpstate(E, S)       qemu_build_not_reached()
 #define gen_helper_set_softint(E, S)    qemu_build_not_reached()
 #define gen_helper_clear_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
@@ -3822,6 +3826,214 @@ static void do_wrpsr(DisasContext *dc, TCGv src)
 
 TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
 
+static void do_wrwim(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    qemu_build_not_reached();
+#else
+    target_ulong mask = MAKE_64BIT_MASK(0, dc->def->nwindows);
+    tcg_gen_andi_tl(cpu_wim, src, mask);
+#endif
+}
+
+TRANS(WRWIM, 32, do_wr_special, a, supervisor(dc), do_wrwim)
+
+static void do_wrtpc(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_st_tl(src, r_tsptr, offsetof(trap_state, tpc));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tpc, 64, do_wr_special, a, supervisor(dc), do_wrtpc)
+
+static void do_wrtnpc(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_st_tl(src, r_tsptr, offsetof(trap_state, tnpc));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tnpc, 64, do_wr_special, a, supervisor(dc), do_wrtnpc)
+
+static void do_wrtstate(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_st_tl(src, r_tsptr, offsetof(trap_state, tstate));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tstate, 64, do_wr_special, a, supervisor(dc), do_wrtstate)
+
+static void do_wrtt(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_st32_tl(src, r_tsptr, offsetof(trap_state, tt));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tt, 64, do_wr_special, a, supervisor(dc), do_wrtt)
+
+static void do_wrtick(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, tick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_count(r_tickptr, src);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tick, 64, do_wr_special, a, supervisor(dc), do_wrtick)
+
+static void do_wrtba(DisasContext *dc, TCGv src)
+{
+    tcg_gen_mov_tl(cpu_tbr, src);
+}
+
+TRANS(WRPR_tba, 64, do_wr_special, a, supervisor(dc), do_wrtba)
+
+static void do_wrpstate(DisasContext *dc, TCGv src)
+{
+    save_state(dc);
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_wrpstate(tcg_env, src);
+    dc->npc = DYNAMIC_PC;
+}
+
+TRANS(WRPR_pstate, 64, do_wr_special, a, supervisor(dc), do_wrpstate)
+
+static void do_wrtl(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    save_state(dc);
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, tl));
+    dc->npc = DYNAMIC_PC;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_tl, 64, do_wr_special, a, supervisor(dc), do_wrtl)
+
+static void do_wrpil(DisasContext *dc, TCGv src)
+{
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_wrpil(tcg_env, src);
+}
+
+TRANS(WRPR_pil, 64, do_wr_special, a, supervisor(dc), do_wrpil)
+
+static void do_wrcwp(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrcwp(tcg_env, src);
+}
+
+TRANS(WRPR_cwp, 64, do_wr_special, a, supervisor(dc), do_wrcwp)
+
+static void do_wrcansave(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, cansave));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_cansave, 64, do_wr_special, a, supervisor(dc), do_wrcansave)
+
+static void do_wrcanrestore(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, canrestore));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_canrestore, 64, do_wr_special, a, supervisor(dc), do_wrcanrestore)
+
+static void do_wrcleanwin(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, cleanwin));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_cleanwin, 64, do_wr_special, a, supervisor(dc), do_wrcleanwin)
+
+static void do_wrotherwin(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, otherwin));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_otherwin, 64, do_wr_special, a, supervisor(dc), do_wrotherwin)
+
+static void do_wrwstate(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st32_tl(src, tcg_env, offsetof(CPUSPARCState, wstate));
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRPR_wstate, 64, do_wr_special, a, supervisor(dc), do_wrwstate)
+
+static void do_wrgl(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrgl(tcg_env, src);
+}
+
+TRANS(WRPR_gl, GL, do_wr_special, a, supervisor(dc), do_wrgl)
+
+/* UA2005 strand status */
+static void do_wrssr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_mov_tl(cpu_ssr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
+
 static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
 {
     if (!supervisor(dc)) {
@@ -4508,142 +4720,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
 #if !defined(CONFIG_USER_ONLY)
-                    case 0x32: /* wrwim, V9 wrpr */
-                        {
-                            if (!supervisor(dc))
-                                goto priv_insn;
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-#ifdef TARGET_SPARC64
-                            switch (rd) {
-                            case 0: // tpc
-                                {
-                                    TCGv_ptr r_tsptr;
-
-                                    r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr);
-                                    tcg_gen_st_tl(cpu_tmp0, r_tsptr,
-                                                  offsetof(trap_state, tpc));
-                                }
-                                break;
-                            case 1: // tnpc
-                                {
-                                    TCGv_ptr r_tsptr;
-
-                                    r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr);
-                                    tcg_gen_st_tl(cpu_tmp0, r_tsptr,
-                                                  offsetof(trap_state, tnpc));
-                                }
-                                break;
-                            case 2: // tstate
-                                {
-                                    TCGv_ptr r_tsptr;
-
-                                    r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr);
-                                    tcg_gen_st_tl(cpu_tmp0, r_tsptr,
-                                                  offsetof(trap_state,
-                                                           tstate));
-                                }
-                                break;
-                            case 3: // tt
-                                {
-                                    TCGv_ptr r_tsptr;
-
-                                    r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr);
-                                    tcg_gen_st32_tl(cpu_tmp0, r_tsptr,
-                                                    offsetof(trap_state, tt));
-                                }
-                                break;
-                            case 4: // tick
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, tick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_count(r_tickptr,
-                                                              cpu_tmp0);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-                            case 5: // tba
-                                tcg_gen_mov_tl(cpu_tbr, cpu_tmp0);
-                                break;
-                            case 6: // pstate
-                                save_state(dc);
-                                if (translator_io_start(&dc->base)) {
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                gen_helper_wrpstate(tcg_env, cpu_tmp0);
-                                dc->npc = DYNAMIC_PC;
-                                break;
-                            case 7: // tl
-                                save_state(dc);
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                               offsetof(CPUSPARCState, tl));
-                                dc->npc = DYNAMIC_PC;
-                                break;
-                            case 8: // pil
-                                if (translator_io_start(&dc->base)) {
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                gen_helper_wrpil(tcg_env, cpu_tmp0);
-                                break;
-                            case 9: // cwp
-                                gen_helper_wrcwp(tcg_env, cpu_tmp0);
-                                break;
-                            case 10: // cansave
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState,
-                                                         cansave));
-                                break;
-                            case 11: // canrestore
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState,
-                                                         canrestore));
-                                break;
-                            case 12: // cleanwin
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState,
-                                                         cleanwin));
-                                break;
-                            case 13: // otherwin
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState,
-                                                         otherwin));
-                                break;
-                            case 14: // wstate
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState,
-                                                         wstate));
-                                break;
-                            case 16: // UA2005 gl
-                                CHECK_IU_FEATURE(dc, GL);
-                                gen_helper_wrgl(tcg_env, cpu_tmp0);
-                                break;
-                            case 26: // UA2005 strand status
-                                CHECK_IU_FEATURE(dc, HYPV);
-                                if (!hypervisor(dc))
-                                    goto priv_insn;
-                                tcg_gen_mov_tl(cpu_ssr, cpu_tmp0);
-                                break;
-                            default:
-                                goto illegal_insn;
-                            }
-#else
-                            tcg_gen_trunc_tl_i32(cpu_wim, cpu_tmp0);
-                            if (dc->def->nwindows != 32) {
-                                tcg_gen_andi_tl(cpu_wim, cpu_wim,
-                                                (1 << dc->def->nwindows) - 1);
-                            }
-#endif
-                        }
-                        break;
+                    case 0x32:
+                        goto illegal_insn;  /* WRPR in decodetree */
                     case 0x33: /* wrtbr, UA2005 wrhpr */
                         {
 #ifndef TARGET_SPARC64
-- 
2.34.1


