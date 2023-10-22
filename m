Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90E7D2733
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qui07-0007X5-GY; Sun, 22 Oct 2023 19:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui03-0007Lv-Oy
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qui00-0008S1-T6
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:36:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1936467b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017807; x=1698622607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilMoYO+UORlqNDjTxgPfqAipaEowY/O8LpHmzBfWvZI=;
 b=BRS/HAvW7zT+lZTOlm2bqNe4Hb3Kxo8G0YP81BmGQVkc03brVL6uPQO6QdeaQCM1Ry
 EY+8TTIGiPui/NYlErYdeiEAX+WtPkNZJdOuYrdJ9XCWw97ZbjwB6uDPv8QCNVZ6yLIv
 rsYdoKwe13/HTvnTxrt5a6/PRSt/nScgtAWnU9ShWZumObCMSlcdAS/BCKU37wndDAzj
 RB14RMwfvfJgJGW7mZAx0smOxNTex2tMFlgmkM0ISMg02qRO3Ch0DQdMWX4znX3M2dZA
 /d8rd9MDg2lQM3K/07wGwgjPQ2xMstn5mxKP+w4kkZAUSLntZ6Jsw/Zy+2YzbCiw6T/i
 tJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017807; x=1698622607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilMoYO+UORlqNDjTxgPfqAipaEowY/O8LpHmzBfWvZI=;
 b=aEZAja2FkXleOwuTuK2AllMaIBRpHgL/DNikb7HWaMU5CVJcioFP0VtzAYofT2v8d5
 PvdKONpTHguZplPLKTUcWuzKewYn3QcDpmymWZ8wachhwnkGsjceqrVpTuGYwW2Cvcgn
 NCo92EoDGCmGVurSb8wV8fe/DXOZGGxYiP73OnGbAMZPc0K5bOJ2MVx91324fuqCu7vo
 8Bcmyrj9j/5NLIhGmtIK6VMEw+0chPaoZWBIZWi/qBqrKCU+NLrjPc6JTYhKzAW/Kt1o
 h8N9VO3rB2FcE1AqfA13LLyf2NH39udS4sVV0RonocO2CwColAeIdTLLB2evlQIGLWbM
 ysVQ==
X-Gm-Message-State: AOJu0Yz3tkrOXsXPSwvLQQ5+x6l90OgkEieyKmD5aZ0Dwe+JT9gGprAu
 5ZkpW/WiHUifrSsSUPR+KGzPcvnoQVSh9TIGa3g=
X-Google-Smtp-Source: AGHT+IEnmBDJ403rrAv0BzDeZBeSM8JngeY6mkNzWMxLlRd5iVOjYgesVdAI2H6VOLbY5hnStZlsIw==
X-Received: by 2002:a05:6a20:1604:b0:17b:8638:c6c6 with SMTP id
 l4-20020a056a20160400b0017b8638c6c6mr12989377pzj.13.1698017807550; 
 Sun, 22 Oct 2023 16:36:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4026861pgf.12.2023.10.22.16.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:36:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 86/94] target/sparc: Move FiTOq, FsTOq to decodetree
Date: Sun, 22 Oct 2023 16:29:24 -0700
Message-Id: <20231022232932.80507-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 44 +++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7b65b31f89..c76e603f2d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -273,6 +273,8 @@ FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cbdaa4935c..784558cfc5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1672,19 +1672,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4800,6 +4787,29 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
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
@@ -5085,15 +5095,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


