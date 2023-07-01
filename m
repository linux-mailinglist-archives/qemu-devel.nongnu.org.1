Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99564744864
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWf-0001au-LH; Sat, 01 Jul 2023 06:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWc-0001Y7-3R; Sat, 01 Jul 2023 06:08:18 -0400
Received: from mail-db5eur02on20710.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::710]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWa-00076b-Fn; Sat, 01 Jul 2023 06:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3zwyS+DobY+bhGSo7vV2sT5d5eN0MOrx2gfjmIV4O1NBR77bEfK22uC9X+5AQmsWArLSDDnAE5ita0FTO4ElIx01plhXp1LSV/loC6zrBysQ/x12QqUQULprWcxMHe1L976uU7fGOin3S/WSt+lOhOy8L8/QbfnBy6OZESiTi0FV3QfD/D1//yTcRur8B0k7LUeQP/U7NGhLE/oTNBDkCGSBYxaksnMhSAujh5WuNPKXPU9d5B3h5spv7dFLyWD7CO0i8Mg2G/GULRwIQ1fiqX37nW/EMZuRdesSZh8hW4MjEKJHPEe4gJyd7Nrqa4RIjgtxDRX9fDnxs9lttc/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuf7RnmcuBo2aUY6XCR3g+hut+RBVotOg18q+tJ6irg=;
 b=FrC3i7Vbn6SXJ5vyzOdSR/eDVSFpPGOYw38F0+dAVaY3k1LstwuV39soaK5D76a2OPKaR5eQ6SQ3igcc1M+jibai33gicuZ01ft6Y1qfu9vBaURSYO3ojyxS2U/mNj4nQmmz2INm/weXaVukeUCwonvTwrgpm++LoJGnU+5nv+frUdpapabdZiR9UaYkdjLMHEiIqO1uil1n+QBLB8vk3cINfQok6VVf599AD0WSUz9uOWBljaxdL0V6U7BTwwVMNmd/4iBdhG52EfdHMPv3WmrqK/dtnzeCEQFSvA40EbmTET2sKsTx70+Mq0AwwlshMpDhXDRJSfs1qIdB9D4YVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuf7RnmcuBo2aUY6XCR3g+hut+RBVotOg18q+tJ6irg=;
 b=ibkK0GIYfVqiwLwFGb6aAh12r9UGlebFuuh3p8JWN4i2sXwY5qNTDI0pGsmcGJ/Xk7MIcDHDM0+BgBe8dF1tuMIa0vipilfz7OdR/Q/mfNHrbGhrl3WQYhbVBBr1Pob2ePnzPO9PHbFrD3lFU7Kinox/bj2fdOsonlzMqWvI8t/9BLkqIvEFZmPn3pe1lLQm3NHwwetBuyOBJD2FkE4b5ccu570b6u7BwFPMyMtn5vd6Xhtzjlg5j7VTaj69p2lHVJ1vqfTcJUucBQJRzDtv27SMgCMb074dEGMtjA0AeUbCydLuILnIi6YNJ+e1hHfwkkuyl24h1QrTcpcZ3cDRJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:08 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:08 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 3/8] parallels: Add "explicit" argument to
 parallels_check_leak()
