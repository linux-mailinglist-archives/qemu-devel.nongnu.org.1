Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65FA7C8F4A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPml-0003BV-Ff; Fri, 13 Oct 2023 17:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmE-0002Ca-8w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:58 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmC-0001Z3-7Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:57 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fe87cd74eso97907839f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232775; x=1697837575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbxnAZ0W5cYgIkkfggAEjUvdbJ7p+9d4s86p1nZfkxE=;
 b=f/we05RbEfsR1r3eO8omP0gXEShTnhDMkh/0A0l97hiRuk/ceGInJV83YqcGqy3j7G
 qEof09ObBQ/5nAe678co4eswRLTa/diIh4P0X79np2xwTaScTSkHE9WAXI7L5Rd6EhoA
 tJT1XkuVmgOaq+MSkzvaD4bYFHV/nzrKvtYwCxLSntgsBm6LUcWDXTOQTpDJMdf/9Zzv
 RzEVh0p6MuzOBo6TUFx+kkh6rOOIWFPYEq+SbQLgEM+iBq/Bv+ncd135mcrkNuUOUJW8
 LGOQaf+NmSg8K4OM8USMCSbCOh7YdZzcRr6ne/M9BTYXy/lZ/8m9GtIwvZ+CEnQ8MiwP
 hMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232775; x=1697837575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbxnAZ0W5cYgIkkfggAEjUvdbJ7p+9d4s86p1nZfkxE=;
 b=CxXZ0frn/abSDVRVK38XeOh1to+mTDypQYYYEo+0KB00Uysxyk2APBGGwQnr39ITdG
 ZNZIhS8wYipXqYwJsF0a4HU+Zo3kREtQR0dKTHpovSl9fp03FhDNsbmmkOQtLWb2yxjm
 H+AnvCwh6Y9Tewa2Uev4rPpV84iYiln+440wferv2rapsT1jLIYiCCv8nP34+oK1XmHC
 igZp2ETD/g11fxbtF8VZaD1aIln2fiG+Ttz6nN2Zz2/dWtjVLzjkyQLHgGccR0HKBB2w
 fHtxcOjo5kiMz3pxiRTld4fIzvpdTpJ2jcRKtfLo5b0xYOTq8TpZCNsloR22uvbR3TqB
 GJmA==
X-Gm-Message-State: AOJu0Yz97e71Ex1lpWXpDBrJwaf/BWe5yJ+G/0UGXdukWP4T9RcwuaXy
 Kgmq/UievZ9GHSL55yalDsgmfc0XScN1MZsG3SE=
X-Google-Smtp-Source: AGHT+IHFYOtSg++6MOCOcFRS8H/M7wQnQGSktEqTsj+A40MxLEF8V1EpdN6I3z/wnVSxglYN+1ioHw==
X-Received: by 2002:a6b:7a42:0:b0:792:884b:209b with SMTP id
 k2-20020a6b7a42000000b00792884b209bmr36074585iop.9.1697232775026; 
 Fri, 13 Oct 2023 14:32:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 73/85] target/sparc: Move gen_fop_FD insns to decodetree
Date: Fri, 13 Oct 2023 14:28:34 -0700
Message-Id: <20231013212846.165724-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd2b.google.com
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

Move FdTOs, FdTOi, FxTOs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 51 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4063695cd9..6378dc5d07 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -257,9 +257,12 @@ FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
+FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b0efcb4551..c1a82b4c9a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -57,6 +57,7 @@
 #define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
@@ -1570,21 +1571,6 @@ static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_FD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i32 dst;
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4700,6 +4686,29 @@ TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
 TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
 TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
 
+static bool do_env_fd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FdTOs, ALL, do_env_fd, a, gen_helper_fdtos)
+TRANS(FdTOi, ALL, do_env_fd, a, gen_helper_fdtoi)
+TRANS(FxTOs, 64, do_env_fd, a, gen_helper_fxtos)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -5040,10 +5049,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
                 case 0x6e: /* fdmulq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
-                    break;
+                case 0xd2: /* fdtoi */
+                case 0x84: /* V9 fxtos */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
@@ -5070,9 +5079,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd2: /* fdtoi */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
-                    break;
                 case 0xd3: /* fqtoi */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
@@ -5097,9 +5103,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
                     break;
-                case 0x84: /* V9 fxtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


