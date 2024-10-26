Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A979B19C8
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Oct 2024 18:32:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4jhB-0007wq-1m; Sat, 26 Oct 2024 12:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jgh-0007s2-MY; Sat, 26 Oct 2024 12:30:51 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jge-0003bI-DB; Sat, 26 Oct 2024 12:30:51 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D09D320058.AA594
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:135:242:ac11:35])
 by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id D09D320058;
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:fc22:6c81:6588:12d3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id B13A1D4F2584F; 
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 62F5A4B91E8; Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v4 0/5] block: allow commit to unmap zero blocks
Date: Sat, 26 Oct 2024 18:30:04 +0200
Message-ID: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:132;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-1.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

This patch series adds support for zero blocks in non-active commits.
The first three patches in the series refactor the relevant code, patch
four makes the actual changes, and the last patch adds a test for the
new functionality.

---

Changes since v3:
- minor reformating based on checkpatch.pl
- moved tracepoint in commit_iteration before first possible return on
  error
- renamed the handle_error label in commit_iteration to fail and
  prevented the happy path from passing through this label
- moved test script to the tests/qemu-iotests/tests folder and named it
  commit-zero-blocks

Changes since v2:
- moved main loop of commit_run to a separate function and refactored
  the error handling.
- call blk_co_pwrite_zero even if the size of the zero region does not
  align with the sectors of the base image. This removes the need for
  the CommitMethod enum

Changes since v1:
- split up the implementation in three separate commits
- removed accidentally left over includes from testing

Vincent Vanlaer (5):
  block: get type of block allocation in commit_run
  block: move commit_run loop to separate function
  block: refactor error handling of commit_iteration
  block: allow commit to unmap zero blocks
  block: add test non-active commit with zeroed data

 block/commit.c                                | 116 +++++++++++++-----
 tests/qemu-iotests/tests/commit-zero-blocks   |  96 +++++++++++++++
 .../qemu-iotests/tests/commit-zero-blocks.out |  54 ++++++++
 3 files changed, 232 insertions(+), 34 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/commit-zero-blocks
 create mode 100644 tests/qemu-iotests/tests/commit-zero-blocks.out

-- 
2.44.1


