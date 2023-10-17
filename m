Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF037CBB2B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRr-0005oe-PX; Tue, 17 Oct 2023 02:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR2-0003jB-TA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQr-0005CL-MH
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:19:59 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ae2f8bf865so3319152b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523596; x=1698128396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyhf1sFdL+iqlmxAPOZlXhlHFKLevrlBgIAJcJ46gCw=;
 b=lJsip3q3ZctrtOGwES5bN4a1uleJo46gyC5IkqXFExk3o/GoU9UT4OuDIUop7y7/1X
 tH+8ruzZWjNF3mGBOOu7qrrX2VJ24V7hbMdOKVcF2GRFafQQXECDWcM2Iek9YoXJ3F8m
 i3Czwgu/q3922BRSYjd75raUW9VEMQyIMyJyYIKQyNpjvjBotUtlLEmj5frL62WDabsV
 LAOKy8T2t2OtMw9YeXHFmhJiZWaJPIolC43o3Cjm/nvoy2otGjEXosyRzDnm6nkDOEpN
 v9M5qmTi1uVa94nol+JBAerBSW9V5hZInQZOehoO89IjmvIk/jxz9G7NR4THzEAo6EhR
 oV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523596; x=1698128396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyhf1sFdL+iqlmxAPOZlXhlHFKLevrlBgIAJcJ46gCw=;
 b=wULgIpytAAlL9brtSBTPpCzDq/jCf6pruX7+bd9iMoHWhQNVZHposdPQCDlplhJHz8
 M6xsm8bfFPJtc57xGqNFOJV4IEJnA+Te3V0KET4ow6g1jM1bInAOLTq1xEUy2E+D/Oxa
 dQvLLOIrw6KG1ejw+YnplP0qzr1yVSPxyvI92RBD8ImxyCMMf2+BSlOXKaTM4rBTOrl1
 CO5eqb4O2PoZr6hKcbNGUEqYjJ5jDTEU8VrnZMeLHmX660leDDA4Rwbt/YCpMg1luj8r
 0zXTVqFW53nBH5z/QDb2PHZW5RJ0li61oJ8HXa2yDQQ+ax0IzTcqp8O21LOxOI0Qj3DG
 8i0A==
X-Gm-Message-State: AOJu0Yx2zpbW7YggvB0Z1VU30P0wWzl2sjJs09Am4+KN/l4KegG+PMBt
 BlBBwvD/j26HhRiH2/3ySuXVo33dsegYQMqOyMs=
X-Google-Smtp-Source: AGHT+IGAU0sXbjlA9E44rWmnEoOvve27TZiVTOd8qV4U3WSLqt6AGQU/sU18j50oQSM4cPkAI96WSA==
X-Received: by 2002:a05:6808:42:b0:3a8:4dfd:4f02 with SMTP id
 v2-20020a056808004200b003a84dfd4f02mr1418886oic.11.1697523596372; 
 Mon, 16 Oct 2023 23:19:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 83/90] target/sparc: Move FdTOq, FxTOq to decodetree
Date: Mon, 16 Oct 2023 23:12:37 -0700
Message-Id: <20231017061244.681584-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0b54384af7..0bb5b3fca6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -260,6 +260,7 @@ FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
@@ -268,6 +269,7 @@ FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
 FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ecaf1c02bd..86d77c62da 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,6 +58,7 @@
 #define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1627,19 +1628,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4900,6 +4888,29 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
+static bool do_env_qd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_D(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FdTOq, ALL, do_env_qd, a, gen_helper_fdtoq)
+TRANS(FxTOq, 64, do_env_qd, a, gen_helper_fxtoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5187,11 +5198,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x83: /* V9 fqtox */
                 case 0xcc: /* fitoq */
                 case 0xcd: /* fstoq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-                    break;
+                case 0x8c: /* V9 fxtoq */
+                    g_assert_not_reached(); /* in decodetree */
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
@@ -5205,10 +5214,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x8c: /* V9 fxtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-                    break;
 #endif
                 default:
                     goto illegal_insn;
-- 
2.34.1


