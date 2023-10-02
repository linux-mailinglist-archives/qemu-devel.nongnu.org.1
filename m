Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF67B4E5B
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl9-00021m-8R; Mon, 02 Oct 2023 04:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEl2-0001lt-Hr; Mon, 02 Oct 2023 04:58:28 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEl0-0003Qj-7e; Mon, 02 Oct 2023 04:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQOJMnfOX4pQJycOSTguCaEiR6FfG4zqKVLCMRKGUByK5VLrbF0bApIJxe/4nCQL7JxmqfDsI7U1wUq1GO/oc4z886Oz7ZjTctJtXrf4gFtkFQLXg8E0Xs1928Z7FWoK6if03QgdfbWDnaoo26rToOSLjqJTdLbQwI4++Wu3F21WgOFpeQN8LSwtmumeLFP4Dkfc2QW+XizWquHzfG94iqfgKHdfgfq7i52YKnbhXas+yCgrTNKCf7y3kFsaCUmAyhchuTDXo6d7VkF9JHAkjO3OD2pOlwFlHgj13jC0ofe0dejUSBH3GyO+w62AfF6P7T+uxmzqVCzoOAN4lHZrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC/FPAuEawG9LlBXDeoWQTZvaiZbwgBf2K04C4SjZCk=;
 b=WKJU4zmHhy6kqMBGOwxRosTfINYs9dIEwbN/cKhv5hO+jAqRny/SmV34eSbuvCZGNa08nGw5Vk5M7P2bgLfuE90s2kSYoONfS9gzhEgDFpWWbkRVl4/80UM1Q+US/wDuBhrc9L6U6eJf+nms1K+Ln6CIunIEzJWSsNc3Q03ENuOw/HCa6DlX/6ADi4g2Njeir1xkdfEvEjazo37Epl7GOXNI3kHu30NprVCIjIJf4rZlWF6WN85fH5+y6Afgl+ZLFMV6M2kOSw7tL0j/gGtby4a2WaPcDA47vP0g2fMcUuJFqvzUR9zLbQPs4IluXqNBEEjEkPnjcXIcQVoy9IGZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC/FPAuEawG9LlBXDeoWQTZvaiZbwgBf2K04C4SjZCk=;
 b=zX77d9xx24DmPM31oulxbzJU3VyRgJx8i958Zs9aO2mtJXIrJucARaJ85TgKgnuzs53xcPQV/bXXlA4Q0OKTHdaeI/HM9LeMR/ZXjlL5wO8umZCKGsSeWrcwt+1SqgnnaWTxVKkQVSHTpMSLCvXv+oU5ILu6tiFEAqnoDM31WNxJXYZL0vZI4R7pW5sBsKNSMYKhNBJClxlEhBXZQTU90oJYo8t/Nvaed5s7vwDWFI5Ay44oJAodAnh8zQ5ZQ3A/b6aP7gpCC9tLwNyrDWXTug6ZkZj+xzgcrDuFNqIfPW+p4LCoqdZhnHUmz0gZHXcHui/GWfbe8tsx1Pm9BaP9gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:58:02 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:58:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 19/19] tests: Add parallels format support to image-fleecing
