Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB0F81F6CD
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOM-0005eb-VI; Thu, 28 Dec 2023 05:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNu-0005Lb-Dk; Thu, 28 Dec 2023 05:13:02 -0500
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNs-0000fc-2h; Thu, 28 Dec 2023 05:13:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfxuocrVSYnnPw9P8hwi/f/rT19pxSKmA3rtRPcz3c4BunNNFjKVyq0xwkkKODzMOJ+KLpeozgr2vJ84gCFbXElLltjXzAa5qkW9O+cHFY2N0npC+NSPBTlAnHNBgUSonCz7FZGHRIM4ler0+sPyXhmtSrMdR20CLR9oH9wex9rkb716n2q/xZFsiimPqj76tn+f3hEU2S32csbp69J/E3IFr1OTiprT8vgjaqMG3/Hm4AiceRPyxCU6QzgTEm7aNKZTonDaHReeC9U5lWAn1nPpPhU+DDOZBOAp03gmREIRCo3jGQy68HCvfBBxaosnpOejPUkVhfGaDvJwcIbvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=dm7WJmfSjQJrVSNPnqzsjy0ODMzw3TUS2q+AcsFok1XSRtqeBvzuS0KEW0lu9QUJv+4LgmiruNd94Cgo2yPCvLXWV5dYijskB4xBa0jTP5DaTJEvMGyCbu0wS3B6MshA4SADtKjoOfGueLF1vdCyfDOQ7mgQuHzB3L3gGZztqDrvJhdGzH+YXzrYlNAN72tyDTz8ZqYvaVqQBhGctmx4eEHMGzvDSlA6Yn+AxMiankybJvuySTj9ucT0T9k1e++WK/NeKrBJkQXNZ+rd1uy64g+WyRerAtUpmFLp8ti228Kgg/HGDLRu/hYfXUFMZRNGOkbjm/Z9na80+Tvl3eJn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=sFrr+k8/rsNJdTBvyNHmt1xb8O8mLYZ+cjwYg80ZelvSDkbcyN+5GOnLpel9NZGp6YBrNwy3OyiWiINi39kAlrkpq7jv+X1kOCfH2G8mB96zASeqA+51K5bEHWvEoWDJAe8y7baBu/8ukaO0npApHjHWbnbSmPIoPqmRgf+C6wWFhtqHTJsJu/4r3gcv06nmK6qsO9zh01wjE0G75vJZbZ46B++W8+Q+j6sKJMFNYGWjSgWFsBJt/BJ12BOQWYykfVxKMRoYzAPAp0O2rtqj6VRin77H/eORxt7m+HG5QE4v1jcta313T5b/38n2O43SKVzA8K9XIoc5HCMICDw88A==
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
Subject: [PATCH v4 20/21] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Thu, 28 Dec 2023 11:12:31 +0100
Message-Id: <20231228101232.372142-21-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b7e753f-a52a-4c0e-192a-08dc078d8ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTFVGslErcdUZU7uZ17b7NdcWbiL9mhxMePUdry4wlNHNM31y3P4/S01byM2e3DNTnnWwDOSYYam0hl4MXgcRQrN65D80GjX+6DtZnt/wQqUG6UdCG+Q7zEmvpB5uLdn0w/8BTDdb5dj3pi97F2T2BaSCkMuvFa/144cL3zQTnTrsl87Hcrtz3NAfF+4H8c+9/Fk+jvL01GjcUZ76Bgeku4ouH/VxoAXtWyYfznAiQ1zAGXFkjts0CI9+oWe7Z1JK3iBaNNNo1VmSBu5Zx15i8R+VCHikr5GUEuR1JDBlhqaZh396ZlYwyAHdHDRq4yBd/IabVphFDoHXF0ezYNh4e+uJb/pZTIvG6J0eWpE42exUrdG159xBP1pYEddK/f+RaUIR0gJefd2hZ5G2wc4+JQrfDkOFY9patLHdXQzX330CUhdoZg287lTWNb/LeKNnTuwrtlCfUYoZIwkLHzOpLyCeEAMViuYhDKfOejcMqFlwUetSmuuW9zJ0oHHjpjsbGgN2oMb7KDPhuzbaP9Oi46Pm+D3pfLGtzyKd5SZxDkW6pLctHaivJtEERMvcXfGnNeZXVVwr/Ha1kJFjhvQgpyJ/epX3NslS9QE6LXTwiYJvuwTRxEoAiTIyPI4G+Hg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MkNC9FETqtB0UXfYDKYn/D1hMD3nh70oWvumdrDKRZ3xgwbs8PCpPDWIu8iy?=
 =?us-ascii?Q?LytGyVlDJyy00ZeOVj6nmHdmS/AUb9JzrShZAiDNJ6D8LVvYuNaGznCFjir8?=
 =?us-ascii?Q?S6pAUutoRXfttNd7NJZIg7X4hNtp9BVA98oxdig+Cwv8mZjikIKP4So7Wpfx?=
 =?us-ascii?Q?fj0rZVRGCRYJI72g5qy+/lMIeUbozbgPVvcexmGxMTuZwefG9g65v7qXFctv?=
 =?us-ascii?Q?cYZjiZ4Wv7VXz0+law7qvMTyuyKvmll4YYFvPx8b/QWpsYFbv6i0xkWPnn6r?=
 =?us-ascii?Q?IMbYIg/EKmtyo01xB8XThCvWRkohAZPpCFd8I5avTetUlJW4geRYSLsc1Yz+?=
 =?us-ascii?Q?UVCqt7dCesYnWgPjUs1uvlaWCNGvY5aenf6nGYNPGVwNrXfnlb8fzpWRXm89?=
 =?us-ascii?Q?+VLiWuwB1c1o98TaaXtkQLBCLSh7RrzkwBZRvcHbQmlsOF0QxR/1/yKjOkpb?=
 =?us-ascii?Q?sKfReLgEYvK+0baXVtx2Y27lfNVhOApq77jylSz1p4kj0FQw7F35ma4R8l9+?=
 =?us-ascii?Q?aMxhbq5Gcjk3rhq0I2v0AIf2x2dX3udR0qtfFoaONBslscdEAphjUDORhw8f?=
 =?us-ascii?Q?SuHq3t5Pb70pixIs5E5Ev4BT1ArqRbBCfCioBoXqnZO1kcHCND8CGZHmE+er?=
 =?us-ascii?Q?ed2K35xFOqMFiEO5+g4vQeAwVlkbsbQlcBxk7QZGeEjCqDdbWfvjouXUvGzb?=
 =?us-ascii?Q?F/nztXiOVk6qNKK9O+StCysz6QuYiVRmXbuz2HuTu0KenValan2w50yC8Vyo?=
 =?us-ascii?Q?2M5Fquh2l6/fpmFEj5B9bb3C6OnfEQY+VKJGTXhXp6iD294oTcQU1YUvgsA9?=
 =?us-ascii?Q?s9HjUafSx+Gi78vrJWj0Y3T9sLMBxuBqCHfrmyxOMSQQ7wRJ7uQdSVhtw+XF?=
 =?us-ascii?Q?Mfo8L5WQ5Wdo2d4Dz0trokavJh8lCn2k2xZ0ZCwOm8KCgGjChrQV99VVDlNC?=
 =?us-ascii?Q?kEKH/TpGyBBpvM5b4sJDnYapUbkUVXMuHNshnDlEqhACvhBUsrpNB71g+ws7?=
 =?us-ascii?Q?BCsU56kAaMGU81kLAVP3tqAIeLCHC9H2bqZxY5t4lLRgBPt71N8vJv7Vkg65?=
 =?us-ascii?Q?JjhC8oiPwhsO0f7ihIjG3/Lc3sVyG17vvJJZhGMs6E5ADwPqGbCpFbS1vX0W?=
 =?us-ascii?Q?jLp/gc9aqSrrl8Ai2qFdl03FoJjn7aLIHYC/LPwrQxGeaDh+UG2JEm8a7Z3Q?=
 =?us-ascii?Q?DgFxBUvOwpMmyt1welrWReJg7DUMS+n8hZ/JIwqWMlBMApfDak0eqbjVq3Iu?=
 =?us-ascii?Q?3ZJPCUGX3s5JMdKZii3ZYKCPB2pKYSINtGqS9kI75tP0QgrdUaQPrgaHz0mc?=
 =?us-ascii?Q?ivxKyLAdc+P4L7sQUKwsoERE24e2PnEaRatt4LeRYV/Iiyxe5BpGtqSSgmiY?=
 =?us-ascii?Q?q092dH7qy+3xJzzGHZ/e17fjpQrRcIaeTyxu2A9uudFB4at1Vh3oDwT6NVmR?=
 =?us-ascii?Q?+PzTsWLe3ayMQI8rk35dRJygjtmAE5Qfd9azFPOGBH4KIbsz4RTcxlfBbT9l?=
 =?us-ascii?Q?rJxWV+7XNP6S02NVsN1X10B4aLYO0sTV9S8ADYfOWXZwKCxCEq+gu/4M10km?=
 =?us-ascii?Q?uonzlFlL/d5Ab3gw/v4IMpbQJR5gdtdEWADK8/moBXShv4AYwhaZkIbBY9O5?=
 =?us-ascii?Q?IiuavTtLkFMYc3Ihynr9S+g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7e753f-a52a-4c0e-192a-08dc078d8ce7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:51.6787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/8iIoT3a7VjAktyqA8NBZtnGn+oiQ7HngUxAlZwZy+TWUIeUSgLAMe21lRqz9+w3P3hIrYYjAI9O/ISkGP7TeKTXUbrv9mUH81ESCyHg5o=
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

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f282087..1ebf999930 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'])
 
 test_img = file_path('test.qcow2')
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.40.1


