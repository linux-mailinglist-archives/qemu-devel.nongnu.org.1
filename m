Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA47B2E7C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dc-00059r-RP; Fri, 29 Sep 2023 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DV-000521-Kv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DC-0005cc-LA
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRwR21bdggz4SmTbbLuneB2b/ji31PDEjZ9aJRmNc6M=;
 b=AzSqjx3H5yPs8YbPZha7F1Owmba3sli0+WQRqpkPZiG2Z8at0E6oNlOc4iXlmiNqsyLEa0
 Rl8uYN4wdj9y7eugKyE+wxHl1xgghdrffJyQYMFHmrt+YRtCvU5DSf8KEEHMzkBvPZTJxP
 1twI4XP2qIxrM+W5bmEojpK/A3RC6DI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-yYV9XF5BPLWSvNyhxBhKCQ-1; Fri, 29 Sep 2023 04:50:57 -0400
X-MC-Unique: yYV9XF5BPLWSvNyhxBhKCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04F66185A79C;
 Fri, 29 Sep 2023 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6305C15BB8;
 Fri, 29 Sep 2023 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A853D21E6894; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 31/56] spapr: Clean up local variable shadowing in
 spapr_dt_cpus()
Date: Fri, 29 Sep 2023 10:50:28 +0200
Message-ID: <20230929085053.2789105-32-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Introduce a helper routine defining one CPU device node to fix this
warning :

  ../hw/ppc/spapr.c: In function ‘spapr_dt_cpus’:
  ../hw/ppc/spapr.c:812:19: warning: declaration of ‘cs’ shadows a previous local [-Wshadow=compatible-local]
    812 |         CPUState *cs = rev[i];
        |                   ^~
  ../hw/ppc/spapr.c:786:15: note: shadowed declaration is here
    786 |     CPUState *cs;
        |               ^~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230918145850.241074-4-clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1f1aa2a6d4..612dbdf356 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
                               pcc->lrg_decr_bits)));
 }
 
+static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
+                             int cpus_offset)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    int index = spapr_get_vcpu_id(cpu);
+    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    g_autofree char *nodename = NULL;
+    int offset;
+
+    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
+        return;
+    }
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
+    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
+    _FDT(offset);
+    spapr_dt_cpu(cs, fdt, offset, spapr);
+}
+
+
 static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
 {
     CPUState **rev;
@@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
     }
 
     for (i = n_cpus - 1; i >= 0; i--) {
-        CPUState *cs = rev[i];
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        int index = spapr_get_vcpu_id(cpu);
-        DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        g_autofree char *nodename = NULL;
-        int offset;
-
-        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-            continue;
-        }
-
-        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
-        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
-        _FDT(offset);
-        spapr_dt_cpu(cs, fdt, offset, spapr);
+        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
     }
 
     g_free(rev);
-- 
2.41.0


