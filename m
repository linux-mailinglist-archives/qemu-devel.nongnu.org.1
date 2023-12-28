Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76CB81F668
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuI-0008FN-GU; Thu, 28 Dec 2023 04:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu6-0008Az-Jv; Thu, 28 Dec 2023 04:42:14 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu4-0008HI-05; Thu, 28 Dec 2023 04:42:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIWZ7kJLUzelUzJsKjt2qM3fchxDJpDmwiPbv6g0NNR8Lnj45a0+QZvQb2etpE1orIUGEj6VeDzptRqIAdFMpRxh4fRTPy8aVT73ObocIwQiTc/U9lLfJEXzriAALbBtRx0i/uUSeGYCB/lC7Eiqma4/NNd/D9QUBpBa+fwghloUkFzpvjQ3rCOfGmIe/Ucnq8TaML+Fmi60lEWnsW6d56+LpsBP6DjYxdSugnwAsxVGI1bwK/kig9LqumFGqTPGx4zBYyoF8+bp0qZnZUVdS4UgrD5NP9XqQInrrx4TTtejNNmaweXBSadUxpPAL1GFCcImYN36bAQ8ZOfgf8qtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N2JwpCNxcAlatSCQUrsyN56yKpu3V05h+Yb8Q3o20U=;
 b=hF8vkuDyBHaCbT4ZyZHmLx8aEaCUCWwOPv+pJXxcHpt82qQIKORV2pVWbbOFQnsHT4Yis/I+wmnxw4k0KtMzW0Hc3Eqt53XUR2/mliRdXzlG8z1VYs2sKA3veRF1S5iApf1WtiM5Nhjds/KjCDgzvpQ8E18WwStcTWrCyw3v0EU46sXSRWUq9cwCmYcvg9fUhBMIa+OSHsCBSVrOzfvgLCQIms77etLAt1Ct1dRqI6lJHG0CdFsGv65MJWL4QkxjmqymYdtr5xg2e7ZQ+ZfXQDHu7mEN5qkXvVCWXkfaoo2y28VPSFV5RK9WxB+TkSrREaiurhRLI2ONaynYqv/aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N2JwpCNxcAlatSCQUrsyN56yKpu3V05h+Yb8Q3o20U=;
 b=LcMnk0A7Y4Rg5KNAy6ql7AzqU6KdXQln+WM8S7W9qWSpWjakgBFtTngQjKQO73g3QRIkJQXwCOWLwz+n9W08wuJIm1DZ8iGSlbUvav8QCjFcyZnO97yr/xK3PxVH076TrQe7Qk3CH/H1UPkO9V7G+vaYyyE9QNKCMtwRkYRW2JB98aaEQ+zgfCg5yf+dtbArOfllO3Qk30wCPJHChzLXEN8FPag0C/lUvAF53cMMJ0APTjdz2JBZySH1Ta4GvS6YHj3OY0CJwkJqBTNkHsi16qXB64I3IxInVZxdSjPl1jg5DlYyQ7vOcCakIyDeOrxPPQd+f5D8atUpGxXmBTnuHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:03 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:02 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 07/21] parallels: Set data_end value in parallels_check_leak()
