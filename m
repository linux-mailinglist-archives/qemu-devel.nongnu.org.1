Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3957A2667
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDl7-0004TI-5o; Fri, 15 Sep 2023 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl4-0004M0-B7; Fri, 15 Sep 2023 14:41:38 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qhDl1-00037J-Gb; Fri, 15 Sep 2023 14:41:37 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qhDhb-00Fs9Q-23;
 Fri, 15 Sep 2023 20:41:28 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: stefanha@redhat.com, alexander.ivanov@virtuozzo.com,
 mike.maslenkin@gmail.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 00/21] implement discard operation for Parallels images
Date: Fri, 15 Sep 2023 20:41:07 +0200
Message-Id: <20230915184130.403366-1-den@openvz.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series introduces new block allocator scheme into unused data
blocks inside the image first and only after that extends the file.
On top of that naive implementation of discard and write-zeroes
(through the discard) is added.

There are also a bunch of bugs revealed in the code during the
implementation and testing.

Signed-off-by: Denis V. Lunev <den@openvz.org>

Denis V. Lunev (21):
  parallels: fix formatting in bdrv_parallels initialization
  parallels: mark driver as supporting CBT
  parallels: invent parallels_opts_prealloc() helper to parse prealloc
    opts
  parallels: return earler in fail_format branch in parallels_open()
  parallels: return earlier from parallels_open() function on error
  parallels: refactor path when we need to re-check image in
    parallels_open
  parallels: create mark_used() helper which sets bit in used bitmap
  tests: ensure that image validation will not cure the corruption
  parallels: fix broken parallels_check_data_off()
  parallels: add test which will validate data_off fixes through repair
  parallels: collect bitmap of used clusters at open
  tests: fix broken deduplication check in parallels format test
  tests: test self-cure of parallels image with duplicated clusters
  parallels: accept multiple clusters in mark_used()
  parallels: update used bitmap in allocate_cluster
  parallels: naive implementation of allocate_clusters with used bitmap
  parallels: improve readability of allocate_clusters
  parallels: naive implementation of parallels_co_pdiscard
  tests: extend test 131 to cover availability of the discard operation
  parallels: naive implementation of parallels_co_pwrite_zeroes
  tests: extend test 131 to cover availability of the write-zeroes

 block/parallels.c                             | 382 ++++++++++++++----
 block/parallels.h                             |   3 +
 tests/qemu-iotests/131                        |  51 +++
 tests/qemu-iotests/131.out                    |  58 +++
 tests/qemu-iotests/tests/parallels-checks     |  76 +++-
 tests/qemu-iotests/tests/parallels-checks.out |  65 ++-
 6 files changed, 534 insertions(+), 101 deletions(-)

-- 
2.34.1


