Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85D7D793F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:21:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6L-0001Gz-Dq; Wed, 25 Oct 2023 20:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo65-0000rD-0i
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5t-0006bC-Bx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so2121815ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279562; x=1698884362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4JjGfXc1ZK0slmW0Mduo2FRxtvtvRQNj+3A0+w7cQs=;
 b=xvyihsaN/IL8J7P+zIMxfb6AwFMCQQ1iMFuLQtMNCS7b/cU7zP6ceLuQHnsw1d3WvX
 G2DaR9S41nAzrqnvh5mtZp9chOyco1x+IiRZosB63rONfe+LEX2D0QI7L2wTsy9IYfQM
 2huZDanWtVsYleMmP4G0ezD4pJzsA9IU1bpKAmjwJZ1iKlvkD+KO04ts4GTZBy0HafwC
 6D0WT3y+dS6HzlWvCZxcrztknSKclWTaS3/+/ocHeL5I6ahbyiQopiksLRrDLhh5nOps
 MwaZHDqmFYMMRe96g1Ozd+qjroTOteirTY6Q0+nSUrGy8lWU5Ry3VneR7Adx777pmBvJ
 /VYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279562; x=1698884362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4JjGfXc1ZK0slmW0Mduo2FRxtvtvRQNj+3A0+w7cQs=;
 b=gjhUIqpoaGu2KFP0RfTWqPsHeiOToPxdELodY7VbKivzOgUywq7u2tczYEQ21lwNU3
 y05MwbwvcEQJO7A6rhPzWmn3wejor/4R0rqMgvxtknQxvcxzaf/QvGoK+j3NxDsYU/Hb
 +DVpk00X/XilbMV3YfALTTMsyLEoiiB8iKZ2qmMvP5LHishAYE+AqfTM+VCWNbo1Dkeq
 P5ApCDmT/DBD1/TWJBFSvjsws8Bal0DcigZ9ujHOKfavd+UrrJxcVe4eCynyYvfUiwI2
 MB08sOJO6MuSPgRCrZdM+NscItA06+ES3Ei0spXrH8REWqefUkHVzUhy0TJO7ro1imWu
 PRTg==
X-Gm-Message-State: AOJu0Yxh5NyP2VJrX4AZvlteCSUSrEXyyWDttotrMfiA0EeSq8GLPCku
 FXiV0KC3CU2L2ZUY65sneH6IPbime1u7UEDDVXA=
X-Google-Smtp-Source: AGHT+IGjPxVnXCor5bTesqG30xwM8Wk7zsAV8lSK+56Yi3Wwd700AwwXJn+RxVtuRgaf0KNMRuSBYQ==
X-Received: by 2002:a17:903:493:b0:1ca:344f:46e6 with SMTP id
 jj19-20020a170903049300b001ca344f46e6mr12113594plb.33.1698279561777; 
 Wed, 25 Oct 2023 17:19:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 23/94] target/sparc: Move RDPSR, RDHPR to decodetree
Date: Wed, 25 Oct 2023 17:14:24 -0700
Message-Id: <20231026001542.1141412-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


