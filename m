Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4957B1E23
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwo-0003gq-J1; Thu, 28 Sep 2023 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwY-0003ZQ-TJ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwO-0008Fc-IS
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sG6Qx0S3rjdug66QRlVWtj2oS+HNlSyxhEJMsz5r45Q=;
 b=HNuqG4fDG3JZdx7REBJI9Kv8puR8FLojXq25z56zfNw2lMKw1HWvgFiRdAX4VRotQlzPw3
 gaHz0HVweJ1NRiVgENoXGPs5B5WBWTaNhZTw2ycelM+NHHdBBIKQB8KZ6ml97CqGJbWmeT
 /gx9QyjVRnICPs003AecmKvHRLKGg7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-e38rZNf6MnWXKR2mFBSgsg-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: e38rZNf6MnWXKR2mFBSgsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60ACA185A79C;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E30114171CB;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 240D021E6892; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 30/53] migration/rdma: Plug a memory leak and improve a
 message
Date: Thu, 28 Sep 2023 15:19:56 +0200
Message-ID: <20230928132019.2544702-31-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c57692e5a3..54f4a917be 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2617,8 +2617,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
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


