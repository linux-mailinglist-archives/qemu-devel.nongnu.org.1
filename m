Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C37A4B6E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFu8-0006rx-4v; Mon, 18 Sep 2023 11:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiFu4-0006oc-3s; Mon, 18 Sep 2023 11:11:12 -0400
Received: from mail-am0eur02on20705.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::705]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiFu2-0000gi-Ew; Mon, 18 Sep 2023 11:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNqTXTplm4duS1FdZi51I0n0yVle9qf/99drUd4lWGPUP5DbrcBn0CH4RCwOJxf0ygB3qoRRumXUjwx3a1Q6+8LYT77BF/FdPmxHJQskXXJmxkFTlHw4jzE6pabvshGgIIkOSLq3/Yk4wtEBoKGQ/UpIZxwJ6TcteIgsankONV6dVWFb0cyJzXacvBQObsguv242H3T4HF6MU9B/tiofnDmt2WZOCaSTb24MFR0N8Tq3AAdLSsDpAVO5WVj+lK8Lujg9X5ibRz7gmEUov4wHprsM4JcHCQhVYcFPbaLKjdLzXMk2jRZMYG2mhsgUJT/yeRHciEok6tj53TgNh5/hGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNVsFe/cDi/2jUSkTNKKVSZMn/qVjCrPCFF36vJfgYA=;
 b=dmEcEXgqriSkRhUqfLFe3cgI7tlBrmMg22+GzD3Wt6/kPoTx5nZYCkgYO73PjWehIjSlizP9r4tfwVtrVcDCKKLZPUGi3o50Hlq/K7V/kkrKtiyNClBpFwUpEC+AdaSK47UwfmmVKjNIa0pZt0rmcT6NK7VParyOpBH79KxBllGXG2nTNzDABmQqMXKISYLzuQk84vqz9QdTCsQRhRzVxdIVyA6LHKRSh6BRSg1byier35F2dciEKX855xQF6Evuoyd6TxT4GV8a6l2GDKSk49WfSx3DjZ/opjcPf8+rHoIAn3BUVB1gSpbGLKtfRY2jcuv22tolxEAQ5iCBE6p4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNVsFe/cDi/2jUSkTNKKVSZMn/qVjCrPCFF36vJfgYA=;
 b=BJoyox7pj4iwRJmqrPs2szuiJylfeqveOSRv/0Dlx011EWvk6WAI5wnjO3W/jvjpDVP+FOU8WSrvt5BeBAMtoy5A5lpGs+Q574pPfoSqg4Atb5G6q6kUodcWjBFq3ER7sz494kZkjHXEwrGrz8AN5aPySQGE+A9dimTYVfvS25Qpy42LHoVCxwFu4oXEJB35ppKtCH/BfiImBDUwLdEatP5fvV3uQTMvO/picu4Fk3xNAIPJceWlD/Pb7E4LrXaiuha368bF99vHOmD1gMuflngPqu9k9OU+XmWDusD3sCj3sti9YryVplRuUDuTv//KAt8YD2lN0fnNYYO3VL+1fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9056.eurprd08.prod.outlook.com (2603:10a6:102:333::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 15:11:05 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 15:11:04 +0000
