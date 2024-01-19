Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6334833171
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCd-0000Sx-Ch; Fri, 19 Jan 2024 18:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCZ-0000Sl-Ea
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCX-0008FH-Pv
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e9d288f45so13731585e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706584; x=1706311384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsZYTBqcxLmUzApr+Hi9hM5A3V+n1o4VvJJUuDY59oo=;
 b=AVG43C1VzC+CJpA+UzLg5L7YxHzFu7AR+1N6sz0diEPtrVGoeIknGmfkAUPGiOXV8O
 f94Y4HlCrXvCtXLK/dvcrwfZ/IDGnBxvkgQ0t09GaNsCfZHoigwckOm3kHobMqpTlZf2
 wzSGzCo/Eq9INPBGA1C3ci2N/G1pziW3UmzChawUYcx9iSU5FavELU4vds0hmImX+RYL
 O0nY1NaKTafU0K5xnqJCRPZqpnRMqDjPNOQuLuuzgsTPm7WfzOSeqDzGSAyYIKGkSFcr
 Objwv04rEG5g/KqSfOqOT83or3EyMU48hbA6VBXF1SgL7+emMpMofoYKUohM+7URxGmJ
 OVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706584; x=1706311384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsZYTBqcxLmUzApr+Hi9hM5A3V+n1o4VvJJUuDY59oo=;
 b=qUGQq7g8aduMT8IHFMD5VGR1xw3EbVmIdD3uhQT3xhWn22DEsxAXWnO1goqrZjL/c+
 Xu1HUS0bEdTgpD78JEIQlw6Lpra6Ec1gWaUnNtFXdbQQ+7vKZeaCgGQ3927zOUi832V4
 pdto52ftc1fUdggA9SUwtgZovZ5i04LatZFoZWVy+TZXbVSQSN0h46q69gpfncIhTFUK
 hQ4VzDeOiphRSMu51o1Gewnswy1n4o7TxChrYiydTfGwK6fI1uNbBCrO1riDNayt4/Ae
 BZNZJnre6LDVRcqGYhW3qnVZeT/d+bg35AOybCXD7/JNqsbfrfUsfA9cV7RVZRlcTto8
 FGww==
X-Gm-Message-State: AOJu0YxiEoxZGczYv2ucJd9vntTaJGG3fGt/x1lI7UZ8yCI4wr3cKjPG
 lTZ+CA/xyY075YLvVYcj2X6tsTZsLMrdLuFM+798kDLrFDGgskXHYoIDU3kX3qhPzBxnbkYjPCO
 1
X-Google-Smtp-Source: AGHT+IHnOyg7WaXMyVv5J0j8KfIgRRyTakftuc2kcF0YmtOyUp09ScQk3ol6S5mlylcKFJr9X5ZGyg==
X-Received: by 2002:a05:600c:3106:b0:40d:88a8:f89 with SMTP id
 g6-20020a05600c310600b0040d88a80f89mr182327wmo.149.1705706584014; 
 Fri, 19 Jan 2024 15:23:04 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c3b8f00b0040d5a5c523csm34589474wms.1.2024.01.19.15.23.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 1/6] target/s390x: Reorder CC_OP_STATIC switch case
 in disas_jcc (1/5)
Date: Sat, 20 Jan 2024 00:22:57 +0100
Message-ID: <20240119232302.50393-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Code movement to ease review, no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2897880d88..e84c6459f0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -916,6 +916,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(0);
             break;
+        case 0x2 | 0x1: /* cc > 1 */
+            cond = TCG_COND_GTU;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
         case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
             cond = TCG_COND_NE;
             c->u.s32.a = tcg_temp_new_i32();
@@ -926,10 +930,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(1);
             break;
-        case 0x2 | 0x1: /* cc > 1 */
-            cond = TCG_COND_GTU;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
         case 0x2: /* cc == 2 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(2);
-- 
2.41.0


