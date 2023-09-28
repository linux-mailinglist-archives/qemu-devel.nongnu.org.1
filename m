Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF17B1E0B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwo-0003gn-71; Thu, 28 Sep 2023 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwO-0003Ps-JB
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwL-00087r-Am
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+IRfxaI2DhK3uI/sbN9+YgEC2D0NOSgYOhqn4uSoFA=;
 b=UTl1JAyVkh5ZpoVbziBl7TGSlE+GmTcyIHwYl4+c3IyflG48YHZjCW3FLtGS2LzQfwc1kc
 TNz3FABYGgrcypmF1CMYc8Kr1yC8avMBsCNBi4E7RN9I2cO2S7d1JShH4M/VpJhzBd7no2
 qBe53BKLq8MJrEoPViBIdwJkc3euIo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-vW3wOWGQOwiLOpNPLP3TRQ-1; Thu, 28 Sep 2023 09:20:22 -0400
X-MC-Unique: vW3wOWGQOwiLOpNPLP3TRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 275BD802C1A;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 033042026D4B;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDDD521E6912; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 10/53] migration/rdma: Put @errp parameter last
Date: Thu, 28 Sep 2023 15:19:36 +0200
Message-ID: <20230928132019.2544702-11-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

include/qapi/error.h demands:

 * - Functions that use Error to report errors have an Error **errp
 *   parameter.  It should be the last parameter, except for functions
 *   taking variable arguments.

qemu_rdma_connect() does not conform.  Clean it up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 94b828b45d..176fe1a5f1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2532,7 +2532,8 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
     }
 }
 
-static int qemu_rdma_connect(RDMAContext *rdma, Error **errp, bool return_path)
+static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
+                             Error **errp)
 {
     RDMACapabilities cap = {
                                 .version = RDMA_CONTROL_VERSION_CURRENT,
@@ -4175,7 +4176,7 @@ void rdma_start_outgoing_migration(void *opaque,
     }
 
     trace_rdma_start_outgoing_migration_after_rdma_source_init();
-    ret = qemu_rdma_connect(rdma, errp, false);
+    ret = qemu_rdma_connect(rdma, false, errp);
 
     if (ret) {
         goto err;
@@ -4196,7 +4197,7 @@ void rdma_start_outgoing_migration(void *opaque,
             goto return_path_err;
         }
 
-        ret = qemu_rdma_connect(rdma_return_path, errp, true);
+        ret = qemu_rdma_connect(rdma_return_path, true, errp);
 
         if (ret) {
             goto return_path_err;
-- 
2.41.0


