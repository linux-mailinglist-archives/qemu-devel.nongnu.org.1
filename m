Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 237EF7B1E11
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwh-0003du-6P; Thu, 28 Sep 2023 09:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwQ-0003Rk-Gn
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwL-00088n-Kq
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSeyBBF83WKQT61d7meoz63CWSVi3+abXWDIn7AgGhU=;
 b=fsSxO5oylVgu8P1UE3OWdAMN7E8mQ08ny0ej36gnM7KUMIbUsron0Cmm2NEgse9uVFcKCh
 4lFvgRLrex/tj/uqNzu6vUs2aHo68L6vshg+h0fLTwYUF90OFsGZI4up4tYBPEOWeq38mH
 haRYxw5+HcDvVR1P1mzACqrnFl0Focc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-S0P1pZRrN5eUHxMY2lJWZg-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: S0P1pZRrN5eUHxMY2lJWZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B185858F1B;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECBFC2156711;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0149221E6880; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 18/53] migration/rdma: Fix io_writev(),
 io_readv() methods to obey contract
Date: Thu, 28 Sep 2023 15:19:44 +0200
Message-ID: <20230928132019.2544702-19-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

QIOChannelClass methods qio_channel_rdma_readv() and
qio_channel_rdma_writev() violate their method contract when
rdma->error_state is non-zero:

1. They return whatever is in rdma->error_state then.  Only -1 will be
   fine.  -2 will be misinterpreted as "would block".  Anything less
   than -2 isn't defined in the contract.  A positive value would be
   misinterpreted as success, but I believe that's not actually
   possible.

2. They neglect to set an error then.  If something up the call stack
   dereferences the error when failure is returned, it will crash.  If
   it ignores the return value and checks the error instead, it will
   miss the error.

Crap like this happens when return statements hide in macros,
especially when their uses are far away from the definition.

I elected not to investigate how callers are impacted.

Expand the two bad macro uses, so we can set an error and return -1.
The next commit will then get rid of the macro altogether.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0d2d119e6a..fb89b89e80 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2791,7 +2791,11 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    CHECK_ERROR_STATE();
+    if (rdma->error_state) {
+        error_setg(errp,
+                   "RDMA is in an error state waiting migration to abort!");
+        return -1;
+    }
 
     /*
      * Push out any writes that
@@ -2877,7 +2881,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         return -1;
     }
 
-    CHECK_ERROR_STATE();
+    if (rdma->error_state) {
+        error_setg(errp,
+                   "RDMA is in an error state waiting migration to abort!");
+        return -1;
+    }
 
     for (i = 0; i < niov; i++) {
         size_t want = iov[i].iov_len;
-- 
2.41.0


