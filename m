Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578574C494
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxu-0000uV-L2; Sun, 09 Jul 2023 10:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxY-0000Tc-8c
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxU-0000eN-7s
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so40003315e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911213; x=1691503213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPxXjVkEBfCIbnZstLW82ROIVL7eKNAPasvd0ZIUexI=;
 b=JmkM+XjlAgwR2ckM2fjYcVS5Xm7mQtpDjXqIKJqIG1ZreB5jTzQ00bRYn2kYXBPUws
 F4QCoag28Rxu73QO1n84ZMqF0ojz1vAAkuIpbi5ZXBQGB82CQzj75Kg5mDnsPuAVFQij
 xeAug9VHv9zFBbCGKqrJJlJOcs6eqNjt3qHEfeNBkX4pWFHpVvyTP520/yp4zElcYKUL
 N0TBpwzAmx4E5gFVXvn2rVYruCBkMCrq0Rgh5rSy3Y4/60m/FmnzuatM4IPFRf1tzOC4
 XnCvxFp+r9OXvyK4X/rT9nXVX/eXKRIzVtaviRt+r7LbOWopHwqT6mbk5BfKH5aY1K/Z
 K3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911213; x=1691503213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPxXjVkEBfCIbnZstLW82ROIVL7eKNAPasvd0ZIUexI=;
 b=OCg6kQKaSs/E272InEoEGHkaqKIcMOixpfhNAPqiXD9X5MFBxgsBh9LKYU9sbOt7gQ
 Y45AmeSc3lkIxjiYlj45xh7tRhX3POpLcT0eSPxb8V7HEtRBecUQvXp5t57OnkIYBSpG
 b9l88HyB3MBwYCVSkiXiMh8hIv1K+rtiP62sy4ZC2WIpa6cdw6MUKvfAuLBi+aAanF6o
 dENlXNdyMD5tZfD4vgbAno9dKxCbAwcOqlUBI0X94PjS+cl6tZMgWYdHjTOJX3+yKJZJ
 uZHbe2ewnfWWEO4WQPhW0LyaF46+YypVY68KEpfX73At+VP7LXmK/orl59SMMwjbvuQK
 C3fQ==
X-Gm-Message-State: ABy/qLa9kCS2yte5U0h1dGdypKazGIA4dNbBDP7kt3BqQm4wD3M/C5gp
 lJNRGcPm4BAm1Tbv268ujWGZZVnlNtntGjyBbM9jng==
X-Google-Smtp-Source: APBJJlEj6VVrpwJ6Gxa9t6+oeWj8S4s8/G43aQUuAbvv2itdqSPXlXoc/1xXQBMDTuSCHIIP7baBTw==
X-Received: by 2002:a1c:7916:0:b0:3f8:fac0:ad40 with SMTP id
 l22-20020a1c7916000000b003f8fac0ad40mr8016684wme.29.1688911213140; 
 Sun, 09 Jul 2023 07:00:13 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/37] target/riscv: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 14:59:38 +0100
Message-Id: <20230709135945.250311-31-richard.henderson@linaro.org>
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

This implements the AES64DS instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index b072fed3e2..e61f7fe1e5 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -213,7 +213,12 @@ target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, false, false);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64dsm)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


