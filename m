Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1B72B180
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 13:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IoF-0003OD-IC; Sun, 11 Jun 2023 07:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Io1-0003NA-PV; Sun, 11 Jun 2023 07:00:21 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Inz-0004gT-MR; Sun, 11 Jun 2023 07:00:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-977d0288fd2so564095366b.1; 
 Sun, 11 Jun 2023 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686481217; x=1689073217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lP6Prelty62y4Mk9vT4TyO/sraxho74ak0s6TtJPBhs=;
 b=JZPgabILrwiUU7r2NIYdtf+Jzhrmz8IU6cvgaKiX/JKDOf2nx/DgOVQvHZ64iaZsQY
 NE/PEmdE+O/FlBqI6eMGzpRZxs2glFsg2faDUV5UksIezqQENPm/5AYixLJqHWX8WDvW
 wxxEWxiB8Ilc89f0knXamz8F3x4ToQLHu1ZYnC/syo2MkPRfQJj8lgCR6J3mrAKwSyV3
 A4/ZN2HoiUEIs4ZZdpN2reM0AObPXViAVMgJbO8treWQu2YZvOJWpLERhv9pXahWw+OM
 ZPyvKZd0uTWzAkCVqKmmLQM5nWK5AV8ta9pepIiSVJXSCAtGehbEyyffAzIiI0uCnlwv
 ZuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686481217; x=1689073217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lP6Prelty62y4Mk9vT4TyO/sraxho74ak0s6TtJPBhs=;
 b=Hi8X2B/JfGBaVm9Xq4fycdAPWwfSeDRUvC5M+Nes483C28HPLoUahMyQIEpUEyO72J
 KPu3gOyIEh8ml5B3fBNVideet0JNtoAF4DKxm1sX5pWQs34W78lupUwuRkQ4NrHGy7eq
 FTHMPiblU4pPdP+TOIZrYW9aGSe4zVcQ6Nyzmukt0PrJbPbR896jmReSUSAeDnPdOYHI
 2Cc/Qre8n6MatY4a7MxsYtl5nwCaffjIIZ9PDoKSgvAyZDf8hoe1+BeoxBNzXKkOkL6L
 yRmOO1+T2+VK9zsccWJYTGORSpTjKye9jgVSa9AdHJPbTAat0GN9cm0QpQ0hlsUwoK/I
 8TqA==
X-Gm-Message-State: AC+VfDy4/iQAMqMO3pkSXltjFX/rjGhNufYmbOg+5Z2HSzC3aZFiGcSM
 /hxcPV3CukOFe21OlmLKt4z/gPi5pZg=
X-Google-Smtp-Source: ACHHUZ6vPtOdP23k45QVw3f7sebg9qWW9Lo1E/YQyt0yKaVJay8y/BEhhUFfVXq9lAhUyhoosWbJYw==
X-Received: by 2002:a17:906:99c1:b0:973:ca9c:3e43 with SMTP id
 s1-20020a17090699c100b00973ca9c3e43mr7738166ejn.45.1686481217325; 
 Sun, 11 Jun 2023 04:00:17 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 n11-20020a1709062bcb00b00977eec7b7e8sm3708411ejg.68.2023.06.11.04.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 04:00:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] hw/char/parallel: Export struct ParallelState
Date: Sun, 11 Jun 2023 13:00:07 +0200
Message-ID: <20230611110008.32638-2-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611110008.32638-1-shentey@gmail.com>
References: <20230611110008.32638-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL to be
performed in the next patch.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/char/parallel.h | 21 +++++++++++++++++++++
 hw/char/parallel.c         | 20 --------------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 29d2876d00..9f76edca81 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,9 +1,30 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
+#include "exec/ioport.h"
+#include "exec/memory.h"
 #include "hw/isa/isa.h"
+#include "hw/irq.h"
+#include "chardev/char-fe.h"
 #include "chardev/char.h"
 
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
 #define TYPE_ISA_PARALLEL "isa-parallel"
 
 void parallel_hds_isa_init(ISABus *bus, int n);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 3d32589bb3..e75fc5019d 100644
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
@@ -76,23 +73,6 @@
 
 #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
 
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
 OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
 
 struct ISAParallelState {
-- 
2.41.0


