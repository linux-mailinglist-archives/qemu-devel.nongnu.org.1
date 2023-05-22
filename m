Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316B470C5C0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Apy-0003V4-2g; Mon, 22 May 2023 15:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apt-0003Ts-8R
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apr-0003YT-6c
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/A047vV4s2PnA++IFr/x55QkY5kLkxjjQflbXZ4XR0A=;
 b=WsYanDV4/vPDFuo1fBt1wi/BgvB0mBeQiGfgmqSc59jifJM2TonLuh/bs5ygKgD1+q5ey2
 1Dt5CfkpddCQBNXkm6jNWDRejG0S1hI0FZHN6++1Dnun6XTdy0MHoPWbruwBdaW7dyTSH8
 6+1z7QLAxy3HHJtHsgO+nOqxvvqnkEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-o2x3e4K_Oqec94S15ws11A-1; Mon, 22 May 2023 15:04:42 -0400
X-MC-Unique: o2x3e4K_Oqec94S15ws11A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAB9E101A53A;
 Mon, 22 May 2023 19:04:41 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86C8D482060;
 Mon, 22 May 2023 19:04:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 00/19] Fix qemu_strtosz() read-out-of-bounds
Date: Mon, 22 May 2023 14:04:22 -0500
Message-Id: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02951.html

Since then:
 - fix another qemu_strtoui bug
 - address review comments from Hanna

001/19:[----] [--] 'test-cutils: Avoid g_assert in unit tests'
002/19:[----] [--] 'test-cutils: Use g_assert_cmpuint where appropriate'
003/19:[----] [--] 'test-cutils: Test integral qemu_strto* value on failures'
004/19:[0204] [FC] 'test-cutils: Test more integer corner cases'
005/19:[0048] [FC] 'cutils: Fix wraparound parsing in qemu_strtoui'
006/19:[----] [--] 'cutils: Document differences between parse_uint and qemu_strtou64'
007/19:[0016] [FC] 'cutils: Adjust signature of parse_uint[_full]'
008/19:[----] [--] 'cutils: Allow NULL endptr in parse_uint()'
009/19:[0006] [FC] 'test-cutils: Add coverage of qemu_strtod'
010/19:[----] [--] 'test-cutils: Prepare for upcoming semantic change in qemu_strtosz'
011/19:[----] [--] 'test-cutils: Refactor qemu_strtosz tests for less boilerplate'
012/19:[0007] [FC] 'cutils: Allow NULL str in qemu_strtosz'
013/19:[----] [--] 'numa: Check for qemu_strtosz_MiB error'
014/19:[0007] [FC] 'test-cutils: Add more coverage to qemu_strtosz'
015/19:[----] [--] 'cutils: Set value in all qemu_strtosz* error paths'
016/19:[----] [--] 'cutils: Set value in all integral qemu_strto* error paths'
017/19:[0013] [FC] 'cutils: Use parse_uint in qemu_strtosz for negative rejection'
018/19:[----] [--] 'cutils: Improve qemu_strtod* error paths'
019/19:[----] [--] 'cutils: Improve qemu_strtosz handling of fractions'

Eric Blake (19):
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

 include/qemu/cutils.h            |    5 +-
 audio/audio_legacy.c             |    4 +-
 block/gluster.c                  |    4 +-
 block/nfs.c                      |    4 +-
 blockdev.c                       |    4 +-
 contrib/ivshmem-server/main.c    |    4 +-
 hw/core/numa.c                   |   11 +-
 qapi/opts-visitor.c              |   10 +-
 tests/unit/test-cutils.c         | 2469 ++++++++++++++++++++++--------
 ui/vnc.c                         |    4 +-
 util/cutils.c                    |  262 ++--
 util/guest-random.c              |    4 +-
 util/qemu-sockets.c              |   10 +-
 tests/qemu-iotests/049.out       |    7 +-
 tests/qemu-iotests/178.out.qcow2 |    3 +-
 tests/qemu-iotests/178.out.raw   |    3 +-
 16 files changed, 2030 insertions(+), 778 deletions(-)


base-commit: ad3387396a71416cacc0b394e5e440dd6e9ba19a
prerequisite-patch-id: 7d7341e4caa6f8ef05dda8dd5f43b98a6ef969f1
-- 
2.40.1


