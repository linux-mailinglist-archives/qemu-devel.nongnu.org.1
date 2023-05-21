Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A971770AE13
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iDX-00025m-2P; Sun, 21 May 2023 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDP-0001ww-3j; Sun, 21 May 2023 08:31:11 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDJ-0001l6-Dp; Sun, 21 May 2023 08:31:10 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-94a342f7c4cso945924266b.0; 
 Sun, 21 May 2023 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684672262; x=1687264262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCbv0UcSqF4ar26VgNDIWvOon/JFFKQ9y3nbL6W/zoY=;
 b=h9iVW4UMjUWmN7BNg9jx1lZ4f8mkdovsMysXv3X3HhCgSNgFHiJ3Ek8SLUjugVVnDP
 1/0BT2xucjJhheaggwcgUzcTJNLB+yPOCTpXxaXC53eN4ePcfrcoC017YTjq/U5qh6/V
 tvyNysz9Wb1K3khVHdfE9hpFdptZrDmHW1lBUHpzOlUTJUFEuC6YDKhnjKHmD+o3zyWM
 0HiEvioXJ0EuUJ4a12jTZvMrkD8w7N4DCd4Yk+irWfGv0n3O9ydhRJ3sRfOIvYt1jm5t
 tzbhLcwEnMadvVAlrocbRx8EY/0hC23yodWDAVSKCBLyKOOdZIN8NJDrzdUC3Hco16B9
 FoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684672262; x=1687264262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCbv0UcSqF4ar26VgNDIWvOon/JFFKQ9y3nbL6W/zoY=;
 b=f/AwImU7qzn8N42dCSdWzTXCXHbBgt4xeU7qFRkvuPFBqqzoLTOMpQNvOGQ0Ogm1zJ
 H5NiJdPe661UvzYPA4gF8y3o/XgHg/bXTRrkRPDy8vJxZeI2tbNs63wh8RSUpKmXNIrd
 iBgb6vsNq1vj5et9apambAXddlYqrwMbQaM9Nwo0rjQ/v0kkMnAdfi8jVj2TIHcHXj2x
 IBfCh+gEvjhQBtubKWBoSPBeucAE/BioJi0Plzo8D1yNUusSAYaMuJgFycJ2YC6aDZkb
 /1L5m9ATPuXpykK6e6BJxIuc0GLEf7KR3prxsCPfm/nd3YAMnFHTt3Zt5ViVOUbe05Ix
 QC0Q==
X-Gm-Message-State: AC+VfDyT5gKMjKG0HNur8x5Jew1noRVolWE9xu+7f2F09Q6/rOwPRpkQ
 /J5T01mj8b4IFB/Q/xzcVQAlF69yHSM=
X-Google-Smtp-Source: ACHHUZ6Yn6d9XAGBlF36u0KErwaCK4NlVPSjEL0cJMeahuP2oUPqdl+HQpSEpPXswb1u1o9vcvXs2Q==
X-Received: by 2002:a17:907:9348:b0:94f:3980:bf91 with SMTP id
 bv8-20020a170907934800b0094f3980bf91mr7917315ejc.19.1684672262502; 
 Sun, 21 May 2023 05:31:02 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906729300b00965ec1faf27sm1882678ejl.74.2023.05.21.05.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 05:31:02 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 4/6] hw/char/parallel: Export ParallelState
Date: Sun, 21 May 2023 14:30:47 +0200
Message-Id: <20230521123049.312349-5-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521123049.312349-1-shentey@gmail.com>
References: <20230521123049.312349-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/char/parallel.h | 44 ++++++++++++++++++++++++++++++++++++++
 hw/char/parallel.c         | 42 ------------------------------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 0a23c0f57e..2d4907c1fe 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,9 +1,53 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
+#include "exec/ioport.h"
+#include "exec/memory.h"
 #include "hw/isa/isa.h"
