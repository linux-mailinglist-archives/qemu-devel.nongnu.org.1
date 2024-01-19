Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41922832EB1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:14:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNS-0001nH-PK; Fri, 19 Jan 2024 13:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNI-0001ff-Md
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNE-0007fn-97
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9K903/Yegnn9dUEU+6nFxa0MGx2PhUv24bahJVyoCo=;
 b=hnZ9UIngvyN+6TvORixpWKhVCdM49PcAfCU62QsJALcs8AGDh/R4vd8X86R/F3/OZvICmG
 IGaDiqrypEJ4TSmnKptLLi2Zq/MBeAOtxdxDXRj8g7hbiYIuyNNYwJdjmfFBeM0gsWSHCy
 +FibfUo2cAsC6UVIMoe/+n0aC72H+R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-mRG-4jmUNH29YzEVrS2e9g-1; Fri, 19 Jan 2024 13:13:43 -0500
X-MC-Unique: mRG-4jmUNH29YzEVrS2e9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3592685A58C;
 Fri, 19 Jan 2024 18:13:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DBD0494;
 Fri, 19 Jan 2024 18:13:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/14] virtio-blk: tolerate failure to set BlockBackend
 AioContext
Date: Fri, 19 Jan 2024 19:13:25 +0100
Message-ID: <20240119181327.236745-13-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

We no longer rely on setting the AioContext since the block layer
IO_CODE APIs can be called from any thread. Now it's just a hint to help
block jobs and other operations co-locate themselves in a thread with
the guest I/O requests. Keep going if setting the AioContext fails.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240119135748.270944-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 4525988d92..73248d15c8 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1786,11 +1786,14 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
 
     memory_region_transaction_commit();
 
+    /*
+     * Try to change the AioContext so that block jobs and other operations can
+     * co-locate their activity in the same AioContext. If it fails, nevermind.
+     */
     r = blk_set_aio_context(s->conf.conf.blk, s->vq_aio_context[0],
                             &local_err);
     if (r < 0) {
-        error_report_err(local_err);
-        goto fail_aio_context;
+        warn_report_err(local_err);
     }
 
     /*
@@ -1819,18 +1822,6 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
     }
     return 0;
 
-  fail_aio_context:
-    memory_region_transaction_begin();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
-    }
-
-    memory_region_transaction_commit();
-
-    for (i = 0; i < nvqs; i++) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
-    }
   fail_host_notifiers:
     k->set_guest_notifiers(qbus->parent, nvqs, false);
   fail_guest_notifiers:
-- 
2.43.0


