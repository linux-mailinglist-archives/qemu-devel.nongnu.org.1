Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B29A10DA0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 18:25:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkej-0004sK-UG; Tue, 14 Jan 2025 12:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeb-0004pi-0U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:38 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeV-0004as-6X
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:36 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC16bv018757;
 Tue, 14 Jan 2025 17:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=tkkkKbdzZq/3272/UFCUv/gq6l4effkTMJIoDG48jxE=; b=
 fNGqkTIAgNoIsiBRjw1A2bJGgaQaon7TzOiVmbxfjHUlyWwm0EudXLwxPsYgMdNi
 45iaWmyZiLtJVbBI03gwcS4bOn3iOKP6BlNoddfbiT8/dWYGXCLibfiV7fhevCIn
 0VSv7SLnLsZqxHZNNg9BoxlevPsFOFsGllUC2Ff3qCCAvqO4L9aivj2nWDfT4j8a
 QQx9s/Jw932gkZRVh2JP6yhCePoKEI8vA62loITv8sXFraPqFabXfdB1E1+CclU/
 JN0oz1qdy1qQHCPn4J64jDz/WX7yITUGHkFh2pd2Bbs7Ez7hSgt1hz1qnilxqfZM
 iWBra8DN/cTHOuWMmkf0EA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y6756-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EGHH86020364; Tue, 14 Jan 2025 17:24:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtY6013352;
 Tue, 14 Jan 2025 17:24:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-19; Tue, 14 Jan 2025 17:24:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 18/24] tests/qtest: optimize migrate_set_ports
Date: Tue, 14 Jan 2025 09:23:48 -0800
Message-Id: <1736875434-106563-19-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-ORIG-GUID: MA5JRqcVz_vggI3ialTTZ5jjQ_8vUXDQ
X-Proofpoint-GUID: MA5JRqcVz_vggI3ialTTZ5jjQ_8vUXDQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Do not query connection parameters if all port numbers are known.  This is
more efficient, and also solves a problem for the cpr-transfer test.
At the point where cpr-transfer calls migrate_qmp and migrate_set_ports,
the monitor is not connected and queries are not allowed.  Port=0 is
never used for cpr-transfer.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/migration-util.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 526bed7..0ce1413 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -135,25 +135,32 @@ migrate_get_connect_qdict(QTestState *who)
 
 void migrate_set_ports(QTestState *to, QList *channel_list)
 {
-    QDict *addr;
+    g_autoptr(QDict) addr = NULL;
     QListEntry *entry;
     const char *addr_port = NULL;
 
-    addr = migrate_get_connect_qdict(to);
-
     QLIST_FOREACH_ENTRY(channel_list, entry) {
         QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
         QDict *addrdict = qdict_get_qdict(channel, "addr");
 
-        if (qdict_haskey(addrdict, "port") &&
-            qdict_haskey(addr, "port") &&
-            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+        if (!qdict_haskey(addrdict, "port") ||
+            strcmp(qdict_get_str(addrdict, "port"), "0")) {
+            continue;
+        }
+
+        /*
+         * Fetch addr only if needed, so tests that are not yet connected to
+         * the monitor do not query it.  Such tests cannot use port=0.
+         */
+        if (!addr) {
+            addr = migrate_get_connect_qdict(to);
+        }
+
+        if (qdict_haskey(addr, "port")) {
             addr_port = qdict_get_str(addr, "port");
             qdict_put_str(addrdict, "port", addr_port);
         }
     }
-
-    qobject_unref(addr);
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
-- 
1.8.3.1


