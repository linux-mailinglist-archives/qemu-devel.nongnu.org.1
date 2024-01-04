Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5217823B7D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFRJ-000509-VJ; Wed, 03 Jan 2024 23:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFR2-0004jz-SL
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQz-0006kg-LL
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIIkk4Ue2v4Wf9MQGpGUsHUucPOijO16PEsvA6ywQwk=;
 b=aLDpGRaQaTqJ3/AGyBQWBW0RZJS6s6VsOv0W0MOHLn9GIkVxBHvj6YMiOgA8GtCltUxZve
 K4kXOo6HL1sF9anaNvVs1meG5RZqtdMquTl+kWtqf/b7GfeNDBbZVz9HArp5QQYYf9iK3G
 9tvT1EdLj7Ag4HEzTbsICenGgzvCq7Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-DG605HFVM3K-FkS8jw1uWg-1; Wed,
 03 Jan 2024 23:34:17 -0500
X-MC-Unique: DG605HFVM3K-FkS8jw1uWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D0F29AA390;
 Thu,  4 Jan 2024 04:34:17 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8ECEC15A0C;
 Thu,  4 Jan 2024 04:34:13 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 24/26] migration: Remove unnecessary usage of local Error
Date: Thu,  4 Jan 2024 12:32:09 +0800
Message-ID: <20240104043213.431566-25-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

According to Error API, usage of ERRP_GUARD() or a local Error instead
of errp is needed if errp is passed to void functions, where it is later
dereferenced to see if an error occurred.

There are several places in migration.c that use local Error although it
is not needed. Change these places to use errp directly.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20231231093016.14204-11-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9524c22a50..454cd4ec1f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -830,10 +830,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
          * issue is not possible.
          */
         ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
-                                          sizeof(channel_magic), &local_err);
+                                          sizeof(channel_magic), errp);
 
         if (ret != 0) {
-            error_propagate(errp, local_err);
             return;
         }
 
@@ -1825,8 +1824,6 @@ bool migration_is_blocked(Error **errp)
 static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                             bool resume, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (blk_inc) {
         warn_report("parameter 'inc' is deprecated;"
                     " use blockdev-mirror with NBD instead");
@@ -1896,8 +1893,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                        "current migration capabilities");
             return false;
         }
-        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
             return false;
         }
         s->must_remove_block_options = true;
-- 
2.41.0


