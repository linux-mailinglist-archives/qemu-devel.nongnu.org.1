Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DDF81F65E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuE-0008Ca-04; Thu, 28 Dec 2023 04:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu7-0008BC-Jx; Thu, 28 Dec 2023 04:42:16 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu6-0008Gn-6d; Thu, 28 Dec 2023 04:42:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7BwzpXDGtbPmP/ERayZ5GT60o1IGXF4OdarvLOum470E7oMHJDdascuy9sno94gRNnLNvKz41SlbAWC7JY5P98vcoJ1eXTPB6yuTOVdZdJ3P9ndqHGF9ApkTG3dXjouZ6vdqEwHIeBGBOLUZBsA8ALL2djrNRqU3uyKuh1WFQuz7iQZGLXz6xpQY9f2VV81Ar0Lh8M0IRa32sbZj/oUXQIL0zoyy/IB83pehbW43Wsl72gI23CDqIBwaRIsTQpAWc3Omjv4SNaAN5s+UGr4U9Z45lwnmF0Pbad5HUSNZDG1OJHB2/W8lj+8BgtEo6KQ4R+zTmonhQ00ZEmnlkHX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTFvJZaRYxijrcCiOR6/WdsYJiwbnhEJy5neS3DPRI=;
 b=cIxtHcy8e5xyg3Eg/avhybpwD2u5KpHjDEwEWCIbSnMyoz8ZpCwaN9Pg2OJ67hNrs73Fq7m0u9BB07U6qM+9mMGIki6j5j7qko/A2XQIedf4qS+Po19jYDt5CKiQN1CDgheSFC7AW0wyqV3YH1MGjTMiuLywahv73RCzq5FGBOUvpQUIEmOIBeZG2OecBNc2W4plC2kW1dyE7DJH3gYZLyMrIDw0q5dDURZ/EAl0gh7kExoYOwygn/xY2lLYSuxDwOW0wPDAzVxUDkmkzX5EWPMfDOx3KH6e3FaumpZu8PK4+AUucO2Ft6ihC+cEiYQgo2BbnX01eKAi7RPjvr4PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTFvJZaRYxijrcCiOR6/WdsYJiwbnhEJy5neS3DPRI=;
 b=JmqQZQ8PD+TnHT/f/WfRODDELtwlUpdcRla9oCyHR39BLDdHVOKe41GtvEWY7n4RNsCR/gUwX5rQzdGyhyc+FqFZerRYDx1ikrN6tCDjGTUrO7GzI6KlHLxzAWbEMwaR1MCS45rgP8xWkVwTwdXW3W0xJXKx6THP3CPnPd5FE7IvKr2UCiJ756JqryslfHoioON5ee2e7bRQWrjs30Iv0/w7VmcYfxBAiXoQpcsb26ySauVExnItjK8hxwfTRThpHS/QlLuYXzPncdj2kWeRYx7106OJw+RTK/qfIGla7icC6AzdSQ0MyMxcTO5xhIi8M/gJx6fSee1qmmiVxEfLag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:03 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:03 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 09/21] parallels: Add a note about used bitmap in
 parallels_check_duplicate()
