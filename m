Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1D5783D0B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNpG-0000TN-IS; Tue, 22 Aug 2023 05:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpF-0000TF-Je
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:25 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYNpD-0001et-8H
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:37:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1112722f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697041; x=1693301841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJPKVO+xaCar/pzXI7lGpOGhrynSj4d9rgRqF1K4Bw0=;
 b=uI5rO9kSQBwwmw9FQAmlyduqYoGGLMMoSbQ5vcdSzDUBi/VJ2zae+9j0RRaBvGgVwo
 FSdY1oXCtoOk9fUkMrSU7CEjFGKC/2hemT6i9gcSwaPIje4WI/T9TABpYUuk5vbK+xYt
 xgdUTrzTbRIa/Tz3ac2K99YFlP2RjI91SHFfa+3PV/TUSFHRrpKjV1TQwy0jAz3/Hcig
 rnzD6Fq20pSm5DYOhz8rlmu82axsadA7mAbDVE64bXMb9Jh71lH/bmiboVNhJrPCwo6d
 2c6ejzwmsSJ1MKCJZfuGnfHVOIxCt7ii3ExWXNPDpd+5GAOHdIBXxhPhgIJ1rmaxKR0u
 U56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697041; x=1693301841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJPKVO+xaCar/pzXI7lGpOGhrynSj4d9rgRqF1K4Bw0=;
 b=W3tq74RNMAvK2wAHcN8zsFO4+j+aJWj23G/YNeg32S8i/r6DIDwL0UVlUb0mbXlf9X
 KsSi2tHC+pJEjX7mVAnOwDV68iGM6nNv1x3pBVvQTTWuJPyhCxyHgvLvYOH2XZRJaZ5q
 lTTUL5Bxn89syp+PuzO7VPD1lAY9ccXYNLbw9Nz5ySWgT8xCd73Gk8OcMHIzJmhWW1+O
 bgqx5tFp3B6iEPTk5HNZ4vtsFAzBlf612+NR7kAYmFdfARFXLkwsa2aWBaZ8azfTBt/p
 ntcSoaWFKKn0v25/rEX3S1gdLAUC200J84iTw6L60deqAwq09H9YpSBg8YXqUCPZ8qga
 oZkQ==
X-Gm-Message-State: AOJu0Yx/2tDpFU2tgq1QgaMjs8dDS53eLs5H/hRxSHIRbzPxgS8dS5Fg
 Mu+sSMIS6g6NGR/i+fkjcuURFmNDzfbc0g6vH9Et1A==
X-Google-Smtp-Source: AGHT+IGMvMtFAjj6eDI7jtvmy35uXCChJ2QnmtTI+jsbWgHcfbGDJ3U/aEC7sET6NEuan8sddl3CQQ==
X-Received: by 2002:adf:ec8a:0:b0:319:790e:3bc5 with SMTP id
 z10-20020adfec8a000000b00319790e3bc5mr6561589wrn.41.1692697041498; 
 Tue, 22 Aug 2023 02:37:21 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm15257485wrh.44.2023.08.22.02.37.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:37:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] tcg/tcg-op: Document bswap16() byte pattern
Date: Tue, 22 Aug 2023 11:37:06 +0200
Message-ID: <20230822093712.38922-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822093712.38922-1-philmd@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..f164ddc95e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1021,6 +1021,13 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
+ *
+ * Byte pattern:  bswap16_i32(xxab) -> ..ba             (TCG_BSWAP_OZ)
+ *                bswap16_i32(xxab) -> ssba             (TCG_BSWAP_OS)
+ *                bswap16_i32(xxab) -> xxba
+ */
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1032,22 +1039,23 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
 
-        tcg_gen_shri_i32(t0, arg, 8);
+                                            /* arg = xxab */
+        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = .xxa */
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
+        tcg_gen_or_i32(ret, t0, t1);        /* ret = ssba */
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     }
@@ -1721,6 +1729,13 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
+ *
+ * Byte pattern:  bswap16_i32(xxxxxxab) -> ......ba     (TCG_BSWAP_OZ)
+ *                bswap16_i32(xxxxxxab) -> ssssssba     (TCG_BSWAP_OS)
+ *                bswap16_i32(xxxxxxab) -> xxxxxxba
+ */
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1739,22 +1754,23 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-        tcg_gen_shri_i64(t0, arg, 8);
+                                            /* arg = xxxxxxab */
+        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .xxxxxxa */
         if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);
+            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a */
         }
 
         if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);
-            tcg_gen_sari_i64(t1, t1, 48);
+            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... */
+            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. */
         } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);
-            tcg_gen_shli_i64(t1, t1, 8);
+            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b */
+            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. */
         } else {
-            tcg_gen_shli_i64(t1, arg, 8);
+            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxxb. */
         }
 
-        tcg_gen_or_i64(ret, t0, t1);
+        tcg_gen_or_i64(ret, t0, t1);        /* ret = ssssssba */
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
     }
-- 
2.41.0


