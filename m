Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A939B74C746
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEC-0004b7-9S; Sun, 09 Jul 2023 14:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0003Wo-D7
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDq-0004El-9j
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso42002125e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927605; x=1691519605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNJt+xQSaKcqRS2slBC4RsFLFu+ocScsUgiRpjPIdes=;
 b=FxZvPlWTr/jm9Mpm7/6AppNvIqAR9ZwESYc68AEZ4IzHMTdTkKlrkRKx9Bhwg+qUqt
 d1cUP4dJTd9+164djJcx3bJSNge8d+E/5HBrhYcw+uYbZKjXeGQh49a0kPJtatqfuTIt
 avnHEL+PNR1dGPvxjUCBvLGphfGqZe/hn0Mi9xrAR6u/ID2//p1wpUdwBxNkYr5UmZoB
 8QJcG3OadYA0jaG7z+iobNsW84KEYHm8wDlVS6a/f25EBsWlUMeG+C2R0m4b5LxRLYM6
 suqyRop0yIiHPb8WHwC1OV1HIW4fMX7UTl/Lg7eF8qQwuGB7Z8P/ovNuEBlA950BcDNJ
 mixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927605; x=1691519605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNJt+xQSaKcqRS2slBC4RsFLFu+ocScsUgiRpjPIdes=;
 b=CN8vrMQsJFt86XrpX9LR2hDiNocdAa0c4mF7Yp37W/id8QsSDnvDWbhOoQXH0/CKI4
 jfqzzemwfOFlJfedrkwxlLqaceQsY80JbiozRMkxZtNGNibMti6WFYJC5dSlpZeh6Ynm
 iR+KzLpxqxbCcKZX3wjtJkEGJcaQwEJFan/Cg6anaqbJpfgOTOMaM+UBU256594uv+iI
 hVQnSJ2PSmFYTlmiNMKZqN8P110nwocuCNP68LV20Vpo2H+wajJweRr54XWDIcQBE5E2
 pQa27udHLC8e2yCOfjxuHf4LelXGIOVX6oHaM8OwxMO/b0t39tsMpzxu915vIFaG7mRv
 9mHg==
X-Gm-Message-State: ABy/qLYHeDQHwR2De9mMIv3UGAmE4AUlGGMqtLTEWYaHo0J+biuD0kc8
 14eXfQLI3r0e1C7NsQdjP1m3gJh38UzTMlvhkhuCKA==
X-Google-Smtp-Source: APBJJlFn5T/Gs61ECeanKzfzukL+spPIdFAjdEyC8CqaBwbgRYq0sHgCMyKcCQdHYCK8wBdyFQHDNw==
X-Received: by 2002:a05:600c:294a:b0:3fc:1a9:7900 with SMTP id
 n10-20020a05600c294a00b003fc01a97900mr3217935wmd.16.1688927604868; 
 Sun, 09 Jul 2023 11:33:24 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/37] target/arm: Use aesdec_IMC
Date: Sun,  9 Jul 2023 19:29:08 +0100
Message-Id: <20230709182934.309468-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

This implements the AESIMC instruction.  We have converted everything
to crypto/aes-round.h; crypto/aes.h is no longer needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 1952aaac58..fdd70abbfd 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -14,7 +14,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "crypto/aes.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
@@ -102,23 +101,6 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
-static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, const uint32_t *mc)
-{
-    union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
-    int i;
-
-    for (i = 0; i < 16; i += 4) {
-        CR_ST_WORD(st, i >> 2) =
-            mc[CR_ST_BYTE(st, i)] ^
-            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
-            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
-            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);
-    }
-
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
-}
-
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -147,7 +129,20 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_imc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesdec_IMC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesdec_IMC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


