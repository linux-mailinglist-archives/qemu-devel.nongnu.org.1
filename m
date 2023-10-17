Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F057CCAF9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsp4A-0005uQ-Vo; Tue, 17 Oct 2023 14:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp40-0005nG-Kk; Tue, 17 Oct 2023 14:45:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp3u-0004rw-Mg; Tue, 17 Oct 2023 14:45:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 0EAF562367;
 Tue, 17 Oct 2023 21:44:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jipbAUIOliE0-jlyGTHcp; Tue, 17 Oct 2023 21:44:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697568295;
 bh=T1WAS38/Ih++ujo6Vp5NxaxS79Yh1GbpdUcZ2V0wRxY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=MKhJ8WXG30V/pTZhwDTckVYANwDb+629QsAcrq4dJJyEoCLOQR6HdY3RmiP0ZcXYf
 BTArrcS9zG06fxkFEu09d5/CfPBqNg9KViBW9LKlkbLI5Uv3q5gNM4SPZ21pLImZFX
 521f0+bSaJwhMZjTLuC38Ycg0vECnRRg5fBwCJH4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v8 0/7] blockdev-replace
Date: Tue, 17 Oct 2023 21:44:37 +0300
Message-Id: <20231017184444.932733-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi all!

This series presents a new command blockdev-replace, which helps to
insert/remove filters anywhere in the block graph. It can:

 - replace qdev block-node by qdev-id
 - replace export block-node by export-id
 - replace any child of parent block-node by node-name and child name

So insertions is done in two steps:

1. blockdev_add (create filter node, unparented)

    [some parent]  [new filter]
     |               |
     V               V
    [        some child       ]

2. blockdev-replace (replace child by the filter)

    [some parent]
     | 
     V
    [new filter]
     |
     V
    [some child]

And removal is done in reverse order:

1. blockdev-replace (go back to picture 1)
2. blockdev_del (remove filter node)


Ideally, we to do both operations (add + replace or replace + del) in a
transaction, but that would be another series.

v8: - rebase on master
    - add documentation
    - also don't use "preallocate" filter in a test, as we don't support
    removal of this filter for now. Preallocate filter is rather
    unusual, see discussion here:
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg994945.html

Vladimir Sementsov-Ogievskiy (7):
  block-backend: blk_root(): drop const specifier on return type
  block/export: add blk_by_export_id()
  block: make bdrv_find_child() function public
  qapi: add x-blockdev-replace command
  block: bdrv_get_xdbg_block_graph(): report export ids
  iotests.py: introduce VM.assert_edges_list() method
  iotests: add filter-insertion

 block.c                                       |  17 ++
 block/block-backend.c                         |   2 +-
 block/export/export.c                         |  31 +++
 blockdev.c                                    |  70 ++++--
 include/block/block_int-io.h                  |   2 +
 include/block/export.h                        |   1 +
 include/sysemu/block-backend-global-state.h   |   3 +-
 qapi/block-core.json                          |  83 ++++++
 stubs/blk-by-qdev-id.c                        |   9 +
 stubs/blk-exp-find-by-blk.c                   |   9 +
 stubs/meson.build                             |   2 +
 tests/qemu-iotests/iotests.py                 |  17 ++
 tests/qemu-iotests/tests/filter-insertion     | 236 ++++++++++++++++++
 tests/qemu-iotests/tests/filter-insertion.out |   5 +
 14 files changed, 471 insertions(+), 16 deletions(-)
 create mode 100644 stubs/blk-by-qdev-id.c
 create mode 100644 stubs/blk-exp-find-by-blk.c
 create mode 100755 tests/qemu-iotests/tests/filter-insertion
 create mode 100644 tests/qemu-iotests/tests/filter-insertion.out

-- 
2.34.1


