Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD4076EEC7
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRagG-0006pr-3t; Thu, 03 Aug 2023 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRagA-0006pd-0n
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRag8-0004oa-G4
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuhqgQawoFar29iDZgHO95xXm2Ku6g+zYEg0foUzyKc=;
 b=XY1/il34oUpKYP/CDAyUWXokhNpaTAEXa/HZ+oHaWCQujX4tcIWm2WiYsWSDa+rohH1ACp
 TxUil8/isJ54S0EcwOz65lzUzGeY03Kczw3uIc6D3ylmO6OZVquaqyrLNsHuBfkq5OTgi5
 BMbNZbSEE39It29VUCYgWmXMGjrVrwU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-03VoesUdPH-dmPVq28NMQg-1; Thu, 03 Aug 2023 11:55:52 -0400
X-MC-Unique: 03VoesUdPH-dmPVq28NMQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C360A29AA38B;
 Thu,  3 Aug 2023 15:55:51 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28861403162;
 Thu,  3 Aug 2023 15:55:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 2/2] block/blkio: add more comments on the fd passing
 handling
Date: Thu,  3 Aug 2023 11:55:45 -0400
Message-ID: <20230803155545.2349984-3-stefanha@redhat.com>
In-Reply-To: <20230803155545.2349984-1-stefanha@redhat.com>
References: <20230803155545.2349984-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

As Hanna pointed out, it is not clear in the code why qemu_open()
can fail, and why blkio_set_int("fd") is not enough to discover
the `fd` property support.

Let's fix them by adding more details in the code comments.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230803082825.25293-3-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index baba2f0b67..1dd495617c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -713,6 +713,12 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
          */
         fd = qemu_open(path, O_RDWR, NULL);
         if (fd < 0) {
+            /*
+             * qemu_open() can fail if the user specifies a path that is not
+             * a file or device, for example in the case of Unix Domain Socket
+             * for the virtio-blk-vhost-user driver. In such cases let's have
+             * libblkio open the path directly.
+             */
             fd_supported = false;
         } else {
             ret = blkio_set_int(s->blkio, "fd", fd);
@@ -741,9 +747,12 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     }
 
     /*
-     * If the libblkio driver doesn't support the `fd` property, blkio_connect()
-     * will fail with -EINVAL. So let's try calling blkio_connect() again by
-     * directly setting `path`.
+     * Before https://gitlab.com/libblkio/libblkio/-/merge_requests/208
+     * (libblkio <= v1.3.0), setting the `fd` property is not enough to check
+     * whether the driver supports the `fd` property or not. In that case,
+     * blkio_connect() will fail with -EINVAL.
+     * So let's try calling blkio_connect() again by directly setting `path`
+     * to cover this scenario.
      */
     if (fd_supported && ret == -EINVAL) {
         /*
-- 
2.41.0


