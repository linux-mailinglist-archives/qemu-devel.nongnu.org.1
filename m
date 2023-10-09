Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EB7BE304
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNi-0003uW-9e; Mon, 09 Oct 2023 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNW-0003mX-6G
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:02 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNU-00037J-5i
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:37:01 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399D9k9Y017510; Mon, 9 Oct 2023 07:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Yw7fcRxpYZ9J6oJGkqyxkI3QVgfoAONYTfjVOGanx
 Vc=; b=DvADUsKTHd5A6fIRvaEnGJV1lrGW0ITAuD7Rq1eQ5A+AJvM+3fVPihQUR
 /78UMKj7TRGL2hqHVP5mNdkZhPvqPp2afKa1cNbeuCh5AAWo9epn0WhGMq6S5ckn
 rR7oL2RE1wUilBiFjtLYiMwclp0kyCueLzaju1bpiB4cdRrYrzoLmChGZHk1jsSZ
 vljeXuR+RTMkkQn7W7gx6Btoxi2qYAXW+ukLpMfrQYAT8bGUZxCsu8xt3TgIoAlz
 QcJ6EP1g0dch9NhqaNgdUiH5BEYrvZR3SCuSBAC+HPE++yh4BiSEeMh8QCkvPErT
 mRoBgXyDlkxnUjDP+akW18WWW2vow==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhu4jsx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBjjFN7S5GWFWra8G2LlrEFG1HRVFq58po+fzFamZQ046gy/kCFdK/Fk+MK/J+8H2VHX+oXKrpgMWUqGrPKpMxFkXEJxV9xABQYH/JlE976/nVHf4Rjp0h/RnuwTweHyk6zfgHBn0M55ywb6Y+lUjvk6idadqjXEUtN+1Lm8rB5mkFer66RTR6ChjK/ggY2Y1t4Xz7GXnRX/6FHt4K7iKYJk+UxNC+ZpFwS4QM6Q2bS/4q6vpxzZkjzE3AYzYSuR9bGyaQGpY+O/YPMuHTLRzudOORbKQRlMjHH9z8eV6KIhdf8ugRkvI9UEr3KjWRExaApSfywYCI+mTxW2p/V+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw7fcRxpYZ9J6oJGkqyxkI3QVgfoAONYTfjVOGanxVc=;
 b=NpxaaUQ8AJ4qBt/3El1hBHQbkaFQJoqGY1McOAYwM05zQkZpVTbdiYuN4l8jnXvI89OMzqSfORyiw+6T2pLrrvzYidzggGhLXHqXdumGAfJ8ZOkV8T7POgtazrQccQIc2VEglNUoZuNFcfYDyxPe5QqTezjlEMQzd3NKq9MwyHBYg+dLiEcnt1AQCsDLm9fmvu2tPZpzUQS2bqY20ckzz2mNeUDemd2qaNdXzUiw4WJAN8Iy7gwZRGdumPqa95NtJWpXxQhrr1MvevSZpWWLXXw5OHdXfQ4dMaECLisjk6LuZb19zWBT/EPd1bBFMP3Q9zmx2KK1s5/mitijv5uZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw7fcRxpYZ9J6oJGkqyxkI3QVgfoAONYTfjVOGanxVc=;
 b=apmptP5Qhv1/7OEvo5aHCSY/Q6NDUg0qoMdLF9suqIfu7GrGS+PAtgWitiZqaXwEqJH4A94zNyrc/YO29x2VTgnH+Tk4A0cqrRMAYwS3nG/y0scD6481henac67GPkN/3Eh+I+MvmVFpFu7lyvyxsDjA/jfYFzRNcxFiY28YVMD8NVeQTByR5iUQerVQbwJdkQa/ZVqbnowoU6/L4zw0Zgqwle+A0eRWMzTsu0cvpI0YkBXRH+HKgvrIlR48SUihYz4pBTNtWrN0PDKZQiUyIJ0MFrFpgqglP+k980TwEUaXH7wcu8g86iREvmgSHukZHqPZ5WtLaE0uqRntEAeIvQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:56 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:56 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Date: Mon,  9 Oct 2023 14:36:13 +0000
