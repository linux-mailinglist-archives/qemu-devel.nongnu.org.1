Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D5723F1F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjq-0001ea-Uh; Tue, 06 Jun 2023 06:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjg-0001be-Uj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjd-0006Qs-MC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:20 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567SD7T004530; Tue, 6 Jun 2023 03:16:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=sK3PZ4fsTbGSznr8MvSOIiiIpJ/1NvIquHLFEOZHPUU=;
 b=jABE9AtD600nlGsR5OFXWkkavzWpkeC2lZsBpHDcfsvHX9un0KDo/29q6NRlPJ4AdI5e
 OKsbT45cFoZ1tQ8S+bC8P/Kfl8gnlHO59uIWKwSZ5rWpSgI8qYKK0Q8r3UouslwfsKN8
 iR39930M+gI1I7fPGXHiKXt6A6D6c+vhMGritaZ2eaTT8BQRX0rTwRDUoDHo7LJKW13f
 /W56mhdm1qBBgkbfr6p/Bh4iW1ch3/0/NJFaGPjYMbTh5QVxeJ4Sv9nNs6OXtcWogvwx
 A8f/1bktqTqhz0iojx80m3KVQacuooD6fbb+FF/m1URurfVCli4BDf7fcKuAv3TklGhe Lw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r051y5d90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YToV1pkPA7h9RXQFJabIGXNAfI9LNjd2KxWeUg5FFBgWjHXmOASUXlcgZE0/99Gv9y9j29k1/eLxOC4NghqPPBJP94UWz3ZF0jF1I1FxkYkBp+e7PVbw12XelvfjQYOatb/xZnuCUeqmegOotsPRK8PTtOmy9v3SssZZwU0rDaMSBnnGxyt292uOu35gts+Y0AjSJiCIm24nFmSZIAzNDb198enpvIxvCvPXy+6rx9Q3cYWxlxRY5YQPWVrtfQT/uQ2mmUhlx8wVjNNez5R3v/1YtrdMngh3Zkkp3+bp746WqAUc1YwLFijQogx7J5n5CKzDZz3RSdO1dcjJAq2lhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK3PZ4fsTbGSznr8MvSOIiiIpJ/1NvIquHLFEOZHPUU=;
 b=O0iCqnPsz4CmsbffeQilaNTfW0GfBn6gO86ck9mlCM0jycUNSoR2ry7DQ2qmfZTJ4c9XGAaH+p2DSny8taP917JAFU/sQPsiGkiuSRjcr6iY2yi0iptxtDuQKJcS3zyxdJN1h/W3x098iL7oP5kh//hrvjg1D+iM1QG/vrJLa5mn7dXGi2GSRMpUfJ3GF1hr2Jn4k91a8dAVDzIyCsnQfCDaIwNJodOMrlBBFG7ZWgXY80JiGIPALJpd9WuzYouAFbMwOXx/bxbYO8ttQta+ZZUYViQLRCAvrCrOIg+4aAQXCDKFlbJ2A9ZWXmovA9ZSvNsYM3T4juwe7lzzl+hZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK3PZ4fsTbGSznr8MvSOIiiIpJ/1NvIquHLFEOZHPUU=;
 b=pCEuNwDWHU6uk72gFef2rDC8Zveg/NFhLfOPrYDYZ+DwHAxKbdKrAklQJ0Yv6b0Kj6jP4Mc1Bl6Y64yslL6YrIwuFAywzZXD1g1IGN1SEkzARVS6m6/Dy/iT4OcXeIFWWufR3D0+Xj5ttAhn5Ei7DqtRozk/f5vtZd7nDs0lL6ZeglEVdUa+b3V64n95qB0w6iiLZlVqYAvqQ8WKaS14hM46tAy4/v7M2URsbPr1J54iMzAVBHe0w3DAxabwSH1zBcWXUEsgYE0RI85eKv33PA3OrTob3OhtCUZ8n0i5Z3meiB2ZE9wD2O3TjZAsIwW8Ran129ntAQMW/12XwE+ZJQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:13 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:13 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 6/9] migration: modified migration QAPIs to accept
 'channels' argument for migration
