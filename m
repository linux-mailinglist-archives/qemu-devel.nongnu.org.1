Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313D74C757
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZED-0004wI-ED; Sun, 09 Jul 2023 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDy-0003Ze-F9
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0004Ge-0G
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:34 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so37230395e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927611; x=1691519611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehiRk+/4K4ZdSH5tBEmArhhxk2Xw8P4NzuIBcv7dVgQ=;
 b=ts7b6gID2uM1UB8wm54G4iRs2Wgna6SgDMVYW/LMvOZzFo1eAWQ5nZRPDBolohZQQv
 01vAYnIiWKteCL7xvKWw/mwK2SXwzhh3rrDXHBEj3O3yMC3yqYmh9So5m9TR2hmz/RlA
 kKbRu7dCiCCgJcqgwHlygvlGQGoaQ1sRppYC8GI14238uLEcBDH03gmHFVfqI3HA7jOB
 Vq9zcMJj9rASvfsFXM118QBPlghqvZyHKP0Iz7X+/j9TbEL9Umzi0iydErQQdu6nGuxw
 /3ERoCQPAcEkWYJ93jVES0aiPFwNXgpJQYkuLondspvwA5Gd06u4D9QxeKF/Qqa5/rb/
 ML4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927611; x=1691519611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehiRk+/4K4ZdSH5tBEmArhhxk2Xw8P4NzuIBcv7dVgQ=;
 b=j1iTINeAL0pqJ1ytJpVZm3RfxMEfqRDRuJCjUnKP/SlognoR1nNEabMHXH2pb6yNi+
 Wtly6+VZXsSVCW2BSnSWM6AtmJIKg+ECRBZ4nRFGl+pDw4oYEf+585ZY0YDTb+MiYyeT
 US5j9yd04rG1UsELnP6MQqk7uFgBUXtoLdA1c7fTjR6IqInLK1uO0q4pYQbh25gByguB
 G3ilxJVY4eU6X3jzH+gNkakkbh66GQwTWfsiH0hs+8ejcUBOzLa33fK7zDT3IoB6KOKL
 XQpgCyhiv3xmX+IcRfINt8mjRZrELsTOgB6Puyvc/ISMueb4J4fICd8fFEYqgPMGf2h+
 fV+w==
X-Gm-Message-State: ABy/qLZ3vqHxEK5ZFW4xeq3pNhtykWhptWL9RoKOjYp+K2Bwv3ph1MKt
 mAAdC8ukBu8qNkZf9DtMPO57KLWZ6jC9X+ts1LO4Pw==
X-Google-Smtp-Source: APBJJlGmxWPXlYITkzWQ7lr7qsZx1Q9znY2lfOWADGxt+f/6fqLXbQON3a7A3mUrJOl0b2oGE4MB0Q==
X-Received: by 2002:a05:600c:294c:b0:3fb:ffef:d058 with SMTP id
 n12-20020a05600c294c00b003fbffefd058mr5897516wmd.0.1688927611071; 
 Sun, 09 Jul 2023 11:33:31 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/37] target/riscv: Use aesenc_SB_SR_MC_AK
Date: Sun,  9 Jul 2023 19:29:16 +0100
Message-Id: <20230709182934.309468-65-richard.henderson@linaro.org>
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


