Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D4D7459AC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGSD-0003gw-Iz; Mon, 03 Jul 2023 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRg-00037c-4b
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRP-0005xv-47
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3141140f51bso5747773f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378753; x=1690970753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRqjQC8v/J/3z0IiE+GLS9BAOlnmnUcZezvum6TPI3k=;
 b=CyHtq4SuWKPtI0enq0XMRv9MmHffCsVArxB+WqMcFwOePyiyBKr7+ngSf1TchOnl7X
 LAqaN0+c+/DRVoHb/6FWoHCUqhtI3erVZ1zldHnSwOtPJogJOPn5n/SvLV02nvYRQAup
 eqk3dr/aeKoIAZ24Fc17rnpqo4Fm7LdzbbPTVaVobK4ChNXqmfe8mv5z2PSZdQPGGnrs
 mnnOIodGxXKI0z4TkWpUBARUaAN+osWtHDhiVZblyUDzRyWWzZBzizm1q6leYKPtXV/4
 RuUv+bV0wvN93xyfNrL7D3vRlQg6UjO4dAQViMJA/6+vDLith9OlnljFy3HrvZOJ5d6c
 38Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378753; x=1690970753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRqjQC8v/J/3z0IiE+GLS9BAOlnmnUcZezvum6TPI3k=;
 b=EgNgO9ozIF0XC3/mPl38BsLpG9PhjDcUGtCmJvPUmk7S54ShdsNIluXdmQLlIiHq6K
 +axBYEUJMST8h2m+LzkVq0wokWHeUB1QlZ45rHJIW0SY2NeHCfBZH9SVvRc55F3bnpzE
 vyTGnWp4J4INhbC0b9Qn4tDayF/KnjoSPVS8WKPcPcWCPE9E8ltqMzwN6zT9sJSpQwEX
 8lIPluylbGPqleu6RdCjYUWgnm5lGGZQblAIiVUjRdg9ubQKY/ndTl8XUsXAx3pAdTWx
 nsiB6MNLZK7Iw7zca2PleKal1hsgXfy6Di3/YBdjs+Co7itUa+lgQxKM4dHt1DwKqIgY
 vkLQ==
X-Gm-Message-State: ABy/qLYzZrmx5zjrl4OIVHveQrLvYbjOPR8SpmMzc5QNYScN6RRhd68i
 uU/OEvP5Fu2LbX8kaV41wgz9qko6Kue4q1rLB7+Fsg==
X-Google-Smtp-Source: APBJJlE7vUUpB9o9nv2Mz2UGo5rcPzTxUgRtjdi6gFx85Q3YHWJyCBQfkHMqCLvPTk/GPLphZlrbng==
X-Received: by 2002:a5d:54c1:0:b0:314:3b78:da77 with SMTP id
 x1-20020a5d54c1000000b003143b78da77mr430121wrv.29.1688378753715; 
 Mon, 03 Jul 2023 03:05:53 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 30/37] target/riscv: Use aesdec_ISB_ISR_AK
Date: Mon,  3 Jul 2023 12:05:13 +0200
Message-Id: <20230703100520.68224-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


