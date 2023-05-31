Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F107174C6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7Q-0003l6-Su; Wed, 31 May 2023 00:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7B-0003CR-6A
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D76-0006uw-10
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:12 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3982f09df74so3160426b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506024; x=1688098024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yAI6VIgzMZpgJduQw+zbfBfSRhC2iaxfwnzVojWouK0=;
 b=iA770+uYBYGS5/VOgIlxx7pKs6DjWHLUisT0lli5w8g6d+RS8rZrnRwHnDRfbAjL+l
 iFkYQh8GGrH7MIaqFfflOWIrM4JSNb4/aOS6wF/Plnv04GW7+ZG2KITfl8wBmIc/JqDW
 oSp5LcYrDciuB+NDzuIm9k+3Gq9Ml1fcgITXbtY4oKRDPbuH6ei0fgmYW3cbFHRnjWKz
 04FhCgGPOrRLa5l0vkzHj7Ud7cRTuGEZrrrcplXt6Mz/JuDTzhAKDNywanT0ruLJTdxo
 c08IsQ6cnyfwnEMdv85owtr/1pLaB4l2fT8TZdHD6ERoDaqyxV0HxZPzNDPPH1ddU+dn
 g09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506024; x=1688098024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAI6VIgzMZpgJduQw+zbfBfSRhC2iaxfwnzVojWouK0=;
 b=WLzmpHwZfNSGyvSaT1/yAJ9Vn+U2+UNAmch2ImF0F/amG+/OAxph3kMGYmsEYX+Yip
 MQATzDZgWS/QLFKO7yjqawrzAo/Nk071/8Ty9WdPIhZD+oPaCzofbXn7VCThigXo8xSp
 Izk/huXlnKSQMvq5iIuwUiqhqrzMrw28ZihayG+rsjoIPk3iNEmtZ4v5nMDq1QSPYE+O
 BdyYpbAa5INGVr2YbAvEV5IuDJ456wV3/+tTh0da+ddq8gO0yPyFLTyGkjyYBw06D61z
 C90/Pgv+EHjNdPgHWhcBwNAiC04NHT6B+raugU9KinhD1phZk8y9DMUqp9IwZgSe+ADu
 Q8bw==
X-Gm-Message-State: AC+VfDxfzdfKHyrvEfBLMbWQpENFylmyQ/VLymEQqEkJyUPZDdmgw93T
 ypqFTWoWZ4PjxGMP+DazwzZTsjaHOS7nisG4+XE=
X-Google-Smtp-Source: ACHHUZ79BZSCL0Vqh0XUsFBrzimV5c1j8s5I8EY1674LxSvTQ26L3OF8Ucm5JfOrGj75SZ2Rw8SRlw==
X-Received: by 2002:a05:6358:70e:b0:125:506d:36db with SMTP id
 e14-20020a056358070e00b00125506d36dbmr933263rwj.14.1685506023860; 
 Tue, 30 May 2023 21:07:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 41/48] accel/tcg: Tidy includes for translator.[ch]
Date: Tue, 30 May 2023 21:03:23 -0700
Message-Id: <20230531040330.8950-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reduce the header to only bswap.h and cpu_ldst.h.
Move exec/translate-all.h to translator.c.
Reduce tcg.h and tcg-op.h to tcg-op-common.h.
Remove otherwise unused headers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 6 +-----
 accel/tcg/translator.c    | 8 +++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 228002a623..224ae14aa7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -18,12 +18,8 @@
  * member in your target-specific DisasContext.
  */
 
-
 #include "qemu/bswap.h"
-#include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
-#include "exec/translate-all.h"
-#include "tcg/tcg.h"
+#include "exec/cpu_ldst.h"	/* for abi_ptr */
 
 /**
  * gen_intermediate_code
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 60a613c99d..fda4e7f637 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,15 +8,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
-#include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/translate-all.h"
 #include "exec/plugin-gen.h"
-#include "exec/replay-core.h"
-
+#include "tcg/tcg-op-common.h"
 
 static void gen_io_start(void)
 {
-- 
2.34.1


