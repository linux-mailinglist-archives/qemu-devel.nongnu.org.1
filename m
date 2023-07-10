Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F3674DCD8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:55:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv3L-0001H7-7V; Mon, 10 Jul 2023 13:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3I-0001Ei-OZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:52:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv3H-0000Xq-7j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:52:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso5639329f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011517; x=1691603517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef0gwQxZ6wwALYiU0bKC0wOaAk58Ouu2v7vVPMXHDsg=;
 b=eb39i6i7xi4nlBgWcpkrPATAugD/ggTyTyPTcXl+fGuW6SV0vt8rj+5FHUlxaH1vnX
 iLDdCSljVhVQRZBY0YhxR0w4s0lkssx6npLSXepZhggJnSx/z535pdpgeLuYUAHlcE5A
 AtkEXWML8t6KVRp4AbuNsBCjbYq9ahdSX2dnBbryKfxmr0OMA/LZQxXYsyNQBrA00JbK
 mE8xfj8oGKbuQEbSMD49k1ZCkR9YVWOFbGdbkTjvL5+UKjwm8hV7/Bas7q80Tl/Ckb72
 6cdoWJkMxlaNMguwahRwZuIC2GcERO+FJryvCRgN02rtSQY9bJIq4EZ8vgxpcPD5JW7y
 n5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011517; x=1691603517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef0gwQxZ6wwALYiU0bKC0wOaAk58Ouu2v7vVPMXHDsg=;
 b=OcNDKCv29qzdrynpgZ8RUUlg93kb9H8zZROhX71YggK5rtxyLBxIcRs9aWpnbpnTAG
 zo5by8/6tdC2e8mM6OoZLH8h8Hk9h2WQNkB3vRChOIWseoiw3HAgt+1hQMXBCjDLDr7w
 hSSYNXWl5L+rUgsaD53HSe6dfNAUb2EyUx02lV48DXeuwvcpjxjdGgQcR/ioTiXRortu
 n3Au3tdOVhgOvk0DmbfxRXU/k1uQfIqECIrw+wh9fK0TpeFqEyTZxF/rZ0NQMPXELAsp
 z33gimTc3BTAeXrCAqSm6U1yUW7bILtbja8ld1WKUbb7N3Gfo8VHkDX08WaEhEjEk062
 DUIQ==
X-Gm-Message-State: ABy/qLZA6Zwmds01xwL180dhWkHuKvOYz1zL3Rp9QJPxqAxAqYuEnqoF
 yrZRgG/svo5uJgU4GtwD3hvRwDy+aBEigwwWv7OvxQ==
X-Google-Smtp-Source: APBJJlEw9Mu92KmORByDTBzHmJFR/rQlWsrR8POA7WWXn5RQfPn8wTX4kPsHuxuywA9ys0awNDcUvA==
X-Received: by 2002:adf:d84e:0:b0:314:2d71:1f7a with SMTP id
 k14-20020adfd84e000000b003142d711f7amr16256091wrl.32.1689011517665; 
 Mon, 10 Jul 2023 10:51:57 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d6387000000b003143801f8d8sm7154wru.103.2023.07.10.10.51.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/11] hw/char/pl011: Check if receiver is enabled
Date: Mon, 10 Jul 2023 19:51:00 +0200
Message-Id: <20230710175102.32429-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Do not receive characters when UART or receiver are disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 03dce0a1ec..59d239cb83 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -77,6 +77,7 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_BRK     (1 << 0)
 
 /* Control Register, UARTCR */
+#define CR_RXE      (1 << 9)
 #define CR_TXE      (1 << 8)
 #define CR_UARTEN   (1 << 0)
 
@@ -357,9 +358,11 @@ static void pl011_write(void *opaque, hwaddr offset,
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
2.38.1


