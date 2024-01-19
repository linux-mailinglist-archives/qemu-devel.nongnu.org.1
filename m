Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EE8330E1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:49:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxeN-000606-4R; Fri, 19 Jan 2024 17:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQxeJ-0005y4-HX
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:47:44 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQxeG-0007es-JL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:47:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3367a304091so1167756f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705704459; x=1706309259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlF5tx7xWYSxTMVLwpyAF8EB6pJi/TUpAYiS0HlHtDM=;
 b=DOSYHa64G0b28VBRLJfF5T+VycvLItk5q+drKduqvZZ0EAUP8CqkWv4qsuIHmM7Sax
 N4ldTBS/wwjB7bRwi2WWE//WIFp579AUm2YydPbB6C61kXXiZZg4ZIbSE7oo8044uer8
 nQhdbwXF4UbHQn6Wn6Fb/pdEJllX/ERgFSaX9/nkjxbu3lNW/IsbRbpRKbP2kig9LR9c
 5BIL79/qmqnn67snkc2inia3mB6U+9aNuIcZAmKg+35Xom374Ly/8LQJ7DTIMlYJ+FC3
 2JYcutTecEdTJHBQRvKWncW9YE/0ITqBxq7dnZYR9+tU/oAnBBndYVBpqw6eO3E62+GE
 Br8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705704459; x=1706309259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlF5tx7xWYSxTMVLwpyAF8EB6pJi/TUpAYiS0HlHtDM=;
 b=i+fEG2cCqaa1e9AetwRObk3D7T5qwp9Rb1kp20CrezNRRW166gHDo5NLkJG3054rD1
 Y8ip/XxrPGZG7zhjlF8JRBzouN8YJqdY7TEhX9BZtU7zrKAmkjP8qA+HoabYVSRxuqgY
 OFOaXUNiS9ZLykwDDRxY2FPY2clRD9AvrsV5qXzzd4Ni2Xa6GWU4MDe2z1yEsFTSNKK0
 syWtdiJSJWBoJS3aA3Ti5sOFdjLWT+yRLT53Wz9C+vRHwbfA4jquAd1k56JgTrHos+fO
 lb09LArrVzc8dsdwHNS04+2OgDH9i1fo8UG0QkwLKgYwsamAw3AiNmtzNGge93bqLvzg
 NBpg==
X-Gm-Message-State: AOJu0YyAeM8ZfNnS4QN8icssCYHZ+9ytdxi3R0qYfGqwEH0hBUL8sEqw
 zxz8WxA+KXVsTd5Ov3xl2m7Turu43zw4ONQN+gC6z2ZmkZgylGhho/+HPH3zC4iTkFKst7VDL8p
 O
X-Google-Smtp-Source: AGHT+IFH/BmdGoxuCHeD5TvubLJls0k4xvUqb9e1QPTFjVMOZRbZuGJwuTD3n0onH8yrumqJ1SWSuQ==
X-Received: by 2002:a05:600c:2259:b0:40e:81f8:2f8f with SMTP id
 a25-20020a05600c225900b0040e81f82f8fmr171262wmm.110.1705704458757; 
 Fri, 19 Jan 2024 14:47:38 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 m11-20020a05600c4f4b00b0040e86a4c0b3sm11853619wmq.11.2024.01.19.14.47.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 14:47:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/38 1/2] tcg/aarch64: Massage tcg_out_brcond()
Date: Fri, 19 Jan 2024 23:47:36 +0100
Message-ID: <20240119224737.48943-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110224408.10444-19-richard.henderson@linaro.org>
References: <20240110224408.10444-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to ease next commit review, modify tcg_out_brcond()
to switch over TCGCond. No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 70df250c04..a19158f4ea 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1416,12 +1416,20 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
     intptr_t offset;
-    bool need_cmp;
+    bool need_cmp = true;
 
-    if (b_const && b == 0 && (c == TCG_COND_EQ || c == TCG_COND_NE)) {
-        need_cmp = false;
-    } else {
-        need_cmp = true;
+    switch (c) {
+    case TCG_COND_EQ:
+    case TCG_COND_NE:
+        if (b_const && b == 0) {
+            need_cmp = false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (need_cmp) {
         tcg_out_cmp(s, ext, c, a, b, b_const);
     }
 
@@ -1435,10 +1443,17 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
 
     if (need_cmp) {
         tcg_out_insn(s, 3202, B_C, c, offset);
-    } else if (c == TCG_COND_EQ) {
-        tcg_out_insn(s, 3201, CBZ, ext, a, offset);
     } else {
-        tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+        switch (c) {
+        case TCG_COND_EQ:
+            tcg_out_insn(s, 3201, CBZ, ext, a, offset);
+            break;
+        case TCG_COND_NE:
+            tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.41.0


