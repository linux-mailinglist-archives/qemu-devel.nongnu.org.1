Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4C7B7AE9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXB-0000oo-Cg; Wed, 04 Oct 2023 04:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVi-00085D-28
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVb-0002Hb-Vf
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTXr5CWcV3lblSQfJBOfseEIqv48hvGb7/OS7uALRI4=;
 b=WjRcQkYWwciDIXrUTFnVtdlsW2hoJwWkVJN8MB/QE+Wwu/28nL95nzOXBrBWVPHsp2zY5G
 JqGN6cZDO8cjTFrX3FuWl5m4fzlxVdU3wnNporTRW3hbB5ORVcEPqtn5c8vW+Y5xJcULYy
 9qUXonGYN2HzIjWtc3VMy3y5/FKQ0PM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-fPMSFhefOQu3qVmhOEXeyw-1; Wed, 04 Oct 2023 04:45:28 -0400
X-MC-Unique: fPMSFhefOQu3qVmhOEXeyw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so12808935e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409126; x=1697013926;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTXr5CWcV3lblSQfJBOfseEIqv48hvGb7/OS7uALRI4=;
 b=VAhbSXbvQHa4+kRZXsYjeXxklQeoC/tG5QHxlzsiwBy6jzdSwZd0nSBZjFa1NYxKrQ
 wQ9nbXB5jxK1miah+uOye8ej1NG8ahDpCiFD9Ed6qEfSIeADetUvzqzLTTyq4aeNTg0H
 9wSXOOXKjoeAhpPnHfIhciMEzwcN7euix5lMXiuJLJRsaMxqStZQiv3HDzoao7p1krNO
 iI4jSswueboFez5je7El+Kj/4gLmfKTRMmnGYiz5MT0G7DO4f2sTBShbbsN5C/in67RQ
 P4qVi3FSXIpvzKCH9GgeDRz6QShBu2dhPyuxyYuECfcF99YFvllTbPHreLDGCf7dIh/j
 L3GA==
X-Gm-Message-State: AOJu0Yy+NHhEADcbMRkelrFeg/Oh1k1VvmF2JKV1Lu3usT6DXIsB9fEs
 iH1/Hq9ouMWK/BXAR8CSGPpQpvdf6QWPL0bFHs/ZJuUsdZ8/RmeSDgcQssbgWzgvcuzbHXptwo4
 t5vRUUgM3jnRCQmBBZCLIDtHhwqZdRZTlimVbmH+FYuGHiNWFaPXCPgklFK6KyETv4EeO
X-Received: by 2002:a7b:c394:0:b0:406:51a0:17fd with SMTP id
 s20-20020a7bc394000000b0040651a017fdmr1526226wmj.18.1696409126701; 
 Wed, 04 Oct 2023 01:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVy+RF9VKRTTwUY7J8hMsTGBlsvpsGrG/HV39Jml/TnxWxBO1b7KVRTIZbD9w+MewdwgiLLQ==
X-Received: by 2002:a7b:c394:0:b0:406:51a0:17fd with SMTP id
 s20-20020a7bc394000000b0040651a017fdmr1526202wmj.18.1696409126318; 
 Wed, 04 Oct 2023 01:45:26 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b004055858e7d8sm957969wmk.7.2023.10.04.01.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:25 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 41/63] hw/acpi: Trace GPE access in all device models, not
 just PIIX4
Message-ID: <25171d23fdaa8d2c335471f10ebcc2d15b3ec471.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


