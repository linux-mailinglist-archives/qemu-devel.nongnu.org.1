Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A507B9A4D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFI9-0006le-Qt; Wed, 04 Oct 2023 23:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI3-0006eT-S0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFI1-0000K7-S9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTXr5CWcV3lblSQfJBOfseEIqv48hvGb7/OS7uALRI4=;
 b=OlkITIfyS+CEnqRRFoMdjfyITy49lPy0NcCJKEiq2048bM5/qSoxF9RifmLPYnIEYpgSEJ
 KOAs5GO5s4PE9VEU3KgmgumMqv6nzX4yEwM6oFaQr4dKutJ4vAIKB20E6u5PP2zLCsGGye
 k0VngGfoRE+8E2yenuJ0d+jg64WNfvo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-X7izp8rpMkm1-fbhkNbX7A-1; Wed, 04 Oct 2023 23:44:39 -0400
X-MC-Unique: X7izp8rpMkm1-fbhkNbX7A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so479281f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477477; x=1697082277;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uTXr5CWcV3lblSQfJBOfseEIqv48hvGb7/OS7uALRI4=;
 b=pBQj9yA1zviLkrsMO8ESum+vT6Isgb60FaXbvGrV4NGV+z62fX6grhw5RJgT/l5ang
 5GafBdlIRkG3BE0qkBz6TOrVLt4JmpvvFQ8GehnROVxPSKpSXwtCwtcWhSAgFbFhjXwA
 OgZ/FAaPDW3vVdwr+L0HNDbCg14yJ0YiujE+PGrvMqtqCGJKzC/oAyTbbPVcCrPsgtrv
 f+mIImbgxdoRsLBKrWXphgLsWJKk6K+zP416Q2rQcrVkTC2GdGiDWHnn3oV8FJGaav80
 z+WiQSXycAhMg4jmLqUILJqhCqg9r7hLioaaY/RY9DxOLhWfBHCs97rs/eHSBNw0YTsb
 mjTA==
X-Gm-Message-State: AOJu0YxC1AdpBHcvAcWjk7metrrxk0CmyjOtei3tggObDjwqgQaeWdhp
 40rY1X1HRBdJUZqICXHtG0OHJvjhcrj1KXfWYkcqgywxlYI2S3KHAxPqECAUCM982TXPfSGdqLH
 TcaIAJTOwIIArr0tC5pRqRRouhZL7fT/R4G/+8Io1mEeh9Pke/WiujdjsQ6CUT1A0oS5C
X-Received: by 2002:a5d:4d12:0:b0:31f:f9a9:a742 with SMTP id
 z18-20020a5d4d12000000b0031ff9a9a742mr3434182wrt.23.1696477477578; 
 Wed, 04 Oct 2023 20:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGL/DUi9P0Ul0u3NI297Pg52hs9zlcH9/y827Lrrr+o5Sp2AnrnzubcwVbWR5li2904L+Mww==
X-Received: by 2002:a5d:4d12:0:b0:31f:f9a9:a742 with SMTP id
 z18-20020a5d4d12000000b0031ff9a9a742mr3434170wrt.23.1696477477301; 
 Wed, 04 Oct 2023 20:44:37 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 d16-20020adff850000000b003232d122dbfsm623692wrq.66.2023.10.04.20.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:36 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v2 31/53] hw/acpi: Trace GPE access in all device models, not
 just PIIX4
Message-ID: <7f558ea58bb60257b111abac0424dc601ff54875.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


