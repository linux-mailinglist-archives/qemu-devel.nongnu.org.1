Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9367B4E76
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:01:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkv-0001bw-IC; Mon, 02 Oct 2023 04:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkk-0001Ut-HK; Mon, 02 Oct 2023 04:58:12 -0400
Received: from mail-ve1eur01on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::711]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEki-0003Rj-DC; Mon, 02 Oct 2023 04:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU8/WF18e75/78N+kwkR4R9lJtXRyk/bQzlxU398mqxW8DLisP0DtkXGgRNhx/X+saGIFwRuicbvkXvnh8/Gqv4A9sOEN8HAhEGO4YUZk3Ni6jy2Nj3Hy6gJoxOHbYIRwK7ZsSCZ48dyyKPb3oCq5AZBkmvklqsEikRSxTt2l9eYenZ27Mi6jDzPI1is961cmygFGhQ5QQfzGXB0reBmLKX5MKO+sUnyT8cM6Tk73O+yyPiIETIidCS3OwDXm7Rn+3bWg6QdhZN9VHnHeuNE7N59suDKW21xw343Lbadj+wlClEkNBpA5ckxzbupzBfuZc1QbTvIrbTZzgte0mf36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zloRtBnEJvFUj7YTAKRwLq9g1gSpQBj/d0tbWJDAC4=;
 b=dMXvWTNmZ+Y21GZq7RoAu5wtHB8QfK0/uGbEu1q/DCrq3C13/8uftn9AkAsYp38+yZtKH4gG1fNZb/eanEOXfozpuZgPyvzVHrNxDCq6RF/T/ciqR23T0m4X/o9+o+wc1AQrJxi4G4O8oRBYeNAdLi9oZjtxMQUd8GF4MUSMjQjJ03XIMScgcfqCqMawWCcqs7QppEuDVL6d6txU3sQQMT5Tqn7yFF9+i2zuTykVtc3chcxJ9xzuv3qF63RHYSnb0s2SYwII8+gaG7zKqMk98pvUwvxkPIqMBUR+0mofoh9wx0VnmxQwjof4bX+PyYtZUzBStD2HEncXREa47drb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zloRtBnEJvFUj7YTAKRwLq9g1gSpQBj/d0tbWJDAC4=;
 b=0BhtUgL3FTQGKQ41Gw5kDjxAifoo/dBqdd6t7DFL7kAMwn5+TnLwZNFliLvXCnzxpumgMt+2MMqmuYOMpsP3nIuwy2d2k/UMQ/q3QoWV4Aya7JlYOPFyTXJpGJdrQ2IYr/AAF3rl2o5Jf0viz/da3PQIxgS4vw7iInxDNXqn/efoXL4WOgF8ieD9F9aV0DHzo4M2MjBFwpJirXUjT0NpzOtQuB2e9CT6IIvF7H5vtG4GUt/nocuIe7rVAHoSVRO2u9oYk2sgZMyK8ewhbVWvsrkneWvN2cxyXzllEuL1HEF0FJYRP2RP6NHAdhT6gSI4mZEzVKjFlK23RhknK3Op8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8657.eurprd08.prod.outlook.com (2603:10a6:20b:565::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 08:58:01 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:58:01 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 17/19] tests: Add parallels images support to test 165
