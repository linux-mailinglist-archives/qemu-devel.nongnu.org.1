Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7D4831AB1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 14:37:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQSaG-0002zd-Vj; Thu, 18 Jan 2024 08:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSaE-0002vP-8m; Thu, 18 Jan 2024 08:37:26 -0500
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2613::700]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rQSa9-0003O4-Fo; Thu, 18 Jan 2024 08:37:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7YSxc3/+RXlrxPIq2gerr+hEPNAerkjUqiaaxZSFpx3ZXF6arPU0XTSqwGa1iu49KLDpYAkqMa6qSrs4FJCI0uRAwGMDctMqac1YCnJDGs5KK0lI5vorLNPPljyPjq72JcQ+fB8YRv16GmLcgyaonbx1N2elXGv9s9A7Kl4H6uVe8LzprEelr68jElJi8I5Ukf706B7Ha9YFJg+XoPXb+Z2POFl/c0zpSexPMFZyAnvkB7P/AlfEU/A0EY4pS3aGJWFiOA129K0thOTGGOVE9ev22zwRPhxZkmw+wFSvx94wxHfQY38NdRIAii/vSBjTew+8k/hRZbkIRO7FKQzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GinzqjO5WIqz0jEYwAzBpeqSjKfwD9UOJSgVNqb9F8g=;
 b=ITn5k7BfOoWxJUz+iE5a2WVkHnGlnmfikpuSErYhXdXzy96otYPjfGRVAkiZzA90GGjCjGdQsbjwCa+VdfvvGfje4dezkTZ9vfBvxktgr0U4PjL2sraGkAvpAjRXcXSU2iQtAGI8GbE2Ff4ElNPjuyZ2IC07z/DtbryhMeNgV4NhZBM7IvZvmK9erWcEJdzk0JwsVX7y7o/XPMW/ciyOL3/Z133iaKtAWwqjh3uY2COxD6Vp/y7VqFz5gcHADQ5XQvbQjpgfsn6BewJOI8nQfyjeL1CgVPRwJ/zXJIEKhcTDuYmwZ571hsAKUVS4aLVre7ma4xCw7midRbOoYKFAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GinzqjO5WIqz0jEYwAzBpeqSjKfwD9UOJSgVNqb9F8g=;
 b=GARq9GDy7K1VqZ+y5L2xAVI0neNCdSfG47AClJbgZryaiKEbCgWG3GQPOLr3oZUwb0tVy4kIEvfUKcjOOCMis3Z3Pulsikl5nUVMAh9HF1vsVoybYeG2ATR3m/8/4XP52JJEhIanPoN/FVAkFKpyT2gjFUSfk2jjlPvyf68XzMSUi/+rLV2FOvt1Woh2oBF2WS3BqYSAIAoH99nGuok2Wu9qMaq8UxYP7OVC0MsDx1bKnNXmCxiBQKzHBVfONLNBJUOF0oouMbiK4KEySAC3MTsjLis4vX/e64k7Lf6+S676iCgG/33NF1II64ZGOBBtdVKOcq10PHNZvzXxVsZxMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAVPR08MB9770.eurprd08.prod.outlook.com (2603:10a6:102:31e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 13:37:16 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 13:37:16 +0000
Message-ID: <5be339a0-14ce-492e-a775-d6c263a2c35d@virtuozzo.com>
Date: Thu, 18 Jan 2024 14:37:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/21] parallels: Handle L1 entries equal to one
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-14-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-14-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::49) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAVPR08MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af3ae40-738c-4da6-feaa-08dc182a963a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVeq0A7Xo8aJQsc7kQw7tEu4uXIt6bhlyGv/WYB9IsK4yYvHTV0LRMSuaywExIM2lKNpSuILEPbS5/17aLYlcENiQoAtwPe3me9CSLCBUVOpKFvL0fcffyAAJ+MNyZJypSpVymldhbtPWcnNrrKRL10+GbO8vsufMrpH1tMTa0jDvSRIMvuQj4mdsKLnlSlagaD3fKLLPFiH4wnNVolp9L1dRnZcdp6jFt6J0LSQr9uLTN638asCvC7QlAh5LhupXYnsE+/4cW4JE3L84Ef9AvIir26Yd/QTFdPAq8qQWbcvg2sCpSpu+b06kWZvlV2z49hMZF/QPAf8cgl0naRF6jFFEWin1/CFaw0gnqcNfzKTYlzgm2wm8Ip+7nzGynjuiQmT1okL+14SBWzKVyaLhzPc/45hFTxF1ME/jjfkoTBzYz+atT5yWmcf2b5B37DuFx3eVU3lBDVJCA7xdBg3CDvwrIiSQ6/JcojwZ/PZTIpgvWMsrqjAXTAWqhZ047siMTsrYNP/QNMkQKDm8ojm1u+mS3yTe82zr6y0lNXfiZREDB4BDRwhRw1QZZ4lewCT2IO9lKgfb48HKjSEOV5utY6MmhfVf0+HW1LEQ7d1xtThsQCklxPk+hyw7DyeucouvQc+NX24LeOvW3bQTCcCyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(38100700002)(478600001)(4326008)(8676002)(6486002)(8936002)(66556008)(66476007)(66946007)(316002)(2906002)(26005)(6506007)(2616005)(6512007)(53546011)(5660300002)(31696002)(86362001)(41300700001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRhU1lWd2NIS2YvdHducnVqLzY4dWhUckFiWW1xeEVCdnpXeEZ3U0xoS1BR?=
 =?utf-8?B?Z2tDOERoaElXSjErZGNZV0puUnVqQ1RMc1ZkYmthdG5pQ0FwaFNNbmxtdFpq?=
 =?utf-8?B?c0tJdUJrVDJWMllQTE16ZEtzT2xkc0U2aXRmQzBIQm1ONGNmR1p5Mjd5YkVs?=
 =?utf-8?B?SzBMQVc1R2JhZHpTTG1nVi9wTHlUN0M1bnFtQ3NiZ3UzeXdEVmJKVUVtMDl6?=
 =?utf-8?B?R2hBa1VQMm9ybSs1TXAyZFdOZVF1elAxYnA3MTFzNmMrUDVEUEN4R2JRQ0pK?=
 =?utf-8?B?VnZEWk5jSUJUSkl3eXZaakRIUnpnVXhjcjhORWV1M1JWazNSQ2RWVHRjdWdO?=
 =?utf-8?B?cDUwSHliZ0JMZDh0MWRDUGNXMWw4bUczSFJiVU9WcGZ4UWNJZU9qWFBoTysw?=
 =?utf-8?B?Rnl6Q0JBTmRTWXA5UVRERU5VQ25QU2VzM2hIb1Jxc1pyRStTeWFFV01hY1RH?=
 =?utf-8?B?aWlCSk5UejZkYXFNdHFGdVcrMVYyaXVxdFozdUd1SUs1aitIRWNmb3NFekFW?=
 =?utf-8?B?MDFBL2M5SlM5Zi9ORjJDT0xSRlJBRXN3TUswUnRja3R6L040SDRHSm1FK2Fy?=
 =?utf-8?B?MTBveVkvNkJuemlORVU5TGE1blpYd3dGU1dTb3FZcFgwNmpWQ3FLNHMwTmE5?=
 =?utf-8?B?VndoVFI4dkE3c3l5a0pZSHFtZ2lYSlNtV25TYUNlYXQ4RnZ0S1lSQm5JV1ZH?=
 =?utf-8?B?TGg3WnlhVWVKaEwvcEhURS9BeThFY3VsTVo3bjFNSGtPaE9lSlc5dFhRL1Nk?=
 =?utf-8?B?NFZFTUJMeUhFdkFQY3N1VVRjcXBLOEw5bHczTFZSMGVwZ0RKbkR3R1VMdndU?=
 =?utf-8?B?UFBuUGsrSmlseTFKVFV0QkRtNTdlaU8zYWtCNVJQbStjMTVjMkFRb2ZaWGMz?=
 =?utf-8?B?WVhjaTF2VjV6bC9RQ1lURCtuMzRjcTZzNm1hR1o3eFEwUEt0YjhqL3IrRXlG?=
 =?utf-8?B?ZkZtVUlDc1IrTGhZZTR4Tm9JK2xOYlZ5MGFVeUEvTzZOWm9adExCZFlQZjhp?=
 =?utf-8?B?cGFyaXY0OUpKSjRuelc4NzlZa1JEcEN6TnIvSzJ1NlBrM3NuRXd1VTJuK0VS?=
 =?utf-8?B?d1NSM1g1RXhpcDBOTXNKemZ1L01KK1dWMjFINmZhT2NHRmI3QmlGVUZFY0Fk?=
 =?utf-8?B?M21BZlFTK0xHdWZuSlVkQjFaNVBXVkVJazdTTjBEWTZKQlRra2U3ZTNSUElE?=
 =?utf-8?B?Z2lQZ2Vla0NOaTNTdk5Uamprc2VZYlgrQXZ6RUpCditLdlBYZFFuWGxjQWls?=
 =?utf-8?B?dUF2NkpwWnI0T255K1lCWTZtaGZxUjBHMndMNlFzeU1peEt1U2xUSnlrTXE5?=
 =?utf-8?B?SlEwSUlLZjRzOWRhV0xsQ0J4MkZlQkdoWk4yOEx0Ky8zYnpIUlUvMXVsQjZB?=
 =?utf-8?B?enNDbEcxWmFWYUZ2dnViZ2tZSFBYYUhwTU82Uk93bElNWXlDTzNuemRienZv?=
 =?utf-8?B?M1J4M1lJQ3MrWnVIZmgzVzAxQmNjdzQ0Y3AyU2FxZm53a2orTmg1ekVlS3Fl?=
 =?utf-8?B?bGduOWd0YTRtcjhjbWRES040UElsOWVpL1lrRThXWDVqcTdyQ0llYjczL3FE?=
 =?utf-8?B?ZUZkdTliT1hvbUpLa0RDbmZkcllUTmRrZWxRRzJRSG8xdFBTazZOSkhiTzN1?=
 =?utf-8?B?ZVJiK2t5NlRSK1BtNUlKay9kREdPM1Q2M1o3MXNWZkJJb01za1h5ajNZamts?=
 =?utf-8?B?NVN0TGtZakcwQW5PZExqWkdIS2d0SUs0OEFkTCs5OERMeHVJWUk5bjR0U2I4?=
 =?utf-8?B?M2hJVjg0cjlJMENTRG5ZOW14THFQOWwxQ29iOEN0cW5HeThPYldTa3VadG5x?=
 =?utf-8?B?MVlDWGhoQzNudXU3bytwQ2ZHNGc5bklCMXFUdC9TME1DamJiVjdlbTUxb1cz?=
 =?utf-8?B?dnBLS2Rvc0JmcC9TVkxaR05NOHVvd2VZNTFhOFUyZ2JGdDJhTzZaeTRSRVhh?=
 =?utf-8?B?SmM2S1Bxejl0SFJWTURDZkJYOTRVcEZCMVFscmdKamRIZ3hUOUtjZS9tejJo?=
 =?utf-8?B?TmdsMUhMbXJEZUJvQ1phWVUxTWVvOTdxYTRkSExjZmFQeDlhOHg3bDgvbW9B?=
 =?utf-8?B?MEFoRG1TNEtyY3BmSCtVUkg3RDE5TGFPMDlSMlE3RjN2cTQxZnQxSVhRZFk5?=
 =?utf-8?Q?HFp4/fIodINM2TsMbR0lArExq?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3ae40-738c-4da6-feaa-08dc182a963a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 13:37:16.8886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFoK1Ubh3IwHycZ8Gzol7liriLpfP2Mfs3CqayF4CdeF8oQaPH/qStnRwfyfTdw68u+EVlcXy/9QWtWjODvYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9770
Received-SPF: pass client-ip=2a01:111:f403:2613::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
> be written. Instead the corresponding L1 entry should be set to 1.
>
> Check if all bits in a memory region are ones and set 1 to L1 entries
> corresponding clusters filled with ones.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels-ext.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index 195b01b109..033ca3ec3a 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -354,7 +354,7 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
>       offset = 0;
>       while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
>           uint64_t idx = offset / limit;
> -        int64_t cluster_off, end, write_size;
> +        int64_t cluster_off, end, write_size, first_zero;
>   
>           offset = QEMU_ALIGN_DOWN(offset, limit);
>           end = MIN(bm_size, offset + limit);
> @@ -367,6 +367,16 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
>               memset(bm_buf + write_size, 0, s->cluster_size - write_size);
>           }
>   
> +        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, bm_size);
> +        if (first_zero < 0) {
> +            goto end;
> +        }
> +        if (first_zero - offset >= s->cluster_size) {
> +            l1_table[idx] = 1;
> +            offset = end;
> +            continue;
> +        }
> +
>           cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
>           if (cluster_off <= 0) {
>               goto end;
That is not enough. We should handle all-one and all-zeroes according
to the spec and all-zeroes would be much more common.

