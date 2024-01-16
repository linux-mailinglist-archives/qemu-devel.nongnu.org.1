Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4FB82F2B5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:57:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmjT-00062s-NA; Tue, 16 Jan 2024 11:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmjR-00062X-Mq
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:56:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPmjQ-0008AH-8b
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:56:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e86c86a6fso3892375e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705424166; x=1706028966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g5+MoEdJcCdHmkaazghwpTww92NWQ0eEpf8jlJ56rWs=;
 b=TcJhCRCnLLFa3ABKuPxkWBLbYVql0nrLOrLbhLuvpLF8GF2nOL2XRlZvNoHEIoTW1y
 U+KGuY0auprbUrh/4entfIjTqcFXX7Hxv6WLgoh0R3HPr/qR8Z0MPMBNYLYxosbKdT7N
 uiq9a1GUZYm9VYSFUFv8vKGQEkhG+YW6/BKRkpzZcGY0lJyUxUulgkKdu0KFIkput2XY
 8Ato5s4rl5Gisi1rX9eMsy/DLneyU+fUSVtedz+kcA7GpQoupsG6d6HzpYAkdI2Qd0+K
 Rd/xploKWLH+C6WTBuk+DBIhXl7BXocm+ZYogQv7ss8mJa7yoI/6rg3yOJxJv2QzTGyT
 Ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705424166; x=1706028966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5+MoEdJcCdHmkaazghwpTww92NWQ0eEpf8jlJ56rWs=;
 b=toG4DWxt/HFqkVglATL0hQaDQYJTHVHxxxJ8qgRQZawjSO2iQS0eGLJqfpMOlObxW0
 E7bMtFqUomVb41dVG2mZlpfJMPP8fOVD1jF7uE5IPDWbp476iynCb+xapABEVKQUpQR4
 Xeh9+WJGeG8TtRvzY05c8+PgCGtLkCXS1E8LCjENlcVaGOsRbX9iZW7yhkyHqv9D7+jo
 q2j+iBD3wwi5dNFILY/9UHCBxXL0kxya3xFuRU3MYOwshcwml8K0g8ILoLHuCc2n+S5a
 xahVuDx93RBfakOAHM33xglkLSRur9DOjhiWA7yBWRm8G3REX2+WId/B/B34zbymEHzD
 WNEw==
X-Gm-Message-State: AOJu0YyceSgW7t6t9Yppe+2RW2IGTWFde7SIR0FQFJkcuZITmwYfxs98
 7BmreDTULtiiZfu0DAUnRHLMhMag4Ot3tg==
X-Google-Smtp-Source: AGHT+IF8pCupoelRpCG622kyiJoRLpZUnP+NESinF3SuvbjHQYcnCneyg5+I1SRkuykCrmyuWfercA==
X-Received: by 2002:a05:600c:2ed2:b0:40e:491e:e387 with SMTP id
 q18-20020a05600c2ed200b0040e491ee387mr2101176wmn.355.1705424166462; 
 Tue, 16 Jan 2024 08:56:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 bg23-20020a05600c3c9700b0040d91fa270fsm19968636wmb.36.2024.01.16.08.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 08:56:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] target/arm: Fix VNCR fault detection logic
Date: Tue, 16 Jan 2024 16:56:05 +0000
Message-Id: <20240116165605.2523055-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In arm_deliver_fault() we check for whether the fault is caused
by a data abort due to an access to a FEAT_NV2 sysreg in the
memory pointed to by the VNCR. Unfortunately part of the
condition checks the wrong argument to the function, meaning
that it would spuriously trigger, resulting in some instruction
aborts being taken to the wrong EL and reported incorrectly.

Use the right variable in the condition.

Fixes: 674e5345275d425 ("target/arm: Report VNCR_EL2 based faults correctly")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In less lax languages the compiler might have pointed out that
the type of the LHS and the RHS in the comparison didn't match :-)
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index dd5de74ffb7..5477c7fb7dc 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -184,7 +184,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * (and indeed syndrome does not have the EC field in it,
      * because we masked that out in disas_set_insn_syndrome())
      */
-    bool is_vncr = (mmu_idx != MMU_INST_FETCH) &&
+    bool is_vncr = (access_type != MMU_INST_FETCH) &&
         (env->exception.syndrome & ARM_EL_VNCR);
 
     if (is_vncr) {
-- 
2.34.1


