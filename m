Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7374C4A3
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxh-0000Y8-VD; Sun, 09 Jul 2023 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxL-0000Oh-Tw
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxJ-0000QT-9G
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso36456895e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911203; x=1691503203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=wJ9onINFxc3yk4A3u4B9mDcXrR6nMFw42mHpwRPCl1W+UwzExPrgB9ow9XcxVzaZ9b
 FYS9eL8R8X5rUulOm6cl08eO4Dx5XlVNc9EekRe8hYyKgIc+EiSyxwBDFzah2HwA5C5k
 /eGy3G9dgL7bhYm060fTFsvppAp6/xFGOWBawdEGzh7Nyz1VEF8Y5RwFcnPstZcvzPP5
 u83Vg8g9jg7KSnia92imQZpy1mgvLUDYSKPr1ebhHXA9DtGXUbtWSNTk5QECJfTJUGPA
 j6vBjEdxN/C8Ch8MF+GnXJ8XD0X94Nv25CO1vcEICydWO/EInJeYn34thj7WhRkD3wWy
 ITUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911203; x=1691503203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQsBpcgKVgYp7fXYDQVN06TvKGcdOIek7QQgIG6AozQ=;
 b=SWHFkbKdjo0PYXELNnxi2Tg+rK9sWFgjozvpY8idxVuBFOLRfG+4hAdu2kNLAHScwj
 4ngmSOT7QOuSv8krvqlZz15C8oT5E8iROLalu+ZKoZxQBzddNSzmqNMl/vzcfh46icD2
 XwA+4B9Zi0naXNM+X2NoxQaYm+JVtoFrE/5eOURpU3zQmaZU2M/xDjvYged3PzS4ng3T
 Y3msVgyAKU3InS4ZWcYeOAuJphQvcwcjln3mEDjEGg1/3zcixMsGgTacjBw52hIJ8afR
 PQpjSpgcYnZUdH2PlC5YAdBzxm+9GB4Cu6khXDbkKjrXLDP1a55RArRooCSAzSXyY8LJ
 uRuA==
X-Gm-Message-State: ABy/qLZD2AVNDjMzmGGtKMNPs81kYISNNCbGc2A/b2w1wJMNS+hqUNy8
 K2Ouk7CQKinVyQrj88BBzuEvUdJqSUGDkYKad5FzLg==
X-Google-Smtp-Source: APBJJlF+JeLH33Htm6ypzOY+fdf62GP8wBImQzG+C4wFLhAEr0OIZb1/nAvJk6roR2kPmPu6Vr6hGg==
X-Received: by 2002:a5d:614b:0:b0:314:7487:96a3 with SMTP id
 y11-20020a5d614b000000b00314748796a3mr6472113wrt.52.1688911202840; 
 Sun, 09 Jul 2023 07:00:02 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 18/37] target/ppc: Use aesdec_ISB_ISR_AK_IMC
Date: Sun,  9 Jul 2023 14:59:26 +0100
Message-Id: <20230709135945.250311-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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


