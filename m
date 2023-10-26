Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B27D7969
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6G-00018L-Ux; Wed, 25 Oct 2023 20:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo61-0000qp-OE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5s-0006bU-TZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ca052ec63bso2398225ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279563; x=1698884363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEBBC87M+M74G9VePVYzj1ubW0xjjFngqxM/dIsRAKg=;
 b=HR8FXZEroRUyaYMAPNG8GQj6xTeuXwt1XF/SkkFTF7K8GMSaaYPX69bvGDN0KlkyQ5
 V8sKsLvXFf1EA+mSxGSXluUSx2fuOc3oTV5FutaHuy/7mFC+dNJg31dpItreoR9LylHE
 7lR9H7SKVoxzGZpIdceBtB3XdnzcwMbYtqHd4SdwjE4uzKuzgOmuxWndKoep3KGnm1Ll
 uJHYDiM6yILmpuQTm8Wpi2ND1BC6bgJkLsJZoj7l8ioBsSvn+h4wD3ptXtjryTmZTQkh
 iZX3aIqRbiCmD5rm9TPCDRJ5cU71YSywwb3ikoZg56yh3iwWUIN2ya8pWe/MzcnuOQ2T
 h6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279563; x=1698884363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEBBC87M+M74G9VePVYzj1ubW0xjjFngqxM/dIsRAKg=;
 b=ZqpMPyUDYM0ZdO5QEnvHOVTcqokZS8mT/+bG40ONGoCy1hjzTJE7o+YoUzkq2oUuZg
 v4lZqIv9VINq5ojodgQJU/efXmS7n8Yj1aQIfsipfPufAzip/epGQ2NdUvhJ3mwZGv8U
 f4XRTay8ZkuaCsvHL+TDm316xWLVjqa4++u24LjrPr8unn3v3Cb9BcahGW5H33OBlvGr
 DYeMc4HRYTUog2S/1HEgJ/0bs3eIR5p4VnQVv9K6AtNYFNzJwi1kl//P4sEexv44VucE
 D7PyRrbHTUzvgY32Dr/eGXiJJirEas6szgMAIXovZqRuDiYQR/6MmImvF1NNbPy4Q/YY
 YQZg==
X-Gm-Message-State: AOJu0YxiQ66UWrxbyGdTGeo5/fzJbTnbFeRAKqzsRHRpc6d8v57LcJ70
 /h6mjwqB52x+T5SCOXbph+lAd58UFr7wBCuIxZw=
X-Google-Smtp-Source: AGHT+IHXYhpgv4CkwiCy2MWcQj2nqH1QYaauBSlThbDoavAk5lZr5DZhBr8Z74VSd9/gtxtRiCHnpA==
X-Received: by 2002:a17:903:28c4:b0:1b8:66f6:87a3 with SMTP id
 kv4-20020a17090328c400b001b866f687a3mr13818818plb.52.1698279563633; 
 Wed, 25 Oct 2023 17:19:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 24/94] target/sparc: Move RDWIM, RDPR to decodetree
Date: Wed, 25 Oct 2023 17:14:26 -0700
Message-Id: <20231026001542.1141412-48-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  22 +++
 target/sparc/translate.c  | 320 ++++++++++++++++++++++----------------
 2 files changed, 204 insertions(+), 138 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a7d78eb6c6..7d91a7bc83 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -54,6 +54,28 @@ RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
 RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
 RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
+{
+  RDWIM             10 rd:5  101010 00000 0 0000000000000
+  RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
+}
+RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
+RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
+RDPR_tt             10 rd:5  101010 00011 0 0000000000000
+RDPR_tick           10 rd:5  101010 00100 0 0000000000000
+RDPR_tba            10 rd:5  101010 00101 0 0000000000000
+RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
+RDPR_tl             10 rd:5  101010 00111 0 0000000000000
+RDPR_pil            10 rd:5  101010 01000 0 0000000000000
+RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
+RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
+RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
+RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
+RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
+RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
+RDPR_gl             10 rd:5  101010 10000 0 0000000000000
+RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
+RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b58c2594ca..6e415d7070 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -40,6 +40,7 @@
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
 #else
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
 # define MAXTL_MASK                             0
 #endif
@@ -61,15 +62,14 @@ static TCGv_i32 cpu_psr;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
-#ifndef CONFIG_USER_ONLY
 static TCGv cpu_tbr;
-#endif
 static TCGv cpu_cond;
 #ifdef TARGET_SPARC64
 static TCGv_i32 cpu_xcc, cpu_fprs;
 static TCGv cpu_gsr;
 static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
+# define cpu_wim                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #else
 static TCGv cpu_wim;
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
@@ -78,8 +78,10 @@ static TCGv cpu_wim;
 # define cpu_hstick_cmpr        ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_htba               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_hver               ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_ssr                ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_stick_cmpr         ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_tick_cmpr          ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_ver                ({ qemu_build_not_reached(); (TCGv)NULL; })
 #endif
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
@@ -2709,8 +2711,7 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
     gen_update_fprs_dirty(dc, qd);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
+static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
 
