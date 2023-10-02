Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D057B4E62
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl3-0001lP-3x; Mon, 02 Oct 2023 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkh-0001RP-56; Mon, 02 Oct 2023 04:58:07 -0400
Received: from mail-ve1eur01on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::711]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkf-0003Rj-72; Mon, 02 Oct 2023 04:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEDjFGXBk4jPBdsOdb16U6Dt3DwNnYr0wXF/MuTJxTZfs7Uq6ABc84BSRydrONUZNWaENmZKxrE4LWjXx/pdyvOQF60sJXar5Ia0TOMhKz1CWSMMiyTJKg0Rw0v7aiYPosrlaw+vGhkWiWswyWySD7tbImEDWCArYpHFZ1by0PDVnbETjj0fskqkKyyalqFdDdI9jN6IcUBAV2QidyvVrnHz9u3R61BsyHm4mhd4GQduFvqmpGWv4rsTtNn3L1WJEGkITF6NtdofiFppghJV3NgISQbYvGEucI/fIpJKei3TjV19JiwyMpp1Iwix2Cw6HBGTYbxu8WzKq94oxyBIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX95/OsRXapbuLFMQW0E3mhRS4vcJN++F3Atcc0YZ5A=;
 b=bBvzObPxILK0m3PeBXIjA0kbpIvq15vg/wz5MphxnN61wJBko4QUpND5U69xoYdjXngbmig7DXBTap7oTFNL1fYjUdKKM5wDFihn2VU030BNe0c5xQvEbySxRBWC7aJbSGwIWZtatB/uwkVHmOuB+e2Ugrv9mV6SFgi0EsrSxmloWoChJ2Lp2Sit++QXeUfWR0glEKa9nwS480Ws/7mvklwmsWKe42QkV0BYBfcfRG5F9kHIGaJig1j5CCbILeW7s8ZKh3TYpLunpTd/ewzL/q3/s3tBNdR2s9Tddl4XQtxVt7iDxB8GJIHShok40CSGvosa1P2iQtzwhwl3FwMfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX95/OsRXapbuLFMQW0E3mhRS4vcJN++F3Atcc0YZ5A=;
 b=IhjmLfTQdE/giYsbe9AsheYTk/HhLSiYkYGD3H5r4RPYn3NH0zFzZFCRtz4W7CQCPnglxw1BgOzKPkUmOkYTcxfdcXsN3JmnQfVxZvp3LTEpodMDAmGvOZXcAaZjoHO5geaTQ0OmZx9Skw6EQ6NIjhxRRxKUqHTh/IBwosd/MbDhNgSAHiX5Y6wbywymz6yjeVYtqWaUB6YBpWfG3muivmtjqUn/fvuOtlVdHbedRgdEMClDOnDWJdmrJBO3SvzeXav8on0vsy8rtnVPJ55Ug4z76RpJ98ZmMRjw4nCgaOVCmNF5uKDU84N+dg3kX5sW4J+jj3klYeVLh2CPey0IHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8657.eurprd08.prod.outlook.com (2603:10a6:20b:565::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 08:58:02 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:58:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 18/19] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Mon,  2 Oct 2023 10:57:37 +0200
