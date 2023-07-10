Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681674D56B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:29:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq0C-0008Ma-HW; Mon, 10 Jul 2023 08:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq08-0008JR-U4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIq06-0000lm-OY
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:24 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36ABqv47006326; Mon, 10 Jul 2023 05:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJB
 JQ=; b=Hu86adFJt8+2CYGBGRmT/+5h3OtAXa2b/XYQIhXMBGzx82zpYzid0snL9
 V2Ka2hdSwu5CQRBNf+fAdsF1nzJhHwGQbXDGBXVsaPV/U3RqI5DFFKiuN0v+eY91
 ahGEhEMFYpZtKLAUJ6qbHDjRfuaNNG7DD5UzUL2gvPoxeGsGBw+pJVKPYOwheTsz
 5KVrHErX03XdnR4vLN2M9sUXMl07kjfv37x4nVLxLUHWdb2L39qoIb4hs32OLvwS
 sTqnVL0nuVwDQImzJc2Jiw9l5nFAS6Bq6LXdCT8w9aI0bG3ItbptJyOuAzDz8lIh
 lMo2RlzQ6/B2wTVICe6WtsJJbLtaQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq7butu5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCcevPo5CiIN7sJDYOImNynhIHxXx38nlfmbikOrOHXcB06rWwofaGrVadJkOtKqIFQwEzNFlnvbdvUsSA3yV2fX+Ayeigb3kJF9OLtyGkbhYr6dAY6uL/2MAsOdW7gdIXoxXnrDXbZ55T735a2kv+zQ0H3ha8GBcddIiMPa9q8ao2jQ75mlwpNgSPxY1JSlRWI+TLW29KrEeHdb61rOQy5mrZodFTIh4XPqI4E0PHjy/fRfSAAToaGxvpU+4itfpv8jnWPhAqN0M7628j1Pnh4UzwC7S1mZpVekcvL/SWCHzwkcNPXejhqMlL2c5ZzW1RwY3eWrTNGQ4D4JpQ6EHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJBJQ=;
 b=nNmMJaxM9MHwRI2doktnFMaO5IibAM5wg52qJ7XgCv1eT1wC6oeyXA476ETY6GOeil4MtiTnhxQ1DxQ/m02ZiT4Iw4HlR2QuY4tzsAKRa1uC1fY4ba5NgCVRw4zDd89ontmClVsKc1UQdM9fC89pV6MryC0hYc1ALBeMnrmMMH1TKN6uWWOXv920kGw0VfR4VLq3DyP0DS8L07yYzAvWrGjrC3x1uxwBSiiy6G30v+DI7UYFvb5lJ0GqbHZ8IvYy+4byim2A+9nFsn8JGU5ZMU+jmAYZHXV9BkA1a2CCVp/AcPLeU9ykkSfw1k+dCDVaUm+kkl+kFlssj+ZyqQ1rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljhltNUk9KvhipxrtKFUECjVpOkw/8Mvt6PEjAiJBJQ=;
 b=cYXnmItYbYPbPO1l1/AchFzFpSzFX4QJlXM4RHfC0zPgg9Q8zH5MQ199drgropoZBhiiR8TcdO1LhZq9+i92RrDFXhUrYJr4KxOne4i1IKpHqqkYDn/8ftUByXW5X3gvmp9rvLQi32iZXa1ZzSFdATYtWbiVxsdILfuMldxbPnx3R9Zj2l2y/ajPJHLD24s27YlEFCl2J7mOaT7/YskjZKwf7w1PvswdtLD+dNx3n2TEUzy1fXwe2yqFwXDOi/j9H/DaKuu35WP229MEEDdEOaoSPShNcTsGBQxjEmvV69QIiK1fJaZcEvi/iolPbwKIn0Kj2BclpTcRoaGqMJt3/g==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by CYYPR02MB9688.namprd02.prod.outlook.com (2603:10b6:930:c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 12:28:17 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:16 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 5/9] migration: convert exec backend to accept
 MigrateAddress struct.
