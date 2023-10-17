Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15A7CBB18
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKN-0000e9-41; Tue, 17 Oct 2023 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKK-0000aK-At
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKI-0003ug-CB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso31197325ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523187; x=1698127987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQP6a6MxMoaNROE6UWCMRh+qyHbWDId1yiJtSMIXUyE=;
 b=BLWVTNbv3B7o/3PUIbpXDimLSYS5IayzhWr+IxESXaswlgCLYc1dIJgQstlJkNLNyq
 nW7cVnUEedss44W8+1btwD5SHG0iLACaPXdCD6nKYMO2LA5ic10PVurYy8foOZtlgocH
 gvaFlhO+54sUlrq5Wrfy/kCqnteziYOXVdFLB+SIII+XdElUwXWVj2A6KgQNpfvGIUPe
 81sWbbv40mctpV+02dWbTxrarTnJpaPDaiCAOkEcqF8XcKRIMRgQB2s1khrPLRh/tPRc
 S8mIV5/aNxtegP8W5kX4cTjVY0WcTg2LL1mPDIvxwk8uPH75COV2Wjfjmw5n4xeUnHU/
 MEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523187; x=1698127987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQP6a6MxMoaNROE6UWCMRh+qyHbWDId1yiJtSMIXUyE=;
 b=o9Zjqz0j63j95a7gxyF54bqopqen9Sml5huJ7+NMr4JBDv0soIN5P0sfKpftRX5HSp
 utGZwU6YnASwWNt/Iy0ZPiP12uyGIL8tqW9Fb8B/et9+aGPVuaqUk1qZRVYH1pkv0FFv
 h7aToBl+9CTtcQEBifqkqILF3E/xgSs392h1u7PHBka/e5rNDWP0fSX8xoRPhj1OStp8
 rtPmoDck74fyaLLyvLwu0Ux0iD2mb+vFU3Mkf7YuxQJVK3Hnm2ttfrVHQd4RpZogcBSV
 dVJPtj1hapkTchbbSb6yrdohr0gDfV7hnyMnhU9P5LfRXlMFdsMGD0TVjF8aFpx+COIg
 FL2w==
X-Gm-Message-State: AOJu0YzB23eM6JUyIz44PVQF0NDB4BexILPCW2R1ABuIrJzltLf3l6TX
 6azNwA0LXzT0ef/KQQB+xzlIzFB4KnKVqWFgj9E=
X-Google-Smtp-Source: AGHT+IH39QMW/GXBij2Fh4zqp4Uo/a5SRA2jCA7VCt1+jScRTa1XRf/l67JW+PxgNqGDE89bO9ikJw==
X-Received: by 2002:a17:902:f543:b0:1ca:9934:d014 with SMTP id
 h3-20020a170902f54300b001ca9934d014mr557655plf.10.1697523187680; 
 Mon, 16 Oct 2023 23:13:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 26/90] target/sparc: Move WRPSR, SAVED,
 RESTORED to decodetree
Date: Mon, 16 Oct 2023 23:11:40 -0700
Message-Id: <20231017061244.681584-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 target/sparc/insns.decode | 10 +++++++
 target/sparc/translate.c  | 61 ++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6acf0f9403..850b5d58d0 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -85,6 +85,16 @@ RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
 RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
 RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
+{
+  WRPSR             10 00000 110001 ..... . .............  @n_r_ri
+  SAVED             10 00000 110001 00000 0 0000000000000
+}
+RESTORED            10 00001 110001 00000 0 0000000000000
+# UA2005 ALLCLEAN
+# UA2005 OTHERW
+# UA2005 NORMALW
+# UA2005 INVALW
+
 {
   RDWIM             10 rd:5  101010 00000 0 0000000000000
   RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 59931c053f..a5058b5931 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -38,6 +38,7 @@
 
 #ifdef TARGET_SPARC64
 #define gen_helper_rdpsr(D, E)          qemu_build_not_reached()
+#define gen_helper_wrpsr(E, S)          qemu_build_not_reached()
 #define gen_helper_power_down(E)        g_assert_not_reached()
 #else
 #define gen_helper_rdccr(D, E)          qemu_build_not_reached()
@@ -46,6 +47,8 @@
 #define gen_helper_set_softint(E, S)    qemu_build_not_reached()
 #define gen_helper_clear_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
+#define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -3806,6 +3809,31 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrpsr(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrpsr(tcg_env, src);
+    tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
+    dc->cc_op = CC_OP_FLAGS;
+    save_state(dc);
+    gen_op_next_insn();
+    tcg_gen_exit_tb(NULL, 0);
+    dc->base.is_jmp = DISAS_NORETURN;
+}
+
+TRANS(WRPSR, 32, do_wr_special, a, supervisor(dc), do_wrpsr)
+
+static bool do_saved_restored(DisasContext *dc, void (*func)(TCGv_env))
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    func(tcg_env);
+    return advance_pc(dc);
+}
+
+TRANS(SAVED, 64, do_saved_restored, gen_helper_saved)
+TRANS(RESTORED, 64, do_saved_restored, gen_helper_restored)
+
 static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
 {
     /*
@@ -4480,39 +4508,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     case 0x30:
                         goto illegal_insn;  /* WRASR in decodetree */
 #if !defined(CONFIG_USER_ONLY)
-                    case 0x31: /* wrpsr, V9 saved, restored */
-                        {
-                            if (!supervisor(dc))
-                                goto priv_insn;
-#ifdef TARGET_SPARC64
-                            switch (rd) {
-                            case 0:
-                                gen_helper_saved(tcg_env);
-                                break;
-                            case 1:
-                                gen_helper_restored(tcg_env);
-                                break;
-                            case 2: /* UA2005 allclean */
-                            case 3: /* UA2005 otherw */
-                            case 4: /* UA2005 normalw */
-                            case 5: /* UA2005 invalw */
-                                // XXX
-                            default:
-                                goto illegal_insn;
-                            }
-#else
-                            cpu_tmp0 = tcg_temp_new();
-                            tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                            gen_helper_wrpsr(tcg_env, cpu_tmp0);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-                            dc->cc_op = CC_OP_FLAGS;
-                            save_state(dc);
-                            gen_op_next_insn();
-                            tcg_gen_exit_tb(NULL, 0);
-                            dc->base.is_jmp = DISAS_NORETURN;
-#endif
-                        }
-                        break;
                     case 0x32: /* wrwim, V9 wrpr */
                         {
                             if (!supervisor(dc))
-- 
2.34.1


