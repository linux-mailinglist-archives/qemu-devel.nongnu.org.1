Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E47C4F33
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQO-0007E9-Cp; Wed, 11 Oct 2023 05:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQM-0007Du-Sa
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQL-0004tf-BN
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjlQfIKv4YKm1KMlF3w026V9nxB7zjyOMFMS59vJuNI=;
 b=SL4vJJ+PBib4xqsI+QjBAIe+cZEGc6E1iXko7ulQ9LSrZAzA6UoLgx0u8/X4YLqZ7b4BwM
 X1VFdwP09T/Xn1TyD9BbqNYjB2qz9rjcvwc87rhwZi6jwO+aoiS9dI25sELjKtkAg823bX
 j7see6Mn/CfOg2oTSfxGZnT7kkDoGww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-4XtVz6UcNyOF87S7v3ZEcw-1; Wed, 11 Oct 2023 05:22:33 -0400
X-MC-Unique: 4XtVz6UcNyOF87S7v3ZEcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2AE185A78E;
 Wed, 11 Oct 2023 09:22:33 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81E311C060AE;
 Wed, 11 Oct 2023 09:22:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 13/65] migration/rdma: Fix unwanted integer truncation
Date: Wed, 11 Oct 2023 11:21:11 +0200
Message-ID: <20231011092203.1266-14-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

qio_channel_rdma_readv() assigns the size_t value of qemu_rdma_fill()
to an int variable before it adds it to @done / subtracts it from
@want, both size_t.  Truncation when qemu_rdma_fill() copies more than
INT_MAX bytes.  Seems vanishingly unlikely, but needs fixing all the
same.

Fixes: 6ddd2d76ca6f (migration: convert RDMA to use QIOChannel interface)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-7-armbru@redhat.com>
---
 migration/rdma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d1e727f30b..ff8e475f59 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2871,7 +2871,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     RDMAControlHeader head;
     int ret = 0;
     ssize_t i;
-    size_t done = 0;
+    size_t done = 0, len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmain);
@@ -2892,9 +2892,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
          * were given and dish out the bytes until we run
          * out of bytes.
          */
-        ret = qemu_rdma_fill(rdma, data, want, 0);
-        done += ret;
-        want -= ret;
+        len = qemu_rdma_fill(rdma, data, want, 0);
+        done += len;
+        want -= len;
         /* Got what we needed, so go to next iovec */
         if (want == 0) {
             continue;
@@ -2921,9 +2921,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         /*
          * SEND was received with new bytes, now try again.
          */
-        ret = qemu_rdma_fill(rdma, data, want, 0);
-        done += ret;
-        want -= ret;
+        len = qemu_rdma_fill(rdma, data, want, 0);
+        done += len;
+        want -= len;
 
         /* Still didn't get enough, so lets just return */
         if (want) {
-- 
2.41.0


