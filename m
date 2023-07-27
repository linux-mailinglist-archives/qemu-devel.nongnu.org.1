Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B8765D4F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:26:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7Af-0000dv-GD; Thu, 27 Jul 2023 16:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7AY-0000dI-QF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7AX-0002eN-3B
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7wE4c33Fs/OIa+SJUhr1amUPRTZE15FofWJpfMXqOe8=;
 b=atpZrLpG64yeD/q4SqiPka4Eda7ysNk9aEAF5XTaRy+XSmNFt5ZMotVD2640YCpZJApdBj
 B2hOMNEUeGYmbQUx9sGCCgnFdPBzkh0UI5C4ZxkQjsF8Z+RzC/Md5chDQF6HRuzDqoW1dv
 MvPlqfJWROhweukd/OaXris+hs/lkME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-86sFMb0SODOHVS4yW-hHGQ-1; Thu, 27 Jul 2023 16:01:02 -0400
X-MC-Unique: 86sFMb0SODOHVS4yW-hHGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D997805BC3;
 Thu, 27 Jul 2023 20:01:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E7BE1454147;
 Thu, 27 Jul 2023 20:01:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>
Subject: [PULL for-8.1 0/8] Block patches
Date: Thu, 27 Jul 2023 16:00:50 -0400
Message-ID: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit 66547f416a61e0cb711dc76821890242432ba193:

  block/nvme: invoke blk_io_plug_call() outside q->lock (2023-07-17 09:17:41 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 1c38fe69e2b8a05c1762b122292fa7e3662f06fd:

  block/blkio: use blkio_set_int("fd") to check fd support (2023-07-27 15:51:46 -0400)

----------------------------------------------------------------
Pull request

Please include these bug fixes in QEMU 8.1. Thanks!

----------------------------------------------------------------

Hanna Czenczek (1):
  block: Fix pad_request's request restriction

Sam Li (1):
  block/file-posix: fix g_file_get_contents return path

Stefano Garzarella (6):
  block/blkio: enable the completion eventfd
  block/blkio: do not use open flags in qemu_open()
  block/blkio: move blkio_connect() in the drivers functions
  block/blkio: retry blkio_connect() if it fails using `fd`
  block/blkio: fall back on using `path` when `fd` setting fails
  block/blkio: use blkio_set_int("fd") to check fd support

 block/blkio.c      | 132 ++++++++++++++++++++++++++++++---------------
 block/file-posix.c |   6 +--
 block/io.c         |   8 ++-
 3 files changed, 97 insertions(+), 49 deletions(-)

-- 
2.41.0


