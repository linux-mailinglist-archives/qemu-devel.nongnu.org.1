Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3177940C0
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumv-0007By-BI; Wed, 06 Sep 2023 11:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdums-0007Ah-PW; Wed, 06 Sep 2023 11:49:50 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdump-0002xp-8c; Wed, 06 Sep 2023 11:49:50 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qdujg-007L3X-2V;
 Wed, 06 Sep 2023 17:49:31 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PULL 00/18] Parallels format driver
Date: Wed,  6 Sep 2023 17:49:33 +0200
Message-Id: <20230906154942.656537-1-den@openvz.org>
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

  Merge tag 'pull-request-2023-08-31' of https://gitlab.com/thuth/qemu into staging (2023-09-05 09:22:13 -0400)

are available in the Git repository at:

  https://src.openvz.org/scm/~den/qemu.git tags/pull-parallels-2023-09-06

for you to fetch changes up to 06fca745d5ba3be8b693985e6075d6ba2782f145:

  iotests: Add test for data_off check (2023-09-06 17:36:49 +0200)

----------------------------------------------------------------
Please note. This is the first pull request from me.
My public GPG key is available here
https://keys.openpgp.org/search?q=den%40openvz.org
https://keys.openpgp.org/vks/v1/by-fingerprint/F6F1367F707CF91519227CAD3F30A5AE93779C9F
----------------------------------------------------------------
Parallels format driver changes:
  * Fix comments formatting inside parallels driver
  * Incorrect data end calculation in parallels_open()
  * Check if data_end greater than the file size
  * Add "explicit" argument to parallels_check_leak()
  * Add data_start field to BDRVParallelsState
  * Add checking and repairing duplicate offsets in BAT
  * Image repairing in parallels_open()
  * Use bdrv_co_getlength() in parallels_check_outside_image()
  * Add data_off check
  * Add data_off repairing to parallels_open()
  * Fix record in MAINTAINERS

Parallels format driver tests:
  * Add out-of-image check test for parallels format
  * Add leak check test for parallels format
  * Add test for BAT entries duplication check
  * Refactor tests of parallels images checks (131)
  * Fix cluster size in parallels images tests (131)
  * Fix test 131 after repair was added to parallels_open()
  * Add test for data_off check
----------------------------------------------------------------
Alexander Ivanov (17):
      parallels: Fix comments formatting inside parallels driver
      parallels: Incorrect data end calculation in parallels_open()
      parallels: Check if data_end greater than the file size
      parallels: Add "explicit" argument to parallels_check_leak()
      parallels: Add data_start field to BDRVParallelsState
      parallels: Add checking and repairing duplicate offsets in BAT
      parallels: Image repairing in parallels_open()
      parallels: Use bdrv_co_getlength() in parallels_check_outside_image()
      parallels: Add data_off check
      parallels: Add data_off repairing to parallels_open()
      iotests: Add out-of-image check test for parallels format
      iotests: Add leak check test for parallels format
      iotests: Add test for BAT entries duplication check
      iotests: Refactor tests of parallels images checks (131)
      iotests: Fix cluster size in parallels images tests (131)
      iotests: Fix test 131 after repair was added to parallels_open()
      iotests: Add test for data_off check

Denis V. Lunev (1):
      MAINTAINERS: add tree to keep parallels format driver changes

 MAINTAINERS                                   |   1 +
 block/parallels.c                             | 346 ++++++++++++++++++++++----
 block/parallels.h                             |   1 +
 tests/qemu-iotests/131                        |  36 +--
 tests/qemu-iotests/131.out                    |  59 ++---
 tests/qemu-iotests/tests/parallels-checks     | 145 +++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  75 ++++++
 7 files changed, 564 insertions(+), 99 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/parallels-checks
 create mode 100644 tests/qemu-iotests/tests/parallels-checks.out

