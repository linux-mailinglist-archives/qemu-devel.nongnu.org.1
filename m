Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E372D817A17
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiD-00066z-81; Mon, 18 Dec 2023 13:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIi8-00065Q-SS; Mon, 18 Dec 2023 13:51:29 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIi7-0008OK-BC; Mon, 18 Dec 2023 13:51:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c31f18274so45074055e9.0; 
 Mon, 18 Dec 2023 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925484; x=1703530284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35pwZ9lDGgY4cRkCVkGeA79o60zkVpVeGL4oTWNLKjs=;
 b=KGkOyk1nJ2i67kTfCYD7W6wjrIuLKK5Hxnns/dls+dsW4RqgTXLBtR5gy883TBa28i
 M5AWZ89VOtMDyos4nZcPEYZZrXxzcS1z0eNpdT4EhsTCJV65lZhjt5THRkH6LOK6cXqO
 GgDUStoNJWMUXqHFS6j0+Blk75/7KOptEGz5yaVEzA9JMcHxZkiF8imDfleiYSxYVdC8
 M1mE7Nk/gvb7DuWnWiSkwbWC62KPwegO/wjUVRTShTjtXhXpPWByXqgNPQ5H93Tqe2Lg
 iXQXkozYVqvVXD+uJL073NS9eMFF9ifHfToUHw3AgSn9X4o7LDBurYqZCTLc13aY1nr4
 dtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925484; x=1703530284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35pwZ9lDGgY4cRkCVkGeA79o60zkVpVeGL4oTWNLKjs=;
 b=KVENDU2GFXD4v2oEWOUxmp3zEMbYHhG+1yiD+y+bBUlkM/bGQ2C4GhL/NzAF/UyLR1
 UY3Ez0+ILVmheYX2023QOJ7eg2Lme88cFMT5VSYdmNK+9N7ibixY3s0bN5ejK2NJ4v6C
 lzvgxKH8DFPx1Ee8OV3vXbl0mts9ePNaM7pF15cS7RjvBQqw5Ula0Ylf0qMm2QWmTvFC
 Udlxr/SglUAyY4o6Uk64MGiwy00wocs5TbokL47HbAGLnMxhVYp295CSwEKCC4B7uZ0I
 ztTzrkbVthLX66n6rRCx8I5hH4hn1FSFn7xBDF/N4AJDidh+Oa7StqNVDEKOIDoEdaWX
 B5AA==
X-Gm-Message-State: AOJu0YzxG22GnPoxI51+eBExV7SQjAYSwHMV4DTtiqBSWQEW+B+IlK+D
 gNehMkn4jxOAOJZ2J7Y3oSFEXT0kq2k=
X-Google-Smtp-Source: AGHT+IEPFRvqdNkXZwjnb/RCQrxgyji0eZOYyrdL9nzn+sdKy1dxuL5g95+Maha8BS04hIa5saW+HA==
X-Received: by 2002:a7b:c44e:0:b0:408:4120:bad2 with SMTP id
 l14-20020a7bc44e000000b004084120bad2mr7949477wmi.9.1702925484384; 
 Mon, 18 Dec 2023 10:51:24 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:23 -0800 (PST)
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
Subject: [PATCH v2 01/12] hw/block/fdc-isa: Free struct FDCtrl from PortioList
Date: Mon, 18 Dec 2023 19:51:03 +0100
Message-ID: <20231218185114.119736-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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
FDCtrlISABus context, so more it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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
index 7ec075e470..b4c92b40b3 100644
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


