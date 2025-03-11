Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E37A5C2A9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 14:29:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzem-0004Vm-5T; Tue, 11 Mar 2025 09:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdc-0002kP-4n
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdV-0005Hl-Pz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3EZmGUp+mWY/UUw13gvrqgslZdCixQZtPNNeV29Mkk=;
 b=Mhn3nLrMCT7UyGKHRJqA+pRYZCF1v1Zuo9gqyMm30BNDs8cocbIknR5fIpaI4TxDnruhRC
 eFY4ehWHUUCdleNAVgwpxC9viE+2f2M9PZcEOZE5v2UkjYUPHSvXkLvlyweZ4zFL37uNNZ
 ueRkcoE4Col/uzF4yDg2DzL9xGhUgAk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-Ud084b90PMS3uRH-OaFBig-1; Tue,
 11 Mar 2025 09:27:05 -0400
X-MC-Unique: Ud084b90PMS3uRH-OaFBig-1
X-Mimecast-MFC-AGG-ID: Ud084b90PMS3uRH-OaFBig_1741699624
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A890180AF7B; Tue, 11 Mar 2025 13:27:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 103F73001D12; Tue, 11 Mar 2025 13:27:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 09/13] virtio-blk: tidy up iothread_vq_mapping functions
Date: Tue, 11 Mar 2025 21:26:12 +0800
Message-ID: <20250311132616.1049687-10-stefanha@redhat.com>
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use noun_verb() function naming instead of verb_noun() because the
former is the most common naming style for APIs. The next commit will
move these functions into a header file so that virtio-scsi can call
them.

Shorten iothread_vq_mapping_apply()'s iothread_vq_mapping_list argument
to just "list" like in the other functions.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 21b1b768ed..6bf7b50520 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1424,8 +1424,8 @@ static const BlockDevOps virtio_block_ops = {
 };
 
 static bool
-validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
-        uint16_t num_queues, Error **errp)
+iothread_vq_mapping_validate(IOThreadVirtQueueMappingList *list, uint16_t
+        num_queues, Error **errp)
 {
     g_autofree unsigned long *vqs = bitmap_new(num_queues);
     g_autoptr(GHashTable) iothreads =
@@ -1486,22 +1486,22 @@ validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
 }
 
 /**
- * apply_iothread_vq_mapping:
- * @iothread_vq_mapping_list: The mapping of virtqueues to IOThreads.
+ * iothread_vq_mapping_apply:
+ * @list: The mapping of virtqueues to IOThreads.
  * @vq_aio_context: The array of AioContext pointers to fill in.
  * @num_queues: The length of @vq_aio_context.
  * @errp: If an error occurs, a pointer to the area to store the error.
  *
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
- * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
+ * the iothread-vq-mapping parameter in @list.
  *
- * cleanup_iothread_vq_mapping() must be called to free IOThread object
+ * iothread_vq_mapping_cleanup() must be called to free IOThread object
  * references after this function returns success.
  *
  * Returns: %true on success, %false on failure.
  **/
-static bool apply_iothread_vq_mapping(
-        IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
+static bool iothread_vq_mapping_apply(
+        IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
         Error **errp)
@@ -1510,16 +1510,15 @@ static bool apply_iothread_vq_mapping(
     size_t num_iothreads = 0;
     size_t cur_iothread = 0;
 
-    if (!validate_iothread_vq_mapping_list(iothread_vq_mapping_list,
-                                           num_queues, errp)) {
+    if (!iothread_vq_mapping_validate(list, num_queues, errp)) {
         return false;
     }
 
-    for (node = iothread_vq_mapping_list; node; node = node->next) {
+    for (node = list; node; node = node->next) {
         num_iothreads++;
     }
 
-    for (node = iothread_vq_mapping_list; node; node = node->next) {
+    for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
         AioContext *ctx = iothread_get_aio_context(iothread);
 
@@ -1549,13 +1548,13 @@ static bool apply_iothread_vq_mapping(
 }
 
 /**
- * cleanup_iothread_vq_mapping:
+ * iothread_vq_mapping_cleanup:
  * @list: The mapping of virtqueues to IOThreads.
  *
  * Release IOThread object references that were acquired by
- * apply_iothread_vq_mapping().
+ * iothread_vq_mapping_apply().
  */
-static void cleanup_iothread_vq_mapping(IOThreadVirtQueueMappingList *list)
+static void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
 {
     IOThreadVirtQueueMappingList *node;
 
@@ -1597,7 +1596,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        if (!apply_iothread_vq_mapping(conf->iothread_vq_mapping_list,
+        if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
                                        errp)) {
@@ -1631,7 +1630,7 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        cleanup_iothread_vq_mapping(conf->iothread_vq_mapping_list);
+        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list);
     }
 
     if (conf->iothread) {
-- 
2.48.1


