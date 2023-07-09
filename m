Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C374C744
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAn-0008U8-Vr; Sun, 09 Jul 2023 14:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAh-0008R8-E6
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAf-00010A-HL
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso37892815e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927408; x=1691519408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=Y9Q5182sM/U0NJx95hFPNKJMI3sXAvJHxgPBZJb6BTeXzPpRxzqM374qjj++uaA/LQ
 BivzPcG7I7vCNWh4hbqb0YGCrzTz3KEg1jIyp0Bcmvr0iPG9r79LxnnYVUHNR9cCwq4/
 uhm8TJiGmKMVsH7S6FsH4nE3HXSjOPkwWUNl96FVs2LMgu7OJADEkO8+dPPxNQHz1ZFa
 k/lkipAWR+hWs5f0xxigrOUjYNozdiFjkH2jtxbPyq/bi6KLi6oCMoyUiEfg6sVQMOg+
 XSc6Jr3eNsbE14UR7/MJ19uidyrTVSl0MoUGvUOK4j8hLxaok9HOD7QPfl67ST0UtfPL
 p1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927408; x=1691519408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=lPhck7Iv6WRuFwy2+OJvKyWQupWMmH/9gL8TwuTZq+jhWSB7jWWegfyP9NBnw1is7l
 WdcI+jhfDqclPxmdlXHGY7nGDCLUPDUFYnk7LKRvr6qL1g4m73sdvk8zVXLBFgV8D3GM
 dodGnzV2OqKNpmq8vb/f5lZJqNM15AvvlpOOZ1+Xov86eQ1CryWKSgJ5KIb6pnMDajmw
 Y2Npd2U9j74D+JOcm6eY96b3a5WCEbfHbx8OghtQYHNSKgL55gkM8hHtJm+oH+aKWBrr
 Knruzi8EZ/KX8gbjBAGbVWTjd3xE0x+XswoFkPIJE0z+agTAXJSnK45T2qNl7tdIj1y4
 wWuQ==
X-Gm-Message-State: ABy/qLaRukmXlZef1Ub5WnNtJl52lW9dut19Na1qIwF6JCyE3KqXLiQS
 9b/i15RKIkz87ozPO9VuoqsCJF1e47OclDuKUuYr5w==
X-Google-Smtp-Source: APBJJlEW74Z/Tx5Va1RkHJc6TgsKTPDDHeL5JY399PSzzBXglHT5crUBiMrXFn/rJikvqtACHajWxQ==
X-Received: by 2002:a7b:cb0c:0:b0:3fa:97ad:2ba5 with SMTP id
 u12-20020a7bcb0c000000b003fa97ad2ba5mr8232132wmj.31.1688927408279; 
 Sun, 09 Jul 2023 11:30:08 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/37] target/i386: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 19:28:49 +0100
Message-Id: <20230709182934.309468-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

This implements the AESENCLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index fb63af7afa..63fdecbe03 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -19,6 +19,7 @@
  */
 
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 
 #if SHIFT == 0
 #define Reg MMXReg
@@ -2202,12 +2203,12 @@ void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0; i < 8 << SHIFT; i++) {
-        d->B(i) = rk.B(i) ^ (AES_sbox[st.B(AES_shifts[i & 15] + (i & ~15))]);
+        aesenc_SB_SR_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