Message-ID: <5f388948-aa81-b424-92eb-327f2e205356@virtuozzo.com>
Date: Mon, 18 Sep 2023 17:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 20/21] parallels: naive implementation of
 parallels_co_pwrite_zeroes
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-23-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-23-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c32c907-9ee4-4537-9947-08dbb8597a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYyZWS7F+409QK0mfVe7/EFFf+vkRaN4zTiRp01w5GK9b4sb95PwGz6WnyO18SdA47zA2Amj4xhjYEvoq1Ke1Dt0+leoVWDcxF2X5Ep9n3SlGnTbBJ71V+JEXh/RCNET9dAph8ItWsg2l1uI0cjLYReA0qJ98xBGS+d5AovDt4IrUPSxpuYKpHGvuuiRhuU+jMXeAdueDSljjSM8fTkXnwwh36rixo37stjzDdeJqqiTTNTgKUwE4t+eXmLoMATdmHLd/lyTCzdBCcUqKPrWRPo5cI4Xj4e34I5xn/NUa6sLksRw6s4lO7J94HbE+wyPG5iDugQHA9kApZIAH+zRKEc10ZG5QYlliticX4aHQu8ANTQc53C41rWYPEmg1EVjity0W5pyhDVoz+DO2zy2cYs5RGr7hwG/k4DpBWf6vagzTZjaOMF9gKm62v/4RTbAiddunrDcOOMc4uQBgsXwIolf4IGgzwHoxtrSmyHEY61oe/GPLRDF8BbrTtBGQfrdit8CzFV5toQG+zXUOI0sUtuHtJ8l+5YJWnqFvDaueQpXocnwCEPfFyY+k7NOu38LD10aDUAywo+GTGoKRuVrUNB0JKqwfSlmjWxH9sDIfpEkAQknTSL8CPWT05tttBa8/bAlzVwWwf46BfOxzm6SrjYitGCFcBDY8nAt9U5hC2foeNXuJHkJukNIQAvzRohS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39850400004)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(4326008)(8676002)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(52116002)(6506007)(6486002)(478600001)(6666004)(31686004)(316002)(6512007)(66946007)(38350700002)(38100700002)(66476007)(66556008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdJeW9WaXRtR1dDb2tXV3l1aE9xaThURitnVUVscktFekRyZmhuUXNnRTNv?=
 =?utf-8?B?bCtmTkhhZUtUeEdvKzF0MUlWWUcyMkxCbllGLzZTYWFwbUF1UmVGeFdoNFlS?=
 =?utf-8?B?TmJYVFRwWlVJR21mV0J3YTFGVWdUdFMzS1R6SEFmRlRYNXQyMGl3aWo3M0pl?=
 =?utf-8?B?ZDh6R2EwbTRMRHQrN3BFeERtS1YyL1B2U0VNUy85MGZ1UnYxZXZGejF1d1hk?=
 =?utf-8?B?Mkt2blhJQUxMMDkzYUdCV0xZbDRoLzBvQ1B3WW1IK2k3WlQ3MUw5VlljS2M0?=
 =?utf-8?B?QW11aVYxUmVTMmw2RFpKTVN0YXljdGtRWE12N3RJK0dpRlVPczNyNEMvSTRn?=
 =?utf-8?B?OXVXSzk4RFl1YTZEeUY5U0RzbjRlNmUzL3J2WGdiYXc3MXVaVExQZDNqb0FO?=
 =?utf-8?B?c0JqaElOWFA5NWhWSEIxOGJBZmJMK2s3WElFM0xjT1Jadkg5dHd5Wkd6aEli?=
 =?utf-8?B?di81cU1UamYzR1pVSCtUWkoyM2FFWGY1dW44ZnJNSllheFBna1hQYWNTL1hH?=
 =?utf-8?B?T2Jjam5SWUJDOEYxZ3BKQ2tIOEVpRTlIalFmNUpmOTVZQk54eGZyVHZya0w4?=
 =?utf-8?B?cFA2YkxweHR3VmljZ3JOTVNoODBSZERWdU1uamJORGg5SjRGSjFNTzYybVRU?=
 =?utf-8?B?R3dxN3JyY2FFeDV3WlJCVjVrNURJKzRvVC82TlRrS0VRWnRVSEgrdTAzSDBK?=
 =?utf-8?B?VzduWUFvTnloeENvb1F1K2ZLMGhrSGc2QjBjV1VVUTBzc1FuTHM2Qk9sdzB6?=
 =?utf-8?B?U1ZtZlJ0WmtaUHpzc2pqQzZHdDZjMy80OUtiWWdOYk92aWxmNFZXTW56Qmp0?=
 =?utf-8?B?cWg4L0pzOVlkZWgwZ2NvODNyak44QjVKYWtGWk4zT0Q1TmJzblhLMVZaRFZX?=
 =?utf-8?B?dXVNQ0lucU45NEZKamJJK2o2ZHoxUENsdFdoWE1WZW1pM21XbkR4VEZkOU1j?=
 =?utf-8?B?SmVMY0RVeWtGS3VjV3RlOEdEL2RHSTU4UXl0WkpsM1k3TmhBSGtyS0taL1N0?=
 =?utf-8?B?Y01EdEhVUzhPbTh4RmgzTEpGeXFodW1Hd2pXb3c3OUs2WFBxcS9YU01CSW9I?=
 =?utf-8?B?OGZVbkgrL2tUS1pFOCtjaXJHV2NIY0FVS0ZyM0V4RjJDQ3pzZ0xrK1MzQmVO?=
 =?utf-8?B?cjJ1RTVRV0N3VlRwMVpVU3ArQlY0Y1dOSWp6SFFCTVExUnJubWJ3c1ExR2Mx?=
 =?utf-8?B?UUVKZTRXL3JMYmRmV1pRQ1lKakZFTTFiOVhkTjNINDg2USt0c1A4UktLQm14?=
 =?utf-8?B?Q3hEa0wyR2gySGR1K1NDTUJxY1VwWWxUMWlFZEpRaHRSeGFDTVYzUUtzZlhC?=
 =?utf-8?B?ZGlJZG9oYm9vNjFDSnNPMkZNczFYT0ZhTHViZlNDeFVWa2hXbnp1WkF1dWRG?=
 =?utf-8?B?OE9kTTBVVkF0bkF2RTY3aHJ2dnhENUdtR2NndHRGWkcrZW9xeGIrK2pkcjJE?=
 =?utf-8?B?NUNFbXZlMW11R0h2R210U3pJaEhEZTIxU2tjOWFYeVM1Y2dNM1VKREV4VGw0?=
 =?utf-8?B?ckZVakU4NGFHa1dUWlA2MFZwZGVnNitqaXVBTXd5cGppVTRsdFBJTnR1bkxy?=
 =?utf-8?B?SjBZTWRVMjZhRXdyUzBEOUFKWTl3TWZYWDBSUkV1bmdQQUFlMkI5UU5MTXkz?=
 =?utf-8?B?YnI2NTdDTXpUWHpqOUdoSXBOZVVHMmJ5NkRPQlc5TjNOOTQxSzNTTTlZVk9I?=
 =?utf-8?B?VEhrcWZQbFBLV2tQUHpmYXlxTzBWa1F2Znp1dmFnY2FQanFJRjMvcmt5QjE3?=
 =?utf-8?B?dkdwU1d4WWZtWHFyZ3pTeThpKytIc2MzVnZqRTRjOVlxSVhYS29iT2VSeDZL?=
 =?utf-8?B?OWtpM1RucWRseE1SUW1aRUtTMXNRSW9MYXMySDIvU3RsTXBWTC9tL1k3YkVu?=
 =?utf-8?B?MVpQYzRhUGtHLzNWbTNzR1VTQkxDanBjOHFaNEhOb0lINGJzME1nR2xIdCtK?=
 =?utf-8?B?ZEF3TDFvWTgxVTZVUHhmeFloNStSWk05NC9LR1RWM2JMTlQ2SXpsazE4TjBI?=
 =?utf-8?B?eDVoSUJlM1BVM2dyc2tVYWlKMEhXbE43bWk3NFdMM3NJbE8yeS9iNnZZTjNZ?=
 =?utf-8?B?OGZVbFBmNnVRUTBWRDdaWjlhdU5WY1J2TkoxK3dxYnFSWmE1YU15Skh2bU53?=
 =?utf-8?B?Mm5SMkNldVREcE5UTVlWQ1RjbTluUUE2am55REpJOXVDOU55S1Azc0VtYjJL?=
 =?utf-8?Q?rQy6Vy2IZRVMrzRIUXWqAg4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c32c907-9ee4-4537-9947-08dbb8597a65
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 15:11:04.9175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7HCgY5tQXeX23450kdtUBWmCfBCxNBpoxLRxK+3i4mL1r4q8EDxlLkpNgSKVEpypwUyz8hj6nOfXIjQESizzWFlwg4olxqH4dQl68I7GQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9056
Received-SPF: pass client-ip=2a01:111:f400:fe13::705;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> The zero flag is missed in the Parallels format specification. We can
> resort to discard if we have no backing file.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 83cb8d6722..a098e2cbc2 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -583,6 +583,19 @@ done:
>       return ret;
>   }
>   
> +static int coroutine_fn GRAPH_RDLOCK
> +parallels_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
> +                           BdrvRequestFlags flags)
> +{
> +    /*
> +     * The zero flag is missed in the Parallels format specification. We can
> +     * resort to discard if we have no backing file (this condition is checked
> +     * inside parallels_co_pdiscard().
> +     */
> +    return parallels_co_pdiscard(bs, offset, bytes);
> +}
> +
> +
>   static void parallels_check_unclean(BlockDriverState *bs,
>                                       BdrvCheckResult *res,
>                                       BdrvCheckMode fix)
> @@ -1456,6 +1469,7 @@ static BlockDriver bdrv_parallels = {
>       .bdrv_co_create_opts        = parallels_co_create_opts,
>       .bdrv_co_check              = parallels_co_check,
>       .bdrv_co_pdiscard           = parallels_co_pdiscard,
> +    .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
>   };
>   
>   static void bdrv_parallels_init(void)

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


