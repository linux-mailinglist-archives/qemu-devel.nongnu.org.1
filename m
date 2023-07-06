Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DF74A23A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRtX-0000Pc-BM; Thu, 06 Jul 2023 12:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRso-0008Q0-IL; Thu, 06 Jul 2023 12:31:06 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHRsg-0007Pu-2J; Thu, 06 Jul 2023 12:30:59 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qHRrH-00D6CC-0V;
 Thu, 06 Jul 2023 18:30:47 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net,
 eblake@redhat.com, vsementsov@yandex-team.ru,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 0/3] qemu-img: map: implement support for compressed
 clusters
Date: Thu,  6 Jul 2023 19:30:44 +0300
Message-Id: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
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

v1 --> v2:
  * Add vmdk format to the 1st commit.  Tweak commit message accordingly;
  * Make "compressed" field in MapEntry optional.

v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00184.html

Andrey Drobyshev (3):
  block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
  qemu-img: map: report compressed data blocks
  qemu-iotests: update expected tests output to contain "compressed"
    field

 block/qcow.c                                  |   5 +-
 block/qcow2.c                                 |   3 +
 block/vmdk.c                                  |   2 +
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
 13 files changed, 302 insertions(+), 278 deletions(-)

-- 
2.39.3


