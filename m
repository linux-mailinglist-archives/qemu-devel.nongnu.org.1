Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F427A4B4C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFYH-0001e5-1x; Mon, 18 Sep 2023 10:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFYA-000130-JD
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFY9-0003tq-1C
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/4H8ipMzlqKesV3+ytiA59TNqpomYQHxsCepo1ZLLA=;
 b=COvu6bncNeTKzdL9dK2Lz3yXDMrN2qQ5FW5QBMtH2WsnMKNqYtIj9Etd59P/6icqAHc+Uq
 8Ca74BsvNdsvv7Bu6u2pda0CbWt9D84HBG4LM0lqO2vqoqAS+iwnIKm2HBBKl5k7VlxpGc
 dKd2rGx5PeLX11IN2fZHtRzmM4MGkQc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-Uoqc45ADMhm2pnYXwM98nA-1; Mon, 18 Sep 2023 10:48:28 -0400
X-MC-Unique: Uoqc45ADMhm2pnYXwM98nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 117E91C0514C
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E26AA40C6EBF
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:48:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 737F621E68A4; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 48/52] migration/rdma: Silence qemu_rdma_block_for_wrid()
Date: Mon, 18 Sep 2023 16:42:02 +0200
Message-ID: <20230918144206.560120-49-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_post_send_control(), qemu_rdma_exchange_get_response(), and
qemu_rdma_write_one() violate this principle: they call
error_report(), fprintf(stderr, ...), and perror() via
qemu_rdma_block_for_wrid(), qemu_rdma_poll(), and
qemu_rdma_wait_comp_channel().  I elected not to investigate how
callers handle the error, i.e. precise impact is not known.

Clean this up by dropping the error reporting from qemu_rdma_poll(),
qemu_rdma_wait_comp_channel(), and qemu_rdma_block_for_wrid().  I
believe the callers' error reports suffice.  If they don't, we need to
convert to Error instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index cbf5e6b9a8..99dccdeae5 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1467,17 +1467,12 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
     }
 
     if (ret < 0) {
-        error_report("ibv_poll_cq failed");
         return -1;
     }
 
     wr_id = wc.wr_id & RDMA_WRID_TYPE_MASK;
 
     if (wc.status != IBV_WC_SUCCESS) {
-        fprintf(stderr, "ibv_poll_cq wc.status=%d %s!\n",
-                        wc.status, ibv_wc_status_str(wc.status));
-        fprintf(stderr, "ibv_poll_cq wrid=%" PRIu64 "!\n", wr_id);
-
         return -1;
     }
 
@@ -1561,16 +1556,12 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                 if (pfds[1].revents) {
                     ret = rdma_get_cm_event(rdma->channel, &cm_event);
                     if (ret < 0) {
-                        error_report("failed to get cm event while wait "
-                                     "completion channel");
                         return -1;
                     }
 
                     if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
                         cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                         rdma_ack_cm_event(cm_event);
-                        error_report("receive cm event while wait comp channel,"
-                                     "cm event is %d", cm_event->event);
                         return -1;
                     }
                     rdma_ack_cm_event(cm_event);
@@ -1583,7 +1574,6 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
             default: /* Error of some type -
                       * I don't trust errno from qemu_poll_ns
                      */
-                error_report("%s: poll failed", __func__);
                 return -1;
             }
 
@@ -1667,7 +1657,6 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
         ret = ibv_get_cq_event(ch, &cq, &cq_ctx);
         if (ret < 0) {
-            perror("ibv_get_cq_event");
             goto err_block_for_wrid;
         }
 
-- 
2.41.0


