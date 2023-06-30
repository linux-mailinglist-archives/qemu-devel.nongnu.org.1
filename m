Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E767743D71
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFF3q-0005eA-JE; Fri, 30 Jun 2023 10:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFF3l-0005aS-Bw
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:25:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFF3i-0004Wm-Du
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:25:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBObMG015255; Fri, 30 Jun 2023 14:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=gzPx4NnbCJt+TaRyJVCuFbDm/YJYnTidJ2UbmUlH3jc=;
 b=vKeh46rX71BrGOeYD1pdsmcscniuXjyD9aFvVzK8HWK5rMToIdDILa6V/jik/fyZbcXy
 gaV4aUOq/hb7bt8FX3wa6g+9wkDWp2pKG0IKtD1r6AzDfYvUW6tBz/UlRoNkWGgA4XxD
 xxXSZgDDnND3ChgAzUZkYBN/JEjqNxMZPB0j+Mr3V0IQqeVYjCj82ZlZlSM55Ob3Ys6g
 Zwoyk0h9JQo/uoqraonaB0a3pF7XYTR4n5/YNBNaY4Zo8u+D2fGLMi3av/1vqvlmv+uS
 w2HCSHKOVvhZO0OxxlO8EpggvOp0D+DCwrk7vXJHBF0fz4MlHKhDTjDLxab9N+RjCjQf Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcagms0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:25:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UD1vcp019997; Fri, 30 Jun 2023 14:25:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxeptx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 14:25:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UEPA9a005061;
 Fri, 30 Jun 2023 14:25:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpxeptw6-1; Fri, 30 Jun 2023 14:25:09 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/2] migration file URI
Date: Fri, 30 Jun 2023 07:25:06 -0700
Message-Id: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=867 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300123
X-Proofpoint-ORIG-GUID: eCj7p5V3Sp4PN3tFsfhbtXHABRibkKKO
X-Proofpoint-GUID: eCj7p5V3Sp4PN3tFsfhbtXHABRibkKKO
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

Add the migration URI "file:filename[,offset=offset]".

Fabiano Rosas has submitted the unit tests in the series 
  migration: Test the new "file:" migration

Steve Sistare (2):
  migration: file URI
  migration: file URI offset

 migration/file.c       | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
 migration/file.h       |  14 +++++++
 migration/meson.build  |   1 +
 migration/migration.c  |   5 +++
 migration/trace-events |   4 ++
 qemu-options.hx        |   7 +++-
 6 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 migration/file.c
 create mode 100644 migration/file.h

-- 
1.8.3.1


