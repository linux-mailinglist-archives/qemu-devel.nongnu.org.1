Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B677A022C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkEa-0003f7-OW; Thu, 14 Sep 2023 07:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkEV-0003dq-VO; Thu, 14 Sep 2023 07:10:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkES-0006GR-Rj; Thu, 14 Sep 2023 07:10:03 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkB4-003B3F-0Q; Thu, 14 Sep 2023 13:09:54 +0200
To: qemu-block@nongnu.org,
	kwolf@redhat.com
Cc: hreitz@redhat.com,
	qemu-devel@nongnu.org,
	den@virtuozzo.com
Subject: [PATCH 0/2] block: do not try to list nearly-dropped filters
Date: Thu, 14 Sep 2023 13:09:49 +0200
Message-Id: <20230914110951.845856-1-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
From:  Andrey Zhadchenko via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

QEMU crashes on QMP command 'query-named-block-nodes' if we have
finalized but not dismissed block job with filter, for example
block-stream.
This happens because the filter no longer has references from which
QEMU can query block info. Skip such filters while listing block nodes.

This patchset also adds simple test for this case.

Andrey Zhadchenko (2):
  block: do not try to list nearly-dropped filters
  iotests: add new test case for image streaming

 block.c                    |  7 +++++--
 block/qapi.c               |  5 +++++
 tests/qemu-iotests/030     | 17 +++++++++++++++++
 tests/qemu-iotests/030.out |  4 ++--
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.40.1


