Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEA7CFA34
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSeS-0006jw-FI; Thu, 19 Oct 2023 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScb-0005rg-N4; Thu, 19 Oct 2023 08:59:29 -0400
Received: from mail-db8eur05on20725.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::725]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScZ-0002g2-Rj; Thu, 19 Oct 2023 08:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUW96YZdDcQ+dQoLjYCsxX71Y6qMmO3jUMFdcGFyPx1zNYOci6htfQ/+6MYMMXG6vR/xcEeFTKKpaUYgwzowctNfjrBB0YVr8OZE9rbNGHYzDGBw9h8XtDViGpVBPJCN93VP8UM1EPIpExOlPlWfh/yshCtjMuIpqukbMfnZ/KYE+BX+jRbM0uKvBxXZkjys68BzUhPTQ1+ao/bAIOgOasxsXlzkQ+42fsjVFynTdTZ7cnuORMNYh9eJ0LyB84gP5hdK+t/uTYqzo/xZpUNJtPLsKVkOwSR5ErvesforpY9GvGgWwXwsGkpylxxCkVu02B88luTrIbk8Xgt0RYXj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oirhDp1aJ+KaHzsTnY2r8XLS49vYxHQU3xKKAox1B+w=;
 b=Lwto9GKK2RWStUzCORQqKEHo91kPK5ThMZSMRltOw5g68D3evfShFau5oMOx1GUDvrvUuynWMZyZFgHa6GufWFMBgs+2k0IpgrSrB/3BME6SCMobMvY1sO9i33CLBgZg+axvO8ybzantcT53Z8HZJ+0Y4EO93m63T/Ld791s97in5nKzRa7Vhv7UR9ZOPqOj02PPGYbM8THzH0HwKL9e9+jiO/8E7wzkKLsTmPpf2Md4R+zmRmBDLnBGVyZLWXHQ49YaCS4dT9MgrdwZjnk66gCRs/MqTREFX9BVQr91yBE92yCGXPzbRC4wHIaCC09JIU1PSj3aL3hsN6mutYWOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oirhDp1aJ+KaHzsTnY2r8XLS49vYxHQU3xKKAox1B+w=;
 b=P4pgRh8ok7kcjZ9PXngNvjYWNAaqdgz918PhZFam75th6+nwlBnAOrTFjOpDuiBcBkrfOayuXyEdSbe2DGGAAUdLX1qbsYGfNyLW9KPGsbxOajztyLxB66d99zRRYoCjIPypQCm3mIors9/UhW/rTnfxyJfuGIqanmkLRsMDPrA9eJe1g/I3eU5bAmSPJY6fDF7nt6/TU5QwB2TcLR/HcyFZRc0e3SshvhWzjAr6cB/qn8E8xm1P9L4IQbB++UEYSZg6jVo8ll1D/CbUHj9K3nDyjVncE3PZwesFxt3hNNE6vT8Pg8MeKDF/prE5QkzRsvKJlXVGYJksfQpS+Eq8wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:18 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:18 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 18/20] tests: Add parallels images support to test 165
