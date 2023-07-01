Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9074486C
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXa2-0000oo-Bj; Sat, 01 Jul 2023 06:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZu-0000Le-W3; Sat, 01 Jul 2023 06:11:43 -0400
Received: from mail-db5eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::724]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXZt-0007vY-4P; Sat, 01 Jul 2023 06:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCnANlJnnOgmuXP0dLlRSBg8JepVh5oSWX8jgU2yjj29oGqAy46C/i/loV5qDM8WtKtXviJz3gxf2/6m3ySu8vF7MU6E/jK+cNIaU/BSFXCgKN+Cs120Fy2i7Ey4lxpMKQ3YdVJY7nUNPJyeUbp+LFv+VnP/LmEgDS+G8e9xyX3b3dUAxqimZnubQiHIaN8gY7ASCTp3EhYFNJkyO7IHaYTXAcYVhh6x0hXmOOuMc77wlMOr7VL3DcbEVztX0kT1Qp7nICdpVsAZ9PeaCfUfWZLtnHXzY+Yswp0oHyGwfYo827WIkyEDeEP/rs8GInKpHvcCnne44UzvdRL2NM1S7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXxDQl3KN2kYItdqhU8b3qWMQnjevn8aJMXL1T/NQNU=;
 b=Iez+TZc72yOD3Qvj88X863HevPkPxUiCcvoWKl8lYHAyBvk/ZVuhL1DgC3HzPhKczGZbUVmBbK5nBHcmD1f49XMMKxcY+4iwku98vnk+kMx6q43EVGyPoJUIIbrZiIb4OeWk6AGHz7E8JrcnwfoBZ02CwgRb/WY3ek75kd25a1K5hbGetyhvEa++caC32O4x1oZPs1EspkxepAsUkRjYMufNsw/eRRNS9f0+SBdBmhSXIVw4cG9gOXMVxFz7iGCGR2GHPShZMkSfziNA9bZiK/lseKVWUil0VREN4pL5fVFEq82l8PSVWUeeq4aKzhkrlSiDN7PbkZBb9BVRqkoO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXxDQl3KN2kYItdqhU8b3qWMQnjevn8aJMXL1T/NQNU=;
 b=HA1cCiWm/HiwIueANFW1n3lKuRNVputhQLWMoIu2aNDrWosgMs9+Uk/cG4CVn/ZzaJabGXzSZKNJafSKAFEFYee1owpvO0PfdLdSrZW8/tcQXcGvFov22p0YqDVtEYQyo7rLf853fW1tMPK8oV6PlvtZYcwpkgET9yRQPbOU1naSctQ6sDT1fvrPUeA/J71np3/o4bUYypB+wiHBh1OaWmlHWCdQ3JNKnvmI6QeDi6jGa+1/dVol2XbXIKIiZyoDV5zhyBI2Sv/l3HUjFGRQRbnX7d2UtedSnqphkU8jZP56lChjsxLLLvCtpBBiWgGJ5DoVeDHakbzb0IqXJ5ClKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:11:33 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:11:33 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 5/7] iotests: Fix cluster size in parallels images tests
 (131)
