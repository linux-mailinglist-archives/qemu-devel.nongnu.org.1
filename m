Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1E07D897D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6f9-0004M3-K9; Thu, 26 Oct 2023 16:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6eq-000484-7a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6el-0008Tl-Ds
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsQVn025634; Thu, 26 Oct 2023 20:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=VUwHrzv+fk6mKENUtY6aYA7eVgZcpa1bLZZsvUQ3kwg=;
 b=ozxFfMcDd8/SHZV15kxRsoeKi6o7AlhVg36AmHoPzcc9ecjX5VJePB9XOq2F2LJrv7nJ
 uJnS37UUjD1KWI7FmIpqQbS9LGk409ssttMxVLYob6aalRQknet9yDElI6/YbDF8UCGV
 db2mK89HF4zKR+CldfPRAHQSIiGFKftxQRf7ft7GlmyRQYDRzEjrlkPwTqN7eM7zxQT6
 0TfJfs8LtBEOL3+F3XDY807jYjers8MMF5xwy30f28IcO1jynay0oZrZronjcSD5eVOH
 fT7LyEwE4cHwCMTPZanyimwKQHBCs2DG6Yco3mDq7boOAAgh/yXk6o4OrU1DQbYADCHT Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3ng3as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:38 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImfQ9009043; Thu, 26 Oct 2023 20:08:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhtyp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:37 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QK8YLv036361;
 Thu, 26 Oct 2023 20:08:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tywqhtykn-6; Thu, 26 Oct 2023 20:08:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 5/6] cpr: reboot mode
Date: Thu, 26 Oct 2023 13:08:32 -0700
Message-Id: <1698350913-415926-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
References: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-ORIG-GUID: XyiwfJXk1uBMIeSGoKY0lRDG9YihJO4W
X-Proofpoint-GUID: XyiwfJXk1uBMIeSGoKY0lRDG9YihJO4W
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
devices between the quit and restart.  To avoid saving guest RAM to the
file, the memory backend must be shared, and the @x-ignore-shared migration
capability must be set.  Guest RAM must be non-volatile across reboot, such
as by backing it with a dax device, but this is not enforced.  The restarted
qemu arguments must match those used to initially start qemu, plus the
-incoming option.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/qdev-properties-system.c |  2 +-
 qapi/migration.json              | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 07a848d..d961404 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -680,7 +680,7 @@ QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
 const PropertyInfo qdev_prop_mig_mode = {
     .name = "MigMode",
     .description = "mig_mode values, "
-                   "normal",
+                   "normal,cpr-reboot",
     .enum_table = &MigMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/qapi/migration.json b/qapi/migration.json
index f99904e..795182f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -620,9 +620,22 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
+# @cpr-reboot: The migrate command saves state to a file, allowing one to
+#              quit qemu, reboot to an updated kernel, and restart an updated
+#              version of qemu.  The caller must specify a migration URI
+#              that writes to and reads from a file.  Unlike normal mode,
+#              the use of certain local storage options does not block the
+#              migration, but the caller must not modify guest block devices
+#              between the quit and restart.  To avoid saving guest RAM to the
+#              file, the memory backend must be shared, and the @x-ignore-shared
+#              migration capability must be set.  Guest RAM must be non-volatile
+#              across reboot, such as by backing it with a dax device, but this
+#              is not enforced.  The restarted qemu arguments must match those
+#              used to initially start qemu, plus the -incoming option.
+#              (since 8.2)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal' ] }
+  'data': [ 'normal', 'cpr-reboot' ] }
 
 ##
 # @BitmapMigrationBitmapAliasTransform:
-- 
1.8.3.1


