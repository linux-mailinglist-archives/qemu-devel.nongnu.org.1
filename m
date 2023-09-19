Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A57A6950
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qie3H-0003ii-6a; Tue, 19 Sep 2023 12:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qie3B-0003eU-K1; Tue, 19 Sep 2023 12:58:13 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qie37-0002Mc-GH; Tue, 19 Sep 2023 12:58:13 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qidzZ-00DUte-2k;
 Tue, 19 Sep 2023 18:57:54 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 0/8] qemu-img: rebase: add compression support
Date: Tue, 19 Sep 2023 19:57:56 +0300
Message-Id: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

v2 --> v3:
 * Patch 3/8: fixed logic in the if statement, so that we align on blk
   when blk_old_backing == NULL;
 * Patch 4/8: comment fix;
 * Patch 5/8: comment fix; dropped redundant "if (blk_new_backing)"
   statements.

v2: https://lists.nongnu.org/archive/html/qemu-block/2023-09/msg00448.html

Andrey Drobyshev (8):
  qemu-img: rebase: stop when reaching EOF of old backing file
  qemu-iotests: 024: add rebasing test case for overlay_size >
    backing_size
  qemu-img: rebase: use backing files' BlockBackend for buffer alignment
  qemu-img: add chunk size parameter to compare_buffers()
  qemu-img: rebase: avoid unnecessary COW operations
  iotests/{024, 271}: add testcases for qemu-img rebase
  qemu-img: add compression option to rebase subcommand
  iotests: add tests for "qemu-img rebase" with compression

 docs/tools/qemu-img.rst    |   6 +-
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 | 136 ++++++++++++++++++++++--------
 tests/qemu-iotests/024     | 117 ++++++++++++++++++++++++++
 tests/qemu-iotests/024.out |  73 ++++++++++++++++
 tests/qemu-iotests/271     | 131 +++++++++++++++++++++++++++++
 tests/qemu-iotests/271.out |  82 ++++++++++++++++++
 tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/314.out |  75 +++++++++++++++++
 9 files changed, 752 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/314
 create mode 100644 tests/qemu-iotests/314.out

-- 
2.39.3


