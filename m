Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A405D7D1B11
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:41:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bL-0007Kq-8V; Sat, 21 Oct 2023 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4az-0007Ci-Mn
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4ax-0008Qf-H4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so1445926b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866338; x=1698471138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npycK8wu5R5OLbJFhSwcX1YA44oEJe9mrbGlIxuK8uM=;
 b=oyIY166DD0CEc84c6bQWkU/x0ZEeW/9dVah1f+yE/BcFd1x94m599htovt2nl+qQI/
 0d4iklNZaI1vJqQbNL7N9/6ulB2ZDwajEyVPYRq0cmMCd/zJyis5QEmUBV0YfkvXVmku
 ccdwbRLbNKf6f0hu3h114ex7/eyuHKuBm7eqyMmi7YP5Th9U1AWiULzJj/RTsdlmjpx4
 qRZARKmC3QwJgbgh8mjFulW8hSzHkFhENNYamPbixEJ/ACVDnN/5iUWChDyfmfYx8SUb
 eMM2MrzuVP6NqRtjtiUX70RFfrf71S74e3K6rcnrVNBsmKqSLYsz1JqzBCGG5A8Y/iU9
 Uimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866338; x=1698471138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npycK8wu5R5OLbJFhSwcX1YA44oEJe9mrbGlIxuK8uM=;
 b=u1DIFL2RkgnTOAUsqDdy2vtLugzabR28oVAkezjBiygy6LT1eA/Ry40c1KlwyI1sHz
 d2BbwArnvwg8QMM1oB2P5G8amuuPlPxKwaVK3LJFyfYr+w0d5J6e9mJzOXiPhQQydznv
 PMcPvNIPXZ3sUDQsEcimdqmCngFD+fBLXWFGuYrAhJfUAXH+MS1mov7Z2IvfOB1APM+P
 HgZ9Rgyz6CkdiPXHtR2G9fCMVHwCKelMfo72hbhRsVlJRCBp26zLNzz4UChRNy0oaGwo
 M+DLkj9Ouy2EXSAdRGa61hKQDFAV/ydt8I0cTnOgN4cNb7urBcJ2oyIoXKYlZdv2AikU
 4E+g==
X-Gm-Message-State: AOJu0YwfAFkbYNBn5MFOH7al/2/30o8296tArAAIpqsOdgVhQ0TSgyHp
 hWNGUirUh3HUJC/GqzFDhfhXI7eoU6qNwf6Qo/g=
X-Google-Smtp-Source: AGHT+IFKka7lW1Ah1tgYiMlu4myEG2t5AymzRKQyfk7OY7e427pZVe6h57BfSerdl2QPVmfOXU/JQA==
X-Received: by 2002:aa7:97b9:0:b0:6be:334c:6fd1 with SMTP id
 d25-20020aa797b9000000b006be334c6fd1mr3354108pfq.26.1697866338335; 
 Fri, 20 Oct 2023 22:32:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 22/90] target/sparc: Move RDPSR, RDHPR to decodetree
Date: Fri, 20 Oct 2023 22:30:50 -0700
Message-Id: <20231021053158.278135-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  10 ++++
 target/sparc/translate.c  | 112 ++++++++++++++++++++++++--------------
 2 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b084c5b97..ac545c6821 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -44,6 +44,16 @@ CALL    01 i:s30
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
 
+{
+  RDPSR             10 rd:5  101001 00000 0 0000000000000
+  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+}
+# RDHPR_tstate
+RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 81de714aa6..c6e137a235 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -36,7 +36,9 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-#ifndef TARGET_SPARC64
+#ifdef TARGET_SPARC64
+#define gen_helper_rdpsr(D, E)     qemu_build_not_reached()
+#else
 #define gen_helper_rdccr(D, E)     qemu_build_not_reached()
 #endif
 
@@ -260,15 +262,14 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
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
 
@@ -3334,6 +3335,72 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
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
+#ifdef TARGET_SPARC64
+    tcg_gen_ld_i64(dst, tcg_env, offsetof(CPUSPARCState, hpstate));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hpstate, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhpstate)
+
+static TCGv do_rdhintp(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hintp;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hintp, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhintp)
+
+static TCGv do_rdhtba(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_htba;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_htba, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhtba)
+
+static TCGv do_rdhver(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hver;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hver, HYPV, do_rd_special, hypervisor(dc), a->rd, do_rdhver)
+
+static TCGv do_rdhstick_cmpr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_hstick_cmpr;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDHPR_hstick_cmpr, HYPV, do_rd_special, hypervisor(dc), a->rd,
+      do_rdhstick_cmpr)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3365,45 +3432,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


