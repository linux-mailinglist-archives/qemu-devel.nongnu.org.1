Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 541917B2E6C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DY-00055h-4h; Fri, 29 Sep 2023 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DJ-0004x9-1x
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bX-6x
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P70bHM5/faSmZvmFMecysev/ZsN9wiRLMg1QC5BYcAw=;
 b=XYXmItpHZTOrnf4Kn7Rs4q4YoUY+OYA//GOX6f6xCMHhaE2S0QoomUPjXK8KKgLjWnRKAO
 OqEstJqL07nF+Kjeqb56+z6OmkIvZFGnIb7HCjKv8UGzxKht9ZwhmY1AoEI5IN+tqcwE8s
 xbGH9CZsTujcC8DCrznskPIkWUDyWws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-tg8g7DhiOFGxPWZ4RzGbJA-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: tg8g7DhiOFGxPWZ4RzGbJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E22B3811E8D;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF744492C37;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A572021E6893; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 30/56] pnv/psi: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:27 +0200
Message-ID: <20230929085053.2789105-31-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

to fix :

  ../hw/ppc/pnv_psi.c: In function ‘pnv_psi_p9_mmio_write’:
  ../hw/ppc/pnv_psi.c:741:24: warning: declaration of ‘addr’ shadows a parameter [-Wshadow=compatible-local]
    741 |                 hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
        |                        ^~~~
  ../hw/ppc/pnv_psi.c:702:56: note: shadowed declaration is here
    702 | static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
        |                                                 ~~~~~~~^~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-3-clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/pnv_psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index daaa2f0575..26460d210d 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -738,8 +738,9 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
             }
         } else {
             if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
-                hwaddr addr = val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
-                memory_region_add_subregion(sysmem, addr,
+                hwaddr esb_addr =
+                    val & ~(PSIHB9_ESB_CI_VALID | PSIHB10_ESB_CI_64K);
+                memory_region_add_subregion(sysmem, esb_addr,
                                             &psi9->source.esb_mmio);
             }
         }
-- 
2.41.0


