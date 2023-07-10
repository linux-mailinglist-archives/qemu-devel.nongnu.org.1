Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE074DCCE
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv2x-00011Q-Fb; Mon, 10 Jul 2023 13:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2n-0000yx-9U
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIv2j-0000En-5b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:51:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so61361915e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689011483; x=1691603483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFiMwX80BmNyck0DZZOUXh/iAvr0cOgiPWTiwk+R4aM=;
 b=NJq6cF1MGbORrPghESeaZMPTdldDqRn8SaJQk9Lx0Bj+YAHX48XODawpstkOvRMiI/
 XMl7JqR/qIg60irlnHtG+Y0+x9i1FVJfzAWsNDGsUEmzfeZiaOPloJG3QWcE2Xn8BW61
 wdYzXLglLG9YPbcp8SFZmzqZUeR01B1IB4LusROjUE+HpsB3feBF8jH+R0urWJQLw7WF
 7f6b5CijJ1cKgScaVZGXV/M5pPI/pl6820Q1hxOZeiIUxQuaPLnyY61ERhK3ilXh0oX3
 XyHjZ7DkDnAwx/+4uIpVkKOimQOe48OFyCTPUf5Y6QFgGXpLkGwgY7EUIvOod4I584Rd
 U+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011483; x=1691603483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFiMwX80BmNyck0DZZOUXh/iAvr0cOgiPWTiwk+R4aM=;
 b=DHFztOnxvm91yTIP9gn2X2ZMmwldkhsd8i4f5ll7DmDOIun0RsLtyrZIi/RropbmNa
 tGcEIx6scOOAWzgqmdBgyQXJKhxbD7rMBvtCLva1E/BIMznM/2dk5/YNMZZG08TGP3dn
 vr3X/Yr/5w+SHkobBUiU2FhhXH5YeF5B7WDn4GlVUPqoAMI3CGGVn7ptVp6q20ZvQcia
 Jv1g2Fe3SOrCrRxo8qUOPEWTp+rGxPAoNbINbSIgIUUUnp6aKWUIP72y6VpgcgFNaDxL
 IljzYzqep6EqTVVFFsuZ49dRSD5tEWJDsb+5LFpVD+rYo4T6nUBwZoj3WlDI0lNB61S7
 J0SQ==
X-Gm-Message-State: ABy/qLYdObUdiwmjPkHH331eSrYxdBDn/iJR4jGrkV8NiralMC1zgiiC
 f/9/QQzikCsDsVNR70CGuiYsE2X/OU+MWRiLGiIaBw==
X-Google-Smtp-Source: APBJJlHAEy1s+HE4KagIs/j7WeU2hp7vyaaYwc90k+EbA8tKvYwDAZwpyGGbebgcXhw7qk/kegNS0A==
X-Received: by 2002:a1c:6a04:0:b0:3fb:b9b7:fb0c with SMTP id
 f4-20020a1c6a04000000b003fbb9b7fb0cmr16810018wmc.31.1689011483625; 
 Mon, 10 Jul 2023 10:51:23 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 u13-20020a7bcb0d000000b003fbc9b9699dsm433256wmj.45.2023.07.10.10.51.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 10:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/11] hw/char/pl011: Remove duplicated PL011_INT_[RT]X
 definitions
Date: Mon, 10 Jul 2023 19:50:54 +0200
Message-Id: <20230710175102.32429-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710175102.32429-1-philmd@linaro.org>
References: <20230710175102.32429-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

PL011_INT_TX duplicates INT_TX, and PL011_INT_RX INT_RX.
Follow other register fields definitions from this file,
keep the shorter form.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/char/pl011.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index c3203e5b41..96675f52cc 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -48,9 +48,6 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
     return dev;
 }
 
-#define PL011_INT_TX 0x20
-#define PL011_INT_RX 0x10
-
 /* Flag Register, UARTFR */
 #define PL011_FLAG_TXFE 0x80
 #define PL011_FLAG_RXFF 0x40
@@ -157,7 +154,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
             s->flags |= PL011_FLAG_RXFE;
         }
         if (s->read_count == s->read_trigger - 1)
-            s->int_level &= ~ PL011_INT_RX;
+            s->int_level &= ~ INT_RX;
         trace_pl011_read_fifo(s->read_count);
         s->rsr = c >> 8;
         pl011_update(s);
@@ -262,7 +259,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        s->int_level |= PL011_INT_TX;
+        s->int_level |= INT_TX;
         pl011_update(s);
         break;
     case 1: /* UARTRSR/UARTECR */
@@ -350,7 +347,7 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
         s->flags |= PL011_FLAG_RXFF;
     }
     if (s->read_count == s->read_trigger) {
-        s->int_level |= PL011_INT_RX;
+        s->int_level |= INT_RX;
         pl011_update(s);
     }
 }
-- 
2.38.1


