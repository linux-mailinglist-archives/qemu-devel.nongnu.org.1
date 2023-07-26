Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49A7639AA
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMO-0003gv-Iz; Wed, 26 Jul 2023 10:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLt-0003Nd-01
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLp-0001B8-N3
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:56 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDBY9C032359; Wed, 26 Jul 2023 07:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=gAToj1I6DYbRU9J8UWsEOmQz4M7Y0ReHAhFH6/IM5
 VE=; b=wedjJAlLHou4URBVdJA8eZRMO1vCOBjnXQRpx2DF+WdD8IWHYeKfQCkSg
 mqe77SyxZpn8sUU/Tt3+p05MxfzxVr9Rbnv3UXFbFWXSxbfQ1HIPfW1axQIM9nSW
 jypsBAeDYvVTMEY07y+s3pDcx/asAKBqhexXxtCBjsAkT6hhacOWQDehrZKhaKXl
 G8ZMK7KOOMo8E8QL6zTaaLQgAq99PVz2riFRkfJjE5+DExDB2I7XatNx2ENHb96C
 4m/jO7LKZMbCxiK1Sz5QC2rjGTIYNs6FgeTURcrHJUciraKlkk8URvl2wuVrZ53i
 PJVnh94CVN87tZ5bfVXz2AHTrIGfg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bip2THPtHNyc7iodLgexR8JHNBPO2MtOY4LI9TrrxmV6DBv8/s3FfmFd6TcRNf7ipISGKiiFcmwTNCnkepr5Zm/HSdP+myEiL9gj/gokWytGV5gDcN0mvvSecZ8GCdY4yk76MxvWQgqZTihaCxk1r1N2ft0351NHwhv+yV/yPpPLbqIXPCXF0dU3iGGfITGUhEgnAEEaH5NwFK/TF5Hh8t6othkETNPE/l2LYclXk/uLJpe5TEf08T0l+UzdwF8LxoO2Uz8jdPeXnQwc0SdqVTIzIOYPW8Aer35fy20/u8RLAtzLMZCDKWhqQ7JV+0aZTrarOLPocvkFR8q4zrI7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAToj1I6DYbRU9J8UWsEOmQz4M7Y0ReHAhFH6/IM5VE=;
 b=eZ5rVFx2OkFgsZkHNnpN6sctzNIAYXv9s6PE+Sno8vxd+TG2Hk7pvqoTUAmsDxVctUkKGVVdkaUT4bSHM7BsOXDSAfcgBWUK35E0ZGK+AQhsr9IStejV9H30F/1FVaJ7bswsO8zSwnYOjgznLT+Wvmk23U5T/1srJkf6fMHF50Qa3u+KUBrmJW+BZQgeAGS8pMFc9efOCsY5lPOQ8+r4hI2s8JtTOusOJLBfirupVLKBHyrdjQ0BC/Sxjc8hzKWhvIOxG/TbEDI8piAI6EpIQQ+Yn/c8nuk1Ca3WC0Wh8Z1swz3nacNJ14Qp+8t4Boqqr52BYm8D3xz42lKkSC6N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAToj1I6DYbRU9J8UWsEOmQz4M7Y0ReHAhFH6/IM5VE=;
 b=cej6klKw7c/mB9Hm2jH7zqWEopjNpXTBH8zLDaZIs0EyryHxrBkgw7f6OayIPxHeZYEynyt5FoHUVI6qh8GKunA/Wm63/UMZ5JFudr2mGXVRsszRYIexCU17Nhvw1sgCgi/X9ruDKjris5hwGAsUENBYcICaeexlZcUWRrahYy7AT6tOsrc2xx8mw6mpMVXicW/dU9pIHKmt9Chc18kuvzXMMqWLPiVk3NZvmZGOvbtcw4EMl8fS5JUfMU4JukZON72SbjSjNgKEwirpVj/yjC4TKgQriIvsjA69+o9j2KzjKdx+7CS3xT1tWBEtvwnOBvYWGdjInwvOtL1kDtIRvw==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:49 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:49 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