Date: Sat,  1 Jul 2023 12:11:21 +0200
Message-Id: <20230701101123.261104-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
References: <20230701101123.261104-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0005.eurprd02.prod.outlook.com
 (2603:10a6:803:14::18) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a94ff6-88d6-4a41-2075-08db7a1b8be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC1tAHyI+x/GTAz7UqAKVAS6+UbnvsMFFnm5+Cy3uxV87mxra3Y07ACq1EzN6mHFmw2miodRsLR+1FMEjCg6FJOnBlfcSk3eo4EmXNfIu78zwdEHqam03Z/mD4NP0srC9CFJ2Ig+LQVael00oF+1MAQHt+OPhiq6OA3Ig3lZyTAHHTo+SGHwvyr/hIY04MXO0hKpubSbtydQNxpMZPFjL8iZjSc1vT+KT9xe+zAszLRFVYpeQWVNILF5r+4YCfeuzy8uSl6J4jNgQ3t8JMYiwGx3dczUqmDfNdP3Eu0JM+56sh4WwMyD3j5EvVU+eiL4YR59+lTtD3toZxLt4m0N994ZhZjih2G6RgQV7lI9A4CObl2//Df3WrV3eQryJdAZ3VoldrWUGzRdGlcKDnqI+iSwjIoL6eLX+o1ZJ3IwB76Ngj23QlALhU3u4Pu13mMxOoY9qKsWaelzwJFbeAtT+q231r0WYnoRbgnA9szvRyHqMatwdzb/KbYVmqIwIhZugs232DLsJVw09jPhn8XGCZgn96YmBgVb8IZhcCtHW6sH5vxCL6XlqQiVHlhERIaO80NJtl/2ireJjXp1pbBvzNYp26ZNfWzEkDyBney2UGzn1hd54QgAWpgvs2bZo6RNKzlxSLf50DjrOThqaWGWKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zloK3PKoO2wNObAWT2mxj2jeT3384Oau5Vnook0XczaOjrJp0XwydD/R8kTI?=
 =?us-ascii?Q?CgyeMMe+iXQxvxn6Urraq1WRm72O3V0xZ2TcfLXoqpkysK6sqEEMyCzNp2Cm?=
 =?us-ascii?Q?j5S4fPGNE0cXC+8bwbg2lGcX602R5mNOMf/SuMrcp5v5ttTI/pbJUhyP1FwK?=
 =?us-ascii?Q?pZExqZmi95d8xKLcVSCM7D/t0ISvE2NWIEkaAe7y8/bWeYZVSnbHapR39Lmo?=
 =?us-ascii?Q?Kg5pr9n9uyo/gxuGkGckHk5dZq933mjuiCWtkQ57HZIy79yHZxydck3Xvs+Y?=
 =?us-ascii?Q?o2/92vL/XrS4KWl9zok1cqx2pgm2DsE8v5V844ZlSkY5xhwW8gX5HMDkxsZA?=
 =?us-ascii?Q?QrIj8wJ6UCRSl3FtYX1iOC+ry0+Ju3uzi8X/Adzd6I65uSwx21sZCmnGlIFr?=
 =?us-ascii?Q?bi8I74UkBIhr/aj6OnjpgFmNjrxNlSlLgero3rD3utsJw00nfP15lKPZSkpS?=
 =?us-ascii?Q?kSbUW3QPIj3Mgn4A3YYvV6zsFYMFGO3vNN/yTFJkc7qA2XclEh89dOogj7k5?=
 =?us-ascii?Q?kaO3Rgk3uv4eT1Onu9D3zQXuZR23lYwIKihFloZYQIokv8kh6fAXObT9uuQr?=
 =?us-ascii?Q?DZRKEVARRvHef+rb3CNos5HqaSPChnNj1nO3iwF6GxysOYJd/2MpXKMaKz2z?=
 =?us-ascii?Q?F2rzKapuWz5NGoLUozTtvGtv6USJoBaSzx8pqxEWORgA8EUkpUJylbTo2Hx5?=
 =?us-ascii?Q?YZn73M14xbGzyHEXTImuiu+N4bFAUr2LC0AxLefVmGOCD+RrhTjk+idAPR5K?=
 =?us-ascii?Q?84lgesZBG9/+nAm6dPtTnEB8plWTjEn8ENEj2zqiQQBurlBPfw8Wx6D/JerS?=
 =?us-ascii?Q?WBFUsYYNN6AFhxzgklT1xX6G0ZWSPLnCM6sZUYGMvi28/XbUcQ3UPFFOOwOT?=
 =?us-ascii?Q?ubO32/u8YPcvHc37CkQNdEBi5S8CJR9BO197noORE/NsqTt2R8mjdS4n3G9R?=
 =?us-ascii?Q?PWha9+seX6AD5a3ojd/HUhW5TU0iD/haDG65qMBI7HxLCxvh+C4qowCdXDnK?=
 =?us-ascii?Q?5JMkTsO7x8sfFiFBQJmOT+6oFF/XcYCktlqVhnhL46mIFYRTZQ2gJGg2NAFY?=
 =?us-ascii?Q?lq/VH9w+tO3Y3IO4D/A8ZQpjBsPXMLkJquS/BCs0cTJuHy6q5EMa56pw1+8w?=
 =?us-ascii?Q?6lnqF63Nzhw4T3DirQDE1kSSneo+jnLGXkIr0n7QexbSf2yypKJKsNZZA2Qm?=
 =?us-ascii?Q?Ti8NCqb/1dL4cv4LhHRkdMUXWZ2rCEq5eBO3tl6ZUQAvdkBG+d539U5lS8PZ?=
 =?us-ascii?Q?QGJCLY57XQVe65Be3MBpF2RzkifzhxBv06JFq1ZnS+W0RSl+WcB/U2ErmIQQ?=
 =?us-ascii?Q?1KjoehPXeP3CP6am1RmipO7K2o/hzzs36Q3cUUYfGyGR8lT8PwYdbQYw2O6f?=
 =?us-ascii?Q?DQ8LrrrPTsy8RRpubN/rurSQzDoJfKpM9qwaVRl8+e88L5rl6Cdq6eaBYnGq?=
 =?us-ascii?Q?Yu5QOM9c0JGK8wIJ0LBJJvTteNyOriicrgv1ELwp0HEogNTLNQVPednlKEUw?=
 =?us-ascii?Q?tRYFde1W/K7GQV2B9N/IB1CmQ7krdG9PT8ghxa0IHTdnhwrLTNnkOWbq8BZP?=
 =?us-ascii?Q?X8li+ts6nbz9YimZ0KvwSazmEhGiXSPDB5INqb6hkUHDejQWFq6dCge6NnoM?=
 =?us-ascii?Q?W5h0BP0G6Rb7Fal3GIQZOpA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a94ff6-88d6-4a41-2075-08db7a1b8be2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:11:33.3532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De3pARh5S5Pj+IxjKxXxepqoH4D4LiRvZuJBwkMl9moxuhCws/ssR+Pc4nUaXKJ8+ms3pq7o/U0JVrOgV9Cc9eQKOtP2WRctDO68xps2A3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe12::724;
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

