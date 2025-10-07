Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C0BC1B23
	for <lists+qemu-devel@lfdr.de>; Tue, 07 Oct 2025 16:21:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68VS-0002sq-Ag; Tue, 07 Oct 2025 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v68VN-0002jq-5i
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v68VE-0003WM-FX
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759846638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=87EPZnhYYSrmGCvxlHgdPsfrcpVWTX38Y6k6U49WOSg=;
 b=ATJvO2/c+sO0oDNQWDR/n9cEZOetfvRDBoIO5dchzU/RLADnmr/p6U2bLWSvJxqSwX8YSp
 76I00VFI0GXu2tdkd3XCtzBNVBHNmnMhBhuIxLKaV8oOG2abPXPIoOnSZfU0bcu3tyXnsC
 fOtjja/f/D/8PaK2hL2zlJOYYZg3w1I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-v3BH13ZHNaCW6dhz4wr9KQ-1; Tue,
 07 Oct 2025 10:17:14 -0400
X-MC-Unique: v3BH13ZHNaCW6dhz4wr9KQ-1
X-Mimecast-MFC-AGG-ID: v3BH13ZHNaCW6dhz4wr9KQ_1759846632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EC6B1944D3C; Tue,  7 Oct 2025 14:17:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.229])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 488501800447; Tue,  7 Oct 2025 14:17:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/3] block: use pwrite_zeroes_alignment when writing first
 sector
Date: Tue,  7 Oct 2025 10:16:57 -0400
Message-ID: <20251007141700.71891-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

v2:
- Simplify condition to if (!s->needs_alignment) in patch 1 [Vladimir]

This series fixes a bug I introduced in commit 5634622bcb33 ("file-posix: allow
BLKZEROOUT with -t writeback"). The Linux fallocate(2) and ioctl(BLKZEROOUT)
syscalls require logical block size alignment of the offset and length, even
when the file is opened in buffered I/O mode where read/write operations do not
require alignment.

The fix is to populate the pwrite_zeroes_alignment block limits field and to
use that limit in create_file_fallback_zero_first_sector().

One issue I want to raise is that pwrite_zeroes_alignment is an "optimal
alignment" hint. Hence create_file_fallback_zero_first_sector() had to be
modified to honor the limit explicitly. The block layer doesn't automatically
apply padding in order to align requests. This is different from how QEMU's
block layer pwrite/pread works, where it does automatically apply padding and
read/modify/write as necessary. If you want consistency, please let me know.

Stefan Hajnoczi (3):
  file-posix: populate pwrite_zeroes_alignment
  block: use pwrite_zeroes_alignment when writing first sector
  iotests: add Linux loop device image creation test

 include/system/block-backend-io.h             |  1 +
 block.c                                       |  3 +-
 block/block-backend.c                         | 11 ++++
 block/file-posix.c                            | 16 +++++
 tests/qemu-iotests/tests/loop-create-file     | 59 +++++++++++++++++++
 tests/qemu-iotests/tests/loop-create-file.out |  8 +++
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/tests/loop-create-file
 create mode 100644 tests/qemu-iotests/tests/loop-create-file.out

-- 
2.51.0


