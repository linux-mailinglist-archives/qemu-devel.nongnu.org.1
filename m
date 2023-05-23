Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F02EF70E1AD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Up0-0005Kl-9f; Tue, 23 May 2023 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q1Uou-0005JX-4x; Tue, 23 May 2023 12:25:09 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q1Uos-00076n-LY; Tue, 23 May 2023 12:25:07 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q1UnN-00DnIw-1M;
 Tue, 23 May 2023 18:24:48 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, shmuel.eiderman@oracle.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 0/2] qemu-img: fix getting stuck in infinite loop on
Date: Tue, 23 May 2023 19:24:56 +0300
Message-Id: <20230523162458.704266-1-andrey.drobyshev@virtuozzo.com>
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

Consider the following in-chain rebase case:

qemu-img create -f qcow2 base.qcow2 $(( 64 * 4 ))k
qemu-img create -f qcow2 -o backing_file=base.qcow2,backing_fmt=qcow2 inc1.qcow2 $(( 64 * 4 ))k
qemu-img create -f qcow2 -o backing_file=inc1.qcow2,backing_fmt=qcow2 inc2.qcow2 $(( 64 * 5 ))k
qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2

And then rebase operation gets stuck forever.

The 1st patch is a fix, the 2nd -- an additional test case to catch this
situation.

Andrey Drobyshev (2):
  qemu-img: rebase: stop when reaching EOF of old backing file
  qemu-iotests: 024: add rebasing test case for overlay_size >
    backing_size

 qemu-img.c                 |  7 ++++++
 tests/qemu-iotests/024     | 48 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 23 ++++++++++++++++++
 3 files changed, 78 insertions(+)

-- 
2.31.1


