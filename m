Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7520C7D796F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6f-000261-RF; Wed, 25 Oct 2023 20:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-00013a-A8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo62-0006dP-6n
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so2219265ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279572; x=1698884372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRKpWuzD73nLvUgHfXSktD82HmfIC39HF668MZpjq5M=;
 b=a9okAxE7NNTwnJTd/84QZDiZsy4ar1bPwOIhM4LV86FVlgxNeyw2cf3Ti7fIll0+sc
 EoF+k/mYSl0e2bCqZBwhikq33DupW693VOH5m1Wfs5HIzGKYN+CvCDGP2qO53aLmzOc4
 //BYeuDJtq6Jh1U9kdGPwLfNSttw5E/mplAgJivvanl1KFEEaHmHbvpf9YBzQbvWSO4I
 AjKm+SHX56CEMq7ga1qVTwQ6KHmGjpWoC0ElR0b9kVB7xNoHNhLl+UdIbopEGejOu7dH
 sPszECaXR05b5mJCWEeforVEG+biBN5rTcZwqs1YYHdB7DguIEDfYVXgg/bWOsGhY5e+
 +ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279572; x=1698884372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRKpWuzD73nLvUgHfXSktD82HmfIC39HF668MZpjq5M=;
 b=L7+EHZGNu+El8/KSaYrhRA/bYqozzkxR31euGH+Mf6sywQ6dBP6C21XXKj7C4dGTys
 xe5NdZX/HpqN49RuFNLTJw8kQDy9u3+ifGY31L2FD0ZgByD/GUINQY2SDkWOgc09Xl6C
 GnI84gIJxW5HjDja9rbbVyNMZe410J7vVjtEDYv6tp8cV5pmdv3PK4EaixATQR11DsY9
 QIng79wTKCEHgY1ialZBxR7VXUef8NXy4w7FA11LLhb09cCl40gwy7KAhhP4r9y42+gF
 nwRsnWMJw2rzTocSknd7fnVcAUzZHFOIK/oUnSqhUBNhkOvcm1EdN1Oi6Ht040glQcMr
 WAuw==
X-Gm-Message-State: AOJu0Yx9WTvZiwaWW1BjkuFjEBggOft+4ZkXopos23DyFfDYy7x0sBie
 R2SbXlJMlIplhRHYS+wvOE2B2AjAFmpRnDqHFJU=
X-Google-Smtp-Source: AGHT+IEby4tBSU132ovJd1L0V6L1/VsQA0yRhQFGl+zzItpKOUv8MZ5sbTX+6r3z1Xaos+RNpPAOMw==
X-Received: by 2002:a17:903:2291:b0:1c0:a5c9:e072 with SMTP id
 b17-20020a170903229100b001c0a5c9e072mr16183057plh.11.1698279572469; 
 Wed, 25 Oct 2023 17:19:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 29/94] target/sparc: Move WRTBR, WRHPR to decodetree
Date: Wed, 25 Oct 2023 17:14:37 -0700
Message-Id: <20231026001542.1141412-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Implement htstate in the obvious way.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   9 ++++
 target/sparc/translate.c  | 111 +++++++++++++++++++-------------------
 2 files changed, 66 insertions(+), 54 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f478999ee1..eab737fdcc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -143,6 +143,15 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
   RDTBR     10 rd:5  101011 00000 0 0000000000000
 }
 
+{
+  WRTBR             10 00000 110011 ..... . .............  @n_r_ri
+  WRHPR_hpstate     10 00000 110011 ..... . .............  @n_r_ri
+}
+WRHPR_htstate       10 00001 110011 ..... . .............  @n_r_ri
+WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
+WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
+WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9b82e2bf6f..d87c08c18c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -50,6 +50,7 @@
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define gen_helper_tick_set_count(P, S)        qemu_build_not_reached()
+# define gen_helper_tick_set_limit(P, S)        qemu_build_not_reached()
 # define gen_helper_wrccr(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrcwp(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrgl(E, S)                  qemu_build_not_reached()
@@ -3935,6 +3936,61 @@ static void do_wrssr(DisasContext *dc, TCGv src)
 
 TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
 
