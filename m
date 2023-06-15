Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C07320E9
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9tYQ-00027a-BG; Thu, 15 Jun 2023 16:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYO-000279-60
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYM-0002FU-LO
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:47 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35FGJkpn028481; Thu, 15 Jun 2023 20:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=+Z9yrGG1vzAC8u6kCO4qi5GqX85nrZ5FcFYxcpseHRE=;
 b=ua/Xh2XEqXf3fHRV5xET0vdh9ir3jSHRX/M+08GGldeWjxBXVwWzj6SauGXpnRVjh6Rs
 HJeRKaLgQhxbW4iMg9NvbRFoSR2rFiwQrDZp/siSdN6SbTZ64TKuj/gm5sxMchp485Qw
 EJ5N2qQvpYTdwvzY8YaORO8znpoSQzoHmm5/0DnyV2l3LxCkQkPkXPSnBFOhihZBUdOS
 WoRrrUi3zNGuc9iwmUrCFjgnRLyt1YHn2xRhOftnVKexCBFY8zysky2QyyPMFC6mLkOf
 dOXll/+BhmpqnXXpSh3Uah63lhA7dUTG8yemwiR+IfAGjgLXUCQyDFsKIoFB81Dy2mtG dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bu21h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35FKDTeX038916; Thu, 15 Jun 2023 20:26:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm75mmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FKQeq4003391;
 Thu, 15 Jun 2023 20:26:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r4fm75mmg-1; Thu, 15 Jun 2023 20:26:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/3] fix migration of suspended runstate
Date: Thu, 15 Jun 2023 13:26:37 -0700
Message-Id: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_16,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150176
X-Proofpoint-ORIG-GUID: ZGCEfSWj6RHyfHsEAMJI4tiH_G1sxYxb
X-Proofpoint-GUID: ZGCEfSWj6RHyfHsEAMJI4tiH_G1sxYxb
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

Migration of a guest in the suspended runstate is broken.
The incoming migration code automatically tries to wake the guest,
which IMO is wrong -- the guest should end migration in the same
runstate it started.  Further, the automatic wakeup fails.  The guest
appears to be running, but is not.  See the commit messages for
the details.

Steve Sistare (3):
  vl: start on wakeup request
  migration: fix suspended runstate
  tests/qtest: live migration suspended state

 include/sysemu/runstate.h            |  1 +
 migration/migration.c                | 11 +++-----
 softmmu/runstate.c                   | 16 +++++++++++-
 tests/migration/i386/Makefile        |  5 ++--
 tests/migration/i386/a-b-bootblock.S | 49 +++++++++++++++++++++++++++++++++---
 tests/migration/i386/a-b-bootblock.h | 22 ++++++++++------
 tests/qtest/migration-helpers.c      |  2 +-
 tests/qtest/migration-test.c         | 31 +++++++++++++++++++++--
 8 files changed, 112 insertions(+), 25 deletions(-)

-- 
1.8.3.1


