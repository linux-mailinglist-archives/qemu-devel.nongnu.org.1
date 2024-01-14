Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FF082D09F
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:44:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzm4-0003F1-SI; Sun, 14 Jan 2024 07:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm1-0003Dg-7h; Sun, 14 Jan 2024 07:39:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzlz-0001aT-FW; Sun, 14 Jan 2024 07:39:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e5f746ac4so40782325e9.1; 
 Sun, 14 Jan 2024 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235968; x=1705840768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+9ZapGs110KfVKNFzaiA44RoY0VoVZdYmH4JCjTMrQ=;
 b=RlHvsf3NTfmfJjoRODzMsxzZYC/84sjcNW/vtHgGoX3w0Kkt0gm9fJidkYH+zlWn5f
 WdhfZdcVc7A/22eWIlYaxtAfsd9MjXWCX7+A1ApPbn/3LAISiaHeqh3TwUzsn/yiuIM8
 M49NhvfHSA3YkUNfOn9fH8yOuKSDqPQ8DrONub5nu5CSivIHLz6T4Kd/eVPPaKnYxkLn
 fgU2tUAtwEPs1K6d+v+xfMJYgo/GMOqQ4uv7zmlzAe2XqIn2EpcHsW0GC4J6y9iAENJ+
 V0GrDTfk3KcrsHXQgkfP/VzRb0OA0wZnalaYQUA/v0HyucM0sbOHgtqmqkl8TnF+Cov8
 LkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235968; x=1705840768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+9ZapGs110KfVKNFzaiA44RoY0VoVZdYmH4JCjTMrQ=;
 b=R3WwPKisBoTtmZomZdV3vy1yPWyFwY9K1EN7U9rNvl6OyFHQiGZm4n2Lj61Y3yqTxS
 6LkZ8CZ2bdM2WHExJEkEs+DGv2YSpTSvrlFfaEB976VYJz6rXRMMVZ2kC+N6AJEfIj+I
 9OjGVkvaaK9PIquMLs1jZeYk4PO3C6g26XjQsuduLq+Kn9QA3mCAEEYe+vjjYKUEMvc1
 ZjCDqoyGzbSHQVjDyTq9BvScWgKsglnBWpDF7jlT0yw9z09rU9NZ53kK2vr1OyAZEy7G
 hrCbrcW20khm/Y73YAOhePu4fJkZLExjLiaGdWZ4dCsuRiNCBWQdAcRxDaQiO15eix+4
 kC1Q==
X-Gm-Message-State: AOJu0Yw6Fhqjm1Fd8t87vx6LqgCQEM0JdF8ylAI3MmPRNKclzpaW6lxp
 MeQhzFpRqXzVJpMsoA3vLf1c3G2j8WE=
X-Google-Smtp-Source: AGHT+IErOcbIpe83fjdXOFuOXp0Js87h3sYLJTW60HMicr/amRmSEj71Sp14D+50+9xVHz89+kXTYg==
X-Received: by 2002:a7b:cb04:0:b0:40e:50c1:4e79 with SMTP id
 u4-20020a7bcb04000000b0040e50c14e79mr2280188wmj.45.1705235967569; 
 Sun, 14 Jan 2024 04:39:27 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:26 -0800 (PST)
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
Subject: [PATCH v5 02/11] hw/block/fdc-sysbus: Move iomem from FDCtrl to
 FDCtrlSysBus
Date: Sun, 14 Jan 2024 13:39:02 +0100
Message-ID: <20240114123911.4877-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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


