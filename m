Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C67CBAE0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNw-0003hX-8C; Tue, 17 Oct 2023 02:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNo-0003RF-SS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:48 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNk-0004mq-Ie
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:48 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-581cb88f645so345757eaf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523403; x=1698128203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAFj8x/czFPdwn8DziPG6iUtUxhBh9W+l521ap6aJJU=;
 b=xHST2L6g3q486PM4evGzyV2xgXdre8FGEHcZbsEnQOQSfq05cyA3ikGsv540kXugWj
 aiGGOtx48VfcS5fA+omKK3oqgRRUJnlxsAKM2lfcl3jfW5dKqx1L5QdWLADepsCj4PZO
 ZExJ4oSthBmWU62847uDNCNn0P1wVX0T9043iTQfzImOwfRUrJB3KJrJVjhTOKpOYq8x
 cgthwaIi2JS1CZV5XYcJBJnQOPO77nkdYkS8yTJHI5TkC7jOzVCeYb+9If6kg54ROdvM
 NEV8pyc1tmNKyKlTpcNwnw8K5ee8rX9GaRAEG5fJU0Qr9XGjgs3+Z7IKfdYeOgeIqbwR
 v7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523403; x=1698128203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAFj8x/czFPdwn8DziPG6iUtUxhBh9W+l521ap6aJJU=;
 b=iHuzKbJ53UeHhtGhM3QS6Mh96pkb76Bo9xMy1W1LT1d+QV/D1L0K1cpckAUlesbaDx
 IoAi4tV61uRTC2dLlfOdl2uRtuB0eyBqKvhOiMw48XeBC2GjfObC5vZH17CYDQHdFMJ5
 VpOqLB607Ut3XKtAvSbLuLm54j05aA3kEl3Me2qyLSZyQqyGkXRwe0wiLgB+hZLo11VS
 pZhnOBmtJ5yt/kS5WVdRefqbUQ/U0fQL5pxk0k5VVp+zmeZTacczk4FjpZOO8DHEHMkM
 w5u5H3wOpaFlHvapBQWvCDKN+B0Vj/SPFjF2ghMi10fToeF0Act71/myXsaSyE5oBrpU
 QV1Q==
X-Gm-Message-State: AOJu0YxXkCtHtho42yquwUuDZdoUrgsrPgXg3+pO9PwCp/XouTXGGV4Z
 lGJXeRXFk7jdVEXxFQZ/W/CcLO2kEmWQd/FGhqE=
X-Google-Smtp-Source: AGHT+IEtyKc5/xj0e69uquyjKCHB+b4KdXzmtd31aGVmf5WJ6ej24phWp6LUbySktKDU3hNUKHHEOQ==
X-Received: by 2002:a05:6359:3107:b0:135:57d0:d171 with SMTP id
 rh7-20020a056359310700b0013557d0d171mr1500510rwb.15.1697523403311; 
 Mon, 16 Oct 2023 23:16:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 68/90] target/sparc: Move PDIST to decodetree
Date: Mon, 16 Oct 2023 23:12:22 -0700
Message-Id: <20231017061244.681584-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 41 +++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 197d6a0db3..64a7b3bd0b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -270,6 +270,7 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a5901164f3..5d2c95841a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -68,6 +68,7 @@
 #define gen_helper_fmuld8ulx16          ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
+#define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -1634,21 +1635,6 @@ static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 
     gen_store_fpr_D(dc, rd, dst);
 }
-
-static void gen_ne_fop_DDDD(DisasContext *dc, int rd, int rs1, int rs2,
-                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src0, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    src0 = gen_load_fpr_D(dc, rd);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src0, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
 #endif
 
 static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
@@ -4989,6 +4975,26 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
+                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src0, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = gen_dest_fpr_D(dc, a->rd);
+    src0 = gen_load_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src0, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5398,6 +5404,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x039: /* VIS I fmuld8ulx16 */
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
+                case 0x03e: /* VIS I pdist */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5473,10 +5480,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x03e: /* VIS I pdist */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDDD(dc, rd, rs1, rs2, gen_helper_pdist);
-                    break;
                 case 0x048: /* VIS I faligndata */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
-- 
2.34.1


