Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1F270BC67
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144E-0005Xu-5T; Mon, 22 May 2023 07:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143d-0005Bl-BW
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143b-0007a3-7P
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVpzLWuuhBNxH18mPNaORIdlSEI8YVFhxzB54R2645g=;
 b=Gcrf3cxHIw/vz+Wx3eANhFS4V2qxEJV4T8RXkmYtJQDG6G7o5I8P9VZ0NA82eA32cLM7Sv
 tQ6B/iempGHXhayX5nBqzeGkzEBodVUlq+R1P4X7tv9xWatAgjkG+6XWQvXOs+RpFGvhJZ
 Pm78rC7DpI9G+me4AKFVKgawQ3BG5pE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-gvB0koXsM3qIgFziqi8y_w-1; Mon, 22 May 2023 07:50:28 -0400
X-MC-Unique: gvB0koXsM3qIgFziqi8y_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56B1F3C02B70;
 Mon, 22 May 2023 11:50:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D8E02166B26;
 Mon, 22 May 2023 11:50:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/20] hw/sparc64/sun4u: Use MachineClass->default_nic and
 MachineClass->no_parallel
Date: Mon, 22 May 2023 13:50:04 +0200
Message-Id: <20230522115014.1110840-11-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Announce the default NIC via MachineClass->default_nic and set up
MachineClass->no_parallel according to the availability of the
"isa-parallel" device, so that the Sun machines also work when
QEMU has been configured with "--without-default-devices".

Message-Id: <20230512124033.502654-11-thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/sparc64/sun4u.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index eae7589462..e2858a0331 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -553,6 +553,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                         MachineState *machine,
                         const struct hwdef *hwdef)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     SPARCCPU *cpu;
     Nvram *nvram;
     unsigned int i;
@@ -645,15 +646,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         PCIBus *bus;
         nd = &nd_table[i];
 
-        if (!nd->model || strcmp(nd->model, "sunhme") == 0) {
+        if (!nd->model || strcmp(nd->model, mc->default_nic) == 0) {
             if (!onboard_nic) {
                 pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1),
-                                                   true, "sunhme");
+                                                   true, mc->default_nic);
                 bus = pci_busA;
                 memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
                 onboard_nic = true;
             } else {
-                pci_dev = pci_new(-1, "sunhme");
+                pci_dev = pci_new(-1, mc->default_nic);
                 bus = pci_busB;
             }
         } else {
@@ -816,6 +817,8 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
     mc->ignore_boot_device_suffixes = true;
     mc->default_display = "std";
+    mc->default_nic = "sunhme";
+    mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     fwc->get_dev_path = sun4u_fw_dev_path;
 }
 
@@ -840,6 +843,8 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_display = "std";
+    mc->default_nic = "sunhme";
+    mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
 
 static const TypeInfo sun4v_type = {
-- 
2.31.1


