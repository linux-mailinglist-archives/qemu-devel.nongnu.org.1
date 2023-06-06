Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67134723F26
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjp-0001cP-DD; Tue, 06 Jun 2023 06:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjg-0001bA-EV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006NT-RR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567WVsj006549; Tue, 6 Jun 2023 03:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=fxVQjiFW4e1cX+l1WtR6hv9kcaeorLkzZfPmlBtp91w=;
 b=hMubfbrF/Qxb+xmnpEec4R7C/Vb4ge9ajNfjHdjpUZ3HKLij48VO9ZIoX8DIdfez4hsQ
 ag3lTf+Gi04vTACIzO0nQPLW2wnMqHLIqhHAA47Sme9EnNYt4pZmf4C3sGIKujB96FUa
 Ly9iPiUf7ohpwogPEqSsZwGVXBLs0+2S40rQjrDsWpJh2LKaGDxQn+L3KJsSVqX06/sV
 Li8QCU0sYkOaV1iSrwJgFFjJ8DMJkL2RG0WTDVmTQv8lOcQD6W3qSAEUHJul9QhVn0a3
 r09gGiZJWBo9oOINUfOhcZwsPYMpXVu7jDjgYpKGU046SaDqD89gee30eFNCCk6qw6Vi /w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmd-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD3QSMt74LRrAn6tVsCscZ3HBt/u8wt+fKz65ELCSeN8jI7A/Cnld3v4/MAqPiE4aL8ylwV+4XLJBID+r3/krtD6QbL7IjE6QpqUR+k4dbHE1d5vsBekFPYo2aUp/IfUQCBgMkyRqui3doF/MMHfSvwxluy1NH0iCnBJmgH4267gpZImfHuDxWS+smf1RJZ/TnMgku3A+h2ERVsOHwFCiTjvzDWDsORerpFArt+x0/ptpSzs9Wf/g8Jy6UK0psQiURnSciSvfbArWOdbtN6GTqCb4WlsTwycJaYGyM0OBvOs4AgS10F2jze9QozROEHOiTX6ZxOChQIBUVqP+PBCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxVQjiFW4e1cX+l1WtR6hv9kcaeorLkzZfPmlBtp91w=;
 b=aFe/w5xBa7kswHYfBV6QEdFIPLq3siCCdR9NVBLhypJ7SQMHT+manZs2wtx9yPv/u+pUEuMJVRV+QQUeIhP1b0nFNWJnsjajml8IdDPBBSJTQ63bwUOQe5JbGDXAx1rZUqMkAhCx6UBzDPd15UtKqs1opcMutV25RmKbhC1S5COhjCs1Ru1+YCaS8PelQ3U31mZqrQQ59S1S2cXtswVtP06ZOdNnr66o+tGtRUVUKWmpRbySHGr27UCBza+AH68IhFAp3jsQG/asrjbyC8vq8e+c4o4T5EjXkm8gHVmVeLmawo8c9/ASOuTdYao+gJbtxXkj4KfSHhau0NHyxa0ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxVQjiFW4e1cX+l1WtR6hv9kcaeorLkzZfPmlBtp91w=;
 b=a+4KffUATfngiLLmgK2Lei6vIknP1TIcMCrVeMq12O3iT+5Y+QOSJ9b+oq7dBDcmPO8VXZbpckE8JWvMS3rwZE35IeENXjaDqZHWYmGrpRowzTomo5bTc0kBJQl6r8pffkZ/uuSDTUjybypc24axPkhhE+YCDlCS5K0Xiwo825h8pG3+F3cYvbKNEJv39FIh4/ADSOofj2uvzrn8L4CjLHazoE/vLWeu7pfcwONSUL+eNG92KIQomA9qx3EsJNRKGQYh+nXglihhHG3+Pv/HwkRO4+va23UTC2Nspz7BuBqOQPRHfoEkkABd+ea0ty0BRkY70Eiwb/HrTeSuTTVAow==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:07 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:07 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 2/9] migration: convert uri parameter into 'MigrateAddress'
 struct
