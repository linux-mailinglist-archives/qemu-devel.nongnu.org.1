Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1D7C4F0A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRq-0004PS-GJ; Wed, 11 Oct 2023 05:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRn-0004MN-Os
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRl-0005Bw-9o
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIjfxNLrgRASn3Utos0RKb18wiSutTnjmZl7l53/0g0=;
 b=ckay/8jXeIJcilEHFDwk6OU3xOAF3mfXhua/uEdcqCb/RtrjbenWpU7gTb4KeR4WklryeJ
 Labuy/k2H5XlWF24LUKH/JjxYQSmckat7gQ2lfspr3ACbp0ndcMnsE9tjsVpCCgJJaBRaQ
 cP22XMKpwAeKfcARV8DCdVCcjcjbJss=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-uxxQMPioOR-dw3km3EvrZg-1; Wed, 11 Oct 2023 05:24:00 -0400
X-MC-Unique: uxxQMPioOR-dw3km3EvrZg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 267EC3C100A4;
 Wed, 11 Oct 2023 09:24:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6666D1C060AE;
 Wed, 11 Oct 2023 09:23:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 56/65] migration/rdma: Silence qemu_rdma_block_for_wrid()
Date: Wed, 11 Oct 2023 11:21:54 +0200
Message-ID: <20231011092203.1266-57-quintela@redhat.com>
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

Bonus: resolves a FIXME about problematic use of errno.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-50-armbru@redhat.com>
---
 migration/rdma.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b5bb47108e..459dcb002e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1483,17 +1483,12 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
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
 
@@ -1577,16 +1572,12 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
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
@@ -1599,7 +1590,6 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
             default: /* Error of some type -
                       * I don't trust errno from qemu_poll_ns
                      */
-                error_report("%s: poll failed", __func__);
                 return -1;
             }
 
@@ -1683,12 +1673,6 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
         ret = ibv_get_cq_event(ch, &cq, &cq_ctx);
         if (ret < 0) {
-            /*
-             * FIXME perror() is problematic, because ibv_reg_mr() is
-             * not documented to set errno.  Will go away later in
-             * this series.
-             */
-            perror("ibv_get_cq_event");
             goto err_block_for_wrid;
         }
 
-- 
2.41.0


