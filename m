Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE0807686
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:25:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvcs-00016B-5D; Wed, 06 Dec 2023 12:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvcq-00015p-IX
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:23:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvco-0003Yx-HV
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:23:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYX4t014719; Wed, 6 Dec 2023 17:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=XAb3++jepiTKbU7Zn3scZShQCKVMeeNz9WQE9ET0K18=;
 b=LyMR46CePh9hWJx8INBr3803K//jhw50uyRJ7R31avZVn2Ax+kCCTN/ERvqkLRk1rVm8
 AexggQZzpsdfUr/SUSlVPdEJz1gJVY/AlTarOvjwEN2+pWmzocSc2OVhDh4RIdJiSkGK
 JZgHu4caLSyIbqBvHutFClCn5m261SlpU+ahbxZ9/2FXDxGfuscdW4TTl25DgYO3M5po
 8gFp12AXN4GLjxyfnVP9Je6KRGARWrYOBjPI2zns6OYMkH6hohUdOMm7+CEEpSzgENOY
 +9XlBG0d/3HB05wh854x1oFFxw6BLBJSTR7cvdDe+Rysb5yHRB90BhKRJnS34zbMD82G IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc19xpt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:23:52 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6GtlHf037858; Wed, 6 Dec 2023 17:23:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utanc79vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:23:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HMwkI002907;
 Wed, 6 Dec 2023 17:23:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utanc79rv-1; Wed, 06 Dec 2023 17:23:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 00/12] fix migration of suspended runstate
Date: Wed,  6 Dec 2023 09:23:25 -0800
Message-Id: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-GUID: j3p8Pk1Um8JIVxPGNwCnXc_ZSzck5Qgr
X-Proofpoint-ORIG-GUID: j3p8Pk1Um8JIVxPGNwCnXc_ZSzck5Qgr
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

Changes in V7:
  * rebase to tip, add RB-s
  * fix backwards compatibility for global_state.vm_was_suspended
  * delete vm_prepare_start state argument, and rename patch
    "pass runstate to vm_prepare_start" to
    "check running not RUN_STATE_RUNNING"
  * drop patches:
      tests/qtest: bootfile per vm
      tests/qtest: background migration with suspend
  * rename runstate_is_started to runstate_is_live
  * move wait_for_suspend in tests

Steve Sistare (12):
  cpus: vm_was_suspended
  cpus: stop vm in suspended runstate
  cpus: check running not RUN_STATE_RUNNING
  cpus: vm_resume
  migration: propagate suspended runstate
  migration: preserve suspended runstate
  migration: preserve suspended for snapshot
  migration: preserve suspended for bg_migration
  tests/qtest: migration events
  tests/qtest: option to suspend during migration
  tests/qtest: precopy migration with suspend
  tests/qtest: postcopy migration with suspend

 backends/tpm/tpm_emulator.c          |   2 +-
 hw/usb/hcd-ehci.c                    |   2 +-
 hw/usb/redirect.c                    |   2 +-
 hw/xen/xen-hvm-common.c              |   2 +-
 include/migration/snapshot.h         |   7 ++
 include/sysemu/runstate.h            |  16 ++++
 migration/global_state.c             |  35 ++++++-
 migration/migration-hmp-cmds.c       |   8 +-
 migration/migration.c                |  15 +--
 migration/savevm.c                   |  23 +++--
 qapi/misc.json                       |  10 +-
 system/cpus.c                        |  47 +++++++--
 system/runstate.c                    |   9 ++
 system/vl.c                          |   2 +
 tests/migration/i386/Makefile        |   5 +-
 tests/migration/i386/a-b-bootblock.S |  50 +++++++++-
 tests/migration/i386/a-b-bootblock.h |  26 +++--
 tests/qtest/migration-helpers.c      |  27 ++----
 tests/qtest/migration-helpers.h      |  11 ++-
 tests/qtest/migration-test.c         | 181 +++++++++++++++++++++++++----------
 20 files changed, 354 insertions(+), 126 deletions(-)

-- 
1.8.3.1


