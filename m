Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072974C750
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAq-0008UG-6f; Sun, 09 Jul 2023 14:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAg-0008Qz-Nc
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAe-0000zv-OC
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31438512cafso4023494f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927407; x=1691519407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=LYvQNQqKa9oQdsqMxVZReVZejXOyQ+yzk60giB6vYUv9EUi8RFB9XrlUqYedBzHdNu
 NcB5LW4XA0oDPVvHVZ3JlaMuH9OiPmu4M2G6ray37th2tZr+CSklbkhabeWCS8LIgBj0
 /DIQTC8OsE+fuL1bHXa6l3F8eBU3XfIXAUZEbbNjBgbT6PL4CgtUzU9sOdP890svlWNu
 G3OQmbBzT2JkQG2x37ctLSgFR6gmb1bOR1QlqzeEFZy0jv5Co7La5Zbp9qpe+iBdCYxr
 Vjl7h4SmUOrDOD2Hm06RT9fmiRfxHikn978KZ6sfFymrsHFpC/2CSVKTzNC4gdqp0M6e
 z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927407; x=1691519407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=NOzV4yF015QMTYj3DnvZxvnwXwDMLfV1Z3XhqqlrVUSXk1UDRPYrWcQ1QcQJsuJ7+f
 14Ca1Btkxom5pn4gpMKG2LAJd98MP3UnbVb67+6jvfot+Gh7qWEDQ0y/xnUfQ5emUnGN
 +kUUH6H9SpNDtFYXlqJmaqcefOFOjxM5vALq1WjFKyBUVdLRGOOGBZABRmS+3/rrhIwT
 B8V1ImwZLYlXGRYrhZAh9BH8bnjoQP3Mhz+LCIiLcf9uk6kWFSoBDfJqZWgLY4mXVkbE
 GbHJosYv8WhWGzU2zGwvCV9pqdJQfZJa6yyYwrm92ecJ0/xfJiRSHQBTW6vkKHYtJllf
 FPnQ==
X-Gm-Message-State: ABy/qLY5ma3NNqGjEs+mhKvt/4PNokuO4seuvDqr2qXPiQd0vk3VwF/l
 SzvrXixNaZ749bLJ595I4cDMd3+hZbq5SdZxDFD54Q==
X-Google-Smtp-Source: APBJJlEYwHUObCMMkCEv3IZcGTE0AoCWW2+pbisjrogxi7AuzNyPjc78g85fbJTMCBjGDrNvV6a8Uw==
X-Received: by 2002:a05:6000:4e4:b0:313:f61c:42ab with SMTP id
 cr4-20020a05600004e400b00313f61c42abmr9882143wrb.56.1688927407407; 
 Sun, 09 Jul 2023 11:30:07 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 18/37] target/ppc: Use aesdec_ISB_ISR_AK_IMC
Date: Sun,  9 Jul 2023 19:28:48 +0100
Message-Id: <20230709182934.309468-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

This implements the VNCIPHER instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1e477924b7..834da80fe3 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2947,22 +2947,11 @@ void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    /* This differs from what is written in ISA V2.07.  The RTL is */
-    /* incorrect and will be fixed in V2.07B.                      */
-    int i;
-    ppc_avr_t tmp;
+    AESState *ad = (AESState *)r;
+    AESState *st = (AESState *)a;
+    AESState *rk = (AESState *)b;
 
-    VECTOR_FOR_INORDER_I(i, u8) {
-        tmp.VsrB(i) = b->VsrB(i) ^ AES_isbox[a->VsrB(AES_ishifts[i])];
-    }
-
-    VECTOR_FOR_INORDER_I(i, u32) {
-        r->VsrW(i) =
-            AES_imc[tmp.VsrB(4 * i + 0)][0] ^
-            AES_imc[tmp.VsrB(4 * i + 1)][1] ^
-            AES_imc[tmp.VsrB(4 * i + 2)][2] ^
-            AES_imc[tmp.VsrB(4 * i + 3)][3];
-    }
+    aesdec_ISB_ISR_AK_IMC(ad, st, rk, true);
 }
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


