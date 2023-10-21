Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2FB7D1AE2
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bI-0007JU-RB; Sat, 21 Oct 2023 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b4-0007Db-2b
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b2-0008Rm-8C
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso1285096b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866343; x=1698471143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exVJ0xUg4TmQE2v5QVwO9952p+33As4o43E61S8eBHM=;
 b=JyezHoky/SYqsmNWqVrLL+FPzBrdLOHLEPAJsmFwXTL6xo7gZ3EbQdOqOacTncgVkq
 L13Aw40isUwgzY3zRfqeBEUTXrOqa3CmDq+BWnmFQtx8VFgf1a681ULnMb4sbr3w/X1+
 RsGMOgb5TmHG3Dj2CkEO2NTcZcKLzpricX3n2jm6Fbj/LHUkAiPDtvW0gcLShqaETVBd
 NItXRDX9ueM/lqqE/U+DxAfxCqO5MUCyW30K8bLQrxzioIQQ0GENFG2pSoqPyFbCu3Eo
 B8M3ni1/udWaE997KldZ8ITeEcN2+c0dnpAKxSd4Aq+3CBa7ad7F9hh45RfSfyIrtj+O
 cuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866343; x=1698471143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exVJ0xUg4TmQE2v5QVwO9952p+33As4o43E61S8eBHM=;
 b=Aq1dguJpbVf3mDZ35yf7ThCGfxZkGhR2lM1tEJKdrRjEMnko/Oq688RvRRgTdCiIQF
 7pAIKyrZTFM6IJb0cUCxCk+w1iTcX7vFO0uJeTefRPkqky7oArNTjI4Wko0PK5xkNAWQ
 VFWIAy4DhZ0LlfFDmNsqhAZX3Oc1uyZTdnlr7OPC1kYwN6EMhhcIn8YyT4HOMOLFXi+d
 rBT8E6sPmCUZKfUgIijetK7XUzfnEc5wA3PEImsgwVndquVgbGE1p2HF9IUJJ1TmTx0n
 4bAODAiWqqJ5p+BtQKNjhyo0+CMIZZXdyGbgukZItFwohUSGNP0xiwCofuMZEGdcKkjP
 /SYA==
X-Gm-Message-State: AOJu0YxNUGOjuwa6zzzPo8HO5M5B0dlJ5LNOFCpV5v/QF5qIu3prHMtz
 K0Z8QRui+yNNP0ZVVKVktUthcpUV//fNNsDrGDk=
X-Google-Smtp-Source: AGHT+IHO9a4krGsKCxxhfieJsAIrYFCDvr4s/T0bqlz6DQNIB68lIL2uliYkbqpfi/sfl2GdgrbAyA==
X-Received: by 2002:a05:6a00:248e:b0:6bd:b7c5:f776 with SMTP id
 c14-20020a056a00248e00b006bdb7c5f776mr3797770pfv.8.1697866342916; 
 Fri, 20 Oct 2023 22:32:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 28/90] target/sparc: Move WRTBR, WRHPR to decodetree
Date: Fri, 20 Oct 2023 22:30:56 -0700
Message-Id: <20231021053158.278135-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/sparc/insns.decode |   9 ++++
 target/sparc/translate.c  | 110 +++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d7bd6cd718..0c02a269e2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -143,6 +143,15 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
   RDTBR     10 rd:5  101011 00000 0 0000000000000
 }
 
+{
+  WRTBR             10 00000 110011 ..... . .............  @n_r_ri
+  WRHPR_hpstate     10 00000 110011 ..... . .............  @n_r_ri
+}
+# WRHPR_htstate
+WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
+WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
+WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2a0a9b0341..b1918da68a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4031,6 +4031,61 @@ static void do_wrssr(DisasContext *dc, TCGv src)
 
 TRANS(WRPR_strand_status, HYPV, do_wr_special, a, hypervisor(dc), do_wrssr)
 
+TRANS(WRTBR, 32, do_wr_special, a, supervisor(dc), do_wrtba)
+
+static void do_wrhpstate(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_st_i64(src, tcg_env, offsetof(CPUSPARCState, hpstate));
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hpstate, HYPV, do_wr_special, a, hypervisor(dc), do_wrhpstate)
+
+static void do_wrhintp(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_mov_tl(cpu_hintp, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hintp, HYPV, do_wr_special, a, hypervisor(dc), do_wrhintp)
+
+static void do_wrhtba(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_mov_tl(cpu_htba, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_htba, HYPV, do_wr_special, a, hypervisor(dc), do_wrhtba)
+
+static void do_wrhstick_cmpr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(cpu_hstick_cmpr, src);
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, hstick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_limit(r_tickptr, cpu_hstick_cmpr);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(WRHPR_hstick_cmpr, HYPV, do_wr_special, a, hypervisor(dc),
+      do_wrhstick_cmpr)
+
 static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
 {
     if (!supervisor(dc)) {
@@ -4716,63 +4771,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


