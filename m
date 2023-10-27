Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA97D9051
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZf-0000Rr-NK; Fri, 27 Oct 2023 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYh-0007BE-3D; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on20728.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::728]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYd-00041O-Fm; Fri, 27 Oct 2023 03:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxwPy1JUfWPCxD197YzzsLWfWKddxGG24QqJse5ocLGt8xQvJgZBmsG2ntI+6WcdzmNJSlFktfVyY9Zqhnj+AZan4o0GTzX8htfeARr/HFPYRf+n+K0wvxyXAQorI4SpCKgO08byZNqP0SHvMM84rJzzzPGlgwn3v/Vp/uDAVogzM4ZQPQcBNAnQ5lpZ86Y6uGu6aeF/FNaCAXZY9SX3sMr5UQH8qd8Gnnrhbj33FhxSb5LHDEX/uGHYPbOg+WWu44GQN+mvGOTy+fDPJuCIEVkV3ABwNYAzI6wb54Y17VJL2OEZd1927xNnjcOsNKN93s0Pe9ZGhZTOA1jQgUGc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oirhDp1aJ+KaHzsTnY2r8XLS49vYxHQU3xKKAox1B+w=;
 b=N6E5Q3qwYe5UFCieBHAS6tKIy2iRlhQH6R2i1tqro2ptyA3BXqHCp39HFg+9nzcfUwug8dV7txUnWG0luROZygJvaeD53vfnu6o6xUbVwADQhgtB4QMXNNsLF5ElHZ7tzfQ0pz1Z62ScqLsGT4nw/um4obxreMxlcoZC7gOsO0Ylaq+ReoWun90OWgBXdDRkEuNcihLpiiCcXhoSdXB5NJyAJSs5gEO7EIoq9MXZ2wESUhc/LpwvPv/G8qpYqV2pi4eYiFiXus6DG8/u6NQJtBeI/zZ/vBtB+cl9CDA8yD/CqIGI4e2ntqRad3f4S7vzskg3/MR3KQ/0Lxj7Sl0hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oirhDp1aJ+KaHzsTnY2r8XLS49vYxHQU3xKKAox1B+w=;
 b=YdeTgR/1+HuM+ZpqkLFejRi+yFeDqM6X9n6nxI1X7UbIdSN+V9NCv7S0uSPPIUQS5F9NB2cxjg52i1JyPJzzxPyg7U7lP5UZGBWcBFvfAVY8Okpwzvo9hWMvcYR1ndJ+EIajAQ8tEuFN/xSE6O8FxKjdrJ4x51TnN34KOdk2mhWo9qQtqJsDeAV5K5YE6ZAzde1lYsP6OzE+M/c9HlJb90Vm448yIvySDWhH6HGs93nqYhVYPhqKrMF14IRFgGHPaMzYfl9PAT7blEuc9VrrM13nCEB8yh3bDOpyEvLuY39wysks9uGjhciame1QtGrKkM/qcp8sh/+ufdk5K1gJ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GVXPR08MB10715.eurprd08.prod.outlook.com
 (2603:10a6:150:157::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 07:46:53 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:52 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 19/21] tests: Add parallels images support to test 165