Date: Mon,  2 Oct 2023 10:57:38 +0200
Message-Id: <20231002085738.369684-20-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 613c4d8d-e5e9-4ee7-0dbb-08dbc325af56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZNkbE65U0nns9IfIVDuc9+f5QVDjRGuXInlusNQs3Gw2Y/JcGPEFOrP7IIs7zOEsu+h2qhdaAW2T2hbU3LXUKpV4Di2sv/DPKL0LU/65MFkc155qAYWJ1+TYRR7zyiOyNTGbGp01Pv+PCDGX+Mb0ZJlLhjagSLYE63PVz+kLTP5Go7gy+QhlWzxyWbrx6iVhsT3UxxbfQ9uOLcTflFUV9FLTTmaXU2mxs6lseJnad5+EGp+lB+eX2SqsJVDu9uz0YAccIDlrm+452ScCjvU6erT3W0Wg43Q7GMISegcd5m8+0wIk9at3unNg0XvpnHPLo8LlvcJFeVfFN5j2FiXTuf7QNan8reUue7CNpH49FHYhwAf6SFUyHT72fvZNkD0mxmXFIhmXLmgiQxiG6AsDxwaqfFmC1GQcWnHVp1eY/qZPoVhvbHlkGUTolm4Qa8OuLx8Z8v+vTEyifVYStU5YQHflXzA1ssaOof8JpSDgCaYeu3Re18lGSfd7cLM0uWZZ8EsiPj8Hpgi++lLqvwB4m1dw9JjcduqNMadt+NidJiwPio5tLKBfAtBoPUC3DAX6JETyYOorbvfcOVSfVacoohO+5ci0dA/zQ2Nu9S4HLz9bjv92U5+8p+aMJKG8gNn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xG4YFEtM+cJuXna4Aww/0IkTxl3AYhvP5TiCy6bKpUs7t0Nfbgjct+JOPynv?=
 =?us-ascii?Q?MQ+2qAOr5tPFS3ZDTqsSo1P0t7cQKhGub+LxMnmmt9tpvcX7PW5AI5b3GOC4?=
 =?us-ascii?Q?Pnx0/9uNLb3VeeJlsVBIzkTobPy/FOyUGHvDqu44lRRMlJPJL9pWn51KUm4I?=
 =?us-ascii?Q?vtG8YX4d0Jsj4x9NHOGXIbpOrawvgtQbdFC9g4x6RJ5oNiTHiHkX5qjlCwig?=
 =?us-ascii?Q?fPoTp+XsakIssSxJ7IL2TQzz+FcL3Qk5t+IGTeGmh9ZBqJosR56siroLBrAH?=
 =?us-ascii?Q?lPf+jOBi6dDTUzN0ir/bjxWXUdFnQdfgYKwgpQDyqiB+Y8blaqQrABIDBDPU?=
 =?us-ascii?Q?+ZzmF3ocbCreExZ4Rin5bikC8dUvKSEgz/Bi7uSNnHb5nKn3ksN3ZjmAITgU?=
 =?us-ascii?Q?NQNtLp7Nk8APV2EWxkm2YLx+1xA4huZmtjdQ577DxAzbi16j2hx2jGWQFQLO?=
 =?us-ascii?Q?+mPmKJn/7jO+725Ktxi2ABNNL7LrUwQgdHqloU1nTqzKz9zDyd1twOw5xVdz?=
 =?us-ascii?Q?yMz1xAoR2PBMPbjlmy3SjWky8k5B4eIli15NJ2+iA5gYnoSoIWE6Ljw7JA6w?=
 =?us-ascii?Q?s1cE9Og3aXxWIT3EPJ7lLD9dtnuT+d5OrzHh2Fw8B3cfnn7h+AhedTOHR+oz?=
 =?us-ascii?Q?RExv7NVHu17pjmtPWYOSeEUlzEvOABOMykiq1q0AijNvYFLWO1pJzV7HDUbq?=
 =?us-ascii?Q?RuOzJjk7e6MUgHiPjvvqrMytnc9PSXPpynYZCNzI/zofVPXitMljFLP1sBJP?=
 =?us-ascii?Q?ULBPLrDLvmtB4COe82eHEOzeFtanVacRitK8V0zRBrk22gVtE+xFNojT/Ur4?=
 =?us-ascii?Q?oLwbecT5OZVGO2C0QNNH7YKBU0afZ1DcAivEqY5acX3QU+OwCyZ4l4E3kuQg?=
 =?us-ascii?Q?8Baf1+ogG6hXMyFtNMt+z7jK1h0l8KWn9a0zs8+lPvcmoKt+YfCUc6DLWz10?=
 =?us-ascii?Q?eW7ttzFdPDFpIAgTgPwTKW+S1NBHOP+PWjUoxQOcf9sadfuJDUzMrYpMQaIC?=
 =?us-ascii?Q?DLej2/PzA5tN6TANlN+y8h1euR0NQYNJVvlRAAQUACrKg4pBDbuQKxwU5ZFe?=
 =?us-ascii?Q?ukNTrdaycE9OeQeKiEGsIvBHDsktEvF3VX9DK1wSuyhfoUASzhq+rqzeJFyi?=
 =?us-ascii?Q?sZ0nmDTlk2f7ThHNwZ3PW6RXSRCWcHHonfj8Yx8Vz9YipCGVjCNgWBeVw8AA?=
 =?us-ascii?Q?NNZm//CSrG3aBLmeP6sjQoLxN0MHwN1hN2++ysL1Vw7CxA9hp0XE/Igh3aaQ?=
 =?us-ascii?Q?lJOpysWtvfuIGvj9bgSj6b3HXa/wDQzPV9eBv4+kr4zRPkosR+gs9Zu3G55W?=
 =?us-ascii?Q?NqQXMnvbrd5scd+Oc/ju1/pcCaHclfFucTiHT0YAi996CeVhB/GdHM47zuoY?=
 =?us-ascii?Q?QxKB7TzOkfrJifRclpuB7r32Gr0sdTbvlD3PJiaV7lb0IjGbz6/CjEsO3f+V?=
 =?us-ascii?Q?JpiWI+ZAeOWdbrZoWrdN6z1MdJoFzB9cnK0+HyI6fbUOLtV/hgF222OsS7xL?=
 =?us-ascii?Q?UtIgN8+aaheG54mNogBy0uI7Rh7CghJmjpsYIDTbeXxaIQaV5FpRWwCarzA+?=
 =?us-ascii?Q?Lpyk9ZISZVGwqQ5zRx7DjpQkXyOuqFr8IB+J+jM8s1acA9hJHQ+ykxb1XgNR?=
 =?us-ascii?Q?m4sK1kaBoESM2dZn6k/7QrQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613c4d8d-e5e9-4ee7-0dbb-08dbc325af56
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:58:02.7734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu5lxHzH791cA7SikQJ9mkeLZCuv7NVeyd28EjxhKoeTpgxQ6qxW/rpvtLMy5e7CaZZvNyQCmtbiyBgeLd9BNAjmJMROm1/2DAAQYs66xR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
index f6e449d071..00d7f37af4 100755
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


