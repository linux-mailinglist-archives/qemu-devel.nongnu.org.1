Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E97EC9BF
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:36:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jn3-0003ir-VW; Wed, 15 Nov 2023 12:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-7de3bc1eacbb410583386b7e5d6ebd8f@bounce.vates.tech>)
 id 1r3Jmo-0003Zu-CZ
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:47 -0500
Received: from mail186-12.suw21.mandrillapp.com ([198.2.186.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-7de3bc1eacbb410583386b7e5d6ebd8f@bounce.vates.tech>)
 id 1r3Jml-0000ou-Oy
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 s=mandrill; t=1700068734; x=1700329234;
 i=thierry.escande@vates.tech;
 bh=0AkevqCVQ5EhqI9vwSOq2BG4pE9solynAvDj4lNtdRY=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=bRxmXpNNCOod5/n96FS9CzBsTEqIbvOcLKFowC43Vo6gzWqG86oEXRlkQh/04t8rv
 4t10sm+PqdnJ66L8uwq4t4E9+iy2r9d/uloZwNVy5ftxgi/2/d9qkC+cSZbG1/dNDi
 f5/BH85UVjeNdT4Ix3wVp29IfuFDU6Zsh/QtHGCk=
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-12.suw21.mandrillapp.com (Mailchimp) with ESMTP id
 4SVqdT6w4Cz705md5
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 17:18:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1700068733; h=from :
 subject : to : cc : message-id : in-reply-to : references : date :
 mime-version : content-type : content-transfer-encoding : from :
 x-mandrill-user : list-unsubscribe;
 bh=0AkevqCVQ5EhqI9vwSOq2BG4pE9solynAvDj4lNtdRY=;
 b=FusL+iEniD8tOgevdtaQiRUVC5p8iL9N4Wv0wr7kRdQWEMV7BurZHU9I9da8eFhcueCbS
 mYs2KbarOv+rqefqzm9HYniB6ywdZb4h+frt7Zh9VIPxhw1i/phhZMQYawYtNXKuz2Ma8gS
 BY/Lq6FlWYgm4BswZEbxmYkCCZrooaQ=
From: Thierry Escande <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=203/4]=20ich9:=20Add=20accessors=20for=20acpi-root-pci-hotplug?=
Received: from [37.26.189.201] by mandrillapp.com id
 7de3bc1eacbb410583386b7e5d6ebd8f; Wed, 15 Nov 2023 17:18:53 +0000
X-Mailer: git-send-email 2.42.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: a6f8c62a-75f8-4756-90d1-92e0b788484c
X-Bm-Transport-Timestamp: 1700068732351
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Message-Id: <20231115171837.18866-4-thierry.escande@vates.tech>
In-Reply-To: <20231115171837.18866-1-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.7de3bc1eacbb410583386b7e5d6ebd8f?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20231115:md
Date: Wed, 15 Nov 2023 17:18:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.12;
 envelope-from=bounce-md_30504962.6554fd7d.v1-7de3bc1eacbb410583386b7e5d6ebd8f@bounce.vates.tech;
 helo=mail186-12.suw21.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch adds accessors for acpi-root-pci-hotplug property. PCI
hotplug can be enabled/disabled with:
  -global ICH9-LPC.acpi-root-pci-hotplug=on|off

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 hw/acpi/ich9.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index e21732b547..e38c9bb998 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -413,6 +413,20 @@ static void ich9_pm_set_acpi_hotplug_bridge(Object *obj, bool value,
     s->pm.acpi_pci_hotplug.use_acpi_hotplug_bridge = value;
 }
 
+static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+
+    return s->pm.acpi_pci_hotplug.use_acpi_root_pci_hotplug;
+}
+
+static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value, Error **errp)
+{
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+
+    s->pm.acpi_pci_hotplug.use_acpi_root_pci_hotplug = value;
+}
+
 static bool ich9_pm_get_keep_pci_slot_hpc(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -464,6 +478,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
                              ich9_pm_get_acpi_hotplug_bridge,
                              ich9_pm_set_acpi_hotplug_bridge);
+    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCI_ROOTHP,
+                             ich9_pm_get_acpi_pci_hotplug,
+                             ich9_pm_set_acpi_pci_hotplug);
     object_property_add_bool(obj, "x-keep-pci-slot-hpc",
                              ich9_pm_get_keep_pci_slot_hpc,
                              ich9_pm_set_keep_pci_slot_hpc);
-- 
2.42.0



Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

