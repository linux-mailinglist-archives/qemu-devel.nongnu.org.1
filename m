Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D407DCE5E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpEe-0001FR-19; Tue, 31 Oct 2023 09:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpE0-0000W2-Rs; Tue, 31 Oct 2023 09:56:11 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpDw-0000lQ-Uv; Tue, 31 Oct 2023 09:56:08 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BD63A42A70;
 Tue, 31 Oct 2023 14:55:50 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v4 00/10] mirror: allow switching from background to active
 mode
Date: Tue, 31 Oct 2023 14:54:21 +0100
Message-Id: <20231031135431.393137-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Changes in v4:
    * add an iotest for the new functionality
    * set actively_synced to false when setting dirty bitmap in
      bdrv_mirror_top_do_write
    * add comments describing requirements for accessing copy_mode and
      actively_synced field
    * add global state code annotation and comment about assumptions
      in mirror_change method
    * add comment that change callback can be called before the job
      coroutine is running
    * fix typo in QAPI description

Changes in v3:
    * unlock the job mutex when calling the new block job driver
      'query' handler
    * squash patch adapting iotest output into patch that changes the
      output
    * turn accesses to copy_mode and actively_synced atomic
    * slightly rework error handling in mirror_change

Changes in v2:
    * move bitmap to filter which allows to avoid draining when
      changing the copy mode
    * add patch to determine copy_to_target only once
    * drop patches returning redundant information upon query
    * update QEMU version in QAPI
    * update indentation in QAPI
    * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
      doc comments to conform to current conventions"))
    * add patch to adapt iotest output

Discussion of v3:
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg04026.html

Discussion of v2:
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02290.html

Discussion of v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html

With active mode, the guest write speed is limited by the synchronous
writes to the mirror target. For this reason, management applications
might want to start out in background mode and only switch to active
mode later, when certain conditions are met. This series adds a
block-job-change QMP command to achieve that, as well as
job-type-specific information when querying block jobs, which
can be used to decide when the switch should happen.

For now, only the direction background -> active is supported.

The information added upon querying is whether the target is actively
synced, the total data sent, and the remaining dirty bytes.

Initially, I tried to go for a more general 'job-change' command, but
to avoid mutual inclusion of block-core.json and job.json, more
preparation would be required. More details described here:
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02993.html

Fiona Ebner (10):
  blockjob: introduce block-job-change QMP command
  block/mirror: set actively_synced even after the job is ready
  block/mirror: move dirty bitmap to filter
  block/mirror: determine copy_to_target only once
  mirror: implement mirror_change method
  qapi/block-core: use JobType for BlockJobInfo's type
  qapi/block-core: turn BlockJobInfo into a union
  blockjob: query driver-specific info via a new 'query' driver method
  mirror: return mirror-specific information upon query
  iotests: add test for changing mirror's copy_mode

 block/mirror.c                                | 131 ++++++++----
 block/monitor/block-hmp-cmds.c                |   4 +-
 blockdev.c                                    |  14 ++
 blockjob.c                                    |  28 ++-
 include/block/blockjob.h                      |  11 +
 include/block/blockjob_int.h                  |  12 ++
 job.c                                         |   1 +
 qapi/block-core.json                          |  59 +++++-
 qapi/job.json                                 |   4 +-
 tests/qemu-iotests/109.out                    |  24 +--
 .../tests/mirror-change-copy-mode             | 192 ++++++++++++++++++
 .../tests/mirror-change-copy-mode.out         |   5 +
 12 files changed, 429 insertions(+), 56 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-change-copy-mode
 create mode 100644 tests/qemu-iotests/tests/mirror-change-copy-mode.out

-- 
2.39.2



