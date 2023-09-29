Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C57B2E89
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Di-0005FZ-SU; Fri, 29 Sep 2023 04:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DP-0004zn-OL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DB-0005cf-Pn
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fMGsXkhh09uMBBpJC+xEyP+iGrCCOiieEQFkcxMzNs=;
 b=ZMFuOrcKCZ04T/6iy4+EpGAkTBeeLXEtraEpGLRrWavLzXKOl6GOdj/5hORQ4ByDK1nCdb
 uvUEgYqBLgJgFNmkTpcPHRzP7djiPAqhLNlNzDTUgfxheHP6pgeKemoAO2ULMewYk7usee
 kcn6dltaMBoll4hBS6JbDOhfj7UqbgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-g7zDFlhlMouKW483YKnsUw-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: g7zDFlhlMouKW483YKnsUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D67003C025CE;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B405240C6EBF;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2B4721E6892; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 29/56] hw/ppc: Clean up local variable shadowing in _FDT helper
 routine
Date: Fri, 29 Sep 2023 10:50:26 +0200
Message-ID: <20230929085053.2789105-30-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

this fixes numerous warnings of this type :

  In file included from ../hw/ppc/spapr_pci.c:43:
  ../hw/ppc/spapr_pci.c: In function ‘spapr_dt_phb’:
  ../include/hw/ppc/fdt.h:18:13: warning: declaration of ‘ret’ shadows a previous local [-Wshadow=compatible-local]
     18 |         int ret = (exp);                                           \
        |             ^~~
  ../hw/ppc/spapr_pci.c:2355:5: note: in expansion of macro ‘_FDT’
   2355 |     _FDT(bus_off = fdt_add_subnode(fdt, 0, phb->dtbusname));
        |     ^~~~
  ../hw/ppc/spapr_pci.c:2311:24: note: shadowed declaration is here
   2311 |     int bus_off, i, j, ret;
        |                        ^~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-2-clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/ppc/fdt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index a8cd85069f..b56ac2a8cb 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -15,10 +15,10 @@
 
 #define _FDT(exp)                                                  \
     do {                                                           \
-        int ret = (exp);                                           \
-        if (ret < 0) {                                             \
-            error_report("error creating device tree: %s: %s",   \
-                    #exp, fdt_strerror(ret));                      \
+        int _ret = (exp);                                          \
+        if (_ret < 0) {                                            \
+            error_report("error creating device tree: %s: %s",     \
+                    #exp, fdt_strerror(_ret));                     \
             exit(1);                                               \
         }                                                          \
     } while (0)
-- 
2.41.0


