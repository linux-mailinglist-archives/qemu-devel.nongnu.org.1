Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E481BA38
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKeg-00086l-TD; Thu, 21 Dec 2023 10:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKee-00086T-OJ; Thu, 21 Dec 2023 10:08:08 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKed-0004Ie-2g; Thu, 21 Dec 2023 10:08:08 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c79968ffbso981271a12.3; 
 Thu, 21 Dec 2023 07:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171282; x=1703776082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6QSb1FgBHOx15gmSAz7A8OR4SzZo63fPyAah9GqvLw=;
 b=lD7jz4DIaRHiNlDCt3JaMxvtHCkm5jNgaaCZWhyKIbxCi3hdG9oyTRM9pjdY1E3ryK
 vQ7bUnZo25bBOXl1Lh6O3qU5SaK0RFKp1p9lZCZclrAs/Q/53dlF1CttYduQLbXuRRq6
 aXvGWCj/ZJGoI7zB0uR2yKqkDvAlyyok+BcjtVWzCCH7konWikGatDvtoRJyhul0p+4p
 +eycGtZRPUeUsGNwBOpjfZVQtvfZpqezFtL8pM4G2cy4KeH/t1w9YhlgaW7h0eqK3OTw
 VCHVevZ2MqbH1hBochgRnqLYRSjBVSqjiQlcUcgibrH5d/p9FoZigUoy8PuSrpNTEQ3n
 pbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171282; x=1703776082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6QSb1FgBHOx15gmSAz7A8OR4SzZo63fPyAah9GqvLw=;
 b=SwDhBfXs30MO6jDyHafOl0EtBD2p/DTpK4oCY3eVXPKLwCk2qBeZqYLvYESTqhiBQW
 Rlyz1qW+atReFwiqg50oknJIGGXXK3LqmT3Z6tgVamzBIWUuaIscnq0yT7qC9rYVw6F0
 ZwrZoLApkNh8aB1wrF/DKN9coQgHx0WiAfLR0vJ6GzY2/xl8WqvsFC+uRQFNDkZbW6+p
 ZqdqnHy+TOJK6ndZNAqHmtT44NJI+okPIpsDsp5QlmamZYMZXv6loDKDZRDOfFXVO7t0
 QjT3xYKgY8udY+7ciD4Yh9bzLUCpMQ1Z3ZiHfpX0jOcGZ3QkVujK5CWZ+VWu+69beOJW
 vlPg==
X-Gm-Message-State: AOJu0YxN6ngY7/e/zvYZgKS1HlJ9sUe1L0dDQd1PYlWQCO0Bo9YkQ/4n
 +qDwJADO7BbDOBCWqggVgowx7ogTYoBcGA==
X-Google-Smtp-Source: AGHT+IGWuFbrYOPgfFxBwRFob9N5D3BMeQyNU0f2nZ4lzWnQtDD1OrW9DyvgT4cVrDlEoFPmlEWG3A==
X-Received: by 2002:a50:871a:0:b0:553:ca52:3fb3 with SMTP id
 i26-20020a50871a000000b00553ca523fb3mr1695176edb.42.1703171282583; 
 Thu, 21 Dec 2023 07:08:02 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:01 -0800 (PST)
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
Subject: [PATCH v3 01/11] hw/block/fdc-isa: Move portio_list from FDCtrl to
 FDCtrlISABus
Date: Thu, 21 Dec 2023 16:07:40 +0100
Message-ID: <20231221150750.5435-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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


