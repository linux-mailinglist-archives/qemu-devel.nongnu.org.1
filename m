Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FF7A9255
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWi-0004k7-IX; Thu, 21 Sep 2023 03:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWg-0004iJ-50; Thu, 21 Sep 2023 03:55:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qjEWe-0001Ss-17; Thu, 21 Sep 2023 03:55:05 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qjEWO-00BsUn-0O;
 Thu, 21 Sep 2023 09:55:01 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PULL v2 00/22] implement discard operation for Parallels images
Date: Thu, 21 Sep 2023 09:54:38 +0200
Message-Id: <20230921075500.694585-1-den@openvz.org>
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:

  Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)

are available in the Git repository at:

  https://src.openvz.org/scm/~den/qemu.git tags/pull-parallels-2023-09-20-v2

for you to fetch changes up to 1dba99e34d1bcb3c0de69c4270f9587b01e225fe:

  tests: extend test 131 to cover availability of the write-zeroes (2023-09-21 08:49:28 +0200)

----------------------------------------------------------------
Parallels format driver:
* regular calculation of cluster used bitmap of the image file
* cluster allocation on the base of that bitmap (effectively allocation of
  new clusters could be done inside the image if that offset space is unused)
* support of DISCARD and WRITE_ZEROES operations
* image check bugfixes
* unit tests fixes
* unit tests covering new functionality

----------------------------------------------------------------
Changes from v1:
* patch 12: bdrv_co_getlength -> bdrv_getlength in parallels_fill_used_bitmap
  as called from open()
* patch 19: added GRAPH_RDLOCK specifier for parallels_co_pdiscard
* patch 21: added GRAPH_RDLOCK specifier for parallels_co_pwrite_zeroes

----------------------------------------------------------------
Denis V. Lunev (22):
      parallels: fix formatting in bdrv_parallels initialization
      parallels: mark driver as supporting CBT
      parallels: fix memory leak in parallels_open()
      parallels: invent parallels_opts_prealloc() helper to parse prealloc opts
      parallels: return earler in fail_format branch in parallels_open()
      parallels: return earlier from parallels_open() function on error
      parallels: refactor path when we need to re-check image in parallels_open
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

 block/parallels.c                             | 389 ++++++++++++++++++++------
 block/parallels.h                             |   3 +
 tests/qemu-iotests/131                        |  52 ++++
 tests/qemu-iotests/131.out                    |  60 ++++
 tests/qemu-iotests/tests/parallels-checks     |  76 ++++-
 tests/qemu-iotests/tests/parallels-checks.out |  65 ++++-
 6 files changed, 544 insertions(+), 101 deletions(-)

-- 
2.34.1


