Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEC7CBAF1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKP-0000gy-8I; Tue, 17 Oct 2023 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKM-0000fX-J9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKI-0003vm-SH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c888b3a25aso32853095ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523189; x=1698127989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5xRIoXwj5L41AAGrxfgbJ5f8TaaBeUG0cYd5payo2w=;
 b=zUUi25c2myZKhIuYkSbTXS/NHtG7sp9eZaLyfvpdPktQTCGOlQ+7fRmtHQa/RRdGi9
 mvGinftE3O7xucZMpvEQExHve350sXMnQskSfMU3Cw9j6V/1wmP3ValPwtA33wXg45jW
 YcIzrWyNuWtF5pbZ6roxnZ6jz+DUMf5MxxrvxPG1fdb2MYZy0vo6tzQYTPEIXsKrHrxJ
 EW0meWlnLbVfIJNow4TX7+eis115GG9tQ4KoVGVpd4anBF86vBewm1nm8fSRiUeEcvHk
 dQP2/2VRecDLDykaEOBl6spJwMWDD8sQpuuNieoHsECHD2KwZveAhNWV87Q+W+RdV0Q6
 9lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523189; x=1698127989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5xRIoXwj5L41AAGrxfgbJ5f8TaaBeUG0cYd5payo2w=;
 b=rHiJT2CtwAm6RiEDBpFPXJIwXJiLztmm8brjzRiTfI2reqSgvCz+p8pWZZEB18nEvB
 F8om6QSG5c44vqCsNiTQgF4Vs4uGsOT2SIvlt74ivx9dj4pho+17ReXJtdHrsostDSVG
 h0JzZMdAj4sdbt3iMrdG7WYUUiz1Tnmee8HdHgUtkAHVG1EiHhcThHOLmtwkUUacn6kz
 7gkY5DZdrPzo0FIs3viwEv/Auv3AjdHhvuTdwAbzG4JC3VoBYWl0G5AzUNaOOKkJUiMW
 sroXUrvrFdoj+Ig+QVOoztGkHucwTMmNxieGCy77soAxRgkiaUveDWm8r2ovtw9swACf
 PMdA==
X-Gm-Message-State: AOJu0YyGYqFvE42VNBOls6zW3mYTdTFCtHTUsliHm3bu8hppxW0U5Cxo
 iztW6j1VZmuxl17VReKEgXtoAEkpZOZT9Ywkvwo=
X-Google-Smtp-Source: AGHT+IHHpOqvpLPzs10vhZMGVtAEsti8ZT2gxEdj+A78YCNkIqC6pJAfWuXE8SVcJLAKCxkuPXKgeg==
X-Received: by 2002:a17:902:c407:b0:1bc:6861:d746 with SMTP id
 k7-20020a170902c40700b001bc6861d746mr1594158plk.58.1697523189550; 
 Mon, 16 Oct 2023 23:13:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 28/90] target/sparc: Move WRTBR, WRHPR to decodetree
Date: Mon, 16 Oct 2023 23:11:42 -0700
Message-Id: <20231017061244.681584-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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
 target/sparc/insns.decode |   9 ++++
 target/sparc/translate.c  | 110 +++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 56c04f01a5..49270705c7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -143,4 +143,13 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
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
 Tcc     10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6b8dfa7830..428fbb49bd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4034,6 +4034,61 @@ static void do_wrssr(DisasContext *dc, TCGv src)
 
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
@@ -4719,63 +4774,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


