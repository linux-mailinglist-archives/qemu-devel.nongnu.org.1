Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CA3798897
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecNS-0002jh-KQ; Fri, 08 Sep 2023 10:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecNP-0002QJ-74
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecNL-0001nV-Lp
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:22:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388DxHrS024936; Fri, 8 Sep 2023 14:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=CXjSEgkBiljbzMMD5Ouan0VW1Ny+h+hbMIWI37k8tHQ=;
 b=GGK5FdbXLbv0z/AgAV527eBMoauXvwzLz1K3txQfpGpa+67iQ/akiBESbVf7WLOjq1uU
 PvwDbt8gXKILKJbvhY6LYERfx6aR+5dXg0arczx4VrTjmiof81c6Lel9IuU5MS9+6T1h
 wjz23B8yZtp2+H9/DQe1L4uyLtq9x0IgS7it5y7LTR1FzB+IONBzcAhbt+fK7X/nnQnR
 zhSXE23GpmAYyfywgaWvBEbysoLuOTM/9RuXYsbmrK3To0U3cJ7D6wAcGqfSOWELdFp9
 OyywuWP6pREzvctW9+l303MjAmvAQV1f5JNliuHgTFj1xjv7SW8/Mq4gvlXe7IJw9tFX JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t04sjr3rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:22:20 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 388EElVe017326; Fri, 8 Sep 2023 14:22:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug9q067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:22:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388EMBnq013364;
 Fri, 8 Sep 2023 14:22:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3suug9q05r-1; Fri, 08 Sep 2023 14:22:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Claudio Fontana <cfontana@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 0/2] migration file URI
Date: Fri,  8 Sep 2023 07:22:09 -0700
Message-Id: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=835
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080133
X-Proofpoint-GUID: wRdfffOqOQXpYfwOF83i28rXJc56EVqf
X-Proofpoint-ORIG-GUID: wRdfffOqOQXpYfwOF83i28rXJc56EVqf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Changes in V5:
  * fixed GPL version

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


