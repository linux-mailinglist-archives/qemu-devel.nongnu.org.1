Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056AC7972A5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeElw-0004P6-EL; Thu, 07 Sep 2023 09:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElr-0004E9-F0
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qeElo-00022u-TB
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694092203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moxHPEkpPVwuFSxHAfypc7NHc+bmRGFF5JDKNIR9L+8=;
 b=E7wOkeB60wAM1UCUsthoNu7ygU3BzCo9hFvoTG6YExjK44sFaxp8IGnBkAnxuQd1+bqxYB
 7BPwCHFcaVo6iNOfi/CCEpnOSnXWsES4/Q/n7HfJwSlY1C9J83NMXndSjQAIEItPtiFFi1
 0CRLvLWQsktWL78zrWwVFKL1uivRVlQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-gpOvbqoBOVywR1jJX_M8PA-1; Thu, 07 Sep 2023 09:10:01 -0400
X-MC-Unique: gpOvbqoBOVywR1jJX_M8PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 358F71C18C62
 for <qemu-devel@nongnu.org>; Thu,  7 Sep 2023 13:10:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7F1200BC49;
 Thu,  7 Sep 2023 13:09:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 5/5] Revert "virtio-gpu: block migration of VMs with
 blob=true"
Date: Thu,  7 Sep 2023 17:09:36 +0400
Message-ID: <20230907130936.767722-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230907130936.767722-1-marcandre.lureau@redhat.com>
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

If we decide to apply this patch (for easier backporting reasons), we
can now revert it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 63e60745f8..206b759a9c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -26,7 +26,6 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
-#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -45,8 +44,6 @@ static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                        struct virtio_gpu_simple_resource *res);
 static void virtio_gpu_reset_bh(void *opaque);
 
-static Error *blob_mig_blocker;
-
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -1464,14 +1461,6 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             error_setg(errp, "blobs and virgl are not compatible (yet)");
             return;
         }
-
-        if (!blob_mig_blocker) {
-            error_setg(&blob_mig_blocker,
-                       "virtio-gpu blob VMs are currently not migratable.");
-        }
-        if (migrate_add_blocker(blob_mig_blocker, errp)) {
-            return;
-        }
     }
 
     if (!virtio_gpu_base_device_realize(qdev,
@@ -1498,9 +1487,6 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
-    if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
-        migrate_del_blocker(blob_mig_blocker);
-    }
     g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
     g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
     g_clear_pointer(&g->reset_bh, qemu_bh_delete);
-- 
2.41.0


