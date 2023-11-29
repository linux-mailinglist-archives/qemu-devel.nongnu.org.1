Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4A7FD05A
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 09:08:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8Fai-00043V-S0; Wed, 29 Nov 2023 03:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8Fag-00041V-Jn
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 03:06:38 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1r8Fae-0005c4-3F
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 03:06:38 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3AT2GRjt011333; Wed, 29 Nov 2023 00:06:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=dTSSt3Ya8mG
 hUdgvZgk7WWaEa2F/cEQtN7JCKXP2lzM=; b=Zf4GCYMR/f/BrMNFPEhYyFiqEJT
 JG1qB35XuhHI1nGi0b9MGG3aCpD7gW3h+MkMIdUCb9w0sCfkLL8gtEnmAZMvKFSZ
 mzd/hDrQJroZrXjSbflra3sXuNpIHINt6AoEvirnVvIBh6W6PVPSXeuXGt8eE7en
 tzjDTrdfFMbV/Q7md/pPJIJGUvYMW8ut3VAULQG4uqluFbBCtmSUwZxQv5uOQCl4
 +0iAcFkqJOfr1i+HJDcfbIfG5jywibsFwnN8jgK9f/NsE2kvrk5xznDgI0/BB8Hk
 uTj8E0Vp1pAlor9C+x9E0fQ8z1YoQ6G2+x+Y6LNVrgVEUZW8VyxaLy/UEaw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3unvc8rewy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Nov 2023 00:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaqWF98bw3//0/gsSrUobZohIo0TYvx7FS6tiyyjzS4B258XvKM4GpCmp8Xxbe2g17zmka0O0MbJNuLzu919VDjER2cDDYf60K8LNgrDyAu3npblXp0DX8zOg7hccb/d9Km5ULTnvIwbN5s8P2+42/BGPb836nADHJKF7vkVowHaoxxex+FwKPLCjUq2uLDT/CZPtwDrBivY3ukjsV6OiREAPmD9G+ohxPt8YmB6js8nuux/9BDM+nWE+wq7ylhaWWvp6Gijwr3ggfzHlzEBcakshGWz9YQgU3ja5I+dZYxQOY5b4qSezsF4ZfL6JZDGR9crJhYOMdQr8jCGYuF+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTSSt3Ya8mGhUdgvZgk7WWaEa2F/cEQtN7JCKXP2lzM=;
 b=kI66dZCeAqNcJrya3yMGC+ZxsqitgvJE2DTZ3CeX+nZAANDfH7+IDT9JjxVr2RFFLzlPxJZsyVnkB9V//+cX5w5NWS74p+Fgme4tHZhB5boDdAhGx1zmpUPVoUMWcAXSj7eyZ7nN7gDzh/G63X/u/yz9hqhqh9MHoxmylpzrrZrjJsR4yeH5smT/nXwswfB0JJqmAJBY8/joyt1lVnDHtquU7rhz9rUPa4W7GKQLUJCYc8C7nH+OyMXQo5XesSc9ivYa768/wq5et2YUeEKgBBiLzJbs/GWKHYMHhZPvOcxTRZY87hnreBPFXLpbaI2twzPsxUY1b1pkDC7vNFthBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTSSt3Ya8mGhUdgvZgk7WWaEa2F/cEQtN7JCKXP2lzM=;
 b=iAQkqRdjh40NO5cMDjMiDD28vZNvO0AQAYxhcNWo1jfov2f+Vd6nLMDYihC5XN/eL87Sl3wpAFNszE0jOjZ7BHWFl6IKJNbx3+eRsmsrX+fWHoTUj3pO+4vCUu16v/3m2SjwPsma7c6HKy0Jg5qbEs6+bYEWrsdEPlxDk3TeWOe1VVzEqYR6JgULk86tuK0H8d2sl9TF830o8r4SvHPopUufXpmvb0w5KfGoCKQRrveskAIzadECMiziQBGWDoJE62AGWFeZCZaeJU/+Oe7XwFdKBpYW2g3WbIofr3Qp3Oc+EOO7F2g1JbNK+ap/oWfc2JUA16+LZdHNnA5a9R7e2A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB7390.namprd02.prod.outlook.com (2603:10b6:a03:29c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 08:06:30 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:06:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, farosas@suse.de, armbru@redhat.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3] migration: free 'channel' after its use in migration.c
