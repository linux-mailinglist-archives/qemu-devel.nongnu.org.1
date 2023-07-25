Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E2761B49
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIsn-0000n2-Li; Tue, 25 Jul 2023 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsl-0000mV-Sq
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOIsk-0000wn-Bc
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690294761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eG7hCwYs7xiCMHSjOWUl34JVi4aLlSoYSfTSY4HAXeQ=;
 b=TADee2tTPKB2nGHi+OV6Q6p5LwDGLd8/2Q4pZ/LhymL2CZKcz4U66DatBC5MVt3BhAZBvE
 uoEsIMiInU02aXhQKcVBsMzVxJgJ/3ViVBDksZwPpf2D50fst2Y0wHMzM/Ytzvq6m56TeL
 V7rkNQsAl8hfoooCPDe1DyTh9l7eT7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-OOqg2zd7PxmDfH8j8MjD9g-1; Tue, 25 Jul 2023 10:19:18 -0400
X-MC-Unique: OOqg2zd7PxmDfH8j8MjD9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6662803B25;
 Tue, 25 Jul 2023 14:19:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 570D6492B01;
 Tue, 25 Jul 2023 14:19:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/7] iotests: add -io_uring support
Date: Tue, 25 Jul 2023 10:19:08 -0400
Message-ID: <20230725141915.386364-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
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

Add support for block/blkio.c's "io_uring" block driver to qemu-iotests:

  $ (cd build && tests/qemu-iotests/check -io_uring)

I took a look at supporting ./check -qcow2 -io_uring, but there are many
failures related to test assumptions about image creation and QEMU command-line
syntax. Only support testing raw images for now.

Stefan Hajnoczi (7):
  block/blkio: add io_uring: filename parsing
  block/blkio: add "simple" creation support
  iotests: string substitution order in _filter_img_create_filenames
  iotests: filter img create backing_file when IMGPROTO is modified
  iotests: add -io_uring support
  iotests: add io_uring to supported protocols in 012
  iotests: add io_uring to supported protocols in 052

 block/blkio.c                    |  9 +++++++++
 tests/qemu-iotests/012           |  2 +-
 tests/qemu-iotests/033           |  1 +
 tests/qemu-iotests/052           |  2 +-
 tests/qemu-iotests/197           |  4 +++-
 tests/qemu-iotests/197.out       |  2 +-
 tests/qemu-iotests/215           |  4 +++-
 tests/qemu-iotests/215.out       |  2 +-
 tests/qemu-iotests/check         |  2 +-
 tests/qemu-iotests/common.filter | 10 +++++++++-
 tests/qemu-iotests/common.rc     | 12 +++++++++++-
 11 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.41.0


