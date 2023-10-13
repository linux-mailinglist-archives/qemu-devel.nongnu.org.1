Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300AF7C8796
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrItd-00084I-Nm; Fri, 13 Oct 2023 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItb-0007zM-9l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:07 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrItZ-0004WI-5g
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:12:07 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso3124543a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697206323; x=1697811123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RcEaeq0Z+56TpsJGBFP08HsnS3amqPkJQB4mf707C8=;
 b=hsIVvSeI6N0lVpK5iRJ5DXPNg0Tw8ECT7O0q2XWV48rx5cF2KVF5xNYGHXhS73rnZA
 5gyKjVcWwkbz/rUh38KPDF/5m+5wrekrY+D7S4JdX/5GyBC9Q5MgeZ6AqT46lTRX9hu+
 ruRiXc0gzY9Mckn7sX3+5eA0xLz4uUZyaR/yF85AQYqj3UJV2iXjnpEifK3IeZ1McSad
 8+q1WdELEEqkJrQn+TU16+M4jEOZKGkiDgabPJpkcFf8J7WIrfDSlF3HVWpYcTD/Ori9
 fthUgyNXIfcPsISGBJ8Kj3pAUVFObVzcWivcr8fbWN66w+lIaE0B9EUFuvSwJeE3HBBn
 bPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697206323; x=1697811123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RcEaeq0Z+56TpsJGBFP08HsnS3amqPkJQB4mf707C8=;
 b=sEDxurJZeVne91baQExCDSJfkO/BekUJP1JiFwbDSu59O4cC+x86SCS9EJJG4CQifL
 Iov68BMrTRx5qiy03WY2Mx80EE/g3rLLAZQEUYzbpU3TLN5yiqemu48R9Kj2YByYVYdZ
 ipt4HiE1495MIh7vVpK65HNnPoASlXqlLFbqc+kJP3eEV9cVYvg8spTvP9Wxb1ABAut1
 VslBtQWQ/zBDtaQDnGIbkBzt1orD1K2qz2yr9r1nu+gxZy/i8kC8DNNfy+ZoX1wa24jW
 pGv/WeriJcDEBbWgwASFak8Nvq26+F5rvPaWjdBJzyf7cz8MiYUOScqgVOXV/NzJtW1u
 jbUg==
X-Gm-Message-State: AOJu0YzPGdMUYFT/nuIqnlt8OHI+ZqkgMJtVeoeylXCS0pl0HuRvZe3m
 TEkQE1Wwww5DKyitlCw9yxMxzZHikFtEQjQj60E=
X-Google-Smtp-Source: AGHT+IEC6z/25JTa9NFgmu1QMRsT5kSfe/PoNZFCEOChPkPJTwnx9Q3GGu/7jPYY8ZhJHlZe5Mzmdw==
X-Received: by 2002:a50:c048:0:b0:53e:4dc6:a2e8 with SMTP id
 u8-20020a50c048000000b0053e4dc6a2e8mr1221176edd.19.1697206323563; 
 Fri, 13 Oct 2023 07:12:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a056402101a00b00533e915923asm11479677edu.49.2023.10.13.07.12.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 07:12:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/10] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Date: Fri, 13 Oct 2023 16:11:25 +0200
Message-ID: <20231013141131.1531-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013141131.1531-1-philmd@linaro.org>
References: <20231013141131.1531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

When implementing FIFO, this code will become more complex.
Start by factoring it out to a new pl011_write_txdata() function.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/char/pl011.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1f07c7b021..1cb9015ea2 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -149,6 +149,17 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_TXFE;
 }
 
+static void pl011_write_txdata(PL011State *s, uint8_t data)
+{
+    /* ??? Check if transmitter is enabled.  */
+
+    /* XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks */
+    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    s->int_level |= INT_TX;
+    pl011_update(s);
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -262,19 +273,13 @@ static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
     PL011State *s = (PL011State *)opaque;
-    unsigned char ch;
 
     trace_pl011_write(offset, value, pl011_regname(offset));
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        /* ??? Check if transmitter is enabled.  */
-        ch = value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        s->int_level |= INT_TX;
-        pl011_update(s);
+        s->readbuff = value;
+        pl011_write_txdata(s, value);
         break;
     case 1: /* UARTRSR/UARTECR */
         s->rsr = 0;
-- 
2.41.0


