Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932D73A6AF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:57:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNcF-0001Rt-Q6; Thu, 22 Jun 2023 12:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNc7-0000z9-Tb
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNc6-0001bI-Ec
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687453013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbmZd/0GUxBNkX2GKrDTd/Dukt5lTkWbqA7HJxboR+k=;
 b=acGL+bcIK9Gn7ls8RWc01HlBuoeCXicnW9k4yl9coVCjphIInlTznGz9BOWTU9ssW1zuV/
 TzO9Lu4ljjrXl7rcW/fOPhyH4BbewuxjbP6U/+wn+Nzpo25OudK7hegR9lX9F34Ye0Zrzi
 WEJPughSFnmZbFG6m+z+gh/BwDZrjDo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-WRYDQQI6PIKlAGBjWycddA-1; Thu, 22 Jun 2023 12:56:45 -0400
X-MC-Unique: WRYDQQI6PIKlAGBjWycddA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29DE71C07250;
 Thu, 22 Jun 2023 16:56:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A91EC00049;
 Thu, 22 Jun 2023 16:56:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 26/30] migration: Use qemu_file_transferred_noflush() for block
 migration.
Date: Thu, 22 Jun 2023 18:55:23 +0200
Message-Id: <20230622165527.2417-27-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


