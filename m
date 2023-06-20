Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0343973753E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhJJ-0000Tl-0A; Tue, 20 Jun 2023 15:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7o-0004c3-Tk
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:40 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7n-0006jF-DB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:40 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5707b429540so62321737b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281998; x=1689873998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bMCmETV5A3RE3Y5AD1rHTVY6vGqDtmQP66Im/JEggA=;
 b=gDFBR4RHmuOhFl0zAKSW/YdHa+4P3awfbEylJDwusaDIY85UFvDLY/tz68yUx65RBX
 R28q+pnm2RIUNWuMX0W3/mgO69hSHo3BFQP4vBuszuEtuXtXv9oazcjnZMrlhUKwm8X7
 yyIMv6fSasCsKWsbWRAj0B/dlQb1R3Vzx6ZKTvAzt5sBPhZPcc1tKDcNtjOlwLuss8k/
 4US8q4b3RE1J/8EYgFIrfFmQjcGDe/zdXmKeXB//ADqkVuINn7gpFl+7DSKGnOCjd+3h
 7ilSxeJu7N4TheFvtsrd7Y7MNA9vGkk7DQNGQ4ZCoH/iatDdzMoUABr7v68ARDKLWb2j
 evDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281998; x=1689873998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bMCmETV5A3RE3Y5AD1rHTVY6vGqDtmQP66Im/JEggA=;
 b=GYBt4d5LSUzQ7APVW4YEdiTEfjvNDXY/1xUe7gcGKH6W38HW4cvnUB9tlfZq3XwuyW
 PAdO5QxUQH9geREmBVlS//FNMipPLaCSOYRbbVfGnYniogqZtrm8WD/bolqWjZxisa/1
 EKg8JBU3gdHuWdeXA+R8TNYc24ADczR8t8LBWid8uypt7KfDbT8YsFSuuVQYwy/r0pl5
 cb5hxi/1Am+Q3XgHWIWVr9ZyB++sEky9sVn+TBY6/xXtsxyAXS7Ccsz4Q01mXJnolDXc
 M2ARrNhfflnC9YirTyGCE2yzoFtAzN1f4ipA7k1JOkq40Y1xMdbn+tALuvbXDGmMk6e5
 nTYA==
X-Gm-Message-State: AC+VfDyaX21nwDwVdvxUnpU1VoAcY2c4CCSP1Si+txlR2QFA46oPrTwF
 dp4EK/tQyInTzHb1m5nrH/kbCkDDOpWn/w==
X-Google-Smtp-Source: ACHHUZ7cU55hy5Cb37BJ9iPrgAmJK5V5Rqisz43YU2ciSAZoqwyKKwB4+WRqY0bOxGK9i+BEe6e6MQ==
X-Received: by 2002:a0d:d947:0:b0:56c:fd14:a6f2 with SMTP id
 b68-20020a0dd947000000b0056cfd14a6f2mr15247962ywe.8.1687281998081; 
 Tue, 20 Jun 2023 10:26:38 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:37 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 23/23] s3 support: enabling s3 with q35
Date: Tue, 20 Jun 2023 13:24:57 -0400
Message-Id: <109921db6ea7bfbb46130cbd3734f41068d38fe5.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

Resetting pci devices after s3 causes guest freezes, as xen usually
likes to handle resetting devices.


Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/acpi/ich9.c    | 12 ++++++++----
 hw/pci-host/q35.c |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 1c236be1c7..234706a191 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -143,7 +143,8 @@ static int ich9_pm_post_load(void *opaque, int version_id)
 {
     ICH9LPCPMRegs *pm = opaque;
     uint32_t pm_io_base = pm->pm_io_base;
-    pm->pm_io_base = 0;
+    if (!xen_enabled())
+        pm->pm_io_base = 0;
     ich9_pm_iospace_update(pm, pm_io_base);
     return 0;
 }
@@ -274,7 +275,10 @@ static void pm_reset(void *opaque)
     acpi_pm1_evt_reset(&pm->acpi_regs);
     acpi_pm1_cnt_reset(&pm->acpi_regs);
     acpi_pm_tmr_reset(&pm->acpi_regs);
-    acpi_gpe_reset(&pm->acpi_regs);
+    /* Noticed guest freezing in xen when this was reset after S3. */
+    if (!xen_enabled()) {
+        acpi_gpe_reset(&pm->acpi_regs);
+    }
 
     pm->smi_en = 0;
     if (!pm->smm_enabled) {
@@ -322,7 +326,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
         acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
 
-    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
+    if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge || xen_enabled()) {
         acpi_pcihp_init(OBJECT(lpc_pci),
                         &pm->acpi_pci_hotplug,
                         pci_get_bus(lpc_pci),
@@ -345,7 +349,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
-    if (pm->acpi_memory_hotplug.is_enabled) {
+    if (pm->acpi_memory_hotplug.is_enabled || xen_enabled()) {
         acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
                                  &pm->acpi_memory_hotplug,
                                  ACPI_MEMORY_HOTPLUG_BASE);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1fe4e5a5c9..5891839ce9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -580,7 +580,8 @@ static void mch_reset(DeviceState *qdev)
     d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
     d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
 
-    mch_update(mch);
+    if (!xen_enabled())
+        mch_update(mch);
 }
 
 static void mch_realize(PCIDevice *d, Error **errp)
-- 
2.34.1


