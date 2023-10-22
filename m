Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C577D2169
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaw-0003w0-4d; Sun, 22 Oct 2023 02:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaC-0001cm-V5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaA-0002JZ-9d
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so2441266b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954701; x=1698559501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt7vNVHDSQjpKHVY0urCrIGKDYssGAGhvlT0D79szQE=;
 b=AckcCwxto8NTVb5WKPt+EYNypfWTOUq11IIos2r/WoXOU+6fcC+9X6kGbdC251U3JZ
 F128Tu+lcuyht+/CbHGS9IbLZryM6qLXk7qA/dPJbTudG65INx/RwZ5iLTBShbHk064B
 gRNlRArek/MU46vYpyiG4Jp8N1R8y4YnZxXTD+5lvK3AF+uQIPZ5EwIEii293wNhoRTy
 K4LG3IDopjcPgwwS20tqaj3lp+k5BPOCJb5ZxFrcJqj0surRx4BL/6GGINyi33N8QGQp
 oFveGKn2cPJ2LqzoO9CCjLZWMcRxYq5R1QhJKrGKxlQALPoci5aIDHxK+oVbsWGa1TE0
 c98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954701; x=1698559501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gt7vNVHDSQjpKHVY0urCrIGKDYssGAGhvlT0D79szQE=;
 b=bZZu+nl0OZ1BIKfA0v4bTLKzzaV6Br++mP2+eoJUsFMUl/vUtuhWfq4KO4C5SARV3c
 FEjBk9c2QM9c3TiQirSC89zf3jWP8G3DllMF4nUYz24wd3+ajzk7vzLuKBYJ4QwlOTWD
 KIiRidxA8bxHm01cdLrci0Nx6Gy4/OpG+LqcJv5UrOaCpD+IBKgp5YVynIrO38bIdgaa
 x0N0LozjtRIqBmi5YadDWJv24gQ6vePv1Q3JMihzGRW5RwZWbT6GTHDj5Fa897oOozuW
 5yiUGYvX6nhZkMLVOCQ0QpuNXbi0x03RiKxIQEHaDyrqEwAaTBnj5GFa/z8H4rWN8+1E
 WzyA==
X-Gm-Message-State: AOJu0Yz1HDNbTG6CQkBZmmJ18NKXlMtmzEdxnnVp4uyZdhSsuF0PHRrr
 GEIPZUflE9pekdUZaJHsjff13FzU+kGB52Rc6B4=
X-Google-Smtp-Source: AGHT+IEEQUS3TZVwgLsh3LolOrF4gWu75oupZrrG5I3kXKzUuBOxKXYyEpND8QUf8yp9hZ15Bmo30Q==
X-Received: by 2002:a05:6a20:2593:b0:15d:8366:65be with SMTP id
 k19-20020a056a20259300b0015d836665bemr7243437pzd.9.1697954700701; 
 Sat, 21 Oct 2023 23:05:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 70/90] target/sparc: Move gen_fop_FF insns to decodetree
Date: Sat, 21 Oct 2023 23:00:11 -0700
Message-Id: <20231022060031.490251-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Move FSQRTs, FiTOs, FsTOi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 47 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index bc449023dd..85464285b7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -245,6 +245,9 @@ FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f60e7603d5..ce5e6ef6ab 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1650,20 +1650,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_FF(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4966,6 +4952,27 @@ TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_env_ff(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tcg_env, tmp);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
+TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
+TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -5127,10 +5134,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2: /* V9 fmovd */
                 case 0x6: /* V9 fnegd */
                 case 0xa: /* V9 fabsd */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
-                    break;
+                case 0xc4: /* fitos */
+                case 0xd1: /* fstoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
                     gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
                     break;
@@ -5186,9 +5193,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
                     break;
-                case 0xc4: /* fitos */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fitos);
-                    break;
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
@@ -5218,9 +5222,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd1: /* fstoi */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fstoi);
-                    break;
                 case 0xd2: /* fdtoi */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
                     break;
-- 
2.34.1


