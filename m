Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7EB7D904D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZm-0000co-44; Fri, 27 Oct 2023 03:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYm-0007EQ-5c; Fri, 27 Oct 2023 03:47:21 -0400
Received: from mail-db5eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::704]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYc-00040L-Oj; Fri, 27 Oct 2023 03:47:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtTERGH6WiBTJCwtT/qi00Pt/Oex9jPZacbwabf/xGHWtCjtNzKzMe41lE8AYBuW8O0oj2T/CFt+p88EvR8zvo6jZtejrCEgz/rb3L/kIH0pRiCrTdkhYD8noj3QTYbccioOOh7YlvqIiIxENPmeHaTuKWLtnLThyl9hQ4FH8FbQKKNNoxzisZpSPzKGiEC4P4TExowlixVLPYdtJ6kCSSlVGk9+Gf+dA4DqoZ89y8/ygYzv90pDhxAjIVBiN53OWRaSx7p1Z4KQQipzQ2RrUBQP8fV0QFPnWUXYDvQyJYERInawB6eD6vH5GiAUa+ZpVcANMD40wrn8w1U3Q2i77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r6mB3zQJM6dQzkUf0KM+AriCgiob8b8EfOfSHgWHL4=;
 b=TunTq3QXJSZWjxMt5H9oD+bzoE7RbYBSe8LQ01JXIPWowGtu8VDhoiE6yyclzrNayhGA1Re/QeZt7k2wFgMd+tT7r7zAiLEwwciffxuAdf2gTb7PPAmq5xirgT8G9RsbRMl9/LxXlryqtd3sd3IqLHtM3TOlTZkC1AIzZ0lpVJp5kIzOHMfqgsWGt5U0FDP8U2gRDCq0Z+LpyIxSFi1CvxLNr9sSxw34mZ1UDuCu2Zy4opD13TuewjUfkdGxSFEEUQ9PGTTfo3oiewB/JCoFTx2MaCIeS3cv9qGZhTZgueC5tCnJjs5rkAWts0vEhoXNI/CoxkvqU9vDisNhmGprDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r6mB3zQJM6dQzkUf0KM+AriCgiob8b8EfOfSHgWHL4=;
 b=RlyPl1UIPtfjtUvVbfBJLMXXqmS/+5wpVQ4dOPDCl91SxXL4qg7S0MGSO+iLzretvm9hYr758HVb3tt4jR1E8tD8DnkK6G8xq1tr9FdO9WMxRyKD43RlsdFz555SlMdv3QQ/0xIxdn9zrLVMtH+Fz/eq11TTKoTRm8FL1eV/Gk+P7K3fzaYDYSPD2dn/eL0hznJXqeuQAJVXWzTs2jegFsnWorY0BJ2yBZKkFLnYB1eKqHx9/V6pLp3onkloJ7CVcgnYfbsTeUa7MBoywNad7SPsIOeOdWNOuYsIeEveWv56qcULl52XsqKw08uf0I3qkej40z5QTlxBnNgzsdXllw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:47 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:47 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 07/21] parallels: Recreate used bitmap in
 parallels_check_leak()
