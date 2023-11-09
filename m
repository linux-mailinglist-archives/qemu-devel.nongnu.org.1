Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218087E7252
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:29:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ahs-0005FY-Om; Thu, 09 Nov 2023 14:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahp-0005Ez-Ae
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:45 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Ahm-0005HS-H9
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:28:43 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-54553e4888bso1752534a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699558121; x=1700162921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RcEaeq0Z+56TpsJGBFP08HsnS3amqPkJQB4mf707C8=;
 b=aZ1o6QiNBdtXS2EHkgqglPT6KqQ7ZPqlUY/+jTJP8kvgZJ0PMZwuTzBQE8OCxZNPHr
 gVuuN/MXif6I+a2X49syDP+LOidM3rUMkNX8rbh+QcjWgx2kOLk8z4Uj5m0tnu2ylQCw
 vIpTn6c1StNYCnWhJJfo/vjrw2ldBFuQejOoHtmTT5U6GK74NrjMzE0QcwzFzQ1kkjiK
 N4x7qbjw0n3dkwvdYOdMtaTh77EH1uptHdrfPIVtNlXuMgN205sev3acaF+BFVaIWVR5
 cLqfWsOlnu/Nmp12d5plTIDI0q6JwoYJE6I5FKU0EKbr++WUkG9cBoe8FRM6jQ2VwytJ
 5X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699558121; x=1700162921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RcEaeq0Z+56TpsJGBFP08HsnS3amqPkJQB4mf707C8=;
 b=lk+shYdnytl7WjuhcxiIOCwKn4YyV+z9/TSacSmOuWVGbEsxBANGlVM/e7XhghHbWf
 t2aAZolqeBOyirNhukzWHSIsOAxJOSVDnt91lsQzouVWlz+uiTYP732nfzeMk97Jqu34
 4EWu+cSvkeH4jy11UcXBkq/R0kZErQRNvE+s1+Bgb0E7WYqEtjEUDaDwPJSA+td2P9Jl
 wAB3JPWsCaLDRc9D508bnZSG/JiDKmZ0vkmR3t35M9wJHhF5SqVSEbrxmN1qnEP4EikE
 oKqRmhOR75HtJu/5HiD59udkSTnvIRiH4hO1uX5KxzR7YsN8S3J323DhapJPZ+c/VwFk
 X65A==
X-Gm-Message-State: AOJu0YwJJHx1lBRnKfhgQL5Wy5rXz4cRV551VuDXpwy9b41WIep7qAOx
 18+0H1H0Phi+ln4taGCunHjBSwAQZieWCaQgdI7r/w==
X-Google-Smtp-Source: AGHT+IHlHZunX7/OzM/Hq8gtZQVZaha5htzE2nm4Itn4uRqrEmWxmG+hAyGrESaQi+hKc8p2UqA6hQ==
X-Received: by 2002:a05:6402:358c:b0:545:5601:4148 with SMTP id
 y12-20020a056402358c00b0054556014148mr3310692edc.7.1699558120928; 
 Thu, 09 Nov 2023 11:28:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05640204d200b0054554a7bbedsm181784edw.24.2023.11.09.11.28.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Nov 2023 11:28:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-8.2 v4 04/10] hw/char/pl011: Extract pl011_write_txdata()
 from pl011_write()
Date: Thu,  9 Nov 2023 20:28:08 +0100
Message-ID: <20231109192814.95977-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109192814.95977-1-philmd@linaro.org>
References: <20231109192814.95977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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


