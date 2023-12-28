Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF8581F6BE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNr-0005J5-Kd; Thu, 28 Dec 2023 05:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNo-0005HU-Hj; Thu, 28 Dec 2023 05:12:56 -0500
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNm-0000ek-G8; Thu, 28 Dec 2023 05:12:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me7oDFEL2ed15Bri/naoK4KbIgEzMWTvBF4sRVPqGcbFQuvAJyjG4EqcLqTBHiQNZBLxkAaFjsxLeilAMyOxp/j0Zdqt+MoQ5+oF8UM6uezP92nxolVV7LNhjF+8gMW1xvinBRrSyTi1pipluzIhnJKr8mdVDq+g3X+NNc7M8EN4LiF6oTcBX5fPe8WrwaxUMBGCyEPSMAQEnIP7FYBNyDUUUwleovOnIK5KQLX0JtWe7rk0HBD1wWhKFuQ1tSvRpLouDDzfQyWtDVp1cwnRuonwXtF9px4vVD52qSlCbt+ieKiktCffm/tn/jQQLSb4QMW1jVW+NVs1/Sg6hiBwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZh0tPQajn5ZVC76nM9sowYGAr0ImIhqFCdVs8qjAjI=;
 b=DzfEaUYbOZvZxsqVnrFqshJC0m3pDr6UcsYUvRlXwX6e/tCjsU6jfNHqM9xXSXaQBRuQsWdG94BIuoiTEQC/e1LmO1Xn4LPlZtofU8SUmlhOm8HgMSMb9scnmcggUAf8QgG54xDpIm2gKS9ntx0d8XBeOhw0K43+8+QAiz2qt7HuxEMYsQyFahBvhaOQuKB21PZ2ryzb+0RyX64unU4DAna9sMxheIixVym+/+sFU48sA8xMsSru3zBVA9VYegbQzXT+va54D9emIYYQaU9U3jqIyGD1Hi3DRwCJ+5uU+XO05J76g9R5WqRFJ2cD3PnaQO/gXsMdxmFQQ4+/NwnweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZh0tPQajn5ZVC76nM9sowYGAr0ImIhqFCdVs8qjAjI=;
 b=qvqQ1ml9z4H8AxjsGkemeZ/tX3C5uDSSvaJhDxfbsAVni/ETC9gKhfW6MR5q1dqnMSZ4yTpyMxeLsPEODH1RKy2ASPRR8sG5cDDVTGwp+YSE+xCDLng/V6dxlOn2g9U0Us/q+2pnhorhOP/m2uYXfqA6uvHGJekleLnGgBTafPA0i5ZUEluzdbAc7OwOgeUXz6mkaBwqIJMMNabiKrHY7xPRQpKbaKK+JXCXbseMm7AED3+okabHRdQolIfcnGrRtg/geyfr7HMT63J8zsIpqq2iG2LVvaOUdxdaSDU/VmDcrfGESLnf/YupWsFGvzdD6Lg9VVIS/D02x1EPbwXsaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:49 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 16/21] parallels: Truncate images on the last used cluster
