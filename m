Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3DC80765E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:18:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvT4-00082z-N0; Wed, 06 Dec 2023 12:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvT1-0007u3-KS
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvSt-0001Zq-T0
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EY5w8023149; Wed, 6 Dec 2023 17:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=4nVwEFkIFmRXmdsb4oMT/8CxGW0Nyc4yLbtxzU+1yw4=;
 b=U8le/j4DYSfar6x20IBVZy5H09ay0GJxoSIenCpwLn8KdJaF3YZj1ArMXQytcUj6OfrU
 IC0ggIQMjHaISLkmFuGDwdSPgMWPM7z3TgyqfBaPo0emdBI/ca49RQlQ2VqLk2Pu2No/
 m7YmCLxYllCG12PEt21d3ZxyDn8wsgU0+K/esxd0qjYMszQzRr9t0IVPbegm7r71K5Hc
 RBRgGX9Y+5ekBwOJ74sQ5Gyk6dxG0CZrT4/6zuNOgIuNXQJcqdRCboUEM5B3u8Rn7Xg9
 yqYJE7t/gmdQv3ibnd2BGxx8QGil67cZhKj7YFRuZZwEf2x6JoWtTb4anj2xLHjiFDiS 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbj0r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6Gjwue032317; Wed, 6 Dec 2023 17:13:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9exv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HCrVh024168;
 Wed, 6 Dec 2023 17:13:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utan9ewxa-27; Wed, 06 Dec 2023 17:13:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 14/14] tests/qtest: postcopy migration with suspend
Date: Wed,  6 Dec 2023 09:12:52 -0800
Message-Id: <1701882772-356078-27-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
References: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-ORIG-GUID: Iwbw_fTJiRM6_neZTqE98fLq9BSDz8y7
X-Proofpoint-GUID: Iwbw_fTJiRM6_neZTqE98fLq9BSDz8y7
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

Add a test case to verify that the suspended state is handled correctly by
live migration postcopy.  The test suspends the src, migrates, then wakes
the dest.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-test.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 03da984..2033085 100644
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


