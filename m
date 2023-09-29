Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660B7B2E65
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dh-0005ES-TW; Fri, 29 Sep 2023 04:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DW-00053S-Lk
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005cY-NF
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFHXkfu0fole/oqJ653QsQLZi9wEuEiSH8oaSnTRrOg=;
 b=VUGugXPfwq1rMcKLIPW8EdZTpvQaQ7/3KSflaFMveUZD4viSf9fBfrpnmWqqMoHAdNS3U9
 /JWYimaMn9rUUwhLudqQlfIeRM3rfYuT5tAhLpr1fTJH1GqDSy25i3qM/iSLASr3UWoADs
 cgrSUJJpam1aRVpaDFK9WImuWW0m9w0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-FVoHJYMINfa81ftQFX_kPA-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: FVoHJYMINfa81ftQFX_kPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DB37380117D;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DED342026D4B;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B248E21E6896; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/56] spapr: Clean up local variable shadowing in
 spapr_get_fw_dev_path()
Date: Fri, 29 Sep 2023 10:50:30 +0200
Message-ID: <20230929085053.2789105-34-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

From: Cédric Le Goater <clg@kaod.org>

Rename PCIDevice variable to avoid this warning :

  ../hw/ppc/spapr.c: In function ‘spapr_get_fw_dev_path’:
  ../hw/ppc/spapr.c:3217:20: warning: declaration of ‘pcidev’ shadows a previous local [-Wshadow=compatible-local]
   3217 |         PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
        |                    ^~~~~~
  ../hw/ppc/spapr.c:3147:16: note: shadowed declaration is here
   3147 |     PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
        |                ^~~~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-6-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4fe82e490a..d4230d3647 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3214,8 +3214,8 @@ static char *spapr_get_fw_dev_path(FWPathProvider *p, BusState *bus,
 
     if (g_str_equal("pci-bridge", qdev_fw_name(dev))) {
         /* SLOF uses "pci" instead of "pci-bridge" for PCI bridges */
-        PCIDevice *pcidev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
-        return g_strdup_printf("pci@%x", PCI_SLOT(pcidev->devfn));
+        PCIDevice *pdev = CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
+        return g_strdup_printf("pci@%x", PCI_SLOT(pdev->devfn));
     }
 
     if (pcidev) {
-- 
2.41.0


