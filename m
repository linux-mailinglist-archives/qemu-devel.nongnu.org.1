Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12D47A4B3B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSw-0003Ak-BJ; Mon, 18 Sep 2023 10:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSK-0002x1-Ot
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002aW-Mw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQjjegCMyCfUF3K78NUViyNdd6EV848yUG0Dl9X+n5k=;
 b=UisAwxuGROY2Cvs+0PAl6u6/h6DOncoXUl7YU0isaumfUOmyPBvXFAgHMXcLJINxlUCWC8
 jw6czvczQsNOkalUFksQYM/zmu28sYeyb48+CEAIZI7raTTay29dRajgBF/h8kPkNqTS3J
 mB9U1gjbjFvyOfm/kmmQ0kducx2mujs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-3bGbgNkgPPuC-fuv0qxyxA-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: 3bGbgNkgPPuC-fuv0qxyxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2475C3C025C2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01B5A170E4
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED00E21E690B; Mon, 18 Sep 2023 16:42:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 05/52] migration/rdma: Consistently use uint64_t for work
 request IDs
Date: Mon, 18 Sep 2023 16:41:19 +0200
Message-ID: <20230918144206.560120-6-armbru@redhat.com>
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

We use int instead of uint64_t in a few places.  Change them to
uint64_t.

This cleans up a comparison of signed qemu_rdma_block_for_wrid()
parameter @wrid_requested with unsigned @wr_id.  Harmless, because the
actual arguments are non-negative enumeration constants.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c       | 7 ++++---
 migration/trace-events | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index cda22be3f7..4328610a4c 100644
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
index b78808f28b..d733107ec6 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -207,7 +207,7 @@ qemu_rdma_accept_incoming_migration(void) ""
 qemu_rdma_accept_incoming_migration_accepted(void) ""
 qemu_rdma_accept_pin_state(bool pin) "%d"
 qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
-qemu_rdma_block_for_wrid_miss(int wcomp, uint64_t req) "A Wanted wrid %d but got %" PRIu64
+qemu_rdma_block_for_wrid_miss(uint64_t wcomp, uint64_t req) "A Wanted wrid %" PRIu64 " but got %" PRIu64
 qemu_rdma_cleanup_disconnect(void) ""
 qemu_rdma_close(void) ""
 qemu_rdma_connect_pin_all_requested(void) ""
@@ -221,9 +221,9 @@ qemu_rdma_exchange_send_waiting(const char *desc) "Waiting for response %s"
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


