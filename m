Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B77F4FA1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 19:33:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s0g-0004Ed-Gq; Wed, 22 Nov 2023 13:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0N-0004BH-Ah
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s0J-0004aB-1J
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:31:18 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3316bd84749so9070f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700677872; x=1701282672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZrZRIxKP0fr1EzlYqN5VDWsI9Qt1x4ludh/rJlYbBI=;
 b=u7bcKp1l6iBeZ7fcRWf7yjRxw6pA0GNSsv0VuX/X0WtMzBbWWwzpdTI/L6BbbsYrdb
 EQE0GZUYnwQ17LE9RaP77MxkjgdKevzznbpWXNafASRBrQjqYM8rXyqvTBp0AG0EX6u7
 xU1T9aOJuXns0ya8zPrYA0JN1+h9hQU/jKgw8VGuul78rZSTQECTN3zMtb5W8KQheCnM
 SMuLNfHF5b5+1+GvoF7z6JG6O7L3JXtOxkqR/gTkj7i81b1CE6LfPsfxjBjJE/fmxOq/
 dQ1sfCtHhdooS+03vxqBwjuOM7oJtJH2mK6npBjwtfrFcXDdo8nq/6ykNvtZQoEBkgn4
 Gv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700677872; x=1701282672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZrZRIxKP0fr1EzlYqN5VDWsI9Qt1x4ludh/rJlYbBI=;
 b=mQl6OaphM99rKpvRSs+zcras+efqNkXI+CmNBf3nzmTig0kdRWibJNbLeeoBmoE4aj
 SIILLbHPJyc4PMmfDBj61HwsoH7eG0LEi49SRClKCBoLfNL4fnJr52F9dBNavncf8I/C
 ySWsydYz0wuScgHQKFPpdy5oKBl0pALjzCYVbH+ds8SwDEJucSf6F5p4j1v7Fv1iskkP
 vTUpPC1tpAej7fInJIBYZgNRvTnHU41O3OE0l7izhg1wCoenshGNZZYKdK7IlCoRAHAI
 QpK8Xp5Z6l3nGH0+ipQSFCF85MjTT7pWr+N7qsnN8Me3kv2rIudiqiLVmqEoxAw+J7ml
 VzNA==
X-Gm-Message-State: AOJu0YztKDurohuQ3echTfQg0D2hLRX68X1BPwOVgjwuYwHOyoFOeHTW
 0oyPBQ3nlOUOPdFaJpp07vagP7cA6YGKZHvvb1A=
X-Google-Smtp-Source: AGHT+IFNiUEJEkxLFSoN2nQISIoUWkaNr4GSVPoaUIOGvxDTrhIxSw4N0ObW/C2qtmDB5en+mHW2tQ==
X-Received: by 2002:a5d:6802:0:b0:332:d0f6:60fc with SMTP id
 w2-20020a5d6802000000b00332d0f660fcmr1992106wru.19.1700677872654; 
 Wed, 22 Nov 2023 10:31:12 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 d11-20020adfa40b000000b003232380ffd7sm36991wra.102.2023.11.22.10.31.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:31:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-9.0 04/11] target/arm: Move ARM_CPU_IRQ/FIQ definitions to
 'cpu-qom.h'
Date: Wed, 22 Nov 2023 19:30:40 +0100
Message-ID: <20231122183048.17150-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122183048.17150-1-philmd@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The ARM_CPU_IRQ/FIQ definitions are meant for the ARM CPU
QOM model. Move them to "cpu-qom.h" so any QOM code can
use them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Or do these definitions belong to cpu-defs.h?
---
 target/arm/cpu-qom.h | 6 ++++++
 target/arm/cpu.h     | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index be307037ff..38030450f7 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,6 +36,12 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
+/* Meanings of the ARMCPU object's four inbound GPIO lines */
+#define ARM_CPU_IRQ 0
+#define ARM_CPU_FIQ 1
+#define ARM_CPU_VIRQ 2
+#define ARM_CPU_VFIQ 3
+
 bool target_aarch64_available(void);
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d369275827..124d829742 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -107,12 +107,6 @@ enum {
 #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
 #endif
 
-/* Meanings of the ARMCPU object's four inbound GPIO lines */
-#define ARM_CPU_IRQ 0
-#define ARM_CPU_FIQ 1
-#define ARM_CPU_VIRQ 2
-#define ARM_CPU_VFIQ 3
-
 /* ARM-specific extra insn start words:
  * 1: Conditional execution bits
  * 2: Partial exception syndrome for data aborts
-- 
2.41.0


