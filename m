Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7974C742
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEP-0005sT-R1; Sun, 09 Jul 2023 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0003X5-9X
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDu-0004GC-NR
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31297125334so2803160f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927609; x=1691519609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muoNLx2OrRgCzPDttQEHoOl2grqT5w0p62Pb+0kehUU=;
 b=fzNRL4odUbIDIIEK+BUCxux4T2ttI2eV353QmptJ3gUfZptgYhBzz49ZS/GtjLuJ5I
 Kex/lWg9AK2IozO5VUjY9FVzHFExrYttWkO2rAFKxHxUdY39F/HarekCKChs1/xKsUqe
 9pccjpi6tYkNh3V0lqE655AX8KWlY9iJmeK5XoNThOTeapzemGpzq27ZPniES//MQAUK
 FxymSDXfTT0arbmn/16v3xpIpY2uyy6G07vl9uhtnuKEDe1ZA8pH174iqirjxaJYeVoX
 GonCEZaKfGD/qHHOM8dBj8twuIMcOn/GuuFkEAR5vfodt6HI/fz/jg9fCp0J/CuTjt6E
 vwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927609; x=1691519609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muoNLx2OrRgCzPDttQEHoOl2grqT5w0p62Pb+0kehUU=;
 b=PJbhzUrFXfLH0xOwltH0dxuN3icDQmUZKfABCoIhRI5DqWalcU4h2lvo1MjInJX0VO
 gnQJ0oy/i3Ztzia0cj8f4CWS/DJVqK/TbkgLTCYDvzZxRyVgjNW4yJSSispmVXadoglL
 hEP/uJ0XtW0lHerkd2KOl9zCim9nHJlhSHhCS7F0C8feYsKs8ljA7T4hLRBe05Rb50os
 cGPL0uOChRYFkqXOW2T+suQtEmwBGgyJKDiDT2Qbq2RFTMH0/66E9KmQZlTF5t8uBYDp
 EKUFh8eMogcQsPnuSFsVF4OPSAXvk1/34iYJHv8BiVR05HZUnVgUsJoogzNWG3dtbciv
 mBjg==
X-Gm-Message-State: ABy/qLY85YOSs1wiQIJdGc+O/271dDP45oZJq4K5TDFa+Qfi/rDNXPYR
 32Lqi+VaA/g0rrhm/mn7ALJriyZJ6k9c7b/Wiz35Zw==
X-Google-Smtp-Source: APBJJlGz1xvEvR6KYnuFPj+9tAEIIiey+Jtx2cg/Z33mFJFVFRlPtdVyEwZ4UDTJs7ih9OrMNyqT0w==
X-Received: by 2002:adf:db46:0:b0:314:1096:6437 with SMTP id
 f6-20020adfdb46000000b0031410966437mr6848139wrj.19.1688927609553; 
 Sun, 09 Jul 2023 11:33:29 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/37] target/riscv: Use aesdec_IMC
Date: Sun,  9 Jul 2023 19:29:14 +0100
Message-Id: <20230709182934.309468-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

This implements the AES64IM instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index e61f7fe1e5..505166ce5a 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -272,17 +272,12 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, target_ulong rnum)
 
 target_ulong HELPER(aes64im)(target_ulong rs1)
 {
-    uint64_t RS1 = rs1;
-    uint32_t col_0 = RS1 & 0xFFFFFFFF;
-    uint32_t col_1 = RS1 >> 32;
-    target_ulong result;
+    AESState t;
 
-    col_0 = AES_INVMIXCOLUMN(col_0);
-    col_1 = AES_INVMIXCOLUMN(col_1);
-
-    result = ((uint64_t)col_1 << 32) | col_0;
-
-    return result;
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = 0;
+    aesdec_IMC(&t, &t, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(sm4ed)(target_ulong rs1, target_ulong rs2,
-- 
2.34.1


