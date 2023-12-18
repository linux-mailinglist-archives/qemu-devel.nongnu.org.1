Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDD817A1B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiX-00068t-7d; Mon, 18 Dec 2023 13:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiE-00067l-Pw; Mon, 18 Dec 2023 13:51:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiD-0008P9-1l; Mon, 18 Dec 2023 13:51:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso43413675e9.0; 
 Mon, 18 Dec 2023 10:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925490; x=1703530290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3iaY6aUrLWJnbiEuFPEJDzWzkJTCJ7nk9T2FrK86B4=;
 b=MMTA4uYA6Fx0VA3r8ogRW7hBh4DFtQgr3e0vX9BlfjaX1Dig4mS5Tlskma5yR4PD2+
 StI8ZlFaZpDn9PKzFP7G5Gxrvt44xNsv8nFirATd6GZbJg8T+B5uVhttEhn+9KSaoTZL
 YYvDPOCMvsWZl+AoiadOxYIaCntpsCILsp58Muu6I6Kv0xAM/DCrhTqjUFY3huW66ZS0
 PopI3BWJp3osnh+dmYPLTtALt+bLLc+IuDKm55FMQQ1hnh3in6rpSUhykLA3UDYEr3pH
 qMbkq3W+x5iSoyJnALGvA/hdHCIzody98Lrv2X/00r376ci2Kp5EbxBfhBS0VyU+ZCyi
 S/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925490; x=1703530290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3iaY6aUrLWJnbiEuFPEJDzWzkJTCJ7nk9T2FrK86B4=;
 b=oXirGqHhNHblpuERhPv3hDobMQwjrozIlDsCzWdgW1gMX2Vsnym/LA3820aXs5zlOU
 L43GZxf/pWJkN5OzrIzW0KibtIwaOM58n8awFpyilhmzTLkIhYoItNcOSOROy0GrZOMb
 QMCf4XlkasYJlXwwcBitvzXgRb/KWKXKaDYhNT3o7Syv9RrWh7oiaR2Ae5OTKHP5sOa5
 F1cwzXEjfTScLXyGMo0XxPTYkTXPwgrJjdYhimSMOu/CPX7//HhiIV2RKqPxBz6Xw6m2
 h065J4IFRF1N3ofq3vwEiC9Z8YUBuErkscMYypHlke7K/9olM4nKx0N/x/E6zIo8PsTS
 twyg==
X-Gm-Message-State: AOJu0Yz9Kw6s8xrX+qdo1QakMxUY5bNEsmvF5GKjsFb1YSC9WkMBag0i
 S+nTvHMIeoIyOrwf6D5PuAF9Eq3l5LE=
X-Google-Smtp-Source: AGHT+IEQoXW8mJA/XHXJVcdsWPvExsVqWGecHBQ1PCU9T5HPJ+LUqgasnKnpmYpHCtd8jLwaIrMBqw==
X-Received: by 2002:a05:600c:4690:b0:40c:6c81:e6d with SMTP id
 p16-20020a05600c469000b0040c6c810e6dmr3061774wmo.6.1702925485603; 
 Mon, 18 Dec 2023 10:51:25 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 02/12] hw/block/fdc-sysbus: Free struct FDCtrl from
 MemoryRegion
Date: Mon, 18 Dec 2023 19:51:04 +0100
Message-ID: <20231218185114.119736-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
context, so more it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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
index 86ea51d003..e197b97262 100644
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


