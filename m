Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8286DDFF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 10:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfyzQ-0000NH-CE; Fri, 01 Mar 2024 04:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfyzN-0000Mz-Kg
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:15:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfyzL-0002HT-W5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709284530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ShIyOijF5hDb5xUYMjV46WkJwgk4IDv/i3PR+jIa9ZU=;
 b=JkxjvTefvaJYlEEc75G+eye1HfQz6zrb67e+epXbm22JBMRjHCBnW7t766AOsK+zqNryyC
 beXfKY2btwV6JaPRgXbbe84K84jGH/xWkDlx6EfvDj0pZrm+3uE7SNKyHHDcveYMmryhVE
 N19RDad0/v9yEF8FgCPHkvlrpDD5v68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-uaWFUDB4PteAADNMvSEd9w-1; Fri, 01 Mar 2024 04:15:29 -0500
X-MC-Unique: uaWFUDB4PteAADNMvSEd9w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CE9986C043;
 Fri,  1 Mar 2024 09:15:29 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 544A6492BC6;
 Fri,  1 Mar 2024 09:15:25 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com
Subject: [PATCH] migration/multifd: Document two places for mapped-ram
Date: Fri,  1 Mar 2024 17:15:24 +0800
Message-ID: <20240301091524.39900-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Add two documentations for mapped-ram migration on two spots that may not
be extremely clear.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
Based-on: <20240229153017.2221-1-farosas@suse.de>
---
 migration/multifd.c | 12 ++++++++++++
 migration/ram.c     |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b4e5a9dfcc..2942395ce2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -709,6 +709,18 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 {
     if (p->c) {
         migration_ioc_unregister_yank(p->c);
+        /*
+         * An explicitly close() on the channel here is normally not
+         * required, but can be helpful for "file:" iochannels, where it
+         * will include an fdatasync() to make sure the data is flushed to
+         * the disk backend.
+         *
+         * The object_unref() cannot guarantee that because: (1) finalize()
+         * of the iochannel is only triggered on the last reference, and
+         * it's not guaranteed that we always hold the last refcount when
+         * reaching here, and, (2) even if finalize() is invoked, it only
+         * does a close(fd) without data flush.
+         */
         qio_channel_close(p->c, &error_abort);
         object_unref(OBJECT(p->c));
         p->c = NULL;
diff --git a/migration/ram.c b/migration/ram.c
index 1f1b5297cf..c79e3de521 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4258,7 +4258,13 @@ static int ram_load_precopy(QEMUFile *f)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
             ret = parse_ramblocks(f, addr);
-
+            /*
+             * For mapped-ram migration (to a file) using multifd, we sync
+             * once and for all here to make sure all tasks we queued to
+             * multifd threads are completed, so that all the ramblocks
+             * (including all the guest memory pages within) are fully
+             * loaded after this sync returns.
+             */
             if (migrate_mapped_ram()) {
                 multifd_recv_sync_main();
             }
-- 
2.44.0


