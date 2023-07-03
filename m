Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B337459E0
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:14:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGSE-0003jm-KI; Mon, 03 Jul 2023 06:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRh-00038I-1b
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRQ-0005yQ-3U
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso1682809f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378754; x=1690970754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pOjdTU6VTsEkj/YPCvRrXcIKg2xairdxfu8316FBss=;
 b=rI/m2BJO7QZr34SY2mUpl0eW4eEQE5b4/CL+OIifeNDRskpqLmaZ7rcMwPvdL2oJEH
 1dDEI31s4astHoq7h0lej5E0Uc4Kjd76+nctHh5zio0v+yBKJCzUApvnT/t4HzNVCmqj
 p/fSyHjdPRiMEVx/ZeJ8byu9Kv5IfZvkfQwRH5bwaH0PPbUnzd79uaAqgpAVz1FJFr+3
 ngDIhN53WLXMZOTbITVUdYMtAC4NltnNPVmfjYnF2oD4CtN9H5nz6JF0BBE4c2jJaATU
 dGOFI+d4chfoYLduou/hj+tpota/dryegtsKf7pm4j8JgWaNDCmt1ewWgpOYx+hFLlNd
 kDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378754; x=1690970754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pOjdTU6VTsEkj/YPCvRrXcIKg2xairdxfu8316FBss=;
 b=WVuQ13wv2KdiB2a1EbiTJt+WVV67WFLh34Rqv4QnAnSMRU3t1L9cBjDdl8jNzOo9h+
 Jkqy9ZH5e9k4T5fxUbOKJZiSWdPEOqnRdtpCF2LCfQcNOImMP/hJaTArCSwnv27ts0kR
 /E3y8yRXLin3FH88BujaYACehZRj6Gc4T+qXqvYLJD4vrqF0IeTDxP44oFOS2A7c/xu2
 kkfFPa0FKZnS10xkxySVqjnJ7Csg6pR8uAwDpz7rN0nvUlsXVPbjnpi62k4If7EsSNMJ
 BLCrg8Z2/P7ViRYc1YnohBrqMjEYKIZKZW7cIK5ayRw2OawpIcSaj4hP8vDdaEPHctxe
 w32A==
X-Gm-Message-State: ABy/qLZFRZvnrYztyd5vWoSj3S9TLr1jFL93NQO+ZXt7gSeH8dONOG2S
 xvlLBLSlOBbApN4qXF1gzxDsA3Zdjt3odDXBklURnQ==
X-Google-Smtp-Source: APBJJlFRzqSzn52DDoIzuDGd+yB5+kRaHXhEBr4LPPUUe7vqoorQkMM376kLQMSwcF+0G2xUhAoPVQ==
X-Received: by 2002:adf:f20d:0:b0:313:f429:f6e9 with SMTP id
 p13-20020adff20d000000b00313f429f6e9mr7672124wro.60.1688378754667; 
 Mon, 03 Jul 2023 03:05:54 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 31/37] target/riscv: Use aesdec_IMC
Date: Mon,  3 Jul 2023 12:05:14 +0200
Message-Id: <20230703100520.68224-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

This implements the AES64IM instruction.

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