In this test cluster size is 64k, but modern tools generate images with
cluster size 1M. Calculate cluster size using track field from image header.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/131     |  5 ++++-
 tests/qemu-iotests/131.out | 44 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 601546c84c..72f6535581 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -44,10 +44,13 @@ _supported_os Linux
 inuse_offset=$((0x2c))
 
 size=$((64 * 1024 * 1024))
-CLUSTER_SIZE=$((64 * 1024))
 IMGFMT=parallels
 _make_test_img $size
 
+# get cluster size in sectors from "tracks" header field
+CLUSTER_SIZE_OFFSET=28
+CLUSTER_SIZE=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+CLUSTER_SIZE=$((CLUSTER_SIZE * 512))
 CLUSTER_HALF_SIZE=$((CLUSTER_SIZE / 2))
 CLUSTER_DBL_SIZE=$((CLUSTER_SIZE * 2))
 
diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
index de5ef7a8f5..98017a067e 100644
--- a/tests/qemu-iotests/131.out
+++ b/tests/qemu-iotests/131.out
@@ -1,26 +1,26 @@
 QA output created by 131
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 == read empty image ==
-read 65536/65536 bytes at offset 32768
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 524288
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == write more than 1 block in a row ==
-wrote 131072/131072 bytes at offset 32768
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 524288
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read less than block ==
-read 32768/32768 bytes at offset 32768
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read exactly 1 block ==
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == read more than 1 block ==
-read 131072/131072 bytes at offset 32768
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2097152/2097152 bytes at offset 524288
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == check that there is no trash after written ==
-read 32768/32768 bytes at offset 163840
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 2621440
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == check that there is no trash before written ==
-read 32768/32768 bytes at offset 0
-32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == Corrupt image ==
 qemu-io: can't open device TEST_DIR/t.parallels: parallels: Image was not closed correctly; cannot be opened read/write
 ERROR image was not closed correctly
@@ -35,19 +35,19 @@ The following inconsistencies were found and repaired:
 
 Double checking the fixed image now...
 No errors were found on the image.
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == allocate with backing ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 64/64 bytes at offset 0
 64 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 64/64 bytes at offset 0
 64 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65472/65472 bytes at offset 64
-63.938 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 67043328/67043328 bytes at offset 65536
-63.938 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048512/1048512 bytes at offset 64
+1023.938 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 66060288/66060288 bytes at offset 1048576
+63 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.34.1


