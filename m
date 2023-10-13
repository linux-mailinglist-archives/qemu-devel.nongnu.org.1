Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5287C8F2F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPis-0006RX-LZ; Fri, 13 Oct 2023 17:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPio-0006QP-Uj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:26 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPin-0000YC-5W
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:26 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3512c43adebso9449535ab.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232564; x=1697837364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1IopEvhOVSLQ7m+JZ9GVLfQXpnHhGyM2J0Is85Wd9I=;
 b=meg8v2Y/6u6SDwF4BQVrr5ER/QnBZANUQGW/weSgXIACyhMwT2py0eHGdgTDHYikZE
 KhUoEChW945KYXQ7NCbQr2IYcQCW26SFMtGKF8/sfvcmLKpmqvARE5NkLlRVqfQJDWB1
 8dpia0HniXCgteHiI8lD29g/0ZzMatQCuZDnZHoJtjCEOroB0+yhUb+V8281cwG8BZLm
 hI6p32IcywQSGIpiut2driXVex/XrKXwMwWJ52weOplL0REnu1wll+CDmEHwXVodFurq
 efIj8CQvla+poEmhLANSjGUUn8Cq9yON1ofHIyO/8d6Ndbt3goFwQgsgzxX1yhIfu+WH
 Pt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232564; x=1697837364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1IopEvhOVSLQ7m+JZ9GVLfQXpnHhGyM2J0Is85Wd9I=;
 b=WaPDi3ddVBb4m4eKvpKPCM4CMyhYNRHHhwnmY8Cg+ePw8LY6duV7dKN95XCJEaDTDH
 nXZ+fe9QNTyCHsz9do7v9u0VTpS7C/UcJ7Gv6QgtMaB9ys/sGj90dNklKe5pLD2PCwYb
 vCc/xlwiWOE/ddZvZzCrTojkO3Trr8x03GHAK5fo3QCqY+4RYbZmDowehhb68zasrCSZ
 fZqigJq013xZI6ZzdIPbG2LzQ9jPL74ezQLEGT5lFJY4Jg49Pzwl9BHTNoNlaGMb1R4I
 z4+MIfBuUndbO0ny5swynl75MsY+tDli9MBrBsEbVOQbW/X5o9cVahb3n5IJvwZf4rsY
 udzg==
X-Gm-Message-State: AOJu0YyN51dn4ophSvI5It/RDYQxlBHP401w3bm5VANnjdeRG64uaqvP
 bbit3jgIx1fIV53R3dRvS3sRaljm9HK9nonbIA4=
X-Google-Smtp-Source: AGHT+IEuZSOBlYwUW8gZVhQhg+3Yu1MJlVWsTf9luolMGDD3FH/3kgxUhaR1f2sUxhvnd8KXtEOJMg==
X-Received: by 2002:a05:6e02:cab:b0:357:51fa:ac5a with SMTP id
 11-20020a056e020cab00b0035751faac5amr7605017ilg.1.1697232564062; 
 Fri, 13 Oct 2023 14:29:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 38/85] target/sparc: Move DONE, RETRY to decodetree
Date: Fri, 13 Oct 2023 14:27:59 -0700
Message-Id: <20231013212846.165724-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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
index b7b60f9919..9f17a11dd0 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -222,6 +222,9 @@ NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
 SAVE        10 ..... 111100 ..... . .............          @r_r_ri
 RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
+DONE        10 00000 111110 00000 0 0000000000000
+RETRY       10 00001 111110 00000 0 0000000000000
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 960a3eabbd..e652bdcac2 100644
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
@@ -4483,6 +4485,36 @@ static bool do_restore(DisasContext *dc, int rd, TCGv src)
 
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
@@ -4494,7 +4526,8 @@ TRANS(RESTORE, ALL, do_add_special, a, do_restore)
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1, cpu_src2;
+    TCGv cpu_src1;
+    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
     target_long simm;
@@ -4509,9 +4542,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
-            unsigned int xop __attribute__((unused)) = GET_FIELD(insn, 7, 12);
+            unsigned int xop = GET_FIELD(insn, 7, 12);
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
-            TCGv cpu_tmp0 __attribute__((unused));
 
             if (xop == 0x34) {   /* FPU Operations */
                 if (gen_trap_ifnofpu(dc)) {
@@ -4831,8 +4863,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-            } else if (xop < 0x36) {
-                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
@@ -5274,65 +5304,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5729,7 +5704,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


