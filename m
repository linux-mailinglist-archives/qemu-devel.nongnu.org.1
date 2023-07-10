Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD174DCCD
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv3G-0001DQ-TN; Mon, 10 Jul 2023 13:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3D-0001CK-Cu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3B-0000VV-LR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so44815935e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011512; x=1691603512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXGp8ZoE5V8TDGBHBusqjmtpGceSTb5WuIHztmt2l2Q=;
 b=vKiyNgJX8iIZv4oA1W4xd1oYOrqQOsoO5tqSA9CABYVhIW6zZyNKUmqjhn1swM08lS
 aSd7VCYY/aq6YA2U/HS2n1il0FLcNdR/O2R5UkSFxFGMqEdiP2VmAE3Z1zmfSBBj8EkW
 pLt/flTjj6ZUPlo7PT0E6OWR6+IbfGw4L+b5HaEMp5FpRmjojp8KB6vD8ozcsto7qBSM
 B4twRqzXqJHdtOEyvbOnqUFa+p2BL4bPxb7eFfpAcO5Yv3a4XNOxexder47xsZDfirmr
 RFOwFO/d8RXLDbWSZLrj1nEhduoXN+iXvWPKmaWjnfak97IeL5wTJ4/yCiy4TKJrPkFS
 v7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011512; x=1691603512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXGp8ZoE5V8TDGBHBusqjmtpGceSTb5WuIHztmt2l2Q=;
 b=Jrrwoyq34xXa5GGzPYYtXny36xtXQS9cWsqCQWutIAR0hu0EgADDOQVQrNmgB2SGJV
 zFpibtPRnLsMztx/gKZcZY3OtNHiMVl4aQt1OVOWai7lpe9DA89hjztgyH/cqG5ejMdj
 6+yxpEAIG8OwcW6kBcxaHOxTPzX3Uz3ct4A6ihcSbdZncBiEsz5Pz3QxOUinaTeCcazm
 XQBugz78QGg0S/m81sGwsMlOjleL0GuBG1+VrrP1oCUxWM64uJM8Tha3ZP66KanKC45N
 T83bYeTLq2yKavNDe7iBOOeSPc/LQqEQTVKdT5ssYfOO/KDcIzpg7Dx5td+5nxfVoLsH
 CiKQ==
X-Gm-Message-State: ABy/qLbGFweT6E12TZUCFr72W14PueWFKjXdysiijyoY2Mx34dYlUuvz
 Oz1PN6d5b4VeLcXetG3F5FY6lPZNjCp1/lQxmZcnGw==
X-Google-Smtp-Source: APBJJlFSo5owCaQU5SUO/RjRm30UfKsYGg/wMRGZEz3ZkmY/mC0kvVV7xXXhg6u4lcFMHP64asqVFQ==
X-Received: by 2002:a5d:4703:0:b0:314:3e96:bd7e with SMTP id
 y3-20020a5d4703000000b003143e96bd7emr15193783wrq.4.1689011512134; 
 Mon, 10 Jul 2023 10:51:52 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 l3-20020a1ced03000000b003fc0062f0f8sm489126wmh.9.2023.07.10.10.51.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/11] hw/char/pl011: Warn when using disabled transmitter
Date: Mon, 10 Jul 2023 19:50:59 +0200
Message-Id: <20230710175102.32429-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 hw/char/pl011.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index e2e3d48b91..03dce0a1ec 100644
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
 
 static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
 {
-    /* ??? Check if transmitter is enabled.  */
+    if (!(s->cr & CR_UARTEN)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 write data but UART disabled\n");
+    }
+    if (!(s->cr & CR_TXE)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PL011 write data but TX disabled\n");
+    }
 
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
-- 
2.38.1


