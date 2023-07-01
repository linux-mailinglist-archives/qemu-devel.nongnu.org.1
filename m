Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C174485D
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWi-0001cL-Af; Sat, 01 Jul 2023 06:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWg-0001bR-HN; Sat, 01 Jul 2023 06:08:22 -0400
Received: from mail-db5eur02on20710.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::710]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWf-00076b-2e; Sat, 01 Jul 2023 06:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7P562MaO4Z/2CTAEDyGM1EIl72VA3GTMgjOwCDaxDK/zszcruYVK3x7JyZAazBsoqagZgsQoUkSAbMzlYOuzLbWCF4YpTsHYPFzpJUpHxl1lzjXMq05UeCghVHqN3tYp5tKRic4jqLamZEQsJjFUxCrWqQlBSyoVRxowU0f32sCODANcpB4qi+ohZuyT3AOuchJeUrrn0GJEGaEowhXCKmubTMFwMJg+NDwA77s4raEVPfcxCS1l+3/MaP3tVizI4MaYLhYO+l6dRHfTlLJH0zZljxQoEsVUYH6fNMg7PQWwAtewI0oOTP22sVTJjoev93cC4pXlf7zif7NaxtUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSSUnPvXRGyiilsEqbjc3ibuVMssEPxMtFYeHhlCeEM=;
 b=aKiRrAzVQ+HKYveZZBLed3ww9Vqs7aWCT0ztU6/g81n40BWBB34FYDwX1bAE/dYj3jU2gQyTcYGVvCGSd8zuChBRr2pjG2VYM4MX1aoEOKOONEA7EWG0TwsO7/GBLqOiYki5KsgROwIU6KJXgSWN5KjZmswZY2dUPKBEw3ZTY6H7uj4fhivmQKl3O9RJCc/7VlZ7psWCrgbxZDBp1uROqtqaz+HbNkB1wwiDEbA/CUet7Ip+7dz1geAofZxhl5hhKO0pPrv+FikxtsVF64oqvmF5Du5+l+D5sO7k/vtASnnn6I0S047NZqS93gtoRJU7nFs5R8r0qCqf+C6sM4b/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSSUnPvXRGyiilsEqbjc3ibuVMssEPxMtFYeHhlCeEM=;
 b=uhlxgi467z1cdT4gBwnOem1PuqA3ulOSDg2Xy7XZ1tzr9oHrQVY4wf1ugRdGdOfKSXWuaYCoY8Rt0WcZfcHAW01wVd9bs67Hwv/ke2ttxLD6SYaOsIBJK2Z/TIwLXUCZHAt39x5Adev6Pp1Nu93VvJLfRYcyLLU1+nq1M+RbHphz3+9OsvVFvE6a2Na36C6YtI02zrq0hUOh7GA1q7gE332FjUBlXD+gcOw3exAmYT1lz0FYyg1U6qx6X0guv9PSQwcVjQFvmKSzeOrYwcgK5SPNctaEU5h33j3dCj2WM90Sazh9SrLzsA0WwqeBpnJ1j8EqqtnJ8fdSVBWlgP06ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:10 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 7/8] parallels: Use bdrv_co_getlength() in
 parallels_check_outside_image()
