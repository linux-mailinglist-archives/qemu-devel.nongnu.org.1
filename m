Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D181BA43
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKej-00087y-Gh; Thu, 21 Dec 2023 10:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKeg-000874-W0; Thu, 21 Dec 2023 10:08:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKed-0004Iq-Da; Thu, 21 Dec 2023 10:08:10 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54cd2281ccbso1035995a12.2; 
 Thu, 21 Dec 2023 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171284; x=1703776084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfHRRNWqxD5Cz4yUuf761Ur5xxVpSmPBcVYJl+qexEY=;
 b=BABXFLT+5bTfFvqaz8wYSa0CMcbmOR5JPSbi/2nOxi5zJHtVntaD8MNCelhFZ1+68b
 IEDlJM9jFBxI0AujFVZHr2r4La/gBd6Vik15xtzJBnruFMru+nFCr57NBji6y/X+LvZP
 1Mp7gGvGeaDVJRyo3f7YF+x8drU+sNcGvU8nWIu91Mq43GcJHTJbrg4TtSymOKrF1aOB
 gd9V+5eMrwTJDvnuJ8lJoEMyxvbiBCPb003mychJOuHM39g2ac7GnO9uoGhKj2iFhCco
 VqDZXMXGIHXS6YrNDApaNjU/k5GGf/7AJ3AgapA7goSTcLlNY/slTs+fZPOjW9BPFh++
 NMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171284; x=1703776084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfHRRNWqxD5Cz4yUuf761Ur5xxVpSmPBcVYJl+qexEY=;
 b=UnSW2sOwBIj8Jf9xYtPMfY7ayVqOQn5bbykH130CHBZZuLeQP5H+Y3UOHc9eK2vRti
 Kbl/L4EufOPPcMSmIUZDr/cb0CGdIjBR7uJOOLlCe1Vhs0zfEsbGjLV+L+1IfSrPGL26
 43YgSUdvoqWz87IsaG4MdnQS6lLBXpGQ213+Dq6XlYU4aMWZoVo4byiHCMN6OB2fxsGK
 rguHYhskn460QmogScOJkHjkLhJ9PSg0yggI8BIB88PWnMCL75q3CpEWX7nYzmTCf0km
 o2Xb+sGeDDCM8+w8qcdLGNhNlJru2eJCRAujS5d45002qxd3/krbgxYjdSJUBL+Y7xRz
 UAqA==
X-Gm-Message-State: AOJu0Yych8pukc2D+G3eLXUziCt8H8vjxtVkI3LSauXMeaOxh5MK1lAW
 zuyLgCGUPLOflk1Gf1BK9tg3Opi6eGD8tg==
X-Google-Smtp-Source: AGHT+IGClyiFwkPSF3jeHox3DxpqMwTGrl5lfTNJt/kx+V42xAaxU0Wb2kxE+/p+ICDkUOF6SDlbTw==
X-Received: by 2002:a50:cbcc:0:b0:54c:d2:ea39 with SMTP id
 l12-20020a50cbcc000000b0054c00d2ea39mr11638269edi.18.1703171284259; 
 Thu, 21 Dec 2023 07:08:04 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 02/11] hw/block/fdc-sysbus: Move iomem from FDCtrl to
 FDCtrlSysBus
Date: Thu, 21 Dec 2023 16:07:41 +0100
Message-ID: <20231221150750.5435-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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


