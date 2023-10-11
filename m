Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC37C4EFC
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVQP-0007EI-7h; Wed, 11 Oct 2023 05:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQM-0007DR-3b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQK-0004tN-EP
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXh0uVEhDVlarqeKjML3PE8PQtsbdfkQos7d9PelU7o=;
 b=W1ms5aXnrU/wQeH/PmTVGaW/5h/rcpnOFz/aXk44c+9g9n++HFllk9t2nBhtpqM4onpBEM
 3BAMAo0LDsrDqeOLofROQTsmfxR+3O1w0FV/8tWTIs17uIj4LhptlzCHTNqLJvpzAkHFW4
 JVDoZnz7Rlh4N8RjAsSTfDt8sFplcW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-7Mr8C2CrOKSDmPzYLJnnWw-1; Wed, 11 Oct 2023 05:22:31 -0400
X-MC-Unique: 7Mr8C2CrOKSDmPzYLJnnWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CCB4800883;
 Wed, 11 Oct 2023 09:22:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A8851C060AE;
 Wed, 11 Oct 2023 09:22:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 12/65] migration/rdma: Consistently use uint64_t for work
 request IDs
Date: Wed, 11 Oct 2023 11:21:10 +0200
Message-ID: <20231011092203.1266-13-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We use int instead of uint64_t in a few places.  Change them to
uint64_t.

This cleans up a comparison of signed qemu_rdma_block_for_wrid()
parameter @wrid_requested with unsigned @wr_id.  Harmless, because the
actual arguments are non-negative enumeration constants.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-6-armbru@redhat.com>
---
 migration/rdma.c       | 7 ++++---
 migration/trace-events | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 8f297c9e46..d1e727f30b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1599,13 +1599,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     return rdma->error_state;
 }
 
-static struct ibv_comp_channel *to_channel(RDMAContext *rdma, int wrid)
+static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)
 {
     return wrid < RDMA_WRID_RECV_CONTROL ? rdma->send_comp_channel :
            rdma->recv_comp_channel;
 }
 
-static struct ibv_cq *to_cq(RDMAContext *rdma, int wrid)
+static struct ibv_cq *to_cq(RDMAContext *rdma, uint64_t wrid)
 {
     return wrid < RDMA_WRID_RECV_CONTROL ? rdma->send_cq : rdma->recv_cq;
 }
@@ -1623,7 +1623,8 @@ static struct ibv_cq *to_cq(RDMAContext *rdma, int wrid)
  * completions only need to be recorded, but do not actually
  * need further processing.
  */
-static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
+static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
+                                    uint64_t wrid_requested,
                                     uint32_t *byte_len)
 {
     int num_cq_events = 0, ret = 0;
diff --git a/migration/trace-events b/migration/trace-events
index 19f9ee7c6d..6a50994402 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -208,7 +208,7 @@ qemu_rdma_accept_incoming_migration(void) ""
 qemu_rdma_accept_incoming_migration_accepted(void) ""
 qemu_rdma_accept_pin_state(bool pin) "%d"
 qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
-qemu_rdma_block_for_wrid_miss(int wcomp, uint64_t req) "A Wanted wrid %d but got %" PRIu64
+qemu_rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wrid %" PRIu64 " but got %" PRIu64
 qemu_rdma_cleanup_disconnect(void) ""
 qemu_rdma_close(void) ""
 qemu_rdma_connect_pin_all_requested(void) ""
@@ -222,9 +222,9 @@ qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
 qemu_rdma_exchange_send_received(const char *desc) "Response %s received."
 qemu_rdma_fill(size_t control_len, size_t size) "RDMA %zd of %zd bytes already in buffer"
 qemu_rdma_init_ram_blocks(int blocks) "Allocated %d local ram block structures"
-qemu_rdma_poll_recv(int64_t comp, int64_t id, int sent) "completion %" PRId64 " received (%" PRId64 ") left %d"
-qemu_rdma_poll_write(int64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %" PRId64 " left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
-qemu_rdma_poll_other(int64_t comp, int left) "other completion %" PRId64 " received left %d"
+qemu_rdma_poll_recv(uint64_t comp, int64_t id, int sent) "completion %" PRIu64 " received (%" PRId64 ") left %d"
+qemu_rdma_poll_write(uint64_t comp, int left, uint64_t block, uint64_t chunk, void *local, void *remote) "completions %" PRIu64 " left %d, block %" PRIu64 ", chunk: %" PRIu64 " %p %p"
+qemu_rdma_poll_other(uint64_t comp, int left) "other completion %" PRIu64 " received left %d"
 qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
 qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
 qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
-- 
2.41.0


