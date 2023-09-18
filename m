Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF27A4B2C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFTQ-0004jW-1Q; Mon, 18 Sep 2023 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSR-00033f-4s
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS5-0002d4-3X
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRk/3BTFIROz8GcoW0l4/ksxZbWN2cMvLtnkZKAhwPM=;
 b=c59vMhRsSUp9cfT0s1Vq3ExDIHvfQzgKZw82b6qI8YwKWz5EROcAaOuIeLdHLJQtTLALg3
 wAecxWdNVuT1TvX3mDt7XfpkON4yTKzwxVYiwo6EYxQF+9Umk5zgAVt61We/3zDhiIM2iF
 MiQvFD9prRtOhq1d5NFguqYlDaeV3xg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-iqIkvRiHNYuRPak8uz84xQ-1; Mon, 18 Sep 2023 10:42:12 -0400
X-MC-Unique: iqIkvRiHNYuRPak8uz84xQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF04A1C05152
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 713CD20268CC
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C2C921E68A7; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 51/52] migration/rdma: Use error_report() & friends instead of
 stderr
Date: Mon, 18 Sep 2023 16:42:05 +0200
Message-ID: <20230918144206.560120-52-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

error_report() obeys -msg, reports the current error location if any,
and reports to the current monitor if any.  Reporting to stderr
directly with fprintf() or perror() is wrong, because it loses all
this.

Fix the offenders.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index be2db7946d..9e9904984e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -871,12 +871,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
         if (roce_found) {
             if (ib_found) {
-                fprintf(stderr, "WARN: migrations may fail:"
-                                " IPv6 over RoCE / iWARP in linux"
-                                " is broken. But since you appear to have a"
-                                " mixed RoCE / IB environment, be sure to only"
-                                " migrate over the IB fabric until the kernel "
-                                " fixes the bug.\n");
+                warn_report("WARN: migrations may fail:"
+                            " IPv6 over RoCE / iWARP in linux"
+                            " is broken. But since you appear to have a"
+                            " mixed RoCE / IB environment, be sure to only"
+                            " migrate over the IB fabric until the kernel "
+                            " fixes the bug.");
             } else {
                 error_setg(errp, "RDMA ERROR: "
                            "You only have RoCE / iWARP devices in your systems"
@@ -1407,7 +1407,8 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
         block->remote_keys[chunk] = 0;
 
         if (ret != 0) {
-            perror("unregistration chunk failed");
+            error_report("unregistration chunk failed: %s",
+                         strerror(errno));
             return -1;
         }
         rdma->total_registrations--;
@@ -3751,7 +3752,8 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 block->pmr[reg->key.chunk] = NULL;
 
                 if (ret != 0) {
-                    perror("rdma unregistration chunk failed");
+                    error_report("rdma unregistration chunk failed: %s",
+                                 strerror(errno));
                     goto err;
                 }
 
@@ -3940,10 +3942,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
          */
 
         if (local->nb_blocks != nb_dest_blocks) {
-            fprintf(stderr, "ram blocks mismatch (Number of blocks %d vs %d) "
-                    "Your QEMU command line parameters are probably "
-                    "not identical on both the source and destination.",
-                    local->nb_blocks, nb_dest_blocks);
+            error_report("ram blocks mismatch (Number of blocks %d vs %d)",
+                         local->nb_blocks, nb_dest_blocks);
+            error_printf("Your QEMU command line parameters are probably "
+                         "not identical on both the source and destination.");
             rdma->errored = true;
             return -1;
         }
@@ -3956,10 +3958,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
 
             /* We require that the blocks are in the same order */
             if (rdma->dest_blocks[i].length != local->block[i].length) {
-                fprintf(stderr, "Block %s/%d has a different length %" PRIu64
-                        "vs %" PRIu64, local->block[i].block_name, i,
-                        local->block[i].length,
-                        rdma->dest_blocks[i].length);
+                error_report("Block %s/%d has a different length %" PRIu64
+                             "vs %" PRIu64,
+                             local->block[i].block_name, i,
+                             local->block[i].length,
+                             rdma->dest_blocks[i].length);
                 rdma->errored = true;
                 return -1;
             }
@@ -4075,7 +4078,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     ret = qemu_rdma_accept(rdma);
 
     if (ret < 0) {
-        fprintf(stderr, "RDMA ERROR: Migration initialization failed\n");
+        error_report("RDMA ERROR: Migration initialization failed");
         return;
     }
 
@@ -4087,7 +4090,7 @@ static void rdma_accept_incoming_migration(void *opaque)
 
     f = rdma_new_input(rdma);
     if (f == NULL) {
-        fprintf(stderr, "RDMA ERROR: could not open RDMA for input\n");
+        error_report("RDMA ERROR: could not open RDMA for input");
         qemu_rdma_cleanup(rdma);
         return;
     }
-- 
2.41.0


