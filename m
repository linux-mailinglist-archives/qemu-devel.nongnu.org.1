Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA617CFA4E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSen-0007aW-Fd; Thu, 19 Oct 2023 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScd-0005tH-KV; Thu, 19 Oct 2023 08:59:31 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScb-0002f3-Tq; Thu, 19 Oct 2023 08:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbwDvgQ1VOKS9qdO9+NPQUQFtRb02O+uTnCTznYcmmSex9vuPMTU8OUUIPjGd67vpI5Z21TuKiMDuiThre/LfuFZ/8nV/kPPjte6dMncmYqmZqDaWQngt0qp7a1LFwly8i+9CwW9W0gcoDhtbb57JCRBKb08hVYbZij0utxWDcJVmBLoXBW5s/c3H95ycZAGUDjT9cRh1YR8PJhyF/EPznyKvzhPwG6IsDGoLsMgRpgb1grIlOts28czY9salNwkx5/slg2tFpzbZdqecrhlvjs7ii114ljzlHZr/kdF9pq22VlvBUZ77RB1T/de/xFBqppa3iaXXgTk97agFxC71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQY3VTqKbLWc1ugDai63v18GJcmUxZY7ZT4nVkMImmo=;
 b=ib+q9VqcYo2NRYossvmbWQ5d2VKj80WfPlunp6F21M4r4oxP6uYOuPBg6CyLjNzObuuellHD/Nf0VMHNjw2fmq/gLhIUdYBTDBL7NESLoPUXzQ0Q38XA0FtiOoezODjsFxEzT00ERgDJOvJIue6WfcFdWTxtw8T/DHRWFK1W/f4yMCiDfy+90fZxN5FikRNVNhj6TEfZ+IrzW+cnvJlLQpcpsj8ikkKEWKcUQB7CW7URLvi5vctpKb6OmP+aPA4hA9SGcRoiP3z0ZPx131jc2EE+fJLQq+qnDGowpokg/nsPwSg6hnTOkBwKZU9+Tsql2DaI08LNv+LXPa4dkH+8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQY3VTqKbLWc1ugDai63v18GJcmUxZY7ZT4nVkMImmo=;
 b=qYSs+mAC5Rncq88CmPjB1iL1xppllVR0M+Z4ybaWqRdS0f7OpcpI0P1+jcHobhxsjM5JanuLv6hML96Pv9tyVrS45mm+mCqFHTnClRXdmNQ11sLdus6yM/TgXptPpXk62x0KzlaQrAjUuB/9yDuTiUmInHBKlkQyPLyaiFKPO5AyYCmONi3qQJz7z8r4Ct5nuqAekxx3vEg0KAQVzmlG+Cn5tcCQQu1aalTEXN6Yp0bFa1265rpunyuQifuJVDcn8hhytroduVkznLKCbnkLrJbmPHW+eWMKVG8jkERWTQ+BudTCxkBpFCaCziQw/blW+P9ai6B8xwPczT14ffeO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:19 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:19 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 20/20] tests: Add parallels format support to image-fleecing
