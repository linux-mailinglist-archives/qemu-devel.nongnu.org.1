Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F170C7B2E99
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DX-00053E-4k; Fri, 29 Sep 2023 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DO-0004zS-Fv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005c7-Gk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40dFwdEDYjBk/PJiIMChICvIvPp7xMTuD7Ew4mW7k94=;
 b=gIbarsJ/008kOr9A7qQfSHFxsbzLNDlrCPfh2j4VQqEzA1mR21UxrfFzyafdhW+jYE0elA
 FK8JbHrz+noC5PkG10T38A+tUSM+U5Xvtd7FWjNKHus1O86kRhP0oGBkFBfxuB1+tskGlP
 LF78QbUNu8gNVPMQjCwPLjq1efsy4vU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-XlOpw6q7NBCuhAcp6F5ogA-1; Fri, 29 Sep 2023 04:50:58 -0400
X-MC-Unique: XlOpw6q7NBCuhAcp6F5ogA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C781C08967;
 Fri, 29 Sep 2023 08:50:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5DC9A;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD49621E68A4; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 47/56] intel_iommu: Fix shadow local variables on "size"
Date: Fri, 29 Sep 2023 10:50:44 +0200
Message-ID: <20230929085053.2789105-48-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

This patch fixes the warning of shadowed local variable:

../hw/i386/intel_iommu.c: In function ‘vtd_address_space_unmap’:
../hw/i386/intel_iommu.c:3773:18: warning: declaration of ‘size’ shadows a previous local [-Wshadow=compatible-local]
 3773 |         uint64_t size = mask + 1;
      |                  ^~~~
../hw/i386/intel_iommu.c:3747:12: note: shadowed declaration is here
 3747 |     hwaddr size, remain;
      |            ^~~~

Cc: Jason Wang <jasowang@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230922160410.138786-1-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..2c832ab68b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3744,7 +3744,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
-    hwaddr size, remain;
+    hwaddr total, remain;
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
@@ -3765,7 +3765,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     }
 
     assert(start <= end);
-    size = remain = end - start + 1;
+    total = remain = end - start + 1;
 
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
@@ -3793,10 +3793,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
                              VTD_PCI_SLOT(as->devfn),
                              VTD_PCI_FUNC(as->devfn),
-                             n->start, size);
+                             n->start, total);
 
     map.iova = n->start;
-    map.size = size - 1; /* Inclusive */
+    map.size = total - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
-- 
2.41.0


