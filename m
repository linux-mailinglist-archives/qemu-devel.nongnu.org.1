Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CC81F6C5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:15:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOL-0005ay-Un; Thu, 28 Dec 2023 05:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInO3-0005Pa-1H; Thu, 28 Dec 2023 05:13:12 -0500
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNz-0000fc-LG; Thu, 28 Dec 2023 05:13:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C31bIajTKGAuI8dIdTVxyFtdgEXTJ+dzfRuFcntLWuPYa2r342NnzX+m4YIQdLXNWwbsj0GtLGTLt/I1wM1+z0bNe6i2vV+HMej2XdcMVbBaM3J/JvXA7zzI9Lu/NtDcTgebcGuEW97oGTNc9AHUwMiBLEEj5k7WG8f/xP6tV0yFNHGhngANUrDh4oPL6WZs6mgKUviupdADKFc3HHe3dcRjQnTb5JYhvv9EeiuKbcYQOe208nEQ7y+oNh+dAPn6tXJcMknwmihRmVVYQtWBMdKjvgLTSdw0tG450HLLdS3pKbSFNLvjVhqmt8beQcKp++Qle9aEgSpDe0M7bW+LfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=KakrbuwDggi34dtDNQfn9BA+zwZfmIDQ9CRtxB6uyVIZRdvb7vjAnoGVIHstkjrxJSzyEVE6JFJrmi4UG0ZGYvTya14mX25r4F7nHcqxZBykYwvmjc5yvJtLfsRAx7qSWVat1q+qohHjkwpByIvROQeMQiDp9yzoNzcZONn1Jrn8nLdzLhy4ECLdJ+QHDN0oMJiFTH0RTGKp2ETkKZO4ISM3SIAlbPEFfVY2pooSfDB8rqLMdoALP7wEc68Ny3JXnAQ3GyE1PCDwI4R0a3QGh+bbxzBi7OckVFFl7otNSDttvd9hYcaycsFvKzqDdTnR4pH0Opjf4MBJskdP+CS6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iutxc8tg7YChZVrBnNEg2aHUVzHlrCXYIXjWGG/15z4=;
 b=hvAbT03aUMvLKeGvsg1u8FcOSWAoriF0bQB4sNKIMzCoQ8iyiWFpRF877BlDPgZnVUPpVlLTpLqZw4zpJu6KxhLuht7zpWlP1w8d7gqn6naXrWRxuPB8cP3IiU+Pgb9fnEhyCHBb1QKs2ahXczjBesnG7x0hYNrCzleE45Dxim/VJlairvXUTcgGiax4cXNlIuEaasOqHllHEOLTjrytFIV74uxbXTs/Z3u1JMsH2e1kTnynzDb9OdIYJ0TvzxneMp1mpt8yW5XnJtbeXzqpl75LIly6GJuHn1Qzx5QFsNjQMgZvLn5JqbjNf+nNGsttw5MonmZscFsFFBWF1J+8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:51 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:51 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 19/21] tests: Add parallels images support to test 165