Date: Fri, 27 Oct 2023 09:46:22 +0200
Message-Id: <20231027074636.430139-8-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4bec72-c7fc-400a-5d7c-08dbd6c0de5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8w1d2n12cYYRL6ca8s09bUUA++XgV/dtbPEU81+dIXkI89QNKuFUsAgwaPSfEC2afVy5srk9DjEb4TzHBTdQHFNmgrvKBkXug9HZavuN1VaIeAPvxa2DblCdZAF8q/+pBM4emqN5AIWIP/WgB93lOPYssszPeGb0y/KZq1SNaTU8Jajs//sVwCNE2P40tpe6fWfwgfK9ysBzGXrz2bpK7iEKojc925XhDEFUugD+z7qQX6wRrgYqbaT1ZAvbXgtNglpuuRC4wMMiXm0jj9gf/h997cUPjKfMawbBCSPE5qFW3JYVrYZm4n+Kk/URxA308C5ousAWpGGPXfFhrWVOUivZ6LyUnXx4s+/FeKXWub6cUjjfobPjFavVdp4gf2lJTm6Yau9pDPE1yU7QAdQ6GxOcYZET9/FoX0J9w073/N54w6tcJ49Qq2V7ZCtoW57ft3YabSsqBPtrMTAsLZ7KSoQ3ri9kX3prQ4vvFOBGwPy+rZq2UmnwN7g7dbzXpD6bTIeM8wnPbet8AiF7tzJERR4clPdUs6cLHcIOp2qTt1kT0PUjxxinTqyha0ce8dlnbld6+XByLpYeXQW4T9yhqrHrsIeQDhvy2Mr8dIOp1oniyeiiGbwuMfK1IkPARMM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(4744005)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4eTBSzybI/PHFpDZndmngp8b4+fzZh1dlug06+VjYcIIr7KFi71h4h3EnaVt?=
 =?us-ascii?Q?8ZmAROQLPV6LV4xeuQPknLb2klIrO7GqR4PtJlaHzBsimBviN7hT+n3GvJnh?=
 =?us-ascii?Q?kCGxhwcGxczCGWpjHCwkn98JPBk1QicL2XuhHAmYgcnIfOe+NvSwzQyicJ/n?=
 =?us-ascii?Q?ErPBqUsvCYAjUwFI6+1S29YGM0ptOwvDJNtCgKZpUFpqhuudUspqqL5hTsYO?=
 =?us-ascii?Q?mrC6VCHF9YC+dyD0irZ/6UJWisadtbN73YvmbbkkJ5FAwDB51fHVG3BYjeZm?=
 =?us-ascii?Q?QzHm9ak8TvkaFh28SE/awmXyhqqa25v1Oq61NNzzzRFyf6rv3ZkFQgwnGzHC?=
 =?us-ascii?Q?cZdM17XTM3tPSAfjin0xvJ81QsB8n93VTX0Gl5gV0aATsBf7nkkOP5bO19KH?=
 =?us-ascii?Q?bL9VTImG30nAW1QyKSZc9/2byVMcr7xb9A64k8Io5GWl6K6jSMGaSLIQ2HCb?=
 =?us-ascii?Q?o1iMNySMOt2zK+fCi8TKmJ4oz9Hn3cMUSSn+Wsmqy4/eTdotAo0a7oufN48z?=
 =?us-ascii?Q?wfFwT6BTXZtMEvP7lKUp6xu1mHCXEOTXwGEUzQUMeP+bcyfvucH/B464PQ+K?=
 =?us-ascii?Q?4cts5JzwH/NL/yKXZ9dssknKweZ+E1FHUjWppqp16BaDKkHes97lfqVXNYS6?=
 =?us-ascii?Q?5ekVsBzXwIFWcDJPNrFq2TDf7ExFi6Ls4HTMdnM3QODoleOB+Ys7LicHODwo?=
 =?us-ascii?Q?/Gjo2gFCy64CiyLdOHB0YfHxEeem4UR/YeWpJjoNOa+DsZ9kZ1CAv1ClVDnn?=
 =?us-ascii?Q?Hoilv3LA2EtDzwvFBZ9clcV/0cW7e0B9SLFICL4eklQeC+AsVjRzkDHEzNcH?=
 =?us-ascii?Q?SJBPtvJL9TYgg0EyMqFogGOrQZGDolp/GXDM3HIdyAbUf88OeNDBCmfrxys1?=
 =?us-ascii?Q?7KT/8GpeKCfa7uXogGNSg96mVsv+pCHDkvzx277zi7YmyfWHMZC3835Te01g?=
 =?us-ascii?Q?nmFw4EI5eHF3YHDuWv6fGzvUE+5N6um/xTT3+uzFEDhVC1VPeFRXOjXoNalx?=
 =?us-ascii?Q?LKtEDv3UwsmEb29PR9SX1T29E+5RWERaRRwOCHU6TVJ5rlyFT9Di/f6thQNb?=
 =?us-ascii?Q?KUdsHnEO4aLzGF127xmYu/G55u8+KjsZfqxnOJ3NwUE/s0gmxVKlLU5eNw3M?=
 =?us-ascii?Q?quLaQJ+9eI17DEIiqHlS8lgoDYJ/qkbieviURxMAGWK4RcnMSIe+uSlyxE5+?=
 =?us-ascii?Q?kdKeDkX80yZQI2T4IPEJcSkA/ASbjSNxzl7wio0iBVSE5T3ufVaqYiivLTuc?=
 =?us-ascii?Q?95gleDnZtR/6HXkvqcly9KaC6tSjbQGTZrAkSSv2I/Z+zmxor626GeJEvMMi?=
 =?us-ascii?Q?kdzy32rsjsd4OMQ7DwQ89I89Ju4ttljWwUV3rxyOiQyh2g+96Y3H//tYlhxe?=
 =?us-ascii?Q?aA4XfGhYCGxKQekLXeplG+iAT2gCfrf4qgimd76dJgCRIPjxdckUcwWScQVJ?=
 =?us-ascii?Q?TCuwjjzFMMmZRxfE7woNMDE+4GVwDvQQVcGEGCCm4JSPnCtxv23WI+byhiMY?=
 =?us-ascii?Q?UuZfuH1cAeg+Ug/mVmp0ct9kOuejpO7V/bIHOdDoaJKJ8R1TeEgJ5LPy4svx?=
 =?us-ascii?Q?NgsFO0ix+2eVuXMk/kiAHvRfzilwWNHsvSSAYPZD2Nh9YYpLMCeytUlCLsyR?=
 =?us-ascii?Q?NKUvIKrm1vGYsAOfiDga8Ss=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4bec72-c7fc-400a-5d7c-08dbd6c0de5d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:45.7022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIz+7jg+P8vDPi51hKNOop/drsj5Sxk6UPMCBhr6CuUzeEGhVvKQxgFfQ3iece17hiHazQJ4gMAKkSp6/crH2IF/hOwg46WarH9OlqWlD24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::704;
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

In parallels_check_leak() file can be truncated. In this case the used
bitmap would not comply to the file. Recreate the bitmap after file
truncation.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index d6dbb6757f..2ce3e40ce3 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -809,6 +809,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                 return ret;
             }
             s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+            parallels_free_used_bitmap(bs);
+            ret = parallels_fill_used_bitmap(bs);
+            if (ret == -ENOMEM) {
+                res->check_errors++;
+                return ret;
+            }
+
             if (explicit) {
                 res->leaks_fixed += count;
             }
-- 
2.34.1


