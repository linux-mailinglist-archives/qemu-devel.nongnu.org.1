Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B257A7264A3
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:28:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6v3d-0008TP-Bh; Wed, 07 Jun 2023 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q6v3S-0008Rl-Md; Wed, 07 Jun 2023 11:26:34 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q6v3R-0007d3-9L; Wed, 07 Jun 2023 11:26:34 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q6v2w-00E8qK-32;
 Wed, 07 Jun 2023 17:26:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/3] qemu-img: map: implement support for compressed clusters
Date: Wed,  7 Jun 2023 18:26:24 +0300
Message-Id: <20230607152627.468786-1-andrey.drobyshev@virtuozzo.com>
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

This series adds "compressed" field to the output of "qemu-img map"
command, specifying whether or not data block is compressed.  Only
JSON output mode is affected.  With this applied, output looks like so:

# qemu-img create -f qcow2 img.qcow2 192K
# qemu-io -c "write -c -P 0xaa 0 64K" img.qcow2
# qemu-io -c "write -P 0xbb 64K 64K" img.qcow2
# qemu-img map --output=json img.qcow2

[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": true},
{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 393216},
{ "start": 131072, "length": 65536, "depth": 0, "present": false, "zero": true, "data": false, "compressed": false}]

Only formats supporting compression are affected (qcow, qcow2).

Andrey Drobyshev (3):
  block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
  qemu-img: map: report compressed data blocks
  qemu-iotests: update expected tests output to contain "compressed"
    field

 block/qcow.c                                  |   5 +-
 block/qcow2.c                                 |   3 +
 include/block/block-common.h                  |   3 +
 qapi/block-core.json                          |   7 +-
 qemu-img.c                                    |  16 +-
 tests/qemu-iotests/122.out                    |  84 ++++----
 tests/qemu-iotests/154.out                    | 194 +++++++++---------
 tests/qemu-iotests/179.out                    | 178 ++++++++--------
 tests/qemu-iotests/244.out                    |  24 +--
 tests/qemu-iotests/252.out                    |  10 +-
 tests/qemu-iotests/274.out                    |  48 ++---
 .../tests/nbd-qemu-allocation.out             |   6 +-
 12 files changed, 300 insertions(+), 278 deletions(-)

-- 
2.31.1