Message-Id: <20231009143615.86825-9-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231009143615.86825-1-het.gala@nutanix.com>
References: <20231009143615.86825-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2a29b9-08cc-4ab6-6b58-08dbc8d52ff8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRl9lpUPlZQJue1msb+JnSPhcZL8bXUvJKN6Tz/94cGoqu//DW38ofRiS9Uj3LnwmKcT2nRi1HKqLVf2YMSHD84N+det7ByCMTZjyhey48CJpbvgXTfHfNFfyMW0JFvHXFPo6xg4ippCkbTPyzNqxk7BD2So2xvguJjxzOqGFEczZD/PFBZc3I1TAwiHzs/Dotw7ESDdvveMd+gZnFKVBJPeg4akAFC1DSaDSAbnIeJZz2u6F6NSM41F4tD9BXpbc5aMH7uc4RHudRZj7gJy3PbujhYi/bF5rmchAHgX0SH52saaEL1fe6PIcon/qTSfM3dwNTyXteaB4cnq+Qnimt0nKLEEUd47T5k02tAF4RF9arPuV+1nG7IYBsQtSYoTkrPgcwJbrJ+RjZ4dW8X6uiYzDGJv4YfXE/mekhfY8vItq6am0Nnpezz6D0gSbpWS0PZIcv26UclqMJc3wjcTdxizYenHbgcnIHieUQ5F5y5HX7EnbO6xXco6EDRzQ0T+saB+vgz5VQE9jp6PEvOzwgzRcaN5gMXVYh5Q3vYLO4xLd4mdHwchHAhavcU3swAZUUA8l+cLLAjlEprR/dsQrxJXJ6iRrerhpMNusxnkqWASYaSF1maGtZbiVdV8n7d/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g85EvweBomLvUviR29zP1q76jjy5fV8fDO9SWWSesE2Rp6VRqWAodlMDM+cs?=
 =?us-ascii?Q?KJb9+swJtyj7qeH8BXv/fzY4UxM0p5ThqXoP+hT8KOI9UjBxXn9Qlky9TiuG?=
 =?us-ascii?Q?XtuaJTRtlw+MnSkG9gJuGEwcTUuY4e+xpZsjOFc45ULE86YbYvpgHBkID6h9?=
 =?us-ascii?Q?1H07okdKXdd1wBiLi4Z+oteyB0d7gEXKSiD7rCVCoOPKtFvRuzPXJSg4eULa?=
 =?us-ascii?Q?qCfgpskXERNxCfTPEhzma6Q6dEnC/r5FKfd5OpOMUQPChqiDH1fN5ReWFbri?=
 =?us-ascii?Q?G4cFfYrxe6VI1qeSYBqwYl8wXi5hzViJObDvHatc2/OcwGee/9XDRSYouXfr?=
 =?us-ascii?Q?QCaPycFu1b1LLE+d3YoKJmYGAOzRsk9Dk8uD/2ayvReRQNvk6GJ1Vqs9mnT2?=
 =?us-ascii?Q?115slh4syKy71Kxwod17G9Nw3ZOoRfejW4DYCXP3swI44SZ32Lv6PubidFm5?=
 =?us-ascii?Q?0IwJFMvYv3ZdRnNk23aoLHMPkm5sENjKCPhgLltzUb1jdK1nuaU6jW/9Nvzb?=
 =?us-ascii?Q?RttWNaAVBB3kRvQoARFJwgF4/iDaaD2//O+7Xgm9tEmxNWjHfguAwfGNPk9n?=
 =?us-ascii?Q?ajfXEXQ1EcAPRpbx95/wcCenBfcGgS2aqFkkQ397LCvw42rIlLXxJlAyi//T?=
 =?us-ascii?Q?TQ2woFQ+hRLz7WzR/CEDROwkC/xOlcDQyAcN8uapg+5x2Ee9P8ZGRCAqU/O3?=
 =?us-ascii?Q?l0KgypvjG8OLSmYfvQZLIfaYVbpmQiTkIUwoXTirL9WvdYxNBnTNxzJ77UWt?=
 =?us-ascii?Q?qZJ/n2rFhXyheNYFufIkANs4wznsgwHch8uKSxPT6IDJy+fxSW8MLxgsv/gw?=
 =?us-ascii?Q?UIO/UyOfGw50lj/gIovObjCuf9LU9vya2G7ZTrLs8vtWXTv97XISNyc10wNB?=
 =?us-ascii?Q?+oEzBDRTeYisGZoDjHZX+/7zSXvcVYwUx+YDdNrgy4SQbXb7V9BTvt1q9Gis?=
 =?us-ascii?Q?ERk1yf+/nkg7qGWu2+UbORgKNJL4npB+C9Sst7Al1FfDImF6Q7Vdw91vvSiB?=
 =?us-ascii?Q?aXKqcewOkjS/6xpwlAqp25RxwnN3P9hfyBiY8i+7kGE2BvlhCN94DOuzSV/d?=
 =?us-ascii?Q?HDxnS57zXjTpcSM45Ld/h1sM54YgltQgWu3nU/ed2aYsAQKwiHhqmBwuRcIX?=
 =?us-ascii?Q?YWgn8LQBSWxc1MRG+6/5+NLZ1pvdKrHpUjawhnt3kCZ63EbhIrj5Vj1pEbeM?=
 =?us-ascii?Q?WLFUZo2V/UJncA+cUO47e10O5UTYw8zoWsFVjQE9pnuoO3L5zTOks5XOyOjK?=
 =?us-ascii?Q?ru1pO0eucv1wRBTCJod+rzha0prLm8JkcgRWYjTMSezypeaOKnYQLvwJQfJ+?=
 =?us-ascii?Q?RrdQln/+FWZEoFasogOyUMUCPyY0Ku80wxr8c+0j4xW4cHZQZVZ4nzn6ao0y?=
 =?us-ascii?Q?riVnUESQZTreXx0PO3ra1KikdnR9Eeaex3qHBNEgOOAjQqXAJiQOwZ/GNDKZ?=
 =?us-ascii?Q?1mESeHlYANG7au4c7LzbP6J4auqaiIMysxlVzMu04Bfmdj7Ite8+4sddQz/E?=
 =?us-ascii?Q?0W28+JPk0gW/Bdzw3dLdG4DtxgQwFdoaxnzq6hTzcOc2+5N4jnNGItPmKpfZ?=
 =?us-ascii?Q?4MD4Gqk8HBGw2t1pcIc+GhtP5vvPj0MbuqF+3h5idRYvt9qNC3nLIAhHMvGH?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a29b9-08cc-4ab6-6b58-08dbc8d52ff8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:56.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwpcIcDQQ6A2nKmzmxKvsL7MYif55DabUfx9y3aZjKZywCcgv4DL8bVUM+5XjU3/fbVL0NufmoZyyOF/8lltgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-ORIG-GUID: eg6uuh-CEHDZAFgb9jXPjdidTo85baP7
