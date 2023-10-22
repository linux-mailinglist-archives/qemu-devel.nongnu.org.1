Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE97D272F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx9-0006s5-H9; Sun, 22 Oct 2023 19:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx1-0006Zn-Ub
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwy-0007mF-LQ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso2748525b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017618; x=1698622418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKN+29GiYlci1os7DddoDhL0F6INAtdqko+LQ2U7Xso=;
 b=KDgVKD6IBPNZr9LYzMm7rnPjQzTjljCrLkD8ntvUfX3VstdJeZxR/F2JH9S2HXtSCx
 +xnoDofMaEr1b1nkPBZ1rc2JZVAvS43v8nxA8mYD2b/JSv+5lDz5DsTdce0TKhL7RiR+
 RjfzVE4o7RAg8nZi4mxbTa9focA+tQWi/TW1+U2iu+5B+pFXKSLF5O46fAvgW0VC7RUH
 duKFF6X+39JkmNOUpnusaUJaWGL1XfQN1U8sH3Ar4A2zTS1AhlVl7DU/uBdD5oAzDHc9
 rECEdZonxXGUQGv9qRcvs7xdGi7Wq7PM4p4Kbct6+umZcXvBX1vi9xYbIYBIxujs63x2
 VvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017618; x=1698622418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKN+29GiYlci1os7DddoDhL0F6INAtdqko+LQ2U7Xso=;
 b=c4YLDuIv9hLmYi2jJImicRi/exNTBbM0cW0IbH+F1BMHHnTAOa0OkecNAW9xVlCQZN
 KNvU7cw/ocqw1kBMtJzeC9Bb+wNeAo47TBo5lvb2s2VEMeZIfkEtO2pXECRsltuq/hE7
 7Q+jFcrd6MGVvbCpYFQOB2FCTOy5MHK79nqd0eoKyhdlQZ+y4Yl2BbEcELxjEOMVJhZq
 L7l8tNeqkt3gsTMXPbwFtIIfZuFiUmEP+kk1CJ2qHn/e0OcoFC5XCMb+SVIUOob3+cH0
 B15HviiWyI4rXco2W+lrQXa+Jg+/bksvT0DLTRaA/9lkEj9KkIZeYhLXe3x6idupIRHc
 A5lA==
X-Gm-Message-State: AOJu0YyyKoZsSmW6hFlcusyvwY1KWloSMPUf9cmM2LD9XcIVRJEYn6tl
 xOoZ3j3uf7Bz6k+o5LDi0eU2cYblYI5WyEsUIZA=
X-Google-Smtp-Source: AGHT+IFvq9tBoGVjZLRsm1qDqbwyoqWjXtkOzYN2Kx+XE2DVirHdxXRkcVykxGlZMqrMG1zjM1EW5A==
X-Received: by 2002:a05:6a00:2345:b0:68f:bb02:fdf with SMTP id
 j5-20020a056a00234500b0068fbb020fdfmr8876550pfj.27.1698017618282; 
 Sun, 22 Oct 2023 16:33:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 76/94] target/sparc: Move FSQRTq to decodetree
Date: Sun, 22 Oct 2023 16:29:14 -0700
Message-Id: <20231022232932.80507-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 38 ++++++++++++++++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1d766fab21..4cb250265d 100644
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
index 45da3e9dfc..23e191aabd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1686,18 +1686,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4842,6 +4830,27 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
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
@@ -4987,11 +4996,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