Date: Sat,  1 Jul 2023 12:07:54 +0200
Message-Id: <20230701100759.261007-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: fcae5f8c-0722-4851-3c1f-08db7a1b11ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4MwBigVYqmV60zKbDl5kyelRgl5kJ1qJaTa1BfOrnX9VGZutghRzaPOHYHYByCqca4I1NOUn58bzNgRBN4zww1+YBsr354IyqMsNZK3YmjIlF7IvkHJXs30VQd3wNXBFu5am4BVppROaPErhyRp7R2QOC8ag6zuRSsc5p6jX7m3hsF3a0IfE6gsb1q2DFO59JFcJK8E6UjQZoWjThBFLQdIFqFT9pjohY/5vna5TDzR6hYBQh7J5OXAsMycbFKz8DqaKctq1S94Vot0H4PTJV+n8tg+n+Utnu4vTiPstaARcNoQ3LMIubu7owW7cu1UZZBeWMTJMwyCWT0jFZGmk15EFaLR0ezaPUj1KZaPaVGIpWD9GUMOEm1w/UKXkDyClq6TScZUNf9X7A8F2Xb9JgdZ8VA5i6F1anOjH/mXCjpGHWKOAvmUtHCG2BXDEG1YbEtElCkDTqQSUvblSVgW8jkReyit5iuOK7Jk7twgGThDodYvyme4E/NheCP/wQd6gnm9Foz4YNaMFgEBatP+H9UlFyk4M7RgNFEz7Y4GRCrZhh6OLpGNPIXdyZnmZe4VqXswW0nFh/wGWDQmfj9/sf6NomFPIEMNuYpzxa61Wht9jAQ6ENXl/hKEN7uculrK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNOxjOF0D6/3EaduQbYoPDuP8gYLAViQyBsaVy807c8Xg8fWJROBRYJzSUEO?=
 =?us-ascii?Q?q3gaa+FoH3H/EPEkdl2unDvKBg2+5EFuUhVfOOKG1YuGfvJNHFCC5Quzgq/R?=
 =?us-ascii?Q?6Yiou2oB20MyXNOWi83I7njhQd+DU1FTEIH1WrnR+vRE5KNac5sRFyb/ZkCX?=
 =?us-ascii?Q?kSqu3czLCk7mk+Bl+NoqQ6d4TaqK/YjzPlguimHAHhZg8unk/MqeZc0n3nZI?=
 =?us-ascii?Q?yGNLlatTcfg45kyvgWsZTOL5/UJP/nS+23w+x0olgiP2jVNHAMAtWyJtijr5?=
 =?us-ascii?Q?qasXAiwB6ZzZULuu+rvjvKgXb4L5UOX3Ahyv5o4CVx1PsOrJCY5OKH4C8LDo?=
 =?us-ascii?Q?Cz4fsH3DK4Huu+6IhFPBvJu2ez/Y89g92ds4s1E4aJ9BhZwscOoQp+390tpN?=
 =?us-ascii?Q?yfXc8hyNG2p/dQ2+jifwsfjO1CGxjSQ0O3KQb8K+laioCET17CzfXN82kF2A?=
 =?us-ascii?Q?atgeR3AkX/U9lUsBjCOMy4craHNn4nyfnUctyQxb6mSciWtS8Yk6AhMYsfcR?=
 =?us-ascii?Q?EyXRGbxzsvgfwaD7jcuFlte4/YjyXYhYhWCMvFoOSeh+ESNGX5Ek34zjNGAd?=
 =?us-ascii?Q?VjHxadm7FapJV+8LBmk8LMdjx5LhRcQ8OaEMOB5bFHIAropxLOKyPxGzyJ8y?=
 =?us-ascii?Q?G4sboLZtRb3Xn1ag9GrT++2Bl/TI44tLW/27BxcJgdM605AViofpo1BGso37?=
 =?us-ascii?Q?9+wJkPus5AfftRChKmVmYYNjavyrPnY0gtRowHXwIPNxJrQgjEreMLqkt8/F?=
 =?us-ascii?Q?vIongiitBnvZKXTrkG9n8EWo725hOgtMNlrDp0qZRf/5TdQexRY6jZ5bAtX1?=
 =?us-ascii?Q?t2ICXKxheMUClgKgzeEswmd764LtJiqdryPSykuJrNC8l+sxW7FFKIaKZXRp?=
 =?us-ascii?Q?UZ/1ioQ8L0bWtl1MvQdeeBTsm/d+RFSSxkT/PVVD6PrPo7k8A9HZvzVD4a2g?=
 =?us-ascii?Q?4A7si2J5SRTL7zlxLz2kCGO4LVa/HdyMCm7hea+6RNGl2p0D0Xs0XuH693Jz?=
 =?us-ascii?Q?FXgkYDKLXsrf2X6ggE6EPGCzzavSkA3xHyBhuymlmRlkwH8W1/7qXsQIERLA?=
 =?us-ascii?Q?j6jEjFWeft0C12t7hr4LtCFwMKcVUyCCAKu2LeWnDxHVr9lcTy4dtQeJF6qC?=
 =?us-ascii?Q?aHR1PDp3wJv/f0iNZO7dJZke3icDQ0I4haGeooO8g3KBLonTuoENonO/dOhI?=
 =?us-ascii?Q?CXMhe/Y1lGBJCIt7SJ9nsR+vH7U2bOUTOh1ZmoBw4OirGR2GS8urMaazsCpk?=
 =?us-ascii?Q?vDUlRL/sTD6J68ResI/TPJsKjqmeGG6lETLj3/XArGX5CWG13syd4XOpuoCw?=
 =?us-ascii?Q?uuHox2boFq+zxqirlGYNfMq9IsJtq9I0mHQluaVaTfdw6fVbFO1z3nMD8V+W?=
 =?us-ascii?Q?w0d4LOoFqnmNRAmQycv0zN3PDI8/OGHc2Epbkdb7LlRzBbwjQdcjUjQqK+me?=
 =?us-ascii?Q?xN5IBgW0PgO5p1FseNSzLYlTIVN/8jm7fV63A9JFl2d8jFm3EUHBk8KkdhIc?=
 =?us-ascii?Q?ey5+LjqTFf+0cUW5mW/7bdtiHRHl4uOQ3kLAnkDgkyPkb03njv/2uEhBeMCq?=
 =?us-ascii?Q?hrL038ff0fwd0Nf3DvndZJyo4nX+MX4ztFOucUs3Qd4l2W/Kl57hd7HYB+F5?=
 =?us-ascii?Q?t65Iy7VDPG95/PkGymz82bU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcae5f8c-0722-4851-3c1f-08db7a1b11ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:08.2998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXxrt5rbXlli4llZwEkup4mmD558oJwu47gwnsgZOu7UITvPkWO4SI1bOthlSXlIEgvge0KSdjqkMAyvllsr377qD1bi7Hrz6ZJ6C9HjO1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::710;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

In the on of the next patches we need to repair leaks without changing
leaks and leaks_fixed info in res. Also we don't want to print any warning
about leaks. Add "explicit" argument to skip info changing if the argument
is false.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 40a26908db..3cff25e3a4 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -484,7 +484,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
-                     BdrvCheckMode fix)
+                     BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t size;
@@ -499,10 +499,13 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     if (size > res->image_end_offset) {
         int64_t count;
         count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-        fprintf(stderr, "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
+        if (explicit) {
+            fprintf(stderr,
+                    "%s space leaked at the end of the image %" PRId64 "\n",
+                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                    size - res->image_end_offset);
+            res->leaks += count;
+        }
         if (fix & BDRV_FIX_LEAKS) {
             Error *local_err = NULL;
 
@@ -517,7 +520,9 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
-            res->leaks_fixed += count;
+            if (explicit) {
+                res->leaks_fixed += count;
+            }
         }
     }
 
@@ -570,7 +575,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
             return ret;
         }
 
-        ret = parallels_check_leak(bs, res, fix);
+        ret = parallels_check_leak(bs, res, fix, true);
         if (ret < 0) {
             return ret;
         }
-- 
2.34.1


