Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F414765D15
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7BG-0000ql-OC; Thu, 27 Jul 2023 16:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7B3-0000li-4j
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7B1-0002mn-6R
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KW/dec1j/setmZe1D7OoJVA6gf1hHhrxrVymaFzSgtQ=;
 b=CNmPV6MbQtJM/2qwHNaz2jS10BGcqSNVKb9yfFbWuWC+8MH5TDMcAFVi8beGSiVa/W98EB
 omADHrJvSKwarFeRa64QFR8sHQStCGCmCncSPCs6uyufIma3IL8+pO1ButpteH+R1uK04G
 cTVWJM1q77IMze42ekEJasAHMYI7Bwk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-WIJuX5zDMdK5RzE8GnsgJg-1; Thu, 27 Jul 2023 16:01:29 -0400
X-MC-Unique: WIJuX5zDMdK5RzE8GnsgJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31F7F29A9CA9;
 Thu, 27 Jul 2023 20:01:28 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BD611454147;
 Thu, 27 Jul 2023 20:01:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 8/8] block/blkio: use blkio_set_int("fd") to check fd
 support
Date: Thu, 27 Jul 2023 16:00:58 -0400
Message-ID: <20230727200058.1071776-9-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

Setting the `fd` property fails with virtio-blk-* libblkio drivers
that do not support fd passing since
https://gitlab.com/libblkio/libblkio/-/merge_requests/208.

Getting the `fd` property, on the other hand, always succeeds for
virtio-blk-* libblkio drivers even when they don't support fd passing.

This patch switches to setting the `fd` property because it is a
better mechanism for probing fd passing support than getting the `fd`
property.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230727161020.84213-5-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 72b46d61fd..8e7ce42c79 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -690,7 +690,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
         return -EINVAL;
     }
 
-    if (blkio_get_int(s->blkio, "fd", &fd) == 0) {
+    if (blkio_set_int(s->blkio, "fd", -1) == 0) {
         fd_supported = true;
     }
 
-- 
2.41.0


