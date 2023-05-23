Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C670DB25
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Pp6-0004U7-Ki; Tue, 23 May 2023 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pp3-0004Tq-R6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pp2-0002e2-82
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684839895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p88QPabx6fyTv3KzbTfhZ1QR58gl8zylMmH/d8/QmaM=;
 b=BwohHHJKyVLITOeRTAtpOLkawAy1UqubJ71J+F2j3wac3Ftn9wsbHNvxPYFqO9mb8NhmUm
 Rk2ftfCOwJAVkZl3TlUI/a/SwTtIfEeQmVsZwJaNmVAHLDyMnUVQZu33uXxyZuXRV9WaIL
 a0Bl+AoS9z8dYXi0JazIe795PLVh9B8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-RL2zaCohNwK0JQqzFlLIUg-1; Tue, 23 May 2023 07:04:54 -0400
X-MC-Unique: RL2zaCohNwK0JQqzFlLIUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD31B800888;
 Tue, 23 May 2023 11:04:53 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61BC09D7B;
 Tue, 23 May 2023 11:04:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/5] hw/arm: Use MachineClass->default_nic in the virt machine
Date: Tue, 23 May 2023 13:04:33 +0200
Message-Id: <20230523110435.1375774-4-thuth@redhat.com>
In-Reply-To: <20230523110435.1375774-1-thuth@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b99ae18501..9b9f7d9c68 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1426,6 +1426,7 @@ static void create_pcie(VirtMachineState *vms)
     int i, ecam_id;
     PCIHostState *pci;
     MachineState *ms = MACHINE(vms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     dev = qdev_new(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -1479,7 +1480,7 @@ static void create_pcie(VirtMachineState *vms)
             NICInfo *nd = &nd_table[i];
 
             if (!nd->model) {
-                nd->model = g_strdup("virtio");
+                nd->model = g_strdup(mc->default_nic);
             }
 
             pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
@@ -3033,6 +3034,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->default_ram_id = "mach-virt.ram";
+    mc->default_nic = "virtio-net-pci";
 
     object_class_property_add(oc, "acpi", "OnOffAuto",
         virt_get_acpi, virt_set_acpi,
-- 
2.31.1