@@ -2731,7 +2732,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
         tcg_gen_add_ptr(r_tsptr, r_tsptr, r_tl_tmp);
     }
 }
-#endif
 
 static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
                      int width, bool cc, bool left)
@@ -2866,11 +2866,13 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_32(C)      false
 # define avail_ASR17(C)   false
 # define avail_64(C)      true
+# define avail_GL(C)      ((C)->def->features & CPU_FEATURE_GL)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
 # define avail_64(C)      false
+# define avail_GL(C)      false
 # define avail_HYPV(C)    false
 #endif
 
@@ -3389,6 +3391,177 @@ static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
 TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
       do_rdhstick_cmpr)
 
+static TCGv do_rdwim(DisasContext *dc, TCGv dst)
+{
+    return cpu_wim;
+}
+
+TRANS(RDWIM, 32, do_rd_special, supervisor(dc), a->rd, do_rdwim)
+
+static TCGv do_rdtpc(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_ld_tl(dst, r_tsptr, offsetof(trap_state, tpc));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_tpc, 64, do_rd_special, supervisor(dc), a->rd, do_rdtpc)
+
+static TCGv do_rdtnpc(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_ld_tl(dst, r_tsptr, offsetof(trap_state, tnpc));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_tnpc, 64, do_rd_special, supervisor(dc), a->rd, do_rdtnpc)
+
+static TCGv do_rdtstate(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_ld_tl(dst, r_tsptr, offsetof(trap_state, tstate));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_tstate, 64, do_rd_special, supervisor(dc), a->rd, do_rdtstate)
+
+static TCGv do_rdtt(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tsptr = tcg_temp_new_ptr();
+
+    gen_load_trap_state_at_tl(r_tsptr);
+    tcg_gen_ld32s_tl(dst, r_tsptr, offsetof(trap_state, tt));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_tt, 64, do_rd_special, supervisor(dc), a->rd, do_rdtt)
+TRANS(RDPR_tick, 64, do_rd_special, supervisor(dc), a->rd, do_rdtick)
+
+static TCGv do_rdtba(DisasContext *dc, TCGv dst)
+{
+    return cpu_tbr;
+}
+
+TRANS(RDPR_tba, 64, do_rd_special, supervisor(dc), a->rd, do_rdtba)
+
+static TCGv do_rdpstate(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(pstate));
+    return dst;
+}
+
+TRANS(RDPR_pstate, 64, do_rd_special, supervisor(dc), a->rd, do_rdpstate)
+
+static TCGv do_rdtl(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(tl));
+    return dst;
+}
+
+TRANS(RDPR_tl, 64, do_rd_special, supervisor(dc), a->rd, do_rdtl)
+
+static TCGv do_rdpil(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env_field_offsetof(psrpil));
+    return dst;
+}
+
+TRANS(RDPR_pil, 64, do_rd_special, supervisor(dc), a->rd, do_rdpil)
+
+static TCGv do_rdcwp(DisasContext *dc, TCGv dst)
+{
+    gen_helper_rdcwp(dst, tcg_env);
+    return dst;
+}
+
+TRANS(RDPR_cwp, 64, do_rd_special, supervisor(dc), a->rd, do_rdcwp)
+
+static TCGv do_rdcansave(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(cansave));
+    return dst;
+}
+
+TRANS(RDPR_cansave, 64, do_rd_special, supervisor(dc), a->rd, do_rdcansave)
+
+static TCGv do_rdcanrestore(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(canrestore));
+    return dst;
+}
+
+TRANS(RDPR_canrestore, 64, do_rd_special, supervisor(dc), a->rd,
+      do_rdcanrestore)
+
+static TCGv do_rdcleanwin(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(cleanwin));
+    return dst;
+}
+
+TRANS(RDPR_cleanwin, 64, do_rd_special, supervisor(dc), a->rd, do_rdcleanwin)
+
+static TCGv do_rdotherwin(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(otherwin));
+    return dst;
+}
+
+TRANS(RDPR_otherwin, 64, do_rd_special, supervisor(dc), a->rd, do_rdotherwin)
+
+static TCGv do_rdwstate(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(wstate));
+    return dst;
+}
+
+TRANS(RDPR_wstate, 64, do_rd_special, supervisor(dc), a->rd, do_rdwstate)
+
+static TCGv do_rdgl(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(gl));
+    return dst;
+}
+
+TRANS(RDPR_gl, GL, do_rd_special, supervisor(dc), a->rd, do_rdgl)
+
+/* UA2005 strand status */
+static TCGv do_rdssr(DisasContext *dc, TCGv dst)
+{
+    return cpu_ssr;
+}
+
+TRANS(RDPR_strand_status, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdssr)
+
+static TCGv do_rdver(DisasContext *dc, TCGv dst)
+{
+    return cpu_ver;
+}
+
+TRANS(RDPR_ver, 64, do_rd_special, supervisor(dc), a->rd, do_rdver)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3419,133 +3592,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
             TCGv cpu_tmp0 __attribute__((unused));
 