Date: Fri, 27 Oct 2023 09:46:34 +0200
Message-Id: <20231027074636.430139-20-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GVXPR08MB10715:EE_
X-MS-Office365-Filtering-Correlation-Id: 064cba19-da39-4cea-4c61-08dbd6c0e107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qKBqENe9WjQsicPm2YPasoukco6p65Lwi6oa2YyS3XnbQSlrTq3cE8Ji2wUT1Ol5/SX/5k1zZ7dAkHh4+XrzTWaKNPJIeOL6tLWLCySndktmPAVkZPGcEybfQTf90Xu3Ic+lAihdfvODpk57gi2UZFYJaF741ZZnhg/Qmoi21pzYZcbNpDGXn6kvREOvOzamzY+p2EoUjaLshysZ58x5gGeZO7u2Z+NyzuUAAkxi9gzEHoHOPHc2AJuEThnK45LZ+b/dPgbIuqq6bkSg1c4MyQDeGVs6CuLBMhNLabtspVwyUG6tuHWn1st2B9Bft7sLo3BaTyQCfTe/y8tpTAt6/eV8Idqfq8zRuXbCV1JNqKvgrvrYqCI9HLnvBgFM2aZz29ZL9b3W/Obe6aaKnIm1MV0+dZTjjosVwiHOnabmOIkn2UTjtzUH49YrsRmHfpv4mYv888XTqfbiBTFMrf9mfrAhWsI7nJkA5VKAy/y4tpYDWL5WNhr1uuv1Dh6RnLF37pttmsyRp+zwkOPLOC9GUMnMqw7QAuPpZfPgKfHH1Q6u+sfqz+uN2uLk490wyy4CICoBleLd/qhAFtuNMHvF0b9Q8us9Ten11lG9X02gztYbZ1/y9PbkQMe4AF3lEbK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8676002)(4326008)(8936002)(83380400001)(26005)(38350700005)(5660300002)(38100700002)(86362001)(36756003)(2906002)(44832011)(41300700001)(6512007)(52116002)(478600001)(6486002)(6506007)(6666004)(66476007)(2616005)(66556008)(66946007)(6916009)(1076003)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arCx2ab8R+Krn8Y7rYCKU0POx/kAQ10v4Rakqn2c/hmXIPllMBOCgNa3bWiT?=
 =?us-ascii?Q?UMQcnD+CVUy9MshFlN+9me2jAiPt/DWMIBbzHXXrNHilia+eSbXGd0XgMQok?=
 =?us-ascii?Q?IyxyFXnLi9Bw1pZIdFvY5wzWNKuAC9O4gf5KbgMBv28J5ojpyJ4UmxVVgujh?=
 =?us-ascii?Q?cvkRtubn6cYB5DJGy/gv2sl3fc9ByXiSXEJJ20+gtmNTju6TW8ai9/6T4vUf?=
 =?us-ascii?Q?a89rJLUgq9lPV5oZER72foPKtwwnDBTWiEjm60gZhwscd+85YAP300S2ShNy?=
 =?us-ascii?Q?d3/XDcBiEjVc3LOhXN+BkpRl2kamTETY61bxEq7Xh3cevgdVI2KaZf3wEIy0?=
 =?us-ascii?Q?SS8n2IOjSQwR4DWTPafl/6kAdDfz6IONZC3x/Ce/iMD9sxGxT8pVIEW+s5bN?=
 =?us-ascii?Q?36vnhUnrrtSq6E6MZNRbA+GonL9o0f5bb2cX6dvLIVJmbU98N1LK8TwLnuli?=
 =?us-ascii?Q?ysvZCYgRwS2j9cPivp3ews0XXbOcsXI7unF23amWg/CdRUrJjlJaJFc00RB0?=
 =?us-ascii?Q?6NVVKdVSepCOVgpe/6pAMm3J2zvbzGdaOmOX1yFOmYqnMgIRZbqtxbaLprN9?=
 =?us-ascii?Q?2Twx2RzypJFi8nqqmIKBkW7rru3u6ilPhtWg/l367THcUxn218PQFsfda3t4?=
 =?us-ascii?Q?OygD50pFGNV7O8Ybj5JeG19cA1G7Fdt/8AevYjNdnzvzuSwOrqCvOs78mysd?=
 =?us-ascii?Q?BwV2k41xGEU3c5/DVTd2WZIPzdYpFZw//YE7nnu/8B95Natwa0DhWi//cuL5?=
 =?us-ascii?Q?CLVtcBzzA/i+oz748YyU0oBPLQcZ3/OxRAslgQDRADoDhwkLsIk5Ab5/Anpg?=
 =?us-ascii?Q?Q1r1HUh0OuJtFAyewON7AUO8CLNtKbqex78nZb0FvdxgAcPdCRFSdShb3L+P?=
 =?us-ascii?Q?FZiMEHGrMhjIOKHSoQKty/nYECu6rqTMbUuRDMnv2anLPxCO+LvESQPn2SB/?=
 =?us-ascii?Q?Z3kO894XtPNNX36L7iHqUHFq+E44l5kOQbib5nlB7PieUt1uQTuqBhUa2SO0?=
 =?us-ascii?Q?PhCWx6DUEZF2s7Knok+VXkUje5WLajXSUeq7IWVrJ851nipaaGs4sTFtMnmV?=
 =?us-ascii?Q?gtOGqny7mO9ueWwiTUgxl7XkoiQ8nIOBgufcKzYEhmLrY+EnrvJRC6YgoyEC?=
 =?us-ascii?Q?508mqW3z2lkPvtXp8rOtJH1vsoOYH52XQ0ameFSia76wcgODDHodigbBbL2y?=
 =?us-ascii?Q?31isfyuQaAt+N1cZFtx7De9AG2WpRftYJaGtguD2Gv3S0nHUF0OGQeqUZw8G?=
 =?us-ascii?Q?x52xC65xZRHMHcKltSXgkSa7fm54O0BCSKcvYlWe7jobxIhxAF7PLYZldQ07?=
 =?us-ascii?Q?sxZ+yL4yN1DhoTSGMbaFwSaPKvxyH5XEpw/TR9etR7moCsMD8IQAnGCaBowB?=
 =?us-ascii?Q?QaOC1sEXH1ioQonwWTOeiFnzu19Yr2ghXxLwsTp4xG4ze3IeASIPwBwulm1x?=
 =?us-ascii?Q?A+cQXMa5I/cdz7GQcmK8Py6tkQoJoOh/4BAHYIyK1tN9J4Ocmwwu0eOC4HYf?=
 =?us-ascii?Q?ZtBei3IBNa66oRnYCavQwRGW25pyvh3iBk3oX2LPqrmKqCt4w+B1402qJO/t?=
 =?us-ascii?Q?uHltcDAeekz3MiMnlZAREJejlLkcYYeNd7tWKRYBABeOJaDOf4rg0zijNlKP?=
 =?us-ascii?Q?4X12l50YHOaRMzNXD23Zk3M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064cba19-da39-4cea-4c61-08dbd6c0e107
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:50.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VERMpxzA4F1yR7tTFm1ro6IsUiJnvB2SE2EEpX5hrpmuxP0EoNjiH3S1jwOnJW/MQKSMvoXybyhSAL4Fpcywm95NxwLhlM4psV4yGtdyshQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10715
Received-SPF: pass client-ip=2a01:111:f400:fe12::728;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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


