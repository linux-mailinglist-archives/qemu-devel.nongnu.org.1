Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116697E7255
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:30:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ahk-00055w-Tg; Thu, 09 Nov 2023 14:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahi-00055K-PC
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:38 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahh-0005Gv-7J
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:38 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso2022864a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558115; x=1700162915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP8e7F+MNf59pa1iU6FTfmv7Sb18zKeyajADdz6BZOc=;
 b=yUA8Lh9vnAqKuqVclqo4i3ETE3k3VEdY79vtFZFifhM6esPzTL+Sc1vbf6GCBFyaTt
 Y62vlH/CLoCuJaA7twdJw3h36m+WNZ2DmiKq2R3l4N1CC4WCpYBSx8pwPLbTrM/nKttr
 SQflwdGaeuFjcdqJW7kXLF5p5PTfX9qGgYS2pZUcckqSETQQR64s0h2avoLPApes/e1n
 7S2mjFt5kmJBnhYbhsXkAksFPBLAXlAhMSb9Msj0uSmI/A/qcegHa7xD2dRgDtDeyqmD
 /zFoId7TjiraCPJmILdUVa4QpONPtym7ZCmNLQ7PVxO9RWIRaIJ2p+c0EaSIBbbP74NF
 VOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558115; x=1700162915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP8e7F+MNf59pa1iU6FTfmv7Sb18zKeyajADdz6BZOc=;
 b=nV8gVbj3FKIJoJ8gtBap4VIG+lvstfdbWtS8XmA792aYG/QbDbDIS0HGXEhFpkwOaN
 zs+gzGWwIwhNwcvvnbpgKPBB9kcgsQiL4wnrmmBwL9NBLECShh5OEEU4FGbwXUbNatX+
 fHZD/DUAx8BOoOUTzS03PvzGL6nY6TO4eCZZ5uuidkKzJk6z10cWoGjzdPSROfJT/1TT
 qYVw4fH+z8GzmCKtL8ZwrdLkPOxGghzPyHmIhsob+yPjHt26KWsQO0UaclpmRSYcDns/
 HlUtzBPZ1UwmsqkGaDsykJxTmu+MFkhU6u8Xt3EdiS2Z7ABap2/qiDOb0u6/Ihbi3SIQ
 Ze7g==
X-Gm-Message-State: AOJu0YxYMeo1X0kAiDtYaauqBBrF935RMUsiKzRV5PlQULi/l3ZQ75ay
 FFLxbpl37nrVQwXg0Ae4SfcBqmdMZCWGDfRiTu71Mw==
X-Google-Smtp-Source: AGHT+IGGos6RV93WgveC47MImoD//dBkcUR/VbX7MCdBOWuHJ/5fD+3r55VEGS5yvqHl0EYy1uU3kQ==
X-Received: by 2002:a17:906:d9dd:b0:9e5:21d9:3ba6 with SMTP id
 qk29-20020a170906d9dd00b009e521d93ba6mr712372ejb.9.1699558115130; 
 Thu, 09 Nov 2023 11:28:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 bw25-20020a170906c1d900b009bd9ac83a9fsm2946023ejb.152.2023.11.09.11.28.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:34 -0800 (PST)
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
Subject: [PATCH-for-8.2 v4 03/10] hw/char/pl011: Split RX/TX path of
 pl011_reset_fifo()
Date: Thu,  9 Nov 2023 20:28:07 +0100
Message-ID: <20231109192814.95977-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

To be able to reset the RX or TX FIFO separately,
split pl011_reset_fifo() in two.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/pl011.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 58edeb9ddb..1f07c7b021 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -132,14 +132,21 @@ static inline unsigned pl011_get_fifo_depth(PL011State *s)
     return pl011_is_fifo_enabled(s) ? PL011_FIFO_DEPTH : 1;
 }
 
-static inline void pl011_reset_fifo(PL011State *s)
+static inline void pl011_reset_rx_fifo(PL011State *s)
 {
     s->read_count = 0;
     s->read_pos = 0;
 
     /* Reset FIFO flags */
-    s->flags &= ~(PL011_FLAG_RXFF | PL011_FLAG_TXFF);
-    s->flags |= PL011_FLAG_RXFE | PL011_FLAG_TXFE;
+    s->flags &= ~PL011_FLAG_RXFF;
+    s->flags |= PL011_FLAG_RXFE;
+}
+
+static inline void pl011_reset_tx_fifo(PL011State *s)
+{
+    /* Reset FIFO flags */
+    s->flags &= ~PL011_FLAG_TXFF;
+    s->flags |= PL011_FLAG_TXFE;
 }
 
 static uint64_t pl011_read(void *opaque, hwaddr offset,
@@ -289,7 +296,8 @@ static void pl011_write(void *opaque, hwaddr offset,
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
         if ((s->lcr ^ value) & LCR_FEN) {
-            pl011_reset_fifo(s);
+            pl011_reset_rx_fifo(s);
+            pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
             int break_enable = value & LCR_BRK;
@@ -506,7 +514,8 @@ static void pl011_reset(DeviceState *dev)
     s->ifl = 0x12;
     s->cr = 0x300;
     s->flags = 0;
-    pl011_reset_fifo(s);
+    pl011_reset_rx_fifo(s);
+    pl011_reset_tx_fifo(s);
 }
 
 static void pl011_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


