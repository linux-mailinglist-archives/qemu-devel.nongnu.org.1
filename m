Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D136074F738
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH7m-0005x2-OI; Tue, 11 Jul 2023 13:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7k-0005vJ-Gw; Tue, 11 Jul 2023 13:26:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7h-0006yU-MH; Tue, 11 Jul 2023 13:26:04 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qJH6B-008F35-2s;
 Tue, 11 Jul 2023 19:25:44 +0200
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 0/3] block: align CoR requests to subclusters
Date: Tue, 11 Jul 2023 20:25:50 +0300
Message-Id: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
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
 * Fixed line indentation;
 * Fixed wording in a comment;
 * Added R-b.

v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html

Andrey Drobyshev (3):
  block: add subcluster_size field to BlockDriverInfo
  block/io: align requests to subcluster_size
  tests/qemu-iotests/197: add testcase for CoR with subclusters

 block.c                      |  7 +++++
 block/io.c                   | 50 ++++++++++++++++++------------------
 block/mirror.c               |  8 +++---
 block/qcow2.c                |  1 +
 include/block/block-common.h |  5 ++++
 include/block/block-io.h     |  8 +++---
 tests/qemu-iotests/197       | 29 +++++++++++++++++++++
 tests/qemu-iotests/197.out   | 24 +++++++++++++++++
 8 files changed, 99 insertions(+), 33 deletions(-)

-- 
2.39.3


