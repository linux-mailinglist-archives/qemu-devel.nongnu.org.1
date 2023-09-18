Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2E97A4B28
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSz-0003Dz-1k; Mon, 18 Sep 2023 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002yD-GF
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bJ-Pf
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MekCpRJ0UTZUfcihTqFMKa+lcRtdtyas5aHLXosjyqA=;
 b=UDdtbCbcNni2sRkyHXVT7a005a+po1i/6GO48nIn/NVIaj0/v07I0U6mrfakekWIFBfJwu
 +0kkyKNvCywH8MazW5LdvS0yg/n8kokcZYX1JaG6mC4Ovu4YD7JwFcWXIwctt29em7Drow
 cYRxAgN2uP+/Gujxmjr+lsRT12puqmI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-BJ4Bh03JOAu4thYOemANpg-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: BJ4Bh03JOAu4thYOemANpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 563C129AA2C5
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33EC6C154CA
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3CE1321E6890; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 29/52] migration/rdma: Plug a memory leak and improve a message
Date: Mon, 18 Sep 2023 16:41:43 +0200
Message-ID: <20230918144206.560120-30-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6c643a1b30..d52de857c5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2586,8 +2586,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
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


