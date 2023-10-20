Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D647D1878
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 23:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtxU2-0003sj-Ee; Fri, 20 Oct 2023 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTu-0003pP-A7; Fri, 20 Oct 2023 17:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qtxTq-0008G4-MS; Fri, 20 Oct 2023 17:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=wxV8jJCKMJsQLTHWA67DTG5c2jc9NIxrsoeUcM+AqXY=; b=HXcGxgUcv9/W
 AixKSuZpU8N76EAmosQSGY2WDOOojLJDG8XIjsIYPoY8kC+C+0CKMnDypQ1U+D9iIgLn2NmTwE6LZ
 vQSAKkmccL1MZ4QiZk1nVPGfgRYtNle2XpAaqMiSko8gRpbhRBdF9uEHMNlVmOuIo58mZ/uliLqxh
 lWRMpb6zYLc3doNfOS59MMWf04QWueJvItDbMfjWSMaG8D/WVc5YTytkOxSISARzAwbIQZGXYsaRK
 QO86f1lKMJKKLtw75t1v4SQ9aCAKYPnnfHiVAk/xZ9yMQjjdMzdGZr4TRWKT8nMOJl+EgmXmCZ3a5
 Rkz/zz3bAkBm1bgqPTh/Fw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qtxTT-00A9pF-1Z;
 Fri, 20 Oct 2023 23:56:20 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 0/7] qcow2: make subclusters discardable
Date: Sat, 21 Oct 2023 00:56:15 +0300
Message-Id: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series extends the discard operation for qcow2 driver so that it
can be used to discard individial subclusters.  This feature might prove
useful and gain some host disk space when dealing with the guest
TRIM/discard requests, especially with large clusters (1M, 2M) when
subclusters are enabled.

Andrey Drobyshev (7):
  qcow2: make function update_refcount_discard() global
  qcow2: add get_sc_range_info() helper for working with subcluster
    ranges
  qcow2: zeroize the entire cluster when there're no non-zero
    subclusters
  qcow2: make subclusters discardable
  qcow2: zero_l2_subclusters: fall through to discard operation when
    requested
  iotests/common.rc: add disk_usage function
  iotests/271: check disk usage on subcluster-based discard/unmap

 block/qcow2-cluster.c        | 217 +++++++++++++++++++++++++++++------
 block/qcow2-refcount.c       |   8 +-
 block/qcow2.c                |   8 +-
 block/qcow2.h                |   2 +
 tests/qemu-iotests/250       |   5 -
 tests/qemu-iotests/271       |  25 +++-
 tests/qemu-iotests/271.out   |   2 +
 tests/qemu-iotests/common.rc |   6 +
 8 files changed, 226 insertions(+), 47 deletions(-)

-- 
2.39.3


