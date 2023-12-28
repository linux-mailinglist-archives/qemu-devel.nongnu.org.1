Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8781F673
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:45:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImu3-00088q-HG; Thu, 28 Dec 2023 04:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu0-00088X-Rf; Thu, 28 Dec 2023 04:42:09 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImty-0008GX-AK; Thu, 28 Dec 2023 04:42:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmS21Gk2w4SF7h93nssxeai8oZMCq0JPRXC5H848HSVNUk+NfzBKXKamX7MJbcO0VBqn3F/i9KAN8mLojxjOuXU61KHRP7W1O4hjxsdFv1xbvpswpfi8FCEulBIRVoTCltaQEzmv2Lr3Jnm1uFjwJqWCjMbGLYA19r9nzDyxjILpwSwtPHgsXG2ymcNzfNpX/guSlVLtmEcjwnJmnuJO8lUHbrswu7bCuT9+3yjntPzqk1uGivd7SQj2oUL+JYYb31Lors4QwMpnkW8n+Y2p/tWFsHUQrRR/+ru6sRwtW5FxCbH/wOGgkTTkEt1qDXNqh7SIzV+P1s4Mv/NJPv5hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=nAMShe4/u4UVTa0qoJfK0+6bqfO58T29cnBORm/2TAJI1m+0JgRRQNvxbtBQ8VIgSX8rGJuAcMnwAXq5IZBbu04Z53KOhlZJblawPO0ee3sqO6MNT28IWOeZjF8dEFio1BfzdlOSalevyYyU8Ellp7MMG3S3xNUdP/QaqzJmUS8dX1LsFPhd8zGurPsYFUWmDAcHzfftVviofLAnG4ZVaQDSbMkJocMJw5DQbEzHAs8tajAC1NEUSUZE+4UKwji9dIR+Rwx6o+Xu57s5GHyzzQCSNRS2M+ANl+F90dCeBbvEU/mIx0NHx8Ng4RyfLxQpD/N4/7Qd/QgSFSXaJxvVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGM8R+1YhTFUzcMeWgYcDxrj2klo3PteoKf3LFzL1k=;
 b=ntCGvhgTB7X+SmdusQilk/lkckfOqj8XXrz+XQBg6Zuof2XYh7lRh7VsGQUbdH4gc9qqKbNowHvy3gCQEB2VfsIkTF58DY/fDhMQ304NuMfaeUGMXkbHW7cf24xugGzawdvm2nfJvy+f6BBfGg2OQndMK9yoKYEjqO4qBBoNQC82jRp9bWmHGMfSiOdy1flspyjW/4BMGwX5gOczJvgwuZiAx3EObflkrzquU9LDX/Tbj7u2YxISlBeCHR/JBlKjfkKCNhRBNfkbgDaXo0+6NQjKruQJdte77pbdeM3HY2hol9O+5f86arU8OFo5bm/ErkUo+qoGDp4uD53CZ61RfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8969.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:00 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:00 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 02/21] parallels: Move inactivation code to a separate function
