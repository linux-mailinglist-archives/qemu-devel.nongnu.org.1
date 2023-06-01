Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728171F2EC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nyp-0006pF-NS; Thu, 01 Jun 2023 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyZ-0006jr-10; Thu, 01 Jun 2023 15:28:48 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyV-0005mF-Tn; Thu, 01 Jun 2023 15:28:46 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q4nyC-00DLDg-0M;
 Thu, 01 Jun 2023 21:28:36 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/6] qemu-img: rebase: add compression support
Date: Thu,  1 Jun 2023 22:28:30 +0300
Message-Id: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series is adding [-c | --compress] option to "qemu-img rebase"
command, which might prove useful for saving some disk space when, for
instance, manipulating chains of backup images.  Along the way I had to
make a couple of minor improvements.

The first 2 patches are a bug fix + corresponding test case.
Patch 3 merely fixes wrong args used in allocation.
Patch 4 makes write requests during rebase operation cluster_size-aligned,
which seems to be beneficial for both non-compressed and compressed mode.
The last 2 patches are the actual feature implementation + tests.

Andrey Drobyshev (6):
  qemu-img: rebase: stop when reaching EOF of old backing file
  qemu-iotests: 024: add rebasing test case for overlay_size >
    backing_size
  qemu-img: rebase: use backing files' BlockBackend for buffer alignment
  qemu-img: rebase: avoid unnecessary COW operations
  qemu-img: add compression option to rebase subcommand
  iotests: add test 314 for "qemu-img rebase" with compression

 docs/tools/qemu-img.rst    |   6 +-
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 | 106 ++++++++++++++++++------
 tests/qemu-iotests/024     |  57 +++++++++++++
 tests/qemu-iotests/024.out |  30 +++++++
 tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/314.out |  75 +++++++++++++++++
 7 files changed, 415 insertions(+), 28 deletions(-)
 create mode 100755 tests/qemu-iotests/314
 create mode 100644 tests/qemu-iotests/314.out

-- 
2.31.1


