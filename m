Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C20267C8F40
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmt-0004Tu-DM; Fri, 13 Oct 2023 17:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmJ-0002kY-1C
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmH-0001bJ-5l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso385354b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232778; x=1697837578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9IeoznCVNi9HF18yQIi5ShIBfQ3I5fHN0cJyJzXN2Y=;
 b=x7fbmewKm71PI0YqmajsrBtMj1c8isqRslVH5b6h8PgRHUC86Z6XDEGZ8YsJMYFPnX
 UNX5Cm3xmPtO70ROFFCd3YLU9n6XybRuXPx1RlZB3Gt/XWVaRT+bFRClFUNKzPD4jKfQ
 yrtVbcb2PqyiQ+MmpETuTu4fKmxrxFSJ4Y3L2V/TQImHbrfXPMgfPfZt11pW/eXhYste
 ZilGuYchJ0rhtRP12xIY/1rbl0twnqQHX6xKMCQkjy9dbRq770mSyuCvZsEaUgzfWWor
 KmZom6HaZSN4G8jszI8TGjkr0/Nj3/fF30ugXH89Yo4FoqTd5w/sMWPiGaj56zdn+Igr
 1jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232778; x=1697837578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9IeoznCVNi9HF18yQIi5ShIBfQ3I5fHN0cJyJzXN2Y=;
 b=KcgpFK2TXerUGI1iY41UIBqFj6O7fS5eNkuo41TfmVP530/71Uz8ccNiVKkaD2P/zT
 p1B94NqMW4s/24Roug8pRZM1K75LI/dTi6TJ5sOX+tbnjuRBv/0zSvuHFPJQwKYWAJe4
 Z+3a/0zYjkbOctpIih/WBoPK2mEwxaTQcfkadQnhwK8T8SoU9FTU1YVYNwfjUHNTl6ZX
 e1ElcFXZn2dCzT5npyRRYS4YuYfU4xy3vtiWMIc+FZ63ODXPk5HQUFeH5cIPDKJbiJtE
 hVmdzKnA9ob8lcAZgCe4xVGyelzRfDLuhER+Ycjw8HlVZ2ED55SeRzybAbh+/YiyQ6LB
 Vb1g==
X-Gm-Message-State: AOJu0Yz9TV9naxXD0rULH4kRD0S+dngGXFHMK3pZwjQsmTDFNmoYg5+u
 D8kcyLq+EDXcAoYwVuiJY6zxudIqMECqHn8PhAQ=
X-Google-Smtp-Source: AGHT+IH4JpU21uDVaBLC8Z+yGHkG7d5hasGIzdVnEmX05ehAInku8ZuT2p6w4CJ60TE2pyR5ySBqwA==
X-Received: by 2002:a05:6a00:99e:b0:68f:c2f7:cef0 with SMTP id
 u30-20020a056a00099e00b0068fc2f7cef0mr2319209pfg.4.1697232778286; 
 Fri, 13 Oct 2023 14:32:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 77/85] target/sparc: Move FiTOq, FsTOq to decodetree
Date: Fri, 13 Oct 2023 14:28:38 -0700
Message-Id: <20231013212846.165724-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/sparc/translate.c  | 44 +++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f30f2bc800..f0a6abb170 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -267,6 +267,8 @@ FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4446bc2e48..d6ae4431dc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1542,19 +1542,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i64))
 {
@@ -4788,6 +4775,29 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
+static bool do_env_qf(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i32))
+{
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
+TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5073,15 +5083,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xd3: /* fqtoi */
                 case 0xcb: /* fqtod */
                 case 0x83: /* V9 fqtox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
-                    break;
                 case 0xcd: /* fstoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fstoq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-- 
2.34.1


