Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D890482619B
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrd-0005YC-Qm; Sat, 06 Jan 2024 16:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrb-0005XM-3G; Sat, 06 Jan 2024 16:05:51 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrZ-000180-Ai; Sat, 06 Jan 2024 16:05:50 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-555144cd330so766719a12.2; 
 Sat, 06 Jan 2024 13:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575146; x=1705179946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Blu6OuTjSPsdfd3EbHeR0ttbZLV058NKotTs2DtlESs=;
 b=D6lhQ0IwMBM6MkkvGPL7lP2DjMoGA+jtLIjImN75v+fXb+GwXpbdxZ2gw3NVLRXiB7
 vO4GgkC5fGZXlGdrZdwOUR9Drb1hJdgNp6hAZJg+aetezQhvzWyTerk+WVkmsI2ax6CX
 tmOup6tNLOZquX8nBHx5nT0JhQ6EIEIy+4TuuF4clRGxKI9akczEc+5MqFcNyWUlwkIX
 5zoU8mYT0sM6N77UlHUEa6PCm+M3/ATfmNCP0/QPCm7IJGOaeTh8MNFHUaChf73c9DRO
 UGWqqcry9EHNtwQUEuSn5He66i4foVBwU1dXOqsyJ/uhOWlGrF007l/jZ6axCykb7CVX
 AsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575146; x=1705179946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Blu6OuTjSPsdfd3EbHeR0ttbZLV058NKotTs2DtlESs=;
 b=oakW2a0CtM31GQjhXKdrNIu7gq1tC3WxuvQrdWCFQMpnO2sbDCfZNZoHXNXgrCgo+I
 2KBqWTomtxHhZTPPHXL6eO5frzdJLBssvx6lB2P3L9nm3B/pVEhFIg7clSnOxFZBurih
 iJp8mt6EO0u5eOeKeYwiYfl+SM9SKxg0mjkO4jVXf4v6ZnHqpt1PdbT5kiNqlRANWKbr
 dhlz4EGmsjKq94G2QOGUUxr7jnqa/5arOAD3DhRlMa3kl7mfIADCGHhOqcUkh7dvwFZk
 v9P05XjU/DK21YeIBi9a/WLExEnL/sWfAMpxTcdcfObF5loelTofHVf357fgQc+rFv13
 uIQQ==
X-Gm-Message-State: AOJu0YxeHMOe4jNsJ9XkJWeFlSdaiQjewB0jeK2q+ZSEQOJ6VwZyXhRk
 2HNTRkDU3SMQxvMmBhirzW3NYiyizpw=
X-Google-Smtp-Source: AGHT+IFvNpxU3KqeNE3EAiRL3EZ6yzxTOCnaezhIgQ8bDM0i2lcWRih+ZI7AqEo4G/08JhHZz7XmDQ==
X-Received: by 2002:a50:8a93:0:b0:557:cee:5f38 with SMTP id
 j19-20020a508a93000000b005570cee5f38mr774098edj.5.1704575146039; 
 Sat, 06 Jan 2024 13:05:46 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:45 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 01/11] hw/block/fdc-isa: Move portio_list from FDCtrl to
 FDCtrlISABus
Date: Sat,  6 Jan 2024 22:05:21 +0100
Message-ID: <20240106210531.140542-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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


