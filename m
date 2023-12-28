Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0AB81F6C1
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOO-0005hD-KC; Thu, 28 Dec 2023 05:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNy-0005No-Tf; Thu, 28 Dec 2023 05:13:07 -0500
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNv-0000fc-9d; Thu, 28 Dec 2023 05:13:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcsQlNU0duAC8oUUM+A2P6s14sfneA1COqGwVDhjOSwLOhOAIEeJ1AY2xH0cIWTHpON9/L6Hd26SdnxmkhhKOtuvmjzefUxeQ7/CKT05exzz+PPoyg+H8dIm0O0WzQOO6XpePKkpXRL8fpp0n5wWhqzgwLDOV8UEACb7VqqmBN32nPrRVxpuIn1rmpF+aXrIRrm22sEWRoSidEn2B7LRE5xpU5zAbUhs7FJHXELVK67BXPPlzv9w14egopk/lrBX3vupSMZkUGQvGoElNc8uLTzddcP/nENYGkBprCiu6KvR271j9b+FFHHdRax5OTueUY1cCKkS8s59d3PxcF3aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=nQez4IiDt3FbgtwWW82NE271SMeCipRtnXsXgkrBugHbx0EWk44EjhLpRs30k/a7JXGTO21oA0U4PT+pI8JB500z+/YmI8HHddYTKReOgfixMZYHqFllctHa3i24UgMco1gZKfkZmH1zn04gTjgpvlQYTA6uFb4JnCoXlssvY4RWuVGCcKQbnyvRVWv0ElT2qQ1UaJuU+TrDjSJmk5R+xPpEpxLkDW6nEsYxHpOV4S6O2ZBeBQmnUSCSqo/mG03mdWrDFQkwANeVQ51cuJ6h4iWFIsJkkikwDQGO9JkcCIrFbMTB+SrMX0UTWRtD4OKvt9LxKrjfJ1VTcgsD0HLcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=n4GuS25qSmj6djasGYXFTtLFywEEu1H5s/9WTewDAhoPG9taKHEtAYgSUgkGT7exNTHcRGK9fnwORiPLmqqEWL4cnbZ7HHhShJwltC2jVQ5k3rXqxCPj1kJD+Zl19BSMfK3m3xZozIpg8BeRpHqnvyyeiWVIZYJEFm9C5CYIH3/bOutRY/qRSKGJvLt1VLcr+mlJGb5O7e+LsCUJJejdbk/ceWBwKnFW+Nhr9xzuCLSlQeSaumBOgIuNu8AQlFOD5h68QujK4MjNYLGqGXMDGAzV++fZKZRY6AZea3jnwqGMu/tZUD3R4tTgZDXCVpVoHPu6zA3/+VP/3Rkto8kPgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:52 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:52 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 21/21] tests: Add parallels format support to image-fleecing
Date: Thu, 28 Dec 2023 11:12:32 +0100
Message-Id: <20231228101232.372142-22-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee79a86d-4659-48a1-16c0-08dc078d8d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBxxtRCjOObWRRghAZs5Z8Favm4okJyCH9wpiHRtjJZTGnNmkFdVCKGtVHhXOghCzKYsgA8l72gmurahbicK9PH9eMNufoYVAjq5vpa9KUpSVVODEmawsii0TZYecQvf8pYHxX+8GV4wDfqKnWxvXl31bfJh/IZVfACFz549N2hasFX04VTKdApdfVZceXfTaNNRYZbIG7niHEQfeJXe32duIpwrdj5fYr+zAqAItJWd0yyBAjB+gZArrsVr4y+mEjJZqZWBmPdFRpxb6NzIKWcv6csoKpN9WJnPtENqI/Jm789BTUCgDVb+1mkBhZOrgopI2cdsfYa/6oh57uGeajpDkEqbd8oL8YUpv0aRJfJG9uqqnCyKogwVxDRz/tBYfYs2DV3eB3XRH/UluXLanTpxNgcLQBsVlMTQuVb6a7SzjLSr2K5MtOZlU0urpfQaIFohkMR86wlLXmIORSbW0ObVcCtoKOuyev4weBuGcuGwkSeMaUBdSzYK5KkxektXg4jD4jQnWckXm5mRKGx/nUc8rbhHqzuN+6MrjfqbbZT9vHfai6jpyZ1hRNeuZSQa9KCBDCiqswokTzofuE9oKigapR23KTzCHnefe8so3doYZprCkAp4/WL6dJAOvgtn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4QKKLCPLS1mfnQxkYRQNWPqwEYx+TePv8iDQvth5KCYdVXRmKwGj53ZFujX?=
 =?us-ascii?Q?Hx8y/2z7A7GBRjbsZDYL6O2NFsed2NeXXcryeM9P6DRJvTuRUmLn7yX37Y4b?=
 =?us-ascii?Q?LMNKyUFszvX4mRXUAg0xIFErNJPWXXKu2pDr4l6Ykp+Dnnl75rBBccgSxHW1?=
 =?us-ascii?Q?GDqQzg+Osx8RYyTTU1tmtAW0B0aNnXJNxxkoGmdmNHc8Ajih8Ct/xqB7Vms7?=
 =?us-ascii?Q?ddCQCCGeKL70zNt1e5vwCQy0uT1IEvyxeRSsVA/Mf+qaH16viVlO3XULgfrY?=
 =?us-ascii?Q?He0/qD6QzN5SP9s86KAhYiMUGSTBdHb0vaRe+aWWseMUMG0RNgdudaN6QZRY?=
 =?us-ascii?Q?5VDqopJfUW/Vz2FxO5fRA162/xVsIYBFCXoJqmXzvlz+wUR+PK3msijcxSNF?=
 =?us-ascii?Q?xNBTVIaL8lqfkmQZpJmQvhOkHqjHwk+eBvcR/GTIrB4shrms+HzKmQWrECdv?=
 =?us-ascii?Q?9RlmQmiwM7RdazIymAMDaapA/OQh9/7KzI9cLbMCExN1+SR1Z4HI2fkuu+U4?=
 =?us-ascii?Q?qqVHxxTwZ2+pcQLoO0oXGmrVWPiGWtVOGrmRB/q8sRMKML20t8Ooj7S9FAlC?=
 =?us-ascii?Q?MrK1ZVThXzNlSi7W602bKT+vhkZqfoggba+ZXQ+xCoEmO/IcQNwzIRJzmBV2?=
 =?us-ascii?Q?i70fQhyXw7Z/hlzmUd2kijTk6Z+3jMPwtfNPGlo0DMlctgo1KABGXb1mdrV9?=
 =?us-ascii?Q?6yUUSOmKT65MqWBDUra7PzmA4eBNn1Fv3eXDyCEpETUa/xXtv7Bo4+SsZi+b?=
 =?us-ascii?Q?ZgCp6oFmoMTjZQe11yfMv1LGloEkMPEDJ6pGBgM2o+bJRUFtRHqrXZmCh/no?=
 =?us-ascii?Q?lC7Y13Zwmwz5vBv5w33fFB4h3z8tJ6rH+SAKhs7fyw3Bqu95iTHAG1Oxypwe?=
 =?us-ascii?Q?Fz4X1YmsYJKbpACpXsAGG5ZneeaWVTFKGLbuj+vC6JYeQIhXkaWkuOu6dVsK?=
 =?us-ascii?Q?XoB+92I0A0qc0cUPrOHwqq3R4l+8mfpqPFaTJ7HZjUdmB/3+HniF0qjwP5e0?=
 =?us-ascii?Q?zXhMn6l3Ntk+at+U9Vgus1FzoowjOKYbbFuLdlJjW3JQ/yZ0QO4EJXVz3dkZ?=
 =?us-ascii?Q?rF4F90eEK18yoj2e+Z5a0JwVUHj7u/MW+u1UCgX/CbB8n53MIOFV5Tj7h4Zs?=
 =?us-ascii?Q?QPBKrgkCGUKXS8SfSF7nvoBF9mUzqPdiz+E6a5zKePzf9KtFgW1zu8c1wCL8?=
 =?us-ascii?Q?YbRrkcny5uYywxj98USQUN8GW4afv7G3g+AWVMAx5BoTRddcE2EdH363p48n?=
 =?us-ascii?Q?0ZL1Awjrvo9S41DyclWTjWxyht0U2wQYIDCbCe3LyNYyh8khVyaKGLPSUuR5?=
 =?us-ascii?Q?6XX0RB9u2z8WCd4O29Htx++3CgXc0WyORAcR+vleEwF6p1uh9nysSUNsmElQ?=
 =?us-ascii?Q?SnR1ddBEkIwMFEsgetkUzqPuDDGLj3MkdJWROjxT8kWUMrMTGN1znCPA08d0?=
 =?us-ascii?Q?mTv6XgCpWOlTlumIqCWbLZmt0gDYTAAYxbPh7JcLdxNuqPN9LP1Mc+JuMiEZ?=
 =?us-ascii?Q?QNH23GIC0UTW4JeBaP8iY84CAJGrR8eQyYKagaO3K7kqyI+8SFqQ2q1ur8s+?=
 =?us-ascii?Q?+jvNmhSi4TRbIGYz5bQ1Gv7h46QBBaWttv8118wLL7AfGJkXfdrHmTr/5e4R?=
 =?us-ascii?Q?MUGU/J+6PUiFNn2IsyV7OGg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee79a86d-4659-48a1-16c0-08dc078d8d44
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:52.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1np1vxHO0GIx2G1v4bVHtwxKBtKruam+S26Nkhruw01D6SEza8k5AUry+tygifSO9chikE65uuYu0gjlIFiKXiXbmEr2LGlVSCto6TSpzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f400:fe0e::727;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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


