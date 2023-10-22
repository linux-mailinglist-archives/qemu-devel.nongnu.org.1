Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B67D2705
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtf-0007Jt-1A; Sun, 22 Oct 2023 19:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtP-00079i-3z
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtM-0006mv-Og
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so2636660b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017394; x=1698622194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4JjGfXc1ZK0slmW0Mduo2FRxtvtvRQNj+3A0+w7cQs=;
 b=gYDCJGKyMIMVrfE17HC9EoxPDEZ5OO96iZs0DmvrAsrQSExNhl61UcvPiPtE12Lv7+
 DiwxvRAQflcO5Q402QaRcUrqEs9AuGINOfIRL7KOh/NLTGGRtgsD1fqpSe1ulOYwT8MB
 p4gOPNqqKYSMdkQfsJ4PeYtfPSnPUeuy9hYwnItdCZGXkyBB72fGdOVRwiHYS29wWSC7
 Ii52aPMaZFYtD+Qy7X/8+woB5wfAjr73J+BpnjiTqL8wPSoJVQ7WNEGy7G2JHN4lSO9X
 ZpRoESs1CcNudl88WSYVnY8+VcpMfH+ZrShK4Alfh4MBja4ypOE4J8lVDotsynEqUTcK
 h3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017394; x=1698622194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4JjGfXc1ZK0slmW0Mduo2FRxtvtvRQNj+3A0+w7cQs=;
 b=WR5FbBTwL/QLhlFWwZyMRjEioCY9RDrVxCgW9KL046AZHOIWIrdnWZ/ew1pkP8/3TY
 l9I+ZJ583/g2GMqoXuQrQc2wKVBCOr74/+zERyUbCtjMs9O0CXZurr5NojuWP6wv9V2H
 lNiMlanAOWeZ2UVn3s7EmWh3W9kQluXx/8eXaPmLPMCwYyenQVqVxEaC10fcBkUYkmKO
 rX/GJpZJIjUB/0AZEdCoRDZi1npV2/x/YzC+7k7X1XADZCjkRlri7zgkUcqUDPj0bgaV
 I0F/skGixEdcBz5AR9cJQJFPQuVNXii5C3neOgCIOJZKgSTgzLxhujOdeLPY0hVSI32U
 NT+A==
X-Gm-Message-State: AOJu0YwPtkauSHDbrx2UJMHhX+ocQlUSAC79ohZC5Y2d1paemQfF/YKG
 x9wSJrUJY8zWqvadmM1oRvP0Vgdnm6+4O/w66qc=
X-Google-Smtp-Source: AGHT+IEbZqoaLBblw5bXTKixOnXZ8Vx/YB35ktSJ14QesO9/rNkLMSTTwN4FbvAh/3byQAZ3Z9nC8A==
X-Received: by 2002:a05:6a00:13a6:b0:68a:5395:7aa5 with SMTP id
 t38-20020a056a0013a600b0068a53957aa5mr9839014pfg.17.1698017394413; 
 Sun, 22 Oct 2023 16:29:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 23/94] target/sparc: Move RDPSR, RDHPR to decodetree
Date: Sun, 22 Oct 2023 16:28:21 -0700
Message-Id: <20231022232932.80507-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/847
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  10 ++++
 target/sparc/translate.c  | 116 ++++++++++++++++++++++++--------------
 2 files changed, 83 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b084c5b97..a7d78eb6c6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -44,6 +44,16 @@ CALL    01 i:s30
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
 
+{
+  RDPSR             10 rd:5  101001 00000 0 0000000000000
+  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+}
+RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
+RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9af4578525..b58c2594ca 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -36,9 +36,12 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifndef TARGET_SPARC64
+#ifdef TARGET_SPARC64
+# define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+#else
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
+# define MAXTL_MASK                             0
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -71,8 +74,12 @@ static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
 static TCGv cpu_wim;
 # define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
