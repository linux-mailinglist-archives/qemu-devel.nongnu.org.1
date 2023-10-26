Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608657D7988
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6f-00028d-Fn; Wed, 25 Oct 2023 20:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6M-0001Sl-TV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:54 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6G-0006uI-Va
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b7f3f470a9so319896a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279587; x=1698884387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1LExU5FV8KZbjwf84znCZoseuZjsAqtp+H9XwjBWlI=;
 b=wWkt1QgTY3rGrswh8AXIOPueRBtj7awNAEzwRHRRoQNqXA9fhPqRRpLKqshBdFhECE
 aXoqXAYiTV42LZtuh3XGOspSS1DbvrTONgyNGEBdYcxLJzHlcddaJLl/cCE4KfI7pqfm
 ZMdPtPH+8veTA8+e44H5fIE+98XDUwaY0V/Fz5DAhvcdeE98rE9FFORJiS1i/UCXavTW
 oPe2WWGPgjZGDr7KsiuOy4FQSrIXuXcXf9GvCEYuMf530nIlRCRtTbnkwazB8J5HDLWt
 JdeiTFfHuxdJ33nqF4l+xlGn14kGk2AtmVIAP0FNKjM22i36LLEns7wK2wdJ5xDW8jSx
 O2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279587; x=1698884387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1LExU5FV8KZbjwf84znCZoseuZjsAqtp+H9XwjBWlI=;
 b=EXVAwk/MohNhuiWQBgoauMMq0rb7K2jSPZgvw/czyC7xRW272DalRQo433X0zItfdE
 OBCxcbW4eYXLX0hZ8NbPJN9H746xROgikdUflkaS/ZuKQ2BiepsAbwzbbyRZnoQQvcl1
 STa9WIAp2teLfgy/ynqquJsP5EVzLYR0UuxtcnQyXOiWp7dvCWRoSO/4e+f6QT/LJjq3
 tb7FZprUaRFsn+w68DapM3Pv3R0Q30QvFTINIWtDfVJPcu2EW+xPXtBkAazc2f0aV1+2
 6SS0Mp1B806m3viQ3wYqycmD+OdEzbjFI1DjhLvoctQ+ISGTHrdmj/rwavBNEm7ZMh7A
 MCWA==
X-Gm-Message-State: AOJu0YyWoj6aYTiAqJy3hDhIXei+FG/tYEpHt1YgyUZfM0uYB/PMh72M
 J86X04pcUezARse3V/6JoS3uUoBBZctwmryU+PU=
X-Google-Smtp-Source: AGHT+IE1K2VvpalyA0VDVi3mN/HUUZGebi9vYyATeK/npSrelN5TNiBKBhKMSUJ6zcy2UVtzcKo62A==
X-Received: by 2002:a05:6a20:8419:b0:16b:80b4:c39a with SMTP id
 c25-20020a056a20841900b0016b80b4c39amr9833426pzd.19.1698279586855; 
 Wed, 25 Oct 2023 17:19:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 47/94] target/sparc: Move DONE, RETRY to decodetree
Date: Wed, 25 Oct 2023 17:14:55 -0700
Message-Id: <20231026001542.1141412-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 88 ++++++++++++---------------------------
 2 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index aa90b5c5bb..137b7eb3c6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -228,6 +228,9 @@ NOP         10 00000 111011 ----- 1 -------------          # FLUSH reg+imm
 SAVE        10 ..... 111100 ..... . .............          @r_r_ri
 RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 
+DONE        10 00000 111110 00000 0 0000000000000
+RETRY       10 00001 111110 00000 0 0000000000000
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e0a13e5d29..8faf2c59b2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -43,10 +43,12 @@
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
 #else
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
+# define gen_helper_done(E)                     qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
+# define gen_helper_retry(E)                    qemu_build_not_reached()
 # define gen_helper_saved(E)                    qemu_build_not_reached()
 # define gen_helper_sdivx(D, E, A, B)           qemu_build_not_reached()
 # define gen_helper_set_softint(E, S)           qemu_build_not_reached()
@@ -4480,6 +4482,25 @@ static bool do_restore(DisasContext *dc, int rd, TCGv src)
 
 TRANS(RESTORE, ALL, do_add_special, a, do_restore)
 
+static bool do_done_retry(DisasContext *dc, bool done)
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    dc->npc = DYNAMIC_PC;
+    dc->pc = DYNAMIC_PC;
+    translator_io_start(&dc->base);
+    if (done) {
+        gen_helper_done(tcg_env);
+    } else {
+        gen_helper_retry(tcg_env);
+    }
+    return true;
+}
+
+TRANS(DONE, 64, do_done_retry, true)
+TRANS(RETRY, 64, do_done_retry, false)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4491,7 +4512,8 @@ TRANS(RESTORE, ALL, do_add_special, a, do_restore)
 static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
-    TCGv cpu_src1, cpu_src2;
+    TCGv cpu_src1;
+    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
     target_long simm;
@@ -4506,9 +4528,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
-            unsigned int xop __attribute__((unused)) = GET_FIELD(insn, 7, 12);
+            unsigned int xop = GET_FIELD(insn, 7, 12);
             TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
-            TCGv cpu_tmp0 __attribute__((unused));
 
             if (xop == 0x34) {   /* FPU Operations */
                 if (gen_trap_ifnofpu(dc)) {
@@ -4828,8 +4849,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     default:
                         goto illegal_insn;
                 }
-            } else if (xop < 0x36) {
-                goto illegal_insn; /* in decodetree */
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
@@ -5271,65 +5290,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5726,7 +5690,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


