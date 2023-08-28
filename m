Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7278A6A7
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWnd-0006a1-D2; Mon, 28 Aug 2023 03:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnZ-0006Wc-VN
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnX-0004Ju-Ke
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fefe898f76so28357535e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208189; x=1693812989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwdJ/CG9aYGX/GjFQP7CsHIbxXH0gsEEQc7AQMYTlTo=;
 b=A18Mt8X4Z/A7pW2dxHiRXcHJWZtN/iAN0g2YJxGgjQise5v/zjzUfPf/NzJxitML/c
 pDE4wm/9Yy9JXOJsibKOCPJPJrEoWhcneIMLpmxqC+RNyeJr6XIqMp4BrAVV30YGTJSL
 Dyvgfo6L5UGtSybG4grGw2v0J6x6GrL1/yC34Or5v29YxyffRbxGwFP44LHfRYyV/acS
 RC1RHpw5+pwVUukwsMa6zEtrDczQlDPG0K+elXI1n1N571nWtQSiiW3yEioA5zNRfCit
 elhIyd7NeBeBLCsyW/EoMLJfUh6Z3chiw7nTUf1KL55tLI6K6TJGrEX28eoRJOcpCkA1
 zFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208189; x=1693812989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwdJ/CG9aYGX/GjFQP7CsHIbxXH0gsEEQc7AQMYTlTo=;
 b=Ni1wHizGmlWMy1gA5c6M4PLpA39O7xNJOhELY54ZgYDPppCjytEaXRDx+G2EZFXqXM
 K86sYaPa0NZtwFmgSQ63zFdfDvmVF8Hki7OBSsgxjT0ku4/mllrfIxHD4HC6xY0LJJKC
 U7RO8pVLnuJ+UatHo2/CSEHPGp97XMHfS+JKOJySF94rRB6JD5s17pb2PbRrFIwQYiFl
 fnVy9FIYZDlwiLec/TDPxE2UEjYvG4kNQ5uc0ddSBgV2sl7J54Ssu7wHN1/NXUybgqPL
 YpSYp1lzab/zBbyIHIpmDKW3N6DS4Arr+LhOqBu3ct8zt+MUrvNccHr0jqF72HFQp9ab
 Heaw==
X-Gm-Message-State: AOJu0YzuSlKX37E5PEQqy1UcpLUDGnGvnw2yalhR8kpi7+/4fE2ruFau
 hiXn2cbF/8Yzfwdfehhj3WxRXk+YxJgkNg==
X-Google-Smtp-Source: AGHT+IFQXz2CHzmonS/LwWmukgSVpEhfMu6SDSS8LgjuH56X5CR6vIaZbQO4Yk/8JaSO397WzrgE9A==
X-Received: by 2002:a7b:c4c9:0:b0:3f6:9634:c8d6 with SMTP id
 g9-20020a7bc4c9000000b003f69634c8d6mr18962251wmk.18.1693208189131; 
 Mon, 28 Aug 2023 00:36:29 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 7/8] hw/acpi: Trace GPE access in all device models,
 not just PIIX4
Date: Mon, 28 Aug 2023 09:36:08 +0200
Message-ID: <20230828073609.5710-8-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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


