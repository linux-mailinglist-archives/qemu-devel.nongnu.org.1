Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F87D273B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx0-0006WR-Em; Sun, 22 Oct 2023 19:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwv-0006PB-92
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:37 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwr-0007hD-5U
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:36 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5b856d73a12so2035270a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017612; x=1698622412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/5HWHxi5lWTHsOXnAri2MvEBcCtA2uA7h4GTACftqg=;
 b=GdKYKOSzp6GkXhyfnCLFaEamdE6CGAcNIC2xqU+2xGsuzDQOgMfybImgsv9tCrO73R
 WGfu9R98DC4/qOXNaDy1Y0jY1cdN34JJGCpOHxfzAIrOgW2xBR2l+6GhvTSJsNqZ/7rg
 8qFzc5jKmra1KLiK7g8/3gNTf0DKx1PMCDe/I6RocJsGX3FyKXZ0fBvBEOX7QtTdFc5C
 BYGFdwue7yZXKrQAe6dGE3o6wJ7kqRdvo8mQVwcofy8cRZJX3cuenJ2cz3Vrqc7/eVDX
 krkOLGDSkqUk2uADO10cOsCNV9UMlki8uYiASl/ERwwo4LuDBcbe/TL6gxdqjtddK9B2
 E55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017612; x=1698622412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/5HWHxi5lWTHsOXnAri2MvEBcCtA2uA7h4GTACftqg=;
 b=FgcElxEBQt+OjRAdSAuu3rEpDEA+3xAToyXkNUhSTFUKvD3cKf/uL0du5hBA6Tx3vs
 DiXjej8a/Kq4r1gSye9jpZ4OujSQmXECpI9Jfa0yO7TGObyeKpudKk44G9FfRKNn57wh
 Db9IQwLD5fOMPxlDkL2VnpTmvovwOSywza8Wl5O50VGMCG2mBGSyGaLRDSkkpsdMav9V
 IKQMLIjFI4p3IwGpgMzvDjtYmPdC/8hn7l1uG7WNeBeFhARYBYAzi+sTBG2i2AKNkfj/
 S4449uPHzjFEU+0kSBVuVAHs9QwLBt5QKunJpx5C0R+u4onSn8iOj8lVWOAFen7om9aJ
 P3iw==
X-Gm-Message-State: AOJu0Yyzjke+bK/o9GScgmZ3kpXrJUi55VTQNYCRj7lmHGiYzuOwDdMu
 z6ZPkxOzCM6TGQ1U1kwxuXKZnZDJ4mPyXfIzaNA=
X-Google-Smtp-Source: AGHT+IGVoJPu0tQydnv4UanFOvEM0XuQlhanAUicUTBDBtaQiRDBYFJoO1SiKAsh4LN1mp/+qhJMNA==
X-Received: by 2002:a05:6a20:9188:b0:15e:a653:fed5 with SMTP id
 v8-20020a056a20918800b0015ea653fed5mr9485137pzd.16.1698017611840; 
 Sun, 22 Oct 2023 16:33:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 68/94] target/sparc: Move FMOVD, FNEGD, FABSD, FSRC*D,
 FNOT*D to decodetree
Date: Sun, 22 Oct 2023 16:29:06 -0700
Message-Id: <20231022232932.80507-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/sparc/insns.decode |  7 +++
 target/sparc/translate.c  | 91 +++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 669a54e297..23a21f2c20 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -239,8 +239,11 @@ DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
 FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
+FMOVd       10 ..... 110100 00000 0 0000 0010 .....        @r_r2
 FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
+FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
+FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 
 {
   [
@@ -266,9 +269,13 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
+    FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @r_r2  # FSRC2d
     FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
+    FNOTd       10 ..... 110110 ..... 0 0110 1010 00000    @r_r1  # FNOT1d
     FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
+    FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ff6bbc02d1..50f5a91d2d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -44,7 +44,9 @@
 #else
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
+# define gen_helper_fabsd(D, S)                 qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
+# define gen_helper_fnegd(D, S)                 qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -1420,6 +1422,24 @@ static void gen_op_fabss(TCGv_i32 dst, TCGv_i32 src)
     gen_helper_fabss(dst, src);
 }
 
+static void gen_op_fmovd(TCGv_i64 dst, TCGv_i64 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    tcg_gen_mov_i64(dst, src);
+}
+
+static void gen_op_fnegd(TCGv_i64 dst, TCGv_i64 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_helper_fnegd(dst, src);
+}
+
+static void gen_op_fabsd(TCGv_i64 dst, TCGv_i64 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_helper_fabsd(dst, src);
+}
+
 #ifdef TARGET_SPARC64
 static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
@@ -1639,21 +1659,6 @@ static void gen_fop_DD(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_ne_fop_DD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4826,6 +4831,28 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_dd(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVd, 64, do_dd, a, gen_op_fmovd)
+TRANS(FNEGd, 64, do_dd, a, gen_op_fnegd)
+TRANS(FABSd, 64, do_dd, a, gen_op_fabsd)
+TRANS(FSRCd, VIS1, do_dd, a, tcg_gen_mov_i64)
+TRANS(FNOTd, VIS1, do_dd, a, tcg_gen_not_i64)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4869,6 +4896,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x1: /* fmovs */
                 case 0x5: /* fnegs */
                 case 0x9: /* fabss */
+                case 0x2: /* V9 fmovd */
+                case 0x6: /* V9 fnegd */
+                case 0xa: /* V9 fabsd */
                     g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
                     gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
@@ -4971,24 +5001,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
                     break;
 #ifdef TARGET_SPARC64
-                case 0x2: /* V9 fmovd */
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
-                    break;
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_move_Q(dc, rd, rs2);
                     break;
-                case 0x6: /* V9 fnegd */
-                    gen_ne_fop_DD(dc, rd, rs2, gen_helper_fnegd);
-                    break;
                 case 0x7: /* V9 fnegq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fnegq);
                     break;
-                case 0xa: /* V9 fabsd */
-                    gen_ne_fop_DD(dc, rd, rs2, gen_helper_fabsd);
-                    break;
                 case 0xb: /* V9 fabsq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
@@ -5201,6 +5221,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x06b: /* VIS I fnot1s */
                 case 0x075: /* VIS I fsrc1s */
                 case 0x079: /* VIS I fsrc2s */
+                case 0x066: /* VIS I fnot2 */
+                case 0x06a: /* VIS I fnot1 */
+                case 0x074: /* VIS I fsrc1 */
+                case 0x078: /* VIS I fsrc2 */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5384,10 +5408,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_andc_i32);
                     break;
-                case 0x066: /* VIS I fnot2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DD(dc, rd, rs2, tcg_gen_not_i64);
-                    break;
                 case 0x068: /* VIS I fandnot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
@@ -5396,10 +5416,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs2, rs1, tcg_gen_andc_i32);
                     break;
-                case 0x06a: /* VIS I fnot1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DD(dc, rd, rs1, tcg_gen_not_i64);
-                    break;
                 case 0x06c: /* VIS I fxor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
@@ -5432,10 +5448,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_eqv_i32);
                     break;
-                case 0x074: /* VIS I fsrc1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
                 case 0x076: /* VIS I fornot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5445,11 +5457,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_FFF(dc, rd, rs1, rs2, tcg_gen_orc_i32);
                     break;
-                case 0x078: /* VIS I fsrc2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    gen_store_fpr_D(dc, rd, cpu_src1_64);
-                    break;
                 case 0x07a: /* VIS I fornot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
-- 
2.34.1


