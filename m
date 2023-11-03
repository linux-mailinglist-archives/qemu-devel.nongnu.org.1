Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742FB7E07A7
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8Q-0005FX-ND; Fri, 03 Nov 2023 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy89-0005Ck-HK
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy87-0003Pb-SL
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc5b705769so20985665ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033125; x=1699637925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=196HkJqsXRP9ZkYEyhMzcP9OWyBAk1XF71YuvBdwdd0=;
 b=FjPT1VJp+hpVgtR/RvxXX+utqgpZgNovtqMpic858z1TzRQEJ2SfYrb8B/Tzr+0CsH
 DMLkESlupLvwe81e4AIJoy855EOBN485yRKtCr7ZFyBTdL8huH1Mema1glN4vRlbpg+Q
 N4Z2IkgO/fmqEHnwwLyYbnq0qWvAc7SCbiEucz/ym0hxUGJ5sdeJF9zA9HHU+DOv1I7C
 c3k5QT83iO+ZcSX8ZiumJrS/8ol7CD5JKngr0aDD3t4xYTUeExYEDi6nLIVD66p+e9G2
 q/6x8cYA50DmHUSUfkq4KpkGUthrsQalo3p6tET85HjQMXS0bsFy2OXANS72YeHpWqB9
 A6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033125; x=1699637925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=196HkJqsXRP9ZkYEyhMzcP9OWyBAk1XF71YuvBdwdd0=;
 b=fCZhmqQeLC3Rz93YRRGbJpV+wOA5/DZSRD+ykEaK5CuTpK3BRq/Ro34d5Uw8BQSDIY
 OCJv6fLkg4GPk2yN9fJ8Z9i4nwsblkPQFRWHkN0faY8wTpKP+kQ24vn38qfbsRu6NsBR
 h/KgrfadkWrKqsbruWAkvahZF8AQhYtKhR1knQCIHSsKlEsvTPMtBr02CLUShIXqryHN
 jKHNKtl09lHjAJN6c+jRclfT/CWwthrv55TLgZxMrXVJ6B3vGGRbDhydSYcEO3Pztwyx
 GYPUo+y2pTEAHuOdHd2zNT4yfbixCr3WbwH7pqxZ95PgVgsypLIir0Def/pOgABfaNgA
 AhXQ==
X-Gm-Message-State: AOJu0YzCyLPiptWV2Kd1GJuReRF4VRhHEfBL5U9LCMUMku9rdE8eCGLH
 nhS2VkHxCDfDjw6wxGqQFZgWkVwSZuvUmn0eIkI=
X-Google-Smtp-Source: AGHT+IH6yrNqrkfeqByyj2XfR7kiL+ByYcuxYAlENDC04C04z37HgLt3ecR0RDC9J1pUi5Spxi/EpA==
X-Received: by 2002:a17:902:ec84:b0:1cc:4cb0:d273 with SMTP id
 x4-20020a170902ec8400b001cc4cb0d273mr18059350plg.56.1699033125170; 
 Fri, 03 Nov 2023 10:38:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/22] target/sparc: Remove gen_dest_fpr_F
Date: Fri,  3 Nov 2023 10:38:22 -0700
Message-Id: <20231103173841.33651-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace with tcg_temp_new_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 713ac5bbae..cdc85be807 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -246,11 +246,6 @@ static void gen_store_fpr_F(DisasContext *dc, unsigned int dst, TCGv_i32 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static TCGv_i32 gen_dest_fpr_F(DisasContext *dc)
-{
-    return tcg_temp_new_i32();
-}
-
 static TCGv_i64 gen_load_fpr_D(DisasContext *dc, unsigned int src)
 {
     src = DFPREG(src);
@@ -1873,7 +1868,7 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
         memop |= MO_ALIGN_4;
         switch (size) {
         case MO_32:
-            d32 = gen_dest_fpr_F(dc);
+            d32 = tcg_temp_new_i32();
             tcg_gen_qemu_ld_i32(d32, addr, da->mem_idx, memop);
             gen_store_fpr_F(dc, rd, d32);
             break;
@@ -1938,7 +1933,7 @@ static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
             case MO_32:
                 d64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
-                d32 = gen_dest_fpr_F(dc);
+                d32 = tcg_temp_new_i32();
                 tcg_gen_extrl_i64_i32(d32, d64);
                 gen_store_fpr_F(dc, rd, d32);
                 break;
@@ -2228,7 +2223,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 
     s1 = gen_load_fpr_F(dc, rs);
     s2 = gen_load_fpr_F(dc, rd);
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     zero = tcg_constant_i32(0);
 
     tcg_gen_movcond_i32(TCG_COND_NE, dst, c32, zero, s1, s2);
@@ -4497,7 +4492,7 @@ static bool do_fd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, src);
     gen_store_fpr_F(dc, a->rd, dst);
@@ -4539,7 +4534,7 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4697,7 +4692,7 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     gen_op_load_fpr_QT1(QFPREG(a->rs));
-    dst = gen_dest_fpr_F(dc);
+    dst = tcg_temp_new_i32();
     func(dst, tcg_env);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
-- 
2.34.1


