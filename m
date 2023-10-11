Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EEA7C4E88
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRF-0000gB-H3; Wed, 11 Oct 2023 05:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRB-0000Bg-6d
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR9-000530-H0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnzUPUxq5fkgci/LmM13J/PDYHUd+i3NlZVWG1qg7Sg=;
 b=bCNJ/KXhwywksSxv+SSn6g+1A+3IneAPI2hs0K+Ka0OXITOtefsW/QSy7ZlzkUG1PZahdv
 VGIXLmUJTK62sRR9dWVQdV8aH7ylZyGry2ksd3IUwtqyKiICpONpJ8qAJJ7R/t0bGGHXii
 z1NORvpiOak3/6Cdj38oD026HLAVuWY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-hY8YvW-YMQivwdNJ_KanGw-1; Wed, 11 Oct 2023 05:23:21 -0400
X-MC-Unique: hY8YvW-YMQivwdNJ_KanGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 527AB3C0E667;
 Wed, 11 Oct 2023 09:23:21 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95B4A1C060AE;
 Wed, 11 Oct 2023 09:23:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 37/65] migration/rdma: Plug a memory leak and improve a message
Date: Wed, 11 Oct 2023 11:21:35 +0200
Message-ID: <20231011092203.1266-38-quintela@redhat.com>
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

When migration capability @rdma-pin-all is true, but the server cannot
honor it, qemu_rdma_connect() calls macro ERROR(), then returns
success.

ERROR() sets an error.  Since qemu_rdma_connect() returns success, its
caller rdma_start_outgoing_migration() duly assumes @errp is still
clear.  The Error object leaks.

ERROR() additionally reports the situation to the user as an error:

    RDMA ERROR: Server cannot support pinning all memory. Will register memory dynamically.

Is this an error or not?  It actually isn't; we disable @rdma-pin-all
and carry on.  "Correcting" the user's configuration decisions that
way feels problematic, but that's a topic for another day.

Replace ERROR() by warn_report().  This plugs the memory leak, and
emits a clearer message to the user.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-31-armbru@redhat.com>
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b0125b01cf..00e3c430f4 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2637,8 +2637,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
      * and disable them otherwise.
      */
     if (rdma->pin_all && !(cap.flags & RDMA_CAPABILITY_PIN_ALL)) {
-        ERROR(errp, "Server cannot support pinning all memory. "
-                        "Will register memory dynamically.");
+        warn_report("RDMA: Server cannot support pinning all memory. "
+                    "Will register memory dynamically.");
         rdma->pin_all = false;
     }
 
-- 
2.41.0


