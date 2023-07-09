Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C774C713
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAi-0008R3-MJ; Sun, 09 Jul 2023 14:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAb-0008Nf-09
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAY-0000OI-VE
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso39577995e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927401; x=1691519401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=kq5nM/8V1fbL/HGT4WA84cEPDr8adVJ1cSAFLUUXLQQzgRdNaJ7Z4FcNj8a5es0RR/
 CutRueH5nIkzWor5xybOo0ZWSvpyQGzn61i6SN+/agdHhwX8adravJEZzMpuKBUZC1Mf
 5mAdolmpG0xlqVkmgBh+tCdk0KiFahH5JaPdKlMyqo8fkuOQmaWaP2z3ELZmPCaBMB4u
 9/l4AtnAV7dXyPL7aR59Bky6SZg78f5po88UzJxlC3tcfS6MYdlNSDvit6vS07qf5HbD
 jL8/QenUikd//P6YLJyxFr2lCmK/W1R8carYQ8vXE8aTCPk2qPo6bXhYFEHselJh1YN+
 4tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927401; x=1691519401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=L4Vbcw0Xywb9wsvXO0dTN1vbLl3twBxsIIQIcMoO3ssVQNnlcovwPie/zv8i7FllVJ
 nbjhlWFwjkZ2vSDGGC8AopfD4KPFpHvg2lyRS2Y6xh77CNE/eN4GgkeZRPFKj+RQEbyS
 DLhmOKlKbW4wsMHSvaC1cIJiaZsm8dRcV+8eq6Xa4comlMAzYNLb/QpRMuWtpJO+tWaH
 6IDc8+v1rW/zLFEkyh8/EB01cDzE3278ElnQGA7fkPeXBSRyzScUX5mJCKLuKUkIS0QL
 eLnZj50nVxI4WJcvk+kgz54wqniKgtCyNJ/eU0YzK6Mg3V6i1DbS/8u8dDPHAg5d43v0
 kHmQ==
X-Gm-Message-State: ABy/qLbYY00P8Gpwa6hcIZvV0AuIrIO5R2lkYoLoSdo9KYBZd+d7Bbcs
 +jhtJJqifdgxUVgCaW52RvYtVkNZMHE4ivZpL+ismA==
X-Google-Smtp-Source: APBJJlHzJWVWku2CMUf4w0g1xDaxTiMRepIBFAwjPZdXPC1nPVozY/30v00ArUPvZlsvow3NcOlaZA==
X-Received: by 2002:a7b:ce8a:0:b0:3fb:be07:5343 with SMTP id
 q10-20020a7bce8a000000b003fbbe075343mr8867367wmj.27.1688927401676; 
 Sun, 09 Jul 2023 11:30:01 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 15/37] target/ppc: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 19:28:42 +0100
Message-Id: <20230709182934.309468-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
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

This implements the VCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d97a7f1f28..34257e9d76 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -2947,13 +2948,7 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])]);
-    }
-    *r = result;
+    aesenc_SB_SR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


