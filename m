Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C96B7093FB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwhB-0000Bi-Gs; Fri, 19 May 2023 05:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgy-00009W-IW
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgv-0008RX-8r
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J5Jq33003348; Fri, 19 May 2023 02:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=8kLFhBy8xrHkyhdB/+w2R7EJX1c38C6ixHyMREzOmLY=;
 b=D5bT/3/Y9vUwsqYfokkrXziozt1l7ZzCc4dZPBwwOGo1be9Tv+5b4kqQAROfz6CK5Oi/
 NdFr/WiEkd8CjgLKIq1soyrCzQFXhBCpouuGZpXcyntc2+1RPDpc1IZ8TxeqoFHcD210
 kVvCLWbhCCxbTHFbh2twZoDAhpvrBF64y9vW5vs5GxyfPaFg3lYjOmw2R4NO/B1ynu4z
 h8FaFLA0dKc/BPCCAii3BgP3Van+DMV9+HLf9iwtRnFQ+Oi06DXoZ8I8zRtfNCIt3+vD
 rfx9PSHf4GXQR8TpOulL5M8WvJP33j/F1MWBlCOqu5q9l+NPaIVP1k81VvsRR3FdTDGh ng== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw0vda2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyMxkReaA/8Qzec4iv972HZPx9A6vEra9p024J2FTYrCkR/Ki0Z/aqDMn4ZqmSM/z9VPJNqOUuOM2cq7D4Yg4p69JJfvbrhU4jxZa+CTS8dasDETcPYmdSXgNm6Yi3OEKzLiTnBfwfFASzDC3t3yUf046/1JqKbrro7eKcOgP6+IBIGTF7NdDumbiypieMwnmg9FKZV+96XDp5tpcFK2EbySXR+w8vg1ND4+9cx8EbnfKuDz5qSB5bRcXrwlsKsiMvKxjo8pGhiRJk3RSApqvUaHC6kbDMfMQ1o9Gm5nvaN4Cql5P2o8w0ixlVDIUHRndkbtb+jpQ2mhXBlLaJ9g4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kLFhBy8xrHkyhdB/+w2R7EJX1c38C6ixHyMREzOmLY=;
 b=KpVbmYmTJq2lFS7s1eZkXUHqlC3dyTcKsrR8ghb49fcybWE0N6FNrUs40KoUecl5Oi01m61LT3YVC3yjUwP2oTp9SXdEStGjQ6Ct+pGbmTd/ZDo7m3xb/7s7XvR92X57IzWFq5YmRzFcdS0uo4lSvtlWvN7Dr9WjSttDiGeZ8/1x7bvm9lvOeLazWKmELYvTgjuM6rmThHVajhqlrabrc/9GdwMlSGbtqLzqEbDS0MwHrEi0+yHd6Ze9FMvIyWbkj5i+rRirb1n8GfTdIwdbiucScj+1tuB+GiMOAxe+EbMj98nYMKmbj86L3/2KFBv9JKnNHJxL3idKW/wrR1fW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kLFhBy8xrHkyhdB/+w2R7EJX1c38C6ixHyMREzOmLY=;
 b=onrkTXW1JBZS2YTT2mfOZCRhEwG1XRteiN4/Sl7ZbmOpkoKsS7qFydiArytcULWNau2tIU7RXmbd+7XJnAmWdrYyoqAiYRT2h7kbZOtFm2Yb/7SyaMqp0TVlqlvdUUhyTYBB5+zMTXWfEx0XTWjP/xOwzBaHzNaSMWuYEUTnL4Sc8AjiN1DzD9eJPXFELq97GJh78+2k4YI3sNFN657EIe6LQ5IBQZ8aaj2hF/CoqQNMEQuRz5Yb2O9De5nDgtB3SVtbN4ftZp4nPW8h7qZ4wJJI/Q1k/e3k+CKvs5QUmv8Jd1f8gab6QyifttXXVE6DpA17lYlvJepKLcI3vNI2jQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:26 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:26 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 2/9] migration: convert uri parameter into 'MigrateAddress'
 struct
