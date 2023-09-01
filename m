Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7A78F9D4
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMI-00070i-R1; Fri, 01 Sep 2023 04:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMF-0006zu-NI
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzM2-00010o-9e
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DtKBay6n++cofWRjOzeMBD4leGu9/NyLjeiF9vuISZ8=;
 b=ICDWdDLA8zI7GwGL9Os6t/XLk8ivAWQcHthM53+XgsGi9vr/EwRfZYrQk4q/Phi5GZzs+J
 xHeekCqubw8Ac6UlCatchF/UM6MYQ9j/JwktqYUUph0iiZJP2UrpWQteBIHRuNV1gSziZZ
 3wJeH4fcHKIc/HajYNmdTJuzdDvWXK4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-IFIm4m-1O8iWjImvJCZg-g-1; Fri, 01 Sep 2023 04:18:07 -0400
X-MC-Unique: IFIm4m-1O8iWjImvJCZg-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C80243827DFE;
 Fri,  1 Sep 2023 08:18:06 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D6040C6F4C;
 Fri,  1 Sep 2023 08:18:06 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 00/14] Block patches
Date: Fri,  1 Sep 2023 10:17:55 +0200
Message-ID: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81:

  Merge tag 'pull-tcg-20230823-2' of https://gitlab.com/rth7680/qemu into staging (2023-08-28 16:07:04 -0400)

are available in the Git repository at:

  https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-09-01

for you to fetch changes up to 380448464dd89291cf7fd7434be6c225482a334d:

  tests/file-io-error: New test (2023-08-29 13:01:24 +0200)

----------------------------------------------------------------
Block patches

- Fix for file-posix's zoning code crashing on I/O errors
- Throttling refactoring

----------------------------------------------------------------
Hanna Czenczek (5):
  file-posix: Clear bs->bl.zoned on error
  file-posix: Check bs->bl.zoned for zone info
  file-posix: Fix zone update in I/O error path
  file-posix: Simplify raw_co_prw's 'out' zone code
  tests/file-io-error: New test

Zhenwei Pi (9):
  throttle: introduce enum ThrottleDirection
  test-throttle: use enum ThrottleDirection
  throttle: support read-only and write-only
  test-throttle: test read only and write only
  cryptodev: use NULL throttle timer cb for read direction
  throttle: use enum ThrottleDirection instead of bool is_write
  throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
  fsdev: Use ThrottleDirection instread of bool is_write
  block/throttle-groups: Use ThrottleDirection instread of bool is_write

 fsdev/qemu-fsdev-throttle.h                |   4 +-
 include/block/throttle-groups.h            |   6 +-
 include/qemu/throttle.h                    |  16 +-
 backends/cryptodev.c                       |  12 +-
 block/block-backend.c                      |   4 +-
 block/file-posix.c                         |  42 +++---
 block/throttle-groups.c                    | 163 +++++++++++----------
 block/throttle.c                           |   8 +-
 fsdev/qemu-fsdev-throttle.c                |  18 ++-
 hw/9pfs/cofile.c                           |   4 +-
 tests/unit/test-throttle.c                 |  76 +++++++++-
 util/throttle.c                            |  84 +++++++----
 tests/qemu-iotests/tests/file-io-error     | 119 +++++++++++++++
 tests/qemu-iotests/tests/file-io-error.out |  33 +++++
 14 files changed, 418 insertions(+), 171 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/file-io-error
 create mode 100644 tests/qemu-iotests/tests/file-io-error.out

-- 
2.41.0


