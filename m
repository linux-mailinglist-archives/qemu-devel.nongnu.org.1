Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146083316F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:24:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyCs-0000Yc-Ep; Fri, 19 Jan 2024 18:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCq-0000Y9-GL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQyCo-0008IF-TZ
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:23:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso8033535e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 15:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705706601; x=1706311401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpX7HX7EolNAWiMUOh3LJMt2Imoxl2aeklNIaM18ZtY=;
 b=O8APWSL5CflkVdr2dnMcIRdIbkdLvCxLfgppnoedaI8pbIaJJxfsphzRcJESRdvVkc
 pE+dbriCzP5HNnkNUEpYsYJblf2IsD/fLPrAIrJ8AuRUYXypgNfgOz5N3PjizQQj29p0
 x0RdveAxNy91Mr6nvMIJOvszLog4pD30nU43bS5DF2Veh8d1NhJQbQBPT7hYoER+7OOZ
 ur44Bl9KkxsmPw4vkepM1gksy0YGz8MOvOjFuWFdxRjihchP8LWXDwQ+8z3ZPXBkK0jp
 H2MJ+bgNMYka+fxBhUfDmVY361xVMk+4yyLSV0xl4lQsIF20Dhytk8hUz3sEp3ObNqbn
 FG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705706601; x=1706311401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KpX7HX7EolNAWiMUOh3LJMt2Imoxl2aeklNIaM18ZtY=;
 b=oz3BojOmjYRY/qiAOy6YLMUuA09RrbzImqsA7cLV7e0NU9Ie732uKxlctz6LqACu2Z
 f+2b9YDr99CnZr3FXiQQ7yt7UroCorVTlUcRqftWFIe2D24Bu9Rdpw7EjPr2vX8RxoJK
 sMMAUv9iBZF5EUMovm9XgnTF0oZAfPpFHySM0AkzQ23flUco1UnkOdt4wvB4O+/Kvw8y
 JloDX6oKNWXSyM1RQNRBSJVMJ+dLMPkRDDM6ycjAf8h591Hq1UC5gR5LQF3pxp3AjDQD
 PE5vhmU5IYewXvx+TyNRm+z1unPVmJewMv8pLdfUmxGbBydF2QUGxI7SRQ8650PqWdSk
 4Rbg==
X-Gm-Message-State: AOJu0Yygo3A016T81zzFrXCj01EHoDM/u0ixRg/TXGiPac1JeeYxj4Sa
 XRUydGUeLZ5mrOYbmKyDuHhC2xgKbXWcyOqGTBiNvXYm8qM+HYApyENM8JEvfV3aajK39hHq3+g
 x
X-Google-Smtp-Source: AGHT+IE0P8t9fZsJx4Z/CoLZtXqbzceSc5Lehw9pU0qc0PD/FjTOCsAKL6aKNseA/bKJPkJxzapTAQ==
X-Received: by 2002:a05:600c:a008:b0:40e:6064:b70c with SMTP id
 jg8-20020a05600ca00800b0040e6064b70cmr289315wmb.82.1705706601448; 
 Fri, 19 Jan 2024 15:23:21 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 p37-20020a05600c1da500b0040ea22b51cbsm973280wms.34.2024.01.19.15.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 15:23:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/38 5/6] target/s390x: Reorder CC_OP_STATIC switch case
 in disas_jcc (5/5)
Date: Sat, 20 Jan 2024 00:23:01 +0100
Message-ID: <20240119232302.50393-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-16-richard.henderson@linaro.org>
References: <20240110224408.10444-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 9224df867b..93c64db33e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -914,6 +914,10 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_LTU;
             c->u.s32.b = tcg_constant_i32(2);
             break;
+        case 0x2 | 0x1: /* cc > 1 */
+            cond = TCG_COND_GTU;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
         case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
             cond = TCG_COND_NE;
             c->u.s32.a = tcg_temp_new_i32();
@@ -930,10 +934,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
             cond = TCG_COND_NE;
             c->u.s32.b = tcg_constant_i32(0);
             break;
-        case 0x2 | 0x1: /* cc > 1 */
-            cond = TCG_COND_GTU;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
         case 0x8: /* cc == 0 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(0);
-- 
2.41.0


