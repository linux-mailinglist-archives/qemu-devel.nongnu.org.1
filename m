Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C07D2158
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:08:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWX-0000lt-6V; Sun, 22 Oct 2023 02:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWD-0000ao-8P
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:58 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWB-0001am-Gh
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:56 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ce2cf67be2so1596366a34.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954454; x=1698559254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07llbLREsZP4vqpSC4QzyAuMwEAvOewkAvdq2XiLjng=;
 b=x/7DqeWxBQBZwI9FcYV22dcr+NtcrvSsIz4UYxSsVoU1WbKsgoFIX8vhUyH+GSylN7
 aRz3gvAe7pDbc6Nm6J9QX37TPqEJJU85smLCJfFceuZOH+yjTt3btJQh/dJyyLMlFoJf
 Xaor3CkW2xhcFtpDq3z17MHsFedL1FmQVefB9ajrzqKUdLdIid3jzNMuf80f0omBoJvd
 rcuHIZxuiBzboKoc9Z8h8AsvzAraRHMstKIiVQTwAMmb0pKGvxXSxpnjVb7bbGoeV/ab
 rJWHSDC7KI0/lx8sFJqrn+OhfeWBBzTD1Pgm90R78EypDlRjBL6Ns7HoOv+lFVZ3us0a
 H84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954454; x=1698559254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07llbLREsZP4vqpSC4QzyAuMwEAvOewkAvdq2XiLjng=;
 b=jWcf7tXu0AUu8UR2fAI0T4TH++YQryQtOYRA9sQWDYZ9ANTYkTmVIM/sx4av0uTOwj
 FIwx3M5+G3N+/s6vaKTG+xpb+HQwZuLPgNElhaMskr342UrkZ0WLZTGlK/fCLCXc5LND
 3Q/eVztRcSvWGrlRza/9YyQMtl+nIsXwWeCWSSrn/Nick4tUfnLz4CAkdEq/r0uXyFuU
 mreX5q17qVnWtX4+yhrIK6MLHfugU11DQH4NapNqjJ5sGaGmMl6rrQEJ7KqDELeY9jrF
 xg5pOxPM21GzAFBmk2tFvaww/obWNZ1agv+3OCPPrzDML6l1UoHxJrT4Ph08D26yH3HZ
 vRaA==
X-Gm-Message-State: AOJu0YyHLCdaCzP8W2FPFkBg9ed4AVtxWgORfxevoOde0Ql/5waGewcY
 yfnjaV4Fekbs9KU4OEXTTP3sQIECv4sPZ1zRVMQ=
X-Google-Smtp-Source: AGHT+IFlWtxS1XRbDK+HtvuWJPFMQcstO/MkXLcEy94ORMsv61+aKRqD/8qA9gjqNtDFWYm0BUnVUg==
X-Received: by 2002:a05:6870:8dc7:b0:1e9:95c8:e15e with SMTP id
 lq7-20020a0568708dc700b001e995c8e15emr8448913oab.14.1697954454419; 
 Sat, 21 Oct 2023 23:00:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 26/90] target/sparc: Move WRPSR, SAVED,
 RESTORED to decodetree
Date: Sat, 21 Oct 2023 22:59:27 -0700
Message-Id: <20231022060031.490251-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
index 118f0f1f17..45cf47a32f 100644
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
index 3afeb226fa..8d1af552f8 100644
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
@@ -3824,6 +3827,31 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
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
@@ -4498,39 +4526,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