Date: Tue,  6 Jun 2023 10:15:54 +0000
Message-Id: <20230606101557.202060-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: fed96da5-397c-4b4c-bb3b-08db66770e98
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVemoj3jZgJKNqnupGl+lrF507r4fyBra0idaylovf1R8hxsLlCCFbGoIhsLjwOV/wALJaG6WYHzJSBOh4+6O/fUZXBr7cLq9Pi6FypWDG8QXjbPyJQHdEjY97DE2+PFHPK+HXhnHyAWXCD8aq3Bk2XFkTor297RFDADzSswrIDWWsacqTueGS+3vtLUnS/DHW1XqBLzAmglmhWgi1HHM6YRYkqYGgj5fTSPcIlB7x5YGqp5mnnXtzkAQY/fGFfzF9pcxoG3cXSMJHPb6l1mmWUCqRRnKm4/YpnF3gvVrXJk1Tbl1APIHviwrJDj2nupSUI+15JZEvvWBIHArOs+bckqqH7o1Gl2p+q4bFVB93yOfobNY+Jv3ugwyeEclvdaw5crOU0DRrQGuVvzzOk8nDj0tI42ag2rlYbOnWr46NL5bagL/6c0fdV1rXzfDr199DEyL88wmq1vFn0dyUCKSbahJNJ6sdPZzjQI1prSoyAlS5GxDOJJ7cctNcmMsMB2eLjUMT8H6XePoQyL2nQsoksiGMzUGN1lKBB2liUd38VaLrg7qgPAlUBJumzJN1sDv7MK9k80wNZQAnZgdIEHjOVICltDfwSoGfH85lAJN96WGqm1QfgC1Zv9jkbQFGtM8nt09lENB4sqSF9K1NliGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OaHvKz4favTit/7vQO+I5Lq2JQd+aouDzOZk/FVn9eYHo/pTyWf60fPtpAfu?=
 =?us-ascii?Q?q1CcXBPjpKeQnvpvOkylo6JErJykXGq6CKY+twTLQHsjMERBMCAGUWEYW/cM?=
 =?us-ascii?Q?oR6QvWl3NOSESWsWbaEfv8kMv2L2pw8lEOY+cacX2Pj2K4I73mxUQE07ER5a?=
 =?us-ascii?Q?VhunLQ28I6QMTGMOtgTvR9zhYPQyfsmZi8d6N7uZaD97x648/yqgS8FIywIz?=
 =?us-ascii?Q?ugLzFe/7iXg7S/XiA1sxqP/UWAqnr/OG2QumE8FacW8h9Ci3QYCZiVeFiY4b?=
 =?us-ascii?Q?nHQnXb0jL6k+Y60i4H22Qns9CF6cuQnW4LnQf4xK7J/xychp0z5TLfBOB+7f?=
 =?us-ascii?Q?5p8GN4LrvLJui5HXGJ5ZMNfykCFSKVw3g8xVe8FPHLy33+PtwSQBZRSRKQEZ?=
 =?us-ascii?Q?zO6uQkooPp2yFdTks/nxIvuG6aJi/7GfUhqFZVv5T76QGunU7NunqkeNRyJ+?=
 =?us-ascii?Q?f8x3fyyHBQ2VzRmBflFILEmVHzRxJPrRrRxHXj+WcfqqWbhaaCJT3tvw4hXy?=
 =?us-ascii?Q?LHXmu01SMtUwC74WRvSZroc4CYpFesHHn55lZAIAFRw0artr8LOrmhCZcNsm?=
 =?us-ascii?Q?/FxJchGgLguY44Veu2ltHmANRBYPtW8ql8mRFiawln1SiWHKgxgMmh9nS7lr?=
 =?us-ascii?Q?p3+CBnb+LXK8x71JkvtlINWlhrNoNd9vx+hnAxVzMXGzNoSoaJ5vz70u+bHK?=
 =?us-ascii?Q?DfHq2wca4RARbIdtfH1zBO0pKxm52kgmf4xLHy2tQzt6Ytq2gB/nAVdC2bBG?=
 =?us-ascii?Q?esjIUtH7SgIDkpOl9S2lZM2Fsx5V2IlaS315d3muqOyTJz3tELUw++5cOE9X?=
 =?us-ascii?Q?d1ikzSM35UjxiiQ5O29DbpL4E1fHJBceJGuHYMvGv9poqlCUw2uczfVM4Yyn?=
 =?us-ascii?Q?PHHf3SC57l8ycn847ZO7dkeyyDebjPxvruiOTGLVEF9omdEf4hyAhq08SCB+?=
 =?us-ascii?Q?cYY9a6DoxOXsRWPymzMl9oXKVEOpKeLdYDvr3rEbiaUQF+AB0cpK3MlfBvlI?=
 =?us-ascii?Q?ugR/jbhbCfEKSIYPC/IHrMbDAzZcbuKamNXeaorMgB9Qs/1HR1PqvXgF+x9W?=
 =?us-ascii?Q?cmXvxRNxEroInn291ctT/08jKW3bQt8pTKGrUePeQvHAUQLFQkf6HvEmFi14?=
 =?us-ascii?Q?o4LW4G8H4fjyG5OwsNhJ22TDVXex39KEfL6AzXPCoe7XaYHPzSB+pD3RVrWn?=
 =?us-ascii?Q?MkG2hE1zEco5n9OFeX3m2wiug3PQxd9RvkbGxXFWLrIWWs2+0TvAXNfaz1Ef?=
 =?us-ascii?Q?gWmTIdVjHDibB39cHtYs6wehLOg65vwTyF2atgBXx2p91UM4RhjOVdNYQxhJ?=
 =?us-ascii?Q?+QcaF+VZjA2IsGHC60ENPmmVztzUGcgj5VfM//D+ZpxQJHnC85GSVRNu2WUK?=
 =?us-ascii?Q?+A0oL82CmozxAS4b3qZDNCzrlZzNoENtyhrQ7q0IPszCjuUba2IoWR8PVhnD?=
 =?us-ascii?Q?nn6n5VqCH0yiQXDXciXUxF7O9vF0JR+4NIlgDGbXoSBb6/c+J4ccYPU37tKc?=
 =?us-ascii?Q?bfHu0cZmDJtYjfEftG6BYUQoBFp+Vy4dEDN4QbJ1zdxFD8sFNsOCiZoVvmKi?=
 =?us-ascii?Q?06RqRVaHYeDT4nNhj1V1ezwl44m8ge/zrmuZUWfa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed96da5-397c-4b4c-bb3b-08db66770e98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:13.6302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxYBXkpH/7LR9l3oj4MJyN2qPP4gp3RP6kZTvNpxnyDQGJYq6aRxR3rEiMyQw/ZgqKJWdGX04GQNp/7j3zupZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: QrbqPFszd2thx0kGL3l-T_I6Q8ihGFIP