+TRANS(WRTBR, 32, do_wr_special, a, supervisor(dc), do_wrtba)
+
+static void do_wrhpstate(DisasContext *dc, TCGv src)
+{
+    tcg_gen_st_tl(src, tcg_env, env64_field_offsetof(hpstate));
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRHPR_hpstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhpstate)
+
+static void do_wrhtstate(DisasContext *dc, TCGv src)
+{
+    TCGv_i32 tl = tcg_temp_new_i32();
+    TCGv_ptr tp = tcg_temp_new_ptr();
+
+    tcg_gen_ld_i32(tl, tcg_env, env64_field_offsetof(tl));
+    tcg_gen_andi_i32(tl, tl, MAXTL_MASK);
+    tcg_gen_shli_i32(tl, tl, 3);
+    tcg_gen_ext_i32_ptr(tp, tl);
+    tcg_gen_add_ptr(tp, tp, tcg_env);
+
+    tcg_gen_st_tl(src, tp, env64_field_offsetof(htstate));
+}
+
+TRANS(WRHPR_htstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtstate)
+
+static void do_wrhintp(DisasContext *dc, TCGv src)
+{
+    tcg_gen_mov_tl(cpu_hintp, src);
+}
+
+TRANS(WRHPR_hintp, HYPV, do_wr_special, a, hypervisor(dc), do_wrhintp)
+
+static void do_wrhtba(DisasContext *dc, TCGv src)
+{
+    tcg_gen_mov_tl(cpu_htba, src);
+}
+
+TRANS(WRHPR_htba, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtba)
+
+static void do_wrhstick_cmpr(DisasContext *dc, TCGv src)
+{
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(cpu_hstick_cmpr, src);
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(hstick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_limit(r_tickptr, cpu_hstick_cmpr);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRHPR_hstick_cmpr, HYPV, do_wr_special, a, hypervisor(dc),
+      do_wrhstick_cmpr)
+
 static bool do_saved_restored(DisasContext *dc, bool saved)
 {
     if (!supervisor(dc)) {
@@ -4624,63 +4680,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
-#if !defined(CONFIG_USER_ONLY)
                     case 0x32:
                         goto illegal_insn;  /* WRPR in decodetree */
                     case 0x33: /* wrtbr, UA2005 wrhpr */
-                        {
-#ifndef TARGET_SPARC64
-                            if (!supervisor(dc))
-                                goto priv_insn;
-                            tcg_gen_xor_tl(cpu_tbr, cpu_src1, cpu_src2);
-#else
-                            CHECK_IU_FEATURE(dc, HYPV);
-                            if (!hypervisor(dc))
-                                goto priv_insn;
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                            switch (rd) {
-                            case 0: // hpstate
-                                tcg_gen_st_i64(cpu_tmp0, tcg_env,
-                                               offsetof(CPUSPARCState,
-                                                        hpstate));
-                                save_state(dc);
-                                gen_op_next_insn();
-                                tcg_gen_exit_tb(NULL, 0);
-                                dc->base.is_jmp = DISAS_NORETURN;
-                                break;
-                            case 1: // htstate
-                                // XXX gen_op_wrhtstate();
-                                break;
-                            case 3: // hintp
-                                tcg_gen_mov_tl(cpu_hintp, cpu_tmp0);
-                                break;
-                            case 5: // htba
-                                tcg_gen_mov_tl(cpu_htba, cpu_tmp0);
-                                break;
-                            case 31: // hstick_cmpr
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    tcg_gen_mov_tl(cpu_hstick_cmpr, cpu_tmp0);
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, hstick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_limit(r_tickptr,
-                                                              cpu_hstick_cmpr);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-                            case 6: // hver readonly
-                            default:
-                                goto illegal_insn;
-                            }
-#endif
-                        }
-                        break;
-#endif
+                        goto illegal_insn;  /* WRTBR, WRHPR in decodetree */
 #ifdef TARGET_SPARC64
                     case 0x2c: /* V9 movcc */
                         {
-- 
2.34.1


