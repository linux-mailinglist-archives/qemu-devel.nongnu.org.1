Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5583D374
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jan 2024 05:19:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTDfc-00027d-At; Thu, 25 Jan 2024 23:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfT-0001zA-Pw
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rTDfQ-0004zv-Sy
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 23:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706242692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Vvbftuj0OCUtZRn4vsJpQ7cASD1WEAgCGmOsdimkcI=;
 b=da3Dcf8F+YWRZzQPo0112v8gTjrVxTODvBWgOcyK7XdClmj/OzIcMx4Aox/WsPqKuXT1va
 cZd2zNR5nOUv6y9pkJzQRo1tqv4qj4c5y78BXS45ZQSmtWh5Q9h1EZroyOTXuDqjQPsZvF
 XQ+jkX23+L4ls29hZ5J33gFTAh6p3jU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-JZZj14NHM46dbQrmWbx48A-1; Thu, 25 Jan 2024 23:18:06 -0500
X-MC-Unique: JZZj14NHM46dbQrmWbx48A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ABFE83DE29;
 Fri, 26 Jan 2024 04:18:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44C5B492BC6;
 Fri, 26 Jan 2024 04:18:03 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 12/15] migration: Reference migration state around
 loadvm_postcopy_handle_run_bh
Date: Fri, 26 Jan 2024 12:17:22 +0800
Message-ID: <20240126041725.124562-13-peterx@redhat.com>
In-Reply-To: <20240126041725.124562-1-peterx@redhat.com>
References: <20240126041725.124562-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

We need to hold a reference to the current_migration object around
async calls to avoid it been freed while still in use. Even on this
load-side function, we might still use the MigrationState, e.g to
check for capabilities.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6410705ebe..93387350c7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2174,6 +2174,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     qemu_bh_delete(mis->bh);
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+    object_unref(OBJECT(migration_get_current()));
 }
 
 /* After all discards we can start running and asking for pages */
@@ -2189,6 +2190,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
+    object_ref(OBJECT(migration_get_current()));
     qemu_bh_schedule(mis->bh);
 
     /* We need to finish reading the stream from the package
-- 
2.43.0