Date: Fri, 19 May 2023 09:46:10 +0000
Message-Id: <20230519094617.7078-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230519094617.7078-1-het.gala@nutanix.com>
References: <20230519094617.7078-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b33fde-9f61-451b-69bb-08db584de98d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMUp2sCNHmtJ7OZzvUcsn7YoTJrOXK/7lZ02hG+qXRGVF6HLFAEqGU9fHS2RT/zcUOKxG/WAU7hy+8jYgkbsnnOOUTz+iBRuYm2V8KFY1/czLvc+GJcGP/OEW/StuBL2qV21Zwu4UVO9Y58JfIWP6kPagXlU62kGZb6jUr6UrVjAwrO+B5aE1iubD+hUA+TI5SWZ2K347WhlRCswX4A2e/hmOEhFNSBG2WGhQKiU4mY59Z4nPsHVO3+fT3IymEyGyIQlu+ygooxzXGmwKXv0ZVHTBnEpXon13mtbr0y+czcFP0GEF6T59aPHFr1VVFDMU4msQFmNbZaFHDmdnsdh2+ne89H+WdyrCHNoiFG8ura5zlOzLI3FBBVqOMBB31ELZ4wapDVz6vgtsU6hhv7yedbdWatjgjARRP4UsPTN+EO3RtLHd5q3Ev4ScwH1J6ezlGqmbQH/a/Q5XNEc/06m/doIaMpltHvEZw2O+cJVl5rg41kl/nRuwzEm3kmFOKyF5F/uE7mXKtOpF7hTB3SDcliBj4Z3uQyIt3HKaBIsiZjCZcormbqYWvilLb+hbkOXFK4WsWmFdjDYDHchAsIR7XM41i8RXoZfMYEdfp/s3xjsaG5sEg25QCm6W5lrDuQI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZXntn0Zc0bg7BWhcfozDGIYFswiJXF6lPY+d/948bwiej/WwhTIADRtDaii?=
 =?us-ascii?Q?yAP+f2arv26ED4BsnLJ9EINUq+NaUuUfI2MQyJYuLh916AUENMi2EDaU22cj?=
 =?us-ascii?Q?I2x+zix1Ru3kjE0IcQFzZBx5FiOtJnuYZ8avUVJIYSAmLF4EbL+fUZjGF8a2?=
 =?us-ascii?Q?65eNBvlpN1U8Q42xusVLOzTn2uNMts1zRHhhtWwNYk4RofTjNFPKMCvX3hEI?=
 =?us-ascii?Q?rG174C37cAwDshgzbXZQohei+Q0c3i5qgKuQE3Tu07AF/pbOkDKgYT+DGJrZ?=
 =?us-ascii?Q?q8CTu8Te8p+fAmjkAoHXi9gq/EW09elr6jWsqJ3GSc2AtKXnqGNXUWSrht3V?=
 =?us-ascii?Q?+Syck8qnYE6vmmm8+UK3vMOT1asiXZh4rNZg4h5FDglKfBQJ9Y8FDD3Ild87?=
 =?us-ascii?Q?puIiwzVwmcC5ys7NM7g+Y797KnJGY75Pjf3uaHmYk6tvK/vrbj5WL2srAWuB?=
 =?us-ascii?Q?B1KWjlIXeMu9mDf6G/aCie13APafqZglCbE61mfAfT52sZ1hUja1+0cgO7Vi?=
 =?us-ascii?Q?S/Hpc20DH2JEB99N9HmE39iZBYQ1KDRqe/h0EyhbrfjV6UrIV/gJ16MhbvNE?=
 =?us-ascii?Q?aKd9q0/Yr3OAyxx+OqAU2TXtrMYZT9H+J+yBnUw31qMafRJ+ckfQWkG0ccGa?=
 =?us-ascii?Q?hwi0VlD/74ExD0vBSJClSEo7zDJ55q8EwcR1oUTspFYJR6ew5JqLlqNgE4JJ?=
 =?us-ascii?Q?/l+r2FM8DuilbqiLNkcBzoezVUNdnEc+5YLDvPS2btMc+OqYjrJDxRsTz4vo?=
 =?us-ascii?Q?/WQdri4InQXyBdGzXOmYZBIOZPxZDEOqQpKWbESBd+biMiHp2b91I93kvldO?=
 =?us-ascii?Q?5TzF5BrPlO+pO0JwJpsCcztuQ8qvmYQwpJhvwaLGXeIajMqxfeejO4V4epSC?=
 =?us-ascii?Q?0eQkb4gX/Q4e80rk5OAL9C9gHeZ1Fj2GcPQYJ3T6aNt5TFb89zkAxaEqqcff?=
 =?us-ascii?Q?hKmtfYZP95DybqPDEH3A+9ciX1f7q0PCyoekDhMfJQWTmmXK3Zii4BO8cKrP?=
 =?us-ascii?Q?2GRn8vp0OWch6dA/wIV4FhLfcwkRqjtzOqLNs2A6GZJW9sDW89kL+gSyGGrV?=
 =?us-ascii?Q?vfT1enQVSssy6d4N/78sTD6LT+YWE8DUZj32q50o9u3wS/NYCFKedN1pqQU5?=
 =?us-ascii?Q?0JhWDC3lkeZ8RYG4wKTJ8sSj5V4QWv2VlN+hbm+E5IV0GjlhHycNNDozzgIz?=
 =?us-ascii?Q?F+tPE7kvlWk9NvbzZhxXkj1PY8IVqjUqziy22mq0T0NT6lE9AnI+IY9Se/Kq?=
 =?us-ascii?Q?/1l/hUIdLMq8sBD4Zx6VPhbDliigL5Bes+dzgNLxvcdGb/vBO7LeLAZEiOi8?=
 =?us-ascii?Q?UKA1GT1+PumkfSmOo3z5QWGiflMQUl8HUxswdG5vlJXSdh906FuTqM1+5TOg?=
 =?us-ascii?Q?dQyUbTBQu71deugwFWhYZJxfUQ76DHsJG6TBTzUdTcoQkUsbtDWhYiIyTYtC?=
 =?us-ascii?Q?Qn0PxHYlHcTT79Q7ag15DJBRKVqvYGV89iPHt2hmkws7yOj2+UjFybjeByke?=
 =?us-ascii?Q?ur972Av+OYjy69QOSbh9jlWqc8daOV6F7qWh2ZfLsPBhizH75dzSreiBTD6s?=
 =?us-ascii?Q?7r0DMqt0Hk9X6zuCAWeLbGBOCQWlrFfIWS2flAeE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b33fde-9f61-451b-69bb-08db584de98d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:25.9043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itCdgdON5r+IeWE5G6YawYX64qYza6Bwo8waydA8xeelkiMzkpdEWnAjHSTtSl3ncvG2iOQ8TJ04JBg/bYVK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: G16XQVepJp8cSAWQ628JGutAI_s555an
