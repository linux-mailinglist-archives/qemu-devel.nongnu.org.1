Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83481F666
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuJ-0008HO-Qz; Thu, 28 Dec 2023 04:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuH-0008Fl-IX; Thu, 28 Dec 2023 04:42:26 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuF-0008Gn-Vt; Thu, 28 Dec 2023 04:42:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu8HvYc3aPyxkqjLhhrgejWwogcXFAClkQ7i9VPVOuoeJbYgols21wyCYiTmjyK9OeIMTF66IFqq9dJnoAlgWCbvi+8VZdRbNXiLymMH4hoYdwTZjOQhy4chia3V2CrmpZjGLLVbELMilvUC9aflmMIVOBM//pMGCQYpI2sQaOdN85ykWaL/A8Eib6mJTdFnkhRrCOQocGwxDuRmpbyyIpB54/1kygVQfNIPaj+4vG+NYh+nPpsEDk2AsjNCKraAelv42kB5ZF7haZq/ecz1+rGe+mWDpZANJwQa+8ZCsxMaMv0EKNSkkPJ4xg3pQGrbcxb+OyW6AMoODXgoJjPdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=bxkLj3QAx5PbgonCGTHYa17f5tbbE/cAGebcHn4il5qWfIAZLzyPRttSkok8yN4RJrtHXZb+1El6DxRCX8LjKuzV9p9oQaup+9dR6fjl9H1q0cvJW1P12i2EhjPkgH8E7e8iZFJyqOI55k/B7iPXRho8dSCU946Ky2tRU/tkZY2ih9UwbU0/5Dpd8PlOMm8a9i0yJundlR2i7uu63GgH6khh7bgK5Cyxcyx5XK7tyDnzw1kC9I9xyck5Cd9CL+U+Rd3RdHv3Ejv2lJoVYgy6jsrMoAui4c3I/WvlbZIyYBcfjx+FJ4PtMS5ZVqi/1+T+ZXrAXw3fqrO/DPNBAhqj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylUSNpntRN+gDmFyGythjkA4Aww04xqGG3xhlvzvfEE=;
 b=EGkBxQnOTXDeN4pxJVPRA2ne3whn8T4JOLfZm6RPbcDn8UVbEacRP3iBneIZogTutUP89o6ZPtbqYvP8pZPbD9JZza1pGVuLnRtM8bDzDZMdOuykWBAISOKce8sUE7gEyVXsUiCOzjX3EDZ4IgFdW9CWIvXoBaXnxMklwolHXmdtrGgtzxa/79i0eaknTkgqaGLrxZgn7wQXItIKddVFNAjrAXxDpWCC33nOMq7s6GW91Q3GAjhqaLdD6WQ/IG0oqlY9kLSHnkFQyOF39zHRC8K7vY+nd4sETLI+yt4onnudXHDHkjJuZMnmjVKSBFvf8NtkiuD/KF14yQUgmcvC4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:09 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 20/21] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Thu, 28 Dec 2023 10:41:52 +0100