Date: Wed, 29 Nov 2023 08:06:24 +0000
Message-Id: <20231129080624.161578-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: a23f6260-78bd-48d0-c00b-08dbf0b217d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFUqHavGsZHJUWACBAzK27gS3KhqvLpDJsAFupy0xggPDKnawJHzVEtKSZ8IlGywcyJbWkftDcMXk2Eu2VA7DrntQz2pcyAH6k0KNILs3IDy2eaK3hdTREQzctFF1QE5GxxOQRbFkig9GS5EjBAqqV5Iq2W5Dqs2L6JZY1T5wLiJDd0eco+IFqyGSJisWenof2D2LXqmPan7Xc/TULzs9L53YYmzB9HJuPjcAC9cdz3LFG5ZA6SAq/NiO3c4yU/Vd0hPRD2xkCdjH+9cCmFj+pjpxCp4X6WyufWYMdYyB8u8m+cmc2yLhdaCAq1T8WXdkryys+1PWGV7sROR9DW/Yik/ozWZ7Ef3mkHLLwPZCWQmK6qinmssrKyuyD2reXjDyq2yCtdo5IOo4+1aaVqpB1pqHjeIBDxnFG6qy0dH9OU155mW8+cg4hf1eZSVtqSwucSzwVjc2xKF9e8ydnJHJEyfyGGnHOgtLj0aw/UelFg24t+tgNZ9TPeD5yeySIvFMz7mBcHiNYMxZLIuomRAm6AMccaYNZ9zKqnsDmu7B5vPzHAn8DTooLSzSUCGTEx7IPBp2HpIulg4tMSPxb1bvlB8AgDtQ1GNj17PkRrl5UEECUYAse22ZXxL5OJBFxry
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6486002)(41300700001)(36756003)(83380400001)(38350700005)(316002)(6512007)(6916009)(66556008)(66946007)(478600001)(66476007)(6666004)(6506007)(107886003)(26005)(52116002)(2906002)(86362001)(1076003)(5660300002)(8936002)(8676002)(4326008)(44832011)(2616005)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNCjnSpnlhZ3rzJvUdlppqM20i46jOf8J7lCQoZOla9Xxl/i/svE9OQ763Lh?=
 =?us-ascii?Q?YD2+2x8SLdx9tIa/4MmuFymjpQr3KqdKxzrfetHtUmYZy1j3zdKdzZHy2DLd?=
 =?us-ascii?Q?HuVx0THf9nuR+43Uqp/QurBR/uN0ekeZEnpYRgC4qXEEJIGZ2n+pLM6K6ssa?=
 =?us-ascii?Q?EzjLVK9bteCgEhi6rGbO2fKXGLWRTiG/1JSgxhMUis3C57zCYfzOfhxW0der?=
 =?us-ascii?Q?dP6duenMftCbFIuJv+R9/jOL6evex234nRrF2p+f0HekI5iPkylqaC+inBSk?=
 =?us-ascii?Q?RF2pfjrQUqGRdX3XpS2N6kDG6IN0N6z8A5rsTf/0U4OSiys1uyn3F4wnJgtB?=
 =?us-ascii?Q?ZOg7vilcHnjZr7Rq9I6R877uDK5BdstWcBZhAEcuyMGD45dzkWHWt670LYIs?=
 =?us-ascii?Q?XKLWzc1rxX+ZjMEqODb5HY/694HfMvK5aZvCxngpcgw4qlLjk9AkcUSe458J?=
 =?us-ascii?Q?dlXJDa6ym91TuE7Mr2ew51Ddccm/vAo9IdmGYr+MKXPtzXctF6q6DlVvG6y6?=
 =?us-ascii?Q?4G0HjjEcYJRCBqP8Ue2TK7kThzl1IW7I7s4hb6TqXHrKbF042pM1nFfCA3qa?=
 =?us-ascii?Q?AHG6JhEmJkbKRvIPeQbN7dAEh6Pt1ndZHRi7QbYCy2h8K+FWHJHI44F7sirW?=
 =?us-ascii?Q?1ZvSZuihcM90GxXumc3N5K/ifTUn8HD1yh8DxhqkPmTWic6aTj7620An1DIg?=
 =?us-ascii?Q?Apv6bFkEyaMBeMgovwo/rvIvuXpOaJiFOYCb/ymg0HVtcLPyE2QyHqZd2AMw?=
 =?us-ascii?Q?XopX3y1hgdPXnZE7xuOCVYx64cGXlRK5A6gtAwjDhlcYFbwRdPhFORu0E/F2?=
 =?us-ascii?Q?1uGVie9MQ8N4/+/fis0NTKwZm9pjzD67Zwp6U92wf5DAL7tJzYa0TB6b5qi4?=
 =?us-ascii?Q?Dqwo2dzbc9iqetEaTz0kCAMjkQuS8xKCfVDxAQ1C9wweWB00xOUES27vWSpU?=
 =?us-ascii?Q?cLkQrrx2ftDQOnMLhQxIJFLQgFCEKdVo4uF7XF3cpPdv0zOyMza1pjVQ4fW2?=
 =?us-ascii?Q?mkPE76K3s4Zps9IA0y4NJIiEJ4R5HhKa5C5vxhfth5dgEv14qOgwwCLt8RKv?=
 =?us-ascii?Q?WLiI7Gc6pXHzvnMGtIWdif4O8VP+VxPC/VJv9ERdzyyof0K7jY0KV8AAnaRc?=
 =?us-ascii?Q?82CBJ8XnQ6IjQcYgThE38JGTGv6RQ45rkLaCEhC4Z/U6t9gOw1oq0wSU6zQV?=
 =?us-ascii?Q?hOFWZNyvXxo/XjF4kWbjGr4OTpMpVzGbJQeLjcuy3n+goolv1PmLbK73/dOl?=
 =?us-ascii?Q?/Xp74Sbik5Wls61ISnQKFgyNcJ67h/5x4mNvdZsZCQP01/jQMdfuR6rzFv0X?=
 =?us-ascii?Q?tkteWxu2VkOP1hJqp5z9WbYX/8pXS3PxJN93KpRu7XqyjRsyubMmN3TH+Y74?=
 =?us-ascii?Q?pSyt3R5VuBfT9PbuASajWI5lGxxZIMcvK93UZnGgD93m4eUfKFD2TiiiI8l2?=
 =?us-ascii?Q?qVDJT1vqddWRbTJQOfXg7DgYoHfokw8YEb8vp24s5qhAyTbms3271eVnmvPV?=
 =?us-ascii?Q?hKGIcZJ2OftQOKMF+o9FqPuJgE4wMkElxg9Kkvu+GLF9ged6rVV8QUkpsxSZ?=
 =?us-ascii?Q?A7Jgo3gp6SAeOl1+kZY4v2Yz8rQFElNKfoFT1yEZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23f6260-78bd-48d0-c00b-08dbf0b217d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:06:29.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqS1gj8SyRSGDq7IBCGT4gXINkl80Fl2xuBIOiGOFWZMG4ynPcN7G/F911EnwZ5gN9z9FSxxQq8qeiZT757ZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7390
