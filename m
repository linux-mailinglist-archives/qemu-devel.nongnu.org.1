Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D253575B03B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsp-0007EF-Mz; Thu, 20 Jul 2023 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs8-0006il-4X
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs5-0007Yg-6D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689860348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnEVJbFMBCtAwYuaeWy99f750/TU2Uo0rZnuoNBLTeM=;
 b=FjZ3o9Ygvh3pqLjQC5m+bCYn1FIDmijq0SDaxKOELjiDos4hQ+b6zPoYoNxCEHp6hIkGkA
 YPF4eSUnGTjwzRz4ZVsCtGUF1L7KxOJpWsG8si6Apa+ytqFhVcFxpF1lW0w9fXuxkSQCyC
 rrhNir+1FxiyU5vl/pa9h39Ifs6hISA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-yD7HlrywNtqLXToCbCV01w-1; Thu, 20 Jul 2023 09:39:06 -0400
X-MC-Unique: yD7HlrywNtqLXToCbCV01w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E62A31C04189
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:39:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE234CD0E3;
 Thu, 20 Jul 2023 13:39:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH for-8.1 5/6] acpi: x86: remove _ADR on host bridges
Date: Thu, 20 Jul 2023 15:38:57 +0200
Message-Id: <20230720133858.1974024-6-imammedo@redhat.com>
In-Reply-To: <20230720133858.1974024-1-imammedo@redhat.com>
References: <20230720133858.1974024-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

ACPI spec (since 2.0a) says
"
A device object must contain either an _HID object or
an _ADR object, but can contain both.
"

_ADR is used when device is attached to an ennumerable bus,
however hostbridge is not and uses dedicated _HID for
discovery, drop _ADR field.

It doesn't seem that having _ADR has a negative effects
OSes manage to tolerate that, but there is no point of
having it there. (only pc/q35 has it hostbridge description,
while others (microvm/arm) don't)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 19d268ff59..bb12b0ad43 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1464,7 +1464,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, aml_pci_edsm());
         aml_append(sb_scope, dev);
@@ -1479,7 +1478,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
         aml_append(dev, aml_pci_edsm());
@@ -1593,7 +1591,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(pkg, aml_eisaid("PNP0A08"));
                 aml_append(pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", pkg));
-                aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
                 build_cxl_osc_method(dev);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-- 
2.39.3


