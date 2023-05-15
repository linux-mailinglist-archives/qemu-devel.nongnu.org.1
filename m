Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1971703E0C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeLI-0002bs-Gt; Mon, 15 May 2023 15:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeL4-0001oM-4h
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeL2-0005aY-06
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rv0OW6U2taWTBZp3ks0AuejA0Q/nSmNZ/Pvn3eecT5c=;
 b=S9JMN6LxiW/EuhRSwfzUhrd6YpdpaFBQ526U8Hm4iShuYLGXhnxIolOXYK/1Sz2Ef5yVvM
 5QQWq/3J7AS9H0FBzH0scNL7OUB8KV4C58YxoDWpcbQLQK0gyE5h3ZugEWTxAgc2egPl1B
 dSNHukkEf73g0IAsRmPu39lVT6zRidE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-Tu5HA8yyPMy551Q7mUAx1g-1; Mon, 15 May 2023 15:58:28 -0400
X-MC-Unique: Tu5HA8yyPMy551Q7mUAx1g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B4FA2999B29;
 Mon, 15 May 2023 19:58:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B80E492B00;
 Mon, 15 May 2023 19:58:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 16/16] migration/multifd: Compute transferred bytes
 correctly
Date: Mon, 15 May 2023 21:57:09 +0200
Message-Id: <20230515195709.63843-17-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the past, we had to put the in the main thread all the operations
related with sizes due to qemu_file not beeing thread safe.  As now
all counters are atomic, we can update the counters just after the
do the write.  As an aditional bonus, we are able to use the right
value for the compression methods.  Right now we were assuming that
there were no compression at all.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/multifd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index aabf9b6d98..0bf5958a9c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -175,6 +175,7 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg = {};
+    size_t size = sizeof(msg);
     int ret;
 
     msg.magic = cpu_to_be32(MULTIFD_MAGIC);
@@ -182,10 +183,12 @@ static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
     msg.id = p->id;
     memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
 
-    ret = qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp);
+    ret = qio_channel_write_all(p->c, (char *)&msg, size, errp);
     if (ret != 0) {
         return -1;
     }
+    stat64_add(&mig_stats.multifd_bytes, size);
+    stat64_add(&mig_stats.transferred, size);
     return 0;
 }
 
@@ -395,7 +398,6 @@ static int multifd_send_pages(QEMUFile *f)
     static int next_channel;
     MultiFDSendParams *p = NULL; /* make happy gcc */
     MultiFDPages_t *pages = multifd_send_state->pages;
-    uint64_t transferred;
 
     if (qatomic_read(&multifd_send_state->exiting)) {
         return -1;
@@ -430,10 +432,7 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-    transferred = ((uint64_t) pages->num) * p->page_size + p->packet_len;
     qemu_mutex_unlock(&p->mutex);
-    stat64_add(&mig_stats.transferred, transferred);
-    stat64_add(&mig_stats.multifd_bytes, transferred);
     qemu_sem_post(&p->sem);
 
     return 1;
@@ -715,6 +714,8 @@ static void *multifd_send_thread(void *opaque)
                 if (ret != 0) {
                     break;
                 }
+                stat64_add(&mig_stats.multifd_bytes, p->packet_len);
+                stat64_add(&mig_stats.transferred, p->packet_len);
             } else {
                 /* Send header using the same writev call */
                 p->iov[0].iov_len = p->packet_len;
@@ -727,6 +728,8 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
+            stat64_add(&mig_stats.multifd_bytes, p->next_packet_size);
+            stat64_add(&mig_stats.transferred, p->next_packet_size);
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.40.1


