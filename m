Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29600B52000
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 20:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPDb-0003uw-K3; Wed, 10 Sep 2025 14:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDV-0003Nj-S4
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDS-00053T-7b
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dF2xtG/GWkHKJxYykG0pdNQfC+Iq1SGMxDe51lS3LAs=;
 b=HoVZAxvh+dNUvMEih2/URVYMmiwGmW7yUpIEsXQa/uHl74X0+xGyBzV/+GzHPCwEQyIEex
 ZV6NOBDYCNxzcXHZTL9b+rVE05kAurodlHBpdJMITek6Z7JhPTtOWvt5LLz26WlrT5yVbm
 DbKnQddbKtdcdRUJhRun/5C/hg74dDU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-Q-k_AI0GOv-glui5W_BaKA-1; Wed,
 10 Sep 2025 14:06:39 -0400
X-MC-Unique: Q-k_AI0GOv-glui5W_BaKA-1
X-Mimecast-MFC-AGG-ID: Q-k_AI0GOv-glui5W_BaKA_1757527597
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6022B1955D56; Wed, 10 Sep 2025 18:06:37 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77E051955F24; Wed, 10 Sep 2025 18:06:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, hibriansong@gmail.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 00/12] aio: add the aio_add_sqe() io_uring API
Date: Wed, 10 Sep 2025 13:56:51 -0400
Message-ID: <20250910175703.374499-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v4:
- Rebased and tested after the QEMU 10.1.0 release

v3:
- Add assertions documenting that ADD and REMOVE flags cannot be present
  together with DELETE_AIO_HANDLER [Kevin]

