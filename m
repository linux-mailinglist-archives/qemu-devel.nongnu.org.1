Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 694587D2140
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWZ-0000mj-Pr; Sun, 22 Oct 2023 02:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWE-0000ay-Rw
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWC-0001b6-LC
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso18144605ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954455; x=1698559255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VO6vWcKYJslbm9/yoJ+t3ZpT4RSCM4gjLz6Gp/K2cjk=;
 b=RTbqnHknc5/JeZYC492ayledlAkUk5brRfGaTDVJdfy1hqZmP27v7Bc8gHQV3desOI
 BWTEHhoAUpCkolGOCEWCH6vDyhvRbM397uX+ArxI5HB/ONaKKkhMZu2Fwo1VvOWcmGiH
 xoji3GE6z7IUZ60/C3lvZO7nHvnbT/yl5BwzHzEKdhf/zNDrP7BNX+UtYy6xI3W0U+w6
 zF/lVl5x+fQkZB+FvTCl4/t9xBJkAaiFXf6MAF5/zjQXByTmU4TAM0V+wj5ps3MIWT4V
 6mLfT63/cQd/dM0SlQswUBDjmhs+mFWBeTEoEUgSIrDNNMZDmR5Ib2XzhcAJMaVVZ/yA
 QYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954455; x=1698559255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VO6vWcKYJslbm9/yoJ+t3ZpT4RSCM4gjLz6Gp/K2cjk=;
 b=h9fAbi1madfSr4CMl6C6ZrsIbcXGdCaznM+BP/CpksgbZAXO0ubIuhxRmkVR1KD9AK
 eXvmBpl+qy/CLW34lism4SZeMFA74IihmnMRYduc5Tu60eCiQMTSoDAVK2wP+dBhcTpT
 YyZ5XHFV7U30S9ug3lG/fr+vPy1QKJ5fBnLFvzTbj36Qqr7xe9dkMBejue+dpU89rO6N
 sjfVDjljzRSNwaxGTSxTOMFLVIWRoZNKqIbkvckLxOP2u3Wl4K0sXF99DMW6R1AiyqUm
 IQz3/vj0G2Eo/PFtsZP2GSS50f7NMvwXaX9UfA32lO8X3m2HtOwlBh8mcE/OtAUFusn2
 Uilg==
X-Gm-Message-State: AOJu0YxXp96bW9s3UDeCYAq6uKq1O/d9IussXyPf9t/vIiOPMpnle3F7
 lK5BASevvInIZ5qZ3PjiUmwE9WZZsseHIRnX2aE=
X-Google-Smtp-Source: AGHT+IHYM9VRw8RABWz5XU24vhW1PlVt+/YG0kUeZNe/nom8JWxwG00aZECb3jHVGg9hz7TBRjNHog==
X-Received: by 2002:a17:902:e0cb:b0:1c9:e85a:4296 with SMTP id
 e11-20020a170902e0cb00b001c9e85a4296mr5017699pla.6.1697954455166; 
 Sat, 21 Oct 2023 23:00:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 27/90] target/sparc: Move WRWIM, WRPR to decodetree
Date: Sat, 21 Oct 2023 22:59:28 -0700
Message-Id: <20231022060031.490251-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 8d1af552f8..8735cf1845 100644
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
@@ -3840,6 +3844,214 @@ static void do_wrpsr(DisasContext *dc, TCGv src)
 
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
@@ -4526,142 +4738,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