Date: Thu, 19 Oct 2023 14:58:52 +0200
Message-Id: <20231019125854.390385-19-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ad39deb-846f-49d9-235e-08dbd0a33489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etZ4vGwBNeWX7/Lw4T2wnaXn9pHKydFGZvpVTpYCH8ii2tOEQ0dhm0vuQB2ihHEFMdD+NMR8L/xv1mYyL87Zns3+UZayClIeWbHI/MTqJ/o+H7CcLskf9a+zp7JByIottw5bNSqeGg3K8kgpX0xqPVtll0IV2tQldYXy2c/m8zrYixOfl+Ha7rRI1IaVIJ4AYD5JqCI3aHEN9nQ0KW/6/BXWUI0Zt93anQrmyufV3h3bmlkNtp7XSK/lFLgDTorwiSk0BASxU6Pjo9LGrwmshhihfdqalqn9vKUxE7ZOiHiB/HZ5MgV2u+QcjcV7SlL3QiTE5zEpjaITIiXYsSTNHUgnV8c6hOCT9rAvm48npMcEr+LKBVuwWNQbi50OrNM/dFhb5eqiTDZfIq27HwY2b971HsPARGfnUdxMTeGw94kjgOZAQwDoSgmV99bOuXW4fpL6/HD3LwvhQD0N0oYJC+JD2EinYuaOPkqOW9A1vHQme6C8dokCaCXqKJoQAEOYc4ynKLVPb9SppojLN49rN5N+mtZwGOVeMxSOfflMzvatc23iIuSEq0MZj/Y7Dw+Ap9agroqSchAp/ZfpGL2X3yl8UoVrFYCKmhEiCeF9uUDic00oIZoJrG21kcz42/y9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0S/I59MbO4oomhIUYwt2WxdfVOhA4t51OouFVYyxaYdmn5PWVhHkStYRoKU4?=
 =?us-ascii?Q?TlJvwXRcHLHwadpI4hNTbvUdM5G4UQ40g/m8ivt33V/CJeRW4M4KxuBBxIp+?=
 =?us-ascii?Q?rSuMyDkeCp0sXELUKqpJwoeThBlKVGCY7hUGSqxUYV73IsNjiNZFyNQx2FfQ?=
 =?us-ascii?Q?nW0I+tpMXRlKJMg7QncY/9zM/LQx1bMzKLA7BC6LNPjBJVa4NGU7CCPWNtBi?=
 =?us-ascii?Q?0OjgBiatn9KCwdzFzPVN114NqnpwjeFjoD2jMzdqkjU/dgqWF7Oj6CXDRsH5?=
 =?us-ascii?Q?zBtL4n4vqluaP7uiSmR1arha6VuPDsj9kVNofqhiBCqAd0taUT00KlAXQNM1?=
 =?us-ascii?Q?dNuULSUOrESqSIrMgwQGNhLCG95JSPvQtsGRkGcLAnCoQUbnrme2xfDAdxUN?=
 =?us-ascii?Q?u5tvdJEQDc/5FtO1aoDHT7yDklCJfRwS6msghSWZg3mRSePMfOeQznqflfTN?=
 =?us-ascii?Q?SG30jDI211Bj65vNHxIHDUTZdjH9c2xQVpBUukKFCaKpinWb7YukTZQoerZW?=
 =?us-ascii?Q?axzxgAOt4T5zCmEnriV7hCsVh/mo+NDAnA6oqIILSm+H9za3hmf8ytH9GeNE?=
 =?us-ascii?Q?QilQuBMudfOUPYV3UMT4AeHhf8Ac3Lo7Ip7ILiMjUK4jqZ5G28D5yMQL8uWD?=
 =?us-ascii?Q?iA3RLewmGY+BNX2mn2yqX6HTpid/TV2hFFOajYEFyiaQkRXfLnL6zWVcbjzN?=
 =?us-ascii?Q?3ZXLdeX76fvE2jX50OWhyRiJNEvptctkrDIMalz4MuEv1dWwG3kbneBFneIY?=
 =?us-ascii?Q?ysfh9JQaESOcvsz10hVjHYFEu2upRKKvyacAzLIez71CfHOwRpBvIcWXP5ad?=
 =?us-ascii?Q?lv5SQAYbLce4ebzk7jGOn7KWdb+fwji3p1qyCxdIMvutULYr6njWF5jtmQW3?=
 =?us-ascii?Q?NJQdtvndp3UqSlHZtud5ROs7W0Ebkq9lqWMnyGTC+M3wg3T3h2FtLxsZ5Cbe?=
 =?us-ascii?Q?BFE4HPPpbQSUOGTVDSF+G1OP7OiBguFMbL1mbF9R2ZrqTTI/HpB7tTAJ8Qgh?=
 =?us-ascii?Q?zi0Heg2v6I1V95AKU9sEaPVpcRRPLUUIuAUJyCfGdzJQAgPF8HSCUAov+CX1?=
 =?us-ascii?Q?Ry0lfeyk9JTR38S+cAG3OZpFxCWDm4y2HNLJdMbP6chH6NrOpAP5lmiudkT2?=
 =?us-ascii?Q?5OA/SreOjQ3cILPXdTzagXC0J7ZqskdefaM6FfEQb5cNLsvyZo+e13QXwNX4?=
 =?us-ascii?Q?LPUCSUl/00LhZXVnXhl6oHeDfbPbAJ4ejeTr4oTdIAZfu5yEhVxtJZJxs+tQ?=
 =?us-ascii?Q?adAEuZWzioqC9ifs7+vsCiqd/424PqKupGA3o8P3etQljJkkQQOyOj/TzFpg?=
 =?us-ascii?Q?Fxy6ilXhgAt4ymKxjY86TqjyEdWRezRmFRYjKn6z3wZygQ08Mfzvd8dPPwzW?=
 =?us-ascii?Q?+Sba3lLPEq3Q3YP2uPIMxOpBtmfqphu0gNFJBWAfF1J93lJ9vX48XOLADs6y?=
 =?us-ascii?Q?zhXdnbQiyXYupB4P0TnabMlhnofWXXw7JmhI7k1b4BYMdurg0tsvQOkaCiQ3?=
 =?us-ascii?Q?x6ePDQK7exoO9W5vmyGwQTfvVMMoFjLb3kvhYGj1CJygrLoyXvscTdSPa/Y5?=
 =?us-ascii?Q?nRz5S9OMdx1NnoOWXZLJYd99y+2KEWDQ6Q0SDi84fJAMoi72Lt1ERewQ2e0w?=
 =?us-ascii?Q?4q4sa1i6FVFueYQRegT35do=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad39deb-846f-49d9-235e-08dbd0a33489
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:18.4021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj3hg0YJ6+5mvwLulp8v3gyNOnniqzEvhVDuGbNO+jwPG5q4b92oJHXVBBGHwjzfheG0ssHIrYce7CZSxsOXpze7TqvWH5W5mSQM0k7yb6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:7e1a::725;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

