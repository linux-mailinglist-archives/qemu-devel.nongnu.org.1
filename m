Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A474C49A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxh-0000V1-80; Sun, 09 Jul 2023 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxL-0000OX-7n
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxJ-0000Z4-M0
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-314313f127fso3667960f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911204; x=1691503204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=y3DlOLOwyui2TXeKftd9s256xDlgAe+guhi/Uz8RVcbDnz0SWCs55rPJU6NONqsywl
 PFUgajtCzbrxK80O7m7rWP+cOajeUlOqZrRcuASvk7/ATf72YX8xjAaHIWk+KEYx50oH
 iU9dd/wz98jtxSknKe1/SeKk10okkMYkPKuoKstu5+p3yH/bmb01Va7fac+VXk5duOgN
 wFPRRDxtIK5skPCAlDUaIq0wd4yzgp3G4FfjPlAhncCT/O+gI1HNKeArOgti/HFUyjf3
 2Rq4aw8o7CJb+yrrKqI5hDTFuWKtMWnwtYWI+kut1Xa33s7BWg1UYjUhaIGPVAZg7cL4
 i48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911204; x=1691503204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCbxuyj6w2doHmBool/Ak6eLq+V5O+przb+5Ur/gE60=;
 b=cfx4r7e0LIEbhZuKsNnp6tavPTudlZZEKaHbLegagXgczWIHHSlvTGMrwR0DfR4qTa
 CXwr4Jg00Wcq+6ume4nifIg9I7kR8pUMfB8Jrya5J3/Z4doTrjRp75glN1U+A7lUykRT
 HDuktoGgzR8X8ila3GpApXPNfUlxMrPHyTxc8UWstBb0ti434eplRZN4wQ3pl2ZbdbX6
 GTIbirT4voFhwuqiIR+MIU1Eg9QzXl7A0oIJLwMvERouwaZ6vGffJCFsw1ZjQueydOCH
 RGJfOw6+94GfO8LzA0eHeCr7SjesxB+L47CahumjnRUwQ2KZpQDFKSQaYZrp6+639ipt
 wLVQ==
X-Gm-Message-State: ABy/qLaZPJJoDAhbGiHYMys2mvxrwF0Ex762o9mZ81+VWaAEnFnTfkuV
 H7B+4d+1iK1KO2Ty5XxVCfFT91gKzFQAOUYhcdA+ww==
X-Google-Smtp-Source: APBJJlFc4kzCt1aKXR8HF5qFdjIudUwg81UUe1WHdZb9FvtIPgDYXmf/puo0lBSRoaiUfDZLymRMaQ==
X-Received: by 2002:adf:ee4a:0:b0:30f:af19:81f3 with SMTP id
 w10-20020adfee4a000000b0030faf1981f3mr8588557wro.41.1688911203577; 
 Sun, 09 Jul 2023 07:00:03 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/37] target/i386: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 14:59:27 +0100
Message-Id: <20230709135945.250311-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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


