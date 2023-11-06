Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E10687E2050
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:46:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuB-0003Pe-5L; Mon, 06 Nov 2023 06:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxu3-0003HB-C6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxu1-0003MC-Ry
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJUvqWW9yoZqCljtAReh0jRJiy7SYpKqsreR0+FkXW4=;
 b=KaPHOoE7iWaooOjFb89+rnz/kOusjMabVKFJYTumyAtLCDl41PhqYwStpsAy+IAozuurSc
 7THUQ8IOunQe7tZFMpTRoxO3PVwgIDjJATF8TOpUdICt0mQg+mYWB/iav3UClepidAYbn3
 7Hd6k3t4sF+jiqfIpyI850R26cGKMvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ox9--JsOOjq-WEXRYBy-vQ-1; Mon, 06 Nov 2023 06:36:18 -0500
X-MC-Unique: ox9--JsOOjq-WEXRYBy-vQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB18C1019C88;
 Mon,  6 Nov 2023 11:36:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF632026D68;
 Mon,  6 Nov 2023 11:36:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 2/6] virtio: make endian_needed() work during loading
Date: Mon,  6 Nov 2023 15:35:56 +0400
Message-ID: <20231106113601.2052601-3-marcandre.lureau@redhat.com>
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index e5105571cf..22aeb88235 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2517,7 +2517,11 @@ static bool virtio_device_endian_needed(void *opaque)
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


