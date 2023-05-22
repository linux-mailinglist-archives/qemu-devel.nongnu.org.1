Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565F70C285
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17Wh-0007fH-OH; Mon, 22 May 2023 11:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WV-0007TB-LU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q17WU-0001Sb-2G
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:32:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f42c86543bso40693915e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684769552; x=1687361552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q108c2Lliqjn2JXt6hPBTH1oW++ckhJeDwIAiOICrs=;
 b=IMHyvW6b41w7xSQpLSpQKb/8I2BRZydodmSpCk/NRscgvzIhUtZMGKq5KcvWaFEhOk
 Kq70ExoxrZc3in+/b0WTJVRJTql9fCnKjgwxk4UTIBsCmo/ZqBTLH/PGLV9bspkR7JCU
 QucW5H14V+L+xxo2ZQnmqRjlxK7vHItTLcDcyrYvBAtTI3fmQEs+ZFEVvJCGDV7F2SH4
 NcXQLKdGt6NfS5pCmdLaVvxNp82i5dkrT6AtUuyRlBW3pxd++Km/O4C9lG9/bC3sbco+
 K/0d97xu9qcqWdRqZ+z/QdH9D1XUPeSqJAu8WUoEDLCbpYnZD5c2NowZnrPpSDZC1weZ
 xLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684769552; x=1687361552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9q108c2Lliqjn2JXt6hPBTH1oW++ckhJeDwIAiOICrs=;
 b=Th8hVQ5flf9+2tDFVQutLUh2zJErXMMNZiIhYdY1WhzHa+JZjYRJ+elw1WLtWYCkQf
 HbyAqvg2lAcCULmmKxBxBMhH5ttqqdu4wVCoMwhG+/7/OWUD/MDhm3sbzGroM9aU+qEg
 Y3yDZxlwuxqJzeSSUYavpE6i3hgeaq1HQQygYhTxryXUR4oaGb7zcipcmBkUdVV7ajO5
 DCUl0zzPHWb9yvhij18NPkG59U8EkfTUWc7mIPpRjtJntntHqlHOvqfpg5TP70LKaqPB
 p5j962SqVrRdVwO+vLg0H1ZjE/GIbCQceTqJ1UwPvty1yMRSprnMoXoPE1dVtx0nmQdo
 OxSg==
X-Gm-Message-State: AC+VfDwfF8hmxnUhv39QVk2b/aC80SURN5uLfnsv/a7JTvJ/VqdV8wnQ
 Wl+9sHf1+oDlg3mVTPGZ0MDvgnXwFPFeF5Ue7PM=
X-Google-Smtp-Source: ACHHUZ5daT317HebxC6rzNCrJzzvlRIQAwbUTOm48bB91IEBi8el7d5GDaIyU5ujf/bHkMcUQahh9g==
X-Received: by 2002:adf:dcc7:0:b0:309:32d1:59d8 with SMTP id
 x7-20020adfdcc7000000b0030932d159d8mr7907619wrm.64.1684769552397; 
 Mon, 22 May 2023 08:32:32 -0700 (PDT)
Received: from localhost.localdomain ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a5d670e000000b003062b2c5255sm7999526wru.40.2023.05.22.08.32.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 08:32:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] hw/char/pl011: Extract pl011_write_tx() from
 pl011_write()
Date: Mon, 22 May 2023 17:31:40 +0200
Message-Id: <20230522153144.30610-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522153144.30610-1-philmd@linaro.org>
References: <20230522153144.30610-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Start by factoring it out to a new pl011_write_tx() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/pl011.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f0b305e5d7..c55ef41fbf 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -149,6 +149,17 @@ static inline void pl011_reset_tx_fifo(PL011State *s)
     s->flags |= PL011_FLAG_TXFE;
 }
 
+static void pl011_write_tx(PL011State *s, const uint8_t *buf, int length)
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
+        pl011_write_tx(s, (uint8_t *) &value, 1);
         break;
     case 1: /* UARTRSR/UARTECR */
         s->rsr = 0;
-- 
2.38.1


