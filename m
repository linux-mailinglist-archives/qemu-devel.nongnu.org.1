Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED87C4F29
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRM-0001de-IP; Wed, 11 Oct 2023 05:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRK-0001Xu-Ri
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRI-00054A-7h
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rJQM2S1S+jNX6mfr3SnacCoj2GF/dQWd8Ho6CSSFaw=;
 b=QxVJ/MG33AFjWHc+hYfSiaUk8ICogqWsdxBhFLtWNckMw+wwVRZt+L4M3T3WiJA10PHk1I
 erp1QCz8bNnAQPHmUljib8QAhD976zTs86wIoNPh9lUR+4pV/ggv+nNsrLbrrGzthzvwKT
 K401QPYmdIxSzccrHAsemwkXcvyvM6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-YINI_10iNiOxBOCMKgIEQw-1; Wed, 11 Oct 2023 05:23:34 -0400
X-MC-Unique: YINI_10iNiOxBOCMKgIEQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3A023814594;
 Wed, 11 Oct 2023 09:23:33 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 402DF1C060B1;
 Wed, 11 Oct 2023 09:23:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 43/65] migration/rdma: Convert qemu_rdma_exchange_send() to
 Error
Date: Wed, 11 Oct 2023 11:21:41 +0200
Message-ID: <20231011092203.1266-44-quintela@redhat.com>
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qio_channel_rdma_writev() violates this principle: it calls
error_report() via qemu_rdma_exchange_send().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_exchange_send() to Error.

Necessitates setting an error when qemu_rdma_post_recv_control(),
callback(), or qemu_rdma_exchange_get_response() failed.  Since these
errors will go away later in this series, simply use "FIXME temporary
error message" there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-37-armbru@redhat.com>
---
 migration/rdma.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b13fec6328..7866cf9bb7 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -518,7 +518,8 @@ static void network_to_result(RDMARegisterResult *result)
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    uint8_t *data, RDMAControlHeader *resp,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma));
+                                   int (*callback)(RDMAContext *rdma),
+                                   Error **errp);
 
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
@@ -1376,6 +1377,8 @@ static int qemu_rdma_reg_control(RDMAContext *rdma, int idx)
  */
 static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
 {
+    Error *err = NULL;
+
     while (rdma->unregistrations[rdma->unregister_current]) {
         int ret;
         uint64_t wr_id = rdma->unregistrations[rdma->unregister_current];
@@ -1438,8 +1441,9 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
         reg.key.chunk = chunk;
         register_to_network(rdma, &reg);
         ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                &resp, NULL, NULL);
+                                      &resp, NULL, NULL, &err);
         if (ret < 0) {
+            error_report_err(err);
             return -1;
         }
 
@@ -1893,7 +1897,8 @@ static void qemu_rdma_move_header(RDMAContext *rdma, int idx,
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    uint8_t *data, RDMAControlHeader *resp,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma))
+                                   int (*callback)(RDMAContext *rdma),
+                                   Error **errp)
 {
     int ret;
 
@@ -1908,6 +1913,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               RDMA_CONTROL_READY,
                                               RDMA_WRID_READY);
         if (ret < 0) {
+            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
     }
@@ -1918,7 +1924,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     if (resp) {
         ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
         if (ret < 0) {
-            error_report("rdma migration: error posting"
+            error_setg(errp, "rdma migration: error posting"
                     " extra control recv for anticipated result!");
             return -1;
         }
@@ -1929,7 +1935,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        error_report("rdma migration: error posting first control recv!");
+        error_setg(errp, "rdma migration: error posting first control recv!");
         return -1;
     }
 
@@ -1939,7 +1945,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_send_control(rdma, data, head);
 
     if (ret < 0) {
-        error_report("Failed to send control buffer!");
+        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -1951,6 +1957,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
             trace_qemu_rdma_exchange_send_issue_callback();
             ret = callback(rdma);
             if (ret < 0) {
+                error_setg(errp, "FIXME temporary error message");
                 return -1;
             }
         }
@@ -1960,6 +1967,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               resp->type, RDMA_WRID_DATA);
 
         if (ret < 0) {
+            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
 
@@ -2034,6 +2042,7 @@ static int qemu_rdma_write_one(RDMAContext *rdma,
                                int current_index, uint64_t current_addr,
                                uint64_t length)
 {
+    Error *err = NULL;
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
@@ -2119,9 +2128,10 @@ retry:
 
                 compress_to_network(rdma, &comp);
                 ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL);
+                                (uint8_t *) &comp, NULL, NULL, NULL, &err);
 
                 if (ret < 0) {
+                    error_report_err(err);
                     return -1;
                 }
 
@@ -2156,8 +2166,9 @@ retry:
 
             register_to_network(rdma, &reg);
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL);
+                                    &resp, &reg_result_idx, NULL, &err);
             if (ret < 0) {
+                error_report_err(err);
                 return -1;
             }
 
@@ -2864,11 +2875,11 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
             head.len = len;
             head.type = RDMA_CONTROL_QEMU_FILE;
 
-            ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
+            ret = qemu_rdma_exchange_send(rdma, &head,
+                                          data, NULL, NULL, NULL, errp);
 
             if (ret < 0) {
                 rdma->errored = true;
-                error_setg(errp, "qemu_rdma_exchange_send failed");
                 return -1;
             }
 
@@ -3925,6 +3936,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                                        uint64_t flags, void *data)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    Error *err = NULL;
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
@@ -3968,9 +3980,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
          */
         ret = qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
                     &reg_result_idx, rdma->pin_all ?
-                    qemu_rdma_reg_whole_ram_blocks : NULL);
+                    qemu_rdma_reg_whole_ram_blocks : NULL,
+                    &err);
         if (ret < 0) {
-            fprintf(stderr, "receiving remote info!");
+            error_report_err(err);
             return -1;
         }
 
@@ -4021,9 +4034,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     trace_qemu_rdma_registration_stop(flags);
 
     head.type = RDMA_CONTROL_REGISTER_FINISHED;
-    ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL);
+    ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, &err);
 
     if (ret < 0) {
+        error_report_err(err);
         goto err;
     }
 
-- 
2.41.0


