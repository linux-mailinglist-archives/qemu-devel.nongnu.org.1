Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCA7D79AA
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA5-0004qC-VU; Wed, 25 Oct 2023 20:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9h-00034h-3T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:22 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9b-0008GL-Jm
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so299767a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279794; x=1698884594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFnSxDeK3rdSz9x4fev82AZ34W6M8VZ9rvoNIcYwmXE=;
 b=L1R4JiZLtpaycJYn1EdrgX/ite72R0Wk2Y2zPT9O2dErHzIX4NOO1WGkQb0XT9TVCU
 UFvyWA6Saw2+zF8C909MvBrPnxgh/H/IFfjUYzeIaXUaD3jIZZ4Zg/G5iB3oznRLWEFE
 TdckOoigZv8xJgEDXQre3+PMUqk35EptP6qpSLb09p/QWREhX2+Pz15G3tfWfvGBgQaJ
 mSdX3Aj1yke7dL9P4d7cB514joMBm5ToBU/cDPGGq0K2i5UVrWcz4TYkVpmgM/tOB+sN
 JKjkHAt8EePMkcCvok0O/s0Mb0sT39D1xo622RsHq7I/knMpz0geAnQ8dj/dyWxkxbVp
 CEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279794; x=1698884594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFnSxDeK3rdSz9x4fev82AZ34W6M8VZ9rvoNIcYwmXE=;
 b=Exb37oqLK4hA68LNKob8F+BYvTnrW/6qbNcc5ODEvJsT3NrN7CIZh4JJtBQmJcD7ex
 uyCCn/flUi0NO8zR9klGMm1OUzAQld6rmncXNvswpiiN2KoUwIB68OwFAc0vKCbZih9r
 n6zBl4co9FTAM4BsOTJVa8bdYe0SQ7OF/HlEXdXk1cjRkqxHhc77K6htjPDk3tRaWzWy
 QkRhnfiNtITYaJ0rdYknl6u38Y2kIhjhD9vhJ5BXPEULtqFzLhINOfcSU1SRl7a8U25J
 eDbN0iBrftNGi/qqR9U3vu0Z649PXFTqzi/SJg7tCjYmmaDtU4mKgcELgv9LzOD5dVPL
 Gwpg==
X-Gm-Message-State: AOJu0YwwavgilnL82PHOhjcjl5I/XEakcOSs2rs+U0jaKuLODAQLOccQ
 ghaQeD9xzFd5z/6RykZGJcMwh1NfmlNth8lKSbo=
X-Google-Smtp-Source: AGHT+IFuPytdW3kOS2I6ngaFh1pw8DdFFnq4oacRfFcfuKU7qHL96lS5qLS8xLKVkxMDU8JccO6pFQ==
X-Received: by 2002:a17:90b:4f4a:b0:27d:1862:a494 with SMTP id
 pj10-20020a17090b4f4a00b0027d1862a494mr14172731pjb.11.1698279794150; 
 Wed, 25 Oct 2023 17:23:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 82/94] target/sparc: Move gen_fop_FD insns to decodetree
Date: Wed, 25 Oct 2023 17:15:30 -0700
Message-Id: <20231026001542.1141412-112-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 51 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a19d191603..faf2bcef83 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -263,9 +263,12 @@ FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
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
index 29643768e1..6c1dcf6472 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -74,6 +74,7 @@
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
@@ -1700,21 +1701,6 @@ static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
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
@@ -4715,6 +4701,29 @@ TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
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
@@ -5055,10 +5064,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5085,9 +5094,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd2: /* fdtoi */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
-                    break;
                 case 0xd3: /* fqtoi */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
@@ -5112,9 +5118,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


