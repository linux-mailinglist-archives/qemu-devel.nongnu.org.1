Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4374C49D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxj-0000cZ-04; Sun, 09 Jul 2023 10:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxY-0000Td-8r
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000em-4r
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso36337775e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911214; x=1691503214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehiRk+/4K4ZdSH5tBEmArhhxk2Xw8P4NzuIBcv7dVgQ=;
 b=drfjP0nSnJVGLCG7MaYpaMfCdaKDboTm3RCxwBSKBWUOtrmIIfyFJqx/D/YngHEiGg
 7Ex7P7mFFQS8WYEiiNbjBB37t70GoRB652M/3tCW6xYluqpOi0Sn075w/BughIXNOI4V
 tbFi5RFIzu/QlbmRdvjW2J47zJsWb8wnug9ob2mQFoHyvsPXT1V/czb6t1ilivajCVB6
 PVpf4TPM4TJCASkqV7oJmFGVVl2KYhyGTgktOb5n0IoP+rlB1rmZtoXkaceqVgAYSjBh
 6scq/QpCUy+ll3k9Q6gUECYQwqKdDe2rxZcp/lGlyXomqpwu4mhKWAhlgfdtHJDWEw+r
 Wnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911214; x=1691503214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehiRk+/4K4ZdSH5tBEmArhhxk2Xw8P4NzuIBcv7dVgQ=;
 b=NVbOiWfffUcg8V56z4kRO1pc3CzSYkZlY8oNGzhGJaKdaUeWB06FHFvgrweEs5FVEK
 ZPC5shRpvF4pw9GfLiwyhmnO7kNev0V/h9k3ruF1adHjEvAw/UegYYBnkXktOEbKbz5H
 0fpgzUtZw9V1GI/YjnBQmopgoap1u/Kk4gp7rk8/rj3bp47lPK26WBO/gNS0+i2pBkdc
 24UfFYFb76YkwgKlsMYZpY+ze7G6ihXji11SZvs+Dj8H+OyePuN0Iluz+JunPgqsVCNi
 5eS4y71RhrNeCiXQiS3emFFeO4PnQ6vRmHVlxa7YM9dSCJ0vEArBnc7Oc0FpS4gKsXy+
 Czfw==
X-Gm-Message-State: ABy/qLY1dwJpdxtrsuUbo3Lc5JA4gcRFCWP/aehlROEM4eQvA/dhdooq
 5q5Bcvvtq0bBd4h3ryZUpnHD0FAoJuBv6g/iCJfOOw==
X-Google-Smtp-Source: APBJJlEEcUesS7QBYE337sY17REbCuGKzycJTD5QoauFbvGnXac99pnKW70OmoVSz3JfwPCGZhkgqw==
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr8028326wmj.16.1688911214647; 
 Sun, 09 Jul 2023 07:00:14 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/37] target/riscv: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 14:59:40 +0100
Message-Id: <20230709135945.250311-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

This implements the AES64ESM instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 505166ce5a..c036fe8632 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -198,7 +198,12 @@ static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
 
 target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, true);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1


