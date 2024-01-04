Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEA823B7E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQT-0003Iu-Ln; Wed, 03 Jan 2024 23:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQR-00037S-I4
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQP-0006fi-W9
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rnk2maPq+bSGItFG+Z0n+FGuFwgdzYVZMOX86HeQM6Q=;
 b=WTsygflArtvtYmeS5MRXrD+VL2aRyyuentOun4g4cZ62PMuUZj+a3bnFUd6zYEvtn4MLdC
 HFWuoT5RY42G7o0agUpc3SOuayRBWdEN/G5XCbfD5F7ChOHSJhBydw80+vatQKeYqC9xAy
 nBW5FIZGwCIjNqv9yWLV7y5rw44msyk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-s3SGKsMxPCeEfg4skg70xA-1; Wed,
 03 Jan 2024 23:33:44 -0500
X-MC-Unique: s3SGKsMxPCeEfg4skg70xA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC1A23816D84;
 Thu,  4 Jan 2024 04:33:43 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E919C15968;
 Thu,  4 Jan 2024 04:33:38 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/26] migration: Refactor migration_incoming_setup()
Date: Thu,  4 Jan 2024 12:32:02 +0800
Message-ID: <20240104043213.431566-18-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

From: Avihai Horon <avihaih@nvidia.com>

Commit 6720c2b32725 ("migration: check magic value for deciding the
mapping of channels") extracted the only code that could fail in
migration_incoming_setup().

Now migration_incoming_setup() can't fail, so refactor it to return void
and remove errp parameter.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20231231093016.14204-4-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 15dc8aa21c..e7d342ab59 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -724,11 +724,8 @@ fail:
 /**
  * migration_incoming_setup: Setup incoming migration
  * @f: file for main migration channel
- * @errp: where to put errors
- *
- * Returns: %true on success, %false on error.
  */
-static bool migration_incoming_setup(QEMUFile *f, Error **errp)
+static void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -736,7 +733,6 @@ static bool migration_incoming_setup(QEMUFile *f, Error **errp)
         mis->from_src_file = f;
     }
     qemu_file_set_blocking(f, false);
-    return true;
 }
 
 void migration_incoming_process(void)
@@ -780,9 +776,7 @@ static bool postcopy_try_recover(void)
 
 void migration_fd_process_incoming(QEMUFile *f, Error **errp)
 {
-    if (!migration_incoming_setup(f, errp)) {
-        return;
-    }
+    migration_incoming_setup(f);
     if (postcopy_try_recover()) {
         return;
     }
@@ -855,10 +849,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 
     if (default_channel) {
         f = qemu_file_new_input(ioc);
-
-        if (!migration_incoming_setup(f, errp)) {
-            return;
-        }
+        migration_incoming_setup(f);
     } else {
         /* Multiple connections */
         assert(migration_needs_multiple_sockets());
-- 
2.41.0