Date: Thu, 19 Oct 2023 14:58:54 +0200
Message-Id: <20231019125854.390385-21-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d576eef-4d3c-4f05-77c7-08dbd0a33564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYNHjbns1qYzQd3dSkC8otaFLNXZ6m0NGlen1nMl+cwappkuf1rmvjR/btWhZdWHT0YFUp0i+Q6mNZaZ5FI9cMZalE4JJJDXiH2WnKulymsFkCGwRNemBra4fqrBP1KRHHZDj9s7gqulg0uGYD8NtUiZ+gbNVHFH1aVDsbuRpw95si4cNzcO08zmEoxeScUPeSWty6HivmpbXnjX8UnzuJTA0G6oiCx0WzesrCf6zRtJUKa+dKY48fQKN+GBPXrgFCfVfiwhDlJ8egVUogwFWkIzQusUXhHzjmXzKyVw3EqmF9ho8LquV/zkzXTdBLztGHMS49TLKN5JKr/cF6guufZF9tzGQPRkZ1R2ipcSlKAoMemZ9A0IytMPq2or23ExZjWwUQxAJ9sC/1ypfhxG4X3joKNx5//VQBzCQ3kUZkO1twblZUZNVrHliIh/4BDkmEqW0bUwypsegFnwKSJnlDEH17Iwh7v80BysSKEuLynnJQwJ7ooC2JPugx1Q1FgmYwVLnOr3XrLh/nXdWmCRpKG4YdiO3/Ps2Iq8Sz3ZMRQBuqDs6MDC07lw6thpQFxS43xsAwJdKbrPwUZx6EpW6kAwNw0oMH3YWR25rdog8tkcq+SE9oxn8aOV1I/kW6q5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBHQKP4T5be4LpMpajIXxVp006JTCJv/ZLJSzjrNW02uq156P/IsPCR8q3Ej?=
 =?us-ascii?Q?8Znld3YMSFZ1HEiwHlh/aJfK2XdAGVT6SObaFsCSzZTOaPYUiaYlgTRlBDM+?=
 =?us-ascii?Q?tUJaX3+wpglnMNA0SlDA02Q6D01X3nbdreErvgQVegwcx3HrSPbzj+eY6Xvo?=
 =?us-ascii?Q?5vtqsvsO8hu4NoehJyoA1p/7pACrwoNaCL6QG0ULvicI0iy8XeDliW3CUa6T?=
 =?us-ascii?Q?deoYaqtKEiOsTIhhAz+0M1e6J6TQOGfzmZtlIOGgsK2/Se0k56y2DHUa27fD?=
 =?us-ascii?Q?YaJLU4i3H065+4gFmSbe+Pu2U4U1i5v9qbtk7ojOslKNKiOEZs8WEvuXzGdO?=
 =?us-ascii?Q?08/CUpnmI+LWKC2Y7SwSEd80ygfV66GsvZMZHyI7/Jv6eARt3iLswpc9xHlb?=
 =?us-ascii?Q?W4MLYNKTG434wCniMNsSiK7sPVUK9ERSLSgSYrRixYET1jpYmIhTeiRPaO2B?=
 =?us-ascii?Q?DoNLse381zinKEuqe2ChmdCapcjhoy53ruFqYWGXomfc6WY5q7C5IbZ0v+F+?=
 =?us-ascii?Q?vUiknPuE1eBNtfyHqOQeGo5hdstLDAiPIMcta0rApI7zBvID0rmg2erbanIo?=
 =?us-ascii?Q?DNpuSLqUbECbvXHtcn69iOZ3IIxUv8H1Re7ov1pwMLlpMyR83W7IAZ6VLWow?=
 =?us-ascii?Q?P6znNI4PbESS8nEPeMd1Hk/tVGQWRLgQXq2OPgIHxgC3mucLKJeseNOkQUGe?=
 =?us-ascii?Q?qN/KEWG5EAYrdU2peWa3bj4UZhCMWIFLyVPeRYU6XEGx/bqkD7VwSvrb2r1K?=
 =?us-ascii?Q?+o3eAuxTyz9J2LAmRxIbTO6AaC3qWp+p+VZRtsVZ51lmIpLKHOZITNIblQJU?=
 =?us-ascii?Q?Plj6zHmFH/SsPEhmYw3PWEe1OW/xtl4tsuAelgpIlWCkzxl8XWMAHz2VWvDf?=
 =?us-ascii?Q?6W/2KqqHO+6akICqdLZLMLtCP8gcy37AHJLMGEytUmibtrsVeoavgnt65STn?=
 =?us-ascii?Q?prmgt6QTzzUigh5zqH501oE3+hdfbVZa35VA9h0uthCegtkf+gypR/O7xS4n?=
 =?us-ascii?Q?CJpFvVTByOia8dRu+dZLaIy37cN+kea9GrCFri23RgRhg36svW/Zavz4K3e4?=
 =?us-ascii?Q?DJCWasUjn3/ybXydW2w9YJwlD66YzLJhDgeRsDj+XULhQvwmySxH/K3ej21L?=
 =?us-ascii?Q?q1JbJMdtlOP5XDFGVdDooDkaelGhDu4U46tQj6MFDh4DzI4+CGwJ0KIvPW7o?=
 =?us-ascii?Q?eUgGkARwkHcQF1VstC2WtFmTwit1awbrNmF21O1Ly7ZEJrhKynOlvMKD4Wis?=
 =?us-ascii?Q?I1ijv/ahKoQSe+46f3L+yvE5KIALwhpiesRdtv4zKBZa2QbWEyC7298u2gVL?=
 =?us-ascii?Q?4i9xRakgTXa7B44sL5CC3shzY05NoyiRO4hL3+ov5SZgOI2aS3KwAXclbOUk?=
 =?us-ascii?Q?fGIAXEhF8ABM8QFO2eoOGRcSSWUyqNty2ZA7x1wU+HxggTqpvjJM9wi2OCqA?=
 =?us-ascii?Q?dRqGUxJMkF0r/E+FUtovoL8MSBk55eLXMLn5cFusf0SoPLhm8n/AQzrWN2/U?=
 =?us-ascii?Q?xGdePJjFCzYmEoothg0iy5o36Q/Zkq949+PglJgSc2mPFkl1lRI9VlPIrMM5?=
 =?us-ascii?Q?POjgeLCnL+n5nZKMr6zbDAhiH+5pwCJN4PNgWNYisvp1cnYdd86wLNFKXpKD?=
 =?us-ascii?Q?B1CZ8uZGDm9MpS26pk/KiQo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d576eef-4d3c-4f05-77c7-08dbd0a33564
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:19.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk+oXeVLTUbWXXIUPdRmy/fSqTDGIPx4E04J64owRFXhsPpxGq1oyAeFMpK/mP5XuStjKc4PSlXbmdpuA/K43S4ujUo+spKzgU8BxKzPwjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use a different bitmap name for parallels images because their has own ID
format, and can't contain an arbitrary string.

Replace hardcoded 'qcow2' format to iotests.imgfmt.

Add 'parallels' to supported formats.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/image-fleecing | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 5e3b2c7e46..dd940b7203 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -28,7 +28,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io
 
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat']
@@ -61,12 +61,17 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     if push_backup:
         assert use_cbw
 
+    if iotests.imgfmt == 'parallels':
+        bitmap_name = '00000000-0000-0000-0000-000000000000'
+    else:
+        bitmap_name = 'bitmap0'
+
     log('--- Setting up images ---')
     log('')
 
     qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M')
     if bitmap:
-        qemu_img('bitmap', '--add', base_img_path, 'bitmap0')
+        qemu_img('bitmap', '--add', base_img_path, bitmap_name)
 
     if use_snapshot_access_filter:
         assert use_cbw
@@ -75,7 +80,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         qemu_img('create', '-f', 'qcow2', fleece_img_path, '64M')
 
     if push_backup:
-        qemu_img('create', '-f', 'qcow2', target_img_path, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img_path, '64M')
 
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
@@ -130,7 +135,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         }
 
         if bitmap:
-            fl_cbw['bitmap'] = {'node': src_node, 'name': 'bitmap0'}
+            fl_cbw['bitmap'] = {'node': src_node, 'name': bitmap_name}
 
         log(vm.qmp('blockdev-add', fl_cbw))
 
-- 
2.34.1


