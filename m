Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C987CBB36
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNn-0003KY-Rh; Tue, 17 Oct 2023 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNR-0002O6-Hj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNP-0004fI-9K
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1640750b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523382; x=1698128182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bifKoxTReoGUtyt9dEyNfA9Pc21VjUiLamdfYMd5Ikg=;
 b=NdGzT0aCFfN8YO7BUvMbPQfDRyk2mmOeF5Qakr1v/3xTLYdElxs8560befG4UKEy+V
 ZlZQplpBlLkZMSSqmPyAYMkLM0xTb2vSqR8+jfv4UvVcTQwB9UIwuw+2JPDMURvlEtL3
 xkU+q8FC6DbN9ypTYstwlPX7DofTNjqOcAUMAvdwvH124h6TTUXCZOKT8Cp+WMOnQyw4
 wdcrSsZCigh0JpPWeA/LlLnEDuZnb7HIZqEd9D7Es/DhS+iPTumpG6W2kR38HC0DfCxX
 ZpUXqOjryb5VN4DvofQO37mfeJSq6vn6fo7qeHngmV0vg32JEpP9alqHKCZLEGisiiFR
 TrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523382; x=1698128182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bifKoxTReoGUtyt9dEyNfA9Pc21VjUiLamdfYMd5Ikg=;
 b=FE2fwI1SAUK3YvR9Gb1oSRoNbfV+WFQou7A7xcWbweMwFfDR2EwLS6OzlqGBcJVwH7
 qgNtF9kjXrbuvIk6YDeihxot15ZDkc+8xEM6AjKHFycFlbdPsXp/XCWr3wvqMbnXj4yH
 mtAPKqJHobk26LJC7LkcNwX1HLBoxDWa5Dzb7D+EZhMgDQizJbSMTgHdF3HptS1IJYey
 9Ikg1ej+JE1mGbhNRn2C3NzUjL0fRXKsEYlgjP8XDIpUsTIzN0LveB4/9fxOhRjw909Q
 Rsit7oXBneLICZPWP8+Fuxv0IAtRNuBsqR8zqFlWDqxQptICfgH/JgOplhkXfAa+Ec80
 3vUw==
X-Gm-Message-State: AOJu0YyG2HLFzv2ol9R9y+JPJdRtr48ChvpaBiTDdF8ZqKy/Jr7D7l80
 8+fryCt3qA2Ch+k9mY5aZ22Dzxyv5lRrL7tGTkc=
X-Google-Smtp-Source: AGHT+IFsAscb8/UlGo1hRPKLBKGVaSdMFdVOdeD9MLHu65JGvdcMLU2T/avKmWYMwLnLDpyyllG52w==
X-Received: by 2002:a05:6a00:b46:b0:690:f877:aa1e with SMTP id
 p6-20020a056a000b4600b00690f877aa1emr1436532pfo.12.1697523381733; 
 Mon, 16 Oct 2023 23:16:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 43/90] target/sparc: Move DONE, RETRY to decodetree
Date: Mon, 16 Oct 2023 23:11:57 -0700
Message-Id: <20231017061244.681584-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 99 +++++++++++++++------------------------
 2 files changed, 40 insertions(+), 62 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9c4c493630..dface4a9dd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -221,6 +221,9 @@ NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
 SAVE        10 ..... 111100 ..... . .............          @r_r_ri
 RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
+DONE        10 00000 111110 00000 0 0000000000000
+RETRY       10 00001 111110 00000 0 0000000000000
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5fc46d1b20..784a019dcf 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -54,6 +54,8 @@
 #define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_done(E)              qemu_build_not_reached()
+#define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
 #endif
@@ -4549,6 +4551,36 @@ static bool do_restore(DisasContext *dc, int rd, TCGv src)
 
 TRANS(RESTORE, ALL, do_add_special, a, do_restore)
 
+static bool trans_DONE(DisasContext *dc, arg_DONE *a)
+{
+    if (!avail_64(dc)) {
+        return false;
+    }
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    dc->npc = DYNAMIC_PC;
+    dc->pc = DYNAMIC_PC;
+    translator_io_start(&dc->base);
+    gen_helper_done(tcg_env);
+    return true;
+}
+
+static bool trans_RETRY(DisasContext *dc, arg_RETRY *a)
+{
+    if (!avail_64(dc)) {
+        return false;
+    }
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    dc->npc = DYNAMIC_PC;
+    dc->pc = DYNAMIC_PC;
+    translator_io_start(&dc->base);
+    gen_helper_retry(tcg_env);
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4560,7 +4592,8 @@ TRANS(RESTORE, ALL, do_add_special, a, do_restore)
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1, cpu_src2;
+    TCGv cpu_src1;
+    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
     target_long simm;
@@ -4575,9 +4608,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
-            unsigned int xop __attribute__((unused)) = GET_FIELD(insn, 7, 12);
+            unsigned int xop = GET_FIELD(insn, 7, 12);
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
-            TCGv cpu_tmp0 __attribute__((unused));
 
             if (xop == 0x34) {   /* FPU Operations */
                 if (gen_trap_ifnofpu(dc)) {
@@ -4897,8 +4929,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-            } else if (xop < 0x36) {
-                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
@@ -5340,65 +5370,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 default:
                     goto illegal_insn;
                 }
-#else
-                g_assert_not_reached(); /* in decodetree */
 #endif
-            } else if (xop == 0x37) {
-                /* V8 CPop2, V9 impdep2 */
-                goto illegal_insn; /* in decodetree */
             } else {
-                cpu_src1 = get_src1(dc, insn);
-                cpu_tmp0 = tcg_temp_new();
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 19, 31);
-                    tcg_gen_addi_tl(cpu_tmp0, cpu_src1, simm);
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    if (rs2) {
-                        cpu_src2 = gen_load_gpr(dc, rs2);
-                        tcg_gen_add_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                    } else {
-                        tcg_gen_mov_tl(cpu_tmp0, cpu_src1);
-                    }
-                }
-                switch (xop) {
-                case 0x38:      /* jmpl */
-                case 0x39:      /* rett, V9 return */
-                case 0x3b:      /* flush */
-                case 0x3c:      /* save */
-                case 0x3d:      /* restore */
-                    g_assert_not_reached();  /* in decode tree */
-#if !defined(CONFIG_USER_ONLY) && defined(TARGET_SPARC64)
-                case 0x3e:      /* V9 done/retry */
-                    {
-                        switch (rd) {
-                        case 0:
-                            if (!supervisor(dc))
-                                goto priv_insn;
-                            dc->npc = DYNAMIC_PC;
-                            dc->pc = DYNAMIC_PC;
-                            translator_io_start(&dc->base);
-                            gen_helper_done(tcg_env);
-                            goto jmp_insn;
-                        case 1:
-                            if (!supervisor(dc))
-                                goto priv_insn;
-                            dc->npc = DYNAMIC_PC;
-                            dc->pc = DYNAMIC_PC;
-                            translator_io_start(&dc->base);
-                            gen_helper_retry(tcg_env);
-                            goto jmp_insn;
-                        default:
-                            goto illegal_insn;
-                        }
-                    }
-                    break;
-#endif
-                default:
-                    goto illegal_insn;
-                }
+                goto illegal_insn; /* in decodetree */
             }
-            break;
         }
         break;
     case 3:                     /* load/store instructions */
@@ -5795,7 +5770,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
  illegal_insn:
     gen_exception(dc, TT_ILL_INSN);
     return;
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
  priv_insn:
     gen_exception(dc, TT_PRIV_INSN);
     return;
-- 
2.34.1


