Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0F81F660
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuK-0008I7-KG; Thu, 28 Dec 2023 04:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuI-0008G8-5d; Thu, 28 Dec 2023 04:42:26 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuG-0008Jv-Ls; Thu, 28 Dec 2023 04:42:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEsDXxpetbP2LpOQpStiz3xYtA5sC49ZzZy9z1iyNT4mhD+8DLxdLnSqzEuWTUxX4jPwxnfmcPAa4IirEAqUXkRyiiho7jC2x9N91wrLTuhJTt8ty8WeGUxDBkrymXDqIL7zBpBl80ofJSfksWVFzhCJ2p0o2vYBlRs4518K5WatugkjNfS/JPnXESHGAC8CqB1B2NktJvJH62PTFx7g3ZIDejp2foOjg2sB7jLEv9fiFRuJpaWaoo97xaJ16Dx5JVgNvpAahU2OgHeS8YkI8dCgqbPxOBhhIyoeezZaeVNocm/aPybAQf/EN+ZTl1xsEgHGLiVsMtF7bwjPME8XbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=kh1+X2qdIuvCw+VO5iw3giNYwJufUX920hUmdSTS2gn1Qa6Fj9prBhwmbV6l4tjvFZryX394VrSLvMLcOhY0eM0EJe/WsGnCCK9HzDweWTxD29NiuwB3NenLXUjviSsp0/nM7T20HLavD7rtPd7kduPQUDQy6PJu986HhOEPaaGKbyAO0E8VK6ckPGeFxOWdIlKFlqSFakZdQD/EIElWHEnLoEZEl59YG9MLQ7FN2wDzkBMSL4LGg54uS/Epf56xu5Kx5yudjIkuWCUueUDDhzrGGKljYkeASnvsuKZFPJlWZd1MmjN7hNIKE/PKCqXiq7QKCU9RAF5DxZybPWXPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=d6slJU0BeW6gdKWEVvcLQz4Bvq+PINKfCbVPb4fZFhYy4H7eYeaxqqpdcDt6i7pHQU7slEGu6XUUiSeB6MxE3ppYTwgjg+O0uhlnbZQZVGVLmIYyyHx3r3HFRTjHbQwQmmhVD4XVSo541WBZEvWKcBaAhXyHn5I/9DCh+hlD6k1QtSOoB2+pUjGNiiJG9Y8HyoJAteNvRoVAszvn0oVfh5NUs3NxFjv6EmoeZ+erJBYYND9GakuwkwezEcj0jKX/tufisz3KXsmvy6TwuETd/Sy7kQkS6szPRs7YXGIIu7ZosdPTg/ioSCFJi1KYqRjdYMVV4AW10ovnJi4xc+LaKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:09 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:09 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 21/21] tests: Add parallels format support to image-fleecing
Date: Thu, 28 Dec 2023 10:41:53 +0100
Message-Id: <20231228094153.370291-21-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f272e50d-f67b-444b-b1d8-08dc078941b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EdhVIUTFb7I6UW7KpcHhtGdk3EZAmNulpAeHblckaZU/PdhWseBapRSyJy0slHl9LmHAub4dWyYCT9Ok3WIHqmedMf/n0y+i5azlu6VOgZDyrAwfsQVlz0TmVgQpEKi9P5o/hUI+irLiS999SEJK3ZWcr7jjs4SQDjnpo0eU8JPOaT54kTNWT3WurHeq8pEexb1+eJozOgHwdKN+6iRguOQJbNL5ncmu4e6DWLd1p+vnwIqjUOFO/3/PlOmgMZDmMjpgmzD2gxQYaeBKKxVlmT+ml/pmpC0G21TDGapq3apjG1M+QHMzVo+cYe71nM/25qzFD26HcHpYRRvgnQHrmBZFy3blIePwdINCsjHnt95TT05ffTLvQNP6FCkGHN5Nttk4V8bhbB2Xn8USQW5BTzytiffq1tOenNdOx/a7Imae/lmT8zNB2/AFPmToU/aSfSKEGd4xbe2ONkEdpW8vdWG6uVdvMox7aQO5m69P3fFgBp/UJ7DkSTo2/OLk1nCU8hjL60ejPw1/qtX+wLVj9kXwJXGWHQ+JwlvvjSy8gzGWnhyUVWrpXYJbUxq/SJjiNb1eOe25kiF4+cpfVpj/dGmJBB0LB3A5hFDcmbjtaDCm8FtNnP1KGYg8jAz4Wkr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOs4KN+omJdLAkU8sqYn9rk+zX6upUy6qlpuwBWAyN76NYYzPhIQpGaYKAOm?=
 =?us-ascii?Q?sdja0wTGcAMi87JBpNmTpieiOck6fNyhBXrHWher8EsYCDbcKskyMTXnhEmW?=
 =?us-ascii?Q?JnR73UwLM/lzQbeIWqKafmkDxogAHI5kZypQ1uVeNJLjtt9jBvi2dhyPyWAr?=
 =?us-ascii?Q?ZyAMlmyu1nfYf1FKHhH6oTMQ/LnyranHfeF9dNm+chrzx4E2pejV6PsrLhoF?=
 =?us-ascii?Q?jmLJ50hsbM5RnDHfAZE7Qk7xhVfGBiOuCm/0dQgtN0IatMNVeF9QqoO+8L+y?=
 =?us-ascii?Q?tLK+ED3ifaEDRp71NMtIqRQ2fL3/CuxdFpGzJqPGzs48eL6/RSCKUpk15Bbx?=
 =?us-ascii?Q?Q7X7+y/lpOpFsryU2+Suwu+IjZApfcSejSepWa1qoSciU6TZXCs+ab7QxsN8?=
 =?us-ascii?Q?xsP/nqIAGdT6QOlSF8PMBCtWHM9bBgHkL7dV9K9oqJAvnH83EWqe68afXARm?=
 =?us-ascii?Q?yohbFYtKbuOFMEJ+EewUu4YhvE+91j5lyV6xDAeR1wigpyYi3TJHvIv7ANzD?=
 =?us-ascii?Q?oYvxbZ/w8EHbRWKPCqj8HCurBO+0SBsRz1vyzov+6mEHIiorvIgF5OV9vG4U?=
 =?us-ascii?Q?O0JTeS+nFgkuphM+DOMwlB3XcHJyUKBS9sp9X6zdwkpzaBXthsIVJps0bC5x?=
 =?us-ascii?Q?iXmh8WpNALxMFerUScrnTZ5o0nncGay+10aZnc4Zgdox6cZkkBCqt0AbO1OY?=
 =?us-ascii?Q?6CfCs0UjJid0wNly60vV1UnMOI3jbetKnSuz5Jx6XRR6KwP0oIJa7Dsy8Dsl?=
 =?us-ascii?Q?ePRhwDspiDlhe8JC0vkowKcI9ZiyPoooLk1b2as2izAfQ3HZXX78FGuDvGYf?=
 =?us-ascii?Q?YRajNoed7sGkVIBgsIAgEIgMYs85XfmfS0C/SktIIswiM6U7dkE8QTbp8VSW?=
 =?us-ascii?Q?KzrfdPxa9DKSqeNfXGRJ+JWQfp9JsUmu27yZ3zIn3Xen+dBoP3uaOYVaoicb?=
 =?us-ascii?Q?QtoY54ErEWQ/RQZoWNeYdd4g3JhbVE8tCrqV45coMQpcWcg96YLU+bSD49Lp?=
 =?us-ascii?Q?Y73jgrfvZ+9Nml+xP6uWPBWOffUKG9CYjyLPP13YZCdt7GDRX9YTK0sSqDPa?=
 =?us-ascii?Q?E1axiEByF2GqdljGdkxyjIvYx39rjLDVW7JybUK7atAD76q6+b9xkfqh827v?=
 =?us-ascii?Q?gwKg56RGs3r4VRRvMRESN8Fw0lz0DOps8MW8sjYQWh+v2paMCj5dH14eTker?=
 =?us-ascii?Q?0zo5rWS+vNANniAXhbA7YmqqGdojO+8PjxneQuJGhTXHX4BPgFHaRWgiDWEf?=
 =?us-ascii?Q?xQT9U0OOgF5ZnCnds7XmNG4v5woClJg5AQX/vR2VqmP03Gz2KAafhQfVFKAA?=
 =?us-ascii?Q?6wikAGI15ev7NTzhqpd+NWK35bDO1z2FJio/5uKjYknfRlf/NILqv3Z6F1RA?=
 =?us-ascii?Q?6JZwElIAvd1V0+2Q6ql9/gVtvZVJuF3KhfviM071AtC0JE+FeKypHkuPZPoh?=
 =?us-ascii?Q?kHtZnaWsNzhH0qOUiHWwTzl06u14L4phAxFSWdxqlDixHY++2GsNWCBSfyfG?=
 =?us-ascii?Q?JYyEBtZCbUsmRP/NW4AkIJxdWzngZimbtBJD+Ezd/BxYEDfescTWFkSeAho6?=
 =?us-ascii?Q?AN7oq1bXinrks/fMyl1LkRlWXu/sIbBphaVEoqlyoG4kaf1i5aHxf38wEndR?=
 =?us-ascii?Q?7faAsfPdfR/buQPTQRD0mpU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f272e50d-f67b-444b-b1d8-08dc078941b6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:07.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zju35Ozdu0ltojKpGDA72pRVf/ZYexnFps5JY5ZnnJiyj/usmqPVdhEvHyeH8/jFfMKPz/9jgYAEprkLkyxq2tQhNDhHp5+Lde3gXJUqq/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
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
2.40.1


