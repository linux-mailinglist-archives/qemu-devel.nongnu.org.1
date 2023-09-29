Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F57B2EAD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Di-0005Ez-7o; Fri, 29 Sep 2023 04:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DY-00057S-Mf
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DD-0005dp-03
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQvEnCBkMaIjlkhN0qqXFYk8x9asIDFQ7pHQfyuffOU=;
 b=ghZPVcaYHzg03WROxIztqRs/dD6AiqSI1yb/JtVR71Bv0T5J0VmRBcSHGCm/qXBJXeSg8E
 WYanBed3wx7YFO9L0YoD5qlDx4uVfTKbETdNDBToM8cJ4VCFiN3cadx+ao5dpEJAgfmK5E
 OWcNM+TI+TERP2su1afsHbbwLfFjwf8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-nYKA9oSrMGGF1uM4Dw7IgQ-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: nYKA9oSrMGGF1uM4Dw7IgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D19D3801179;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF88C40C2070;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B767C21E6897; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 34/56] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
Date: Fri, 29 Sep 2023 10:50:31 +0200
Message-ID: <20230929085053.2789105-35-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Remove extra 'drc_index' variable to avoid this warning :

  ../hw/ppc/spapr_drc.c: In function ‘rtas_ibm_configure_connector’:
  ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of ‘drc_index’ shadows a previous local [-Wshadow=compatible-local]
   1240 |                 uint32_t drc_index = spapr_drc_index(drc);
        |                          ^~~~~~~~~
  ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
   1155 |     uint32_t drc_index;
        |              ^~~~~~~~~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-7-clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr_drc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index b5c400a94d..843e318312 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -1237,8 +1237,6 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
         case FDT_END_NODE:
             drc->ccs_depth--;
             if (drc->ccs_depth == 0) {
-                uint32_t drc_index = spapr_drc_index(drc);
-
                 /* done sending the device tree, move to configured state */
                 trace_spapr_drc_set_configured(drc_index);
                 drc->state = drck->ready_state;
-- 
2.41.0


