Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 020AF7E7262
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AiR-0005yE-C8; Thu, 09 Nov 2023 14:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ai2-0005RW-B4
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:29:02 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahy-0005IO-JJ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:57 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso216021466b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558133; x=1700162933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEZCH3t9203jXT8Ca8hiOxWdvxGRGRt32KSzy33l+nU=;
 b=bmUkq/QiqQsVxBIPg6upwJ3HanE2T6z3MuOJU7EAhURTKDz+A8kASIlZvFgIf/2orm
 99JsS8K6Jt14ckG8Po+nRQSlCqGQtNXk7srx/mVspcrJwbHEOMj0Hzryb7Q3R4WuWRXR
 md5OGIAGP1z8vcl5j6ZtS9ntO7EmbeClB9+z1CEEHhQBiW1kwtYoSgafe9ujlwCSi9Rm
 Dq+SgUuICnsQbeo/s+JX7W8ZjtlahgqwzXfIDVX8j1r7cwiQT/VkN8F65huo06+SqBBK
 F08nR4RGH24P7bYnbgUYsrytZkqxKMI7ISquOsIJEXpfsneQiOVOAdTl9lEpnVlJ6Yab
 dgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558133; x=1700162933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEZCH3t9203jXT8Ca8hiOxWdvxGRGRt32KSzy33l+nU=;
 b=SZ/CLP+53GUX4awM4Gnm6SUGkvKNqKGMn3czyzCEvINF6t6Szhf9R5DCaPSgcfaI7F
 2t59B3PblHTXz4+p49DUj0rpQ+hzXBx3VpRyZEf+zruHXJolnEU4V9BKdh6m9NRPPlm8
 0KCHgISkaW4dwjj+WS7VzCuPEmIlK//7/puRLFj+ot+Lsbi9tlVGvPi31/9WiRTynLYf
 WIxijmhGq1RkfZoeEmKU7OsQAqTe5SYpbi5xe5np9Nny+yIRflbzGnrr9rH9b+CCWBPf
 R/8Pjo3Y1h04UPhMQiBodpMZeOUdCxaDNl8GneWf0EIHzkGU5YFwlgq4nOr0nsx+1Zre
 qiGw==
X-Gm-Message-State: AOJu0YwgPdPHcfdwJ9kIF2qGs8kqprtgnWpbTK/vee6FXMlPj2BGTvBU
 AoSzrzbU3szKYmwUp4xhyD5oiw/cWB7uWu5KFbeRmg==
X-Google-Smtp-Source: AGHT+IE4Zyn8KXdktvGc4uyvoiOmwlNKr8f7had+FoLm5D9aXdTdHbdq3c31AhUYwDgoJSY7N+NY1w==
X-Received: by 2002:a17:907:a0b:b0:9bf:9c58:e91e with SMTP id
 bb11-20020a1709070a0b00b009bf9c58e91emr4392989ejc.56.1699558132912; 
 Thu, 09 Nov 2023 11:28:52 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b009b2c9476726sm2904753ejw.21.2023.11.09.11.28.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-8.2 v4 06/10] hw/char/pl011: Warn when using disabled
 transmitter
Date: Thu,  9 Nov 2023 20:28:10 +0100
Message-ID: <20231109192814.95977-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

We shouldn't transmit characters when the full UART or its
transmitter is disabled. However we don't want to break the
possibly incomplete "my first bare metal assembly program"s,
so we choose to simply display a warning when this occurs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 30309337b1..9c43cb47bf 100644
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
@@ -151,7 +155,12 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
 
 static void pl011_write_txdata(PL011State *s, uint8_t data)
 {
-    /* ??? Check if transmitter is enabled.  */
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled UART\n");
+    }
+    if (!(s->cr & CR_TXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 data written to disabled TX UART\n");
+    }
 
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
-- 
2.41.0


