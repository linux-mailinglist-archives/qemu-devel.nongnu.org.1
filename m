Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D9F7CBAEA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNk-00034N-Fi; Tue, 17 Oct 2023 02:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNQ-0002GZ-G3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNN-0004ez-OE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so39443545ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523380; x=1698128180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCaWSL3D8+ipKSjTkBG+OGzcsgjBm0vQFdSSgOXGgrI=;
 b=DS3ZBNB5CeZWiwegJ5Ba9pMZVvL6BCPU4c7GctbqqaURe4qyPopGH5xbLdH2G+CP4W
 Bh6R3gx32axYhN+S4gAe3JsD8IDx+nmrwk1CLO4SQpxkluwBg3H2aukkOm9RaD2zccjP
 t3ylNqDM2XoSBqeV9Ol7lknLNwY40I8G3ewfVWmDFUnBjCKF26TnxMmTx+en/8dmNgA/
 Goypj6Gu0zcWZz6Jn1AoGpD93+UsORpqpuFYZQ6NH5t0Hd85rHgyRpjnNz5x4QUqtsTy
 hpeKVX4OJu2edkLS8+B2IXCMHu9TZrnn6l3ve0F9pQG03fufWbfKCBCISoSkLBBc0CR8
 2n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523380; x=1698128180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCaWSL3D8+ipKSjTkBG+OGzcsgjBm0vQFdSSgOXGgrI=;
 b=uSUbAGlXDh0oJBRtw++jEkKkGttZumVtEaXprRquH7lyeVh5MgX50kffydtQXhi6hH
 p4gQUoyypbxBTKIUa3t9H6IcP/92k1vPXf2GC1v4EL4zq4r2ZaldqYUgfY3fMo31Q6pw
 ZIoIiYiFCyodmxjaNvOHqO+JsXK1eZ0jAshFEq8spbLbFdwrqpj+txtqYUlW0F3ZsY28
 hoExOn6OqTt8n1FBOB8NPpqC905fiydqM+TERO3bFA/P0uP2QM1NEUZ/tqQqKRNgRMSt
 p9zaEOUvh1hFmxVJdCo8zFYrklhV+aGxGo+TtBD8ONrOK9xyYfrwJJhXDhpgPA/U/JhB
 2PtA==
X-Gm-Message-State: AOJu0Yy549erHZRbeshLxgtMLFgZBzFFNwXPgiGkoxV9YjT0OW9h4A/X
 CjgyMasEfyE+jwMxY2WLT5vAHRqF4iXijQTYE10=
X-Google-Smtp-Source: AGHT+IEsU/EMP2EPwdd2ktK4y/9HBr+KaNRhHUQkKaBaLDPFUs9ZseeTKFCOOQMypvSTEoTwn3NtiQ==
X-Received: by 2002:a17:902:c945:b0:1b6:a37a:65b7 with SMTP id
 i5-20020a170902c94500b001b6a37a65b7mr1422200pla.23.1697523380216; 
 Mon, 16 Oct 2023 23:16:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 41/90] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Mon, 16 Oct 2023 23:11:55 -0700
Message-Id: <20231017061244.681584-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   6 ++
 target/sparc/translate.c  | 126 ++++++++++++++++++++++++--------------
 2 files changed, 87 insertions(+), 45 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index bdbf6d987c..060ee79db0 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -211,6 +211,12 @@ MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
 MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
 MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
 
+JMPL        10 ..... 111000 ..... . .............          @r_r_ri
+{
+  RETT      10 00000 111001 ..... . .............          @n_r_ri
+  RETURN    10 00000 111001 ..... . .............          @n_r_ri
+}
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5af642a637..bf8d611942 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -40,6 +40,7 @@
 #define gen_helper_rdpsr(D, E)          qemu_build_not_reached()
 #define gen_helper_wrpsr(E, S)          qemu_build_not_reached()
 #define gen_helper_power_down(E)        g_assert_not_reached()
