Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 068A07D9055
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZK-0007ke-V3; Fri, 27 Oct 2023 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYc-0007Aq-NR; Fri, 27 Oct 2023 03:47:14 -0400
Received: from mail-db5eur02on20728.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::728]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYZ-00041O-TC; Fri, 27 Oct 2023 03:47:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbtAJ/ifmtb+XG7OWyhRtHtGBHKLpROaKntpc6En4QM0myuH4I7KE5XWOEi9n1Wc9p1lV3QVcy7qaVqrFC0jhaJBkvqEvXv9jkEnjlxnkkKjO0BzcoiDjkFKy0gMy6i54oVw6pKESM7LOiolg7/yT7wDwlx9qHG4iWpa9nTIm/Lhm10BBEJCLji33VZz5plUP1V4fFWMZIC2aPZqNw5uKqYoO2v/aFgPtXPJ6p+d4u9agqic7xud+kg7bCdGu4xr3aqTFGFyrZdsbkr2aP0YV07joiFqkGWcJhqusmQ7YJSnf/ISxI4Vjs07Sxu/S6ReZ347HINo3YEsVBjYxPwbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djhWzR1OD9wSw+5JwkKqbMpl26LmShHjJ4ERxNNSq+8=;
 b=TnHDKpsr+Ne9kSWn6oV+kRCqdIJXYY6IpzopQk6o0d4xTA9brZ1t5+Yn+KMbGgi0HjTMOAS2D7yeXFUXX8oFAChPw2Io1374gi5T0rxAMVhDz2IFyukZCiuHIc1IlcAiYGrs7iBZV8xcj/8SmDvnmKyVjYUSYztxBUh+oyuEGGYyCwLKLrxXYMJ51Vh5/1FNBIz0QHz3HRL7fOW/53B03Osm/ehJVmMzxgcfjG4g6+UGvNll12eNdKJe6Axx/KPHxt9MqYK9kW4CzAARvndpdiVuaaVL4YxpDFNlp60cdG0ysHqaYnSjBy2M9kxIpBeL0nH73tJrhkpfB087n1JvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djhWzR1OD9wSw+5JwkKqbMpl26LmShHjJ4ERxNNSq+8=;
 b=VKZ4PpjG3VuK8SCKKEHB/RgN6AxpY433ReH6AEjfNE333qmZWG3OsoF61TxvHWHMh+Xqkm7HyjtbXFcV8eQ7ECZV+n/Z3Z7sC7oXCwT7jWdLnfrbEOIUQpyuaIEba5egnxWIbhcCFGQFWH6/bweWM3nHZkQCnGxz5x5ug0H+f40ZZXgVRBVMEJYiKibHkTslCLxERtPB/7Jkq91LFfT2eliyaqSC3/Qnh+LEMf4puikjYgZHf4mT/2H5jb2UbkhcblGfCtLfGut3aJrHk0x8TzluLycXrEa5K/wI8CNGusJFuyw8CynO8P9TRMnZk2sDMB3Ze0AHeokGUx2MZzwh3Q==
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
 07:46:53 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 20/21] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Fri, 27 Oct 2023 09:46:35 +0200
