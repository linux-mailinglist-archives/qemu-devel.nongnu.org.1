Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD147C8F25
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPic-0006H0-IZ; Fri, 13 Oct 2023 17:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiZ-0006GN-Fw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:11 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiU-0000Te-KH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:10 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35757bfb3f7so8652445ab.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232544; x=1697837344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1oI+8GMLDR5DVCaCGuMrw+ON657pFUNlq64syrOQWw=;
 b=qkLbXRbPs1FLURkPEC1Ew/a2MsQZHJl4rlMS8slNmAZ+Wg1RNYDnGMFOtHUzHd6l4V
 U1ZChl2eVaDW04w1JE97ZmmEbbeAUy/6CeM9YWaa70lvf/OupE3ZuaR3dR4x2ZpBUET7
 tv+E7GijpxUuFap0QdMmPOl3/p/9kXQf5cl12q6QctM8vz3QmLFHLOJ6lwSIjlaIZJOE
 6ljb4Sft7D6JkLwywDMzcdDXP2nVRmww3oRkaeyLn3+0yYfO16SvedRTUyW861MRmbEz
 p8m1C+RmIBa6u2rLyI24RCy9i2FuVOeW6veTw5Z88gW031yRuQKQoYnRCTUpe8J8sFBg
 qOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232544; x=1697837344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1oI+8GMLDR5DVCaCGuMrw+ON657pFUNlq64syrOQWw=;
 b=HUP2FmdRbyEJkVSR35d8xVxUz7Byl+3gINtecVpBADQGy6La7P7s66TnZTUng5maL1
 NT/Pz2Px1M2zZNvgD5rOCDlAcqy9LvFZcTiz1QqVb2PlT9AbGflcRYgZyF4RtWi35qtw
 EPzhYJMYp8CP/Ufs8Hb3nLV7Gg/eSh9N+BCOOswiEq+VAMU5c0Py1gmICePDtzFY1IOo
 iNyteMyJV7amPfejGFuzbGWKwAZ6cEiykaeVTQN2UgTW1MDAxMweCtC5EX2GzPWBZmRE
 92oWcgayo0r1NInWSt2spCoEe+HfRlqL5xmjeJYYyjGIHK6S7TVhBAcIMak9IFW2LS1O
 yqrg==
X-Gm-Message-State: AOJu0YzRnuYa2bXVip9U+q2/92Bkj3qnrX3T0U3tUsQjWeJbbxZ2hoD8
 mQ45a5Za6gSPfC3/tD7ZkHmd2aSCD9xnz3u542A=
X-Google-Smtp-Source: AGHT+IEqvKeWm5r6CmzkhDvMmQ8lhjwKTAcDhNuYO04ezxSY8RHmMTI35JL/MzR2evkbyva40DGpdA==
X-Received: by 2002:a05:6e02:1252:b0:34f:b9e8:a431 with SMTP id
 j18-20020a056e02125200b0034fb9e8a431mr29210860ilq.22.1697232543878; 
 Fri, 13 Oct 2023 14:29:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 17/85] target/sparc: Move RDPSR, RDHPR to decodetree
Date: Fri, 13 Oct 2023 14:27:38 -0700
Message-Id: <20231013212846.165724-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x135.google.com
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
index 8dc45f5abc..d3ca9061ce 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -46,3 +46,13 @@ Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
+
+{
+  RDPSR             10 rd:5  101001 00000 0 0000000000000
+  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+}
+# RDHPR_tstate
+RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 55ddd7b051..a88f514399 100644
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
 
@@ -250,15 +252,14 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
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
 
@@ -3303,6 +3304,72 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
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
@@ -3334,45 +3401,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


