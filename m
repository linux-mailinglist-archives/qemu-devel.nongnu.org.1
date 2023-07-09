Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1477874C495
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxk-0000fA-5r; Sun, 09 Jul 2023 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000T4-Dv
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:18 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxR-0000eG-K8
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so37582515e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911212; x=1691503212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cwUPdSqiTi+cpvjs0+320/XSt6FYwReeMeUR4tviQI=;
 b=LNk6Rza+MfQaL+5IWRKbAUw+W61RgR/z03p5ElAPllXpfQOuJCqj0Tj07Ir0HwW/2c
 cyEf7nMJXrM2MlYrgOxg5E+iNt32HpJ6eRpIEuoToU946zsbcn+poHimNe0F4zEp4fe2
 xPCPF++fEEAY+nl5AjQDU4mjEWyGv2HwCUa6ZmWSAEaArABAbEm+L4kLbN96utWb80mW
 WR236VIZ+8gLA8F1dTFO+gKHNSmXXeSzspHPpYuEbOXnb/zVjgkLNh6YEA0wUhic02l4
 DiCzUAf7DVm7OL+7TBFPEMgjnuzeYywpFRhys0OnM3akdRhKDJgnsIKjGZpvY54+uIv4
 gYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911212; x=1691503212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cwUPdSqiTi+cpvjs0+320/XSt6FYwReeMeUR4tviQI=;
 b=PvPZ/dAVhZ98pbOmHDzavzeZTDdFHN3TAMxjNtbGNQ2EaRtuiV6DK+GB/LyokqhSzq
 O5gYH/ntVLhG3wfHOl1XiShSThTiS214eCfsPtpfYtlI2qK+jimxJczreD1O2m2q5mK2
 I1PTVUiViK/boNhzNOH7WWDApRZrUacVz9ug83wQgmlzy+/YtguMH3KDtgz15/YpyLkU
 SHuhoN+fvnkQ9ZarfDHuXyXkmXqir77DEPYaG4fDKxxJGr+GSbficws1yMkBbWM8M5Jk
 ZC0qr2C6GoAl3JsxQ9VWw70f8D6FDtipuZpQsBEo/7uzo4XyRMvc8MrcTtkpBWSQx1d8
 W4ng==
X-Gm-Message-State: ABy/qLaSElO24xn3Xr+dFu/lQCfFM9Zijaenn7SufJDdn8DWAILE5O3U
 epu4WlxDS63dJSgtiWelAld1WW1RCdrcK12dpsFtPg==
X-Google-Smtp-Source: APBJJlE8PVKceu5zuzosoYnbSjb1+cMwnzBZbMArh2wAOzTauW1jDza30fd0Xsq72sCWS744Zw/svQ==
X-Received: by 2002:a1c:7c08:0:b0:3fb:b6f3:e528 with SMTP id
 x8-20020a1c7c08000000b003fbb6f3e528mr9007714wmc.25.1688911212327; 
 Sun, 09 Jul 2023 07:00:12 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/37] target/riscv: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 14:59:37 +0100
Message-Id: <20230709135945.250311-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

This implements the AES64ES instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 2ef30281b1..b072fed3e2 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 
 #define AES_XTIME(a) \
@@ -136,6 +137,8 @@ target_ulong HELPER(aes32dsi)(target_ulong rs1, target_ulong rs2,
     AES_INVMIXBYTE(COL, 1, 2, 3, 0) << 8 | \
     AES_INVMIXBYTE(COL, 0, 1, 2, 3) << 0)
 
+static const AESState aes_zero = { };
+
 static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
                                            bool enc, bool mix)
 {
@@ -200,7 +203,12 @@ target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, false);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


