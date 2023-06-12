Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D772B9FA
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8cfk-0001E9-K3; Mon, 12 Jun 2023 04:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfV-00015Z-I8; Mon, 12 Jun 2023 04:12:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfT-0002QB-4m; Mon, 12 Jun 2023 04:12:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51478f6106cso7210393a12.1; 
 Mon, 12 Jun 2023 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686557568; x=1689149568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1BT4rBX3xCABC2uJOGUB23DsZLkbQxhm1QQVG+FZuA=;
 b=SnKqI8bKvgXTOazBeGJs/uddGDJPFpfUZwUoC4ITobwrZn1+0eh1IX4B7Ad0SiPjSt
 sqKslbr7TkZA34svFpNp76Zz/TO6mzkqN7gLpVziRmrCv/tnkU1K/klBkdLsaHMSJLTX
 WuBctNIH6uU+VR/IT3T/zye8veCQl7aR+BDpIUFR7O4mRedkEEX3zc6xKklg2isZ0e32
 Qpr1TxJ0bMI8a1LWna7ooBuUNDqbBNiNUIzBrLvk1gfHWL40TFQzyilS4DDbjyRWBqVK
 ULCstAJvIfI+f59n5Dzf3zmy1a8CzYQKqCxnaP7M2+Vqah6ZGLrm8P7uKFgDeNeW6IuR
 aKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686557568; x=1689149568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1BT4rBX3xCABC2uJOGUB23DsZLkbQxhm1QQVG+FZuA=;
 b=Nx7GSpDWkRdYOTQMQGelpImWby55/zGQi32p4ptRI0c6gaYANkhLM0pSkuPZ2u+VUd
 Leh8o+GGHrFBmQWdic3Da3gz9AaHZkmRlNHfTiWXQHXe0Kfj0OH8CKA8Ig78tJx0Q7uk
 S43srHuB+8OVdG0Kt6wl5iocoXgHuKLOTzwyLBH96lLBaC2tLTfc8n927L23ugRW7sZy
 jbYLxMmUBmKgIoD3hWa0GmOlz2tv6RIliCa/gbwxVyFDijZkeGVsMrIfVpG6QQqfGZ8a
 81LIIV54QEPY3/XyXVsqRud2PcJD8oEjiF4WnRRomhBZc1A+/r14skc9WQgPIbScRIc5
 /XWQ==
X-Gm-Message-State: AC+VfDwp75nfkFm+ZG+R+FA+Ji0Qnlbs9UEXdPtCV/sTGz2Vc8JCY6Dp
 ivfcUkE6dDc67vGncTV3+ya9bD7vINs=
X-Google-Smtp-Source: ACHHUZ4DzdywxmsXyA7cg0R4AIhG8QPtJuKWPZLXDtM81fHQqE2EB0TfK7uihJK5TcLI+h9B86LzkA==
X-Received: by 2002:aa7:d804:0:b0:514:91bd:a967 with SMTP id
 v4-20020aa7d804000000b0051491bda967mr4104252edq.9.1686557568210; 
 Mon, 12 Jun 2023 01:12:48 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7f9.dynamic.kabel-deutschland.de.
 [95.91.215.249]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa7d617000000b005148e981bd3sm4678514edr.12.2023.06.12.01.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 01:12:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/2] hw/char/parallel: Export struct ParallelState
Date: Mon, 12 Jun 2023 10:12:37 +0200
Message-ID: <20230612081238.1742-2-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612081238.1742-1-shentey@gmail.com>
References: <20230612081238.1742-1-shentey@gmail.com>
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

Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL to be
performed in the next patch.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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


