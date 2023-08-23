Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EDD786166
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOh-0000Ht-V6; Wed, 23 Aug 2023 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOd-00005V-Hq
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOa-0005ZU-SG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf57366ccdso1605605ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822243; x=1693427043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d7f9xMn3s76GGCrTSbv49LCbGX2TpxUayf0OW1Jmmg=;
 b=i7LrKwRtWPnBLIGZngc6Xiy7boKCuCaTb2gsuiXUbTHpbGnkarDf0KE6Ke/M9rewHT
 dYMcdy7RIUVHmky80ZKf94XklAxxpu6Mo/W2Ay2CW4ixje4GZnGurIUmZgw25Lj8qQrb
 7T8LCo2YHmG+9eN5xAVV16ZFLfk8t82yHmR5wxDfm+yxVcf1a77OkAcgWEVbqRAB4PNn
 AkuPZYJlqlPG8WTZln6CFgcyHERsuxwK9PmzQYUo7eY2NbeOl+Dx+svRKDXi1eYyOi+4
 5fuEJUC5Ifg25o95P260IAvsTJ7dEtZ4vIFCnsKShoUG4O4PM+ELp9AgOuefkfc0jdNH
 lSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822243; x=1693427043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2d7f9xMn3s76GGCrTSbv49LCbGX2TpxUayf0OW1Jmmg=;
 b=JiI0+gb/DT8jt9wbSIxgw03xSpPN9LXY8l7ns70/1QtcZwUBn/CEI+P+7MELm0hl7g
 PDtPAnWVAHO6pYJkY4bi9lghoInGvygUs8U8hZMRpQhRCeD1eam3j3tlP/rTZZFm51aq
 jrXrecD1MMf4WfFa7rQXKXqns/OsGMRnNFP40Z8ndSNU2FYW+2izwAL55Et/RsdWGbDZ
 +3FOcWgFITO9JiU/8+pEoz8yndlsy4KU/QIBF4JuZWiZ4lvzBH4jtOGd9Lt57gcubmhx
 StkHqvSC+KYlwJ3vIaMNpZjdwseiPpm9kN1hZX5+Om5mxKHMzs6c6gjSKIVZlpSt6f1h
 cpmQ==
X-Gm-Message-State: AOJu0YyaOBEau1092dYo1OW8P282+q6eSFM7f74JMzuou9nw5gO3HQWl
 7KahsKqfYo+i6Xz+zIuWJxkKCaSYzIyi6t7vtHc=
X-Google-Smtp-Source: AGHT+IH0UI/i/9XYMzFp3baFwwmWbeX71vUQ6w/8hfP5fOgLI58PHq1cbU7n1MiYFhBfrmDi2adQ2w==
X-Received: by 2002:a17:903:1c4:b0:1b5:522a:1578 with SMTP id
 e4-20020a17090301c400b001b5522a1578mr20049442plh.29.1692822243553; 
 Wed, 23 Aug 2023 13:24:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:24:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/48] tcg/tcg-op: Document bswap16_i32() byte pattern
Date: Wed, 23 Aug 2023 13:23:17 -0700
Message-Id: <20230823202326.1353645-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b59a50a5a9..fc3a0ab7fc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1035,6 +1035,14 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
+ *
+ * Byte pattern: xxab -> yyba
+ *
+ * With TCG_BSWAP_IZ, x == zero, else undefined.
+ * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
+ */
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1046,22 +1054,25 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
 
-        tcg_gen_shri_i32(t0, arg, 8);
+                                            /* arg = ..ab (IZ) xxab (!IZ) */
+        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = ...a (IZ) .xxa (!IZ) */
         if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);
+            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a */
         }
 
         if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);
-            tcg_gen_sari_i32(t1, t1, 16);
+            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... */
+            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. */
         } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);
-            tcg_gen_shli_i32(t1, t1, 8);
+            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b */
+            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. */
         } else {
-            tcg_gen_shli_i32(t1, arg, 8);
+            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. */
         }
 
-        tcg_gen_or_i32(ret, t0, t1);
+        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ) */
+                                            /*     = ssba (OS) */
+                                            /*     = xaba (no flag) */
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     }
-- 
2.34.1


