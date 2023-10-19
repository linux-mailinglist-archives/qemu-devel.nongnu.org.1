Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638367D0352
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZw8-0007Ms-FN; Thu, 19 Oct 2023 16:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZw1-0007GX-5q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:48:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvw-0003UO-VB
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:59 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKigCG019245; Thu, 19 Oct 2023 20:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=Qz6ejEXqSijzF/+p48FQJqT95+eOBkqedt9aGGSYXqY=;
 b=Wqb4HFtOrYyV5jGTpilXnsQN2V1aA0JBa1vbHO/ZrEjjHfCIYvJPgZKLTcJNEenZDHA3
 yb5vo3rLdOaoefd0VoAz6JkAhx8fI2Gw80H6CqsdYxPp7c/QxHsmZL7RPJjbXrKPnYdt
 2N8/M7mfifzVm6WooH6vyx4t5lcJ7PNrHKdQ2lgl1yBpKG6CXPhMoe24j3DMnjcXSIjO
 HUl3IqCr1fyayeT2/o0lOkI8Z61xxJv2ZEiXM/GOHMbU7Yf5+VwDbia2j/7Z8oWX7i+3
 wDcB/IezYMJQrp/sXTcxUiV7/8sgeejmUiEvhkH78Yb6x6FBwJ2HaI8UflKFU7uVR+MG sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bukce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JJd7Ss040665; Thu, 19 Oct 2023 20:47:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyqqamb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKllWO014514;
 Thu, 19 Oct 2023 20:47:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyqqafy-5; Thu, 19 Oct 2023 20:47:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 4/4] cpr: reboot mode
Date: Thu, 19 Oct 2023 13:47:46 -0700
Message-Id: <1697748466-373230-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190176
X-Proofpoint-GUID: zYXW5Y3qR-_C0SYPhc9NRoeLlHooa121
X-Proofpoint-ORIG-GUID: zYXW5Y3qR-_C0SYPhc9NRoeLlHooa121
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Add the cpr-reboot migration mode.  Usage:

$ qemu-system-$arch -monitor stdio ...
QEMU 8.1.50 monitor - type 'help' for more information
(qemu) migrate_set_capability x-ignore-shared on
(qemu) migrate_set_parameter mode cpr-reboot
(qemu) migrate -d file:vm.state
(qemu) info status
VM status: paused (postmigrate)
(qemu) quit

$ qemu-system-$arch -monitor stdio -incoming defer ...
QEMU 8.1.50 monitor - type 'help' for more information
(qemu) migrate_set_capability x-ignore-shared on
(qemu) migrate_set_parameter mode cpr-reboot
(qemu) migrate_incoming file:vm.state
(qemu) info status
VM status: running

In this mode, the migrate command saves state to a file, allowing one
to quit qemu, reboot to an updated kernel, and restart an updated version
of qemu.  The caller must specify a migration URI that writes to and reads
from a file.  Unlike normal mode, the use of certain local storage options
does not block the migration, but the caller must not modify guest block
devices between the quit and restart.  The guest RAM memory-backend must
be shared, and the @x-ignore-shared migration capability must be set,
to avoid saving RAM to the file.  Guest RAM must be non-volatile across
reboot, such as by backing it with a dax device, but this is not enforced.
The restarted qemu arguments must match those used to initially start qemu,
plus the -incoming option.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/migration.json | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 184fb78..2d862fa 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -620,9 +620,23 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
+# @cpr-reboot: The migrate command saves state to a file, allowing one to
+#              quit qemu, reboot to an updated kernel, and restart an updated
+#              version of qemu.  The caller must specify a migration URI
+#              that writes to and reads from a file.  Unlike normal mode,
+#              the use of certain local storage options does not block the
+#              migration, but the caller must not modify guest block devices
+#              between the quit and restart.  The guest RAM memory-backend
+#              must be shared, and the @x-ignore-shared migration capability
+#              must be set, to avoid saving it to the file.  Guest RAM must
+#              be non-volatile across reboot, such as by backing it with
+#              a dax device, but this is not enforced.  The restarted qemu
+#              arguments must match those used to initially start qemu, plus
+#              the -incoming option. (since 8.2)
+#
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal' ] }
+  'data': [ 'normal', 'cpr-reboot' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
-- 
1.8.3.1


