Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AD81F6BA
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOJ-0005Qj-4x; Thu, 28 Dec 2023 05:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNs-0005KK-UJ; Thu, 28 Dec 2023 05:13:00 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNp-0000Sp-8R; Thu, 28 Dec 2023 05:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBVpIVAR+Sod96ro6Y0zjeM2gsPJoY0/liSJJDp/5450lIwNdIsV8LkG840++Kiji6BpVpVEtliaH7NP34t2qSrZC6brB/Be5OV6mi+Ma8+LfksZE/BW/BFk1kslkRjLrmLn+I4KXO6JOSoMkJABKKvcUvMnrN9t9YKXE/Nxv9lKSNbcV+LgeUHvioY+FR06rCu4lBwPGZBvomtmKtvBM5DeahSl0RXfYv7Xb1LQCiuNWXzOnPtqwqD4FniGgttzk+UL4bbWhFgIsSGMHE1lBIpz8uOdaMMw6Xvj213NVaRgKb0OsM/WqlYICK9pC357Tmwn3f+qwBrAyZ6X8F+/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3dDAqfScSQKpORpASGRpyoVYYLjILjPhIDAhREH9GE=;
 b=c7I3jOiPgIHFF6WqR9PeQEQmRcoVwB85NvPSTBmm5VmlhA4ZXKbtBHICEYObrAuf6tnWjC9ZW/kcK3/sBEGVqGk5mS11pI9opi7WBTffksTVrnIHyCuX+BMQJbB84j8zhmQJlIe9feN4dBlhL2faE1Jnw5O85PyZlhpr0xYG5zU2hm2NT0d68/2Py3OkSpGqD2DAHnqlaqi23mDpZCrlbv4pwICDQhVyKhX3s2eK94i3FtjAfBI3rCNPNVsFsXJYliRV4phR2/sZE5EuuJVcGVv/h9Kv2zA+q+DoFad4KrVzEZf85Q/CqPLcOWfvSgsybeec3eZKMSOoBocTOsZ1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3dDAqfScSQKpORpASGRpyoVYYLjILjPhIDAhREH9GE=;
 b=NDiuYJ3PjqxKS8Zlan7ZS8ujUsKarutoZU+pA4IUzz7hkYvdBqL+QFyNnFP4YIOpdQFy9r6+Zp4NhUolJHqNEYgzPiZ1qTADTrNPPhUvbs4lBt3zyo8dglFc9fdy7pTvlD52kDxwrC/sdjiVxsg5fv592uJEarS8tl67SQ9QYC1h6/fECJIrtNzqKhmTaLqnQyhZV/DLjT5n3tHuG7Vf836AJgGa4a5nFSm/a1cIXZHbyfym1y6Q78QJ2c6cn4s+loigPpMg+fVc16VP/D4E6fr8qb23USulVwsFLTrTD1CLZvyST+5Q665dY5YKCNT4H+owz4nndivpJPWr5J/laA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:44 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 08/21] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Thu, 28 Dec 2023 11:12:19 +0100
