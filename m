Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA773B80D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgBr-0002H7-JT; Fri, 23 Jun 2023 08:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgBe-00027q-AJ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCgBc-0000tX-0f
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687524406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0nk12NyOdxSa7W1XLwJ5BYEwzU/9oz2vOKSkY29znw=;
 b=MWMl7FbTPxK1mNoPRYzdeP/DfUtXDBeCNWeJfxpnI70IHE7/oJtB3oYGdsrVuPqjAJxOvR
 y8Dd3SBGyZr8mYJE6HCtl0xY55scyRMARM8I0AHcvI3K2agjXqVyGtY+ltoSAlyHCFmXeN
 cwMSyxIhb/bDr75gpv0Pch+gFtW801U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-QqdGj4DfN6KkY6mUVyiphQ-1; Fri, 23 Jun 2023 08:46:31 -0400
X-MC-Unique: QqdGj4DfN6KkY6mUVyiphQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65C2880123E;
 Fri, 23 Jun 2023 12:46:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.22.32.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF0AB1121314;
 Fri, 23 Jun 2023 12:46:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v4 08/10] hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
Date: Fri, 23 Jun 2023 14:45:51 +0200
Message-Id: <20230623124553.400585-9-david@redhat.com>
In-Reply-To: <20230623124553.400585-1-david@redhat.com>
References: <20230623124553.400585-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

There are no remaining users in the tree. Libvirt never used that
property and a quick internet search revealed no other users.

Further, we renamed that property already in commit f2ffbe2b7dd0
("pc: rename "hotplug memory" terminology to "device memory"") without
anybody complaining.

So let's just get rid of it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c         | 19 -------------------
 include/hw/i386/pc.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a1dbece31e..900499d876 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1649,21 +1649,6 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void
-pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-    int64_t value = 0;
-
-    if (ms->device_memory) {
-        value = memory_region_size(&ms->device_memory->mr);
-    }
-
-    visit_type_int(v, name, &value, errp);
-}
-
 static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -1975,10 +1960,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)");
 
-    object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
-        pc_machine_get_device_memory_region_size, NULL,
-        NULL, NULL);
-
     object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
         pc_machine_get_vmport, pc_machine_set_vmport,
         NULL, NULL);
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c661e9cc80..6c9ad2d132 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -60,7 +60,6 @@ typedef struct PCMachineState {
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
-#define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
-- 
2.40.1


