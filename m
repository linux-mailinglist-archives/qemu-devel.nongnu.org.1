Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29D81E6B5
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:51:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI44S-0000WJ-Hb; Tue, 26 Dec 2023 04:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI44P-0000W0-Py
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:49:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI44O-0003hW-68
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703584191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbBeyS/80jftVPd7Ma4Yal4/KK1d/JdRq54dZwI1a6k=;
 b=fV3dc6VHVuDS0E64wiqETC38yel7nBxrBVqCEzJZQV690BFcAIEF1ZktvK+mRKAMRc2dad
 6GYD41Ib4dbNWjIpQNCYD2hvQEFayN/EE/dd2Bw57AMTQNXnnA5KH03z+3ccEB+gLtZ12T
 xQTKPVwSIF29bdGfXkwqaqyuGCQYzCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-lXz1UB3IOG-6p_E59F4jAw-1; Tue, 26 Dec 2023 04:49:49 -0500
X-MC-Unique: lXz1UB3IOG-6p_E59F4jAw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-332ee20a40fso3203952f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584186; x=1704188986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbBeyS/80jftVPd7Ma4Yal4/KK1d/JdRq54dZwI1a6k=;
 b=GTAcu04hAx/vUvH2BX+Q3zd/Yb6Mzf+cea60K9S5MhsiVOiwCTJqQBULxa4ZcGLwjg
 6Hs8xzGUNb6r81eaTKAujSBtM/nj6rz3Wi8EAPqvYLGr7HuIg0TjzkOzaAqJqskDy5Y6
 QmOiW1la4ZoStt2MF5NaV865zF5oP2F8t2vmm7ZuWzE6pnzxoLq+43Z/tgj9KIlc1+ns
 h9QnY9WSCAMkmsNs0P+9v1YI0/pqBa8LaT1HJFlEJx/BqjYGzCi6P8mpLmoqOal3uIF8
 7PetoAtUswoOfeUIpQHYyTG6zA/C6N0Ww+mOmVzGLDcgynucMMzHukTVg4BgMxoddTaH
 pFDA==
X-Gm-Message-State: AOJu0YzhIl+8wUFXoAG1b6wkIB1sKjvfHGGVdWGknWZ2+feyif1QbdaM
 lAjafLfZ5mmiDRMd3DYJwl4TixXdMM0mIQ8NfaBO4QObfU2KoFj2DctjRfy4x7gN9UwTNIprcIj
 J7N6k/DZKnwgiVl/vLf1wIn9yQ/Tg41wCRQuWkMfOeF8nGsmKyc19yP1FlWQ/k9+DE0xloe5PeT
 hz
X-Received: by 2002:a5d:5605:0:b0:336:7434:193a with SMTP id
 l5-20020a5d5605000000b003367434193amr3591714wrv.124.1703584185886; 
 Tue, 26 Dec 2023 01:49:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf6Va6rYeZk5frmJa+pemxx+Py3dhXnsR02RdlM7fPUy3DC1+NCVdwwKIhnbMQvg0WRs51yw==
X-Received: by 2002:a5d:5605:0:b0:336:7434:193a with SMTP id
 l5-20020a5d5605000000b003367434193amr3591706wrv.124.1703584185425; 
 Tue, 26 Dec 2023 01:49:45 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 l2-20020adfe582000000b003366cf8bda4sm12190788wrm.41.2023.12.26.01.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:49:43 -0800 (PST)
Date: Tue, 26 Dec 2023 04:49:41 -0500
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


