Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7BE70DB24
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Pp2-0004Tc-LS; Tue, 23 May 2023 07:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Pp0-0004TB-4L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Poy-0002dD-KF
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684839891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPvbxejgj/zHqMIwqaEznsRDu2txeXcjWw0YpkveP5k=;
 b=G4w8ZP8OQugyqrbvNL8gTCnAtQdazPF3oLPRAlhNsBPW2VTlTKU2DiCZbm+/8VTcJfvvc2
 qtKOwI/Ghe4NI5Sw9Ixujh1HtPAcGNXKYgaIJx5AIQe6wyxlRPqlNhA3Ww02JzLEXt5tNs
 X1U/rDJE+pAtFjbggrE3WFKsMPBxlw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-9EK3HNsoNEyTBkSirQCivg-1; Tue, 23 May 2023 07:04:48 -0400
X-MC-Unique: 9EK3HNsoNEyTBkSirQCivg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08874811E78;
 Tue, 23 May 2023 11:04:48 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 188F39D73;
 Tue, 23 May 2023 11:04:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/5] hw/hppa: Use MachineClass->default_nic in the hppa machine
Date: Tue, 23 May 2023 13:04:31 +0200
Message-Id: <20230523110435.1375774-2-thuth@redhat.com>
In-Reply-To: <20230523110435.1375774-1-thuth@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
 hw/hppa/machine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8fea5fa6b8..b00a91ecfe 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -177,6 +177,7 @@ static void machine_hppa_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev, *dino_dev, *lasi_dev;
     PCIBus *pci_bus;
     ISABus *isa_bus;
@@ -272,7 +273,7 @@ static void machine_hppa_init(MachineState *machine)
 
     for (i = 0; i < nb_nics; i++) {
         if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "tulip", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
         }
     }
 
@@ -462,6 +463,7 @@ static void hppa_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 512 * MiB;
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
+    mc->default_nic = "tulip";
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
-- 
2.31.1