Date: Mon,  2 Oct 2023 10:57:36 +0200
Message-Id: <20231002085738.369684-18-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 49aa7eda-d4bc-4d6b-a6df-08dbc325ae67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z30tYsZB2IDGshHLOF8lMveOr8EWBp1PlX/YwrqkhWZA8XOg1FZJWL4G85V80BiW9dCt7ETkG/69D9O3mqN3mJQuZY+rHwqRAZnRxDlwokj4W5+krXLzZ4+N5gss1WWV1g73Gk0TLTaDdA/svB6SviTCzMpVfYtQBrWHnPsF84OKOv51l4D4Wk782OxyJHcpheSCNTzO4XVG0ALYDVu5wrYPti6oFxNQmBVGiYkZDxHfNfu0OO/mqMv6BSGDICiT4KaXzcMM5wTZqpO2g0wDY8sZZZJ1lTc8rUvsBYP1z7stwvq74BoZlZswIWKI13CBQiqzW6Ex9+5cOybEmKzbJ23SPF0jflRK8zDNtd+4lsUlsK/e+zvXuFp6eJwGGw+9GyQ8xnzhRZXWPeroEFv7rnA8luTtIYra2v75cgSWWVhc80EiWOBi9UzyuRdFPOmWxwbIIi9y8c/lARddYFJC1IahN/MSuuck9rCjFlT2qdw3fvm54syh1gHED09pWwD7Rr/kpxxsGKPGqxBCLblODWkPE0z14AJ0IejWE9nO4PsLXmpiXU2ei3wtzOremPuUhwdug/RxHEbGDoLqIdaUB8TpOtqrFXqMcWfmOvCcT75iQG3cZgtm99b4/sR6CUiV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39840400004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66946007)(2906002)(8936002)(8676002)(44832011)(4326008)(6916009)(5660300002)(316002)(66476007)(66556008)(41300700001)(6486002)(478600001)(6512007)(6506007)(6666004)(52116002)(26005)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CPYpIx0pjlSCbWEEK90ebc+sq7NNPS7QIcNzm4QZEYcAsMhbZWFVoze2Xhj+?=
 =?us-ascii?Q?72ou/7AnM7md2eYjXU/2ra3Pe4rIKbR4K1WeaBYAWigVpCmtdwsTXtqvcq2d?=
 =?us-ascii?Q?tCD5VeUewHZmEoljwxm5jC7fFL69H6nx88ABroCXItaIGtk+Y6MLKH1wfhHF?=
 =?us-ascii?Q?bRB4d3kQChHUYo9yqgDei68qLfHvyiaKGIA61omrZK0vls6xSY1mN67vW6ra?=
 =?us-ascii?Q?qiosS3ft7a4GvcEbUnAWmqK4fFQlTOdqyIxNExpN+Gq9DfApZmlSWeNPQknu?=
 =?us-ascii?Q?cHjNxLKv+mWZbfIkj1fHNxL8IpUHMoU1EgpAB4/j39uJqgN+dw6d5G4n9+Yr?=
 =?us-ascii?Q?4Fnnkbjh87CxjXp/RIku91ef6n5+TFVo9Pll0spBDTn8pJ1p5u5OtbHDfYNw?=
 =?us-ascii?Q?AQxDNWAjFxAcPP4kp5ghGyNaXd/9qKOU8RrFaPS/uykbHPG5jCMZvPFlrcdt?=
 =?us-ascii?Q?O6whqNJ1hRHpwlzvmRpb5aB+xaOnlYnYOmZ7fcWj4gGLbnm0MhYWg/BCkJ+w?=
 =?us-ascii?Q?V2zs13qPy4P72FiLYC4zbSD3IBfeoBlOhQyMpsNmQkxLGwfDJdGFjEMS5Bo2?=
 =?us-ascii?Q?hbltB2CZQI2auON0C+Mq8r077LMQMLlNPkHzmqajW1h4YYyqTKEJPWrIYaD0?=
 =?us-ascii?Q?BsO5WkawMikjRdn+BvLtfLXcrTTg32HFNOdd2TopQc4TQg1fI3sjYJyFhLHI?=
 =?us-ascii?Q?0gzM9goEd25Dae6bRGFh06E+2voYcqkYRAy5PEl+Skj9ouSpYC/5Ytnwx48n?=
 =?us-ascii?Q?8o8zSbYRB4xuKzgILvf+6+MAAApzXy+s8mOfa0QnFmWMW34A9UBesYCi6D9K?=
 =?us-ascii?Q?fPJsNUZQIDIFWoDQFqWwTle/DVwOLTJaJd7puHZQS8rj9F9AtYdGFXzYLIN/?=
 =?us-ascii?Q?TkP1csXdNlcUVlgQj6r8C+k1kBWSu3NATRMkMRWWX0Jqi6sGmxdDfhLmDW0t?=
 =?us-ascii?Q?owUxokW/0SPR2e5txoHtIgMX607WwFKshcU1KiN/VBhIRNKQBgtr8R+N6GCE?=
 =?us-ascii?Q?PpPjv1V88flvdfY0Q4hL6amKnOeGkfmnQDmsFIh66rnyLNYBoWy4PvEE5InI?=
 =?us-ascii?Q?yAStrxAixosM6s2OevDQlscZcebSI22n1mjPHfzLXXbBaGITA0wFTD8anpOn?=
 =?us-ascii?Q?8jU8oC/dfDvP19wgqMF5Mcb7iqEZA7jRRF1b02Q1UUJY+p6QgG/U6Qc7EpUC?=
 =?us-ascii?Q?GcA7t6scOyapDF24szvwCxBHus0pA+sOjUOKkxn96hczxHGMS2TA3f1Ofe79?=
 =?us-ascii?Q?F6CoVtLKGdaxaTJned9ybaJNxxlv2icvWvAGjt0wVamqpsbHXmuhhedCaDeP?=
 =?us-ascii?Q?19oVHlDv/qEXQywnZHjlUwYSfJvTu8TcE/lqoDdaOWRVL+Wg12gpF+X34/Hz?=
 =?us-ascii?Q?QJaz2JuQ5PlmwpCUi00oga7Sltw5B+NLJLfbWi6CUF4UJ65YsLStjm8U+4iY?=
 =?us-ascii?Q?lTWeNKRxxBsA0gQ5gT7IoQdOlUqWBGgAhYxm2iAkDNAuhK3PHuNcr1qGibq1?=
 =?us-ascii?Q?l8UGVMKJB8i2XVDTn6lY6dP2J01YIBNCqgAbyEImDbF6QqzZBuZ/sKMvFPVc?=
 =?us-ascii?Q?GXnJiiSbecffplDrF2aTTpfkPK78AMww7sL/DKKh9jp773af5Hoxh3+tQIgz?=
 =?us-ascii?Q?eM7cev0H+wIj6SGdspZCrSY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49aa7eda-d4bc-4d6b-a6df-08dbc325ae67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:58:01.1607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxYhmidQepsl0eiC2xXZZwUs2YHJzIKuECSAESg3ArC05+cXqAchA4sak+Ss/acssE7tkaUaRMsVF2kbs7ctnWWZfzubmlSxE36FSvRHqvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8657
