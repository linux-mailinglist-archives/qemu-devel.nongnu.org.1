Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C16E7D4AA4
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCyG-0003oZ-2I; Tue, 24 Oct 2023 04:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyE-0003n8-3i
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyC-0003Je-LF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0sIoyOFAtdBEQyNjp7wD5mrhmgIJhKoQXB/TDbxuWQ=;
 b=e4FTV+oRWoBQgs6DpFCOKa7viI7hxksaLM0nVaEZW+L39i9MoeE+8yv20Sv5Yyfu4zUiQb
 2g5mvD6Tx7pw50RIE9gEQPxVi9FA1F+vYYxEayOjLmukfYePe8p51HHWve1Bl0EeabPY7i
 eOalvH8dQYRpFsZTHf4gR0KpRWUB3OA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-CyuS3CWENJewInKyUoSbaQ-1; Tue, 24 Oct 2023 04:40:56 -0400
X-MC-Unique: CyuS3CWENJewInKyUoSbaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB0D2185A7BC;
 Tue, 24 Oct 2023 08:40:55 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 213831121318;
 Tue, 24 Oct 2023 08:40:54 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 2/9] virtio: make endian_needed() work during loading
Date: Tue, 24 Oct 2023 12:40:36 +0400
Message-ID: <20231024084043.2926316-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

There is no simple way to distinguish when the callback is used for load
or save, AFAICT.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6facd64fbc..8baf9f7ca8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2502,7 +2502,11 @@ static bool virtio_device_endian_needed(void *opaque)
 {
     VirtIODevice *vdev = opaque;
 
-    assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
+    /* On load, endian is UNKNOWN. The section might be loaded as required. */
+    if (vdev->device_endian == VIRTIO_DEVICE_ENDIAN_UNKNOWN) {
+        return false;
+    }
+
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         return vdev->device_endian != virtio_default_endian();
     }
-- 
2.41.0


