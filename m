Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A263823615
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7VG-0004jk-5B; Wed, 03 Jan 2024 15:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7V6-0004gd-6u
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7V4-0002CR-JJ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:03 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JYW2p028565; Wed, 3 Jan 2024 20:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=ZQ2ycey7tFSeCUAvislcm5k2GE6FWRBnHRx9NBcQNWs=;
 b=WrAWpvQER1TAXWwqLSM3TDSMegbUbXLhWfIFhPBZrUZ9bFb34Yu+QTiZ5ArWvOIp9jWf
 fTHVJUmH91OTDGL13GawoXdgcR8x42QHLA5siojMWgUOqkjCZFt2d6lGJ0ghgZp/AXm3
 946c+krST/FhHsabALFSfrtFf+cYjHZepL2vp3MmELEoPE0qG3vRD0aW+x98Ix7KFJkN
 HEKQeASmDirjC6HxoNi9zM1R30Vt5cbDUW1x9t1AqY+8lpvM3j9oEXRMcSwtWP1WbQ//
 6F2Vc7Vg1gghoLjGVpbu44tM+KY86oRMch9HDUOtIa4W5jkZpZhXABxjH0ZuG927F+fg 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu5qte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:56 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K22Vc013668; Wed, 3 Jan 2024 20:05:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2Ua1020511;
 Wed, 3 Jan 2024 20:05:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-13; Wed, 03 Jan 2024 20:05:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 12/12] tests/qtest: postcopy migration with suspend
Date: Wed,  3 Jan 2024 12:05:41 -0800
Message-Id: <1704312341-66640-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-GUID: XtLY27RWd7btVOXpSmQt0bk-DnvUn08i
X-Proofpoint-ORIG-GUID: XtLY27RWd7btVOXpSmQt0bk-DnvUn08i
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a test case to verify that the suspended state is handled correctly by
live migration postcopy.  The test suspends the src, migrates, then wakes
the dest.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a3bfbf2..136e5df 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1347,6 +1347,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
+    wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
     migrate_qmp(from, uri, "{}");
@@ -1364,6 +1365,11 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 {
     wait_for_migration_complete(from);
 
+    if (args->start.suspend_me) {
+        /* wakeup succeeds only if guest is suspended */
+        qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+    }
+
     /* Make sure we get at least one "B" on destination */
     wait_for_serial("dest_serial");
 
@@ -1397,6 +1403,15 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_suspend(void)
+{
+    MigrateCommon args = {
+        .start.suspend_me = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_compress(void)
 {
     MigrateCommon args = {
@@ -3412,7 +3427,10 @@ int main(int argc, char **argv)
         qtest_add_func("/migration/postcopy/recovery/double-failures",
                        test_postcopy_recovery_double_fail);
 #endif /* _WIN32 */
-
+        if (is_x86) {
+            qtest_add_func("/migration/postcopy/suspend",
+                           test_postcopy_suspend);
+        }
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
1.8.3.1