Date: Thu, 28 Dec 2023 10:41:41 +0100
Message-Id: <20231228094153.370291-9-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3743f3-8dc6-4099-1821-08dc07893f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60jJNOTgB6YS6qOKqPFiEeashz8PQ4baFwhptkhPfw/bc2rJ+cqJBHCObGzdWviob5/fhDSI65ptl7LqqGGsV/lntiDhkF/a7FFaPJr1XynNLewKrfABXrIqZtDXCE8tm/EW2NwoFdBrH3KtMC1jlwFHy2NX1lvFHATkf0OSx1Rwhw6qczapPtG9Wpka3uoQZj6kpPdeNyiQcP91Vqo3q3QoqMPlwuNXYyuR33quXi2b+hX/flhDxRRHtXdNcXWsnFJAjwSXY34sfAXbmKKEHQkWlL6MmjOAUNXLwzpY3HKtaTLlGtM2P4GLldteiFmmWEsOHuXXh2lcs8xTtjF9jXxauIr5R82HcIsxX9ADFfVkBhRjp60hDcLlq89+PbfXd+N3YYTJABjT1NLIJGr0gE/SeZINNPij71iCYjxSMYXIG5kUM7Bjosg+gB52XdijTJ5fhZg7I7+9RQvZ/nPy9JEaxYMBm1Rlm3zWxe1Uf5ZPnlyAuI0R/lBGAFmERF2oQ7/V2VLp2VN/zkGgqf6isJfog+llrUJOb0/75D9A2qrBDWrspYBjhq/E2HbqQ6D0sT8mqtILrBg3MMCwny78cCUoJUKCe1xYof7tQRdSz116J/xwSQkr84AO3hG8xP/m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pkucmxnLezJLZyPQKat0VoNrxqRj9BjmC+F3+ffI/dngkLcNS1b6htNc985G?=
 =?us-ascii?Q?oJghUHfV2Ig+lcKsnwuR0o9bt8BQFNe9PiVcSlr/SPYETPfT0fGPurASNHD6?=
 =?us-ascii?Q?E5+q4PcH9ltrsAUf1lZATJK4L+UUjtmEEtJqjuhjFSfRe5XhCCqzQS54qeqx?=
 =?us-ascii?Q?+DNoMgRKlttl/L4uHRkID6DZiJuJgL7OHvHQ3p/alDSDGaBvLsN2DIun0tDo?=
 =?us-ascii?Q?bExzgLaxShhlGuugmjQeEaLaIALJkKr89wBTxiKiorHe8VmaTD9S8efnXlc0?=
 =?us-ascii?Q?WQ8LtvYcXjEdB/Wvaelp0tuJHhDBmNf6f+td9WII1b4xOvbvdA4uo54E72Zs?=
 =?us-ascii?Q?8Cnf72Don9oRjMjifTzAGLC5Im9wKm+IYKKdoisC0kLSAH9T/UgbrzfBeoEV?=
 =?us-ascii?Q?etYpzcaAQeICnwqvaHmRnzaouPUApL6d8kbKnAAOZR2G/7CXsGHzuzk5EVnv?=
 =?us-ascii?Q?Avb+Xs/RpnyKOAobi8IjzbpREWJAe1U7XvPdlALfbYs1hunczff85JI7IH13?=
 =?us-ascii?Q?ZMF/r3leAVmNn3QbC4GNwz5Mu9QRuO1Sz9cZaew3Gs1QQ7W7t1yyOb2XXTnr?=
 =?us-ascii?Q?dApha0JjHOaV9zNLxVJmcjpOpVDlWdfXse+pkvyUqCy2czjJYEdEFuBnBnuV?=
 =?us-ascii?Q?5ScGP2WCgslJT9pwlK9QenGIjLUoD5+tPUijQ584COKcy1LTuRgZ06mLCanA?=
 =?us-ascii?Q?e3JtCsgLsQNgBFR388+hlizveBmqZOI24LvY+s1xqxrO6+B6dHW3ANPqXAS5?=
 =?us-ascii?Q?tV8/01mgiZE2W4huB69WwWAZ4mPMDiPFLgW3RX+YZanbV9J/8pB1n9BB2Ax1?=
 =?us-ascii?Q?E1bVMW9Hl4XSp+GzJFVGEPUDW/Pr+tWNGT4FlbtqPJThwJZ6Z3Klny2ckMHo?=
 =?us-ascii?Q?4b2CEhQoadKCf7cMFxN/r0P4rrSRMo2DctRoJiUclAm11NWNPM5d8Vt0lowU?=
 =?us-ascii?Q?lSWHhv5QFW8y8RG1knfclguJb3T1HkZJz7nnby17tn+4CU/ASkrcHmEj82ij?=
 =?us-ascii?Q?bUegyWxDC7/w6f2buAOIgRi8urMCCHcDcIr8OO6cHN3dw9m6oSlE5HOHJy7m?=
 =?us-ascii?Q?2nza5wvsAMBUQ5CdLTo84Xchm2n80ikoyBzOYwO/7RNZxCU8lSqcghHL2vPi?=
 =?us-ascii?Q?M/7QArjmLZfKEiNxw8IMvWxG/L+A9+UkPAAoerHM2T/j4dgmWySvfSvxJRHh?=
 =?us-ascii?Q?vE1t2vlVSzS5Wj/5yGZHcNqXoe7H6CSua+n6DrMg+4R3Wkf8se3Nort2piGy?=
 =?us-ascii?Q?flxw+NN41xhGTkY9ellzyjkcKnkMGECgKdmsVYN71l811U+IameYgbki0xWp?=
 =?us-ascii?Q?GerHFRtLMuxe6LTyF/6Col88Unu8I7s0eZrYPmH8uNcPjyffqkW11ZJ1NGXH?=
 =?us-ascii?Q?3CTI1gvumWKEuKOyEV3mKkAYn1eRd82qYX8WVJ0f550Ayr0lwW1TvVhLEzYD?=
 =?us-ascii?Q?WQMG/bOEsTxIOL2+BzeAYjXvrCdgSB6bJY0JvmnoybccDrLztDnLiCIdLwib?=
 =?us-ascii?Q?UOynBCYu6cZD+aAfZxNPgTUsmowexT6Ys4RIrk1BtJZC9u/961lsN5ddCw+l?=
 =?us-ascii?Q?iRO8CUM/7Izag+nW4RoMzMMRoR/0DwSbszXgdmrQLmM3G9g2wBL7x4CTmyj4?=
 =?us-ascii?Q?flAUmaGLpUQReps9M4BIpLU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3743f3-8dc6-4099-1821-08dc07893f1b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:03.1481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7uxrvRp8XrIhLQjpyeXuLmOaOJfZ92QnMSDl+u2hU1WBdMCCgcpB22XUkHFK7QazTxHay8mvRlyUzB49+L742dZxneCuDaxFBLhsW8ZEbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

In parallels_check_duplicate() We use a bitmap for duplication detection.
This bitmap is not related to used_bmap field in BDRVParallelsState. Add
a comment about it to avoid confusion.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 04c114f696..0ae06ec0b1 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -837,7 +837,10 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
     bool fixed = false;
 
     /*
-     * Create a bitmap of used clusters.
+     * Create a bitmap of used clusters. Please note that this bitmap is not
+     * related to used_bmap field in BDRVParallelsState and is created only for
+     * local usage.
+     *
      * If a bit is set, there is a BAT entry pointing to this cluster.
      * Loop through the BAT entries, check bits relevant to an entry offset.
      * If bit is set, this entry is duplicated. Otherwise set the bit.
-- 
2.40.1


