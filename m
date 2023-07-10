Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678274D56D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0B-0008Lw-Rn; Mon, 10 Jul 2023 08:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq08-0008JQ-Tu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq06-0000ls-Q2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36A6feiF020935; Mon, 10 Jul 2023 05:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=LZuRxmOF8pMmOEJONkSHfrpI/6ZokjlPiGL9NtF/x
 qQ=; b=pLMe/nBeP8pP+KjMl2ymjhB95JemyNE+up7a/5Vu0/5RsrlB5TLNlDn5i
 JDLRoMvhOQfURSOm2tnvs7KZBE75/34Xn5MMINDdhlr2hEem+24eJ16LGHAfreDV
 qzMQ8mqQMGxaEP9Ykbw1UAFYYGgVaiuFIr2Wpi7ngwCF/I7iEft+yT5O9Tr3rnAM
 01pAq3BadwsRPbm6+jBq+iqNahuwiYizc8nSVH44NXSAp55Q194WU4zBG49DfpEe
 +E+knkjxjaREz334enZB4rH6o0DCMbg5kVySCE4N06em5hXadP6RWAR9JNcLch79
 0JX3ltCd5mldqA843umXJafMOf51A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7awaxxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFXMKFrGKw1gVjZoXvHbJtLi2W3HOuwHsBDZDxXCSiiJQ3su3is8iUjWLPkcTXu8trlSwfibW8Gy0eojU/C/fiFSK6BAuPSBdGRjMdommN9Km7MpZiHqX7c7hOkRXasDUV2JQ5fSdiHOAg6bpkWAv998J8ONF7UycmTcJ0ZGZTkah6gq+f7OFqGOiCJqwmzfXIoZQZu+iEx7xrMstyInb3/iHQbX/Uk15Srxi3v2MC5gln2uAMOKyJ33Hq7NXIXK2ArHv0EhYbHD/gVrm1ScujL7rveIpgq4SPsvheCDrw6zteSP577zFwmNwxRg4cvgHncvi35voQbYTvM0N90txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZuRxmOF8pMmOEJONkSHfrpI/6ZokjlPiGL9NtF/xqQ=;
 b=ivfeN4NWJEKFr85ObE3PbbyyaNHTGlvCZZZG2wZThd5b0Z5PF89C4GnSaR8vymifKY53TZw11/1yLnugva+eu+E1Cok1YiN7jMrf4DpJsy1g7iIi/fX4M1lZ0Vv3/GvDMuj3Q7GOWKSw005tBCzclcAbpkx21o/QbbpNvAcl/oapO5P/O6EntnVb7em28gKNO89HltrjqZX4xm2OK5PqJOQdlvZ7Ghmm9HWEajB1mmJBJh1j+niq2sdXvfw1UHoQoR7y3eysAgxKgYbIpbOYYGmYU1jhSQf5SaWoBhUZ2d41kTX327ODp2B5NtqTYgMgjqzUFBThxxDHLq8FoAp1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZuRxmOF8pMmOEJONkSHfrpI/6ZokjlPiGL9NtF/xqQ=;
 b=taiP1lEb5Fmxoh3SkV9A2yHcVdUPuHQp4hD0AFStbb+XA/fzfffLt94pITZa/dFDJYh6c6iVWLGGZqSbmWp6t90LGbEKD/ZkLgOLHSCwR65QLDXlZHjTKiNHVl9z17tbvRXgUwMiAI5ePAVh4FS/3KY7yNpobczB6n1+Jfd/VJVLwH2ETnhE8WY54f7ANGM8xwpjWIsgbjgcWlrVGIHTGCc4KY0Btrj2T4MpYnnEtNgPWGsHSEzkgwigqvaRPYISRC3cJiYlYHpKqNvrLd8+0PuJlTNkYbQ0fGzGLmS/j1tiVQTvaZnP+zMRcmKCadUmLIIVQfOqPU+JflbdDb2jvw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MW6PR02MB9934.namprd02.prod.outlook.com (2603:10b6:303:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Mon, 10 Jul
 2023 12:28:11 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:11 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 2/9] migration: convert uri parameter into 'MigrateAddress'
 struct