Date: Tue,  6 Jun 2023 10:15:50 +0000
Message-Id: <20230606101557.202060-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230606101557.202060-1-het.gala@nutanix.com>
References: <20230606101557.202060-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: d7768ba2-4ada-4211-c20b-08db66770a9e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjyRScWKM/PKyew/XK2JvRHaYEPaFByzL4wG+wQzMKsb6qOV2BAUU5U0ELyAQdXgK+lNCrsZTZ5566MS0UpgXrGHOH86pQoxBYmym6OsjyfiPtvK5/KRbcOCsuUW/JALxQ6YwyJ5fe07AKGpA9oF0ARaTIm3uG+Q7dlOQG75sXikxB8LlTINzv5F1cPwiaOLXqcxFn0i5aFEUu7aZ3erApvCnx3QZPYA7AwOIvvwVmkNy19QhLePLm+l87MNZAuMVRl67hdImMVQO2QEoniIE9QLxXiZYWcfq/YTVxeUafFZgGNL2t+BXkejqinIOKd32hKpJFYJu0voc1AChW+LkkeN0QEZTaGLk7UwchWJUCKSy7qLgbXuQx8yw3HuHmSalQ8mEYanXX6I1UkxoxQlVzk271y00FgOgPe3H9gS+tsQIuA4LNZYctMTutq6VFP3bJT9HsoboVHLMgb2pf7cTbb93U1DS27vAoSsMNiEbnUX32YH5le/b8xLEW5hhfMTHDbhPhcV2jwGa5dWfXBcvwgil4x6UuIG1Sqhtz81r+G2QS4cdLwsk+WQ3INmHaHjGuG0rVYDi47gHTkQyhnQD5nY+SG5Qb99yP+41lbtzqzSJFPLv0jjGviH+zyBAJo3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sgcbegdkVjd9Gf9W0CZViEpPTBBpJms/XhBjGNMULTlGxu7w5rT96LUHtoPs?=
 =?us-ascii?Q?PgblNiuWCf7VmKxhtNSmuFWeuUBBSf8C8pLl6x/F2f3jUd1COsA0z8eZkrIt?=
 =?us-ascii?Q?9l4X8CXE54XUjUcT1eztlBGoTZI1N6uIt8OI4Eg+czTAIBlUcMbYVdd4aYgw?=
 =?us-ascii?Q?sDtgPzEF+oj0c26JLwwDtSuYnbCzK3Np1TqC1GjqmQqR6+TaULvM18ZXDG5P?=
 =?us-ascii?Q?OTCpSS90YF6bzWW/KPXvNJNCzKMiMsxKKfpNBRTOHw5aVz8rEaGZPZpxK7jb?=
 =?us-ascii?Q?veEPT5ncQZCtskjBA9X9gP3GvaO3Aw4YQUDPNCyDuqQX3fw7cbhbFd9Zzf7X?=
 =?us-ascii?Q?vvsC98lASPEyFZPl7PCvepV+TpomfvCnJTSFQbb4yXgJRaZ7tj5oF8iAxnqq?=
 =?us-ascii?Q?GZvsboDpkDvHlng9pJSkh35gexbETByiyrW4P1r3hQRTuJLVX4MQMKAHInpl?=
 =?us-ascii?Q?RJ1yptC3h45DrLm/mQeQ0Y0C5OBeQDP2DxjShQ475iDoDMCBTQdflH+mJ+zP?=
 =?us-ascii?Q?W3VY2j67UwESSQ/zJQUsGqIseBF5Chka0UceFi8AR8TPYZZ1JD5CXJV1SeSG?=
 =?us-ascii?Q?1UN3mTFGzvA2jbLWF452MrrSxmklRv2U7HODU85rkb8qj4LLtA9xamsf4qpO?=
 =?us-ascii?Q?aTo7AXvO2lpLDLAnoY2cSzxeaAveGtH5YD9ATLu4MxoMzASeFtWn90xQ0v3w?=
 =?us-ascii?Q?1w3idaQ7JhOF7yv8QPJ4lqmoZntb5oNbZ6KQ+6imGk4QXeP8NWZqz55JWDIY?=
 =?us-ascii?Q?NfVHOMdk+fUTaTrQtBxTSOMzlgmBNxM6JIYrASovZxaB9FBaOnV0xsYqeHbD?=
 =?us-ascii?Q?1oeT9QD5WKpU8LHhn3yA+JZT3ldkTYzravINy7lvGTgQ7UKiFIpgAqz2Y2qT?=
 =?us-ascii?Q?xjyvJvgQCesvIuilRw2AZouHR38vl79RFyQio2rAjvpDuxv5y7FNb624gpZA?=
 =?us-ascii?Q?axypDcdLzypp42+SEn4tEG5qhbfA9Jx+92G9QIRcAuMLRhNHQY9NUiZsDGQZ?=
 =?us-ascii?Q?ywZyXVn5CUG/DoaglXzse8rYmKL29wJY7h6cparccusDtMq/j/c7FG0HtLKp?=
 =?us-ascii?Q?+PNOEvhHkpqm7TnOP/ye0+NX2IEbux4JKRhINtIPVSfgaSuVGe4tRKZtVA4L?=
 =?us-ascii?Q?rnb1cWBG9EF15nfxcnMH9aqaqYFMuQKrZdQ4aw+xLd7HxTclxMsJtNViJPXi?=
 =?us-ascii?Q?YbW3SE+1gsx8qz0oct6rZm/6FIorE+zxy0pUd1eVQ5jZLWr3AGWwIDFVDfjF?=
 =?us-ascii?Q?Tqry7lKQJg4tx893DXbhUeJNCQgDVtJ7fkE9Og2zH+m9YeWgCiCtBz5dAsGH?=
 =?us-ascii?Q?pbKFN/tNeL0SkuY4v2TxhvkCextXeLaBRL0UE+xs/XBLumCHk4qWHCaQKyE+?=
 =?us-ascii?Q?uhNUg6pAfj4MNAxASTobV+jfqVssGJLGsTHl02GdWaR5rZCValOtxA/SRw8t?=
 =?us-ascii?Q?0agMQkfhifSdtK+34uPzxoFhwJEF0A/3JpC7W4uEG+q0Dt5mBegiqNwiVF2g?=
 =?us-ascii?Q?UxnXTxNaDzaaDkqnVPXXB3XeF57LQA0kKKOqXpJ2Nch1s6KgAh7bQ+rilntQ?=
 =?us-ascii?Q?XKww8yi6jg9iqnM/dL95GKobPIftZpjsq23EoKBB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7768ba2-4ada-4211-c20b-08db66770a9e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:06.9659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CIcxuQPQV4rhwPfreS1Dke7KhUz9DLxqymLALimOmh6BVYwinC6zIsxGwBVKDESmXFZMdpIeZ9XbBPxb0qRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: lJO5pyFQp3gHD1C7g-6gw5BE3qVIqGWi
X-Proofpoint-GUID: lJO5pyFQp3gHD1C7g-6gw5BE3qVIqGWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
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

This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri' parameter
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
index dc05c6f6ea..0eb25bb5a4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -420,15 +421,63 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri,
+                              MigrationAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);
+    SocketAddress *saddr = &addrs->u.socket;
+    InetSocketAddress *isock = &addrs->u.rdma;
+    strList **tail = &addrs->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addrs->transport = MIGRATION_ADDRESS_TYPE_EXEC;
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
+        addrs->transport = MIGRATION_ADDRESS_TYPE_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addrs->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
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
+    *channel = addrs;
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
@@ -1632,12 +1681,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
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
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          has_resume && resume, errp)) {
         /* Error detected, put into errp */
-- 
2.22.3


