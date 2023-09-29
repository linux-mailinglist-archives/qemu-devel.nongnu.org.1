Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55847B2EB8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dp-0005Kn-M5; Fri, 29 Sep 2023 04:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Dj-0005Gu-6t
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DE-0005dW-Tk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DZX1t/Jy77h1aaNiB67Wo1f3gwNo9ouNMgM0TJJqWAw=;
 b=XmutOjIVzuZw1URAAhqQnOPgLZxa/TBNX4whODBgW0ZLQne5J7Z1VtlwfBqtyfwWMw9kTY
 5SKKt8s0tNmIkPwaBilIH659qCwWlwzviiAuw3bQwsj9Od0W8FuAaljBXyxqgaQ3Bm75uc
 ZwG6Ap/TFBvv2wMcj9aMShIcKXOXVpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-k3xIZ4BfNlqkmfobvO0aPg-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: k3xIZ4BfNlqkmfobvO0aPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E7E5858F19;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6E02026D68;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA63A21E6898; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 35/56] spapr/pci: Clean up local variable shadowing in
 spapr_phb_realize()
Date: Fri, 29 Sep 2023 10:50:32 +0200
Message-ID: <20230929085053.2789105-36-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Cédric Le Goater <clg@kaod.org>

Rename SysBusDevice variable to avoid this warning :

  ../hw/ppc/spapr_pci.c: In function ‘spapr_phb_realize’:
  ../hw/ppc/spapr_pci.c:1872:24: warning: declaration of ‘s’ shadows a previous local [-Wshadow=local]
   1872 |         SpaprPhbState *s;
        |                        ^
  ../hw/ppc/spapr_pci.c:1829:19: note: shadowed declaration is here
   1829 |     SysBusDevice *s = SYS_BUS_DEVICE(dev);
        |                   ^

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-8-clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ce14959317..370c5a90f2 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1826,9 +1826,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
     SpaprMachineClass *smc = spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : NULL;
-    SysBusDevice *s = SYS_BUS_DEVICE(dev);
-    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(sbd);
+    PCIHostState *phb = PCI_HOST_BRIDGE(sbd);
     MachineState *ms = MACHINE(spapr);
     char *namebuf;
     int i;
-- 
2.41.0


