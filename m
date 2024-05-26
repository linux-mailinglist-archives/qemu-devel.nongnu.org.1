Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB798CF5F9
	for <lists+qemu-devel@lfdr.de>; Sun, 26 May 2024 22:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBKU9-00054H-Sk; Sun, 26 May 2024 16:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sBJZQ-0007FT-Ca; Sun, 26 May 2024 15:30:16 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be ([134.58.240.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sBJZO-0004vl-2a; Sun, 26 May 2024 15:30:15 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6386C201AE.A9C95
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:139:242:ac11:3b])
 by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 6386C201AE;
 Sun, 26 May 2024 21:29:55 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:dd0a:a068:3e21:22de])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 41D84D4F567B0; 
 Sun, 26 May 2024 21:29:55 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id E3F72282440; Sun, 26 May 2024 21:29:54 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH 0/2] block: allow commit to unmap zero blocks 
Date: Sun, 26 May 2024 21:29:15 +0200
Message-ID: <20240526192918.3503128-1-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.58.240.131;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-2.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 May 2024 16:28:49 -0400
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
The first patch in the series contains the actual changes to the commit
code, the second patch adds a test for the new functionality.

Vincent Vanlaer (2):
  block: allow commit to unmap zero blocks
  block: add test non-active commit with zeroed data

 block/commit.c             | 71 ++++++++++++++++++++++------
 tests/qemu-iotests/315     | 95 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/315.out | 54 ++++++++++++++++++++++
 3 files changed, 207 insertions(+), 13 deletions(-)
 create mode 100755 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out

-- 
2.42.0


