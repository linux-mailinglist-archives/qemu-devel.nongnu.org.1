Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759227D2746
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui06-0007Tv-CA; Sun, 22 Oct 2023 19:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui00-0007Eq-2v
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:48 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhzy-0008Q3-07
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:47 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so1966523b6e.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017805; x=1698622605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWn4MpJzCYB9+YCH5kEZsrYT1lZ09Wk6pL3Euh4t/mg=;
 b=h3Wd9XVsQKN8FeRIHF/4CEGAj3sY1Z8SiBAfk3x48wAVUD8z46lveCwHdfnDiWB0h1
 bj5Lpb1ZlPjwPPzKYXf3VpSZgueVkfWv5fgJc01Oha9uXLnuxvbatLbIlcPETbWcFW9p
 mss48eq2NIvxYB+hKeW/U0HI1BPP5LjQRMDSAKmzUH8FIww6UlOqnSNpZwFePgiF/H4I
 UbUYmCC2F/tOu6MPoOySXjNr00uuhe89DnuIcyzLpad9XCmX1dGkCsUPBnR31gzgzwuP
 FuPSVv2s+Cky5QLYHJdY9k04E5le9xXRrPvpXDlQ9zcx66x23CXimZMAjOfpFN6K4QbD
 UbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017805; x=1698622605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWn4MpJzCYB9+YCH5kEZsrYT1lZ09Wk6pL3Euh4t/mg=;
 b=Dl8VkeB2KzpL/gRNsJwM/VLb6x9tItnIDAvkB/M73A8GcH7gJx85R3rpROdO9NBaVE
 9nNJ3FXOY3gD0aEgSiyNj9htclxWftO1odoN8KgY1F8W6HIkDPOgFJ3ip6kkIU6m8nLZ
 k8NR1jqgdUtovJ9zY79Llnu3QVuqXABzF4iH8qzRV6mxNM1k0mX1FlfVratsPhebsnqk
 DJDZU8+qqyFVlhq5rSmNF2SmM/nF+FRUz/PHLwjrvEIK78jrlCBbW728KJamVOnQRfmt
 pjH2KvLItPY3ufr3VZo4nFfZuImfQL4+YjfMbKiXvQ3WWX76Hup3SJHfFhvtqYqEIVJj
 D28Q==
X-Gm-Message-State: AOJu0Yy232cPP81Xdy+oEk1E45qUrrRxLgJJBEUvwgnqeYAt7XOqDYLo
 yblrXyOKN23ZOoh6dTiU8uL+IBDLFBmVcJjgRxk=
X-Google-Smtp-Source: AGHT+IGd2tcowDZ6U2Akn/2LO4qFYsRRTt4m09putfhJ9qpjrmTAtWhUwYJqxZxEoOWXIEM99/d1+w==
X-Received: by 2002:a05:6808:30b:b0:3a8:7f65:a96 with SMTP id
 i11-20020a056808030b00b003a87f650a96mr8848647oie.33.1698017804792; 
 Sun, 22 Oct 2023 16:36:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 83/94] target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
Date: Sun, 22 Oct 2023 16:29:21 -0700
Message-Id: <20231022232932.80507-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Note that gen_ne_fop_DF was incorrectly named and does pass env.
The two sets of helpers should have been unified.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 67 ++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index faf2bcef83..ee9262061b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -262,11 +262,14 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 92a443d61e..14e0082634 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -73,6 +73,7 @@
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_pdist                ({ qemu_build_not_reached(); NULL; })
@@ -1670,37 +1671,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-#ifdef TARGET_SPARC64
-static void gen_fop_DF(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
-static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4765,6 +4735,29 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_df(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
+TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
+TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
+
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
 {
@@ -5064,17 +5057,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc6: /* fdtos */
                 case 0xd2: /* fdtoi */
                 case 0x84: /* V9 fxtos */
+                case 0xc8: /* fitod */
+                case 0xc9: /* fstod */
+                case 0x81: /* V9 fstox */
                     g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
                     break;
-                case 0xc8: /* fitod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fitod);
-                    break;
-                case 0xc9: /* fstod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fstod);
-                    break;
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5108,9 +5098,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x81: /* V9 fstox */
-                    gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-- 
2.34.1


