Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE2815FF1
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLY-0005Uo-7V; Sun, 17 Dec 2023 09:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLU-0005TX-Af; Sun, 17 Dec 2023 09:42:20 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLS-0003ML-OB; Sun, 17 Dec 2023 09:42:20 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55114c073b8so2612017a12.1; 
 Sun, 17 Dec 2023 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824136; x=1703428936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7s4/LcmfHKTeKgmtMjwtMN44iUEsLZ+FoJ9PwqvTqU=;
 b=fydCk1Idx62xOnH+HmBVOErN0OoupQP1vQ8DYgeF236EdJecW/Jj6TIixmUmni3QGj
 Ehhlx3q4qVKTs7i6OZ2SVAXfzKHsibX2rUcbTbBdYxouKV7a3jGBnlRT4HmUDo+h3ueL
 22gRh4ajQH0vAMDDAoFm9pRE4yPeRC8GxuNu9NFhROleNAl9sYICL9JLOnf5OCJDT2Cz
 23iM34hp+i8cx5cdUFZtXPzQUXdYh5kfgXL/typhwsFtFujULgOsmqBdg8XHkfv8mi3P
 tICtYeKTnt71iy0fmWpMS5rJrmgeR8tTg6ZNcrIj01u//52L5jIDtsPKb4pdwHve0te1
 pbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824136; x=1703428936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7s4/LcmfHKTeKgmtMjwtMN44iUEsLZ+FoJ9PwqvTqU=;
 b=jpQ+sSiYwqehQh1FSuDclQ72a6bin70eS+1rWRUU+hl0tdCvY42rkziJ2sb+uCgMY3
 AOvE6ZcdmpdpQVPE/MRpaae23UWFTKsCQQBzH5tsvWEtxLUscv6Gwclqk/3pFwBmmhw1
 JfZvmCnhOXFr7Zfx+XI9xWcAvzudwYbxyn9azjekByddVAMbkad13GEEwLG65bR/r7TC
 bzaGoGlzzjEclpP1WmSScHySGLs9/d0KRMltOfrnCPbbhMksak9OrEikfqAWxh8YXCko
 8kFvBdHGbTqusoaSIXE3EwBpClbr74SL2jcNBA2GJqvNj5tQUE+fHwtjYECa6nxNR+JZ
 v25g==
X-Gm-Message-State: AOJu0YwOpxyNx4qukJPQfmSOqXXhzMtPCVlvsrjDcnV8WasH8vgRjia8
 GHb0mjv62eicm/N0/F7gHJgd7n2IwME=
X-Google-Smtp-Source: AGHT+IFydhxEyGGWfVgeozALK8n6/hTn/rSiNZnFaKwSQgzLhKR4tBLykuQIGnrAQ3PcW3EKmrP5cA==
X-Received: by 2002:a17:906:c141:b0:a18:abad:195a with SMTP id
 dp1-20020a170906c14100b00a18abad195amr5599921ejc.47.1702824136044; 
 Sun, 17 Dec 2023 06:42:16 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:15 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/12] hw/block/fdc-isa: Expose struct FDCtrlISABus
Date: Sun, 17 Dec 2023 15:41:42 +0100
Message-ID: <20231217144148.15511-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
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

Exposing device structs in headers is encuraged by qdev guidelines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/block/fdc-isa.h | 15 +++++++++++++++
 hw/block/fdc-isa.c         | 17 -----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/hw/block/fdc-isa.h b/include/hw/block/fdc-isa.h
index 42abd001dd..965c749c96 100644
--- a/include/hw/block/fdc-isa.h
+++ b/include/hw/block/fdc-isa.h
@@ -3,9 +3,24 @@
 
 #include "exec/hwaddr.h"
 #include "qapi/qapi-types-block.h"
+#include "hw/block/fdc.h"
+#include "hw/isa/isa.h"
 
 #define TYPE_ISA_FDC "isa-fdc"
 
+OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
+
+struct FDCtrlISABus {
+    ISADevice parent_obj;
+
+    uint32_t iobase;
+    uint32_t irq;
+    uint32_t dma;
+    FDCtrl state;
+    int32_t bootindexA;
+    int32_t bootindexB;
+};
+
 void isa_fdc_init_drives(ISADevice *fdc, DriveInfo **fds);
 void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds);
 void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 7058d4118f..090dc03381 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -34,12 +34,10 @@
 #include "qemu/timer.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/irq.h"
-#include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
-#include "hw/block/fdc.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
@@ -49,21 +47,6 @@
 #include "trace.h"
 #include "qom/object.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
-
-struct FDCtrlISABus {
-    /*< private >*/
-    ISADevice parent_obj;
-    /*< public >*/
-
-    uint32_t iobase;
-    uint32_t irq;
-    uint32_t dma;
-    struct FDCtrl state;
-    int32_t bootindexA;
-    int32_t bootindexB;
-};
-
 static void fdctrl_external_reset_isa(DeviceState *d)
 {
     FDCtrlISABus *isa = ISA_FDC(d);
-- 
2.43.0


