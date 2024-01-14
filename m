Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD682D09C
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:44:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzm4-0003F2-T9; Sun, 14 Jan 2024 07:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzlz-0003DC-B6; Sun, 14 Jan 2024 07:39:32 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzlx-0001Yg-1y; Sun, 14 Jan 2024 07:39:31 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7d6565b5so9223724e87.0; 
 Sun, 14 Jan 2024 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235965; x=1705840765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Blu6OuTjSPsdfd3EbHeR0ttbZLV058NKotTs2DtlESs=;
 b=e8zL+0lXzIqWvSAGbaxDxZF1ruuppUcHrTwFlBz18MVRkriszdlZyBahIFmpDBzLIB
 g1RR0sW9GahmRUdRgYmJDAlcRlRGAoNPFn78xl5mMX081CmB9pSMC8yFTL2HvNGfKtiL
 DhKNzk0BJutuguZiR1eCQRkTHFbHMhcNO2yMHeS+nzE6eCUgxrRc3H692NQJZMYcB0Lq
 Ts9qJQ+QEPxx2YdWNCjUK0g3ApMghSlQrrhS4PkYgsNbV+0/W+L8oWqWgvHXfDURIZyQ
 z3afzcsvdEJm+xuFzOYrva8WZ3KQ/Oyxcp5f+aJhbMy/mjwAZ4K3NG9FDA64nUHfjGdC
 ZcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235965; x=1705840765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Blu6OuTjSPsdfd3EbHeR0ttbZLV058NKotTs2DtlESs=;
 b=O2JwVjboT6pWC+dBnr/mOWaBL5vjbl9UerZUH9qcTYajsZ2Y3tBLitbDWJvR+Qvl38
 gFMD0As+IANInHEdNaL3K6yDWC/qFMgo9xEv3NI096HqI1EDvY+qCwOy3iUlyyDZkzFB
 b7doprPDpyAD+iVVOtDTntn3PqbX7UzvRldpvMgTWWwQYy0+LPJt1FY22OJq62eDzJGL
 j/c3wyi34vItRwV1qZzIOlseUpDEW82L/qKMO2KNsIEkMQQVYmT1PTzjS7wL0mS3J7yy
 AyrdtAI0DI+dSjz5HpKHosls5F77Su4l3Cr5tZdEKcvkoxCFZnu6X6GuoUErBis16B62
 qCjw==
X-Gm-Message-State: AOJu0YyfIKk9RG+agnZ27t7sc2XYMPSOlHfOawZMFM0pFBAjGphgjd77
 3YeeOxhxFGOMESVyaUGJ8alpHOeiDNk=
X-Google-Smtp-Source: AGHT+IEBsmbm58nPQH4Hjg5RrwhCkRVAcO0Rd3js4FhncHG9B83nyPXe1zUnwDlkk5p0HH1nL/VHQQ==
X-Received: by 2002:a05:6512:10cd:b0:50e:2bfe:ef43 with SMTP id
 k13-20020a05651210cd00b0050e2bfeef43mr2105583lfg.115.1705235964652; 
 Sun, 14 Jan 2024 04:39:24 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:23 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 01/11] hw/block/fdc-isa: Move portio_list from FDCtrl to
 FDCtrlISABus
Date: Sun, 14 Jan 2024 13:39:01 +0100
Message-ID: <20240114123911.4877-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

FDCtrl::portio_list isn't used inside FDCtrl context but only inside
FDCtrlISABus context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/block/fdc-internal.h | 2 --
 hw/block/fdc-isa.c      | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index 036392e9fc..fef2bfbbf5 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -26,7 +26,6 @@
 #define HW_BLOCK_FDC_INTERNAL_H
 
 #include "exec/memory.h"
-#include "exec/ioport.h"
 #include "hw/block/block.h"
 #include "hw/block/fdc.h"
 #include "qapi/qapi-types-block.h"
@@ -140,7 +139,6 @@ struct FDCtrl {
     /* Timers state */
     uint8_t timer0;
     uint8_t timer1;
-    PortioList portio_list;
 };
 
 extern const FDFormat fd_formats[];
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index ad0921c7d3..2d8a98ce7d 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -42,6 +42,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
+#include "exec/ioport.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -60,6 +61,7 @@ struct FDCtrlISABus {
     uint32_t irq;
     uint32_t dma;
     struct FDCtrl state;
+    PortioList portio_list;
     int32_t bootindexA;
     int32_t bootindexB;
 };
@@ -91,7 +93,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     FDCtrl *fdctrl = &isa->state;
     Error *err = NULL;
 
-    isa_register_portio_list(isadev, &fdctrl->portio_list,
+    isa_register_portio_list(isadev, &isa->portio_list,
                              isa->iobase, fdc_portio_list, fdctrl,
                              "fdc");
 
-- 
2.43.0


