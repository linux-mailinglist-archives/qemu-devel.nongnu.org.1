Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3665737548
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIg-0008Rw-UB; Tue, 20 Jun 2023 15:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf76-00046y-Cd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:25:56 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf74-0006Zx-RZ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:25:56 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-56d304e5f83so55358637b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281953; x=1689873953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkXrXUCl9XejgHeWNoDJ4ecPxbS0VZq3G8Aoj6DU1mE=;
 b=BluWLSfvwI+/zgM8cEPwJz2RJFOpN9nh+nRRnTUhGkZQfDM4nVXICadsMfcu63FyLC
 kvlVgwGq+2fcv7ouynfVjqpfGKkrr6S1i+Ch0fBYdjr6k7s7zKnMy07Eyh5FhQAarhEX
 08gDjjCvZhhSJgP0LL8bi4iCSiWNu2ibCBVD5bZmYcY/+UrNEK6ztqTBo6qZuaKtUx5M
 vOD47+QxCLKQafeMBh0j8GXCtvfBXFIQf6Q2iRbxI5273OsvZtm27G1DiTUkRO1QKLiG
 C53qZAG1W8afpp+d1y9gh1gV78COR0HWB3OsftCf2ecZaWzD8vfdLsxIROFozoIdf9hI
 MyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281953; x=1689873953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkXrXUCl9XejgHeWNoDJ4ecPxbS0VZq3G8Aoj6DU1mE=;
 b=LYzBqYG2n98GGx4XIofzwxVXZ5J8u90S5ymbmciIBDZV+lkL9XdlqQqNdlGRHTHbhX
 cppbNQHwuA8Jg+VRdIzf57pTMtNTYthmg0OKdyByaVces9tzlER25PD/fOQh4hQ9mEJE
 ePoSbaYN049PKwto37fwCRVk3P69TJtlY2w1P8WToxY1boQqfkskgRZuAhUIk4TfAN+R
 90BjyquiJ1IE9ZXniVAWwiM+WCivcYk68+Wpa8CHHiBkoPXlbV4AFG6slhtonsHMyQ6J
 eMds7l4Mi4BM9ixr3x2fYmqi8nelk7LhABU9v4fHJhqFncFdVPJNBOnhndhxvCLChqce
 wPRA==
X-Gm-Message-State: AC+VfDxFUO9E28xYP+y25AIN2fYAB/kaLACp15oYVGl/grwL5hO6z+hY
 wowI2ENiagQbXXf5Gx2bpT55pxCDTBZssg==
X-Google-Smtp-Source: ACHHUZ5AmQXnhHA56yrF+So0ut59LSENG1l5M48qJUexNYXE94tSgCH5l/sGECpkTwNXZ9EO4PxbnQ==
X-Received: by 2002:a81:4f54:0:b0:56f:f565:c037 with SMTP id
 d81-20020a814f54000000b0056ff565c037mr14037065ywb.7.1687281953509; 
 Tue, 20 Jun 2023 10:25:53 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:25:53 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 02/23] pc/q35: Apply PCI bus BSEL property for Xen PCI
 device hotplug
Date: Tue, 20 Jun 2023 13:24:36 -0400
Message-Id: <fc1a6594429e549af90037e0ba0a256680a95cf6.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

On Q35 we still need to assign BSEL property to bus(es) for PCI device
add/hotplug to work.
Extend acpi_set_pci_info() function to support Q35 as well. This patch adds new (trivial)
function find_q35() which returns root PCIBus object on Q35, in a way
similar to what find_i440fx does.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/acpi/pcihp.c      | 4 +++-
 hw/pci-host/q35.c    | 9 +++++++++
 include/hw/i386/pc.h | 3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index cdd6f775a1..f4e39d7a9c 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -40,6 +40,7 @@
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
 #include "trace.h"
+#include "sysemu/xen.h"
 
 #define ACPI_PCIHP_SIZE 0x0018
 #define PCI_UP_BASE 0x0000
@@ -84,7 +85,8 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
-    if (qbus_is_hotpluggable(BUS(bus))) {
+    /* Xen requires hotplugging to the root device, even on the Q35 chipset */
+    if (qbus_is_hotpluggable(BUS(bus)) || xen_enabled()) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
             bus_bsel = g_malloc(sizeof *bus_bsel);
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fd18920e7f..fe5fc0f47c 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -259,6 +259,15 @@ static void q35_host_initfn(Object *obj)
                              qdev_prop_allow_set_link_before_realize, 0);
 }
 
+PCIBus *find_q35(void)
+{
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/q35", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    return s ? s->bus : NULL;
+}
+
+
 static const TypeInfo q35_host_info = {
     .name       = TYPE_Q35_HOST_DEVICE,
     .parent     = TYPE_PCIE_HOST_BRIDGE,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c661e9cc80..550f8fa221 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -196,6 +196,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+/* q35.c */
+PCIBus *find_q35(void);
+
 extern GlobalProperty pc_compat_8_0[];
 extern const size_t pc_compat_8_0_len;
 
-- 
2.34.1


