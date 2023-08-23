Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256E78617A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRd-0005KL-EM; Wed, 23 Aug 2023 16:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRY-00055e-8v
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRW-0006CR-G0
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:07 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68a1af910e0so3238923b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822425; x=1693427225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GM9qcgiCUzexTHGWX5t+ahLOGZIdFkTo6Y1+THQiB14=;
 b=fhjxzxnWlPTHUNn54KpsaVCc/2JvLM79nZ8K6ZpVMzklcPrjcFx4/Oi16r8WIiLo9O
 wOyNOQWXTD3ajs9cNqrIvtxHfcXpK+DTOEL+FAU1HnbtLCXjfMxkOaXIX79AzCQtgIS5
 pPA8tvUFxbWQbMBOeyFvijE2FyfnSbVDS1pzqvZjgVNxXVfkwD2CsrwQD4vmBJdscaIY
 qaZyHhgpymOsvcHipqawipP4EI6wb4jUlcf23SiNT2u1tazKJzd9pqmkqCsB6QbuGxnv
 yThp99c6RbCWKDojhZtP0cSKb/I5xT2Y9J6sP+tBdeG7VllGB/yJUObJHJaeeSfFqbhM
 Hpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822425; x=1693427225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GM9qcgiCUzexTHGWX5t+ahLOGZIdFkTo6Y1+THQiB14=;
 b=g9MZ3RDxGv/YJApLn2jjOgBEhDR5L4k7jf7tqA4Qa3jyAPgT4Iq5Bn27J78B9jChvK
 gnmQhNs+cRLwWBEaXW1AU+QPSrqcZc04bBeZCJA3pDTHpP4pNpIhM9mKU6VoKBfB+2Xa
 VmfjafzJG9zwHKzBf6/a5LXSU7KMQ6fckanzsqf+LAmUZ4ECm80xUmv+oFuyZl5QRx1q
 tYbVIGHRmntKY7uoreaNLZCb7WiehWU2XSvKecFBOl+oAeKOqKSME+ynk2whdGdjLt3X
 snkO9wU2KtcuQThFbf/dlX4E9y+y6UBMLhytgI8mbEXH/1oa4zvolXMeoottWSU9rwgX
 OcOw==
X-Gm-Message-State: AOJu0YyNvyNdWcaatu5OJ9KoENB6PWpCjAnxLzOFdgMKv4xAu/afa1nU
 Rxs2jTYO5zS5Fr2LQTtQ6l+VlwB5XhNwmf5Yk04=
X-Google-Smtp-Source: AGHT+IGmLKRzhHwraLigkBLFUl83bo8ntjCFZGJiz3STL3i06sbvtpsMb/7cgwJFHzlzn5rB7P3+LQ==
X-Received: by 2002:a05:6a00:896:b0:68a:582b:6b6d with SMTP id
 q22-20020a056a00089600b0068a582b6b6dmr9084609pfj.1.1692822424760; 
 Wed, 23 Aug 2023 13:27:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/48] tcg/tcg-op: Document bswap16_i64() byte pattern
Date: Wed, 23 Aug 2023 13:23:18 -0700
Message-Id: <20230823202326.1353645-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Message-Id: <20230823145542.79633-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fc3a0ab7fc..88c7c60ffe 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1767,6 +1767,14 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
+ *
+ * Byte pattern: xxxxxxxxab -> yyyyyyyyba
+ *
+ * With TCG_BSWAP_IZ, x == zero, else undefined.
+ * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
+ */
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1785,22 +1793,25 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-        tcg_gen_shri_i64(t0, arg, 8);
+                                            /* arg = ......ab or xxxxxxab */
+        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .......a or .xxxxxxa */
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
+            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxab. */
         }
 
-        tcg_gen_or_i64(ret, t0, t1);
+        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (OZ) */
+                                            /*       ssssssba (OS) */
+                                            /*       xxxxxaba (no flag) */
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
     }
-- 
2.34.1


