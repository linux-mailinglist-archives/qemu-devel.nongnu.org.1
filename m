Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A244983FC8E
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Jan 2024 04:06:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUHx3-0004Gd-6N; Sun, 28 Jan 2024 22:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHx1-0004GE-Ci
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUHwz-0002d9-Ta
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 22:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706497485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sa2/urw2imMu6/yzcBVCu0Uejg3i9taSytYM/VmmU4A=;
 b=YojnzWa02fTlHwxnHDUJExOzKF9REhyrhqHi8AsnN3AXo0VI7rf1PsAcPcsNsxcxfOFgFf
 OcK+nG9PE9A3buT3Dc+TZJBHhFbgLpcB9SP+zemGTRwipRx7sc8Ho+VolQGxZzq0wLt0UL
 3UYgHXpVzD6XW0242D1zC0GFi4iqznw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-NT2wBNpLMtWLSWNbAirSAA-1; Sun, 28 Jan 2024 22:04:41 -0500
X-MC-Unique: NT2wBNpLMtWLSWNbAirSAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 572A283BA82;
 Mon, 29 Jan 2024 03:04:41 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 151891121306;
 Mon, 29 Jan 2024 03:04:38 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	peterx@redhat.com
Subject: [PULL 09/14] migration: Fix use-after-free of migration state object
Date: Mon, 29 Jan 2024 11:04:00 +0800
Message-ID: <20240129030405.177100-10-peterx@redhat.com>
In-Reply-To: <20240129030405.177100-1-peterx@redhat.com>
References: <20240129030405.177100-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We're currently allowing the process_incoming_migration_bh bottom-half
to run without holding a reference to the 'current_migration' object,
which leads to a segmentation fault if the BH is still live after
migration_shutdown() has dropped the last reference to
current_migration.

In my system the bug manifests as migrate_multifd() returning true
when it shouldn't and multifd_load_shutdown() calling
multifd_recv_terminate_threads() which crashes due to an uninitialized
multifd_recv_state.

Fix the issue by holding a reference to the object when scheduling the
BH and dropping it before returning from the BH. The same is already
done for the cleanup_bh at migrate_fd_cleanup_schedule().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1969
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 219447dea1..cf17b68e57 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -648,6 +648,7 @@ static void process_incoming_migration_bh(void *opaque)
                       MIGRATION_STATUS_COMPLETED);
     qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
+    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -713,6 +714,7 @@ process_incoming_migration_co(void *opaque)
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
+    object_ref(OBJECT(migrate_get_current()));
     qemu_bh_schedule(mis->bh);
     return;
 fail:
-- 
2.43.0


