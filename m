Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB97B7AD8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:56:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxXR-0001V2-8Q; Wed, 04 Oct 2023 04:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVv-0008H3-Uo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVm-0002L9-Vk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-1sQcCt-dPeCjzvkpRwF2TA-1; Wed, 04 Oct 2023 04:45:31 -0400
X-MC-Unique: 1sQcCt-dPeCjzvkpRwF2TA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-323334992fbso1380596f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409129; x=1697013929;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AyBHZxgcznnd088YayNhukDWH1TlGZpm/MILwePdz9Q=;
 b=Q2D9HD8DcW3Y4l1Q8QEEUg+i/LNn4Ud7J6VLZT+N9jrenpZJdol33rbzdsDR1+xkFy
 FyBVdL+tIX35RmvOLp/N1rPbY/Z2kAkymfkLFhwM1Wsl0PguyWUI1lxvIRJqUt/YaJT1
 1M832/bcW9oNwrbRlOAgRzes9t/7e4DUVeINd+9M95/czCD0uX3Ivhw8xwWhS/hW8uAF
 7Q8Rsdkck9PtneRswFHW1ES40jCwyo63AYDo3l2ctJMOthFbupcJCdjQFWoabmR/Nox3
 D4kOKIcjP+HC1Yx5lVFrsBKBuVKyPEUUIRNnUbF5uV6a1u8Ot+PQBBc9ePyXvyFjGaQZ
 4iNw==
X-Gm-Message-State: AOJu0Yy0mNbPlk6ZxLgP7jFnPH9zC6UVbKYN3iCcBkN8cGzv+xwdijWI
 HcBeP7Ao+PiFnMaBIECBePrpMDBvVivyeZCytj2R3Uu9J7AeA+lMUHxsjoRURN+RHtsG5tLjHLY
 +nam9tCM8oA06jU3Q3FmBhY0uEeyEILPXGHgqlJU4WM/ZwMI0lDPRbOtnZNZoiXDEaCxD
X-Received: by 2002:adf:e6c4:0:b0:319:841c:ae7a with SMTP id
 y4-20020adfe6c4000000b00319841cae7amr1762843wrm.41.1696409129626; 
 Wed, 04 Oct 2023 01:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2iJTRstpyaQJZVubn0+7EkATnsELvqTnomrdcd5KlrKl6AcAmVcZFVGDqNMycvtzfvhAdqA==
X-Received: by 2002:adf:e6c4:0:b0:319:841c:ae7a with SMTP id
 y4-20020adfe6c4000000b00319841cae7amr1762825wrm.41.1696409129375; 
 Wed, 04 Oct 2023 01:45:29 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 x2-20020a5d4442000000b003179b3fd837sm3454723wrr.33.2023.10.04.01.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:28 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 42/63] hw/acpi/core: Trace enable and status registers of GPE
 separately
Message-ID: <12741ddcda3514ee99f8296009f41d8716047d04.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

The bit positions of both registers are related. Tracing the registers
independently results in the same offsets across these registers which
eases debugging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-9-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/core.c       | 10 +++++++---
 hw/acpi/trace-events |  6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index c561845a4a..ec5e127d17 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -687,13 +687,13 @@ void acpi_gpe_ioport_writeb(ACPIREGS *ar, uint32_t addr, uint32_t val)
 {
     uint8_t *cur;
 
-    trace_acpi_gpe_ioport_writeb(addr, val);
-
     cur = acpi_gpe_ioport_get_ptr(ar, addr);
     if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_writeb(addr, val);
         /* GPE_STS */
         *cur = (*cur) & ~val;
     } else if (addr < ar->gpe.len) {
+        trace_acpi_gpe_en_ioport_writeb(addr - (ar->gpe.len / 2), val);
         /* GPE_EN */
         *cur = val;
     } else {
@@ -712,7 +712,11 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
         val = *cur;
     }
 
-    trace_acpi_gpe_ioport_readb(addr, val);
+    if (addr < ar->gpe.len / 2) {
+        trace_acpi_gpe_sts_ioport_readb(addr, val);
+    } else {
+        trace_acpi_gpe_en_ioport_readb(addr - (ar->gpe.len / 2), val);
+    }
 
     return val;
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 159937ddb9..edc93e703c 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -18,8 +18,10 @@ mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
 mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
 
 # core.c
-acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
-acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
+acpi_gpe_en_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_en_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
+acpi_gpe_sts_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%02" PRIx8
+acpi_gpe_sts_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%02" PRIx8
 
 # cpu.c
 cpuhp_acpi_invalid_idx_selected(uint32_t idx) "0x%"PRIx32
-- 
MST


