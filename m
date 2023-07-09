Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BBB74C76B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEM-0005pb-WC; Sun, 09 Jul 2023 14:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0003X3-8E
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0004Fs-4A
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso4037004f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927608; x=1691519608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPxXjVkEBfCIbnZstLW82ROIVL7eKNAPasvd0ZIUexI=;
 b=hATF6DCngcDbRCg1HJDI3/RJmRhxoooUNfrT5iPA9qkR4tWVMGJr/mW767FYTphoSc
 hiNx8ZCP4ivqCwXb4KBnrVpQ/SWlCqwuaToi1yKpAFyyRY6Lj7xU2EoYdl2ZGeZwlUCf
 2HOy0FeVtYvoyScMKLSOWCv0d+fXnyFWKg64PJBgkOtpo9jfRmz5ID9h/x1lJ+2Q7bs8
 zvsI0fZpF1Wr+Rqu+j5N1byH/H36jpHV59DxqLXPQp8YWk2o1Kw3Bqo6Nfbgpz19soXT
 KUmncHNrwteaMC1HuUznhh8c3TZ3WsPmIG8wIW5oQ5vMVpKYhgmjykMtWOvE9KpMr0Zf
 N1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927608; x=1691519608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPxXjVkEBfCIbnZstLW82ROIVL7eKNAPasvd0ZIUexI=;
 b=RfcNWYacG4QCNrVnWpofXMZqFsAYwXJ1dS/Q/JT10M2fX6SE7RqSNZgojVNSbd7CQN
 MLq/nGd2bTG5vyBnA/lTRIdQC7Db34lNj0mqzA1xLDD2pB//3/YszFBdEau9znGi7jQj
 lenphEY/bQs1/vQIZpyyKr4wV/HwTTD9c8wTycqBvhIv7fUEEDhQiTmUaWOurxVYOU4Q
 /Och5a3z/l9ty3cvy51OLpXWU/ofSEq45Tv+bPthDFPWDsDwu4HeRqQwL7B8jd+/wwvc
 oav6iI3+9BiUr942hRs/R46K51wQ2kWJpjFRRVZavVkmlFD9iNSQltnnjq/ftzvBS2AT
 1AVw==
X-Gm-Message-State: ABy/qLaruzY+gAC09A3vAT8Wz/hlwIfl9G4hurtg8i/84SWOCZYGo7CJ
 g7H4COsV7NJ+P0MU9zK35hLYhOsAQRJm3W7C4DJlzQ==
X-Google-Smtp-Source: APBJJlER/5NIP5KyKfZ0iZRr34kA5MYVLQr6jL/vAu+PPKu/QCn42r9ooZzWAbOX5+QvbVFudUERXA==
X-Received: by 2002:a05:6000:4ec:b0:314:1483:d8ad with SMTP id
 cr12-20020a05600004ec00b003141483d8admr9000185wrb.44.1688927608083; 
 Sun, 09 Jul 2023 11:33:28 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/37] target/riscv: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 19:29:12 +0100
Message-Id: <20230709182934.309468-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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


