Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABD7C4F1C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVSG-0005Zj-FL; Wed, 11 Oct 2023 05:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS9-0005LI-6W
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS7-0005FR-HG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VCC+e4hUIxC4IlRqYVZSFxB6Bcw6S+/LoUQBIHoUdtg=;
 b=jTIEpv7Nc2o+Gvb/wrghEt0sSbfCYBgRw88cjhtGBJZZynMe676Rf8WoeTWy7oftS1LEMS
 nM4dJbxidT3KBHB17mc6Z0J2mNhz88OhDQJIv5qay1r9FwScvDxiEeOB/6UdTGK7RkCUE3
 Ot491ML4ZUnua0OeIcD/xtn15zZmHnU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-kqsRUxpVMKW_akGmVNKguw-1; Wed, 11 Oct 2023 05:24:08 -0400
X-MC-Unique: kqsRUxpVMKW_akGmVNKguw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34771101A53B;
 Wed, 11 Oct 2023 09:24:08 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7646E1C060AE;
 Wed, 11 Oct 2023 09:24:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 60/65] migration/rdma: Replace flawed device detail dump by
 tracing
Date: Wed, 11 Oct 2023 11:21:58 +0200
Message-ID: <20231011092203.1266-61-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

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

Fixable, but the device detail dump is noise, except when
troubleshooting.  Tracing is a better fit.  Similar function
qemu_rdma_dump_id() was converted to tracing in commit
733252deb8b (Tracify migration/rdma.c).

Convert qemu_rdma_dump_id(), too.

While there, touch up qemu_rdma_dump_gid()'s outdated comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-54-armbru@redhat.com>
---
 migration/rdma.c       | 23 ++++++++---------------
 migration/trace-events |  2 ++
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ab2ea85c45..f6fc226c9b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -734,38 +734,31 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
 }
 
 /*
- * Put in the log file which RDMA device was opened and the details
- * associated with that device.
+ * Trace RDMA device open, with device details.
  */
 static void qemu_rdma_dump_id(const char *who, struct ibv_context *verbs)
 {
     struct ibv_port_attr port;
 
     if (ibv_query_port(verbs, 1, &port)) {
-        error_report("Failed to query port information");
+        trace_qemu_rdma_dump_id_failed(who);
         return;
     }
 
-    printf("%s RDMA Device opened: kernel name %s "
-           "uverbs device name %s, "
-           "infiniband_verbs class device path %s, "
-           "infiniband class device path %s, "
-           "transport: (%d) %s\n",
-                who,
+    trace_qemu_rdma_dump_id(who,
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
- * Put in the log file the RDMA gid addressing information,
- * useful for folks who have trouble understanding the
- * RDMA device hierarchy in the kernel.
+ * Trace RDMA gid addressing information.
+ * Useful for understanding the RDMA device hierarchy in the kernel.
  */
 static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
 {
diff --git a/migration/trace-events b/migration/trace-events
index 6a50994402..ee9c8f4d63 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -214,6 +214,8 @@ qemu_rdma_close(void) ""
 qemu_rdma_connect_pin_all_requested(void) ""
 qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
 qemu_rdma_dest_init_trying(const char *host, const char *ip) "%s => %s"
+qemu_rdma_dump_id_failed(const char *who) "%s RDMA Device opened, but can't query port information"
+qemu_rdma_dump_id(const char *who, const char *name, const char *dev_name, const char *dev_path, const char *ibdev_path, int transport, const char *transport_name) "%s RDMA Device opened: kernel name %s uverbs device name %s, infiniband_verbs class device path %s, infiniband class device path %s, transport: (%d) %s"
 qemu_rdma_dump_gid(const char *who, const char *src, const char *dst) "%s Source GID: %s, Dest GID: %s"
 qemu_rdma_exchange_get_response_start(const char *desc) "CONTROL: %s receiving..."
 qemu_rdma_exchange_get_response_none(const char *desc, int type) "Surprise: got %s (%d)"
-- 
2.41.0


