Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F474C70D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAk-0008TB-OI; Sun, 09 Jul 2023 14:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAc-0008Pj-NY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAb-0000er-5Y
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so43911515e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927403; x=1691519403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=wWoSBeyQtz2Kvn2ZT1cR7JzFjct6vWELQuyHQYdETo71nV7I9Q7Ujrdef8tMgx9kKw
 cqdTl5aSGNVgFw8rUL/MRMtUiioaZgviT8cB5wBWA5WCNDycHB7hSM7g3glqjSI0tXbn
 rHrzlA0J/rPqdx3zCDVP33rNZceJ3ncha40oE9zyP/e6+v7MjzkJ5o/WBZmOkaLVqS++
 JTeMpaRHZQexwxfqXVvLxu6VBccaQpV6roaJshN34HZ2TWyBIuZLsXy2p7UfB+kmabq5
 YSZ86iTYM7pnZRWn3SP7Ac3R8W/euuCUpHEHZJ9H0dDbm1kiKv+AAcuNpd1tW2MskH2Q
 qd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927403; x=1691519403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=b3dCBTTJJewT4IxOPqVpH+J8PeN9HMMGft9sriPJy/y8jFALBeybvIwkAP2Z9f4QTY
 LlaBUp3LPTr4whPzaAjSCNfqUUI95j4Lb3qMT/P+dh6FVFxyYGy2UkWH6DJzWSS30Thr
 RdCaIoV/WXJ0Yg0SukAucpkIBMD2RYm05Oi0TJBu+lIeQlPF9SXp6fWrzT/MPDaVJrbN
 7vQ2edhhtrMw3kSbSlrDjrTOy4I8YYDrx3X1ez1Jyn0SGHpMW0g60pAX2IsXlm3r0IF+
 HIjiL+SD74PnqST97/1f+MrhH0y/VIH5yuvl4DZoEoZF9ggd6ENvPaP9Is2VJ2eikIFq
 Uh2g==
X-Gm-Message-State: ABy/qLalTTkndn9sqPxj5CGyEjbF50r0n8FNjFus6p27cCoxbHZ6HK2I
 KsfB08z9bSTEGyZLcUTmBaEJkHCPQ+4jIDF2XMhRXA==
X-Google-Smtp-Source: APBJJlHju/Vwb3j7S9ofGzH3uT2/Z2VmSjPGKJ0BRUw0nDk9SAV/Mof1Agxv+zAl37eugU79AsV0Dg==
X-Received: by 2002:a7b:cc9a:0:b0:3fb:40ff:1cba with SMTP id
 p26-20020a7bcc9a000000b003fb40ff1cbamr10936308wma.6.1688927403790; 
 Sun, 09 Jul 2023 11:30:03 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 16/37] target/ppc: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 19:28:44 +0100
Message-Id: <20230709182934.309468-33-richard.henderson@linaro.org>
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

This implements the VNCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 34257e9d76..15f07fca2b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2973,13 +2973,7 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
-    }
-    *r = result;
+    aesdec_ISB_ISR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
-- 
2.34.1


