Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6F7C8F22
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPij-0006Lf-Ae; Fri, 13 Oct 2023 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPid-0006ID-C1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:15 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiZ-0000UG-8H
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:13 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b706f604aso1425502eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232549; x=1697837349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc6FZ0/36jVa2TE3XINyXaHbhElQDiMOKtYHJmzoBOo=;
 b=ZxyL/yxZ68+O0L0MIxGSzlSV0vSFtmTrna7lWFqS86pm3wop1xo8Ekj/vxaFv0iOsB
 EqOLYi0tGilHPHQv8vGV0y+rJYhKvxalDwLWrZ6JZPfeAWQXQZK/+IU0bOLJpQHJ302o
 K4JL9s326xzQLJqkWQHEOdutC7ZtIN1x82lZbbHRFXLQSoI1hDx88oAXYEX9qLKw3xHT
 O5qxjTgIA/h0G088Bs1bn2weqshOInFs1F30ogdwRY1JB3+Hwv35FjvyzjjpiEU0V3gO
 G69D4PWFasirKGXc4dC5WWf0Xvln0lMlqHTb/vWS1/Y7LXihdpfB3ASSkoUIHiHW/7lR
 YAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232549; x=1697837349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rc6FZ0/36jVa2TE3XINyXaHbhElQDiMOKtYHJmzoBOo=;
 b=ENGqTkD+jlZTw1wrK1RTUlYVdVZNbSX6o7jbye0OAUCVtByjsGuKdgrAS9+yS2ziHZ
 n9F2WTFosIT0GHAAHEkfL8uAc5jGoO6MPjLNKZ3PapDGPC7+0QZnBsaQIQHORy4hZzMi
 dkantxiBGINPUuANG941dwG+0R6knfrurumFVvJ9alGgm//K/q98BhSAkcqo1xOzHCnt
 FLQ95+mC1t5TIi/084R1nlkW7zpsjUZs3gZBc/V5oMz224PN9zgVo2srWLPbPLr+Nb0m
 ChWmpwB1CkKCNipf0GfpJlRg33xBJbGvxXbCs69d3yQlTiohevyugkORaOHWnN1Fi2Mi
 Pj8g==
X-Gm-Message-State: AOJu0YxLYReQ6B+90TNpygpzPM5YAkyRqs+pakcHBG+quOyz8MpaS+3k
 677f9D6W+fkVsazlSLl0pJ06C1S3Stq+i9hBEVk=
X-Google-Smtp-Source: AGHT+IEKJVZpU3J71gIuXDHtcnGk8k21gD0OWHYmlMX8woGhvYVC5rnT7mL5cQk+5hwouQ+w9A0zhw==
X-Received: by 2002:a05:6871:514:b0:1d5:adc0:4a1 with SMTP id
 s20-20020a056871051400b001d5adc004a1mr29710397oal.22.1697232549739; 
 Fri, 13 Oct 2023 14:29:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 23/85] target/sparc: Move WRTBR, WRHPR to decodetree
Date: Fri, 13 Oct 2023 14:27:44 -0700
Message-Id: <20231013212846.165724-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
index b61926d278..0425764973 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -145,3 +145,12 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
   FLUSHW    10 00000 101011 00000 0 0000000000000
   RDTBR     10 rd:5  101011 00000 0 0000000000000
 }
+
+{
+  WRTBR             10 00000 110011 ..... . .............  @n_r_ri
+  WRHPR_hpstate     10 00000 110011 ..... . .............  @n_r_ri
+}
+# WRHPR_htstate
+WRHPR_hintp         10 00011 110011 ..... . .............  @n_r_ri
+WRHPR_htba          10 00101 110011 ..... . .............  @n_r_ri
+WRHPR_hstick_cmpr   10 11111 110011 ..... . .............  @n_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4b4ca04d62..efb3c7c570 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4000,6 +4000,61 @@ static void do_wrssr(DisasContext *dc, TCGv src)
 
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
@@ -4681,63 +4736,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


