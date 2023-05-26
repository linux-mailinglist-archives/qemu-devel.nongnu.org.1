Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AA71231E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRX-0003AY-AP; Fri, 26 May 2023 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRR-0002zK-Pk
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRQ-0000ia-AZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOT2Js3b4mm4Jy9Geh3nYmXhP7NcBm28PYHB/D1n35I=;
 b=Vv5X20ADM5QuCNdu3v4XG4zTRCQ7pGbTnWiM7xPWnHLdfzAGSVN7yOkEDIjnv4g+Vb3pFc
 p5atidsTvSZYYZdjejTtyDLXUWMqkMgZSdaHrKJTK2R0krs2JBp3D74dnZz6+iUOzJRvx1
 6/wLFiHDyV3voFj6dVbN/ajZmGcxSUg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-3r50-6JTPAyahj-cpunOhg-1; Fri, 26 May 2023 05:08:50 -0400
X-MC-Unique: 3r50-6JTPAyahj-cpunOhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41050185A78E;
 Fri, 26 May 2023 09:08:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 714F0C154D1;
 Fri, 26 May 2023 09:08:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/15] hw/mips: Use MachineClass->default_nic in the virt
 machine
Date: Fri, 26 May 2023 11:08:32 +0200
Message-Id: <20230526090840.2225958-8-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230524122559.28863-1-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/loongson3_virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 25534288dd..216812f660 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -406,6 +406,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     PCIBus *pci_bus;
     DeviceState *dev;
     MemoryRegion *mmio_reg, *ecam_reg;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     LoongsonMachineState *s = LOONGSON_MACHINE(machine);
 
     dev = qdev_new(TYPE_GPEX_HOST);
@@ -456,7 +457,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
         NICInfo *nd = &nd_table[i];
 
         if (!nd->model) {
-            nd->model = g_strdup("virtio");
+            nd->model = g_strdup(mc->default_nic);
         }
 
         pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
@@ -619,6 +620,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->kvm_type = mips_kvm_type;
     mc->minimum_page_bits = 14;
+    mc->default_nic = "virtio-net-pci";
 }
 
 static const TypeInfo loongson3_machine_types[] = {
-- 
2.31.1