Received-SPF: pass client-ip=2a01:111:f400:fe1f::711;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
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
 tests/qemu-iotests/165 | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index e3ef28e2ee..3181cccb89 100755
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
 
         result = self.vm.qmp('block-dirty-bitmap-clear', node='drive0',
-                             name='bitmap0')
+                             name=self.bitmap_name)
         self.assert_qmp(result, 'return', {})
 
         # Start with regions1
@@ -136,17 +140,23 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         self.writeRegions(regions2)
         assert sha256_1 == self.getSha256()
 
-        # Reopen to RW
-        result = self.vm.qmp('blockdev-reopen', options=[{
-            'node-name': 'node0',
-            'driver': iotests.imgfmt,
-            'file': {
-                'driver': 'file',
-                'filename': disk
-            },
-            'read-only': False
-        }])
-        self.assert_qmp(result, 'return', {})
+        if iotests.imgfmt == 'parallels':
+            # parallels doesn't support reopen
+            self.vm.shutdown()
+            self.vm = self.mkVm()
+            self.vm.launch()
+        else:
+            # Reopen to RW
+            result = self.vm.qmp('blockdev-reopen', options=[{
+                'node-name': 'node0',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': disk
+                },
+                'read-only': False
+            }])
+            self.assert_qmp(result, 'return', {})
 
         # Check that bitmap is reopened to RW and we can write to it.
         self.writeRegions(regions2)
@@ -156,6 +166,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'])
-- 
2.34.1


