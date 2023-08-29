Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3E78D01C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n0-0000o9-Rr; Tue, 29 Aug 2023 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IC-0002bi-J1
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I7-0003ZP-59
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THimmE007078; Tue, 29 Aug 2023 18:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=fRwushpw6567sXwJ1uISKOi4xWb1Zs0MflTc5kt0f9E=;
 b=pypeRrTdUN/fu5F4796/j4Ug+AuiXjX4oCFPgQg2ZqzDcS26R7y8CTMMd1/MeRBAPD4W
 ItnTHHUSC76xyQVgnBLV+EGz8IAW3pKKiOcH593zg3bWePYHbGYKualJMulSh7OATBK9
 iTcy2snuB9jczj0EcjJFaErqS49npsxMQH1reNFu1fXMbeHdpv+e8JAchs/APwc3TaoD
 54GG1OHcmyD/tHXEtoAz/h6r7Q7wvn2x6GvqXAD8JtUl6OmIN69vhKYSe9jQqmjS2yJh
 iJkU8avO7jnx7ej5vFj2CbfHVqB3zFT8VRctIn3efrL2Ho8ooAYgCAvNAbN5NyJMfkYC Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcnprx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:13 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THApTY024805; Tue, 29 Aug 2023 18:18:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6mA011911;
 Tue, 29 Aug 2023 18:18:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-11; Tue, 29 Aug 2023 18:18:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 10/11] tests/qtest: postcopy migration with suspend
Date: Tue, 29 Aug 2023 11:18:05 -0700
Message-Id: <1693333086-392798-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-ORIG-GUID: KcbZGdBa8hl6wYO5xAmRVhVbSiC9DyWa
X-Proofpoint-GUID: KcbZGdBa8hl6wYO5xAmRVhVbSiC9DyWa
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

Add a test case to verify that the suspended state is handled correctly by
live migration postcopy.  The test suspends the src, migrates, then wakes
the dest.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-test.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cc508ef..6306fb0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -599,8 +599,12 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    wait_for_stop(from, &src_state);
-    qtest_qmp_eventwait(to, "RESUME");
+    if (src_state.suspend_me) {
+        wait_for_suspend(from, &src_state);
+    } else {
+        wait_for_stop(from, &src_state);
+        qtest_qmp_eventwait(to, "RESUME");
+    }
 }
 
 typedef struct {
@@ -1299,6 +1303,11 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 {
     wait_for_migration_complete(from);
 
+    if (args->start.suspend_me) {
+        /* wakeup succeeds only if guest is suspended */
+        qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
+    }
+
     /* Make sure we get at least one "B" on destination */
     wait_for_serial("dest_serial");
 
@@ -1332,6 +1341,15 @@ static void test_postcopy(void)
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
@@ -2884,6 +2902,10 @@ int main(int argc, char **argv)
             qtest_add_func("/migration/postcopy/recovery/compress/plain",
                            test_postcopy_recovery_compress);
         }
+        if (is_x86) {
+            qtest_add_func("/migration/postcopy/suspend",
+                           test_postcopy_suspend);
+        }
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
1.8.3.1