Date: Wed, 26 Jul 2023 14:18:29 +0000
Message-Id: <20230726141833.50252-7-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230726141833.50252-1-het.gala@nutanix.com>
References: <20230726141833.50252-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: e1250f69-e32f-4645-c909-08db8de33b52
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhjDa9KFlObr2MoCuMJ1fBtcMZvJNjzvedCv1Ys+/tj2A8eGiwhk1LgsvryJpDoKnf82awi1HdB3lckJMPr5IPoI+m1yS6YEB6UG9EdWHsZHpgN5/ilZMOG0/yNlzxTtMlO32Yxo0FiK9uqtHJ/ivXpdkIWC3czR/vz71xDOvxeX2bhHvb2LxQxbRiRAuiywsjtDNbeJi+BaArXvyAmAEGZ6rtnd6PCJgIh7yNt78dQuX1MfLG4xfDsQy7jVwI477YW/PJzP8r4eARHmA8i+HodhMRKkaSWy8CJEgQBM5ZhwKVelFUwtdY0QqobNM/CieEFt6q8OmTxP1JCmOHc2CLYTG3SwfH434Jhne6moUDKN+wRW0m5cXHXnJjWfF81VQKH2WkUw85G8f4SwCX0cNke6Ex9witmXCGz+MWceg3aU/gA4hj/ran1wFSWNjhRrMgA6jqJ/e+hxoNpj12Abraam6kee7B5fUvpa9jQiAF5YWWGvyapNHJs6BgZNeosVlCN1QZZcYTdtQFBmbua5aQTbnXr7FQNsH7+SCFpe7Cnh2+QFjEzvYiOYZcQBMzbc212W/eI/mgoexkFCksmqKglcMVXTH0g+aHEwN5+/6UGmdRNbsNQFhb/ISwWNBFf01xB/HSMWeGwL3gtP2FGRPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(6666004)(478600001)(52116002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXsMr7JhVXf7JowIYs1Tv+ipKcaDmNGOzdJS0j9B+pl6ct70QEI7/1eaQ6IW?=
 =?us-ascii?Q?619aMZN8x8W17u3Lk0v15B5BdwL+LpF3PahsLWrlxqmIy+HHPBQ/8eOtPOUH?=
 =?us-ascii?Q?hPUJxmDl/MvXsnnX1jCUQ8M8CArKzgtnFDhgIlXFdoxbQPtOWj9KQI30RyAI?=
 =?us-ascii?Q?Qdmy7bym03Zj5lVROI4+f4fFUZJKjcOKfp6RXwUcRJbgJywKPPAp1sOxk+Vk?=
 =?us-ascii?Q?SIYQ11AMZCcMI+zjhYy64Z3hRvZF64/00ICKxuk5XeD++qqViE3E5m+kDi0G?=
 =?us-ascii?Q?Cx50T6iqLsD8QjLTzNn5xvZhClPwSfjD7cgBhj8RhNaztP5BX9tPauAvWQx1?=
 =?us-ascii?Q?Lsyxx/ejI51uQktLGzB3Wd4YTHqCouarATDGBuEkv409x6kO2wQE70bFTh7M?=
 =?us-ascii?Q?inDzb2enxTFpNOvtrjeaFxs2dtIPyyEJOAOPGZG1HcUnmp21I22JNysPjtfL?=
 =?us-ascii?Q?Nl0DzdmhZzCBb6B9e5Zjv2XNVT2f0jVPJNrOXsXNWVd/2OpmQ2QSHwuljJu2?=
 =?us-ascii?Q?BJxXbfzN/5AQBWDhEBG82Dkz9Co40vbDysaZ8EY/dmWv/kR8+mQzWUze0do8?=
 =?us-ascii?Q?sd9alDEK2247wFKBdx5oLT8rH/ixfmCkd8crI3ybj4bh7WMQO4YAU4M7iNLH?=
 =?us-ascii?Q?TqjOjj0mY6BidBSF8YIPnGukp4PSOP9rGU7YdVoZNa9S/XBq7hIde9eNe8mZ?=
 =?us-ascii?Q?6X9qoypWDiZp7bOOQGQ+DjDIlwRqMihYdOP+WORhoaCDDaxRzGz69Zuqathz?=
 =?us-ascii?Q?7XvcP5arovR6nXmouS9+9bCHLXoiz5GwOIVbTpi2b5K7dg4uYBW4WO2RUqQD?=
 =?us-ascii?Q?MMTyPOGgGVwPAU3/8FxWZ89Xi7BkEKAwWCZBXEDJXEie1BFc06t5T0fwiYIL?=
 =?us-ascii?Q?e8ETgqszDAyrlch5pzWnhZ46d0mg6GU0FVtHo29vsbTYkUGXbXvVndePefYf?=
 =?us-ascii?Q?KugcBCz6E3IpD8GzdNxwG+9Y9kC+YMogkK4W3V+AdRDWVgE9PTfANg9xoqgc?=
 =?us-ascii?Q?2A96biaupNG8f/4y9TWKS78GpJvFNyq0SJnVjYOfCCSDrjF+8DUVJuEH0dl2?=
 =?us-ascii?Q?9iQpje0k0faTppEe8qT51imT8pEZzeMcZNfdAtm4L55izllXSYH8g/wkFshy?=
 =?us-ascii?Q?LJFauAB7MUs+7XMQFzRUq9nE6ZK5U+sJbFjvX+EEPEyCpGrcm9O9R0aeKDo9?=
 =?us-ascii?Q?+kbejsgaHJC1yGHxwTSNPg581r8S4aEeAOkvQ7zgu3Hwg60VlMsKaAJ+uwhA?=
 =?us-ascii?Q?tV6E3ofKn8hf2OuPwWLy932CIzKJDbcnspwZTbhD44mCzIwOC7fYRIihq2GT?=
 =?us-ascii?Q?Qp91JHq4CtYlqk/RqLeCkPwPqK8gzz+zi2ZKF/z8TVrHtVs9j6g89wsgokIQ?=
 =?us-ascii?Q?+D16AyZ4tJnjflyyeTNin/D3WKQBxs1Hz1Kgt/gkHb8YO4AjqAILoM7i4z23?=
 =?us-ascii?Q?y6j6MTWvyVTIL8lHk7Sbvt5BjtU4VP8xYup3m23BlJAb5iXHfWkZuR0xk7j8?=
 =?us-ascii?Q?DxzgOUDwr27iCkXqXcrpbbXDLVz6MchKNxZrBi0vWIgctv2E76toQF17ZLZi?=
 =?us-ascii?Q?lmi/g8TNudaDOD+/P9GGAB2cERQuXaEtKtAim1cl0KE/PWe234G5xFFmfrTs?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1250f69-e32f-4645-c909-08db8de33b52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:49.7343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjO1E+Ik1KPJXtrnk5+xy/+gd1ntkI5axFl6DFJtpRgQNkgbxJO2fiYF0BbFKzLvAo5KIWXKyzVhmE+06KeHTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: NLJ25Ps3j332pG_tE-wHXuFajwGgvTNk
X-Proofpoint-ORIG-GUID: NLJ25Ps3j332pG_tE-wHXuFajwGgvTNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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

MigrateChannelList allows to connect accross multiple interfaces.
Add MigrateChannelList struct as argument to migration QAPIs.

We plan to include multiple channels in future, to connnect
multiple interfaces. Hence, we choose 'MigrateChannelList'
as the new argument over 'MigrateChannel' to make migration
QAPIs future proof.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration-hmp-cmds.c |   6 +-
 migration/migration.c          |  56 +++++++++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..49b150f33f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -424,7 +424,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
 
-    qmp_migrate_incoming(uri, &err);
+    qmp_migrate_incoming(uri, false, NULL, &err);
 
     hmp_handle_error(mon, err);
 }
