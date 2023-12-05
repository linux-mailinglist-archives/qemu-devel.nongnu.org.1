Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66400804BA2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 09:02:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAQMb-0008D2-9d; Tue, 05 Dec 2023 03:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAQMX-0008CT-LI
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 03:01:01 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rAQMT-0000bu-9J
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 03:01:01 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3B57fHZp028762; Tue, 5 Dec 2023 00:00:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=laCLZ6d8mgr
 s2Aqz0YXp7O4KXOH2FNMlZZA1nrKuHJ8=; b=itbEK8cpqMr4PTORTqx9ItpNk0c
 QMk35u9Vm51QYsWYY4eSkrlIi+p3zdiixecrdYe5QkCxWR67ZhqvEia9uKtzJ3dY
 QoiXH/KO9M0jQUg3mdB0li+xjqBh8E3Es5tgS8CEYRZmNEPU7onzkKeDoAyA1da5
 qCCpL6nn+FTLgNmLG6axEG2gy7wwZ2aScuPivNYBaGTAMUoJMnpm34lTRmcAPdgl
 XIF2OpBL3Va/8OZU+9pAtUvijYuebVyJlqug4QyUZ290blfWmxl12nvbHc4tg6Bn
 Niyg6D9uvvChvdougbYrb6eIA0hMMU7gYb46+IJDOavmwOxnPB5NwbBKVsQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ur4sfmvh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Dec 2023 00:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6ik4SX66qNgMxpDS4SHW5kTjYJPpupKJyhNPPEWb3ngAOrZPoDWEGuopOesrdEk0JnVynP9Q3zGruzC/cj2LjEmJyp7gt3TecBACxo1N26xaX4sx3YQjRSc5jK3znlGok7Fgb/eNXG75Ps95Q2rZ1nBkbAoOHKXioXStzxGJ5X3aLE7tk7/hdBm8JlAjAJnVAxkn+JNIp2TY4w9rv8Qvd302Rte4nJrRWhJP3j0bjrCVJIyp3F8G62SIHUNTa+EoCSKy9POhrdsD40AGCmqTzu212+KI7HyBBbVvEc+DLuoK5d1QVkMiG/ATBHthgTk2qPCDd4mmtWrTFaSguiW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laCLZ6d8mgrs2Aqz0YXp7O4KXOH2FNMlZZA1nrKuHJ8=;
 b=AsVcb7fvZQQZch1q1+qWtnKUg82fyLGHPsDyedNHivgc7AyFn2eFcbXtsyRtgSQLWIVw06O2nNRcjFXgBGXDBnGC+SK7I6R66Qd4PwFS+eYJKHsiCFdzIcj6hUhO42+tqa2HXzQDEsBJlPHpN9JFDx6GbbgTked7Fe8ICbDSwSIpNlECuhouXxrUuCeGxIYNOpQWxBuPKK4pTV/Bhe0B8UcBeIvhYTorl4A+T06WkqdBaOx3hHcKsYkHD9ofdByLvObukw5QTxbldcSx2hmg3YhmCK7pBXDYJZly9zKw0FnYu3HuaOIXTvmIz6ET+q9Zm9N2ISrqCy6/vArN648gIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laCLZ6d8mgrs2Aqz0YXp7O4KXOH2FNMlZZA1nrKuHJ8=;
 b=n2MXkcoAc4+wX8dKpB03zTdEKJBxtbg8XCcIGMBJHmtFlnbTH3necnPYVAhyHHR1iWNmIua3SJrD4zwxLK1hJeoAd2bbufgPdVhU7F+86+SIdAAPdV/6D27qooqPUb7wEgY3TM+XrwWn1lAsqW6mJGG3cQ4a6l9edlWWo7cADWh+A9/NE4w5KC16AW9ArRxLpYuJOV55pzKbrEte4jibNgRGkmXhCkl7TEo2QU6F/56NnD+YZtZoYMaEJGqfya62Xhsny9xI+0fzwLWPT3IungoU8Izyv/oJ9D+wkCkwHwPbkKX+/v43R8zGjpTwlvLvDnX4K273fCHjOCZfyZRlhw==
Received: from PH7PR02MB9944.namprd02.prod.outlook.com (2603:10b6:510:2f7::8)
 by BL0PR02MB6499.namprd02.prod.outlook.com (2603:10b6:208:1c5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 08:00:49 +0000
Received: from PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17]) by PH7PR02MB9944.namprd02.prod.outlook.com
 ([fe80::603d:1f11:4db4:cb17%3]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 08:00:48 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, armbru@redhat.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH] migration: Simplify initial conditionals in migration for
 better readability