X-Proofpoint-GUID: eg6uuh-CEHDZAFgb9jXPjdidTo85baP7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for qmp migration.

For current series, limit the size of MigrateChannelList
to single element (single interface) as runtime check.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/migration.c | 95 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 23c3a1079f..ff04728b33 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -433,9 +433,10 @@ void migrate_add_address(SocketAddress *address)
 }
 
 static bool migrate_uri_parse(const char *uri,
-                              MigrationAddress **channel,
+                              MigrationChannel **channel,
                               Error **errp)
 {
+    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
     SocketAddress *saddr = NULL;
     InetSocketAddress *isock = &addr->u.rdma;
@@ -473,7 +474,9 @@ static bool migrate_uri_parse(const char *uri,
         return false;
     }
 
-    *channel = g_steal_pointer(&addr);
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = g_steal_pointer (&addr);
+    *channel = g_steal_pointer (&val);
     return true;
 }
 
@@ -482,41 +485,44 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           Error **errp)
 {
     const char *p = NULL;
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate-incoming' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-
-    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -525,11 +531,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             fd_start_incoming_migration(saddr->u.fd.str, errp);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_incoming_migration(&channel->u.rdma, errp);
-#endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_incoming_migration(channel->u.exec.args, errp);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_incoming_migration(&addr->u.rdma, errp);
+ #endif
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(addr->u.exec.args, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1756,35 +1762,38 @@ void qmp_migrate(const char *uri, bool has_channels,
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     const char *p = NULL;
-    g_autoptr(MigrationAddress) channel = NULL;
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
 
     /*
      * Having preliminary checks for uri and channel
      */
-    if (has_channels) {
-        error_setg(errp, "'channels' argument should not be set yet.");
-        return;
-    }
-
     if (uri && has_channels) {
         error_setg(errp, "'uri' and 'channels' arguments are mutually "
                    "exclusive; exactly one of the two should be present in "
                    "'migrate' qmp command ");
         return;
-    }
-
-    if (!uri && !has_channels) {
+    } else if (channels) {
+        /* To verify that Migrate channel list has only item */
+        if (channels->next) {
+            error_setg(errp, "Channel list has more than one entries");
+            return;
+        }
+        channel = channels->value;
+    } else if (uri) {
+        /* caller uses the old URI syntax */
+        if (!migrate_uri_parse(uri, &channel, errp)) {
+            return;
+        }
+    } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-
-    if (!migrate_uri_parse(uri, &channel, errp)) {
-        return;
-    }
+    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
-    if (!migration_channels_and_transport_compatible(channel, errp)) {
+    if (!migration_channels_and_transport_compatible(addr, errp)) {
         return;
     }
 
@@ -1801,8 +1810,8 @@ void qmp_migrate(const char *uri, bool has_channels,
         }
     }
 
-    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
-        SocketAddress *saddr = &channel->u.socket;
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
             saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
             saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
@@ -1811,11 +1820,11 @@ void qmp_migrate(const char *uri, bool has_channels,
             fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
         }
 #ifdef CONFIG_RDMA
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
-        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
+        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
 #endif
-    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
-        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
+    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
-- 
2.22.3