v2:
- Performance improvements
- Fix pre_sqe -> prep_sqe typo [Eric]
- Add #endif terminator comment [Eric]
- Fix spacing in aio_ctx_finalize() argument list [Eric]
- Add new "block/io_uring: use non-vectored read/write when possible" patch [Eric]
- Drop Patch 1 because multi-shot POLL_ADD has edge-triggered semantics instead
  of level-triggered semantics required by QEMU's AioContext APIs. The
  qemu-iotests 308 test case was hanging because block/export/fuse.c relies on
  level-triggered semantics. Luckily the performance reason for switching from
  one-shot to multi-shot has been solved by Patch 2 ("aio-posix: keep polling
  enabled with fdmon-io_uring.c"), so it's okay to use single-shot.
- Add a new Patch 1. It's a bug fix for a user-after-free in fdmon-io_uring.c
  triggered by qemu-iotests iothreads-nbd-export.

This patch series contains io_uring improvements:

1. Support the glib event loop in fdmon-io_uring.
   - aio-posix: fix race between io_uring CQE and AioHandler deletion
   - aio-posix: keep polling enabled with fdmon-io_uring.c
   - tests/unit: skip test-nested-aio-poll with io_uring
   - aio-posix: integrate fdmon into glib event loop

2. Enable fdmon-io_uring on hosts where io_uring is available at runtime.
   Otherwise continue using ppoll(2) or epoll(7).
   - aio: remove aio_context_use_g_source()

3. Add the new aio_add_sqe() API for submitting io_uring requests in the QEMU
   event loop.
   - aio: free AioContext when aio_context_new() fails
   - aio: add errp argument to aio_context_setup()
   - aio-posix: gracefully handle io_uring_queue_init() failure
   - aio-posix: add aio_add_sqe() API for user-defined io_uring requests
   - aio-posix: avoid EventNotifier for cqe_handler_bh

4. Use aio_add_sqe() in block/io_uring.c instead of creating a dedicated
   io_uring context for --blockdev aio=io_uring. This simplifies the code,
   reduces the number of file descriptors, and demonstrates the aio_add_sqe()
   API.
   - block/io_uring: use aio_add_sqe()
   - block/io_uring: use non-vectored read/write when possible

The highlight is aio_add_sqe(), which is needed for the FUSE-over-io_uring
Google Summer of Code project and other future QEMU features that natively use
Linux io_uring functionality.

rw        bs iodepth aio    iothread before after  diff
randread  4k       1 native        0  78353  84860 +8.3%
randread  4k      64 native        0 262370 269823 +2.8%
randwrite 4k       1 native        0 142703 144348 +1.2%
randwrite 4k      64 native        0 259947 263895 +1.5%
randread  4k       1 io_uring      0  76883  78270 +1.8%
randread  4k      64 io_uring      0 269712 250513 -7.1%
randwrite 4k       1 io_uring      0 143657 131481 -8.5%
randwrite 4k      64 io_uring      0 274461 264785 -3.5%
randread  4k       1 native        1  84080  84097 0.0%
randread  4k      64 native        1 314650 311193 -1.1%
randwrite 4k       1 native        1 172463 159993 -7.2%
randwrite 4k      64 native        1 303091 299726 -1.1%
randread  4k       1 io_uring      1  83415  84081 +0.8%
randread  4k      64 io_uring      1 324797 318429 -2.0%
randwrite 4k       1 io_uring      1 174421 172809 -0.9%
randwrite 4k      64 io_uring      1 323394 312286 -3.4%

Performance is in the same ballpark as without fdmon-io_uring. Results vary
from run to run due to the timing/batching of requests (even with iodepth=1 due
to 8 vCPUs using a single IOThread).

Here is the performance from v1 for reference:
rw        bs iodepth aio    iothread before after  diff
randread  4k       1 native        0  76281 79707  +4.5%
randread  4k      64 native        0 255078 247293 -3.1%
randwrite 4k       1 native        0 132706 123337 -7.1%
randwrite 4k      64 native        0 275589 245192 -11%
randread  4k       1 io_uring      0  75284 78023  +3.5%
randread  4k      64 io_uring      0 254637 248222 -2.5%
randwrite 4k       1 io_uring      0 126519 128641 +1.7%
randwrite 4k      64 io_uring      0 258967 249266 -3.7%
randread  4k       1 native        1  90557 88436  -2.3%
randread  4k      64 native        1 290673 280456 -3.5%
randwrite 4k       1 native        1 183015 169106 -7.6%
randwrite 4k      64 native        1 281316 280078 -0.4%
randread  4k       1 io_uring      1  92479 86983  -5.9%
randread  4k      64 io_uring      1 304229 257730 -15.3%
randwrite 4k       1 io_uring      1 183983 157425 -14.4%
randwrite 4k      64 io_uring      1 299979 264156 -11.9%

This series replaces the following older series that were held off from merging
until the QEMU 10.1 development window opened and the performance results were
collected:
- "[PATCH 0/3] [RESEND] block: unify block and fdmon io_uring"
- "[PATCH 0/4] aio-posix: integrate fdmon into glib event loop"

Stefan Hajnoczi (12):
  aio-posix: fix race between io_uring CQE and AioHandler deletion
  aio-posix: keep polling enabled with fdmon-io_uring.c
  tests/unit: skip test-nested-aio-poll with io_uring
  aio-posix: integrate fdmon into glib event loop
  aio: remove aio_context_use_g_source()
  aio: free AioContext when aio_context_new() fails
  aio: add errp argument to aio_context_setup()
  aio-posix: gracefully handle io_uring_queue_init() failure
  aio-posix: add aio_add_sqe() API for user-defined io_uring requests
  aio-posix: avoid EventNotifier for cqe_handler_bh
  block/io_uring: use aio_add_sqe()
  block/io_uring: use non-vectored read/write when possible

 include/block/aio.h               | 136 +++++++-
 include/block/raw-aio.h           |   5 -
 util/aio-posix.h                  |  18 +-
 block/file-posix.c                |  40 +--
 block/io_uring.c                  | 508 ++++++++----------------------
 stubs/io_uring.c                  |  32 --
 tests/unit/test-aio.c             |   7 +-
 tests/unit/test-nested-aio-poll.c |  13 +-
 util/aio-posix.c                  | 143 +++++----
 util/aio-win32.c                  |   6 +-
 util/async.c                      |  55 +---
 util/fdmon-epoll.c                |  52 ++-
 util/fdmon-io_uring.c             | 226 ++++++++++---
 util/fdmon-poll.c                 |  88 +++++-
 block/trace-events                |  12 +-
 stubs/meson.build                 |   3 -
 util/trace-events                 |   4 +
 17 files changed, 710 insertions(+), 638 deletions(-)
 delete mode 100644 stubs/io_uring.c

-- 
2.51.0


