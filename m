Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71381CADE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr5-0008Mc-CW; Fri, 22 Dec 2023 08:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqV-0007Rr-VK
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:50 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqT-0004I6-Cb
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:47 -0500
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-40d4103aed7so16804705e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252744; x=1703857544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VY9KY9jAEOnyFThfElKVnYvGwOxX3ZoqXZA4G1dIEXQ=;
 b=v6XLfaNZpVu/jOtozLnRUqP4nvHEhhSOjBtOrPUHr8Ow6fGb/o86mMPLL4CzSCmRLC
 /r9eFHLEU0sUKctLlOJjIAIqUNgOH+rln92v2Wa5QFaGSGB0u8jyC7u/xaj+Q+OOx6sz
 7cirKm8BitG/qH5rXefuiPagokzDZzKBeCiY1uti1mEzfgxkXNTRxKc4W0x6QFO/ZACC
 Or4qR7nA7Oqeq7RJ0UvdWPZ4ivR4MfZ9h0ngdjTza0TuEWQLy48SE0dkIIi9LQrRJQeo
 DsPJKvhzYGf52Qb6XKKOtTrS5ck06slqzhJ74ca/YDEvvEZAz7qiKlluW93QOin54VGk
 XRUQ==
X-Gm-Message-State: AOJu0YzovV5QqzsLka80/OhwA8mm2yCgNpMj6HxqOUaHZcdqyEHcv8BN
 1Gttz+6zXOmRV4GQdJbWfCrOW9MvS/0=
X-Google-Smtp-Source: AGHT+IF5QpFlTYvAyzg8zgVAk4tFsCpuqYcDOCtH6CBrXS8upglwJToDOxmx5hrkj9gdZF8c0L4VHQ==
X-Received: by 2002:a05:600c:4918:b0:40d:1bce:f069 with SMTP id
 f24-20020a05600c491800b0040d1bcef069mr882122wmp.25.1703252743588; 
 Fri, 22 Dec 2023 05:45:43 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:42 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 02/11] next-cube.c: don't pulse SCSI DMA IRQ upon reception of
 FLUSH command
Date: Fri, 22 Dec 2023 14:45:18 +0100
Message-ID: <20231222134527.15705-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.41; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Normally a DMA FLUSH command is used to ensure that data is completely written
to the device and/or memory, so remove the pulse of the SCSI DMA IRQ if a DMA
FLUSH command is received. This enables the NeXT ROM monitor to start to load
from a SCSI disk.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index feeda23475..87ddaf4329 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -473,7 +473,6 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
             DPRINTF("SCSICSR FIFO Flush\n");
             /* will have to add another irq to the esp if this is needed */
             /* esp_puflush_fifo(esp_g); */
-            qemu_irq_pulse(s->scsi_dma);
         }
 
         if (value & SCSICSR_ENABLE) {
-- 
2.43.0


