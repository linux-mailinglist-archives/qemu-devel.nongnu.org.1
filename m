Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463087B1E1E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwq-0003gy-QN; Thu, 28 Sep 2023 09:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwS-0003TU-OB
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwM-0008An-E5
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON7IO5ivCVC9AGVzZpLWa3v/90xMndv3sSh0NL3cuGg=;
 b=RWvuccQB0vq7/htmRGM7zNh7GkuZU1Bi/bwAw7OLiMYjaAz6sB1+L7XoTVV+DmuPMOMxVr
 T7LTx4rcFFvuFjnaITOYJbGI/Nlao9SCjJVxwQkWwb8vQQOG4NleysF6OTEetA+654PsX9
 JHFcPiFWZmBXDBVttRB68CVIcA5aV6k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-1nikscxFP7G4Wmu7KTTbzw-1; Thu, 28 Sep 2023 09:20:22 -0400
X-MC-Unique: 1nikscxFP7G4Wmu7KTTbzw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CC59280A9CB;
 Thu, 28 Sep 2023 13:20:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE31114171B6;
 Thu, 28 Sep 2023 13:20:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1CB021E690E; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 06/53] migration/rdma: Fix unwanted integer truncation
Date: Thu, 28 Sep 2023 15:19:32 +0200
Message-ID: <20230928132019.2544702-7-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qio_channel_rdma_readv() assigns the size_t value of qemu_rdma_fill()
to an int variable before it adds it to @done / subtracts it from
@want, both size_t.  Truncation when qemu_rdma_fill() copies more than
INT_MAX bytes.  Seems vanishingly unlikely, but needs fixing all the
same.

Fixes: 6ddd2d76ca6f (migration: convert RDMA to use QIOChannel interface)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4289346617..5f423f66f0 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2852,7 +2852,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     RDMAControlHeader head;
     int ret = 0;
     ssize_t i;
-    size_t done = 0;
+    size_t done = 0, len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmain);
@@ -2873,9 +2873,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
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
@@ -2902,9 +2902,9 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
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


