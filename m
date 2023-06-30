Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DD743D09
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEYP-0007b8-4n; Fri, 30 Jun 2023 09:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVc-0006E5-H9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVX-000728-Lr
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBORMM016597; Fri, 30 Jun 2023 13:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=3XNdV2NkDGXfRrutrDlV/gMtJQNDR6JghgWHeNmrZXg=;
 b=pEPCuwPf9DUOa1/rFenB4sTTPKjWMwyGciYWydcPchblbvs19G5euPGmQMEZSh5yF8Bx
 GfJ3gpkYyyuGMapYK22871QlJF+5DCy0wU8y+1Ty4EQ6d7FiaOTB4OkI7kZD7nQkyV/v
 NN51hI44a0XdWdsoZwIvjDX154sjXxbMbl0+YxZMBLjAUunniRy6L5sQeRjpiR7xPjci
 ZD0vCY8rm3j6ApL/d8qeE8DCgD3Q5gMU7LCk5PF8JwlifE6LjAJhyRBqPnhjbZpU2n+o
 vje3jxMsPUyhqmtopWbKpQDvRjsFUResgQVQ5zetm7W1EGgMIpi4+rsn5w7ff8YDx9iE Pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdrhpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UD76FN008585; Fri, 30 Jun 2023 13:49:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMf039660;
 Fri, 30 Jun 2023 13:49:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-1; Fri, 30 Jun 2023 13:49:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 00/10] fix migration of suspended runstate
Date: Fri, 30 Jun 2023 06:49:38 -0700
Message-Id: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300118
X-Proofpoint-GUID: XImGCtLrovO6bbGIWpBLgONuGWx4jciV
X-Proofpoint-ORIG-GUID: XImGCtLrovO6bbGIWpBLgONuGWx4jciV
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
for a restored snapshot, the automatic wakeup fails.  The runstate is
RUNNING, but the guest is not.  See the commit messages for the details.

Changes in V2:
  * simplify "start on wakeup request"
  * fix postcopy, snapshot, and background migration
  * refactor fixes for each type of migration
  * explicitly handled suspended events and runstate in tests
  * add test for postcopy and background migration

Steve Sistare (10):
  vl: start on wakeup request
  migration: preserve suspended runstate
  migration: add runstate function
  migration: preserve suspended for snapshot
  migration: preserve suspended for bg_migration
  tests/qtest: migration events
  tests/qtest: option to suspend during migration
  tests/qtest: precopy migration with suspend
  tests/qtest: postcopy migration with suspend
  tests/qtest: background migration with suspend

 include/sysemu/runstate.h            |   1 +
 migration/migration.c                |  28 ++++--
 migration/migration.h                |   1 +
 migration/savevm.c                   |   9 +-
 softmmu/cpus.c                       |  12 +++
 softmmu/runstate.c                   |   5 +-
 tests/migration/i386/Makefile        |   5 +-
 tests/migration/i386/a-b-bootblock.S |  51 +++++++++-
 tests/migration/i386/a-b-bootblock.h |  22 +++--
 tests/qtest/migration-helpers.c      |  27 ++----
 tests/qtest/migration-helpers.h      |   9 +-
 tests/qtest/migration-test.c         | 174 +++++++++++++++++++++++++++--------
 12 files changed, 256 insertions(+), 88 deletions(-)

-- 
1.8.3.1