X-Proofpoint-GUID: QrbqPFszd2thx0kGL3l-T_I6Q8ihGFIP
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

MigrateChannelList allows to connect accross multiple interfaces. Added
MigrateChannelList struct as argument to migration QAPIs.

Future patchset series plans to include multiple MigrateChannels
for multiple interfaces to be connected. That is the reason,
'MigrateChannelList'
is the preferred choice of argument over 'MigrateChannel' and making
migration QAPIs future proof.

For current patchset series, have limited the size of the list to single
element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration-hmp-cmds.c |  16 +++--
 migration/migration.c          |  34 ++++++++--
 qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..5f04598202 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -423,10 +423,12 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate_incoming(uri, &err);
-
-    hmp_handle_error(mon, err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate_incoming(uri, false, caps, &err);
+    qapi_free_MigrationChannelList(caps);
 }
 
 void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
@@ -704,9 +706,13 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
 
-    qmp_migrate(uri, !!blk, blk, !!inc, inc,
-                false, false, true, resume, &err);
+    QAPI_LIST_PREPEND(caps, channel);
+    qmp_migrate(uri, false, caps, !!blk, blk, !!inc, inc,
+                 false, false, true, resume, &err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index f482de5df3..a5ca9e0e27 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -464,10 +464,22 @@ static bool migrate_uri_parse(const char *uri,
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
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate-incoming' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
@@ -1489,7 +1501,8 @@ void migrate_del_blocker(Error *reason)
     migration_blockers = g_slist_remove(migration_blockers, reason);
 }
 
-void qmp_migrate_incoming(const char *uri, Error **errp)
+void qmp_migrate_incoming(const char *uri, bool has_channels,
+                          MigrationChannelList *channels, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -1507,7 +1520,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
         return;
     }
 
-    qemu_start_incoming_migration(uri, &local_err);
+    qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);
@@ -1543,7 +1556,7 @@ void qmp_migrate_recover(const char *uri, Error **errp)
      * only re-setup the migration stream and poke existing migration
      * to continue using that newly established channel.
      */
-    qemu_start_incoming_migration(uri, errp);
+    qemu_start_incoming_migration(uri, false, NULL, errp);
 }
 
 void qmp_migrate_pause(Error **errp)
@@ -1676,7 +1689,8 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
+void qmp_migrate(const char *uri, bool has_channels,
+                 MigrationChannelList *channels, bool has_blk, bool blk,
                  bool has_inc, bool inc, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
@@ -1684,6 +1698,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
 
+    /*
+     * Having preliminary checks for uri and channel
+     */
+    if (uri && has_channels) {
+        error_setg(errp, "'uri' and 'channels' arguments are mutually "
+                   "exclusive; exactly one of the two should be present in "
+                   "'migrate' qmp command ");
+        return;
+    }
+
     /* URI is not suitable for migration? */
     if (!migration_channels_and_uri_compatible(uri, errp)) {
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index e61d25eba2..7d4160e130 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1452,6 +1452,34 @@
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
@@ -1459,6 +1487,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
+# @channels: list of migration stream channels with each stream
+#     in the list connected to a destination interface endpoint.
+#
 # @blk: do block migration (full disk copy)
 #
 # @inc: incremental disk copy migration
@@ -1483,14 +1514,50 @@
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
@@ -1501,6 +1568,9 @@
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
 #
+# @channels: list of migration stream channels with each stream
+#     in the list connected to a destination interface endpoint.
+#
 # Returns: nothing on success
 #
 # Since: 2.3
@@ -1516,13 +1586,46 @@
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