+#define gen_helper_rett(E)              qemu_build_not_reached()
 #else
 #define gen_helper_rdccr(D, E)          qemu_build_not_reached()
 #define gen_helper_rdcwp(D, E)          qemu_build_not_reached()
@@ -4446,6 +4447,85 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
     return do_mov_cond(dc, &cmp, a->rd, src2);
 }
 
+static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
+                           bool (*func)(DisasContext *dc, int rd, TCGv src))
+{
+    TCGv src1, sum;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    /*
+     * Always load the sum into a new temporary.
+     * This is required to capture the value across a window change,
+     * e.g. SAVE and RESTORE, and may be optimized away otherwise.
+     */
+    sum = tcg_temp_new();
+    src1 = gen_load_gpr(dc, a->rs1);
+    if (a->imm || a->rs2_or_imm == 0) {
+        tcg_gen_addi_tl(sum, src1, a->rs2_or_imm);
+    } else {
+        tcg_gen_add_tl(sum, src1, cpu_regs[a->rs2_or_imm]);
+    }
+    return func(dc, a->rd, sum);
+}
+
+static bool do_jmpl(DisasContext *dc, int rd, TCGv src)
+{
+    /*
+     * Preserve pc across advance, so that we can delay
+     * the writeback to rd until after src is consumed.
+     */
+    target_ulong cur_pc = dc->pc;
+
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_address_mask(dc, cpu_npc);
+    gen_store_gpr(dc, rd, tcg_constant_tl(cur_pc));
+
+    dc->npc = DYNAMIC_PC_LOOKUP;
+    return true;
+}
+
+TRANS(JMPL, ALL, do_add_special, a, do_jmpl)
+
+static bool do_rett(DisasContext *dc, int rd, TCGv src)
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_helper_rett(tcg_env);
+
+    dc->npc = DYNAMIC_PC;
+    return true;
+}
+
+TRANS(RETT, 32, do_add_special, a, do_rett)
+
+static bool do_return(DisasContext *dc, int rd, TCGv src)
+{
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_address_mask(dc, cpu_npc);
+
+    gen_helper_restore(tcg_env);
+    dc->npc = DYNAMIC_PC_LOOKUP;
+    return true;
+}
+
+TRANS(RETURN, 64, do_add_special, a, do_return)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5243,30 +5323,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x37) {
                 /* V8 CPop2, V9 impdep2 */
                 goto illegal_insn; /* in decodetree */
-#ifdef TARGET_SPARC64
-            } else if (xop == 0x39) { /* V9 return */
-                save_state(dc);
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
-                gen_check_align(dc, cpu_tmp0, 3);
-                gen_helper_restore(tcg_env);
-                gen_mov_pc_npc(dc);
-                tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                dc->npc = DYNAMIC_PC_LOOKUP;
-                goto jmp_insn;
-#endif
             } else {
                 cpu_src1 = get_src1(dc, insn);
                 cpu_tmp0 = tcg_temp_new();
@@ -5284,28 +5340,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
                 switch (xop) {
                 case 0x38:      /* jmpl */
-                    {
-                        gen_check_align(dc, cpu_tmp0, 3);
-                        gen_store_gpr(dc, rd, tcg_constant_tl(dc->pc));
-                        gen_mov_pc_npc(dc);
-                        gen_address_mask(dc, cpu_tmp0);
-                        tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC_LOOKUP;
-                    }
-                    goto jmp_insn;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
                 case 0x39:      /* rett, V9 return */
-                    {
-                        if (!supervisor(dc))
-                            goto priv_insn;
-                        gen_check_align(dc, cpu_tmp0, 3);
-                        gen_mov_pc_npc(dc);
-                        tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC;
-                        gen_helper_rett(tcg_env);
-                    }
-                    goto jmp_insn;
-#endif
+                    g_assert_not_reached();  /* in decode tree */
                 case 0x3b: /* flush */
                     /* nop */
                     break;
-- 
2.34.1


