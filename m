Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEDA9BBFD
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 02:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87LE-0006Qm-Ls; Thu, 24 Apr 2025 20:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LC-0006QE-Gq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87L7-0000TQ-QY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZOTPoAGMtuaIknH16YbMOl0qHRzMGWpcTgWcrjLiBso=;
 b=JG/zwTR15NVXkkznNXhvkWHF02VMw2IvTD2Ltd1Kw6Aylp6ZNlFA048Z1b/w5n5AeolKPp
 DUiJGIJ5B41Z6oq2+fEvskRglstwjIUj7Xz+hvFjvgLd1PDMlicApfRxLAxZWQwhOHJ3FP
 5Etx3/iNtG7SWCQTehjgekWAkZrBhuo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-WXfj6aLNO6GGfKhXr91HYA-1; Thu,
 24 Apr 2025 20:54:45 -0400
X-MC-Unique: WXfj6aLNO6GGfKhXr91HYA-1
X-Mimecast-MFC-AGG-ID: WXfj6aLNO6GGfKhXr91HYA_1745542484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA8C1956088; Fri, 25 Apr 2025 00:54:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A08351800374; Fri, 25 Apr 2025 00:54:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	stefanha@redhat.com
Subject: [PATCH v3 00/11] Make blockdev-mirror dest sparse in more cases
Date: Thu, 24 Apr 2025 19:52:00 -0500
Message-ID: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg02940.html

In v3:
 - use flags instead of enum at start of series [Stefan]
 - Don't throttle for skipped zeroes [Sunny]
 - Try harder to punch holes for "detect-zeroes":"unmap"
 - More cases in mirror-sparse iotest
 - R-b added on patches that didn't drastically change

Andrey Drobyshev (1):
  iotests/common.rc: add disk_usage function

Eric Blake (10):
  block: Expand block status mode from bool to flags
  file-posix, gluster: Handle zero block status hint better
  block: Let bdrv_co_is_zero_fast consolidate adjacent extents
  block: Add new bdrv_co_is_all_zeroes() function
  iotests: Improve iotest 194 to mirror data
  mirror: Minor refactoring
  mirror: Skip pre-zeroing destination if it is already zero
  mirror: Skip writing zeroes when target is already zero
  tests: Add iotest mirror-sparse for recent patches
  mirror: Allow QMP override to declare target already zero

 qapi/block-core.json                       |   8 +-
 block/coroutines.h                         |   4 +-
 include/block/block-common.h               |  11 +
 include/block/block-io.h                   |   2 +
 include/block/block_int-common.h           |  27 +-
 include/block/block_int-global-state.h     |   3 +-
 include/block/block_int-io.h               |   4 +-
 block/io.c                                 | 126 +++++--
 block/blkdebug.c                           |   6 +-
 block/copy-before-write.c                  |   4 +-
 block/file-posix.c                         |   5 +-
 block/gluster.c                            |   4 +-
 block/iscsi.c                              |   6 +-
 block/mirror.c                             | 150 +++++++--
 block/nbd.c                                |   4 +-
 block/null.c                               |   6 +-
 block/parallels.c                          |   6 +-
 block/qcow.c                               |   2 +-
 block/qcow2.c                              |   6 +-
 block/qed.c                                |   6 +-
 block/quorum.c                             |   4 +-
 block/raw-format.c                         |   4 +-
 block/rbd.c                                |   6 +-
 block/snapshot-access.c                    |   4 +-
 block/vdi.c                                |   4 +-
 block/vmdk.c                               |   2 +-
 block/vpc.c                                |   2 +-
 block/vvfat.c                              |   6 +-
 blockdev.c                                 |  18 +-
 tests/unit/test-block-iothread.c           |   4 +-
 tests/qemu-iotests/common.rc               |   6 +
 tests/qemu-iotests/194                     |   1 +
 tests/qemu-iotests/250                     |   5 -
 tests/qemu-iotests/tests/mirror-sparse     | 128 ++++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 365 +++++++++++++++++++++
 35 files changed, 815 insertions(+), 134 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

-- 
2.49.0