Date: Thu, 28 Dec 2023 11:12:27 +0100
Message-Id: <20231228101232.372142-17-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 752a0858-e54b-4930-5f5c-08dc078d8b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoUMxE94Zyz5TnRlxPCK56gx4AG3bkEVwYH/bhD8v4pgPpkMk41UndhaEoq/fQzJD2kT+QzEKZqNDWGdzgtIgLBnWRdoDsrkbkNP92j8BtIz6P1wzwKLjT/mgoXldnjheRhTMUj/vc26iV7TUq0MKzscBbVDBNe3CS7frN2zcdZqSzOP+C4zN0EQgcuzxeQaqmBRgV6Fdae1EOk3l86IL01FY9Fycfx7rDOpsMsTCcSYVUJBjUuOaBraSpP4vIWN7CRwOuCk/Yeu95qxvQTy2rQWGaajA7v5hXJDll0Xa6sVOhOJy349nQQnMYhyXUfZLu+5MtJhqZ1TWP/wX/cIvtSc7iE7YHWr7lP+1R9Ra7ho2UHnfEssDJ5d1nt9z1JTGSFP8qT9cZcKezESONBvGq95BKuiwL4MM/fKaR+IK44B3Fj1PYSRoXEEbp04B1m+In0+cca2rk3U+JM+12++n3jsBnvwdicwkevwk3ZAAwgjY2v5oBd78LImbxibd28eQXTSiGuJWowUykINcy/P7KZvdQVW+Hm5op30tewZXfIBcHO/HNkY62oqfEjRcN6Zj/n7G59A3nlvQr6QRbW47a8QnuoqwolxY01wlaPu4GW86bF7FHhDUdM6xL/Gs7u5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCm7fTrOCfSr0BUtrwh2bDT1yj8Vjp5t/RatLxmzAwxq3wvBumFXa7+uqHBf?=
 =?us-ascii?Q?qu3kCaIp64TwQoDwdERoDWfOcuTXZXHsQKzYBxXf3dlj8DW5RMVK4PXcA6tz?=
 =?us-ascii?Q?qQh+MvY6u5mfeOa2yf/wpEhDQseHq0680mzRyRvdrAkWlI4Fy/VkjFWesmsw?=
 =?us-ascii?Q?7IbB4XRhOxN4rFN1LpG8BMpxYXn2pz5merCZYaYvSZBVLopNsUsSIGQz7gDQ?=
 =?us-ascii?Q?ulDjoMeBWnMaZ4ehqhZL5GnSK3x4D4bE6nqNpgShPUJUSOpFA2feaJxppwXi?=
 =?us-ascii?Q?jV5Eb56qLKoUCPn9xb1KE759fDO2JDYLeeRLJA0wADiQINjwpM22kCdS3SZK?=
 =?us-ascii?Q?GgBxMuZAP7lubIfMabxPZpvmmmLTdR7qGSUDDCULh6GMQrZDohmhJNbJeVLT?=
 =?us-ascii?Q?+1wb0yNeZPawWAkkGNfmrV+ZtezLoZPOB3J77wZpqe+olQ5hSeZzGMG9x/f2?=
 =?us-ascii?Q?ndIp6Pb19ienZTPb6bl4CO4Vjs4887K5UgE/agYwI69ocptElZp2ppHi0f+R?=
 =?us-ascii?Q?lQXLO51Qdmac6reo28X6bfkCF0bG3jLJjf6KOUwDvz9W67AUNnXwGfQA64iz?=
 =?us-ascii?Q?iBy+snK6ZYlo5VSsf7MPnX4Fs3rZH/FRvt6BTiF6xDml71BWB5eNpbqEJtxb?=
 =?us-ascii?Q?3GP1rTTFFYsQvkaNRVKa1g8lEPTd3b9ik9W531Kulh5g4tNGSeJOAo6cJDqK?=
 =?us-ascii?Q?tFQyp/t4R/ErDjb6lQGkb6Ev6uC7lmg8LjahAH/e66G8IpnOZ71UswZD/bjF?=
 =?us-ascii?Q?be0vzSq7ngUApDtY6GLExndJ7qRiFPL8+2cD2tHZz9UCn1IxvNK1pTCI8tzO?=
 =?us-ascii?Q?J58h6wzQ28G2WOqFNh9wD79lhLU6itvrN7sPiADdyg+JRY9m7saWlV2Tb0Jl?=
 =?us-ascii?Q?IMFbEfWiCn+A14dEncoVg1M55lbZ4AqDUoapn8SjNz5BF0d2LKjGQqxo0prl?=
 =?us-ascii?Q?XdhTpqwZW1rF+CtDklKpEGW8B7fcoAVxzqQ+hnrf1/q2JkXw/ZCSUtuzFVKB?=
 =?us-ascii?Q?bxcUMLGb4fHdlBIbDzkM3rDx5Ftuo/HbOFsCFgk9OiiX2M46DyfQetreaMgU?=
 =?us-ascii?Q?z1BpITYbXVID3pkDSemm2QgelbDjoLMr3/i0nXXJoXHJvKGCwq8QJrlW25jQ?=
 =?us-ascii?Q?QhJEbDceivq6bpcO/pCLsd9yDewfpB22qSXm9SKARrsWeW9n/5cYT8JnTBxh?=
 =?us-ascii?Q?DbubL/urIFPOwukUFkDPHvRvakMlmYxXhvoMHOvtnPjiBraW/O+bhs7kfwA9?=
 =?us-ascii?Q?nPWdBy3yr+TaganchypLXGf1MvofBmuKBpetiSAx7JjPR2EbBwDyRatiwMnw?=
 =?us-ascii?Q?qBEKL3TnVhES+ZmnfIxhwThto5WUf+s2tIgIjB23cm5St0en4QzHh51MIRsE?=
 =?us-ascii?Q?0lUlnw/02V0nRPonDNlxfB5PxBFgUC59N4y3/dAKgA7hieEMr7iPHyoPxHAk?=
 =?us-ascii?Q?42YVdNStVze75/elywHNUO6MmDsz1x33uvUpRcx+MCY/mlQfFVJMogMvG5pU?=
 =?us-ascii?Q?/DJxLFXMZoJTxG9N5FmKKJyvZer7ohFyJOatLw6mRMCobroyOELHMmMe0P0X?=
 =?us-ascii?Q?SfqosAGDRsfUcCuDxU66Il8N1MsCSq1Sgvyetv4m4tI8AFi7g0yJv4U0MuVl?=
 =?us-ascii?Q?VJK9AForB4iGwtHKcstC/nQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752a0858-e54b-4930-5f5c-08dc078d8b6e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:49.3400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4JyA2eFX4NamxTxmtB02sGgzyJQnNTm4v/BQtpmHBKffiPzsIGjf4A7EkyVHHrJHQXIcD09TquImcU1fgy3eeHsRI0k+cfZnm65wiusJ/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On an image closing there can be unused clusters in the end of the image.
Truncate these clusters and update data_end field.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fb7bc5e555..136865d53e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1454,6 +1454,23 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint64_t end_off = 0;
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+}
+
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1471,8 +1488,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
-                        true, PREALLOC_MODE_OFF, 0, NULL);
+    ret = parallels_truncate_unused_clusters(bs);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.40.1