-# define cpu_tick_cmpr          ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_hintp              ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_hstick_cmpr        ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_htba               ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_hver               ({ qemu_build_not_reached(); (TCGv)NULL; })
 # define cpu_stick_cmpr         ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_tick_cmpr          ({ qemu_build_not_reached(); (TCGv)NULL; })
 #endif
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
@@ -272,15 +279,14 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 /* moves */
 #ifdef CONFIG_USER_ONLY
 #define supervisor(dc) 0
-#ifdef TARGET_SPARC64
 #define hypervisor(dc) 0
-#endif
 #else
 #ifdef TARGET_SPARC64
 #define hypervisor(dc) (dc->hypervisor)
 #define supervisor(dc) (dc->supervisor | dc->hypervisor)
 #else
 #define supervisor(dc) (dc->supervisor)
+#define hypervisor(dc) 0
 #endif
 #endif
 
@@ -3320,6 +3326,69 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
 TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
+static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
+{
+    update_psr(dc);
+    gen_helper_rdpsr(dst, tcg_env);
+    return dst;
+}
+
+TRANS(RDPSR, 32, do_rd_special, supervisor(dc), a->rd, do_rdpsr)
+
+static TCGv do_rdhpstate(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld_tl(dst, tcg_env, env64_field_offsetof(hpstate));
+    return dst;
+}
+
+TRANS(RDHPR_hpstate, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhpstate)
+
+static TCGv do_rdhtstate(DisasContext *dc, TCGv dst)
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
+    tcg_gen_ld_tl(dst, tp, env64_field_offsetof(htstate));
+    return dst;
+}
+
+TRANS(RDHPR_htstate, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtstate)
+
+static TCGv do_rdhintp(DisasContext *dc, TCGv dst)
+{
+    return cpu_hintp;
+}
+
+TRANS(RDHPR_hintp, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhintp)
+
+static TCGv do_rdhtba(DisasContext *dc, TCGv dst)
+{
+    return cpu_htba;
+}
+
+TRANS(RDHPR_htba, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtba)
+
+static TCGv do_rdhver(DisasContext *dc, TCGv dst)
+{
+    return cpu_hver;
+}
+
+TRANS(RDHPR_hver, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhver)
+
+static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
+{
+    return cpu_hstick_cmpr;
+}
+
+TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
+      do_rdhstick_cmpr)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3351,45 +3420,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_tmp0 __attribute__((unused));
 
 #if !defined(CONFIG_USER_ONLY)
-            if (xop == 0x29) { /* rdpsr / UA2005 rdhpr */
-#ifndef TARGET_SPARC64
-                if (!supervisor(dc)) {
-                    goto priv_insn;
-                }
-                update_psr(dc);
-                gen_helper_rdpsr(cpu_dst, tcg_env);
-#else
-                CHECK_IU_FEATURE(dc, HYPV);
-                if (!hypervisor(dc))
-                    goto priv_insn;
-                rs1 = GET_FIELD(insn, 13, 17);
-                switch (rs1) {
-                case 0: // hpstate
-                    tcg_gen_ld_i64(cpu_dst, tcg_env,
-                                   offsetof(CPUSPARCState, hpstate));
-                    break;
-                case 1: // htstate
-                    // gen_op_rdhtstate();
-                    break;
-                case 3: // hintp
-                    tcg_gen_mov_tl(cpu_dst, cpu_hintp);
-                    break;
-                case 5: // htba
-                    tcg_gen_mov_tl(cpu_dst, cpu_htba);
-                    break;
-                case 6: // hver
-                    tcg_gen_mov_tl(cpu_dst, cpu_hver);
-                    break;
-                case 31: // hstick_cmpr
-                    tcg_gen_mov_tl(cpu_dst, cpu_hstick_cmpr);
-                    break;
-                default:
-                    goto illegal_insn;
-                }
-#endif
-                gen_store_gpr(dc, rd, cpu_dst);
-                break;
-            }
             if (xop == 0x2a) { /* rdwim / V9 rdpr */
                 if (!supervisor(dc)) {
                     goto priv_insn;
-- 
2.34.1