Date: Thu, 28 Dec 2023 10:41:39 +0100
Message-Id: <20231228094153.370291-7-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 548142f8-7c00-4701-6c1f-08dc07893e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwJwAcepU85mGStiHgOpt2fMyRrvvcjp3bQWlH625Auf836BRsNXWOmT6Y9WipNpwnY/BDEmjXnbAGCFDNgub6t7H7aLq0uTcjREpJWa3rH7ZK/W7dj5kHajg19LZbLhQWwbL7RwU70RL6s+RRirS/IrqAm4SqUssYda4IHI8eseQGomYoeoS5myb2/1Dn10cCfurjNCnhywNmqTZIK1m+p+DWa547sunTbOUzXaUh1YlWIRJ9trPK+gUQM5gNF9Kkw8ihafHhBqOFEICfKAwehA9/enhXZN32/ZLHE7mWOYhT7le6Pk+rwJYROOpA1MSeLO8KDTj75SiLvsD7kyta5x+oBKb42Oq6nlYOTsCtQq4UlgiBi5O+JfnFSgeyO+QggMWbNdjp6+rLtYgspive+ddEgePOeyPkim2nYNkx6TiyJIiQ3BiFevfUVdC7xVhMnBdNeqW6Mq0iS186V0hg1Id/ogU/uBcd5h348pG7i/bmEF5rkXCIBPWwo4Lzjn8dquWZhGXNg3FjOmzhEw3qOTkHbDn1LVL+mhVGJ1Uba/RUQFDm5/fTklhCAc635FoZf9L0e1gUU9hUXmPa1XbsUHGr9q5npEj3WjplXK4hLXc35yXi//CcGlnFXAdbf2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(4744005)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQeXoH7k1CcH4WNc/G7LfakxakrdQ+T3XqwG8bnpTExWOG/HpXLk+cvIKprm?=
 =?us-ascii?Q?u+wyAoNsVCVm4ybYHAszpNoQs+fY88bNHu2WSM8GzZJ34/4EPoKVhFMcaskB?=
 =?us-ascii?Q?QYhVImjR/sla+GoykRu9vPAWUJrp1gnB/D0PSLlJsGbdBIrpbVTuSNY5dCRU?=
 =?us-ascii?Q?ePa06KEHmj28ow2xzyFahyVp1Oea385pBiDJQR06nbpBHmo5a0s5FkII24KG?=
 =?us-ascii?Q?ZjTcCw/YTGV/yYtEPCRdHnaiHtl8x969IxCRW49oXZVIgZsCgIqqIpy8qm8e?=
 =?us-ascii?Q?e55kGbQzkNU28eWEjJ2EJEPybQz/XTaSGMUJ8DIrxRvVRK3C0FjPYHrhxmZ0?=
 =?us-ascii?Q?KNV/wBGK1Cu2vqwoK/7roFd4LOa+5hvqb9CNyhB7BNK4u6vYwxqXlmpm44Bp?=
 =?us-ascii?Q?8tJWRC3y11z3/W0LGM++lz7CAh8NcGEGU8Obp+1A4xphEjfz1FjXofiwO/2O?=
 =?us-ascii?Q?yhRHCRUceaSGMuK1qvVMO1qDEH/zzYKmc6XuBqvb1RWFPVDL/P4AvkrrWIl1?=
 =?us-ascii?Q?cq1Wv7jESa2hoVKsTvk+4VgzMi8jQTeurrng7Ufs+3GTrZ2MFo+xGzQUyIHU?=
 =?us-ascii?Q?lRYFwMnSyL96vewKXg5ap6kTD6e/jta7UXsZYhaQ50MXSkyecdXneFQ1AaqF?=
 =?us-ascii?Q?2YUg/GNdOJIcfgItWjhurSB+dBV1Raha2RzBbRugY809BuWO1+NfSjYvHtH0?=
 =?us-ascii?Q?8tn2bxKDPVmZ4IDB8WtX+sMHk9cBmhP2SR8yrd4fS70Mv31O9sK1bxPly1PJ?=
 =?us-ascii?Q?FhT+F9bmeCBd9aR/FkgkN9zRspT09gscrDzhK2PkxW/LLI5XqqnQpYZShxcn?=
 =?us-ascii?Q?DCWEgSyLdabCTp3uR90hXbChCBmn2OXXSj2XMEmhGnQ2PIpPrXA/ZTEmDtth?=
 =?us-ascii?Q?snSyZ8k7AFpon6aM7vaFIN194ucAvJwwe1JAtzYdG1UaPwqowuBkacRGG0LP?=
 =?us-ascii?Q?Gtxt7Ph0hbD4qpXPE9H6r4McJWbpG2jyDYlCHBOU5JpxrUakAs6xmywjZdNH?=
 =?us-ascii?Q?TIKMQ0fbRRLJmush4fdPf6BcTObhUo5PrFIDM5zaK4ltqu+4OmmNRrtjudmZ?=
 =?us-ascii?Q?ESJD9mmQCofcjLBHv+5d5YUGaH3FUKxf4MedzKtzqwWtiIVn1h4BU+q3H2Aw?=
 =?us-ascii?Q?b7tc6FuQB8WxV9GUWHDAn+LsDT4lyFlHCWmJ87IMTY6t66BCTTv6NqH4ewbG?=
 =?us-ascii?Q?fBhEBvLZ5lGKADTsK4OuNq5JS+5yMgpdFL//pdb/p8oCVhs9PpdXvQgicssK?=
 =?us-ascii?Q?ObG9tq2Bax2w4XyVGtUetTNpYlsD/NZ5E7KDZSAViJu+2k8dnPlZXkYbxPS4?=
 =?us-ascii?Q?F6ZjDKzMh41M8U03NQMl3AjSuwvHLW3L5GzPNK/foKoaw6TqcxgvMZuBG4sD?=
 =?us-ascii?Q?jm/yuZSVzwmYOECDq0s9chgfAVu5XDFGGTOKVa+nyC9WsQZpnW/ZtAIFYhkV?=
 =?us-ascii?Q?qpY01kFn2WUlNSBQNZ7Z3sJhI5uiDoGv8xB6PAvl9aNc5eo4zqtg90fSq+sw?=
 =?us-ascii?Q?RmQO3c2hs3eZdgHmLZPXSIw2V8WC21sR7IjF9laKJgaglXJUXT0VIq3/CEhO?=
 =?us-ascii?Q?u0czeMhEeEE8WC+Q8/Pl7iTJ3ksk/NEUK5dNUgDZ456lT1ChjI4nhGl14osc?=
 =?us-ascii?Q?LghRjruzCBTWAp+wRbYkkcc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548142f8-7c00-4701-6c1f-08dc07893e8e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:02.3497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41AFi0ZeRwx3OEM/raABeOcyN3F6jUD6rdVOsgCUANlY8/xllUDUuHPDTne+Df34KSXiNqqZ846BRpwNNdZWnvixw3E2CTl1TgU5ynzquwM=
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

In parallels_check_leak() we change file size but don't correct data_end
field of BDRVParallelsState structure. Fix it.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 658902ae51..8a6e2ba7ee 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -806,6 +806,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 res->check_errors++;
                 return ret;
             }
+            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.40.1