Date: Tue,  5 Dec 2023 08:00:39 +0000
Message-Id: <20231205080039.197615-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:a03:117::36) To PH7PR02MB9944.namprd02.prod.outlook.com
 (2603:10b6:510:2f7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9944:EE_|BL0PR02MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 82de73b6-50d7-414c-2a75-08dbf5684aea
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/c83hEutJkD1wiHj6hkJW33DkNHtoKO6QchfRypVNXYOtUJ3JYFhsv5yOtbjUhfrYNkDT/gU+MUWw7QNPvOw8l4gCB4rdtJBCRfDvkNklxbM3HSbi23wxzhzQdEj0LLAN9GG9QrAWAThVGBFTzx/oKhrLco3KtcUh0SDXkNWe9+Yf8CNHuL/DQoh8F62c8gpWUfrwJcz8EK1urN8cIlYdoBv6drpXBKG2/NAvmC0CVOTRZvKpND+7DlrAcCwRPOKpbgYtmLhvrysXoahoR1ebjNakM9Mkxlg92KsEvFTlfXwBlEH8lWWrjS0fw6r3VneHgCgjVEKM++nj85wAZ50RYXxNiBmWOWtreqldn25tKKNb5wnVYydlxBA2vchcmhMxg7x+1RxPDzT9x9t844t0QSzPrXINjXvIv+ChNJXut2+vqQLej0HL1UjD6CzFDCDiTKJszrkJHpX9Q4GEZWi5qvo9P7xfo0v3Gb33QHgRWAM05HtiORMxLAq2TySIfxDsnCvIiTXiG9wT+YQLPKUyoCkqZWG3csgVwa/bE34eCr4hapYPrvKzvdmU1fQJ4xfTFL7/kY4FIBkdPePuq4q+ql1tsxuSqzYhB3K4vK0sM2SsjfqMowda0RP9X/f18dmCK08jO396/w/MIPvoEgnf7yuDXwWi8nRPWPd+DQyRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9944.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6512007)(5660300002)(38100700002)(2906002)(44832011)(86362001)(36756003)(41300700001)(1076003)(2616005)(107886003)(26005)(6666004)(6506007)(478600001)(6486002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(316002)(83380400001)(8936002)(38350700005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ja62yUgY9+Cgb9yoTlSfexmDj0TNcw/Gjh0KcBxD3prycNqCAOGCuq+L5GCL?=
 =?us-ascii?Q?OCj0T9s1ElTW0SyO1+0Yfrh4LwwGjVxYHl6t08a7G8H5pBnQJmeFz2hNHtyR?=
 =?us-ascii?Q?wTzG1QxFETVEsVZsanZPgIuE+pv0IG44OOUv4JXlII4IKtiOhRObVPE5QfEn?=
 =?us-ascii?Q?gYl4QazLnzB/iySgxbjrz1f3RDqOUHRkeD4wfoLyF9idb3S9rAVqHYk/S8fE?=
 =?us-ascii?Q?HlVKpE5TN3EcBAxHzMxQWX/usmgFk59ecFSsIM8j3Ve1sSEHW9O9SdA42txx?=
 =?us-ascii?Q?DuyHCc73HOtFdjmLtToW1KEGxM7T3vZbABm6Fa8eSGjH10AIn7n5W2Ydzgvx?=
 =?us-ascii?Q?GPDg2SjzLW+NDz+to5thevgWEYjm/gP7zEhv64VV9aX+QSGmbBRubL1JX53a?=
 =?us-ascii?Q?ae6skz0Siw+YsKcQ9sRIJIvrffIwB+Pf/fR1mwBFHOXZKi6W9sKTu3PUFP0A?=
 =?us-ascii?Q?rK7W2ReX+6Re+91DqG2VkqbaIoXhZRWk8x7J68H8PpAa8eIcNR52PB11zaJ2?=
 =?us-ascii?Q?p3EzpoNntXjcHzoETSUeg821TZIBE07k+MfeJ/QFUoyc2DX+PJJfBrlYK8Xo?=
 =?us-ascii?Q?585IBJib+4x4w7yPfCWwJq+6HLkyyY4SxhqIBx9ktQtDi22NR9mpHKpYxY1O?=
 =?us-ascii?Q?Fmo3UyZVszr7ZpyMLlTfXbJpY7oIY+CDAUNmQzLz+tmdDObX9+w2a2Mqhjbp?=
 =?us-ascii?Q?JSD1LLivN/khHVi2VRDpGLYSStaDQVzweqDyFsnkquhk+Ctks01rYCh+ob5f?=
 =?us-ascii?Q?5KxWufZHyVtl+gtW7tjNs1sA5+Cn4NJ4doi/kIQ3JjWuWtagmcBPgoCCwv5x?=
 =?us-ascii?Q?D4uh/jUq5lYEEMmD8L3WX/Fbk49xPhil6XMW0nSHwt95QEytuEFCod7tLzLM?=
 =?us-ascii?Q?I9nQn0qwxr6DfVkMdt3yWATkbwXh8Ijrs3i0dgQCErcr+DXTF1Qba9J2+tnx?=
 =?us-ascii?Q?Ul2zag7fK22ZxHiWTdKHUB2oJ7DI1V9GJX6t7O2sNZGE1ZRk7gpdvDy/YbyC?=
 =?us-ascii?Q?Ej5kDkRwD0wnJeUVMxbA6YSUGW4CHmXWdN/Qp2eyzpJCF1buR+V6RIpA3u9P?=
 =?us-ascii?Q?HOcd17PXh5XWG81vLs0UvGpQJh9X0pRz7jccACukuM+8kPN7+cx3gmDdk5/O?=
 =?us-ascii?Q?pUKMjuXFpJCM9qROsBizu28K085o83RNXhtBJjVLmL56WaDRFgKhSwtpSsgp?=
 =?us-ascii?Q?khay4ayPHhhERd8dEGGd58xLcXopGNeo3KZqECPyb2KF9cqH2mP5S8Zx3lOm?=
 =?us-ascii?Q?0SOVNyy7dOQNQWR+TW9AVQ85z9SgU5O1nw7Q43xmGtOb6ImapFsCuyq7YkuD?=
 =?us-ascii?Q?xgI2U1YNz7Zpza3Fl7g5joCt+rc2VGaAT81G8C5jBHrWaP3gJaUeDVlOuQCb?=
 =?us-ascii?Q?N/lb5/Bo3UXqw372RXyo1DY4BSau3vhjZhNq7QJJkeHPk7AzyD9PB4YNNCC0?=
 =?us-ascii?Q?qG8ORupmBYhjT2AadaRgCoQbU6CrMIJCF5oqPttMDnEvKgPsygdmKLz/bEzY?=
 =?us-ascii?Q?04nXPkY+ABm7eTicWgjqduYJZ5SD9DrzDDV9ytIv07Mw1XqZ5BRCro5dYUkw?=
 =?us-ascii?Q?17H0PChXfII5sKSAWksig7kSTSRtXgQNrR8fttR1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82de73b6-50d7-414c-2a75-08dbf5684aea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 08:00:48.7281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vuf1wqm17+NSFGZs+xqbJx44XFF9obuFdpoqIS7/jidJfjpaIHX3UZdt4QngFkG8VriaGph/3EuznlE2S3EM2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6499
X-Proofpoint-ORIG-GUID: UGO2pVCOKMoiR4qGkAUtdc2shLjfqq51
X-Proofpoint-GUID: UGO2pVCOKMoiR4qGkAUtdc2shLjfqq51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The inital conditional statements in qmp migration functions is harder
to understand than necessary. It is better to get all errors out of
the way in the beginning itself to have better readability and error
handling.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2aaf..962ee7564c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -523,28 +523,26 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     /*
      * Having preliminary checks for uri and channel
      */
-    if (uri && has_channels) {
-        error_setg(errp, "'uri' and 'channels' arguments are mutually "
-                   "exclusive; exactly one of the two should be present in "
-                   "'migrate-incoming' qmp command ");
+    if (!uri == !channels) {
+        error_setg(errp, "need either 'uri' or 'channels' argument");
         return;
-    } else if (channels) {
+    }
+
+    if (channels) {
         /* To verify that Migrate channel list has only item */
         if (channels->next) {
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
         addr = channels->value->addr;
-    } else if (uri) {
+    }
+
+    if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
         addr = channel->addr;
-    } else {
-        error_setg(errp, "neither 'uri' or 'channels' argument are "
-                   "specified in 'migrate-incoming' qmp command ");
-        return;
     }
 
     /* transport mechanism not suitable for migration? */
@@ -1939,28 +1937,26 @@ void qmp_migrate(const char *uri, bool has_channels,
     /*
      * Having preliminary checks for uri and channel
      */
-    if (uri && has_channels) {
-        error_setg(errp, "'uri' and 'channels' arguments are mutually "
-                   "exclusive; exactly one of the two should be present in "
-                   "'migrate' qmp command ");
+    if (!uri == !channels) {
+        error_setg(errp, "need either 'uri' or 'channels' argument");
         return;
-    } else if (channels) {
+    }
+
+    if (channels) {
         /* To verify that Migrate channel list has only item */
         if (channels->next) {
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
         addr = channels->value->addr;
-    } else if (uri) {
+    }
+
+    if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
         addr = channel->addr;
-    } else {
-        error_setg(errp, "neither 'uri' or 'channels' argument are "
-                   "specified in 'migrate' qmp command ");
-        return;
     }
 
     /* transport mechanism not suitable for migration? */
-- 
2.22.3