@@ -705,8 +705,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index f37b388876..be8cdf0fa5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -466,10 +466,33 @@ static bool migrate_uri_parse(const char *uri,
     return true;
 }
 
-static void qemu_start_incoming_migration(const char *uri, Error **errp)
+static void qemu_start_incoming_migration(const char *uri, bool has_channels,
+                                          MigrationChannelList *channels,
+                                          Error **errp)
 {
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1497,7 +1520,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1515,7 +1539,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1551,7 +1575,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1685,7 +1709,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1694,6 +1719,27 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (has_channels) {
+        error_setg(errp, "'channels' argument should not be set yet.");
+        return;
+    }
+
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
+    if (!uri && !has_channels) {
+        error_setg(errp, "neither 'uri' or 'channels' argument are "
+                   "specified in 'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 6b97ce9633..a558a4d705 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1458,6 +1458,34 @@
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress' } }
 
+##
+# @MigrationChannelType:
+#
+# The migration channel-type request options.
+#
+# @main: Main outbound migration channel.
+#
+# Since 8.1
+##
+{ 'enum': 'MigrationChannelType',
+  'data': [ 'main' ] }
+
+##
+# @MigrationChannel:
+#
+# Migration stream channel parameters.
+#
+# @channel-type: Channel type for transfering packet information.
+#
+# @addr: Migration endpoint configuration on destination interface.
+#
+# Since 8.1
+##
+{ 'struct': 'MigrationChannel',
+  'data': {
+      'channel-type': 'MigrationChannelType',
+      'addr': 'MigrationAddress' } }
+
 ##
 # @migrate:
 #
@@ -1465,6 +1493,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1489,14 +1520,50 @@
 # 3. The user Monitor's "detach" argument is invalid in QMP and should
 #    not be used
 #
+# 4. The uri argument should have the Uniform Resource Identifier of
+#    default destination VM. This connection will be bound to default
+#    network.
+#
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 6. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate", "arguments": { "uri": "tcp:0:4446" } }
 # <- { "return": {} }
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'*uri': 'str', '*channels': [ 'MigrationChannel' ],
+           '*blk': 'bool', '*inc': 'bool', '*detach': 'bool',
+           '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
@@ -1507,6 +1574,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream in the
+#     list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1522,13 +1592,46 @@
 #
 # 3. The uri format is the same as for -incoming
 #
+# 5. For now, number of migration streams is restricted to one, i.e
+#    number of items in 'channels' list is just 1.
+#
+# 4. The 'uri' and 'channels' arguments are mutually exclusive;
+#    exactly one of the two should be present.
+#
 # Example:
 #
 # -> { "execute": "migrate-incoming",
 #      "arguments": { "uri": "tcp::4446" } }
 # <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "socket",
+#                                    "type": "inet",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "exec",
+#                                    "args": [ "/bin/nc", "-p", "6000",
+#                                              "/some/sock" ] } } ] } }
+# <- { "return": {} }
+#
+# -> { "execute": "migrate",
+#      "arguments": {
+#          "channels": [ { "channel-type": "main",
+#                          "addr": { "transport": "rdma",
+#                                    "host": "10.12.34.9",
+#                                    "port": "1050" } } ] } }
+# <- { "return": {} }
 ##
-{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
+{ 'command': 'migrate-incoming',
+             'data': {'*uri': 'str',
+                      '*channels': [ 'MigrationChannel' ] } }
 
 ##
 # @xen-save-devices-state:
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..d811f3f878 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2651,7 +2651,7 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.22.3


