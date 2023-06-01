Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2E71F582
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOJ-000810-5e; Thu, 01 Jun 2023 18:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOB-000802-TS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003yr-EO
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EJHTp0xclZt5/5JUMmTISEfNWeI+pvsEbtzWCRF31Og=;
 b=XY9UCNG4EbdfAusXX1FFWYr6xRiMZgboIcsSDpP8hYa/kXA4omfVEliRz98ocVN4wAaeV+
 mHTSNx3UtxuRtoo2Gt7HvbJwiMkDYiM2bFMgk+KZIRI1nOPEZOBE/306MdQsKtgDBn4m2A
 w+sVeJRHwqVu64MVn07ncP+qRd8+7T0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-XwWFS5MQNd-PL8QUVhwUcw-1; Thu, 01 Jun 2023 18:03:10 -0400
X-MC-Unique: XwWFS5MQNd-PL8QUVhwUcw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9FAE8015D8
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 22:03:09 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 981C0492B0B
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 22:03:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] NBD and miscellaneous patches for 2023-06-01
Date: Thu,  1 Jun 2023 17:02:44 -0500
Message-Id: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

The following changes since commit 19a720b74fde7e859d19f12c66a72e545947a657:

  Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-06-01 08:30:29 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-06-01

for you to fetch changes up to 58516caac47c4bc7ed3ad6a8e2f565404a563dd3:

  cutils: Improve qemu_strtosz handling of fractions (2023-06-01 16:55:25 -0500)

----------------------------------------------------------------
nbd and misc patches for 2023-06-01

- Eric Blake: Fix iotest 104 for NBD
- Eric Blake: Improve qcow2 spec on padding bytes
- Eric Blake: Fix read-beyond-bounds bug in qemu_strtosz

----------------------------------------------------------------
Eric Blake (21):
      iotests: Fix test 104 under NBD
      qcow2: Explicit mention of padding bytes
      test-cutils: Avoid g_assert in unit tests
      test-cutils: Use g_assert_cmpuint where appropriate
      test-cutils: Test integral qemu_strto* value on failures
      test-cutils: Test more integer corner cases
      cutils: Fix wraparound parsing in qemu_strtoui
      cutils: Document differences between parse_uint and qemu_strtou64
      cutils: Adjust signature of parse_uint[_full]
      cutils: Allow NULL endptr in parse_uint()
      test-cutils: Add coverage of qemu_strtod
      test-cutils: Prepare for upcoming semantic change in qemu_strtosz
      test-cutils: Refactor qemu_strtosz tests for less boilerplate
      cutils: Allow NULL str in qemu_strtosz
      numa: Check for qemu_strtosz_MiB error
      test-cutils: Add more coverage to qemu_strtosz
      cutils: Set value in all qemu_strtosz* error paths
      cutils: Set value in all integral qemu_strto* error paths
      cutils: Use parse_uint in qemu_strtosz for negative rejection
      cutils: Improve qemu_strtod* error paths
      cutils: Improve qemu_strtosz handling of fractions

 docs/interop/qcow2.txt           |    1 +
 include/qemu/cutils.h            |    5 +-
 audio/audio_legacy.c             |    4 +-
 block/gluster.c                  |    4 +-
 block/nfs.c                      |    4 +-
 blockdev.c                       |    4 +-
 contrib/ivshmem-server/main.c    |    4 +-
 hw/core/numa.c                   |   11 +-
 qapi/opts-visitor.c              |   10 +-
 tests/unit/test-cutils.c         | 2469 ++++++++++++++++++++++++++++----------
 ui/vnc.c                         |    4 +-
 util/cutils.c                    |  263 ++--
 util/guest-random.c              |    4 +-
 util/qemu-sockets.c              |   10 +-
 tests/qemu-iotests/common.filter |    4 +-
 tests/qemu-iotests/common.rc     |    3 +-
 tests/qemu-iotests/049.out       |    7 +-
 tests/qemu-iotests/178.out.qcow2 |    3 +-
 tests/qemu-iotests/178.out.raw   |    3 +-
 19 files changed, 2035 insertions(+), 782 deletions(-)

-- 
2.40.1