Message-Id: <20231002085738.369684-19-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f2b6ec7-b67e-489c-77fd-08dbc325aedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23Nx12nENEU9A4bPhZ1GNrfKwU3NT0g5yyghX97mPKZnxjS72jZQ9uTVX+9j54xkgTayGP6HcmjaknCSLkc88P7Fty+79A16+RReJj4EDOMfwFZmf2XCtyARdylTkm9gt0qxO+dPny4dJh3a4RHttFhKOPt/R4Ui8gNY9yh0bB7FBkctSELcd/IKoXcsWXUfb58d9ycFtzlSXEeajPriP73sE75UbapgR4gmpMjBwdI/57aIRRl1n/tbjYmobaXz4LJTa+YoQr59Pbrb4sDQbx+1nEXb6v9me6PqLpMVU4A9I7Id0tLHqnKPceKc7wiO8Fb4p5JHRbem4hid5ZkepvAldgGubRADzr1/SASq3n/o7PoTf10L54b+PWkKg0yOoPhQ+FiyYHQs+6haLhHZTJpASHs6fAGozT8EFJ7V+xFMg/Efr4dyFSnlWOinT1dQAsuTuwx800UwQA5XqsSMdVVDFYmxWImu25a6+QA2FupwtFxgiiMnBp9YOxdQEAaza70V4Y+FhKdmF5qr+NhHCogHE02QzWlPuotRHo0yPeoJ4GASo+Ve63+9E4V73sMR24Fwe+OyLtde0rEiOPe3mvbwX6UXPi5PsZ9SAoL072Gc4pk6IBjj0cFpH3CyRgge
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39840400004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66946007)(2906002)(8936002)(8676002)(44832011)(4326008)(6916009)(5660300002)(316002)(66476007)(66556008)(41300700001)(6486002)(478600001)(6512007)(6506007)(6666004)(52116002)(26005)(1076003)(2616005)(83380400001)(38100700002)(38350700002)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q1X6vyItI553iUfQOvhfDOoO39LZ17/lszeSfCiZxMLEIs0bdGDDolRgSqLu?=
 =?us-ascii?Q?xg7MCAusnqvg/W0CHsMKXEioF5o00j13+1HQBDShOPOqcoLletKcQvajKkwA?=
 =?us-ascii?Q?igoIaaVy9IKHeEhXrPbyymHRX+evPffUyJJPcgAZH4UshtXarW7LIjktksSA?=
 =?us-ascii?Q?QB0CFkBax55BcIb8VFzWu7hGDiOgNKXIsPYTPY6exxr9iyfH6f5oXQ7ZQk+I?=
 =?us-ascii?Q?KI0+CIQzhZ98MfnbZNhH1TkL3yNMUxdWX6GN9VV1sv2gYvKNhAJ4RwEVla0B?=
 =?us-ascii?Q?D/oBMHhF8bO/mO8jRem+Kc1lpITZ/VFIs2B+3YoE+PM3MGAE2nEbt1J+0QqS?=
 =?us-ascii?Q?FTIuSLkdBfB0MFSxlKSbe28VA7q1w0oIA4AUBuMjBobmHyreYg7h72ITkgQj?=
 =?us-ascii?Q?5eLenMtiXkxys4cOtt7PhciFT8mbI0/dzLC9koHh8kXBXMlcL6J3Ila9YK0C?=
 =?us-ascii?Q?hdubnXFpX1SlZcdmWDr3gQZUK2n3YbCBJS7Tb3ZSeD6leDmZ/cVsqBpWlXsl?=
 =?us-ascii?Q?jBWxk/UKDJ+sbiLzThxyRUZM2KLabSCUq3Dy0CDDCkV9LZ1980QOMP8ZdeMP?=
 =?us-ascii?Q?6OkNHKJu9Ye+MTC2lQCQCxuHnkR5OQc5Ba0EDxcKmtZWL0MSOGjPUrRemhX3?=
 =?us-ascii?Q?btIy94POw35jnpRMhz1QUZjJ8UDYHcqNwsMxeRsmqUiMS9g+3ZP1fc7eK4AI?=
 =?us-ascii?Q?IIfyyiVPomLXD8L2ASnJ5hSv+eYQxZfQgsMs+9qn948MMj/EFIpTH1NOKjvD?=
 =?us-ascii?Q?jG5wqVmDWhy3QN7ojaP7qHrmElGGWYsGPjEcyLVB64wtwPsna3fbu8VFXlW7?=
 =?us-ascii?Q?fVHGHb27UnB3Jtv+6JvMNvnjyolrTeIiWwhW4BFN8aOJmmc9S9aF/mrwF+Q8?=
 =?us-ascii?Q?JqrMJ+GTQWgYcdVcyc8G+5GGZ6MlCMipuF9yi4I1vdZHum59KeqVIQCEvD7L?=
 =?us-ascii?Q?6Cw87bBqJhHW3iEf6JAUNtoJHkV3j+6hvV/AP5TO9BSN3FkZG2BaSWKTQOv0?=
 =?us-ascii?Q?wXcgowRgIWc0RQOB2GUvV8fUC8sD2e52o0zOkXm9DU6TqSgnKsq6G0Se54Xo?=
 =?us-ascii?Q?AHn+wJJxllrOpX082he3dT4SFYA54fnAjnF5VxS+nZ5T19ZnnEypFxS213WK?=
 =?us-ascii?Q?hwXxd9YZkZ3xLv3rhpPIv7lZxEhR/8MTzHz8L0r/tunYTpAYtgkCzDLs0o4k?=
 =?us-ascii?Q?6orT/oEIVB8lb8OmpH4STHm40w6w9XMVbjhkXrAQyQFKQ7JZ2ZeBrn4/KEq4?=
 =?us-ascii?Q?qqnTyl+pd+g/uWTSHrpwSK6jJ3Ciko9ry2zpgrBTYw4BzSsTVrTTk3POpbtm?=
 =?us-ascii?Q?rz7XLOAH3Now9MoTLBmEY7x0jK4XAbUOWRtsTZ8vROk0Kp1uQO6Iod/VeclV?=
 =?us-ascii?Q?Tu87dt7pVGRmAz4uM1fXK/oLop9JncYq/9YlHZNL+yMNmLKjl1VC/MscS8Z7?=
 =?us-ascii?Q?8lY1q8C9Z5YVyls+oDRmCa6cEWjtvSHBQX2i4Qtu4f/vlPxGj7ITdyNZJ2a4?=
 =?us-ascii?Q?EQQVsxc4jXcMf8N2vRhKGLlHwrochkWZ4A+NM+D6gKJ7Go7DjSzTDvVD4dT7?=
 =?us-ascii?Q?XkAS+pdsAfVKebXNV9EVez+WwRG3Ez4rSkZFvYCdIc9Q6NeWpwV0NwuBb/Ut?=
 =?us-ascii?Q?tvyBty8d+s1EevuEhR+7W1w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2b6ec7-b67e-489c-77fd-08dbc325aedc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:58:01.9802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQiFSI7z3w4d9AearKUNvM/v7oc/AbP4dik2s6HE9tsf7Gd2fHNl5yXnGsCqU0fIXblflKz8g1wQ/1MSx/NBfsNAsQc+QYyszP+ZVJw4INE=
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
index d7e67f4a05..1930bb017e 100755
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


