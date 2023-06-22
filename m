Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C36739571
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9rO-0001tr-Mu; Wed, 21 Jun 2023 22:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qf-0008BR-UB
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9qd-0005CU-Fu
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbmZd/0GUxBNkX2GKrDTd/Dukt5lTkWbqA7HJxboR+k=;
 b=SW5TzrPnl/LThpv+IWTqscj1UoOuL5daygmJzjI1j0m5zudA6ZTja1KWkzqsn8ylNqtqiN
 TPFRlfleluUMZavUZzFVpBM4d+rKmFx8TK3rcBIxJlC5Z431sma7uJJpPAJsZ9u6oS7/ZB
 C4UU1AThn92U/BT4p1d+nlalRSMLyTo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-bhtVvbNLPWWET1mXmwNFFw-1; Wed, 21 Jun 2023 22:14:55 -0400
X-MC-Unique: bhtVvbNLPWWET1mXmwNFFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 983B73C10145;
 Thu, 22 Jun 2023 02:14:54 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C424112132C;
 Thu, 22 Jun 2023 02:14:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 26/30] migration: Use qemu_file_transferred_noflush() for block
 migration.
Date: Thu, 22 Jun 2023 04:13:16 +0200
Message-Id: <20230622021320.66124-27-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We only care about the amount of bytes transferred.  Flushing is done
by the system somewhere else.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230530183941.7223-4-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index b9580a6c7e..b29e80bdc4 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -748,7 +748,7 @@ static int block_save_setup(QEMUFile *f, void *opaque)
 static int block_save_iterate(QEMUFile *f, void *opaque)
 {
     int ret;
-    uint64_t last_bytes = qemu_file_transferred(f);
+    uint64_t last_bytes = qemu_file_transferred_noflush(f);
 
     trace_migration_block_save("iterate", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -800,7 +800,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-    uint64_t delta_bytes = qemu_file_transferred(f) - last_bytes;
+    uint64_t delta_bytes = qemu_file_transferred_noflush(f) - last_bytes;
     return (delta_bytes > 0);
 }
 
-- 
2.40.1