Message-Id: <20231228101232.372142-9-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e355d3-f6f9-47b9-ed02-08dc078d885d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/apI52Y9SXbuPXFy+cQturjRYJL/XU9FFzOGInie2wDNkCh4iln/knAYXS+pfTLt9m3hgSB2G1IS1FRFS/Fuv7E0oUaHvq+6SkAvZYA+vGR2ecHgrBiXAKeSEsw8vWeyYUIMOFd7NRhUaS2S3kziE5euWDB/ZJTzjePjtjqyjLweE1+Y7Y8UYW9qWYE6/Ybg5rRTt6blqB5DFwKhWaLD9I3CcujnGPnjOMzVwAME07V/NMtgVufVin6spkkmCu1QG6Ii60AZEXTOjsVgxXfbYNlnIBRbZVNk5sI26M2BtSSp/uZqDDZBCjhyGr/q/ya4nK0TYGiPygadqW/GrE5pdrEQHxieFBOiMs9gwiiD57fuWfKc1tn9DNJgyFLYqHZE3VDW9esMFbrunV2wM0y7DUd6Jie16Fui5ddDNoRXr9Z+Ea5vvSl5T9hF15FNJkbKTe2OHluGA7uk+UdAmSi+qyeJXeGvHFCR9pwYptUxNxti2eH7efyq86yIunCo0fmNwtZRW5CfJiMDhel6UEOBxyagsg+Ns8X6hF+2qBsZjvHRnsJCwmlz6c++5VyVcHQhw+2gFw7AwkUIPnGKjUKs+Dr0gXQCyD/DrkyV3AO89+SXyPuKUVhQ72BNrblK2Yt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(4744005)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UCF0Ql9FglyNV/gl6rpgB3VcvCgzrHIjpew+8eGeDsLaBhNHXziizj9j6mx6?=
 =?us-ascii?Q?JXpbtowD28mMkiKOAcE12SScLAWYJnEGjSyvVjC62SbdmoMHLUkYztYwVt58?=
 =?us-ascii?Q?fYAx1HiKYfVzONzQBdMMsXL36iFNLALtQMxPthvak8tVa6K06oOHNKjcby64?=
 =?us-ascii?Q?EIXEuC9Wrw1bkzzuf2GVQUFs+p91teP+iUNWU1pVXSBb0JJgM40VWtnoi/80?=
 =?us-ascii?Q?IOFKXteq0KS35nHzgA34UKLdMsY7Pg3pCRxF3K0udqKQxqy1lLYbBT/v5KGY?=
 =?us-ascii?Q?qH3oDXJFzfo6psUuBcVbEyL01JUyvbnk6NNZmjeHcd8zTlEq6A63v+pLe2fL?=
 =?us-ascii?Q?8COcZ2ideeM0SlMsk/GtCAc5/bU0jQ2+CKnQxc84uMy6lKv9XRR3luTdr5BT?=
 =?us-ascii?Q?/eASAPuMToYGo91/ajUoDm7Ym4AAOEvC7DNM0CYvdE9RJnXd2GHP7+t/OFWC?=
 =?us-ascii?Q?+VKJ7SJXMy+ICChePDXsHorq1IyXp9TdylXFW1guyMp6bONgn9Bi2Zz4sTUS?=
 =?us-ascii?Q?uQBDO5Z9TMTUURUeBhR2Py7zSYzRyi2u2WFm/QEEefgxiXHyFc+dL2nQNsdn?=
 =?us-ascii?Q?lb9pnaW6yUEudsyWoz5Fymu+wyLqQtGkznKytOo+L1cwGXhONmjAUkTojwqF?=
 =?us-ascii?Q?Bj4vVG8PIADZlS8mPK2RoRZiyhlCSsap43RPyocKQgpw3tBCXaMaCGSz50v2?=
 =?us-ascii?Q?iKP/v0DP9qZ4KDzNK4gLHZSgniYDNrNlBPgTUNgLQKeJm3fnE/IV9QmB/zB/?=
 =?us-ascii?Q?I6rd9uuAEh0XA07O6j4dCmB65FLAeEA9LNKXWOHSKP/VJNyCRV0kbb9sr+/9?=
 =?us-ascii?Q?1zHg8rUo9LIrNLQ7qLDghbtWORqQp7Oh+aSgyjeZw2mUUygbFAa/SbeXDAr3?=
 =?us-ascii?Q?jnnTiWbumBMyD8wfnRzJASNDPnyXKfVd3f2mgvkJbhrFRi0LAMRJp1Ne6544?=
 =?us-ascii?Q?taxNJSJtDRAJbuGg2wbVS0RrC9LpFGAmupm2H96VT1FuMj3cjcFIdkBDJeN1?=
 =?us-ascii?Q?2irE4FVyOnkCRUJNh9uknasSvETcO9qI014JzrdiIP6+mJpfPynYslgsvYw+?=
 =?us-ascii?Q?3lYAvaPOI5M98+35cRDfHJTTGVQs96xI62l2bI6jB6s5holS9lsCRPMUGK26?=
 =?us-ascii?Q?8VMepEPIoDlQdqM8su294RT7nSSLo9QYxyfKunMpjU0PHtGW/83CQ4Iye0Ui?=
 =?us-ascii?Q?nspotRHY32swXRcDrNrvBEGsg9GKWlhYirB+Dt1UJeJoU3qo27BB9tSpRf4r?=
 =?us-ascii?Q?xqEboPv14Cjj7czWHoRi70dn/mGdrdo5+Kz2G445xcOndCnRrfDC4uxvcaQo?=
 =?us-ascii?Q?kpg5LR7pFeOdoArHGCJiz+DxrGErNn9+qlYl+UcXINqb+fIdZSmX6XBmRqlg?=
 =?us-ascii?Q?n1nMVJgHY+w4ua6JWEPMIzltkTzVuvzkics2XijbagUOPCIYKIFVYQcWgew5?=
 =?us-ascii?Q?ILG+eojUXi96CMFtvIHaveE+IH9GBBylTceeeLpJCf1TPt/pyjxjGo5wkb1l?=
 =?us-ascii?Q?YNQBaKHP+8GLVGmmTpqQmsFmA7H5jrhXEy6sdYYSoBMLdqo7mNVbGDpYNbhH?=
 =?us-ascii?Q?EQl8nErLBUM7XQm6G9DkoW+kjH9RpqzFLz4Ykl47EuagK63WG5ywBkn1WHNl?=
 =?us-ascii?Q?59iLy43o4eYHTRqj4MnP2Ag=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e355d3-f6f9-47b9-ed02-08dc078d885d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:44.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFeZblnkskd92iiDfCq4P2MBYVOL6EJmRww/PSA/jG5MJaVrymmPKYOdzkVy6kLLeCxsQul5/z6LzZnnvigOmLRkxKIWEwO7y4Fo9hjbsX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 8a6e2ba7ee..04c114f696 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -807,6 +807,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