Date: Mon, 10 Jul 2023 12:27:46 +0000
Message-Id: <20230710122750.69194-6-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|CYYPR02MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2262bc67-c8fe-48c0-aded-08db81412343
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t40zlU/cd7/M4qg6wCJFnyDdCTBNeJnfaXbCi9C6mbihjbMquKVxVdpLYCJBfpbBsberpWCs1c+LUX5EVz9EOO18kUZSy/c42/Wbj6cQ+MxsfWxW86KBz3Zw4ERsUh7LaoQt6+GM+ky0wWXeVDhNKZnD61MrMnT5ZMkaiVNYkd4BDx6QFHG9jqwGUgoU8/Xuw6/TlQ5oyxJIrndpDPcBts/8hkDUbOyTGj9rDoxBsxFIpGLLxwlU2/HVoiEssCDR/3DBYn5hRvG3k1xm4XHbC3jz4yGiZlFzPCQXQF0pxR5eaxCAHrLK2fljix4cNQWCgC9MsAyPw8Hv4ZvfMuL75eVxcU8qxll2Mf6OdYJ/DexHAk4LtqmiJ34lbKR+INr9SZCxg4LTjehtPz6qSlTzV+oUuUGc1o+YUqJJ4c9MySs8NO85UqnGDUl6rmaCeVfUf3v10+zZB/pQ5KSkoChFB2FpQnhfIkFgHzVO4WnlxvL4Q6Sg5fIWNb59IbhkJ+7D55F+xb6Kk+DirBg2rTYmeYAEDQbP7oEjSNEtGBeuzWxn7rKxlftDszwb1ghffbrcVR/Xm8d3lYLqfMOfJOBaQo3iG0PTAhvc1mIAz0L6DYsMrunfuJWr2P2YhEcYJOhH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66946007)(66476007)(4326008)(66556008)(6916009)(186003)(2616005)(86362001)(26005)(1076003)(6506007)(107886003)(38350700002)(83380400001)(38100700002)(478600001)(52116002)(6512007)(6666004)(6486002)(2906002)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bVAi1+l/CyE3kB5oK3ab5N2nD0n4VtbT2+fhtusWmnML68PLMk8VfptY/9X?=
 =?us-ascii?Q?ZpnRaUn+2VpQ03HFXTqIP/o9TwbtlSCctandXVmMlAcaSYThl38jG2F8Od/i?=
 =?us-ascii?Q?7zyjkpcK4ZL/MB5bQCZANKfH1RqacJZ0NTbe46etmjCweO5PHJUU8YbCdfP4?=
 =?us-ascii?Q?7KA4AUeW0LR3uclbI+37HZF98+cwDW1BfjTNnBtD4nz/WEyv+mhLgtz3VhCf?=
 =?us-ascii?Q?Bod7ii6R1xHXhbOcf3xcTCyQhETMETjELMHyFF5ZY9mgZewz24wG731alBVt?=
 =?us-ascii?Q?DlKDHj/e+WXRk3fimerChlMVhy0SsdKS2IJhEMFvcTi+OGpdi+j2CJZHHG1N?=
 =?us-ascii?Q?gPKK1Fzx0EFfaSHajXapF9gpiQJ5dKIaKYfjEVBED2JDejBn8N7x1fFeLSpf?=
 =?us-ascii?Q?Hfwvd84YijtLMIIq/fevz49Yakm+x7FzkPDc+mu36rJS6jF2QD+vMb8LL1PR?=
 =?us-ascii?Q?jmLm9iJHoS7W0+Zu18zO1oTdo/tZL2ku6bu6TOLDBU7OpvsAMFjc9yvCCbPR?=
 =?us-ascii?Q?Q2cK5SHWJLVP3ueYkzdwx1u2HlawQ1yKwyp/2ESdqnev7I1DIa7iArrJFGJR?=
 =?us-ascii?Q?Y4DDxnKSyYOplolCM8ZGPxxiBhTKloBoVYGUmMRKGXftkVCBftclKCxj13P7?=
 =?us-ascii?Q?O5BfhjbCaQRDUXbWgy/LzCdpr9yBbvyVIIACVeQLgVCu7Rhr36lGEAQ++tXE?=
 =?us-ascii?Q?HReHwgYbdX7f10Ib28OGIrjOTwVKBrhhjTrfF3RHNd+M2mF5shMDsZvQeapV?=
 =?us-ascii?Q?qzRX970g+8NZxu3AeH1RpBG9jpAmVK1gl3RMMv+SC4q9Qc6a/g0jF84KLw+3?=
 =?us-ascii?Q?Rlxzu9eI+2Kif2JESbwetndounEsok6q8xaPnjyt8YfxWRaCnz30L+XWA3y0?=
 =?us-ascii?Q?roAqMQvB6yWbKmVhHcKZiBv8rMaRqSQU/lvQO0OtUDs/7Kly9xYiBcbzk+RE?=
 =?us-ascii?Q?lNgMcM5dEJ6Qhx098q+erv+6ZpdYeWh8aj8/6uvGDkxuef6ABFenywkGium6?=
 =?us-ascii?Q?hXiLYRAalG/4G6qafyFfbx83T01ZxXS6GZ4u3VRyBLcVyjvYYjP4GQanXftb?=
 =?us-ascii?Q?ZxEefnL27bwwLeHIRX3DaNVihGBAtdlRzoUTxfd+m9rl7h3LeujQYrvg7aD2?=
 =?us-ascii?Q?pKowjs6cZiGGNNzSsTmPbQGf4m13dY6MPpmr/ZdHr303g0/hytDp5GnJfizt?=
 =?us-ascii?Q?DUUlNRy1DaRA7PdMNrP17dHV5nTf46zxPFkDtdURacbqRWv/9LDkNto+pHaQ?=
 =?us-ascii?Q?ugCn4JWbF2P/RavpkwkyoEhjNuMppOkVTnU7anG3o0GQNGXRbmt6Pb/suCHU?=
 =?us-ascii?Q?fqZNd5OoOwG17u09a72BVkCUEQIU4wQlpa3cbZyO3annbRbbYlGzS62vSh/u?=
 =?us-ascii?Q?kCKkd/tgqHiotGoUELC1Q890Mwy4taUmFsNzSmFZ2pslyO/hy7JaPJ+uhZe8?=
 =?us-ascii?Q?kD3Bh0MsobeXIZNBAswyvIia5V8q3Tch6K/0nA3GZpe5CC5OVqNmEEw/owJS?=
 =?us-ascii?Q?7PXQNiT3LVrLjdC5hKi5eJhJwl1xXxPF7pDhkD3NtnXf1D83h4uoM/aWuY3w?=
 =?us-ascii?Q?NejesPwH4f2ex1sl9s2NNQkHvICEZDKeCV5V1KQHfzs9Z8rAABHbdMOv9UpR?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2262bc67-c8fe-48c0-aded-08db81412343
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:16.8630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIhklkjNcI/d1fujhaWktl97USJjGknp4UpY+B6fvcg8TAGDMPsaWSiV34LxTgj+oTanZQkmMkjmE8RRcSzgvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9688
X-Proofpoint-GUID: 8FJo0zuOVkO8PEyLdVqauX6T7wAYpN7u
X-Proofpoint-ORIG-GUID: 8FJo0zuOVkO8PEyLdVqauX6T7wAYpN7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      | 70 ++++++++++++++++++++++++++++++-------------
 migration/exec.h      |  4 +--
 migration/migration.c | 10 +++----
 3 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index c4a3293246..8bc321c66b 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,21 +39,50 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command,
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem->next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst->next) {
+        argv[i++] = lst->value;
+    }
+
+    argv[i] = NULL;
+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
@@ -72,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length);
+
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn((const char * const *) argv,
+                                      O_RDWR,
+                                      errp));
     if (!ioc) {
         return;
     }
diff --git a/migration/exec.h b/migration/exec.h
index 736cd71028..3107f205e3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,8 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+void exec_start_incoming_migration(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
                                    Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 2f5bd5df6b..52e2ec3502 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -467,7 +467,6 @@ static bool migrate_uri_parse(const char *uri,
 
 static void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -493,8 +492,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else {
         error_setg(errp, "unknown migration protocol: %s", uri);
     }
@@ -1692,7 +1691,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p = NULL;
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
     /* URI is not suitable for migration? */
@@ -1730,8 +1728,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else {
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-- 
2.22.3


