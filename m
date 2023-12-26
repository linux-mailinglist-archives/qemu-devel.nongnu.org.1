Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D112981E650
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3g5-0001an-7P; Tue, 26 Dec 2023 04:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fr-0001Hp-UT
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fq-0008Hn-3Y
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbBeyS/80jftVPd7Ma4Yal4/KK1d/JdRq54dZwI1a6k=;
 b=iQeUJrkjSvpsIcxLG9UFfsW9bWHpDk+e7d5MJbTLoMYbK34w2Cwjr+Gt4oOyOoGjUsYPE9
 LNKn66+TQQCaqjBdXon75eEwihOCKwYwn8o8a0lPItiqtX6ATwr03RdF+AJGfaIEr2y33k
 tLkxeV/QHePAyBhirqBpJxi5kvJYDqM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-ZRW6f9M0NHWf5saJnyu16w-1; Tue, 26 Dec 2023 04:24:27 -0500
X-MC-Unique: ZRW6f9M0NHWf5saJnyu16w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3367e2bd8b0so3195232f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582664; x=1704187464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbBeyS/80jftVPd7Ma4Yal4/KK1d/JdRq54dZwI1a6k=;
 b=docJLF/fvIhA7hwKW4QvlmpX89ZXabVh8XQpbh+WGWHmiF/cjcNXC2KKl7wGnOrbbf
 g6eAHlGv+jiJz1LdWtVX2Bn045cwqFDs2Z2C2ZauUkyJvPxgYrSI2DWU5lx65IjxR/Ht
 AN0pIGXS9VlLIAv3vOqIwycvLj8FrjndlVwiUzIqqf+g4yBFi9tR93dyhInUAKcXerTB
 a2yvpV6ziTSgdmo85BNaqA9kU26tjvfjdSpZ20Ra4VAJsOcmRQc3CC24j8RO7Jh+xv3y
 tvD8AKPQjPkYB1OT/nyxn2T4ph0Pdhzp1wCA6g4Zk+2bJvnZFyWRsKfECporDdoY2ete
 oTxw==
X-Gm-Message-State: AOJu0YzKX2/HZCHetVfq+BFzz24IV4dwKm/JwudLfcityfgRpY8hgsMs
 Mli2g4/SiEStH5I0Hwh/y4/ClAkzCfHfzHvOaZGDzcUrht3lmHr5IxEuY4Ea2/wIpjQkdiNpE1w
 rinl+CTqRCgR5whJ1p+OTe69z1mWlo5l1IUUdL+swc4p4+QZnpvyGdt81bxPtly1aWnShWUd2q+
 dW
X-Received: by 2002:a5d:6a4d:0:b0:336:d4b8:e3f7 with SMTP id
 t13-20020a5d6a4d000000b00336d4b8e3f7mr779272wrw.4.1703582664605; 
 Tue, 26 Dec 2023 01:24:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk62Q93TprXu0PLDyr/W74FGCe2O28dhpbUFJlretpVvf/RIikEzHzEdfm0bv1FNfc9xVbxA==
X-Received: by 2002:a5d:6a4d:0:b0:336:d4b8:e3f7 with SMTP id
 t13-20020a5d6a4d000000b00336d4b8e3f7mr779264wrw.4.1703582664315; 
 Tue, 26 Dec 2023 01:24:24 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 c10-20020adffb0a000000b00336d21e40f7sm2123692wrr.103.2023.12.26.01.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:22 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aaron Young <Aaron.Young@oracle.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 05/21] hw/acpi: propagate vcpu hotplug after switch to modern
 interface
Message-ID: <45e48809d3d0328fd2f113b878a62a27f1360664.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Aaron Young <Aaron.Young@oracle.com>

If a vcpu with an apic-id that is not supported by the legacy
interface (>255) is hot-plugged, the legacy code will dynamically switch
to the modern interface. However, the hotplug event is not forwarded to
the new interface resulting in the vcpu not being fully/properly added
to the machine config. This BUG is evidenced by OVMF when it
it attempts to count the vcpus and reports an inconsistent vcpu count
reported by the fw_cfg interface and the modern hotpug interface.

Fix is to propagate the hotplug event after making the switch from
the legacy interface to the modern interface.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Aaron Young <aaron.young@oracle.com>
Message-Id: <0e8a9baebbb29f2a6c87fd08e43dc2ac4019759a.1702398644.git.Aaron.Young@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cpu_hotplug.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 634bbecb31..6f78db0ccb 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -59,7 +59,8 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
     },
 };
 
-static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
+static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
+                                     bool *swtchd_to_modern)
 {
     CPUClass *k = CPU_GET_CLASS(cpu);
     int64_t cpu_id;
@@ -68,23 +69,34 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
     if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
         object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
+        *swtchd_to_modern = true;
         return;
     }
 
+    *swtchd_to_modern = false;
     g->sts[cpu_id / 8] |= (1 << (cpu_id % 8));
 }
 
 void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
 {
-    acpi_set_cpu_present_bit(g, CPU(dev));
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    bool swtchd_to_modern;
+    Error *local_err = NULL;
+
+    acpi_set_cpu_present_bit(g, CPU(dev), &swtchd_to_modern);
+    if (swtchd_to_modern) {
+        /* propagate the hotplug to the modern interface */
+        hotplug_handler_plug(hotplug_dev, dev, &local_err);
+    } else {
+        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    }
 }
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
                                   AcpiCpuHotplug *gpe_cpu, uint16_t base)
 {
     CPUState *cpu;
+    bool swtchd_to_modern;
 
     memory_region_init_io(&gpe_cpu->io, owner, &AcpiCpuHotplug_ops,
                           gpe_cpu, "acpi-cpu-hotplug", ACPI_GPE_PROC_LEN);
@@ -92,7 +104,7 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     gpe_cpu->device = owner;
 
     CPU_FOREACH(cpu) {
-        acpi_set_cpu_present_bit(gpe_cpu, cpu);
+        acpi_set_cpu_present_bit(gpe_cpu, cpu, &swtchd_to_modern);
     }
 }
 
-- 
MST


