Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F37457CBAF7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRy-0006SO-SN; Tue, 17 Oct 2023 02:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR2-0003hj-D6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:12 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQp-0005Bo-LC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:19:57 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3af609c3e74so3555398b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523594; x=1698128394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=np6wyp9H5bwq/rv3no32dfOhOOOhfjRybO2Ph28cMbc=;
 b=yH0Dn3hUN3GfrEMRc3x+yLYG40Q1yYrwLfxWJKF2ZlZ+jmKPNIhhc1zGjKYvMR2Bxc
 NTVKzc1378bW5ghBlGc7njdc4UoN9OHMio0C0gigbER6mgUVMqCuYLJlLc/DCQIIbPpv
 waagnnyj9596Ttox+xskDUk5B97w6suf7cHQV7bG/wRPwSL3ySWJO/UDGIefYfCCIVdY
 5u8UaEqeMWB6+a7iYzQzn/0wL/AS/znwODgYcbHm+d47gmoJ5Q3lZY0lEm91Cx2IufKO
 RVTplWNOpNG64f//e2APdG7k4g5gZuoc0IkG3kmM2gDT0PuRD4mN9P/5anHgLd58laZi
 34qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523594; x=1698128394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=np6wyp9H5bwq/rv3no32dfOhOOOhfjRybO2Ph28cMbc=;
 b=dWySW5FPOlnB2ex/F1pBfgA92LALZbnjqtOdYRQcToqO8S2qUOND6FFCoATufd/AbT
 3VeYmW1rb91kYHy8KvG7WXPSsTJLilC/OX5lDZ/uE49EaUsGQXXa6CK6+DLRJk+McOeU
 YBbxIeySr2SZVv2Gh+hTJT0cx4HlpnD4HHjjVbqRDQfE1xFP1wux+IlCvnAd2Zj6CY8d
 JgakKdPCecXJzMWmYDOLQrxypJoEvh0u92/rtkLtLBcRMR6+mwI1Z+G860vyvls8oN/w
 bsW4Vr3MbUXiK3rVLe7aCvt1qslCiFKIwJG317/3MsoZOErYKrf8JdVmwNmq0VUBV423
 SiAQ==
X-Gm-Message-State: AOJu0Ywd9KBxtnPnLAz1Jp+MFqlKxsbcQokB8pLU6M+rVOmeWE9cOyax
 rILOm4ChzI6cjUHdyoumhn24mz8o9xOnAxnPMKU=
X-Google-Smtp-Source: AGHT+IGvjEMF4XDi27ktekTyOpxwA7rleEwOzWTCF5xBJVIp5N88zSDwg0SBVMMxur0QkLi/ZRDj/Q==
X-Received: by 2002:a54:4103:0:b0:3a7:30cb:c092 with SMTP id
 l3-20020a544103000000b003a730cbc092mr1481350oic.48.1697523594051; 
 Mon, 16 Oct 2023 23:19:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 80/90] target/sparc: Move FqTOs, FqTOi to decodetree
Date: Mon, 16 Oct 2023 23:12:34 -0700
Message-Id: <20231017061244.681584-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 target/sparc/translate.c  | 48 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1965084fb8..d890d97f12 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -261,10 +261,12 @@ FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
+FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 395674d901..3d073c8b22 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1626,20 +1626,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr))
-{
-    TCGv_i32 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr))
 {
@@ -4869,6 +4855,30 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
 TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
 
+static bool do_env_fq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env))
+{
+    TCGv_i32 dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    dst = gen_dest_fpr_F(dc);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
+TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5150,11 +5160,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc8: /* fitod */
                 case 0xc9: /* fstod */
                 case 0x81: /* V9 fstox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
-                    break;
+                case 0xd3: /* fqtoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5171,10 +5179,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd3: /* fqtoi */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
-                    break;
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
-- 
2.34.1


