Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140177BD79A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmqg-00005v-Cz; Mon, 09 Oct 2023 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqQ-0008QT-UW; Mon, 09 Oct 2023 05:46:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqM-0005Yc-Eb; Mon, 09 Oct 2023 05:46:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CB9354493E;
 Mon,  9 Oct 2023 11:46:23 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v2 00/10] mirror: allow switching from background to active
 mode
Date: Mon,  9 Oct 2023 11:46:09 +0200
Message-Id: <20231009094619.469668-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

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
I couldn't figure out a way to avoid mutual inclusion between
block-core.json and job.json.


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
  iotests: adapt test output for new mirror query property

 block/mirror.c                 | 95 +++++++++++++++++++++++-----------
 block/monitor/block-hmp-cmds.c |  4 +-
 blockdev.c                     | 14 +++++
 blockjob.c                     | 26 +++++++++-
 include/block/blockjob.h       | 11 ++++
 include/block/blockjob_int.h   | 10 ++++
 job.c                          |  1 +
 qapi/block-core.json           | 59 +++++++++++++++++++--
 qapi/job.json                  |  4 +-
 tests/qemu-iotests/109.out     | 24 ++++-----
 10 files changed, 199 insertions(+), 49 deletions(-)

-- 
2.39.2



