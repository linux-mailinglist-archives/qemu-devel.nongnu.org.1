Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE674C48C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:03:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxl-0000fq-0S; Sun, 09 Jul 2023 10:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxJ-0000OP-Jm
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxG-0000P1-EY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso3407527f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911200; x=1691503200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=jYWTXnBLWwJ0lR7S2FvQFTwmNIuu5GIuh1oJJ2DQG6gH204ihMdS6g6JhizzJskyzg
 qW/h+yLTYlKkLXwblYslLgruWo/lypnzceze7iQlQCAnjgiR4bSftkbf8UQ8q1NA9V5T
 qqMotE0R65juOoaHdFbI9L3M07bSYwqXOxFnzWIaCx4JYo6ZdPkPh0qvuShbFtDYFXvD
 11hKgoC0txgs9gpiabfscOlKiQA1N++hDqlXTPnCqK6V3VhJSTa9fG2S89X4DnfodHOj
 qVo+0wWAxMcwb8qV32rliObUPp5E2C3xDxbWfgcvff4HNXAnQ5MhKo9CHiPHqmVIzBFu
 wLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911200; x=1691503200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=KVW+EyliWaKZrfwft6zsUqzgv7kGGd3gWgNf55PDfRA5ziXTYtuCG3QApr96XU+H9s
 Mf2OcryhmTnD6xKQRSPt8Iyuz3pYenN7m9SFALqi3EglB5vkxsaNOhMheERy7qb0j5SZ
 FgVqn+3TZLw/z3tR/trlMP2Kgvc/M5ZNwdrkS34sBE2NoPONiEICrYP2V1fZ2a7c3qN4
 2XRzxUuqXJdFlEicxgtPAoiGzZlalSPTmXBTh0tO0k8g8LqZtbtgwlXppB7kgtKRmwa0
 h/y+b3m1gU1RfnXFeJHsrijkXirP9xniTrg2y3NgdMP18P2BT6ySTq3qmtZebQjxxWNP
 ehoA==
X-Gm-Message-State: ABy/qLZvdf1gC3siltxbxdvG2QvSmHMH8A4Dr+sxsC1QW/SzAEAlDXkj
 +lbg6IjZlsmltATa5f/g3WvgbMYMmdoOcCl9XZzqtw==
X-Google-Smtp-Source: APBJJlGSsBooMFqzdNGLlfSZhCQULc04sLTWWv5HY4tieq5+1o6LWiFrSNdrjGhup4DziROKiHzu3Q==
X-Received: by 2002:adf:f60c:0:b0:311:1aee:4e1d with SMTP id
 t12-20020adff60c000000b003111aee4e1dmr8345676wrp.33.1688911199815; 
 Sun, 09 Jul 2023 06:59:59 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 15/37] target/ppc: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 14:59:23 +0100
Message-Id: <20230709135945.250311-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

This implements the VCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d97a7f1f28..34257e9d76 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -2947,13 +2948,7 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])]);
-    }
-    *r = result;
+    aesenc_SB_SR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


