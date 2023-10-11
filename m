Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CF7C4F2A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRp-0004P1-OJ; Wed, 11 Oct 2023 05:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRm-0004IQ-Kg
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRl-0005Br-1H
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J31vCvoZejcF4wP9ygnbOMccMNISYw3I+jojPbB4nDA=;
 b=g3h2D7gFa1TNHrJxOY08TyJAzGfRON8iDnQV3pZ0TrijAMyySUD32IMgTs+v5g+9isk/3c
 JbSP+c8eUORWCnJnd+wrRvFmoU1InUEQf8fT9sSIRmwa21S8e/lSKwFgT1YScwkoeLjOjh
 hk1ysFV3l9wTwo0/8XSpqncmO8ck40U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-vfVoHF9gMka4ur0QYJPlrA-1; Wed, 11 Oct 2023 05:24:02 -0400
X-MC-Unique: vfVoHF9gMka4ur0QYJPlrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C3B48002B2;
 Wed, 11 Oct 2023 09:24:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BA511C060AE;
 Wed, 11 Oct 2023 09:24:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 57/65] migration/rdma: Silence qemu_rdma_register_and_get_keys()
Date: Wed, 11 Oct 2023 11:21:55 +0200
Message-ID: <20231011092203.1266-58-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_write_one() violates this principle: it reports errors to
stderr via qemu_rdma_register_and_get_keys().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up: silence qemu_rdma_register_and_get_keys().  I believe
the caller's error reports suffice.  If they don't, we need to convert
to Error instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-51-armbru@redhat.com>
---
 migration/rdma.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 459dcb002e..025523bf70 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1325,15 +1325,6 @@ static int qemu_rdma_register_and_get_keys(RDMAContext *rdma,
         }
     }
     if (!block->pmr[chunk]) {
-        perror("Failed to register chunk!");
-        fprintf(stderr, "Chunk details: block: %d chunk index %d"
-                        " start %" PRIuPTR " end %" PRIuPTR
-                        " host %" PRIuPTR
-                        " local %" PRIuPTR " registrations: %d\n",
-                        block->index, chunk, (uintptr_t)chunk_start,
-                        (uintptr_t)chunk_end, host_addr,
-                        (uintptr_t)block->local_host_addr,
-                        rdma->total_registrations);
         return -1;
     }
     rdma->total_registrations++;
-- 
2.41.0


