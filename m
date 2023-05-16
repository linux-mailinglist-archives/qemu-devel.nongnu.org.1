Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CFD7056D2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzxR-00026m-8l; Tue, 16 May 2023 15:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxP-00026L-Mh
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxO-0001Gy-6O
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQCTZSkypWn0YHx4KoG3dn4Qz091Y17YNDQRTejUUgA=;
 b=i/KtxrvLHk/nD1oR9PGmiojq8q+6OPWSSweSBdBV1D3STGtNu/S6kquQx51kXKCpDAeY8a
 4aVPX7Vc1JH+mzyy9K0lMLYHPTy2V3Aw4kizszIbgoGzdH6uIS/zWPY2M+k525TOJhM7+7
 qwbhofyivl+7jAoRZLKSmuc+3TbNbx8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-MkRP-mB_O2aVof1osuZVZw-1; Tue, 16 May 2023 15:03:30 -0400
X-MC-Unique: MkRP-mB_O2aVof1osuZVZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9B386C60E;
 Tue, 16 May 2023 19:03:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37E3C492B00;
 Tue, 16 May 2023 19:03:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 eesposit@redhat.com, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v6 12/20] hw/xen: do not set is_external=true on evtchn fds
Date: Tue, 16 May 2023 15:02:30 -0400
Message-Id: <20230516190238.8401-13-stefanha@redhat.com>
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

is_external=true suspends fd handlers between aio_disable_external() and
aio_enable_external(). The block layer's drain operation uses this
mechanism to prevent new I/O from sneaking in between
bdrv_drained_begin() and bdrv_drained_end().

The previous commit converted the xen-block device to use BlockDevOps
.drained_begin/end() callbacks. It no longer relies on is_external=true
so it is safe to pass is_external=false.

This is part of ongoing work to remove the aio_disable_external() API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/xen/xen-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index b8f408c9ed..bf256d4da2 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -842,14 +842,14 @@ void xen_device_set_event_channel_context(XenDevice *xendev,
     }
 
     if (channel->ctx)
-        aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh), true,
+        aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh), false,
                            NULL, NULL, NULL, NULL, NULL);
 
     channel->ctx = ctx;
     if (ctx) {
         aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh),
-                           true, xen_device_event, NULL, xen_device_poll, NULL,
-                           channel);
+                           false, xen_device_event, NULL, xen_device_poll,
+                           NULL, channel);
     }
 }
 
@@ -923,7 +923,7 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
 
     QLIST_REMOVE(channel, list);
 
-    aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh), true,
+    aio_set_fd_handler(channel->ctx, qemu_xen_evtchn_fd(channel->xeh), false,
                        NULL, NULL, NULL, NULL, NULL);
 
     if (qemu_xen_evtchn_unbind(channel->xeh, channel->local_port) < 0) {
-- 
2.40.1


