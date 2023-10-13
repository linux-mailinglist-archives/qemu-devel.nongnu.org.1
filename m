Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B567C8F44
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmo-0003gQ-ET; Fri, 13 Oct 2023 17:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmG-0002Uo-Ib
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:00 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmE-0001b2-MH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:00 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c4cbab83aaso1594040a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232777; x=1697837577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqepOeFNPXYARKixzCeY8ehN9qKElU8pUyxhHOBMpnw=;
 b=IciXy3vDOyzOFXv3rfIfrvuF7cGF36wtZm+wzjnlX5UIsfrn8O0PdMtWLCQ1mSMjn/
 HfoFuqB/bpfqvynECefB+lg1k/ouXTf08qYtTzbVHIvWexUdwL/1n5Cq8ymZIUcDU6i7
 3jODQ6DFGSWI3QCISBpRkcGMXb1L72hU+kN/Nse04ST+MOdjBu+JfvEriFBsjcWSuKFL
 WhKyek5DmhaJHw5PXgdW3m3qxuNAJf6gjkaQDT1kydUyqfhxUxacMwj8FCX54ZqgAZ4I
 ztOMxAnqBDaaZkbY3ezfwGhsVpU2cpze8BfZhqhuilgTShbnEdxufByFh1Lr5ZME0Tzq
 c5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232777; x=1697837577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqepOeFNPXYARKixzCeY8ehN9qKElU8pUyxhHOBMpnw=;
 b=FxV+Sj6/oqj9AXCbyx83LyaotjjJUUgWZXI+mDopw/s8z8h5fJ3+jutip6+oHthae5
 XztEvYN6YYbn0i6I89iA/zrUKfu89Nvmmnop4fqPOB3x2joZVkir8gcucFxlcJnYP5iz
 93VjdeY8G+20w8mZWF8oUj0C+vgMXOoA3Br6RZQZ6I4m0kh1xhWhNYvY+rDlWUp60/jr
 patUgEl1vlLEcRCvcRtAiAIgFc4z+MOmngpYPfUaiCf1JEZ8g81VNOfuQzDF0MWWxwKs
 7Hyjz4VZU1ZKTVxmLZRgZlLJNwRxxyujelv9wWh1MgP5IC3Ck8F8swLj8+PNLNm3Kolq
 421Q==
X-Gm-Message-State: AOJu0YxxU3K5FJU3FB0N+JNijvK9ORRoLDqkrx7xqNwISu7nCwPZ9aFH
 t6QVV/s9874Rr73VaPDqe4ZakQ/fshiOEs/fAcI=
X-Google-Smtp-Source: AGHT+IFhqpacQOqPQFL2aMlZR0zSEXOB5ztJ6QAXHl5Uw67Mi9BgYR88pdwHEbFmrun3R+2QUUSz6g==
X-Received: by 2002:a9d:6f9a:0:b0:6b9:14bf:7097 with SMTP id
 h26-20020a9d6f9a000000b006b914bf7097mr27128423otq.9.1697232777471; 
 Fri, 13 Oct 2023 14:32:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 76/85] target/sparc: Move FqTOd, FqTOx to decodetree
Date: Fri, 13 Oct 2023 14:28:37 -0700
Message-Id: <20231013212846.165724-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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
 target/sparc/translate.c  | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f38ea9b343..f30f2bc800 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -258,6 +258,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
@@ -265,6 +266,7 @@ FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ee12a8b9b7..4446bc2e48 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -57,6 +57,7 @@
 #define gen_helper_fabsd                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1541,20 +1542,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr))
-{
-    TCGv_i64 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i32))
 {
@@ -4777,6 +4764,30 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
+static bool do_env_dq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 dst;
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
+    dst = gen_dest_fpr_D(dc, a->rd);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
+TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5060,11 +5071,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                 case 0xc7: /* fqtos */
                 case 0xd3: /* fqtoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
-                    break;
+                case 0x83: /* V9 fqtox */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
@@ -5090,10 +5099,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x83: /* V9 fqtox */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


