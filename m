Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD77CBAAE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKM-0000cc-TN; Tue, 17 Oct 2023 02:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKH-0000V8-FL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKE-0003tu-SX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6bce254ba56so1746874b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523185; x=1698127985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNFFeSwgL0mBbKArIbcpwqvzDJa/OzeCcibZ2wQczXk=;
 b=f+wSTbyb9K51x8VTV8H90BY63G9Lgrg7i52cOTqqX5As3Q3Y8eCxOaqMcE+B8e3sm2
 7Ggq9JcxGM+JpeDX5YtC9NKAyYhBYLzqzYp7+wgz50PRDXU0CWfoOfCfA30Ss1iCyeDi
 v/Oc6oJ7PKNBURaYfUDFdZlz1fDJIqvX4CysxQUwa82YpBVHS5ivFDnmH47EkVG/a9DT
 HmZxvym65TpT4ERhu0RwmJh7VDbM94yhvNeRU7YQYy+30SwFAi8/2zZhXKj+kwZURhu2
 iYYUFG3/XKOEwHnoUBm3z3RrCVgO9//rFW45zV0VE56w78+tcgJk07ZRX+egt5saLfVY
 1QQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523185; x=1698127985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNFFeSwgL0mBbKArIbcpwqvzDJa/OzeCcibZ2wQczXk=;
 b=hax0+mgnn25l2uVMc/aRmZeIE8FcZjYE5x9szdpUYdDKQPxO992S2qZxdugRqQR8LS
 BU7A96abPUVAaSxEnR/vvdDdVpIhbbgdcVjDrAgftWjTNZZwDXEWmpUx59a6jUlrq2kX
 0BYbwIg9Abh+WTg2PjY2wxK/CnxA+lrp5+IIVb5xoJht+OCoVi//1JM7CN1ofepJjL4O
 GDYwYTqpLcaWJYFW34ys6xg1aUTciIg7PwgiLINN1cVsncj78pe+vOJNurUzTHHWAlRM
 BV7+r288jyVJ+vOcmBNCV4Jx9Zs7v2crWUgG/nfd5p2uS9EmSlyVm4mtSf3e6axvnk//
 AfuQ==
X-Gm-Message-State: AOJu0Ywkm3DvEuLbKlhUa3k6rcVHNgxo/dnQZei6I2T68XLq85nn1fkb
 C8cQgJQ2vloWw/DoBW98/v+4T/wjhSMzOcO/McI=
X-Google-Smtp-Source: AGHT+IESFvzjWXbfAROsxDIuPqNIzHEiWeb9twwB3YWdYbBtd0dRxjR/rPCoTkvY0t6TKKSxNCI/Sg==
X-Received: by 2002:a05:6a21:4842:b0:17a:cfce:5a30 with SMTP id
 au2-20020a056a21484200b0017acfce5a30mr1027730pzc.16.1697523185353; 
 Mon, 16 Oct 2023 23:13:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 23/90] target/sparc: Move RDWIM, RDPR to decodetree
Date: Mon, 16 Oct 2023 23:11:37 -0700
Message-Id: <20231017061244.681584-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/sparc/insns.decode |  22 +++
 target/sparc/translate.c  | 360 +++++++++++++++++++++++---------------
 2 files changed, 244 insertions(+), 138 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8b05b9d8f1..bab80514ba 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -55,3 +55,25 @@ RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
 RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
 RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
 RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdfe353596..9d01c53791 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -40,6 +40,7 @@
 #define gen_helper_rdpsr(D, E)     qemu_build_not_reached()
 #else
 #define gen_helper_rdccr(D, E)     qemu_build_not_reached()
+#define gen_helper_rdcwp(D, E)     qemu_build_not_reached()
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -59,9 +60,7 @@ static TCGv_i32 cpu_psr;
 static TCGv cpu_fsr, cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
-#ifndef CONFIG_USER_ONLY
 static TCGv cpu_tbr;
-#endif
 static TCGv cpu_cond;
 #ifdef TARGET_SPARC64
 static TCGv_i32 cpu_xcc, cpu_fprs;
@@ -2687,8 +2686,7 @@ static void gen_fmovq(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
     gen_update_fprs_dirty(dc, qd);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
+static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
 {
     TCGv_i32 r_tl = tcg_temp_new_i32();
 
@@ -2709,7 +2707,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr, TCGv_env tcg_env)
         tcg_gen_add_ptr(r_tsptr, r_tsptr, r_tl_tmp);
     }
 }
-#endif
 
 static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
                      int width, bool cc, bool left)
@@ -2848,6 +2845,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 
 /* Default case for non jump instructions. */
@@ -3404,6 +3402,221 @@ static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
 TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
       do_rdhstick_cmpr)
 
+static TCGv do_rdwim(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    qemu_build_not_reached();
+#else
+    return cpu_wim;
+#endif
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
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, pstate));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_pstate, 64, do_rd_special, supervisor(dc), a->rd, do_rdpstate)
+
+static TCGv do_rdtl(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, tl));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_tl, 64, do_rd_special, supervisor(dc), a->rd, do_rdtl)
+
+static TCGv do_rdpil(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, psrpil));
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
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, cansave));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_cansave, 64, do_rd_special, supervisor(dc), a->rd, do_rdcansave)
+
+static TCGv do_rdcanrestore(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, canrestore));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_canrestore, 64, do_rd_special, supervisor(dc), a->rd,
+      do_rdcanrestore)
+
+static TCGv do_rdcleanwin(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, cleanwin));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_cleanwin, 64, do_rd_special, supervisor(dc), a->rd, do_rdcleanwin)
+
+static TCGv do_rdotherwin(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, otherwin));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_otherwin, 64, do_rd_special, supervisor(dc), a->rd, do_rdotherwin)
+
+static TCGv do_rdwstate(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, wstate));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_wstate, 64, do_rd_special, supervisor(dc), a->rd, do_rdwstate)
+
+static TCGv do_rdgl(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, gl));
+    return dst;
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(RDPR_gl, GL, do_rd_special, supervisor(dc), a->rd, do_rdgl)
+
+/* UA2005 strand status */
+static TCGv do_rdssr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_ssr;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_strand_status, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdssr)
+
+static TCGv do_rdver(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_ver;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDPR_ver, 64, do_rd_special, supervisor(dc), a->rd, do_rdver)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3434,133 +3647,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -4406,7 +4492,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state, tpc));
                                 }
@@ -4416,7 +4502,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state, tnpc));
                                 }
@@ -4426,7 +4512,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st_tl(cpu_tmp0, r_tsptr,
                                                   offsetof(trap_state,
                                                            tstate));
@@ -4437,7 +4523,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                     TCGv_ptr r_tsptr;
 
                                     r_tsptr = tcg_temp_new_ptr();
-                                    gen_load_trap_state_at_tl(r_tsptr, tcg_env);
+                                    gen_load_trap_state_at_tl(r_tsptr);
                                     tcg_gen_st32_tl(cpu_tmp0, r_tsptr,
                                                     offsetof(trap_state, tt));
                                 }
@@ -5866,9 +5952,7 @@ void sparc_tcg_init(void)
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


