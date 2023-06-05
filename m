Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3D1722BD9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CP1-0007ik-TY; Mon, 05 Jun 2023 11:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6COz-0007iC-6T
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6COx-0001HK-H9
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LSIE00uJ2eJCMSh2vZboXPZY4W5SF+27BlxOXvhoE8c=;
 b=XCwFwMDYEmGjkWukVxwfhR8wXq8xYo7Q2Ky5X6QskJhRTzRiskA+ofhKAVslViu7fxw3es
 FZtCb4SnSiDKraxlm/Z1c+Buo2NN6J61KnXMScuSsNyPY75oshM/1xMD6IDkiT57fjrCjb
 EpyU4W9Rg5XFG2qoecXHviQrKmm989s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-AU1x1F8JNJa1nk7BtpfJZA-1; Mon, 05 Jun 2023 11:45:44 -0400
X-MC-Unique: AU1x1F8JNJa1nk7BtpfJZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 886A53801ED3;
 Mon,  5 Jun 2023 15:45:43 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C3640CFD47;
 Mon,  5 Jun 2023 15:45:43 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/17] Block patches
Date: Mon,  5 Jun 2023 17:45:24 +0200
Message-Id: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:

  Merge tag 'migration-20230602-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-06-02 17:33:29 -0700)

are available in the Git repository at:

  https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-06-05

for you to fetch changes up to 42a2890a76f4783cd1c212f27856edcf2b5e8a75:

  qcow2: add discard-no-unref option (2023-06-05 13:15:42 +0200)

----------------------------------------------------------------
Block patches

- Fix padding of unaligned vectored requests to match the host alignment
  for vectors with 1023 or 1024 buffers
- Refactor and fix bugs in parallels's image check functionality
- Add an option to the qcow2 driver to retain (qcow2-level) allocations
  on discard requests from the guest (while still forwarding the discard
  to the lower level and marking the range as zero)

----------------------------------------------------------------
Alexander Ivanov (12):
  parallels: Out of image offset in BAT leads to image inflation
  parallels: Fix high_off calculation in parallels_co_check()
  parallels: Fix image_end_offset and data_end after out-of-image check
  parallels: create parallels_set_bat_entry_helper() to assign BAT value
  parallels: Use generic infrastructure for BAT writing in
    parallels_co_check()
  parallels: Move check of unclean image to a separate function
  parallels: Move check of cluster outside image to a separate function
  parallels: Fix statistics calculation
  parallels: Move check of leaks to a separate function
  parallels: Move statistic collection to a separate function
  parallels: Replace qemu_co_mutex_lock by WITH_QEMU_LOCK_GUARD
  parallels: Incorrect condition in out-of-image check

Hanna Czenczek (4):
  util/iov: Make qiov_slice() public
  block: Collapse padded I/O vecs exceeding IOV_MAX
  util/iov: Remove qemu_iovec_init_extended()
  iotests/iov-padding: New test

Jean-Louis Dupond (1):
  qcow2: add discard-no-unref option

 qapi/block-core.json                     |  12 ++
 block/qcow2.h                            |   3 +
 include/qemu/iov.h                       |   8 +-
 block/io.c                               | 166 ++++++++++++++++++--
 block/parallels.c                        | 190 ++++++++++++++++-------
 block/qcow2-cluster.c                    |  32 +++-
 block/qcow2.c                            |  18 +++
 util/iov.c                               |  89 ++---------
 qemu-options.hx                          |  12 ++
 tests/qemu-iotests/tests/iov-padding     |  85 ++++++++++
 tests/qemu-iotests/tests/iov-padding.out |  59 +++++++
 11 files changed, 523 insertions(+), 151 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iov-padding
 create mode 100644 tests/qemu-iotests/tests/iov-padding.out

-- 
2.40.1