X-Proofpoint-ORIG-GUID: Mazr-2NatyPTsi-kqdkhNh3laKIGPbd4
X-Proofpoint-GUID: Mazr-2NatyPTsi-kqdkhNh3laKIGPbd4
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

'channel' in qmp_migrate() and qmp_migrate_incoming() is not
auto-freed. migrate_uri_parse() allocates memory to 'channel' if
the user opts for old syntax - uri, which is leaked because there
is no code for freeing 'channel'.
So, free channel to avoid memory leak in case where 'channels'
is empty and uri parsing is required.
Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
migration flow")

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9068..34340f3440 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -515,7 +515,7 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
                                           MigrationChannelList *channels,
                                           Error **errp)
 {
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
@@ -533,18 +533,18 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate-incoming' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
@@ -1932,7 +1932,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    MigrationChannel *channel = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
 
     /*
@@ -1949,18 +1949,18 @@ void qmp_migrate(const char *uri, bool has_channels,
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
-        channel = channels->value;
+        addr = channels->value->addr;
     } else if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
+        addr = channel->addr;
     } else {
         error_setg(errp, "neither 'uri' or 'channels' argument are "
                    "specified in 'migrate' qmp command ");
         return;
     }
-    addr = channel->addr;
 
     /* transport mechanism not suitable for migration? */
     if (!migration_channels_and_transport_compatible(addr, errp)) {
-- 
2.22.3


