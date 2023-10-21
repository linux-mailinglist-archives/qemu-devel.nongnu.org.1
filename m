Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8B7D1B20
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ec-0003Mu-Qr; Sat, 21 Oct 2023 01:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eZ-0003KS-1C
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:03 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eW-0001Al-U1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:02 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7789cb322deso100883785a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866560; x=1698471360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DAJAtz1OX7RgBPpkaJPdRDiqx2t3tyR4Ljt1FBy6I4=;
 b=oKH3vb5d2POZz3rEm8MJnKv8JYrJB4cETJTETLm+V3n/QF/Y5WU82+hcAQre6ZujS1
 WVa8DUQ3YjbvcQLXTyQB876DwGFmQk8/ELy7yEhQVBKnTG722gBxGy0YvGAocuF9Qs0I
 Y4Pe1ErdBsWe6fpEhoNwbBn4oKXBISTZamMfpCrxRg7IDMbuV1Fo4+w10cGC1AW4lVmN
 GKpIr22UEa0Mg/knIXmTX5LI6PTdiXTFexqcvfBYDzBwL/Tmcv8yuaC7SxA9XhlVh/22
 6mX8q9Rt+M9NdWOMT9+rdhrmaJWZrF/Qhr6FVGcC31UwcOxN2wmgcuWU9ai+cC9MT5M2
 rrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866560; x=1698471360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DAJAtz1OX7RgBPpkaJPdRDiqx2t3tyR4Ljt1FBy6I4=;
 b=v+wYLJ6jvJIJN2mF4n+oeKSEjEfvQQGuSqZswBbliH9qsuw8JxpObTtcFKHoWdcjdT
 XU552E3s8DEbrEUX2YmsQlNfQyRRhi9Ko2oyMdv5mU5WskjLAxLWOYF6DcAVCvudFxcX
 517ZBFif/fOrix6QEYZFqziqXvQsFrtCebhKAib0ab0AESb2EeNmF9IweYVOkzAARGoD
 N493cPx6IErhfSuA4WqxSibLRBsa3qHF0G4iWfpJD6I4at+0/CrxFtDUOmDLP0ONDoZi
 reImC7mz4eGb2HPq5V2nUd2eTtTc5e4d8+SdLFtnzV5gaNx4x0JkZpOfclX3W5b2+ngN
 Dzjg==
X-Gm-Message-State: AOJu0YyfZ/EsFPyb/+ZxJJgmwp6GdZsM9kj2hcYm+zA3a40yA1HRuWbt
 8wda1gxZOJ97gcUf41nmPbZXKCrxIPjORbDq6bI=
X-Google-Smtp-Source: AGHT+IH/vAfE9qUOCJP82TZSAiHqPJG7QY9pjYClSD/UchR1UJDJ4b0ddqxSS0UX2KJjRVB9kASX9A==
X-Received: by 2002:a05:620a:2941:b0:76d:aa23:f8e1 with SMTP id
 n1-20020a05620a294100b0076daa23f8e1mr4658959qkp.27.1697866559793; 
 Fri, 20 Oct 2023 22:35:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 72/90] target/sparc: Move FSQRTq to decodetree
Date: Fri, 20 Oct 2023 22:31:40 -0700
Message-Id: <20231021053158.278135-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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
 target/sparc/translate.c  | 39 +++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d8a49838a0..6994312909 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -247,6 +247,7 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 38ad2034eb..2d594ddc9f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -71,6 +71,7 @@
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fsqrtq               ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -1682,18 +1683,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_ptr))
-{
-    gen_op_load_fpr_QT1(QFPREG(rs));
-
-    gen(tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -4962,6 +4951,27 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_qq(DisasContext *dc, arg_r_r *a,
+                       void (*func)(TCGv_env))
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    func(tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5107,11 +5117,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2a: /* fsqrtd */
                 case 0x82: /* V9 fdtox */
                 case 0x88: /* V9 fxtod */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x41: /* fadds */
                     gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fadds);
                     break;
-- 
2.34.1