Date: Thu, 28 Dec 2023 10:41:34 +0100
Message-Id: <20231228094153.370291-2-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2013eb-eae3-4f50-3a35-08dc07893d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tC+/GW4kEDKfD/am7b1HERL4aBDYGc0k4aIHKVAqmIWYqoOCXjX59I385nkWUiG0Ivgui+Z0wSPPa52aRkpilgJjXciYk5LHBm3ZAa5yGq2TUhpFKx0oUeHrVg/EkHVaMkxQHsqhDAC699oSYJQ/cVQc71EEOdfWni/OM4E631Uq7SKoBs3YmF0zrAcM1YDwvNddzleYM+Z7zGEBwctrxbdFxKvs6AnE4HmzwkRzh/PlxF+LGWGG7HpH3B91qJuLjKRfZLE8CY9gb3gaNERwR8u5nqMVvL8Z4VhX6IhkLndRqe733D8SR3KjjTR4c1rQTGFUxe+Y6TA/qPt7gKNLTOS8rOymIUlqIP0onFczGEE3RqTwVQAwhJj5whm0sFsSg8eViWOFJDmAC41TNcpiKukZcXiiM+mi42K2j5JQ8BvDZYN/gsRGjS2BCDt8FTScyHMcTH3s+mNntXvJKH9o2Sb4Z1g4LipjrkoreGfPczJCEUnocfR2futAjRfxBNoPx80hlrdeihouZbBQdwY0eaU+16VdYFP9ugdp8MyyYSX7f7s0JFELVVuhoFdwcpcZqlfj1Q1trOQKwksE/rXDnz4OVxws+ZT7Q3xdfk8EClrSfIxWintNDJIw3kjc4WP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(1076003)(26005)(38350700005)(38100700002)(83380400001)(36756003)(44832011)(66476007)(66556008)(6916009)(4326008)(66946007)(86362001)(6486002)(8936002)(8676002)(316002)(6666004)(41300700001)(6506007)(6512007)(2906002)(478600001)(5660300002)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o2OsSii3bssajgNyah+trbtvnj4mnP0h6AeWZPLm+KNJ5LIPIP/PR5aRmzq8?=
 =?us-ascii?Q?B9Awij66ahiufOQAOF1dOTt63gAAiWEhqS+E/XBJ9H9k+Fi/SqbOiwu5ZaK3?=
 =?us-ascii?Q?esp1T2N9JploFBhUYPwHhSO5hl9Biuo6TLb9OnL/xbSgJoRBFsZ789gPefK5?=
 =?us-ascii?Q?/f6DdRTtvKXiat3h2OdZmGeMzK9zLQBq9dBJ0VTBKaP+R/gYj+Kue1FAgrDg?=
 =?us-ascii?Q?4IU8CdWGju/bG7Czm+YQ0uBwV73LrfGgCfGsSFvd2DYZs4UYcoP+NvQ4eNp4?=
 =?us-ascii?Q?EgutWSExfHHI4Cgi2sjuE/N2jXoUlaRLItsPdxfufXwGozk9Ebc36MN/HYR+?=
 =?us-ascii?Q?khQV90pjelnNr8+UBacwXsq/AEi5pNHd/T80sD+LsJtAM6G4mvejTtI2lYPa?=
 =?us-ascii?Q?mJTDJSrVc+a2RvF3w/df4qtAMEerIzhLO9xIrMtfrmXMmPLGA9KnnUH+WId0?=
 =?us-ascii?Q?8VQBXw4gy/s+zC4zDMvDX+pXbk06WwkSb9FN0epSLTL4Q1Plr3sot6xZSrtp?=
 =?us-ascii?Q?ZZDOINhPPBjZlhnlt/6DGhV+rF7g4EgqwTNvFW5/X3D+0vDs4C4XEDtH1IFX?=
 =?us-ascii?Q?uEkLyKmJI9PAjRtxoscsWfMy4ssDW30mLpmjUl1GmOgG5iy3Xf1L6agFAo6h?=
 =?us-ascii?Q?yAi+6raNYKYU1wsP2xxvZ/w6NbVmLlJrHTLi4Zwp9DhEUtXshN584Bo2GOig?=
 =?us-ascii?Q?u6u+IM0ALOsQp8ZwjwmcN6tCmXN5pLfqKWBxXMzB8JgdkYFbnOoeBGkMHLkI?=
 =?us-ascii?Q?QgZ2NF+Z4M/bn0bUso4wfdoEs7PoHoaRDRfyVZ62q3262ktLcIeVi+6q9YSP?=
 =?us-ascii?Q?v3ti9mRVxX7b3+dMohM6dGsZBYHy6QutYUpSH3suguwQH/tqkqQ3LaEOxzVk?=
 =?us-ascii?Q?49oKnpacb0VUdSkhWq/fw3eCJqn6TzHxoVYjFgKh4verxdqnZK4FN8QOcYBE?=
 =?us-ascii?Q?e1CxWDxVrHUsqeqU1q0LM8aCtRRTj/P5QFlf3IVwzez4DsbZdG/NkmDjWtaH?=
 =?us-ascii?Q?egSuIxqiedOgP5lEcJMyChHPGqQPg3+PVUpflvabIW3vjFM0AUv2ZPIuVjue?=
 =?us-ascii?Q?yGD9MIsJO9pm98umuwMfOark33OLHRMMvcfF6A1jIe2ovea5ryQlHE38FLMI?=
 =?us-ascii?Q?9Jx6GNXyhBmWd9pllHs+to4A/eCiQgI5lSNnZlIErEU/PwYGiyNOw2PntTSy?=
 =?us-ascii?Q?hSAWY5czyaYflZS9Ml3mBUEBeoGpoiOC/BkTtA33fepeH+om1AcOCpoRt8Dz?=
 =?us-ascii?Q?3NbHmIqrmcllBM9cp/pO60zmiyIpMsz5gIewdQuOhZI1pz4f5U6zAWpRHP65?=
 =?us-ascii?Q?AV/wrnSHT1XHki0p3462suWYBUefCte1gpS4qzuD1OkKL3kqhI/JObexd8fI?=
 =?us-ascii?Q?Bwm0eFDKx1chMLXkVIu1ZqxKNnteimronXFkQLuIwPxDQAQUgIAg4eHVHm+v?=
 =?us-ascii?Q?8PU/Q0CQewPaPVvwH6W7APNzD4+9PNQDvZUgK6jQgbe7uAZhY3+gbfx1GlUz?=
 =?us-ascii?Q?2FZh6+pDEiM097H3TVbPXswqgAzWSbEKxpUlmeYaZ65orVTZb+G5KZ6z9ZVZ?=
 =?us-ascii?Q?Zuo3wbbI8RN7utv+TnJBXpv8jeVyDAuF1bmaIXQhcw0q3xek0pNd6pS4FgCg?=
 =?us-ascii?Q?Xj0Wpm9iqOoXDIHIpzL1rm4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2013eb-eae3-4f50-3a35-08dc07893d7c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:00.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX1AD+LxgUtQ/Pvigp83WENmgeHV7RXRzdqzjLjrxp7LWIVULzBF7uA7pA+WxIbp+tzrk8oS4REnr3+6YEH/wj2myAwm+57zijvfartEwuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8969
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

We are going to add parallels image extensions storage and need a separate
function for inactivation code.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 072b1efd78..992362ce29 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1424,6 +1424,20 @@ fail:
     return ret;
 }
 
+static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int ret;
+
+    s->header->inuse = 0;
+    parallels_update_header(bs);
+
+    /* errors are ignored, so we might as well pass exact=true */
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
+                        PREALLOC_MODE_OFF, 0, NULL);
+
+    return ret;
+}
 
 static void parallels_close(BlockDriverState *bs)
 {
@@ -1432,12 +1446,7 @@ static void parallels_close(BlockDriverState *bs)
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
-
-        /* errors are ignored, so we might as well pass exact=true */
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                      PREALLOC_MODE_OFF, 0, NULL);
+        parallels_inactivate(bs);
     }
 
     parallels_free_used_bitmap(bs);
@@ -1476,6 +1485,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_check              = parallels_co_check,
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
+    .bdrv_inactivate            = parallels_inactivate,
 };
 
 static void bdrv_parallels_init(void)
-- 
2.40.1


