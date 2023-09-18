Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0087A4B21
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSR-00031z-Ag; Mon, 18 Sep 2023 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSG-0002vq-QA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS0-0002aB-77
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3YFq6ZYnpRRZBWPjb4B2QXVYn/9fVVoiH9j7gD/gR4=;
 b=OM40Cb5/hiWE47h/CISEuyVJNDIgqH9KUn0cA45wJ8Ubj00XUi4btktd79B+MVtT3jRKLE
 +5I9Ga4kk8p/ryyxdlbrv13/T6uxlIHRfR4UuaS8tvsOl+wCrjom27tQYGXR8l1jALaq0B
 cpFP2zH3F1i3CvY5xeD9lxbxLf0pAMs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-kHKx9dROPhiw3pCW5gRiog-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: kHKx9dROPhiw3pCW5gRiog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 233D529AA3BF
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0117C1005E27
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EEC5F21E690C; Mon, 18 Sep 2023 16:42:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 06/52] migration/rdma: Clean up two more harmless signed vs.
 unsigned issues
Date: Mon, 18 Sep 2023 16:41:20 +0200
Message-ID: <20230918144206.560120-7-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu_rdma_exchange_get_response() compares int parameter @expecting
with uint32_t head->type.  Actual arguments are non-negative
enumeration constants, RDMAControlHeader uint32_t member type, or
qemu_rdma_exchange_recv() int parameter expecting.  Actual arguments
for the latter are non-negative enumeration constants.  Change both
parameters to uint32_t.

In qio_channel_rdma_readv(), loop control variable @i is ssize_t, and
counts from 0 up to @niov, which is size_t.  Change @i to size_t.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4328610a4c..e3b8d0506c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1801,7 +1801,7 @@ static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
  * Block and wait for a RECV control channel message to arrive.
  */
 static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
-                RDMAControlHeader *head, int expecting, int idx)
+                RDMAControlHeader *head, uint32_t expecting, int idx)
 {
     uint32_t byte_len;
     int ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RECV_CONTROL + idx,
@@ -1959,7 +1959,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
  * control-channel message.
  */
 static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
-                                int expecting)
+                                   uint32_t expecting)
 {
     RDMAControlHeader ready = {
                                 .len = 0,
@@ -2851,7 +2851,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     RDMAContext *rdma;
     RDMAControlHeader head;
     int ret = 0;
-    ssize_t i;
+    size_t i;
     size_t done = 0;
 
     RCU_READ_LOCK_GUARD();
-- 
2.41.0


