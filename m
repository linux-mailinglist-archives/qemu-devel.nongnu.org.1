Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C50470C293
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:37:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17We-0007bF-6t; Mon, 22 May 2023 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wc-0007Z7-6b
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17Wa-0001Tm-H5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3078d1c8828so5996737f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769558; x=1687361558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbYgJ/CF6X8oXk1c18I3fiTWkENuu1esnlnJzdOgw0U=;
 b=sQTsuO1+IR3wG1880nFla6zQQ4pT1gMu2cJlzad94PzBKPVJQZ1U+TWNTTNFvSXnEk
 S5E+9kvIAUfjTOolpryQJJLDJaL4mkJ5AK3rL5Gd1X3q+j1KYU/ivJH5OScWV+fEDSvv
 /IWAEWg/EpFl/t/nb1SmEBVCbuqMW7cEKesoiLB1uF1B2iJczBnDt+bzz3tBXpu0WM9R
 Thwuq0eIgb36ABh/BtBlJYuMSM+pYVEsjStML30tSr7ngWXXZ5tHnQB+z3Lx10VhZUW7
 qhQylGRGA5IJT1WBRbw1Atx4k0whDA2qDQM7BrQiPDZfgDRkVNyylKwexiX121ORirQ2
 v1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769558; x=1687361558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbYgJ/CF6X8oXk1c18I3fiTWkENuu1esnlnJzdOgw0U=;
 b=MTXd2qiItqTS0RAUX8OxAPNCQ04yDqvtcL7BsUlQy+6G0W2WNhD9TwISwZhcXnlDbG
 ZidpUS+6Z/AmuH8udgdGt3QzEhbN6o/4R3W3c88XwftacositUZmRZa0N8FjVHbTMkP+
 FtkGbg9FPA6PrrO/9ohd69n5V8u9jB+KidZY8uDOroTP8mNCFuo3Fr63syNfk+Lq7zP5
 gs4tFeQSpPN3uvWALRqii6SaWTD4JvpiKO4itGLm7G54qBrQ1oe44yaRO/bHmBUpDwx3
 8x48TEGEQcqg3FlGw1p3/AFacYBDwabzh8px9nJMxELeZ2OfI5uVs3jJQWsElM9b5mjz
 MaZw==
X-Gm-Message-State: AC+VfDzEIkI85/82ONlsRa6awuJtExRCiHxTT883nnqw1gvM6FG5Qyjl
 yO+sxwTlJ/PPqOVcKzO8sLlpI47aATC/oOxW3ss=
X-Google-Smtp-Source: ACHHUZ5HXvOYmrb1/Rt7YTNlFxzOSDqkPd+oX8zm7imtF+5ZhV72MJMEdczweHN95gDKYUOPqDPzUA==
X-Received: by 2002:a5d:44cf:0:b0:309:54b6:33b0 with SMTP id
 z15-20020a5d44cf000000b0030954b633b0mr7758639wrr.44.1684769557960; 
 Mon, 22 May 2023 08:32:37 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a0560001b0f00b00307acec258esm8082350wrz.3.2023.05.22.08.32.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/12] hw/char/pl011: Check if transmitter is enabled
Date: Mon, 22 May 2023 17:31:41 +0200
Message-Id: <20230522153144.30610-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Do not transmit characters when UART or transmitter are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c55ef41fbf..30bedeac15 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -76,6 +76,10 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_FEN     (1 << 4)
 #define LCR_BRK     (1 << 0)
 
+/* Control Register, UARTCR */
+#define CR_TXE      (1 << 8)
+#define CR_UARTEN   (1 << 0)
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -151,7 +155,9 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
 
 static void pl011_write_tx(PL011State *s, const uint8_t *buf, int length)
 {
-    /* ??? Check if transmitter is enabled.  */
+    if (!(s->cr & (CR_UARTEN | CR_TXE))) {
+        return;
+    }
 
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
-- 
2.38.1