Replace image reopen by shutdown/launch VM because parallels images doesn't
support reopen.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/165 | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b24907a62f..f732db257c 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -38,6 +38,10 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def setUp(self):
         qemu_img('create', '-f', iotests.imgfmt, disk, str(disk_size))
+        if iotests.imgfmt == 'parallels':
+            self.bitmap_name = '00000000-0000-0000-0000-000000000000'
+        else:
+            self.bitmap_name = 'bitmap0'
 
     def tearDown(self):
         os.remove(disk)
@@ -50,12 +54,12 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=self.bitmap_name)
         return result['return']['sha256']
 
     def checkBitmap(self, sha256):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=self.bitmap_name)
         self.assert_qmp(result, 'return/sha256', sha256);
 
     def writeRegions(self, regions):
@@ -65,7 +69,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def qmpAddBitmap(self):
         self.vm.qmp('block-dirty-bitmap-add', node='drive0',
-                    name='bitmap0', persistent=True)
+                    name=self.bitmap_name, persistent=True)
 
     def test_persistent(self):
         self.vm = self.mkVm()
@@ -117,7 +121,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 != sha256_2 # Otherwise, it's not very interesting.
 
         self.vm.cmd('block-dirty-bitmap-clear', node='drive0',
-                    name='bitmap0')
+                    name=self.bitmap_name)
 
         # Start with regions1
 
@@ -135,16 +139,22 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         self.writeRegions(regions2)
         assert sha256_1 == self.getSha256()
 
-        # Reopen to RW
-        self.vm.cmd('blockdev-reopen', options=[{
-            'node-name': 'node0',
-            'driver': iotests.imgfmt,
-            'file': {
-                'driver': 'file',
-                'filename': disk
-            },
-            'read-only': False
-        }])
+        if iotests.imgfmt == 'parallels':
+            # parallels doesn't support reopen
+            self.vm.shutdown()
+            self.vm = self.mkVm()
+            self.vm.launch()
+        else:
+            # Reopen to RW
+            self.vm.cmd('blockdev-reopen', options=[{
+                'node-name': 'node0',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': disk
+                },
+                'read-only': False
+            }])
 
         # Check that bitmap is reopened to RW and we can write to it.
         self.writeRegions(regions2)
@@ -154,6 +164,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'])
-- 
2.34.1