+#include "hw/irq.h"
+#include "chardev/char-fe.h"
 #include "chardev/char.h"
 
+/*
+ * These are the definitions for the Printer Status Register
+ */
+#define PARA_STS_BUSY   0x80    /* Busy complement */
+#define PARA_STS_ACK    0x40    /* Acknowledge */
+#define PARA_STS_PAPER  0x20    /* Out of paper */
+#define PARA_STS_ONLINE 0x10    /* Online */
+#define PARA_STS_ERROR  0x08    /* Error complement */
+#define PARA_STS_TMOUT  0x01    /* EPP timeout */
+
+/*
+ * These are the definitions for the Printer Control Register
+ */
+#define PARA_CTR_DIR    0x20    /* Direction (1=read, 0=write) */
+#define PARA_CTR_INTEN  0x10    /* IRQ Enable */
+#define PARA_CTR_SELECT 0x08    /* Select In complement */
+#define PARA_CTR_INIT   0x04    /* Initialize Printer complement */
+#define PARA_CTR_AUTOLF 0x02    /* Auto linefeed complement */
+#define PARA_CTR_STROBE 0x01    /* Strobe complement */
+
+#define PARA_CTR_SIGNAL (PARA_CTR_SELECT | PARA_CTR_INIT | PARA_CTR_AUTOLF \
+                         | PARA_CTR_STROBE)
+
+typedef struct ParallelState {
+    MemoryRegion iomem;
+    uint8_t dataw;
+    uint8_t datar;
+    uint8_t status;
+    uint8_t control;
+    qemu_irq irq;
+    int irq_pending;
+    CharBackend chr;
+    int hw_driver;
+    int epp_timeout;
+    uint32_t last_read_offset; /* For debugging */
+    /* Memory-mapped interface */
+    int it_shift;
+    PortioList portio_list;
+} ParallelState;
+
 void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index af551e7864..522301f43a 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -27,10 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "chardev/char-parallel.h"
-#include "chardev/char-fe.h"
 #include "hw/acpi/acpi_aml_interface.h"
-#include "hw/irq.h"
-#include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
@@ -54,45 +51,6 @@
 #define PARA_REG_EPP_ADDR 3
 #define PARA_REG_EPP_DATA 4
 
-/*
- * These are the definitions for the Printer Status Register
- */
-#define PARA_STS_BUSY   0x80    /* Busy complement */
-#define PARA_STS_ACK    0x40    /* Acknowledge */
-#define PARA_STS_PAPER  0x20    /* Out of paper */
-#define PARA_STS_ONLINE 0x10    /* Online */
-#define PARA_STS_ERROR  0x08    /* Error complement */
-#define PARA_STS_TMOUT  0x01    /* EPP timeout */
-
-/*
- * These are the definitions for the Printer Control Register
- */
-#define PARA_CTR_DIR    0x20    /* Direction (1=read, 0=write) */
-#define PARA_CTR_INTEN  0x10    /* IRQ Enable */
-#define PARA_CTR_SELECT 0x08    /* Select In complement */
-#define PARA_CTR_INIT   0x04    /* Initialize Printer complement */
-#define PARA_CTR_AUTOLF 0x02    /* Auto linefeed complement */
-#define PARA_CTR_STROBE 0x01    /* Strobe complement */
-
-#define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
-
-typedef struct ParallelState {
-    MemoryRegion iomem;
-    uint8_t dataw;
-    uint8_t datar;
-    uint8_t status;
-    uint8_t control;
-    qemu_irq irq;
-    int irq_pending;
-    CharBackend chr;
-    int hw_driver;
-    int epp_timeout;
-    uint32_t last_read_offset; /* For debugging */
-    /* Memory-mapped interface */
-    int it_shift;
-    PortioList portio_list;
-} ParallelState;
-
 #define TYPE_ISA_PARALLEL "isa-parallel"
 OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
 
-- 
2.40.1


