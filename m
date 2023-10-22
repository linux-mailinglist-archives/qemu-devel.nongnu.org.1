Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536F7D26F9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:31:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtf-0007K1-3C; Sun, 22 Oct 2023 19:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtS-0007C1-JK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:02 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtQ-0006oN-76
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1934106b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017399; x=1698622199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbJ5KxWyhlR+ZXSgbwYcSWOLjJWJ7eGX43nHAlQDHUg=;
 b=sUzzFUlQQCFprqIQD9os64uF7hHTRkFaEDBtG64hjXWD2SuaeW0TM4AyLCtaRovAmL
 2wHlLcmHq1QZ4hCdHkRMyO3dGcn/GY/EQK5hxlMht0IKwBLoomoTs90yMiOwrQMlalrG
 oFCucUNToOQQmm4F2UvnJpFERoThH0eRrqSIBIa9LgDNLus+jk4ZHx2KrcVrcDqbkTrR
 xAsGKdghmb8jZecsCJcjYkLkjZNqSFaGbJYtA40q7RgqWXV6VL5f4FF8rix8SBPiUiUS
 v59N8qbfwUvbukYqflCRsz+Bo+fa3icM7w7y6DHnxoORGevgKMLktaZOM4/0ow+ayup0
 k25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017399; x=1698622199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbJ5KxWyhlR+ZXSgbwYcSWOLjJWJ7eGX43nHAlQDHUg=;
 b=hXjyuYVV2SpR+nrXBuuGTstB57Iz4ceN1TZpM8LSRt3AzgpI9KdfDxwXFn//9t5adJ
 pjgoNT3bLN2b5ElkJnWaa4w5qff+hnVmnMGEkrl5IoTRi5Hn6xf5r/tQ9kXHVZi0aY5G
 8QJz6S6hxAtM215vSScAhgwibZ0idsYoh7wW3WY3pmqcvMAoWOuAa5WZW7Y9VUayk7z0
 kF2LmZtam5GACbobQypzJYv1IMyr7f2NGX4IWfN3hA/oTQAM8jeHKQ9tgc8dFtJuhqwy
 Xy2h0i2JBOCdJ4SmaNHNrxBiPUPdJuWMcvR+f/7IMd8XaZdhnwZfK5rlmIhV2RyzKL4q
 z5Lg==
X-Gm-Message-State: AOJu0YxJwnAxTXdyI6rG6fYFXg6VJQPbbB9P4LMU6+QfN7MBBD83PtBX
 XJk088mIk79u98ZuhKYgNVEfhVPQT+PrqFVxmjY=
X-Google-Smtp-Source: AGHT+IGKbW8hn5HQtxvvIQvLsapjuuXQOPDg0p0eVDYJecaYnEE+ZxCb22cE871iy5UBYCKfYjeaSg==
X-Received: by 2002:a05:6a00:18a6:b0:68f:ce6a:8685 with SMTP id
 x38-20020a056a0018a600b0068fce6a8685mr10412717pfh.14.1698017398751; 
 Sun, 22 Oct 2023 16:29:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 28/94] target/sparc: Move WRWIM, WRPR to decodetree
Date: Sun, 22 Oct 2023 16:28:26 -0700
Message-Id: <20231022232932.80507-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  21 +++
 target/sparc/translate.c  | 315 ++++++++++++++++++++++----------------
 2 files changed, 200 insertions(+), 136 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 45cf47a32f..f478999ee1 100644
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
index 58ea3b2ba7..9b82e2bf6f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -49,8 +49,13 @@
 # define gen_helper_saved(E)                    qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
+# define gen_helper_tick_set_count(P, S)        qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
+# define gen_helper_wrcwp(E, S)                 qemu_build_not_reached()
+# define gen_helper_wrgl(E, S)                  qemu_build_not_reached()
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
+# define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
+# define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
 # define MAXTL_MASK                             0
 #endif
 
@@ -3758,6 +3763,178 @@ static void do_wrpsr(DisasContext *dc, TCGv src)
 
 TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
 
+static void do_wrwim(DisasContext *dc, TCGv src)
+{
+    target_ulong mask = MAKE_64BIT_MASK(0, dc->def->nwindows);
+    tcg_gen_andi_tl(cpu_wim, src, mask);
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
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(tick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_count(r_tickptr, src);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
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
+    save_state(dc);
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(tl));
+    dc->npc = DYNAMIC_PC;
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
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(cansave));
+}
+
+TRANS(WRPR_cansave, 64, do_wr_special, a, supervisor(dc), do_wrcansave)
+
+static void do_wrcanrestore(DisasContext *dc, TCGv src)
+{
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(canrestore));
+}
+
+TRANS(WRPR_canrestore, 64, do_wr_special, a, supervisor(dc), do_wrcanrestore)
+
+static void do_wrcleanwin(DisasContext *dc, TCGv src)
+{
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(cleanwin));
+}
+
+TRANS(WRPR_cleanwin, 64, do_wr_special, a, supervisor(dc), do_wrcleanwin)
+
+static void do_wrotherwin(DisasContext *dc, TCGv src)
+{
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(otherwin));
+}
+
+TRANS(WRPR_otherwin, 64, do_wr_special, a, supervisor(dc), do_wrotherwin)
+
+static void do_wrwstate(DisasContext *dc, TCGv src)
+{
+    tcg_gen_st32_tl(src, tcg_env, env64_field_offsetof(wstate));
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
+    tcg_gen_mov_tl(cpu_ssr, src);
+}
+
+TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
+
 static bool do_saved_restored(DisasContext *dc, bool saved)
 {
     if (!supervisor(dc)) {
@@ -4448,142 +4625,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


