Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C827C8F2C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPif-0006Ke-Hm; Fri, 13 Oct 2023 17:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPib-0006HF-DK
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:14 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiX-0000Tz-C2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso768427b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232548; x=1697837348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLTr3UIdQ5YM3+mq+HwPGykzK1jm0Avd7KVm28ssLqg=;
 b=CoXplsEReHsQk4/fbwuZFHXPjfgOtRvkVE7XBItcwgQzZbNh9lB+3PWPUjSS+5mbcc
 P7yzNvw8aIv+0PRRwy23PXXo+ZCQImNaIR4tPID1xVUVNBgZMYYLQAvTLRk3cefRfYXZ
 mK79RZFQTpCVEA7O6ymV9ca2JtNnd92wjm1k6QKmPQhmocmzQ2YnZ2EF+MIjf1H4jBDS
 33/znbKvcZ3H/79zgim/89PJh5M0UiXDp+2Qnn7BWEynbFf6knrwOFyF/W4cU5FN4JBs
 gk8JoHxOcGuuW34RnverSefQMRei7/Fh9YD9iASKA5rmqEZd644ir3jrMTVKAP96pxHV
 h44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232548; x=1697837348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLTr3UIdQ5YM3+mq+HwPGykzK1jm0Avd7KVm28ssLqg=;
 b=i8mxByzEqwxRr2T7HnsBeBQeajdOooLAevAh4fIWHl30b22XiCjsLLWHeuRQ0Y0+kl
 Mfm54xjnYURH4W6ftIW0Ms88GM94lXik0g1QtztItO2n1fmSNj+KxeATIJxu7wiYdhuF
 YaPuCiOEjfX8SVfRl24dsl4OXv7kCropy45kxhD70TPX6avh1ksXK7oRy5f/WRymU98m
 H/I+VK/fuwhNcEjw6SFj2iWG4DXPBwcyQD/y5/EGgmXOhuSHK/vHKRg1J10MLx9YyODw
 vC/75eXqBmBoZNztYkgiRANKUQNoX5uD9LoYuvOMP/R6m4Fn6MokAoLZksmy5eF9aPXe
 ZXXw==
X-Gm-Message-State: AOJu0Yy4j+oijxsk0HG6FTwMAmfK0mxYhofXY+zSUuB033TyKHjImLNq
 oHbF5aBWvPYtfSAyzpWDOlHUI0UjcO9C9FB5b9w=
X-Google-Smtp-Source: AGHT+IEDdJa8eHD/KrvjWlgmL+s3NvdohEj4Cldi4xX9px5bX4sf+LQz7dj1a0S1ZWxIoeaau65hSQ==
X-Received: by 2002:a05:6a21:181:b0:13a:6bca:7a84 with SMTP id
 le1-20020a056a21018100b0013a6bca7a84mr35903040pzb.44.1697232547886; 
 Fri, 13 Oct 2023 14:29:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 21/85] target/sparc: Move WRPSR, SAVED, RESTORED to decodetree
Date: Fri, 13 Oct 2023 14:27:42 -0700
Message-Id: <20231013212846.165724-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
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
 target/sparc/insns.decode | 10 +++++++
 target/sparc/translate.c  | 61 ++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c253c6b1c1..db5a899bdf 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,6 +88,16 @@ RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
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
index 917a4299ff..5f2e5d5a82 100644
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
@@ -3772,6 +3775,31 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
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
@@ -4442,39 +4470,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


