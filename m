Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED497A4B45
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFYG-0001dL-T8; Mon, 18 Sep 2023 10:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFYB-0001Et-VT
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFY9-0003tl-1d
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Vh8j/4nj2m+S9egdULAIS1abfgrtBCZZqvvhqp5OSU=;
 b=DXk9AdcXC7A8uigNQGcPN4avwrSFU9JU+vRi0uK2ZVVcNe4FrIlwSfVJHP+8vHquAaPweT
 OTJ+LxIBt0fMozVMKK0bZtQi1NAMBwgS4P8pJXVVBhLp63Hnz3HCiuOjPeOssiDfjmneXi
 oAXGHEbhH97sPjYxpA2RN5d6Ufu6cXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-oItKdOPfPSSns9DfXDOpHg-1; Mon, 18 Sep 2023 10:48:28 -0400
X-MC-Unique: oItKdOPfPSSns9DfXDOpHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11A661C0514D
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24461C646
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F15221E68A8; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 52/52] migration/rdma: Fix how we show device details on open
Date: Mon, 18 Sep 2023 16:42:06 +0200
Message-ID: <20230918144206.560120-53-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

qemu_rdma_dump_id() dumps RDMA device details to stdout.

rdma_start_outgoing_migration() calls it via qemu_rdma_source_init()
and qemu_rdma_resolve_host() to show source device details.
rdma_start_incoming_migration() arranges its call via
rdma_accept_incoming_migration() and qemu_rdma_accept() to show
destination device details.

Two issues:

1. rdma_start_outgoing_migration() can run in HMP context.  The
   information should arguably go the monitor, not stdout.

2. ibv_query_port() failure is reported as error.  Its callers remain
   unaware of this failure (qemu_rdma_dump_id() can't fail), so
   reporting this to the user as an error is problematic.

Use qemu_printf() instead of printf() and error_report().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9e9904984e..8c84fbab7a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -30,6 +30,7 @@
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
+#include "qemu/qemu-print.h"
 #include "exec/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
@@ -742,24 +743,25 @@ static void qemu_rdma_dump_id(const char *who, struct ibv_context *verbs)
     struct ibv_port_attr port;
 
     if (ibv_query_port(verbs, 1, &port)) {
-        error_report("Failed to query port information");
+        qemu_printf("%s RDMA Device opened, but can't query port information",
+                    who);
         return;
     }
 
-    printf("%s RDMA Device opened: kernel name %s "
-           "uverbs device name %s, "
-           "infiniband_verbs class device path %s, "
-           "infiniband class device path %s, "
-           "transport: (%d) %s\n",
+    qemu_printf("%s RDMA Device opened: kernel name %s "
+                "uverbs device name %s, "
+                "infiniband_verbs class device path %s, "
+                "infiniband class device path %s, "
+                "transport: (%d) %s\n",
                 who,
                 verbs->device->name,
                 verbs->device->dev_name,
                 verbs->device->dev_path,
                 verbs->device->ibdev_path,
                 port.link_layer,
-                (port.link_layer == IBV_LINK_LAYER_INFINIBAND) ? "Infiniband" :
-                 ((port.link_layer == IBV_LINK_LAYER_ETHERNET)
-                    ? "Ethernet" : "Unknown"));
+                port.link_layer == IBV_LINK_LAYER_INFINIBAND ? "Infiniband"
+                : port.link_layer == IBV_LINK_LAYER_ETHERNET ? "Ethernet"
+                : "Unknown");
 }
 
 /*
-- 
2.41.0


