Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C977C8F32
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmF-0002G6-V5; Fri, 13 Oct 2023 17:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmD-00023B-0s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:57 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmB-0001Ys-4o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:56 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57b706f604aso1427219eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232774; x=1697837574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJHwfAcKqsTK0yqvCsbOGoIF9U6TD7UhbR+nWGTk9G4=;
 b=jp5W/clKxf5B2CvSZvDD9vNVlDYPdCGyTZ7v+Z0vW8eUcq67lmg7EKVKmUlHvK9vPg
 KedmKacMmyVJ3LbpNTHw3OQHzrTLD2DqhuEIJfhXpvGEDUD2xAJXmeRvcsRvKUfZ1qtp
 KM8RlcyHrAe07pMf67+Ii1996Y5/+RtUX4lyXZjnkN0IV/Z9yrTil5oUihFUzD+2RE16
 OZIcjQPfcnTvyTjz3+v2fzRMwxM6pbClmXLNVN8aHyaGLXf+KaxGb1tSoUtSzeJsDPAY
 kdog8I4e/16+YywBGyggePt2XcpkMMo5Ak6uB0KmVoMOn74MXuDXq+9jZqv+QKUvw/H4
 qwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232774; x=1697837574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJHwfAcKqsTK0yqvCsbOGoIF9U6TD7UhbR+nWGTk9G4=;
 b=h11P3gpXBkQNBpnDpdVDVbgYkciJ5iefh85BbJogUC7bkEXpDPZ24a3hPWmsbx1+pv
 K4i/m2v46q+Hp+Z7tYZaLfOyb36LvwPuaNDErqTzHEupSBBmvYXFnmwZsCQzfUJZW54H
 IRkZRQWAzQTsXa1MhG5zBq4cTVBrkGbLuL6jKv4ioUO6EggGSEtDSjAdyz1167B62obP
 /exK0IhsVJm9G5hClec8F2ckeLsAZ3mjjzhOtnTLmYX5eJOgVvEP2tpDQ5hG2cSjpsD+
 gHPAy2MHbTY0DoLeY4y2yqwopzTCkKtZYnB9QJlYBSSlaTLO1hxgx112DUEWP6x/K0kT
 L8yw==
X-Gm-Message-State: AOJu0YwyvQHNhdOZTuagGB2qlUoTbGs0F7zswmkM+8eX5VjWY2yRd5WW
 waSLeKvBhNwHG1hy2ooQKcefH2BtTqiWFaYgH5w=
X-Google-Smtp-Source: AGHT+IHeKSzt52Za6+E/whdrat2fxZzuMsQuzwGsE8N8l7cTIKAxS8nHkiOPvEUF+soVDEeMZ52OaQ==
X-Received: by 2002:a05:6358:93a3:b0:135:acfd:8786 with SMTP id
 h35-20020a05635893a300b00135acfd8786mr34548954rwb.3.1697232774097; 
 Fri, 13 Oct 2023 14:32:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 72/85] target/sparc: Move FDMULQ to decodetree
Date: Fri, 13 Oct 2023 14:28:33 -0700
Message-Id: <20231013212846.165724-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
index a52fac9352..4063695cd9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -255,6 +255,7 @@ FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
+FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4b37a171ff..b0efcb4551 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1539,21 +1539,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-
-    gen(tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_fop_DF(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
@@ -4967,6 +4952,27 @@ TRANS(FSUBq, ALL, do_env_qqq, a, gen_helper_fsubq)
 TRANS(FMULq, ALL, do_env_qqq, a, gen_helper_fmulq)
 TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
 
+static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    gen_helper_fdmulq(tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5033,11 +5039,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
-- 
2.34.1


