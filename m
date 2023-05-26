Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C45E712324
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TRN-0002vT-FE; Fri, 26 May 2023 05:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRL-0002v5-GT
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2TRK-0000hd-1W
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YC6jIvP2QXQOLHf9hCxS1/9g4h0h+RAusucAoyZ/Zjw=;
 b=J6iAdsNmQbbayzzpkyjadZG2ssymxsNFIJsYq6rgpdARpWKib9X+LlfH2pMvqV/ZJLg4HL
 WmJEI1D1DYNhtR4RRIscCyvmgIjsBo92If/+QDtY+Qk0ypgaK4w0fVaSgiAafrfANsfSJT
 9zWTmTOGd99Czlwv6+fjCy9RnpBDoYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-Dliami3IMw2N3ZKVvWuGyw-1; Fri, 26 May 2023 05:08:47 -0400
X-MC-Unique: Dliami3IMw2N3ZKVvWuGyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 091D68015D8;
 Fri, 26 May 2023 09:08:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8815C154D2;
 Fri, 26 May 2023 09:08:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/15] hw/loongarch64: Use MachineClass->default_nic in the
 virt machine
Date: Fri, 26 May 2023 11:08:29 +0200
Message-Id: <20230526090840.2225958-5-thuth@redhat.com>
In-Reply-To: <20230526090840.2225958-1-thuth@redhat.com>
References: <20230526090840.2225958-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Mark the default NIC via the new MachineClass->default_nic setting
so that the machine-defaults code in vl.c can decide whether the
default NIC is usable or not (for example when compiling with the
"--without-default-devices" configure switch).

Message-Id: <20230523110435.1375774-5-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/loongarch/virt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b7588e32a..ceddec1b23 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -474,6 +474,7 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
 
 static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *lams)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(lams);
     DeviceState *gpex_dev;
     SysBusDevice *d;
     PCIBus *pci_bus;
@@ -528,7 +529,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
         NICInfo *nd = &nd_table[i];
 
         if (!nd->model) {
-            nd->model = g_strdup("virtio");
+            nd->model = g_strdup(mc->default_nic);
         }
 
         pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
@@ -1038,6 +1039,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    mc->default_nic = "virtio-net-pci";
     hc->plug = loongarch_machine_device_plug_cb;
     hc->pre_plug = virt_machine_device_pre_plug;
     hc->unplug_request = virt_machine_device_unplug_request;
-- 
2.31.1