Date: Mon, 10 Jul 2023 12:27:43 +0000
Message-Id: <20230710122750.69194-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230710122750.69194-1-het.gala@nutanix.com>
References: <20230710122750.69194-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MW6PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 86494f75-8a42-4162-6f90-08db81411fe9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMnhBUH4pRQRwCXs0dV+nqYrGd99IZoZe7xvh8isbKZy2EtTWnc3P5npNAhXeoV6ABgCgvzEmm33SVOjj7ycBxgmtdlPf2h+mhYdaXk7IkZxjrj3g18nxcQJAcVLstlSdqY8r44+eec5gRENDhN9U1qkTONf7xh+6FP39IRyePawslWQi2zJ/BUV9pN5gNdXfl7Ltc7oby7cqcICnAySZ4DqQBaUw6+BAdkOajZ1yWPDpS5qc8tpSMiA7NqYsTLxByDiHNHgI1H427M7oKg2366BLxOXSLtnpas4GHflyBldj+1CAiyyfLc0EwKQoh2+1Cihi4zjP7QkgpQgwgKUtDtwme6tFQopBGTi37XxDofjSouNSvux0uDE1t/q5bYiaoxlytX7Y78qabKspo9cxLmBXK3SCJrMZa/FO2V9CbJiz5VAlW4pAXMv2AatbFAET5BwPgpvEyqsJERETiIQZp/UKm0I451oC019R9b3vT6AUZ3ne/iMFSpznGUW2hC4v4n0Zg+rWflJHaTaW03hDC0X56kw6MlWTtbbfCE2uNrhjG6Q9TlJ53iEaOv4tK+T+2/Fp3i8bk3bvV4LE3DpwnUyhelO/e6ooN6KPzaipcUEnCW9QZTaOOMAQ0zATuf/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(38350700002)(5660300002)(66476007)(8936002)(8676002)(44832011)(83380400001)(38100700002)(66946007)(66556008)(36756003)(2906002)(478600001)(6916009)(86362001)(4326008)(41300700001)(316002)(6666004)(6512007)(6486002)(1076003)(52116002)(186003)(6506007)(107886003)(26005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2EMMR1s+9ZdYColf3qJP8kv6ZmwMY7EPId6COQaAMx1qLXsZ2Xe/P7QRpRO9?=
 =?us-ascii?Q?b5iUAMW6P+1/zo7hkyImM9BgWtUqwwhzWDX/CZNr3GZJdNEX7RCa+xVKq2B5?=
 =?us-ascii?Q?EmrlcJeDaHnS2I8YPm6pJoyY7EPuLsN6fqB025DGlaOIT3ZWdU/3AOIiJzKo?=
 =?us-ascii?Q?cFbTu1ycvY1LcM+agISGzq9+NdEEjl+zYJiBZxNjoQE7x0LRL+YwLQrfwqtq?=
 =?us-ascii?Q?EKpMXcducL0tR8+bt7CkmZPEpwIyJF9oaVWRV3HHKGbXqUH7/ztmPP7I3te3?=
 =?us-ascii?Q?qPYBXR05zaVyoc2bMNLXadINuT+B+xG0uIIfld/k81bh5Tbvy/+aEGUtu2tP?=
 =?us-ascii?Q?tjOLuYYxMWo/reu1Z/LcE65ueb5Ke4yBFdgGP27XZNV5/Q6+p3uGMcjsjL0C?=
 =?us-ascii?Q?2mopzAmcJl0kEfWmg6pbTJkzuocSMbfsWK2nFYqSVu18CWnC/oyVXwd1X3/2?=
 =?us-ascii?Q?+phJa/ZAsbz83afuQcAPxDgUr72IqQeEPQwHZvIvmxaxfLTJ18N1X5p3TqkB?=
 =?us-ascii?Q?vEHA0t4oMlag9EfLsgHNTnzjlBr18k2wZN2wuqfGIt19VXKpxuf8cBPM61nz?=
 =?us-ascii?Q?kLHbGv4E+13Kk7uf3OeDKaUqHonxe9TASSZaufXULi+cspn2Y3R3Qwft67Kk?=
 =?us-ascii?Q?Em2Xz3UntjOMHISDImZAoPnfoeC5ZXCP73Z05C/NKUuKsrqJHuuzsSxQCHle?=
 =?us-ascii?Q?QKQRgo57egEVvx07vmHI/lAWmJT9Z3VmX/3NlNdGdICLzccQ+ETlDt8jYsmc?=
 =?us-ascii?Q?WnCpQ2OmVl0gv3G3QdSz/8hbxeIKzB4niuwcMwWEGFrvLJ70y+ZMdfbnjkc0?=
 =?us-ascii?Q?jzdXegODd/Agvy3zE1ysOaqMPb5XDaa3KI/gsfB/hxBUsaEFAOLgzeBfIlRj?=
 =?us-ascii?Q?8qwlaLTJ6csB5Ruy5oRVwfn30EYackHaAuAQePANmryybKHQkAowmVk4xS/p?=
 =?us-ascii?Q?xEXXsqmpH+4fUT3q4pQWMaTq7LvE2/F7maxMvS3JQTQZPfQR+fIGEKQcgSmm?=
 =?us-ascii?Q?3Y018NW3cXpr6wVhWoylLGCwpR3tRBtB2Dp+BR4HE1S4VrsWVSIbcErkg05L?=
 =?us-ascii?Q?oYTDfNYdxnOq0bzqro/a6hW6DLW8nOwxOCrU/Cy+0UvxmU9O1bpzFWBicGby?=
 =?us-ascii?Q?mj4HGP+x5P9rfWm7wVPbHN8Eqv4gaLtG3Kq8z8BtfYdK+/tvw75cZLtyx+TZ?=
 =?us-ascii?Q?YUH8J9nO9LuraFUKJBqxgLZzb9gs8Q0NJFPcD0U82epHptdbx9fAWjUXBMlR?=
 =?us-ascii?Q?i9rvBcLWHYRmOJhpNPbW0KI/lUxW3srbhKI0/dv8+VO3WOMLM4cdeyBxJtbj?=
 =?us-ascii?Q?w5SQnHp/XIc4EP4HQ8VKx6uO+yca32gkUkHdFCAoGX+Gkdrg7C+yJzXeczCt?=
 =?us-ascii?Q?X/820TARD+h+ayAj09kgmKCNK9JUGaEzuBdmNYPu85SI4a3iRDsSTynQ3ker?=
 =?us-ascii?Q?poLkybTKEfvP/N1H9OXPgTYYkHO5ehOPuNkUJ/j4rWu72DSZZBltvUwNXDid?=
 =?us-ascii?Q?VF4t9mjToqwxk9+NzWMMi3d4WZXW0VFNbPmAe6NllXY5H9ZAiXyZRO5GTSLi?=
 =?us-ascii?Q?tA92YJqaJTFIMMMNvr5r6U1Yy0VA0sAiYPKHOqxQ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86494f75-8a42-4162-6f90-08db81411fe9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:11.2434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15AGYipcTGQMXfsUya4MIv86ksn+/biLBVLzquxYIWXw/9Cq6WXoh8x1InQmmCgLDk1zS8+sLANoRD9/FEeraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9934
X-Proofpoint-GUID: gqw589yyo6oDP7TbCHZ6-yfnf7KmIWV8
X-Proofpoint-ORIG-GUID: gqw589yyo6oDP7TbCHZ6-yfnf7KmIWV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
parameter
with all the migration connection related information and stores them
inside well defined 'MigrateAddress' struct.

Misc: limit line width in exec.c to 80 characters recommended by Qemu.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      |  4 ++--
 migration/exec.h      |  4 ++++
 migration/migration.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 2bf882bbe1..c4a3293246 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -27,7 +27,6 @@
 #include "qemu/cutils.h"
 
 #ifdef WIN32
-const char *exec_get_cmd_path(void);
 const char *exec_get_cmd_path(void)
 {
     g_autofree char *detected_path = g_new(char, MAX_PATH);
@@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+void exec_start_outgoing_migration(MigrationState *s, const char *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
diff --git a/migration/exec.h b/migration/exec.h
index b210ffde7a..736cd71028 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -19,6 +19,10 @@
 
 #ifndef QEMU_MIGRATION_EXEC_H
 #define QEMU_MIGRATION_EXEC_H
+
+#ifdef WIN32
+const char *exec_get_cmd_path(void);
+#endif
 void exec_start_incoming_migration(const char *host_port, Error **errp);
 
 void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..af2ec50061 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -421,15 +422,63 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
+    SocketAddress *saddr = &addr->u.socket;
+    InetSocketAddress *isock = &addr->u.rdma;
+    strList **tail = &addr->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
+#ifdef WIN32
+        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
+#else
+        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
+#endif
+        QAPI_LIST_APPEND(tail, g_strdup("-c"));
+        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
+    } else if (strstart(uri, "rdma:", NULL)) {
+        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
+            qapi_free_InetSocketAddress(isock);
+            return false;
+        }
+        addr->transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+        saddr = socket_parse(uri, errp);
+        if (!saddr) {
+            qapi_free_SocketAddress(saddr);
+            return false;
+        }
+    } else {
+        error_setg(errp, "unknown migration protocol: %s", uri);
+        return false;
+    }
+
+    *channel = addr;
+    return true;
+}
+
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
+        return;
+    }
+
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
@@ -1641,12 +1690,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
     }
 
+    if (!migrate_uri_parse(uri, &channel, &local_err)) {
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          resume_requested, errp)) {
-- 
2.22.3


