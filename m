Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6E826193
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:07:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrf-0005aG-0q; Sat, 06 Jan 2024 16:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrd-0005YT-CJ; Sat, 06 Jan 2024 16:05:53 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrb-00018a-Kn; Sat, 06 Jan 2024 16:05:53 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cd17a979bcso5594581fa.0; 
 Sat, 06 Jan 2024 13:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575148; x=1705179948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+9ZapGs110KfVKNFzaiA44RoY0VoVZdYmH4JCjTMrQ=;
 b=ibqzl6xOqzXDApHiCdM4mwO3Tlg/v1oZzfSzY+YI4UFyFkyMOA7ApCwpic3LJkByD6
 msrsZMJvupHxyjlzq4ksTg3OfW+mOMkl89Fqkv6LE9hBjp7w1pLvnIt3n94wjlCx2OIQ
 l/7KSXNn8qyg6XfJ70QtMb3hYCWotPKX2bNyGHbT+HhUMMBg2GMTXsYXfsk0fyahuj7j
 M19DCmD1yEYbUbel37/1wMALyHECsu93EwdK9G4V7vPlwxcWHGM1J77vA4PyAvpIU6+i
 BkZtip2RyevsdJs1T3ehRz8hAy13wHSsAFtI6a7L3Ts0Vy71/7x5uHFQHI9pkQHQZncU
 xyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575148; x=1705179948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+9ZapGs110KfVKNFzaiA44RoY0VoVZdYmH4JCjTMrQ=;
 b=aOERpy0V1v1N21Q2zqmSPQ1nnqPrrgHegTU46MlBFljOuL+Hn2+LDnHHUL1TYDEFe2
 Mcoc83qhfskDXXgFTTZT76TW9/Q8ZbSVLyUAtmZf+MjUoGeIDJp6mnz8NrWE4ZglNoJ2
 1fmLIXzGJWLj5YNuDPbSgQG9afzODZeKM2C822jN8FDvEqo5SuNDhmRpHryXkdSakRpc
 qASjF5UVtA6p7QwrfVwWHjqCHV9VbkVjJo7lN/7ZvlhUgNqnhkaVIKy/ntzGaukcW6t1
 SBeCC8agNNqCfQlscT6hXXHPogvgXoZDtQRcA/uVvZ35G6nKNxFQ0iMf0x0RFXNKqGGb
 5dmQ==
X-Gm-Message-State: AOJu0YzTXg7Co9b+vifeRtnYMo1k/8eM7BfRxpHNuzZTqsa0GWL++4Ik
 krPrKPOlGajsJsrtmT/jlhImISFO0D8=
X-Google-Smtp-Source: AGHT+IHzE4IeiJR+Q85AjXB2FVM0Gdzjh6JaEkHPuINONpCi1dNx01zUuHHd21CoyijjkXT5rW5Aeg==
X-Received: by 2002:a05:6512:e91:b0:50e:6202:dad6 with SMTP id
 bi17-20020a0565120e9100b0050e6202dad6mr287912lfb.142.1704575147700; 
 Sat, 06 Jan 2024 13:05:47 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:47 -0800 (PST)
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
Subject: [PATCH v4 02/11] hw/block/fdc-sysbus: Move iomem from FDCtrl to
 FDCtrlSysBus
Date: Sat,  6 Jan 2024 22:05:22 +0100
Message-ID: <20240106210531.140542-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22b.google.com
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

FDCtrl::iomem isn't used inside FDCtrl context but only inside FDCtrlSysBus
context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/block/fdc-internal.h | 2 --
 hw/block/fdc-sysbus.c   | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index fef2bfbbf5..e219623dc7 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -25,7 +25,6 @@
 #ifndef HW_BLOCK_FDC_INTERNAL_H
 #define HW_BLOCK_FDC_INTERNAL_H
 
-#include "exec/memory.h"
 #include "hw/block/block.h"
 #include "hw/block/fdc.h"
 #include "qapi/qapi-types-block.h"
@@ -91,7 +90,6 @@ typedef struct FDrive {
 } FDrive;
 
 struct FDCtrl {
-    MemoryRegion iomem;
     qemu_irq irq;
     /* Controller state */
     QEMUTimer *result_timer;
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 266bc4d145..035bc08975 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "exec/memory.h"
 #include "hw/sysbus.h"
 #include "hw/block/fdc.h"
 #include "migration/vmstate.h"
@@ -52,6 +53,7 @@ struct FDCtrlSysBus {
     /*< public >*/
 
     struct FDCtrl state;
+    MemoryRegion iomem;
 };
 
 static uint64_t fdctrl_read_mem(void *opaque, hwaddr reg, unsigned ize)
@@ -146,11 +148,11 @@ static void sysbus_fdc_common_instance_init(Object *obj)
 
     qdev_set_legacy_instance_id(dev, 0 /* io */, 2); /* FIXME */
 
-    memory_region_init_io(&fdctrl->iomem, obj,
+    memory_region_init_io(&sys->iomem, obj,
                           sbdc->use_strict_io ? &fdctrl_mem_strict_ops
                                               : &fdctrl_mem_ops,
                           fdctrl, "fdc", 0x08);
-    sysbus_init_mmio(sbd, &fdctrl->iomem);
+    sysbus_init_mmio(sbd, &sys->iomem);
 
     sysbus_init_irq(sbd, &fdctrl->irq);
     qdev_init_gpio_in(dev, fdctrl_handle_tc, 1);
-- 
2.43.0


