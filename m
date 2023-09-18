Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786967A4B34
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFT7-0003In-7x; Mon, 18 Sep 2023 10:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSQ-00032S-7j
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS3-0002Yo-KP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqC2Z2GnwKzykYWxLpg0IIWmm6cKsvX9bBS5zkxf7BM=;
 b=hhBZ5tk6ldENR20BXa3cEdeYy4UDydQCbLRV7mlWc+RgJ0C8mRDoi3XR813Nbqfzyzsv42
 sHXz2Pahv+VVyzgImrdxtXdeYv9O9N9vIJWGspJv4YxYN+LNUq8O0Z8G2n7J4PbB6jVeHm
 aGAHzhlpVPBXdkcvPgz9uAT+459CJrc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-ju_RBuxCMommHLTEaZ1Q3A-1; Mon, 18 Sep 2023 10:42:08 -0400
X-MC-Unique: ju_RBuxCMommHLTEaZ1Q3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FBCA85829B
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F33321C554
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8E4221E6906; Mon, 18 Sep 2023 16:42:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 04/52] migration/rdma: Drop fragile wr_id formatting
Date: Mon, 18 Sep 2023 16:41:18 +0200
Message-ID: <20230918144206.560120-5-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

wrid_desc[] uses 4001 pointers to map four integer values to strings.

print_wrid() accesses wrid_desc[] out of bounds when passed a negative
argument.  It returns null for values 2..1999 and 2001..3999.

qemu_rdma_poll() and qemu_rdma_block_for_wrid() print wrid_desc[wr_id]
and passes print_wrid(wr_id) to tracepoints.  Could conceivably crash
trying to format a null string.  I believe access out of bounds is not
possible.

Not worth cleaning up.  Dumb down to show just numeric wr_id.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c       | 32 +++++++-------------------------
 migration/trace-events |  8 ++++----
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 320c291a96..cda22be3f7 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -133,13 +133,6 @@ enum {
     RDMA_WRID_RECV_CONTROL = 4000,
 };
 
-static const char *wrid_desc[] = {
-    [RDMA_WRID_NONE] = "NONE",
-    [RDMA_WRID_RDMA_WRITE] = "WRITE RDMA",
-    [RDMA_WRID_SEND_CONTROL] = "CONTROL SEND",
-    [RDMA_WRID_RECV_CONTROL] = "CONTROL RECV",
-};
-
 /*
  * Work request IDs for IB SEND messages only (not RDMA writes).
  * This is used by the migration protocol to transmit
@@ -535,7 +528,6 @@ static void network_to_result(RDMARegisterResult *result)
     result->host_addr = ntohll(result->host_addr);
 };
 
-const char *print_wrid(int wrid);
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    uint8_t *data, RDMAControlHeader *resp,
                                    int *resp_idx,
@@ -1362,14 +1354,6 @@ static int qemu_rdma_reg_control(RDMAContext *rdma, int idx)
     return -1;
 }
 
-const char *print_wrid(int wrid)
-{
-    if (wrid >= RDMA_WRID_RECV_CONTROL) {
-        return wrid_desc[RDMA_WRID_RECV_CONTROL];
-    }
-    return wrid_desc[wrid];
-}
-
 /*
  * Perform a non-optimized memory unregistration after every transfer
  * for demonstration purposes, only if pin-all is not requested.
@@ -1491,15 +1475,15 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
     if (wc.status != IBV_WC_SUCCESS) {
         fprintf(stderr, "ibv_poll_cq wc.status=%d %s!\n",
                         wc.status, ibv_wc_status_str(wc.status));
-        fprintf(stderr, "ibv_poll_cq wrid=%s!\n", wrid_desc[wr_id]);
+        fprintf(stderr, "ibv_poll_cq wrid=%" PRIu64 "!\n", wr_id);
 
         return -1;
     }
 
     if (rdma->control_ready_expected &&
         (wr_id >= RDMA_WRID_RECV_CONTROL)) {
-        trace_qemu_rdma_poll_recv(wrid_desc[RDMA_WRID_RECV_CONTROL],
-                  wr_id - RDMA_WRID_RECV_CONTROL, wr_id, rdma->nb_sent);
+        trace_qemu_rdma_poll_recv(wr_id - RDMA_WRID_RECV_CONTROL, wr_id,
+                                  rdma->nb_sent);
         rdma->control_ready_expected = 0;
     }
 
@@ -1510,7 +1494,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
             (wc.wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;
         RDMALocalBlock *block = &(rdma->local_ram_blocks.block[index]);
 
-        trace_qemu_rdma_poll_write(print_wrid(wr_id), wr_id, rdma->nb_sent,
+        trace_qemu_rdma_poll_write(wr_id, rdma->nb_sent,
                                    index, chunk, block->local_host_addr,
                                    (void *)(uintptr_t)block->remote_host_addr);
 
@@ -1520,7 +1504,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
             rdma->nb_sent--;
         }
     } else {
-        trace_qemu_rdma_poll_other(print_wrid(wr_id), wr_id, rdma->nb_sent);
+        trace_qemu_rdma_poll_other(wr_id, rdma->nb_sent);
     }
 
     *wr_id_out = wc.wr_id;
@@ -1665,8 +1649,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
             break;
         }
         if (wr_id != wrid_requested) {
-            trace_qemu_rdma_block_for_wrid_miss(print_wrid(wrid_requested),
-                       wrid_requested, print_wrid(wr_id), wr_id);
+            trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_id);
         }
     }
 
@@ -1705,8 +1688,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
                 break;
             }
             if (wr_id != wrid_requested) {
-                trace_qemu_rdma_block_for_wrid_miss(print_wrid(wrid_requested),
-                                   wrid_requested, print_wrid(wr_id), wr_id);
+                trace_qemu_rdma_block_for_wrid_miss(wrid_requested, wr_id);
             }
         }
 
diff --git a/migration/trace-events b/migration/trace-events
index 4666f19325..b78808f28b 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -207,7 +207,7 @@ qemu_rdma_accept_incoming_migration(void) ""
 qemu_rdma_accept_incoming_migration_accepted(void) ""
 qemu_rdma_accept_pin_state(bool pin) "%d"
 qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
-qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
+qemu_rdma_block_for_wrid_miss(int wcomp, uint64_t req) "A Wanted wrid %d but got %" PRIu64
 qemu_rdma_cleanup_disconnect(void) ""
 qemu_rdma_close(void) ""
 qemu_rdma_connect_pin_all_requested(void) ""
@@ -221,9 +221,9 @@ qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
 qemu_rdma_exchange_send_received(const char *desc) "Response %s received."
 qemu_rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes already in buffer"
 qemu_rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structures"
-qemu_rdma_poll_recv(const char *compstr, int64_t comp, int64_t id, int sent) "completion %s #%" PRId64 " received (%" PRId64 ") left %d"
-qemu_rdma_poll_write(const char *compstr, int64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %s (%" PRId64 ") left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
-qemu_rdma_poll_other(const char *compstr, int64_t comp, int left) "other completion %s (%" PRId64 ") received left %d"
+qemu_rdma_poll_recv(int64_t comp, int64_t id, int sent) "completion %" PRId64 " received (%" PRId64 ") left %d"
+qemu_rdma_poll_write(int64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %" PRId64 " left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
+qemu_rdma_poll_other(int64_t comp, int left) "other completion %" PRId64 " received left %d"
 qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
 qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
 qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
-- 
2.41.0


