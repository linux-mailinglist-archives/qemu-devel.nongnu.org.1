Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C25785B40
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpI1-00070G-Kk; Wed, 23 Aug 2023 10:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHR-0006ov-Fd
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:21 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHP-0007YA-Ub
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:21 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so752840266b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802578; x=1693407378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4LGg5YkxcJlmoWgJXIWbZP7qpa7parjz3qUn2eNwA1g=;
 b=KDsDjuVf24ibjlFT9+YoE48duOi4nwym7G1+dOaClzlsIOFQsnY/l4eU9PtofSyNCj
 xCejvyM6tCsElfHOkCXuNQQO4lgQ1TF1VgNjFTFlKr1KjD6zHG4RSQaOi4+39xAvsoyW
 y8Zbd/sc+1SHDsjhXG02YCq/ZOb0Fq8LGCR19Hng0wHCDFIOvlqW0Tig1lOiSh1sA/ry
 FthfS/2pDaZbsT9cTroaixG8IE98onIOY/Y8BvSjPK6fTcnTCW08biYM3mW0350SmbVM
 xiVz1/wULrcZ5l+CnkLWRK5GzmgK/8Q61nmILa/2JQx8Jd0q1VwJfRgVzc/U9NBdO9wn
 fXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802578; x=1693407378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4LGg5YkxcJlmoWgJXIWbZP7qpa7parjz3qUn2eNwA1g=;
 b=QQDoppKmwfWECxAFaPicFwfQkuz++X07ZS5c/ViiF4ajaRvWkJZSG27fjTIxyUg3TY
 jaUpvKJl8jO0mxI1rvYIyqlZ7zgS+tR8NkFn1Lx3aminA2VIg52G6B17ktkR3rN/EW9P
 7vmWjvyrVZywfwMgzniOVAkR3jMd5N/Qgpze8oKb3/1IjDuJnUP5Pu+n2Ugk/z0xhgym
 fAB+izuC3uNKbg/oUXzTR0Rc3tkhepGA6XIwTfAfWoVbuvUkLdBvNLLQjSD9v3ySZ1Bk
 TI+z1fX4hLczKgx9Oc2FcZIW4+2cndUY5qsUfc/daz9WKnyG4qD6fwbZplydLgKI7L8M
 KP5A==
X-Gm-Message-State: AOJu0YzVTj+3LK43qeRFNqdHZFldpP89aNetV4pk3cY9MXv8AVcs7OeY
 fup7O80k0TzmC0n3ZncqoB9Jud+OjM0WrdceM/xFHw==
X-Google-Smtp-Source: AGHT+IGsaTz5GYoF+3foQm2A8I2p1X8OlMS18DW6Tr0QI+OICjVi88cEuMYKCsdLA4ntkzf5GItc3A==
X-Received: by 2002:a17:906:cca:b0:99c:441:ffa with SMTP id
 l10-20020a1709060cca00b0099c04410ffamr9436271ejh.29.1692802578422; 
 Wed, 23 Aug 2023 07:56:18 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 e22-20020a170906249600b0099cc1ffd8f5sm9849863ejb.53.2023.08.23.07.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] tcg/tcg-op: Document hswap_i32/64() byte pattern
Date: Wed, 23 Aug 2023 16:55:40 +0200
Message-ID: <20230823145542.79633-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Document hswap_i32() and hswap_i64(), added in commit
46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 45290cccad..94134981a9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1099,6 +1099,11 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * hswap_i32: Swap 16-bit halfwords within a 32-bit value.
+ *
+ * Byte pattern:  hswap_i32(abcd) -> cdab
+ */
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     /* Swapping 2 16-bit elements is a rotate. */
@@ -1896,19 +1901,26 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * hswap_i64: Swap 16-bit halfwords within a 64-bit value.
+ *
+ * See hswap64() in include/qemu/bitops.h
+ *
+ * Byte pattern:  hswap_i64(abcdefgh) -> ghefcdab
+ */
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     uint64_t m = 0x0000ffff0000ffffull;
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
     TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-    /* See include/qemu/bitops.h, hswap64. */
-    tcg_gen_rotli_i64(t1, arg, 32);
-    tcg_gen_andi_i64(t0, t1, m);
-    tcg_gen_shli_i64(t0, t0, 16);
-    tcg_gen_shri_i64(t1, t1, 16);
-    tcg_gen_andi_i64(t1, t1, m);
-    tcg_gen_or_i64(ret, t0, t1);
+                                        /* arg = abcdefgh */
+    tcg_gen_rotli_i64(t1, arg, 32);     /*  t1 = efghabcd */
+    tcg_gen_andi_i64(t0, t1, m);        /*  t0 = ..gh..cd */
+    tcg_gen_shli_i64(t0, t0, 16);       /*  t0 = gh..cd.. */
+    tcg_gen_shri_i64(t1, t1, 16);       /*  t1 = ..efghab */
+    tcg_gen_andi_i64(t1, t1, m);        /*  t1 = ..ef..ab */
+    tcg_gen_or_i64(ret, t0, t1);        /* ret = ghefcdab */
 
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
-- 
2.41.0