Date: Sat,  1 Jul 2023 12:07:58 +0200
Message-Id: <20230701100759.261007-8-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b523f661-78e1-4cd2-9406-08db7a1b12f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNORmxvwvoR/xQ3PFlYw2bCxVL4XtZHdRSQ6Rnj/JY0Hi7SlSWs36hPaDRuXm2OFWF/+bC4f4nb6XbgJMqIOMYzhEye8CrcgOwNToZ82x6pA5m2cEWtayGdxsELQy92tJPnK+ev/wU8U86ierEMBk9NRRwPfZw7wJWs3Pi+xrIgn41JRlf5qkKYLf2idDRRtNrJZbPa4+kIZUXsvm0lCy/gAvd/huQAniqMvEM35RlJbckRsBPnQ8QnQEa+KYWeN5Bp5MN0mQvMEA/r297wgGXijfibzDJzVIKhtb2YO9ZyQiDZGU3S0TLQSq2Z1OvVP90gtxo9z1nL9+cGWFKVGz82C8olTSHLUfgCes9sNg8mWiwH2CZnGomm077AsnLyRFuGJmm1VJyl17Q399RtXZJ68EhM0qB07j9WZRoY8HjTmNC/aUQ0C7fLKwTVawt1EbTik/8iq20/bD+jb6TmO5hsVuqUYm5zzhLeYi7xYWo2ZH+RNt7xkCDkhbfau7ZhIi68jSw2ZgbB+/opGprDWGJ0jqpVJJ9TYzbpXLL7tbsvjs44eLvFE9vv8vQRtGhQ1nxue1y0xDIO+tjRVYaPRFhdy40Ap3Jxiagat3aXdnJ88l6FFSwOCoVlnF+XsSJvc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(4744005)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/meHLp6LB6N2kroUqxC5lBkJop/HtVZ0YmMGNxcbyVt1fI6EEDxRsw8PXh2?=
 =?us-ascii?Q?N02syRHXsX1bGo72QG37q/Mj4KsgZLG8NK37sNPSfodAchHpwF5Vb3iFXPH9?=
 =?us-ascii?Q?2dhg0qdtLcy1jDwqKUrVaYGIuoRil931xc8wDJxiT67xIPQgu02qIYxlq5wr?=
 =?us-ascii?Q?mmi3UbaAmWS7JlEUA6ZLjgQ5QU5Le3kNytzG8yCntRiZJVcgWYfHvmpLYsfq?=
 =?us-ascii?Q?tT9LyymeWy9pw57V+9PDnSGQctDUdS7djnHg4YqqHKduDE7NIGPRH9msxfE9?=
 =?us-ascii?Q?fBQ8CTTxMTV59Gr01qmwSIV0xY1yFOiKlfMwPKLyyxvhZeBmAuCcISQCFRVX?=
 =?us-ascii?Q?ZjjxgYgud3s1xnJTYAzvSZPmRIC224mN2HISvaW22O4LJUKmoglXi6yIdmZR?=
 =?us-ascii?Q?5pUYEXB33FQSniMeCTIQ+nZV6HriD/pqp5gLt6HKsk3VzTO46HgoGKRngOqx?=
 =?us-ascii?Q?NJ2BifUjSwTFpeffxPM61Oixxb3V9JwRdzazcE031Wg5jh7gAiis9/M0poRH?=
 =?us-ascii?Q?FbTqg0jn50y246fjNKHtJ28Yxi4vXE9nLyXW7ijdm/ClDLnM9cLzIrJY+aks?=
 =?us-ascii?Q?bOFeEls6bZj9xLodDVXw0LM7fe1WtjYEWviuwjryf3O2F55zh7InakctpLEQ?=
 =?us-ascii?Q?TiYyxEsabXxQ7NksOL2ia5eP+EqbEEwZ5uwOmFBHbxkZ5CJ+1U/awcHMWiRJ?=
 =?us-ascii?Q?GxNGu5du8w4AuYOkog6stZzSxhekb9e6NQHZo2TEwLA12aSR0m5wq8KiDd8s?=
 =?us-ascii?Q?23N2i4AMnCKbZhSblk4rz57pv0pKMfN5On7SmjglnCoAQRpC7G7QRW/qiyhS?=
 =?us-ascii?Q?iBdBTRKW4/slBQipoRTDbBm3WTZ6t+djlwA2mmsLEDQkvQIku2tg0wIVR1J3?=
 =?us-ascii?Q?r6lJN2p1cou7Mv7tkMjxWMheFTgN/4qxZC+Hq4hqsTLqWrWUZVVlUrBILyWG?=
 =?us-ascii?Q?bv9WI0/8bZZSzZJ2IB5YOyThoeQpkcYlQsxdXXnswl04I5WLA84YxtBSx1M6?=
 =?us-ascii?Q?v3IxUpvghI04emotyPF7Zpy/QYTi+HUDHLpH/dZUspMctBNWviTLbhw+wkPD?=
 =?us-ascii?Q?oa5qadb8OStoZZw8VQ7bvVQnu1oarfrEHCZqk0JElfo2/AoTNWkQJC8z3ybB?=
 =?us-ascii?Q?NeERv0KMhvdxWCTsDOMf7kZhKRFzGY6K0MYKCXISGjgTUEpTjOh5zALByOEy?=
 =?us-ascii?Q?JAGyiSwTZ7JrK470o2Ux5cjMtYxO2DwfRJiKENtQ/1PKCIk5zyAL/UVqsERv?=
 =?us-ascii?Q?gSJgOWBp4U8SotXQGmuq9FGEtwilvSS37wb0iYAIiIZvguynw5JKKp5ohQ8+?=
 =?us-ascii?Q?5Y28PQCPiakAmb/XFNmLCh6w/TfZR44Zr/biS7YJ5dCOfXC8rRxFQ662kM9c?=
 =?us-ascii?Q?tagMUj6UBCydxnBVtncXBsQvkJxswz8H737L0WalD2kH73OmCLobQB8CG+v2?=
 =?us-ascii?Q?JvoacEcyigsdjY+HLW5KbzJdij0RmbyEswDkebT1HwD39u8kyMkzbmQlALYx?=
 =?us-ascii?Q?rNXJZ3r+uVc0CMPFM4F9jAyXAXPEsRVPElQL/D337Myf5oYVlevhyu5oRKIa?=
 =?us-ascii?Q?llreDGBZYzVFMeuWsyQrT8r8gzckXf06AYb6WbgVWeHPokqYG5bgzHvocC2q?=
 =?us-ascii?Q?qi0ZGB4fwBwZ1EScCf5VXb8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b523f661-78e1-4cd2-9406-08db7a1b12f6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:10.5143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfxfUo9RpNoHrSnAAd+m96PeNtKUfJzAkvcTnyJsBF6x/b2Lmy18Hr4DVE65coHVPbLYLnBjZCCQ/U2MYgZ4m2IxJQtJlrvBjaOX2j3WeZc=
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

bdrv_co_getlength() should be used in coroutine context. Replace
bdrv_getlength() by bdrv_co_getlength() in parallels_check_outside_image().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 51fd8ddf5a..456a13bd28 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -496,7 +496,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
     int64_t size;
     int ret;
 
-    size = bdrv_getlength(bs->file->bs);
+    size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
-- 
2.34.1


