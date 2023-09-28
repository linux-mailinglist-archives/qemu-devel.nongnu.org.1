Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45097B1E50
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwl-0003fL-Gx; Thu, 28 Sep 2023 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwb-0003bB-97
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008GK-BO
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1wx3hMHdpTkfg39vM7M2+3mipLrjneXf1o32b87rbU=;
 b=aCdgEApRioOKgT1lSmBd9xRBi70FpuwNYEMVcmdZEnU2iTborXKh78/3m9uXG9FNg7V9C/
 Mlr2macyj9H0i9q/kwLH/jz0+c3DbZGoHSmYOf1+AjtN9jXC951ol1G4G3+mOh6dLcPwmR
 p9ZGLw6S61kYEO0EZYffhEXq/i6oepY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-Tcauj3ymMYKLpDxsyGEGdA-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: Tcauj3ymMYKLpDxsyGEGdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49FF93C1392C;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BAF32026D4B;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3557221E6898; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 36/53] migration/rdma: Convert qemu_rdma_exchange_send() to
 Error
Date: Thu, 28 Sep 2023 15:20:02 +0200
Message-ID: <20230928132019.2544702-37-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
---
 migration/rdma.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e0101422d9..f77bf1d453 100644
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
 
@@ -1906,6 +1911,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         ret = qemu_rdma_exchange_get_response(rdma,
                                     &resp, RDMA_CONTROL_READY, RDMA_WRID_READY);
         if (ret < 0) {
+            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
     }
@@ -1916,7 +1922,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     if (resp) {
         ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
         if (ret < 0) {
-            error_report("rdma migration: error posting"
+            error_setg(errp, "rdma migration: error posting"
                     " extra control recv for anticipated result!");
             return -1;
         }
@@ -1927,7 +1933,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        error_report("rdma migration: error posting first control recv!");
+        error_setg(errp, "rdma migration: error posting first control recv!");
         return -1;
     }
 
@@ -1937,7 +1943,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_send_control(rdma, data, head);
 
     if (ret < 0) {
-        error_report("Failed to send control buffer!");
+        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -1949,6 +1955,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
             trace_qemu_rdma_exchange_send_issue_callback();
             ret = callback(rdma);
             if (ret < 0) {
+                error_setg(errp, "FIXME temporary error message");
                 return -1;
             }
         }
@@ -1958,6 +1965,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               resp->type, RDMA_WRID_DATA);
 
         if (ret < 0) {
+            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
 
@@ -2032,6 +2040,7 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
                                int current_index, uint64_t current_addr,
                                uint64_t length)
 {
+    Error *err = NULL;
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
@@ -2117,9 +2126,10 @@ retry:
 
                 compress_to_network(rdma, &comp);
                 ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL);
+                                (uint8_t *) &comp, NULL, NULL, NULL, &err);
 
                 if (ret < 0) {
+                    error_report_err(err);
                     return -1;
                 }
 
@@ -2145,8 +2155,9 @@ retry:
 
             register_to_network(rdma, &reg);
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL);
+                                    &resp, &reg_result_idx, NULL, &err);
             if (ret < 0) {
+                error_report_err(err);
                 return -1;
             }
 
@@ -2845,11 +2856,11 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
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
 
@@ -3917,6 +3928,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                                        uint64_t flags, void *data)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    Error *err = NULL;
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
@@ -3960,9 +3972,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
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
 
@@ -4013,9 +4026,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
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


