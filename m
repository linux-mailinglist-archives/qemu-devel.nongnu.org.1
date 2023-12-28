Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67081F66A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuN-0008KQ-8K; Thu, 28 Dec 2023 04:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuG-0008Fk-IT; Thu, 28 Dec 2023 04:42:25 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuF-0008HI-0X; Thu, 28 Dec 2023 04:42:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu/fZsASy0jyqFNVIr3mvGIKnKnogr6bPHpkBRJrjSdpPJNbMcX5gOuY5+ae/TeLvi2/HklgH2ycRzrhHtBgK4HDJwUH2/G0UU5QTo5kansLa+UPkv7u0On9E1mIXQH7KBWCwc4BdOjroPyS4K79PSy8BzNafmDKkWTL3wGBLBBWstVMrFi4jDtJpiNO3y3+J3Qsgrs8NlOzMGcBohxeyRmHDoWwCzhQ3x6SDk4trg0eSn4UesYh6VLb9AmEod40qedMAWRDpnAyGoH4B7ZrU2Kpon1rGQHZhoi1gJCcjm0dUmAS3wjDyyOCl3KzRDSzmP0VoPZc9AVcDcQsOtBrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=E0N/Hn6PjV+qPcVa/TFW86aOeKmH58KThJ+sfUGo2CBKmE87OP4ESvnNKQBjHIpKJuyLinFJCy/cxFc95myX0ygn59N3vMMLxkWfy8DRPMtL/Kn8tssH3W/bkB+UfIkdG7OeKs10KQeblTCbXtq4zwp456xEOrBPNKRawmeXcmW+KzCbDiDKsC+66xB1a1jBu51tmtJcZZk4BBJbB/QKKGnL24IGpsy+8Z/1HOjhvE3necZoCGrqYR5ejfu4i3tM/lD7qGAn+BR/pFsLPHqu5DLChK2+Nl97T53SUqWb0uy0hzvQEpMLRrST0Cysqs7AMQVF9uEKxHdG+5oYqMMQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=vqoBqp9N271ZEoK3TigCCS6gtR+PR5bhJVtrgrIoWuhvuO9H8e7SoDsX0I20q84MHFipWAigeeTwMuztwKRlDDo7Lbcvq63CDVDyzUSWPD8pIUAq9kIwO6buDOzUfdVZIB7BE2Xc9uYgrUTB4HntyiK2f5lffx+il4t6YnfUEP4oupkHkUec6gBCuVu+zIimXn4KpJhMtMVAEVTMQoPBVgnwjFRFHrEGy+oh7moSL+KEq8bep9sKHrUCRya8O4x+yzZRW1mvy7fvWBqi8nJwvDNWMdxEzDL34TP9z0ZKqQgielw4lUx4YMD7IMvMl9El4YO5rn5uwUZ0BZ7JmujuNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:07 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 19/21] tests: Add parallels images support to test 165
Date: Thu, 28 Dec 2023 10:41:51 +0100
Message-Id: <20231228094153.370291-19-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e053e66c-cb63-4568-6806-08dc0789412c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwakORyIRpGnAnJJitPNeuESWqSoDdtL07syOKjgjjT/uZA/leagx71JT0Wnp9jiDhpaKJ62AxtFbXq1Y+IUMXkJWG3oqlIRIbwX6BO7OObOCdKFriTXczQLL1z8ULnlUN2HLpj9Ak5eAEMDeUuTn6i0JVOkNMzSeq6JxdB3mQjkzwagE/c3gAoxKTWoKExsB488CvElYCKqrGjaggnZCiKDW40pqQ+sIwmPgdspOb1yGQbR0i2pIwW/Fk+TI7e3dGKsTn2m2spaqFC0mIZTqGC+7ps1GB+d+Uuq9I5L9OxIe1+TsyWvGnQx11QA1S8XM1Bj3Sj37MTVwONYWtgKnyXyffbGbQ2hHgtSJ7s6LZvinKfPQd4OkSu3PSSx6tvczBNsAmhSaKfeDoMPRVY+5kmK3LzAc/p8jULREy20wIJHpfDQbO/41Ow+rSA0IhrZEdRxwRD2G/X2FcUBnhCen6eE313NlErM4eW3iP2DmXECv3PNmw8q2NlGF12uQTyXvy/01XjAviB1qvVoCqJuJ0cRTEPvLZ/GUjNjwmytE5Y8BFhKxu3noe1kMjQEQQSUOM44As3puMoWmN23RJcTPBmuS1icxTUcOPSIUjGLTNIBlgQCkaqjuvjyAMuey36K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eBDspf8G1rVpxhH7gI7YAMDWXOXdfWuMMREd9TECAaYHdM9rm/vfoLohQqA?=
 =?us-ascii?Q?PlF/PJlmdQoCMnZTGClDTyUQuUR2vTK+N7BGq1srsRp/FQeuzmTo/Pi6o6sH?=
 =?us-ascii?Q?z4Mc2c3r3Ho2/CcbNRA27yEsGxjhpMzDbMbkG7Q/aFtvisBinx/cm+pD3X4X?=
 =?us-ascii?Q?F61Iiq0cDkYCHiWuwrYcw1trvlcLW0GUH08VLIqaaLEqZibr51c050eI7kFI?=
 =?us-ascii?Q?CefusKo6dtS+VqsX2tEoXeTts1mLfhvG6QVNH7oevOazScCrQR140Xn85auN?=
 =?us-ascii?Q?RFndXXdADztj9bVu5gSm49yESyXxyFIiPeloRsIUf7vPO9fBDvvJH43cRmsS?=
 =?us-ascii?Q?sH7BjLAH61ye+DaJ3DFFrgoj5+vdhHSqfNSSKyGk/RFT4bz7iP+izmzJr5bq?=
 =?us-ascii?Q?mneM2Oe8Qg1egBo9ls/XOGNYcrcSih4MG0Kp0CI3toRJ7DaAomVwRPaxeaAg?=
 =?us-ascii?Q?wrJLfSOhVvcFvKUeGdNBx9Wxl0robFbWmb9WP+WMAZqAFGfmRDv+SUlZPOKM?=
 =?us-ascii?Q?352HFv5lxybKwrarxTnxMYemPe8K0zaPazYKWsbFWwSgwYHdWzzPpeF7kyWP?=
 =?us-ascii?Q?Jrkqe0qDuy2/iTh2h5afIa0/PO4AIazvk+NNkEYAWN3Mr35FTYxNCoKQ9km5?=
 =?us-ascii?Q?q7J55hycq+Y9iJM3D0ysM8+P5nPA6LnBIw2QmCTbsPn19ALCOzrbSP8qLdj9?=
 =?us-ascii?Q?O48nmkODsSmuZI5Nc2XgV5JOQ2EWtfzaf7unGd2WuZko5E1KYOGZi9s0UaEj?=
 =?us-ascii?Q?KW0cem64CpyGDDV4VqANcN797a60atpWQORcNKCnSX4qVVZvdLW/EuBwNWLU?=
 =?us-ascii?Q?FDv4tAaZvE2VTH+n4KZcRajTrXLX9oBe6QubmB7yNE9b45lH5W+qR/4Jvs88?=
 =?us-ascii?Q?UuajaiR570cAC8CAWWxUeMo5WP4VmrT9/wAq8k4+nA1CaKObrGtV/zzUDIyB?=
 =?us-ascii?Q?GqXkD867fIQT+M61RiEz7+VLhzRZJiovznr75kuNV7NfCPG+gyb+iTY/1in3?=
 =?us-ascii?Q?NvWUeugUCvggJIHQxi8LHcXeQBXx1SRoV8czTMeiqXKLKgqWpgB6eAWKMMXp?=
 =?us-ascii?Q?VsjHZ/BuhFuKTSLnhcIX0rC6hGS4Q78OevZP+o1TkTSk9FxpzEaJUe5aARQn?=
 =?us-ascii?Q?3qNT1g2p6n9VaX8XBnPOuYzy3QIu+3WHUfqzUJqsZR4dI4WctnYt94wUeuQX?=
 =?us-ascii?Q?gcjy4DWaQHPQYSkqZxcjmtM1phvt0Eb9i4inESAS1x2iidxeuRveA4+0Yjjf?=
 =?us-ascii?Q?HHK0dWUcKyahD2CCqzcdtRSZjLhVo4E4nx5an3TDNTQC7JCpfGQoK6C4TK6L?=
 =?us-ascii?Q?IQwGmsYJy8F61FA2S+UCuADVxRCq5ICwf/yA2X5/atgibU02eiaWEw/EV9Pi?=
 =?us-ascii?Q?TGasCrjhQauPGCfYRwmU+Ks/fapAiqy5NU0hoOoFHgZp91ZKNYksNzdEwraI?=
 =?us-ascii?Q?htxed/bXO4v4uWDKbpOrfJ29FJuFHew//FMw59/szR7PvjLCqg4gd+6HmdMj?=
 =?us-ascii?Q?p1sYNpwRmHPc6H9eHpbVK+PO/KUrLSCtfnr0rPbHbjO/ykPY6z8lwlVrbAmm?=
 =?us-ascii?Q?VGBZ93ZeM/dkZc6mAX3Ls9hmmn7KIhlS1tpq2CgUSPlItdLRRw7b1isMtucJ?=
 =?us-ascii?Q?iVQvfjnJwkrx2uJ984UzPwE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e053e66c-cb63-4568-6806-08dc0789412c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:06.6625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sjE6w92we8XX4ywoeZYTtJEk64hzkfvZqLjLhoGUkVXEDt6B5zd0BpXs84etYkxMZZSQGHvQdg+xPKmsIaBBVfXM34zgUHllFSUWAfoKZM=
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
2.40.1


