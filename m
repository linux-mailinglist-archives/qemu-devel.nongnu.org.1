Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D4798450
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:43:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4v-00036L-1p; Fri, 08 Sep 2023 04:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4q-0002oF-0Y
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4n-0004s5-BY
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1730216f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162571; x=1694767371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwdJ/CG9aYGX/GjFQP7CsHIbxXH0gsEEQc7AQMYTlTo=;
 b=JM423RDzwolM3JHL47xaHWGh+CRN3KzV5+rghFbfywQEvUvbKvyWFzEMZbZxHIk2Ld
 qzX7C+se6xPiBLLPl5e5NrxEgPMD/4nJC/cJKYxiF9L/ItkORGfIgZDvdcLxlyL03lUu
 vQlZ4PA3L9yh7gdIe2gMEAJDBw4bmdNy28ZaHME0rY65ESZiefIKp4uqzutqH+RtxED3
 rbCdw/fUMBsKEGJ2u54cM1pnntwLlYcyhECzGHFlMAJPeaWalrnYEXMOMbox7wFn9fEt
 Ygae0LGntqAeLAmoXT12Hg7b3mYetqzrryzFle4r3B7icn0OcYKk0IQQqa+gxuw7wMkD
 nHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162571; x=1694767371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwdJ/CG9aYGX/GjFQP7CsHIbxXH0gsEEQc7AQMYTlTo=;
 b=A7T2NSsSYo3jdCOkayNh4zFrXGyzgJn3Gdf+9FxklrvfsOO2AJg7amI1WVSKk1WUY+
 P2XiTdWfowGsNlo6C4jdPxq2LY/L6RH0l5hbxPTj0/9TI0XN4LHHBKuzyq7zP8OHGFNh
 YMFMQIkZRdkH5lmHfzQQ1h/2FkfGOq8COckrH+EjG2HhHdAyzY0rgtCto4UmCAK3tVhb
 VygK9UnScf/WeuhO85g7rDg6AKXar91vUdOe2IDGIjZgupCk9LOaq6qHfH8SluKHiiDl
 UhcUFeeYGRojD0cyfngpTtlYtC9b/HtiMX8G9mY+aLS5gW4KDGRNeuRUFLxuBwNX4S31
 tdyg==
X-Gm-Message-State: AOJu0Yy2+tBKVY7oOwtudJqUNSNp9DMosn7M31veIKqhJYRbwhDjBy0r
 NWPupgyI9TzojTezym18DAs5/lQhOb4=
X-Google-Smtp-Source: AGHT+IEYzG7PFC9PUxqQPffFxzF/Xq18TF/XUGGhD3Cj14rWYlX2OI1+0Wq+JmRsSrIwF6//RBIo+w==
X-Received: by 2002:adf:de0f:0:b0:317:43de:4c0a with SMTP id
 b15-20020adfde0f000000b0031743de4c0amr1255506wrm.20.1694162571548; 
 Fri, 08 Sep 2023 01:42:51 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 7/8] hw/acpi: Trace GPE access in all device models,
 not just PIIX4
Date: Fri,  8 Sep 2023 10:42:33 +0200
Message-ID: <20230908084234.17642-8-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/core.c       | 5 +++++
 hw/acpi/piix4.c      | 3 ---
 hw/acpi/trace-events | 8 ++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 00b1e79a30..c561845a4a 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -32,6 +32,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "sysemu/runstate.h"
+#include "trace.h"
 
 struct acpi_table_header {
     uint16_t _length;         /* our length, not actual part of the hdr */
@@ -686,6 +687,8 @@ void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val)
 {
     uint8_t *cur;
 
+    trace_acpi_gpe_ioport_writeb(addr, val);
+
     cur = acpi_gpe_ioport_get_ptr(ar, addr);
     if (addr < ar->gpe.len / 2) {
         /* GPE_STS */
@@ -709,6 +712,8 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
         val = *cur;
     }
 
+    trace_acpi_gpe_ioport_readb(addr, val);
+
     return val;
 }
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a7892c444c..dd523d2e4c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -42,7 +42,6 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
-#include "trace.h"
 #include "qom/object.h"
 
 #define GPE_BASE 0xafe0
@@ -517,7 +516,6 @@ static uint64_t gpe_readb(void *opaque, hwaddr addr, unsigned width)
     PIIX4PMState *s = opaque;
     uint32_t val = acpi_gpe_ioport_readb(&s->ar, addr);
 
-    trace_piix4_gpe_readb(addr, width, val);
     return val;
 }
 
@@ -526,7 +524,6 @@ static void gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
 {
     PIIX4PMState *s = opaque;
 
-    trace_piix4_gpe_writeb(addr, width, val);
     acpi_gpe_ioport_writeb(&s->ar, addr, val);
     acpi_update_sci(&s->ar, s->irq);
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 78e0a8670e..159937ddb9 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -17,6 +17,10 @@ mhp_acpi_clear_remove_evt(uint32_t slot) "slot[0x%"PRIx32"] clear remove event"
 mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
 mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
 
+# core.c
+acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
+acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+
 # cpu.c
 cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0x%"PRIx32"] flags: 0x%"PRIx8
@@ -48,10 +52,6 @@ acpi_pci_sel_read(uint32_t val) "%" PRIu32
 acpi_pci_ej_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
 acpi_pci_sel_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
 
-# piix4.c
-piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
-piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
-
 # tco.c
 tco_timer_reload(int ticks, int msec) "ticks=%d (%d ms)"
 tco_timer_expired(int timeouts_no, bool strap, bool no_reboot) "timeouts_no=%d no_reboot=%d/%d"
-- 
2.42.0