Date: Thu, 28 Dec 2023 11:12:30 +0100
Message-Id: <20231228101232.372142-20-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ed2aafd-1a1c-4a3d-a550-08dc078d8c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbFPmUmqbbNu/rX0YWSdieBuEgFrBo6DvQP5OtwZXY5AwPzS4HKNXvfgoGEXZXrZsl6nc2Wa20ngnUSIjAXm2s7srtJPGKPletXFx95SIka89bKqEU4qzxYwLX9XBiceKQfhVUU91KyboQDMiU2ZJ37U5DeLHxsqk378wETPE+N3Zy+1H/4fLpjOnVOQDfrziXU/jBWppcDZdjsJrhqD49DEVN4bYJ1ExSnSUFM7TTqFxn7Pg/5oLxhWG9GaMVOKJSou3ZlqxZEj3CQnquYMYitRhPSmi3WPe44MfCdo6Skv7bvTXae9TKVLkoRPnR477WpiBTHzeEodyBvgFeNChdGX3qkdoLJdLdxjQgVHwZ761oGXKodmGrrU88/I5jZwwNHdKJGGmQpufZ5FrN/U3pbL2CjAYkE8TQl/A3aV0DCA+O+/qMomeAum74O7V0OAIb/jpQvQ5r99uEFp1wnq7TlvpLPwyGFT9O7KHae6vdowVdHiEJjMGSy7gVVt+17kWN8QDn12rPxJe0XP/iEIoMOwKA5AzrY/FjhalBdfETDbBWDXDDdv9X1vNR3+QlHlfmMmSNabExVaE0LV7HRZXJ8pEGIB4cTAVHDOuIwykJGcYax/NrPvCbbCfnT4HLeF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+0vbxgmpqGMsNf2Qks9fC/HruP12ybyKZNd/VNNLArdwroogOFwO711bJEi?=
 =?us-ascii?Q?+KcVpyvsuNTqNUjoTqE6vwla+nbEetF3dT1QitBfZ3BNDa9jgw1dYo3vAOtu?=
 =?us-ascii?Q?ZeUUSDdPzqfOVAU4vFc8pV0C2+i2l/xmB2sZ9sKzdlABcjAesIreOUk4jUP/?=
 =?us-ascii?Q?aj76V7TyTRjtgomzKs/NtE6lf63RA6ccPyKkEX5hbDqd2U84UkysPqkdpqCG?=
 =?us-ascii?Q?BBhcrHTbt0VmmpKsa9miDaAWU5FkvLym17bwgb3+GqbpkUWyA3END1e8S06P?=
 =?us-ascii?Q?4nb6jAwIF37fm1oP82Gj61DXftPDMVjdqKbyyJGF8zsdfu//hSQCPDqCGKVU?=
 =?us-ascii?Q?XsSPtZKtz+NvXILielFOW7/Z0wNUtV7VzPnYyjAuQ1UofmFqfNApPMnjNrod?=
 =?us-ascii?Q?cJgImdkJgizYrxDGFXz6BkFTNaAqYE62J4fdR7kGe5/1LUNiJ8VYXMzPYs3y?=
 =?us-ascii?Q?XpEUPny8WGGywuXw7gOsvUgGG5oqb3uDA+hwAQgmqEXkA1+NBD1MC8T4xySy?=
 =?us-ascii?Q?5qeS52y59+XqxNDGVZbfys1oDFo2ZCw14BTg53sxuiXEs3l+JzWUFIP6LinR?=
 =?us-ascii?Q?4EkVutpccRpNr5Ta8xQpCdQBZbszd/k6n/ahoEjYEEmDASSBhqt/URJNUWlA?=
 =?us-ascii?Q?MCKL8tFKovALPNxPexHtQKMVmNET+vZRMsgk1iQevbD6XXd2hVo7pBgKtQvr?=
 =?us-ascii?Q?Vi8S5HwHvXqWxj27pXNgiiYrBMnlP831c/zJhDlpsVtXa6UCjU1PrxJg91YD?=
 =?us-ascii?Q?bA063SGwYp1l4G1Ow0pTWhzI+xnp1lBnXmRc8MjX79SmG3MaKxtta63bQvBO?=
 =?us-ascii?Q?Q/+dvUNRkz3mo13LWev6hKybPF/HJdncy1uAiOtYpKhfBa+O8YPOt95tGLoF?=
 =?us-ascii?Q?lcs2duA2lMOeLggmiieI5mGQD1QrFhV0Xx1ZoTokkkBrwShVmJD5HsovMEEM?=
 =?us-ascii?Q?Mb2HlktVL7FqTa7GJgvE+Vu2Z+m5g6cxmFqvZr/mPhrCvMpetGTKZsKP6Q1a?=
 =?us-ascii?Q?VaG4+0OWo0KtCRhMVLKJz5u+S6urc27dLCVHd/2ZKxwqML6x18f90gD7aYB1?=
 =?us-ascii?Q?4c9V0uxBC3cmV7m4Y/fl1IOQXnfKOhrlCJBlklSBwVDXu2DNG1dHslwl3QF9?=
 =?us-ascii?Q?8qyzK8IBnU10gZDfsBeKi2+2b8REUefCqrIyVZtE44NbmwSCK3+Ee6y841+E?=
 =?us-ascii?Q?VaTU0ovJNvCWevTkiUB5DOBRw1WTW1fMlzGJgv6sBCX7OMLVkrFeuG4gkJjE?=
 =?us-ascii?Q?UXGirDXZYV/moCVFOgnJtazMNMSc6VFhA4u1vNucIUTPXPszwb1Fa+VXMG9c?=
 =?us-ascii?Q?bTFMLDRq/4rzMK6KNu9PnmWrdWZAcjT1ZgXjyyxCMiQ3P0KZi1nNTLKQJoG2?=
 =?us-ascii?Q?GxHbaIWGlRtjjvPCubzBi7aGhmOOdfnfBiA5vsk95O1BMNv3ezGXkAGuOll3?=
 =?us-ascii?Q?FljNgHJvOMF0gxxX+j09YZAbtuTKTzekc507eRy+cGLCRJ92RMwmITsOcFEi?=
 =?us-ascii?Q?LZo1sT/CPYR2EVMIqMi1qezI7xURVZIUya95YIeY2JJlNYTmYiJx0TDFeUlL?=
 =?us-ascii?Q?ZC9sLxLjnlXrC+0WkIjCL72GVXBmgkE+cZNE0ocKKrudoGg2hPz9Jg2li2oP?=
 =?us-ascii?Q?9++TI57IfGZrGnOqCFf2714=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed2aafd-1a1c-4a3d-a550-08dc078d8c93
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:51.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMx0W5kSfpn5wqViCa9auQaqeHDsC1wwOT5J1hRhYuQy4cyq/GomRgCkxWqgdWxESdqBqAD4poUFAEiR9wlYMCgQI6pwTWLaUAzR64E1kKA=
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


