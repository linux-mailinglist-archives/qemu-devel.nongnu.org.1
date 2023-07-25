Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2BD761B39
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIss-00012e-7d; Tue, 25 Jul 2023 10:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsq-0000qQ-0J
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIso-00010i-Kk
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690294766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Joa/fVHzZWRu6e+qLqY+R2GtyfU8vDenfyeGgBNfki4=;
 b=UMy/0/3oVEMjDHoRFE9P22SYtHSSaa/ZZGOtyhEkPqqdjmsGn1NYaJfpyb5qcbY3pvvMjA
 j7qmZ2RRI9WHoTt8BKoLiuC7IWORfmFOHuOK6tuk4bLacSbm8b9i4Ay2kKtpmkBPiV6kFA
 7GobJY8OdpMQDfx936VnGBrekg/ttWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-MT0ZxcKnOQaGehDpzu907g-1; Tue, 25 Jul 2023 10:19:22 -0400
X-MC-Unique: MT0ZxcKnOQaGehDpzu907g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF72805AF6;
 Tue, 25 Jul 2023 14:19:22 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E928E492C13;
 Tue, 25 Jul 2023 14:19:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 2/7] block/blkio: add "simple" creation support
Date: Tue, 25 Jul 2023 10:19:10 -0400
Message-ID: <20230725141915.386364-3-stefanha@redhat.com>
In-Reply-To: <20230725141915.386364-1-stefanha@redhat.com>
References: <20230725141915.386364-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Some block drivers do not support image creation. This is inconvenient
for test cases, which usually want to create an image before testing
various I/O requests.

Use bdrv_co_create_opts_simple(), which initializes a pre-existing image
instead of creating a new image, so that tests will be able to work with
libblkio-based block drivers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blkio.c b/block/blkio.c
index a0240a5bcc..28d11325e6 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -1032,6 +1032,8 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
     .instance_size           = sizeof(BDRVBlkioState), \
     .bdrv_file_open          = blkio_file_open, \
     .bdrv_close              = blkio_close, \
+    .bdrv_co_create_opts     = bdrv_co_create_opts_simple, \
+    .create_opts             = &bdrv_create_opts_simple, \
     .bdrv_co_getlength       = blkio_co_getlength, \
     .bdrv_co_truncate        = blkio_truncate, \
     .bdrv_co_get_info        = blkio_co_get_info, \
-- 
2.41.0