-#if !defined(CONFIG_USER_ONLY)
-            if (xop == 0x2a) { /* rdwim / V9 rdpr */
-                if (!supervisor(dc)) {
-                    goto priv_insn;
-                }
-                cpu_tmp0 = tcg_temp_new();
-#ifdef TARGET_SPARC64
-                rs1 = GET_FIELD(insn, 13, 17);
-                switch (rs1) {
-                case 0: // tpc
-                    {
-                        TCGv_ptr r_tsptr;
-
-                        r_tsptr = tcg_temp_new_ptr();
-                        gen_load_trap_state_at_tl(r_tsptr, tcg_env);
-                        tcg_gen_ld_tl(cpu_tmp0, r_tsptr,
-                                      offsetof(trap_state, tpc));
-                    }
-                    break;
-                case 1: // tnpc
-                    {
-                        TCGv_ptr r_tsptr;
-
-                        r_tsptr = tcg_temp_new_ptr();
-                        gen_load_trap_state_at_tl(r_tsptr, tcg_env);
-                        tcg_gen_ld_tl(cpu_tmp0, r_tsptr,
-                                      offsetof(trap_state, tnpc));
-                    }
-                    break;
-                case 2: // tstate
-                    {
-                        TCGv_ptr r_tsptr;
-
-                        r_tsptr = tcg_temp_new_ptr();
-                        gen_load_trap_state_at_tl(r_tsptr, tcg_env);
-                        tcg_gen_ld_tl(cpu_tmp0, r_tsptr,
-                                      offsetof(trap_state, tstate));
-                    }
-                    break;
-                case 3: // tt
-                    {
-                        TCGv_ptr r_tsptr = tcg_temp_new_ptr();
-
-                        gen_load_trap_state_at_tl(r_tsptr, tcg_env);
-                        tcg_gen_ld32s_tl(cpu_tmp0, r_tsptr,
-                                         offsetof(trap_state, tt));
-                    }
-                    break;
-                case 4: // tick
-                    {
-                        TCGv_ptr r_tickptr;
-                        TCGv_i32 r_const;
-
-                        r_tickptr = tcg_temp_new_ptr();
-                        r_const = tcg_constant_i32(dc->mem_idx);
-                        tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                       offsetof(CPUSPARCState, tick));
-                        if (translator_io_start(&dc->base)) {
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
-                        gen_helper_tick_get_count(cpu_tmp0, tcg_env,
-                                                  r_tickptr, r_const);
-                    }
-                    break;
-                case 5: // tba
-                    tcg_gen_mov_tl(cpu_tmp0, cpu_tbr);
-                    break;
-                case 6: // pstate
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, pstate));
-                    break;
-                case 7: // tl
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, tl));
-                    break;
-                case 8: // pil
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, psrpil));
-                    break;
-                case 9: // cwp
-                    gen_helper_rdcwp(cpu_tmp0, tcg_env);
-                    break;
-                case 10: // cansave
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, cansave));
-                    break;
-                case 11: // canrestore
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, canrestore));
-                    break;
-                case 12: // cleanwin
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, cleanwin));
-                    break;
-                case 13: // otherwin
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, otherwin));
-                    break;
-                case 14: // wstate
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, wstate));
-                    break;
-                case 16: // UA2005 gl
-                    CHECK_IU_FEATURE(dc, GL);
-                    tcg_gen_ld32s_tl(cpu_tmp0, tcg_env,
-                                     offsetof(CPUSPARCState, gl));
-                    break;
-                case 26: // UA2005 strand status
-                    CHECK_IU_FEATURE(dc, HYPV);
-                    if (!hypervisor(dc))
-                        goto priv_insn;
-                    tcg_gen_mov_tl(cpu_tmp0, cpu_ssr);
-                    break;
-                case 31: // ver
-                    tcg_gen_mov_tl(cpu_tmp0, cpu_ver);
-                    break;
-                case 15: // fq
-                default:
-                    goto illegal_insn;
-                }
-#else
-                tcg_gen_ext_i32_tl(cpu_tmp0, cpu_wim);
-#endif
-                gen_store_gpr(dc, rd, cpu_tmp0);
-                break;
-            }
-#endif
 #if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
             if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
@@ -4391,7 +4437,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state, tpc));
                                 }
@@ -4401,7 +4447,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state, tnpc));
                                 }
@@ -4411,7 +4457,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state,
                                                            tstate));
@@ -4422,7 +4468,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st32_tl(cpu_tmp0, r_tsptr,
                                                     offsetof(trap_state, tt));
                                 }
@@ -5851,9 +5897,7 @@ void sparc_tcg_init(void)
         { &cpu_pc, offsetof(CPUSPARCState, pc), "pc" },
         { &cpu_npc, offsetof(CPUSPARCState, npc), "npc" },
         { &cpu_y, offsetof(CPUSPARCState, y), "y" },
-#ifndef CONFIG_USER_ONLY
         { &cpu_tbr, offsetof(CPUSPARCState, tbr), "tbr" },
-#endif
     };
 
     unsigned int i;
-- 
2.34.1


