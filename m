Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8DC7FFDB2
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:39:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8oj6-0001hh-5v; Thu, 30 Nov 2023 16:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj2-0001dw-Vh
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj0-0000lb-Q8
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:36 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULbVrM004901; Thu, 30 Nov 2023 21:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=8m8CbhEmA9/k6KeG9BPdJpDDo7cp3qGgYLw3gKx6hLo=;
 b=OIv4TzNvaNN245/Whf8E9riVqTCj66eKUQjH+uxDCjgpO3U7gTlMfIiqHxHZO/cKlIsN
 g/z7sEjfyw3rmOTLuG9O2xJfQAiD4tDGAXVLifF36QfIkDaJ/oZV0jI8TBK9WVyl5eCO
 17ggXhRIgWj0fc4Akh8AWZx83pMi96nFX1UCQ1nkCFeUAOiCK0EVW1O5aZ0CrPquuZnt
 SEpEKImeHMl9ZNlsD7XtXfmtMGQFEKa6cogrZwvkDzfa5lk5PodyX178vO++e4dnJHH/
 NHjXVfWj6NumfrIassmPpiOeSa4qKZd0Vf0VsFdlxcAyFZKiRDeRgtgN4Qjd6GSDDSMf vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq2ffr006-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:31 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AUKNss5012726; Thu, 30 Nov 2023 21:37:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTfv016589;
 Thu, 30 Nov 2023 21:37:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-1; Thu, 30 Nov 2023 21:37:29 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 00/14] fix migration of suspended runstate
Date: Thu, 30 Nov 2023 13:37:13 -0800
Message-Id: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_21,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300158
X-Proofpoint-GUID: ZIw35XJPr3160mhs7tswxfIwSQbNkFTi
X-Proofpoint-ORIG-GUID: ZIw35XJPr3160mhs7tswxfIwSQbNkFTi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Migration of a guest in the suspended runstate is broken.  The incoming
migration code automatically tries to wake the guest, which is wrong;
the guest should end migration in the same runstate it started.  Further,
after saving a snapshot in the suspended state and loading it, the vm_start
fails.  The runstate is RUNNING, but the guest is not.

See the commit messages for the details.

Changes in V2:
  * simplify "start on wakeup request"
  * fix postcopy, snapshot, and background migration
  * refactor fixes for each type of migration
  * explicitly handled suspended events and runstate in tests
  * add test for postcopy and background migration

Changes in V3:
  * rebase to tip
  * fix hang in new function migrate_wait_for_dirty_mem

Changes in V4:
  * rebase to tip
  * add patch for vm_prepare_start (thanks Peter)
  * add patch to preserve cpu ticks

Changes in V5:
  * rebase to tip
  * added patches to completely stop vm in suspended state:
      cpus: refactor vm_stop
      cpus: stop vm in suspended state
  * added patch to partially resume vm in suspended state:
      cpus: start vm in suspended state
  * modified "preserve suspended ..." patches to use the above.
  * deleted patch "preserve cpu ticks if suspended".  stop ticks in
    vm_stop_force_state instead.
  * deleted patch "add runstate function".  defined new helper function
    migrate_new_runstate in "preserve suspended runstate"
  * Added some RB's, but removed other RB's because the patches changed.

Changes in V6:
  * all vm_stop calls completely stop the suspended state
  * refactored and updated the "cpus" patches
  * simplified the "preserve suspended" patches
  * added patch "bootfile per vm"

Steve Sistare (14):
  cpus: pass runstate to vm_prepare_start
  cpus: vm_was_suspended
  cpus: stop vm in suspended runstate
  cpus: vm_resume
  migration: propagate suspended runstate
  migration: preserve suspended runstate
  migration: preserve suspended for snapshot
  migration: preserve suspended for bg_migration
  tests/qtest: migration events
  tests/qtest: option to suspend during migration
  tests/qtest: precopy migration with suspend
  tests/qtest: postcopy migration with suspend
  tests/qtest: bootfile per vm
  tests/qtest: background migration with suspend

 backends/tpm/tpm_emulator.c          |   2 +-
 gdbstub/system.c                     |   2 +-
 hw/usb/hcd-ehci.c                    |   2 +-
 hw/usb/redirect.c                    |   2 +-
 hw/xen/xen-hvm-common.c              |   2 +-
 include/migration/snapshot.h         |   7 +
 include/sysemu/runstate.h            |  19 ++-
 migration/global_state.c             |  10 ++
 migration/migration-hmp-cmds.c       |   8 +-
 migration/migration.c                |  15 +--
 migration/savevm.c                   |  23 ++--
 qapi/misc.json                       |  10 +-
 system/cpus.c                        |  49 +++++--
 system/runstate.c                    |   9 ++
 system/vl.c                          |   2 +
 tests/migration/i386/Makefile        |   5 +-
 tests/migration/i386/a-b-bootblock.S |  50 +++++++-
 tests/migration/i386/a-b-bootblock.h |  26 ++--
 tests/qtest/migration-helpers.c      |  27 ++--
 tests/qtest/migration-helpers.h      |  11 +-
 tests/qtest/migration-test.c         | 240 +++++++++++++++++++++++++----------
 21 files changed, 382 insertions(+), 139 deletions(-)

-- 
1.8.3.1