Message-Id: <20231027074636.430139-21-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5dd57c4-748b-4139-fc75-08dbd6c0e136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7i0ErnS8/UqvsfyUqwjsbOYUb7EajwGJ0n/klOZAc2IbdZ4HqvHia2VxZuJTFKmJhKhLFj/ThP63hfcSCwuR/YHmXHD2qND4NcLBBnF4aHf/TmDBXBs3JGfVAz446UngEEuuKDpXgGSzpsmpFu+yYqmY5J5XWIC4HbkZPBt5tkGNZ8c1Ft2sbuX3oalhPagIPPDT0qso12rHIdgjZm5XSU2kDBDxUmmiYYP8GKP0oyinGaJpEa/WbCrZSDLaiHX7GPFhxiDZu8Hd0PLYUqt6dtmrmmVrQp24PZB2e5eBFckWAQGyFC/8BpowZS6Y7FHadEJ3s4CXK1ksaShUP/3HxGOwQz9GhjryPai5Dhz6YV2yxiYzm5qbtK1N1LS+FZ648/6oLxgFLMpGNRGnHP+AoUFGqoDCCC4LCDAALohnF0E6+3RK4J1U01sg8uo2Xw/BgOHJajfnLdEp3JnwtTRAdJAHCCsm+Ilqr/7ZPy4sfZwG7EZOBIjmuZkGfcxogdUn9+6Hjaw1F/eNUzp8RHUBod8IEp0Pr0YEcFWkFywl4nKjum7g90xB+HebqKi3oEteOHoo0EqLTs8VVB/7+AO4yFhNWa0B5IvTdDECoU9FzV4DRDnMto4dDLL4GNwShyRQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8676002)(4326008)(8936002)(83380400001)(26005)(38350700005)(5660300002)(38100700002)(86362001)(36756003)(2906002)(44832011)(41300700001)(6512007)(52116002)(478600001)(6486002)(6506007)(6666004)(66476007)(2616005)(66556008)(66946007)(6916009)(1076003)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ikJFKO/bws34AJw4v8IFsl8FiFO5xq9JRHUZMX6nE3fp+9tDa5c+YtHjX3x?=
 =?us-ascii?Q?8HXWhdCmWgXFnB+oABcN5/LjV7ZNpiQw1/NRtQrNKkyXy6xEo0LS85CHmjvY?=
 =?us-ascii?Q?gtm4WkNZkX2lYzi8izXUNdWn5IXq/NL20yWmaLuATOl6MBoQ6FOtRgl8Ew+C?=
 =?us-ascii?Q?RfUe05r48BBKHSkto3FySrCTvVn6MYBW95ISwJg6zqi1Wdhz7uwVzqbsFBve?=
 =?us-ascii?Q?Di2EAyW0kASl83RBtE1BYaokee2R2SHHsfu9AOQdi69qJpK1pr5ScMT0tUm7?=
 =?us-ascii?Q?vduLo4dE3S7E6+OP6rp6J8+c8iUNwueD8OG9Qbd1MTft5IMdciQ98wGIppC8?=
 =?us-ascii?Q?wnZ6bC9EpJukXFYweoYjQ+Yqlz5ov+w/mXucjJlwZuSHt0V+1UzbErNmnQeJ?=
 =?us-ascii?Q?zu1NzSFjYKC0P1lkmeewEyWCQ4dZw0o7iwS80FgFaKnzVohII7/zc/w14w25?=
 =?us-ascii?Q?8fL0Z6oCXSNrhxP0Iy0tnKKW0uD9C2v1EjHW3TxGf/jURKMZSBPlF5rBwqUU?=
 =?us-ascii?Q?DrokqtcscdwQxO4WW5HIFICBctV+GUa5GLgo8Pq02xXd3IPDcEa2bSqs3y7I?=
 =?us-ascii?Q?pyEejHLNOMlQT8VqxUwJCrCWrWEaB6ZHM46XgQ5wqfbXGvSvcnCDpPyo4zML?=
 =?us-ascii?Q?q/YADhJvFzwUKeudvCk/6AFTYdc25bTyMNTtZgvFUTGv+BKYbKDeN/b4Ir1k?=
 =?us-ascii?Q?Q1SV5fYEmMqGE9cKp581Zm5BlbaTD/0xIU/Xg95Gz79tjGs6ztqmi6iOT+3O?=
 =?us-ascii?Q?lI0YfUejwxjbrbSoaID7VS0HSJQSSNqQbBigr/uy9YcfjOrYAbluEjTqMMny?=
 =?us-ascii?Q?ptPnXghcjsu43+8CMzMDEogHIFOGbFw5zZ+twMlJcE5RXZ2R8lM09YG2TlG/?=
 =?us-ascii?Q?Vppfaj1Y7FPUAbz3RSeNrceIBjbYfDeGIQXtBfMJGjn6iqjiEFaxPbc6QvOn?=
 =?us-ascii?Q?9Nd4fOIYyMyH2vbdFeunB1lamZb9E1DtaaLZF1tUja2WMxdjjKpcYICU3plf?=
 =?us-ascii?Q?pUI1iUP0F5btG3jwqQWYQYtyEAoAeGwd/AHRmBQhtmiUlNuxfzuOEJBBAFhT?=
 =?us-ascii?Q?Z+R1sOZ1i197cVQPE9+vEX5CeSl8oWDgs/2pGDAe6EvQmESLWetzASudPjFt?=
 =?us-ascii?Q?IybChIWMTYWKMIabu4Z5PBxjjep3DDTj9BbbUfBrmMtoe0SW+AELFtKt3bUH?=
 =?us-ascii?Q?w+0njys1xMlCWT4IBlg9Uf2DvbRJnW3YWSL8z8DM6J63CDk9ZVbGpY9kBhDB?=
 =?us-ascii?Q?lwwvWcxRhBmWR3Bf6TMsy9OEC4DNMRyu901oYB3RrkHO0gPTIoPGtCxSaFCM?=
 =?us-ascii?Q?MeJxIRfNyTVhq8P+nILxiGSOipTzc9BC2HxeXdeQIqOaN/Oo5EiBp02V/wI6?=
 =?us-ascii?Q?HttT4XJenOh95mTyjmd6KhyQmE6f9ptQ4wcLAj7snobbf4aRHm4SxJRdP/Qb?=
 =?us-ascii?Q?XTx+a96gUiyzIq6aaRnDJcV7rjQWxUYXQXC9nqF54naBMRepiTOUI68IZvxc?=
 =?us-ascii?Q?f1BOW/0hYy1KHBX+S3UHBDe7qSxTBIHzInfzTW3e6PIpST0O+qTiNbYsHKop?=
 =?us-ascii?Q?8CdaypMTShTeR4TH3XIMEFFWZ1IyS+8TGpd5bW5uLBxjpsu5W2AK9jucp6RF?=
 =?us-ascii?Q?7adHiZ43/rZOOP565giJTeg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dd57c4-748b-4139-fc75-08dbd6c0e136
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:50.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/fPoZ+sgacc/0JOBI3He0wpNLAy1JqUP8nIH2GNM4V791NKHD0arFHLUcuPecOdYu7VIgxRHmuMqVlpLTgRyNU7w/oC4QE9V2T2PwcY7E0=
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
2.34.1