Message-Id: <20231228094153.370291-20-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4285f885-9a6c-4f31-2ac8-08dc0789416f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOlTWkGCEmYXMyS052ZZXajd8O+8sN0sda/AbiSr6PflnZBzzXXoEnJsJuqyyCRQgLOQpBfVLFxON9R3hlMzw2YFpoanuyFLN01r4Bw25UOMGCbwGD1mVzAIbfFUKuv19WQSR9pPFHa0DAQLr6MoUVD6EJMj+K185ZG8ix3WSmwRgKhHPPBW7gG8SBtMFLCjsrN3RI0atzdpsnhlsFC/0/TjpL37hwhdg3eI6r1ENwcvW0BH3b65pznpqakgyYUgcbMn/g081XugK+2B2zksaojdYZMhzJfHk28hOKwmeYmNSR/7/b1OpZIV9zz9ouqAJ0WtdQ9pWnmM4JVx95B8PnHqS7lRp6P3lBspUtPG7soFDfAuy3Mc0gGcZ0tv5wQXXVl/CqllWfKL7Tii0JAfQ4gNHxY3qwfEqKNOgrxJnJBT91dzIGbRbPTbDaCQT03nn4JvXgc1nxXAiH53dtWb8lsoblohyKDngW/DZMvM9wOa85b4sD32pSlWFxKAoNR2aUJpKLbjoBSdZAjdpzhXP0/HGYbmFVFz/s2fPcADFvEvISKdbNoZyWIW8LL7LPley1jkQM+dqoQu1+poF2dKeOFnEOdoO8wowiIFoDieAICWAb/UdMP0RoMTZcWSsECy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7VmP8xA6+JI+d3ePgdj8XsNY6H7/fSRMcNumvqsBWYl1LU+n+e/yiLGj+QT?=
 =?us-ascii?Q?wnqxZ3CbBu0UlDotHj818CAdO8ZW7aW1ftmif7cFUjG9MPi44M3gtlmHUUBt?=
 =?us-ascii?Q?rPuMJ3N1JQYXJwrPQUEbyspP6ybr1pxxz0Q8MbPocZLQWyodXGG42svk/ey4?=
 =?us-ascii?Q?xdntbcUHDqPLxo9Bhyfyh2jmsWwLGH0Tpipq84G1Ej+d0dQx943dfOAGAnkb?=
 =?us-ascii?Q?44JjnICSRHb93tqqHx4cq9Bozbys5mbZJ+U2f1ebcpySPQGTHd/up4fSlUyJ?=
 =?us-ascii?Q?FRetFjEq8oMTj4dOJvQHmds85pvCqKpFnQ2ys2G0UY+Vnt8NsI3QzuI0l8/C?=
 =?us-ascii?Q?f24zLWyetAqTsNDAn1QhjPgV07Zzxr0bMbXX2+EoIvaLgSWxffUbFfNYGMge?=
 =?us-ascii?Q?pk6NEvqTN4FVvdEIJhNuWqaF4wuojkgUAwU5s6BNIzrO2JabdZGk9iZt3ZC5?=
 =?us-ascii?Q?O+K18h44CIYHSUh8nC8np2IXBz02DhBKQzSebwhrDMZ+QJ5OQNRTSS8g2GKf?=
 =?us-ascii?Q?YANUASdFrN7uQGDEmh0JrZPQqy38kOXPHvS/xJLtVIZm5xTm3sBmZeIZaZeY?=
 =?us-ascii?Q?hpwl6jupuPG+JKEp6TBT1Snc1SZ53DwPzcFAJWowhxLpikKI3ciPp7qULjaf?=
 =?us-ascii?Q?K9Q+5G41zw5P1TiBIH9dNOqTdmGcTqqYWflJhb3rpFcpy48/95kO8tKXb8cf?=
 =?us-ascii?Q?Qj/1rJQrx81YnHXphcUm0TIl3lhTpFknyJB+Sazz2Xh+eLZ1Mp5gh9CHxhgO?=
 =?us-ascii?Q?Sfdel68Yk2cf/SgcgyA1/4uxUVk6WcunvFSJrG6YK+yr6+9/wuGGDGRmrr2a?=
 =?us-ascii?Q?U1FJLKxExyXwuCCkbnmX26BwHQ5iVIlyc8JVpeQtAyqwP9cfwtjsS+G+JMHN?=
 =?us-ascii?Q?Rbi/z0wxChLpqFKUqySkxSJzqf+VGu8gmGwIEKUWajPR2oyBrgBVjCUZ/vNT?=
 =?us-ascii?Q?tbA249rK5x/pY8Db4UD3izO4RhKDp8bZ3xnzz07qgIlL6EoPFeHVyfqlTGPk?=
 =?us-ascii?Q?V0a+nPPiZhGvywjt+GJkUvpppZ7xTCLhqU9+3lAI5OGNi5DUaQA4dN+Rr8tn?=
 =?us-ascii?Q?eQWRiKiWsWj8RTOb8fw7fr9/DfTr2NVPZ71Nh9lzDeNv8sPUXJkq1XHST4ol?=
 =?us-ascii?Q?PubgVQN0waJ4XsjbMbMcFJg8yHXAX/qEMNs+towTbrSsxNdWIOBJ5VtZjKwZ?=
 =?us-ascii?Q?ltiN7s/uLj88uL3s0Utq4CnYtvE2RK0CHoTRjK5b4/3k84zgnMmzwXzCUm3U?=
 =?us-ascii?Q?b+NF9Z18/bSv+XrhYumo03qk9f2xVEDz3qMZYlzraLLTTqKo+gDpDiZN8ui4?=
 =?us-ascii?Q?a3dDtgCjkn+tMz3ampp4WJH3qsK5xPafyimX4Gm8OckX+mYTuPJCAE/fQ+DP?=
 =?us-ascii?Q?TwBYHsMgB6MfWtrxBH1cB3nhfyUnkF0SsDYCu0A29DQKc+DRd6OmjmYFy03N?=
 =?us-ascii?Q?SFm98RJdb1gRsAPIAyyDqFlq0lWc7ivlmgWR6wvjA47TF8C/yM9VX9G5YmhC?=
 =?us-ascii?Q?o4Bmic0fE2VN4X8tlzMMW2I5PY6tAToUJpBELcXxVVN+ZZvp3SX80ONm4TjV?=
 =?us-ascii?Q?olTmw0OSivWA/9bh2UZ1D9RFvdyuHFTQFXv7c0SDuXOSjLuOm/VyGggkhlcY?=
 =?us-ascii?Q?pq2Bkdf0/lgPJ46nUNkVz0k=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285f885-9a6c-4f31-2ac8-08dc0789416f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:07.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPO6otOkys06TCajj0feGz8d+uRK2Crw9QEmh9sfI4SSzrNDA7eETNVX/PgynaQMxOaqRNP3uAR817cSooynIUYAes2XNkY04BnyOcGpCTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
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


