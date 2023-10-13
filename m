Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DD7C878F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIu5-0000e4-T3; Fri, 13 Oct 2023 10:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItu-0000Uo-RH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItt-0004aD-EO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo3615077a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206343; x=1697811143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHrHAGB/EmMRyrEmXuczDQ4ZEQoq+gXqneExLSOiqGU=;
 b=l4LTrDoIAZJWVT43yCCbr8T2C1CHBzuzb2SiOp3AyEzBEaeJ42bWEaFTZaSb8eScH7
 rt5uFQj3PJwUlK9APa/hOw4slO5UIE+WtgIlDvgbqNWIkvuCmMMBr4qXsSfrgTCAs36c
 TT1CzS49gZ8CFN3xYAeqUqGQoPhRFX7IxB5uaQQ4UtdStENGf6R/kT4ORkfhcPqiSM0f
 uyWjIapXEbKFYmLUsLG3ZGQB+4j5V/OV/fURZPR3XjKtLFy15fVgJYJ2FK3FVLlWsyNS
 yPtB6EPOugQMTp0U+EX8r2aqfmsd992IJT2OujTV6+6UQHIGa08UOwxEUdaSVbO8q44O
 5/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206343; x=1697811143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHrHAGB/EmMRyrEmXuczDQ4ZEQoq+gXqneExLSOiqGU=;
 b=YZrPpss1fhffsKCUEpgjzVcEvNS2WGQe7g4sC6ntAXTISfzU+h6d6BSH/0nc8BYIDD
 qrJlBcpEcN0AUc0L/c7paPHjYZCJW3Tc8bj+JjBXNolvMPKBfOGP5BN1Fh6AAwIiFqrl
 wN/qqjMTzpcvBc2z3i/6RMujFIsqIzKoV82SCfMyK7Qx+O8fRhFABLYy6OdAtXW1t/Sr
 0ShRnxpa2MofHyFve/i+Y6av5du+UbBIqRpb3GvZLMQgZRC6qUM8o9SLZtPuSAJ4YcZf
 tXCRqbbcuhHLJtYxa9ViXfAkfZMr8IVeZYr/KVPiODsm1thUryUc4fg1Y/ZudZvL5cGQ
 UXWQ==
X-Gm-Message-State: AOJu0Yyl1iwO7x+idL1EYRMC2JgRAnbDfGIDYld/0PD51rmXE1YYRFPj
 K9HLvTO7k2b9KUmoesL3Mld9ZH3NN3n96fqHNPY=
X-Google-Smtp-Source: AGHT+IFM9RE0iz19vG5MmBZR94zz3/RNlveixfAroNdffsR3/AGtIZBICp0SmQHTvMBAFjYjCZX/Mw==
X-Received: by 2002:a50:ef0d:0:b0:522:2782:537 with SMTP id
 m13-20020a50ef0d000000b0052227820537mr23076679eds.15.1697206343741; 
 Fri, 13 Oct 2023 07:12:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a056402035300b00522828d438csm11613766edw.7.2023.10.13.07.12.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:12:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 7/10] hw/char/pl011: Check if receiver is enabled
Date: Fri, 13 Oct 2023 16:11:28 +0200
Message-ID: <20231013141131.1531-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not receive characters when UART or receiver are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
TODO: Understand Richard comment from v2:

  this doesn't fall under "my first assembly program" because
  it isn't part of "Hello, World"?
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 9c43cb47bf..ca931be139 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -77,6 +77,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_BRK     (1 << 0)
 
 /* Control Register, UARTCR */
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_UARTEN   (1 << 0)
 
@@ -359,9 +360,11 @@ static void pl011_write(void *opaque, hwaddr offset,
 static int pl011_can_receive(void *opaque)
 {
     PL011State *s = (PL011State *)opaque;
-    int r;
+    int r = 0;
 
-    r = s->read_count < pl011_get_fifo_depth(s);
+    if ((s->cr & CR_UARTEN) && (s->cr & CR_RXE)) {
+        r = s->read_count < pl011_get_fifo_depth(s);
+    }
     trace_pl011_can_receive(s->lcr, s->read_count, r);
     return r;
 }
-- 
2.41.0


