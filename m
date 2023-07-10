Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8F74DCC8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:52:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv3B-00018r-Rw; Mon, 10 Jul 2023 13:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv35-00016Q-RQ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv31-0000P8-0p
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so4610044f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011500; x=1691603500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV7jdQi4bEVcp54eyyf8vkcdig+8iB+0mpkWJfR4/DM=;
 b=fY5N0dtvRGCbZtWbx9sN0hPUOOyTjaaazesQVpbBowQuAMYOIiHwvVLID+MPWwLTdl
 bEJqJmUKCi/5rfiEJpw7zmtrtPAN0YsthmWKS0EdUuLqbyxCRofrj8yrWPj2YE4xKVVq
 wUfzDUgqczbSUPDBiG2nX7KXZxwuIYl6anyqUHAOdxlSQpTDjpb+CL2wP67ENCqvJtYO
 akpSSlAJCQvKYeko9CD8N6ZIi8R/GKEWDpJcP0c6bDZ0yxEYVKRAV1yy36aKojkHh+sW
 9GMq6ESc+hn43rCQ3aP4Zwyalh+hc1whfMEnf4Lw6Z77JsmYOlHqQ0L0iR+eWpHHIrTG
 NpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011500; x=1691603500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV7jdQi4bEVcp54eyyf8vkcdig+8iB+0mpkWJfR4/DM=;
 b=Tuk0v+EVRYBaZsFHqeHi/3peo4eUC58vaPC73o3Go5AJr97/m/75qjB2vTUiaJWIv5
 n+wDE7ovbdn2kN8K9AIAV7MXuh06lLq3hUy7zpeqgKwrCzRKLILOu4NyPKWyTU1b2TMP
 AzxYxPuktCXdNMnnf9felVVfmRj4+sAjS174PSmZg0dT0nBzt/xyQLmln/0o8FCZO73B
 YBXZr/ZZWa1WrfXhY9mnHUa6y0RU3F4McZbrfY46h6KQTyHJKIzjMZ6T4lTcXxtRgAa5
 xNqgInVX5EWJOcpvOLNXw/AcoEIxUx+ACbI5oYDQPjpDLWIAyMI4ORbeRqaMDo4u/Iy2
 oL+g==
X-Gm-Message-State: ABy/qLaeyqPXt9AVLweHQyYW/n70Dt5Erv+XlYTl9YAN+P3f/dSXb8iB
 anHvi+qwUhknWr8H873D65KGDDXZ48wsj9p9rxrlhg==
X-Google-Smtp-Source: APBJJlHDBaazICpyGhOY995Ivwofx9KroCWeobCu6JYe6jaUfJhR2XcBDZcPHcv5ddzbMHLn6etZFw==
X-Received: by 2002:a5d:510d:0:b0:314:114e:6e0 with SMTP id
 s13-20020a5d510d000000b00314114e06e0mr12298007wrt.3.1689011500455; 
 Mon, 10 Jul 2023 10:51:40 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 cr13-20020a05600004ed00b003143ba62cf4sm15384wrb.86.2023.07.10.10.51.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/11] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Date: Mon, 10 Jul 2023 19:50:57 +0200
Message-Id: <20230710175102.32429-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
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

When implementing FIFO, this code will become more complex.
Start by factoring it out to a new pl011_write_txdata() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/char/pl011.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 1f07c7b021..7bc7819d8b 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -149,6 +149,17 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_TXFE;
 }
 
+static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
+{
+    /* ??? Check if transmitter is enabled.  */
+
+    /* XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks */
+    qemu_chr_fe_write_all(&s->chr, buf, 1);
+    s->int_level |= INT_TX;
+    pl011_update(s);
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -262,19 +273,12 @@ static void pl011_write(void *opaque, hwaddr offset,
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
+        pl011_write_txdata(s, (uint8_t *) &value, 1);
         break;
     case 1: /* UARTRSR/UARTECR */
         s->rsr = 0;
-- 
2.38.1