X-Proofpoint-GUID: G16XQVepJp8cSAWQ628JGutAI_s555an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
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
 migration/migration.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

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
index 5de7f734b9..4c9ecd521b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -64,6 +64,7 @@
 #include "yank_functions.h"
 #include "sysemu/qtest.h"
 #include "options.h"
+#include "qemu/sockets.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -420,15 +421,62 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
+static bool migrate_uri_parse(const char *uri, MigrateAddress **channel,
+                              Error **errp)
+{
+    g_autoptr(MigrateAddress) addrs = g_new0(MigrateAddress, 1);
+    SocketAddress *saddr = &addrs->u.socket;
+    InetSocketAddress *isock = &addrs->u.rdma;
+    strList **tail = &addrs->u.exec.args;
+
+    if (strstart(uri, "exec:", NULL)) {
+        addrs->transport = MIGRATE_TRANSPORT_EXEC;
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
+        addrs->transport = MIGRATE_TRANSPORT_RDMA;
+    } else if (strstart(uri, "tcp:", NULL) ||
+                strstart(uri, "unix:", NULL) ||
+                strstart(uri, "vsock:", NULL) ||
+                strstart(uri, "fd:", NULL)) {
+        addrs->transport = MIGRATE_TRANSPORT_SOCKET;
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
+    g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
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
@@ -1632,12 +1680,17 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
+    g_autoptr(MigrateAddress) channel = g_new0(MigrateAddress, 1);
 
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


