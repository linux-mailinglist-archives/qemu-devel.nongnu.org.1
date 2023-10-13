Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586407C8792
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItt-0000Rd-Kh; Fri, 13 Oct 2023 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrIto-0000Na-D4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:20 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItm-0004Z1-RZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so3489425a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206337; x=1697811137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEZCH3t9203jXT8Ca8hiOxWdvxGRGRt32KSzy33l+nU=;
 b=Lxz7tNbJotN8Tfrk8q0pfRt/TV0V1hzMBHT+rLxCCnVsrbcgnI68UefH3MGJeljeFs
 RSaYa5MLJd59AQJIHyxVmXLO7fk2dcvYWVv55XFvwLg8UnaGYOk8xoJ0BKu91cpwzLpC
 3OWlJj5i4NefZ79i/M47B2Jhn7mlM5VXkivJhVPaUOGiARv4Ff3EMPv/cUhz0fy8JREO
 1Le/KNBcDh82kZ2PoMn022NbFx6D1O2F4+MWK9GONpCqqBjs12E9TdYfrDD0wbVv9Wxm
 te780/MtOx1HhTMi/TPj1qBwOszgEatFsoA8aiO99DWw6yBnr4oOZJEDS+PZvS3UO1fp
 Q+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206337; x=1697811137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEZCH3t9203jXT8Ca8hiOxWdvxGRGRt32KSzy33l+nU=;
 b=iVtzzu0OMADY4iYTWh+9OfYdZMd/1iMOHlum+UoREP7ZWb8FmbZbbv3jDgAwtapwSZ
 V7gktkKbsqQPZcM9qB1Kys03wUvpliegBXyso05Ov2MXPPx7KjddKEHthL1f3XmSr1uR
 JWfq8uJwdA9wyOUHHetg7GiD8IVkizyN73PrwB7slokLvgERRHaPVpjmt/EMK6cNH9L7
 SJiMjYS0KY4Lt7juKbMcAoDbo3xwOO9A5E6hwmylLRAuvPHqBZ5psr7FbF/K5eTglCIR
 hRVzhm//ziJZAgSX/PcoDcBjYc6952skZDo9yyqZeOCmi3KROZ0glbd3KtydJwHIll6u
 z6dA==
X-Gm-Message-State: AOJu0YxKbKMd6wLE1jr0029Ff6/VyuvDOr6zyf1HpzJhQaBl2jvxrRAr
 7TQH/lgG1joCg/J09nb4kt0SkGXxdSXDVmYgiDk=
X-Google-Smtp-Source: AGHT+IHX4ugufWGqluImCZdUvxTDlFZ2SAOuBxWXdJrjlcL7BU5CoDVnCL1SAPP5XnXA6WFLpGEx+A==
X-Received: by 2002:a05:6402:35c5:b0:53e:6215:76ee with SMTP id
 z5-20020a05640235c500b0053e621576eemr229010edc.10.1697206337349; 
 Fri, 13 Oct 2023 07:12:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 c25-20020aa7d619000000b0053622a35665sm11366351edr.66.2023.10.13.07.12.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:12:16 -0700 (PDT)
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
Subject: [PATCH v3 6/10] hw/char/pl011: Warn when using disabled transmitter
Date: Fri, 13 Oct 2023 16:11:27 +0200
Message-ID: <20231013141131.1531-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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


