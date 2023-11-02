Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EF7DF89E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybP9-0004fs-E2; Thu, 02 Nov 2023 13:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP7-0004eU-HW
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:49 -0400
Received: from mail-lo2gbr01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe15::707]
 helo=GBR01-LO2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP6-0004ME-3q
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hufquIzBQ/j0sxFnLwed8+eVr6WLAWca+QSE0PqbjBb6iyoRcayqvaDLEXrszAMJXLggy0dlbBvtg56zWDOl+/K21HCfApz5GMDfa40e0JSWaPNLZA7YlLO/iB8nMtIRfqi/K0kukyWrhkg33bwRzklG6C1qko0x6T0RGNHD4dYNuoy+4/S1+t55gt3RIs6a/W97Zxs6c1HFp1jtRCzYUsVmIFf0P0+mfaRqNDKeOScItcCbZpghFXeUf8xys7uVG+SIK/KOjCq/iWQJnnF153DcRHpMhAIO1+R3SUS7qpGrJO7k4ynDecFy1fr1NgI/QK9wOgnlG10W8veoT/FY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCbZ8rkYogmfNOg2aliXSXgPWrYaiHvbDmIe0+nPzWc=;
 b=gHBwYT5bVexmf6TUZypXYJU0zRs50FokDa/B+UiYomjEE/agfsGtzOjr88qO3od2WS7AqJUruwSw7wPrZHHlZGlMeELyYuYJbRlPkmL3+sIG8H9FNfn3+kNG9TIiML5aV12xuYvtLxBc5HJtF39AWdX3Jd7LHpuWjj71ZKK4oajdAg8xys2CZgAWakTvYqzVtliWWPQLfg0wF+9x8iL7NkpbiDb46cvOmq2H7xZd52aGwZjVskmOSRfJK5QvnDT79Y0cAFkeARGUGkBesriNHbxw8xFu8O1cIQP2txaRqRWsC72UBR7XE7VaJZnzElwUmGE/7CAdNeAUPXfQOfzdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCbZ8rkYogmfNOg2aliXSXgPWrYaiHvbDmIe0+nPzWc=;
 b=YAWB9OxoTdGKzE29EvbbNwrT5+IYJYQ+sIdu7UoFDY2I6EuRM0s7Nxi1dRA78nFdX/Ea+vWAVSevTbQxLlcTWLE/uPTOR4sH0hIqLYfoO47Cq69Qbz+6IBs2wOyvpG111ES7h5cTM5EXcBpcqozjAg+YkIKGFRo48ZIA0Ab/KkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::8)
 by CWXP123MB3365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:22:38 +0000
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9]) by LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 17:22:38 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 3/4] plugins: disable lockstep plugin on windows
Date: Thu,  2 Nov 2023 17:19:46 +0000
Message-ID: <20231102172053.17692-4-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102172053.17692-1-gmanning@rapitasystems.com>
References: <20231102172053.17692-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:19a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4352:EE_|CWXP123MB3365:EE_
X-MS-Office365-Filtering-Correlation-Id: a905f7ae-d942-4613-008f-08dbdbc84fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: paaEh8ZRnNJKy9gZbwT/k1vQdUMsToE9m9YEASPWweSCkT9itK1/mR8vezQt91s13tqdRBHNDDl+gCXaIX+bSt3iH2hdI2NFjy2FOpnKp+fny3tdlSZZ1XhmObq32fm7NH2pSN6wIzxyEkJ4+oH5hpS3/6f/AykrAziz2eV6PXyGcDwwCHNUO6vUbCWNXmIx/NFKIN3HCDdQVRsy7FpoMfDtuOTycf8zGHM2U3t8ZHLTo7cXpktc17/VdY8XMy2+Xeyq8EQwLLCikwPoApa9nfmXbrKoPtwJ3eG2gflq97bRdXMKDzx2gCVCzOUApefFgPJq4fjM9GJGeCXupPs21QrK9Rq+8PnPiLmZbz61SV1yTb2enY4LzPBmCDXDFQdyZvssKUrhS0DBYZcWYQd8vWUQbQGA2KfNlZHfGT8vg4gJLqeWD97Q/zj4qHpz9xECjdXHJh9We7jMZHtlrBSeeF+vs+iU3QOteNW7L+58Qttv4AIZpJI5UFud86SZtoPzvaQN+Q5SAhePorjsiyRz5dHFjZwWeZP7KopuUqiOQZK7gOMvEu5Fc1yOT/6Ep0KV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(54906003)(6916009)(66476007)(66946007)(316002)(6506007)(478600001)(1076003)(6666004)(107886003)(2616005)(4326008)(26005)(8936002)(83380400001)(8676002)(6486002)(6512007)(5660300002)(36756003)(4744005)(2906002)(38100700002)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbNLiFfdkfuT85gmiBU6Su1ABHC+cL8M6CkY8gG/HO1E2eaakpmcz0vq30WZ?=
 =?us-ascii?Q?/K8GVgIOeXjdL6aEuC919ftCJWZkkzTalopyT+4TVJP//qGAzOKkpm9WIlul?=
 =?us-ascii?Q?o8ajHLP1ybAbZh3sWVAh+ZR1rUZs7JBFOqEpDcMm+OsnKm6o87yudeHbJUP4?=
 =?us-ascii?Q?J/DdB1E8V/dsN2a2xwPo2D2V2UKAZLU9FM3BZz3rM1P1PD3gTf0IpmP/s09t?=
 =?us-ascii?Q?8ZbyB9sG0IgAcdeOZxkog5ukMSfjOWYXoRcQHaBLVeKLCsiNNzJyDy220XWU?=
 =?us-ascii?Q?pBtq/gq/J5pLh+flTmMKDoHMt0x1F5u6wc63b7P9wWeXvN5FFzBuKYV5wa8I?=
 =?us-ascii?Q?//vpn19A5nYEru47AVA3sxS0YFdoBRYrsZ6Lu9wOMQt+zpZxL5tZOkcV0KUK?=
 =?us-ascii?Q?nGAoZzAXferzcNCmJRrB7WOyoAzddOLHG2hibYIld27Ie70tUZWwCNhLWjHH?=
 =?us-ascii?Q?Jz0SCuRQcyogJVqZJQh1NYJL5LtdVr5yU0rYmTWE7qKNFuMCB1Ehh7N9MUwu?=
 =?us-ascii?Q?Six+FziREH5r7NYxTrs4qUjpglSIfLjcN23R6kxXOLDBWdhyth3hC3WvVx83?=
 =?us-ascii?Q?AKDsqbQga5vnZ6XRpc6ysKl/nuj9i6QDK0D/KtztU9d/P1q3GBzm5taWatms?=
 =?us-ascii?Q?tuVRkY7v4qRGHS2gsSw2moTcx7yGM+pMS87HA7RE9gKS5y7uxMR6xWPRnOrv?=
 =?us-ascii?Q?9z0ANezDIljolV16dJ41F4wxzQGtQgm8kEQULO0pNv9f5mBqL13tlsAIjTkc?=
 =?us-ascii?Q?K7UF6lfzcJaSmb/wacU9L5d2jyKQwU49ETy1vngwCFBpe1Os0PvHG3qq5H5u?=
 =?us-ascii?Q?PJAH+adE+uIhj961Q40JFBdpNUoghbgTdtDA6TfyaCQUzjEpkxUO7J5AxLJt?=
 =?us-ascii?Q?1nxlScLhF+eaXmb/S/Uj2L/8PfS5HgvVxCiQSQ5bK2Y1d7GUtS7nCNNaEwJc?=
 =?us-ascii?Q?racyjeX36twnLjYB/WY0Kok9doyygrnylyPfUDaIAu6eJUHPt6YzQLcBB4mv?=
 =?us-ascii?Q?++d/wPKTEhb8jOQCMAJKms/sfA1dzzGxd9Mw8bjgkehVkt2K2+bSOFC7vrux?=
 =?us-ascii?Q?F8b5peOL4hbB9sjgZL4N6FhnMHwkJEeoOeFXH7tJ25KorES87RaWJ8Aw++6v?=
 =?us-ascii?Q?WJmzYYFN7t5xIKEx9hiNZTjb84sE65IKSK7FkuwxiFIr7iStFaAgmBc654Be?=
 =?us-ascii?Q?ngZW4ULEnyYdldbQljjbIT3tiYQ4NeN9JRIwZlfc2UzrKsrbS/z9D+U7nnLC?=
 =?us-ascii?Q?cnLuxbwyrzECQXMzWv8JUWe2ZjJVHqeNxNFl7aCvAhyo2QbLvLhAhARM3Gfq?=
 =?us-ascii?Q?kH5iXhreddZeHI8T6LHAmkRurHtYHzbCd1skdeceYcke7fGaBpAcM01CjBeH?=
 =?us-ascii?Q?HiIJPYTsWdJNxk2/jSWW/OJI6anzdq5zgoaJyfvOlPI4ZKDd/3li8y2H27Ig?=
 =?us-ascii?Q?1lXV+qTmoEUc7JyOJQHhGEM4Eaa7MCEyMnLp8PtVoNI5Lb7ATQA0sAb1TkDz?=
 =?us-ascii?Q?74KzO5zm6iiiKB9Zb3HQQMxedmw8+NT2SgRx9sR8FS22qTHxi6FGlyS1UPpa?=
 =?us-ascii?Q?9o0gEAPHRqRiDuf7/N1zIrF3sD46DeiwYxT4k8SvU672elzbX44mC7GvlC3A?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a905f7ae-d942-4613-008f-08dbdbc84fa8
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:22:38.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYCNgv973aD0uOf9qbNqeqv199aSXgZsxN4MN8o5NbRiOKmNZ5BeYdaXcgrWEe38RrmZ1hgJry8BGZ3UpUThdqCZcuO85PpLXgeqttK7Y7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3365
Received-SPF: pass client-ip=2a01:111:f400:fe15::707;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO2-obe.outbound.protection.outlook.com
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

The lockstep plugin uses unix sockets and would require a different
communication mechanism to work on Windows.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
---
 contrib/plugins/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 751fa38619..1783750cf6 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -17,7 +17,13 @@ NAMES += execlog
 NAMES += hotblocks
 NAMES += hotpages
 NAMES += howvec
+
+# The lockstep example communicates using unix sockets,
+# and can't be easily made to work on windows.
+ifneq ($(CONFIG_WIN32),y)
 NAMES += lockstep
+endif
+
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
-- 
2.42.0


