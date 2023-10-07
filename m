Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589297BC852
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 16:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp8Kp-00048h-Gp; Sat, 07 Oct 2023 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qp8Kh-00048H-NU; Sat, 07 Oct 2023 10:31:08 -0400
Received: from mail-vi1eur02on2072a.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::72a]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qp8Kd-0002dQ-UP; Sat, 07 Oct 2023 10:31:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm2Vuy9W7wNqrP7sfZxJ0irhrO8osmw3g6AfjsMQVJWF5rGmHbNYCtEjf4ReaVwn5F0nEKrIF02WQYFDxx0SgmPDWqpkRrFF/ZWtDiUOKyAmVs1tlZ9Xih4uTt9wAZiKQiIpi+0Bgde1jjbxGpUlFJq+j1R6wZ0aNpCYLHQcO8+bCLRMbnw01gHQMx4yqq6DKsBHWDZ9YsgiTr2ZfxKKb+vcYMAjroYZDJMcuOcvXtY1BtJLsVVAhwuFCc9oWwRI8xhJ1Y074WJ0r4QXV0fDH+R7lIjPrdd2PZO71BNelt25LXHEF5v7PC0ASPLv3oXR6htQg0nhJqSgNXEUyNYL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+1Gp6NrDupiKcOL/m4It2daUgfNZWxU6v7ocTXXJAU=;
 b=TXa+T+btsBVlTgO07FPnzTMd71GvwkgRl9HRDTCN8GT2P+BLwVEvgBBSf11DgPNfh4xj899Av5h2XSQYwoz9HzwbSumpxgoz3VjIhs+IjF8ykc/su6CHAKZbxdzWazjZzeoD8mecqrzcjyHI5egrORBSTj/SbD2z9fndFXgbI1udDjEh4Pgn16aqIQLbHzEfDCCRNdCRnB7pqn8aalbTl4M/jtglBzalFB0qjbdjWq0Lu32IdCeC3woAgJVKuHKcWKiop/R+b9EfGe32QClh0xXlILfZhjOdw5OJLESTE7iOmag7RAspE6/wQl4oL/Pgy47Bejnu/Uh4O5cCel4QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+1Gp6NrDupiKcOL/m4It2daUgfNZWxU6v7ocTXXJAU=;
 b=s/1J0NZQ0cAEF0gOU19vLJSrqKn4+kTy3egRgAiX2AzYLTfE2AKQkFYW7Qta/XxfleXWty9vbk/U8fxoNIVt6urKwnwC2Z5smnzm2pViENbLMisQp06SAqA38tmB2UjkUkiFeemPuOVLbRSj3FIQNOgjwskT4TAX+1Jsib+O8kP6IQmME89zgz41/lSzo8SB/wVnsgpbM1bRCHEUhn9pco6osJ+Rt29fPO0NowHYumtQ/ZoJdx6hheTNmgCseRfWKLGBZYlyA+55CGkFyk6letgrHDVhFW51u6qClpPv1CUyvnzL+k/i5l7CcJ8Y28nJuX9F1WAvG83ZqiPKXQucQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8568.eurprd08.prod.outlook.com (2603:10a6:20b:565::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 14:30:57 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%10]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 14:30:56 +0000
Message-ID: <9240b820-9d8f-42bc-a4f1-7a69656635a4@virtuozzo.com>
Date: Sat, 7 Oct 2023 16:30:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] parallels: Remove unnecessary data_end field
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
 <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
 <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
 <f050b078-1f8d-41d1-a469-4f92d4248580@virtuozzo.com>
 <CAL77WPB37-y4GeWXgy2xQ93_riZkR0q50Gs0apqvFoC6kZwDZg@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPB37-y4GeWXgy2xQ93_riZkR0q50Gs0apqvFoC6kZwDZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5300cea6-9738-4ea6-8769-08dbc7420483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ym1uT+oaHgQtnJMRuZA6NS5X5A+wLdnBaHfY8cddK9q7p33RYOQCvU5HMAJNWM/8g7ST0wT3Jvc6fSjmsPyEG5BKNry2bKQwKg20R+KG7L/UnYcLKrpiPeuZ1s8EHQiJxbeBbkh/58Sm9d8xf32DTP5PGfPBsdeP/aDvn0IxJwDpCJ6VZy4sFWUgE59lxFnRw9RB2C6c2nhfxiCaZWo9NXbLCHgEC06eQeqvOKLRyaYMDjUkt3j6/ajrRw56pR4V/rmu00sOSnQteAxK+2h+iGJcVF9yCYBUOtZ85fp1F/h7pqwCCu2Ho8OgpXdnUPXtE7B/7KaltfEegK8gj5bk1vXa4F7HQmeV0R4K3cteTFL2jEoKC1hWnHQO4zzWxlXV9jcy27AO08rZzRgnrA20TkJr4A5X3iiaKCzMvi8gzURYJchFTQDfLcx4vST44Fec8yGB/H9pfcwV6eJGzFfJB4pUl+1aUuHSse0ZQBpaPa8SX8RhzL1b7pA3VhgAErDaB9hTN+UPUcrzeScMihO7dtJWCrSr7avz42fxtt5Kc1AJJ6TKaZGyywDr3vQCgzssI7o8Abi9qsbNwIK0F9lNBoqBUzxWIp48U31t8NgabNCXfJXnErh9/+R12vv7djbP4PLl8ATox+29P4kDuD1TGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(39840400004)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(5660300002)(30864003)(44832011)(31686004)(86362001)(6512007)(6486002)(6506007)(53546011)(83380400001)(2906002)(8676002)(8936002)(4326008)(31696002)(36756003)(66556008)(66476007)(26005)(316002)(6916009)(2616005)(16799955002)(41300700001)(478600001)(66946007)(966005)(38100700002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29CTisrdEpqT2l4ZTR4WDZPOVBUem9lYitRcHZlUit1VUVuVzRnOHErNFdj?=
 =?utf-8?B?NUdjR0JaUExMaFdZQ2tPUnlNR1QyUERsTzFXeFhQd3lQUDRwV3B2UTAxK21o?=
 =?utf-8?B?K1lUalFNUFp4RzR1WElVSGtGVnpNZ0h1LzJaMUdxalVhT3lzKzB5dDZlM1Jr?=
 =?utf-8?B?ZmwrWU9hclFmUTB5STFDRHU4SUtXVVhHL29zbUtYNW1DR3VNZ0JuaWdMYkgw?=
 =?utf-8?B?UzNvSlJQR2F1K2NJMXFXOXBTcnF0d3JFWTAwWE1MMEhQRXYwSjdUSEF3Z3BO?=
 =?utf-8?B?OXplK2t2K0t4amZSeklzV0lJVlJsWnlwdzRYNEFQRTFlMXJqVStjYkZtQzBp?=
 =?utf-8?B?SXQ4WG8xNUFyWWdDVmtBOEJGcWloS2tFMDJIZWxoMnZhazNyVlZvSWJhT1V1?=
 =?utf-8?B?ZUI1NDIzWkx1VFdnaGY5NllMZHBNd0c2ZGpNcXFpZis2R1FhQ2ZFY21xWUE2?=
 =?utf-8?B?MURBL0gwU002cDZ0NG5OaUJwZStLcUk3RWRpUVlQL3JJYWNHRWhlT0o3Zlkz?=
 =?utf-8?B?WmI0dEpYM09LdkxhMktaM2NEQ003TlA5dzZxdDVYblpQTVROZDJsYmZtMFNw?=
 =?utf-8?B?aS9za21YS2tSRlY5VnZKVzJvUDhLUEFsWjErc0w5ck12VisvM0dUY0xMY2Nk?=
 =?utf-8?B?TWdHR21BOHNGUlFVT0NaaDZMcmlxcDVqRzFsUEc1MVUwdUxYYzNZMHNQamg2?=
 =?utf-8?B?VW5QMkY4OXdyWGpUaXhhaFAxUHE5NEhyMWhiZXpwMWhDR25TWTZTVUgrdnkv?=
 =?utf-8?B?Y2JBZjZjNVI2RjFGdExIUnJhcXlpKzAxbVZHQzVmek5Kdlk5dWt2U3hjUXQw?=
 =?utf-8?B?SkoxWVB1UW5QdU9rSkRMUHduNlcvSmdNb0djREdNRDBDN29oamZmS1hGOVdK?=
 =?utf-8?B?cmFOWGlMam1RdzIwc2YvQW8vRUJYdGdDRVNUclVqRXgzR1dKQmZUNVN3Y0Er?=
 =?utf-8?B?RmFyQXRPYUJuejVHQVRnbXhoUGl6cGsxUG82cm1KcWZNS0dVRHZLQTRPem1U?=
 =?utf-8?B?YVB4YlU1R1ZkbTZVcjByTCsycVFhOWF5ZStCR3B0QXVnc3VWK3I0MFJMbStm?=
 =?utf-8?B?eWpMWU02Znhpa1dGeW1PS1VuYThvdExFYThXS21DTGVVS09RM0lyWXdQSUNQ?=
 =?utf-8?B?dXFkRWVDVWVaazF5b093bWVxVDB6SEJIYmhKZVZJazgxdC90cTc5Rk9HTzJO?=
 =?utf-8?B?Q3VYTlh0dUFYb0pVVjdTWFFnTmJWTW1QVU0wVVhpQUR6OFNhdk45Qk9tSkp6?=
 =?utf-8?B?SWRXZ3l5VjRMdUdnSnoweDZ1WWNENXZBVWRxZXBVdHJUZ3dIRzQwczB4dytN?=
 =?utf-8?B?YkNHOU43S1d1MTUxZzljUzZENGdSRUZwRDZKekVhaUlhbWs3UHVKbEZlY3pX?=
 =?utf-8?B?QlBoNnMzZXdoVDJtTFRneEJCWDg1TVJhT2dzTll5KzZEbjAveXpWTFZUWFly?=
 =?utf-8?B?Z1FXT2tjVTBhcmF3RUFua1ZMMmRGUnFiRzVaVVZFaVdwRkdZdEI1WXVhQlV3?=
 =?utf-8?B?T01SUDFkQjFQU1pSU0pJZFAyRmZNQ2tnMmY0enlWOFZwdUV4alJ2em83bmV1?=
 =?utf-8?B?eGF6eDJQbWQrYkp5MDIvS0pXVHAzOUl6c1k4QytaMUJoZGJGRmg0d1plT3lH?=
 =?utf-8?B?Wm9RVkJINjZ4NUp5NzBGOW1YVGsxSFZjbXRtVFM1UXpDTmlPeWtqS1BQUmVL?=
 =?utf-8?B?ZFpYOXJXNUhneTV3RktabTYzOTJWUXpsdGhNTThPamlDK0MvTlg3Y1hzMTBw?=
 =?utf-8?B?azVPcGcxQkFvRmY2Z3ZzWWFsRnhDOWdTMElIUS8vTzU4UkR4Zlp2OTlHTFBD?=
 =?utf-8?B?NytEQkZ0N2N5bFp3UHhzK1lGV3pmZkUyRlFSZmxYZ3U1V3pJZVpnRHErRXMw?=
 =?utf-8?B?bG5odjdsZlZTa3ZaRjEwL2FVQmpqR1pjV1RrUFk1bkZVbjVKRXFkUnhWWWlB?=
 =?utf-8?B?cGNNam1sZW5kbGFFV2h1aW05OU45VnN4NFpaRk1ibG4zOUZMOFZ0UlF2RWVD?=
 =?utf-8?B?RWY5ODUwRE9HZld4TkhNemhidHVxNlNVZUlRaDduYWRBakxobUJ1Q0hUcmo0?=
 =?utf-8?B?MkMxdnRWSEtGNGhJZXp0Y3ZJclJtYU5lVkVyTFA4OFE5OWF5RXF2bGNiV0h4?=
 =?utf-8?B?QW15c1hReEtLcDB1QXQrbk96VlE2VG56ZHU3R3dGQUJFUW9iNDgrNzMyN0VN?=
 =?utf-8?Q?L0JOgVNCJBDRtP+Q+/ADrg8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5300cea6-9738-4ea6-8769-08dbc7420483
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 14:30:56.3930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z23Foy29aWG+SAqKfGhszrP4nwoDlW0tXW+UZXbPMVXKXSRx7IziPPaNSm7DkmRzmtLi1J4UXq2ZKYLDsrZ7KikwXJTN8s0WJJ/O9WuSIvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8568
Received-SPF: pass client-ip=2a01:111:f400:fe16::72a;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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



On 10/7/23 13:21, Mike Maslenkin wrote:
> On Sat, Oct 7, 2023 at 1:18 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com>  wrote:
>>
>> On 10/6/23 21:43, Mike Maslenkin wrote:
>>> On Mon, Oct 2, 2023 at 12:01 PM Alexander Ivanov
>>> <alexander.ivanov@virtuozzo.com>  wrote:
>>>> Since we have used bitmap, field data_end in BDRVParallelsState is
>>>> redundant and can be removed.
>>>>
>>>> Add parallels_data_end() helper and remove data_end handling.
>>>>
>>>> Signed-off-by: Alexander Ivanov<alexander.ivanov@virtuozzo.com>
>>>> ---
>>>>    block/parallels.c | 33 +++++++++++++--------------------
>>>>    block/parallels.h |  1 -
>>>>    2 files changed, 13 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/block/parallels.c b/block/parallels.c
>>>> index 48ea5b3f03..80a7171b84 100644
>>>> --- a/block/parallels.c
>>>> +++ b/block/parallels.c
>>>> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>>>>        g_free(s->used_bmap);
>>>>    }
>>>>
>>>> +static int64_t parallels_data_end(BDRVParallelsState *s)
>>>> +{
>>>> +    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
>>>> +    data_end += s->used_bmap_size * s->cluster_size;
>>>> +    return data_end;
>>>> +}
>>>> +
>>>>    int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>                                             int64_t *clusters)
>>>>    {
>>>> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>
>>>>        first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>>>>        if (first_free == s->used_bmap_size) {
>>>> -        host_off = s->data_end * BDRV_SECTOR_SIZE;
>>>> +        host_off = parallels_data_end(s);
>>>>            prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
>>>>            bytes = prealloc_clusters * s->cluster_size;
>>>>
>>>> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>            s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>>>>                                              new_usedsize);
>>>>            s->used_bmap_size = new_usedsize;
>>>> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
>>>> -            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
>>>> -        }
>>>>        } else {
>>>>            next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
>>>>
>>>> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>             * branch. In the other case we are likely re-using hole. Preallocate
>>>>             * the space if required by the prealloc_mode.
>>>>             */
>>>> -        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
>>>> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
>>>> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
>>>>                ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>>>>                if (ret < 0) {
>>>>                    return ret;
>>>> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>>>>            }
>>>>        }
>>>>
>>>> -    if (high_off == 0) {
>>>> -        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
>>>> -    } else {
>>>> -        res->image_end_offset = high_off + s->cluster_size;
>>>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>>>> -    }
>>>> -
>>>> +    res->image_end_offset = parallels_data_end(s);
>>>>        return 0;
>>>>    }
>>>>
>>>> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>>>>                res->check_errors++;
>>>>                return ret;
>>>>            }
>>>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>>>>
>>>>            parallels_free_used_bitmap(bs);
>>>>            ret = parallels_fill_used_bitmap(bs);
>>>> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>>        }
>>>>
>>>>        s->data_start = data_start;
>>>> -    s->data_end = s->data_start;
>>>> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
>>>> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
>>>>            /*
>>>>             * There is not enough unused space to fit to block align between BAT
>>>>             * and actual data. We can't avoid read-modify-write...
>>>> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>>
>>>>        for (i = 0; i < s->bat_size; i++) {
>>>>            sector = bat2sect(s, i);
>>>> -        if (sector + s->tracks > s->data_end) {
>>>> -            s->data_end = sector + s->tracks;
>>>> +        if (sector + s->tracks > file_nb_sectors) {
>>>> +            need_check = true;
>>>>            }
>>>>        }
>>>> -    need_check = need_check || s->data_end > file_nb_sectors;
>>>>
>>>>        ret = parallels_fill_used_bitmap(bs);
>>>>        if (ret == -ENOMEM) {
>>>> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(BlockDriverState *bs)
>>>>            end_off = (end_off + 1) * s->cluster_size;
>>>>        }
>>>>        end_off += s->data_start * BDRV_SECTOR_SIZE;
>>>> -    s->data_end = end_off / BDRV_SECTOR_SIZE;
>>>>        return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
>>>>    }
>>>>
>>>> diff --git a/block/parallels.h b/block/parallels.h
>>>> index 18b4f8068e..a6a048d890 100644
>>>> --- a/block/parallels.h
>>>> +++ b/block/parallels.h
>>>> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
>>>>        unsigned int bat_size;
>>>>
>>>>        int64_t  data_start;
>>>> -    int64_t  data_end;
>>>>        uint64_t prealloc_size;
>>>>        ParallelsPreallocMode prealloc_mode;
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>> Is it intended behavior?
>>>
>>> Run:
>>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
>>> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
>>> 3. ./qemu-img check  $TEST_IMG
>>>          No errors were found on the image.
>>>          Image end offset: 150994944
>>>
>>> Without this patch `qemu-img check` reports:
>>>          ERROR space leaked at the end of the image 145752064
>>>
>>>         139 leaked clusters were found on the image.
>>>         This means waste of disk space, but no harm to data.
>>>         Image end offset: 5242880
>> The original intention is do nothing at this point if an image is opened as
>> RO. In the next patch parallels_check_leak() was rewritten to detect
>> unused clusters at the image end.
>>
>> But there is a bug: (end_off == s->used_bmap_size) case is handled in an
>> incorrect way. Will fix it, thank you.
>>> Note: there is another issue caused by previous commits exists.
>>> g_free asserts from parallels_free_used_bitmap() because of
>>> s->used_bmap is NULL.
>> Maybe I don't understand your point, but if you meant that g_free() could be
>> called with NULL argument, it's not a problem. GLib Manual says:
>>
>>      void g_free (/|gpointer
>>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Basic-Types.php#gpointer>
>>      mem|/);
>>
>>      If /|mem|/ is|NULL|
>>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
>>      it simply returns, so there is no need to check /|mem|/ against
>>      |NULL|
>>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
>>      before calling this function.
>>
>>> To reproduce this crash at revision before or without patch 15/19, run commands:
>>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
>>> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
>>> 3. ./qemu-img check -r leaks $TEST_IMG
>> Sorry, but I couldn't reproduce it. Reset to 14/19, made the three steps
>> and had such output:
>>
>>      $ ./qemu-img create -f parallels $TEST_IMG 1T
>>      Formatting 'test.img', fmt=parallels size=1099511627776
>>      cluster_size=1048576
>>
>>      $ dd if=/dev/zero of=$TEST_IMG seek=12  bs=1M count=128 conv=notrunc
>>      128+0 records in
>>      128+0 records out
>>      134217728 bytes (134 MB, 128 MiB) copied, 0.0797576 s, 1.7 GB/s
>>
>>      $ ./qemu-img check -r leaks $TEST_IMG
>>      Repairing space leaked at the end of the image 141557760
>>      The following inconsistencies were found and repaired:
>>
>>      135 leaked clusters
>>      0 corruptions
>>
>>      Double checking the fixed image now...
>>      No errors were found on the image.
>>      Image end offset: 5242880
> My comment regarding patch 15 is about 'check' operation is not able
> to detect leaked data anymore.
> So, after this patch I see:
>
> $ ./qemu-img info   leak.bin
> image: leak.bin
> file format: parallels
> virtual size: 1 TiB (1099511627776 bytes)
> disk size: 145 MiB
> Child node '/file':
>      filename: leak.bin
>      protocol type: file
>      file length: 146 MiB (153092096 bytes)
>      disk size: 145 MiB
>
> $ ./qemu-img check -r leaks leak.bin
> No errors were found on the image.
> Image end offset: 153092096
>
> After reverting this patch  'check' reports about:
> ERROR space leaked at the end of the image 148897792
>
> So, after reverting patch 15 I tried to repair such image
> and got abort trap.
Yes, I understand this part. OK, I think, I could place 16 patch before 
15 and
leaks would handle in the correct way at any point of the patch sequence.
>
> I rechecked with downloaded patches, rebuild from scratch and can tell
> that there is no abort on master branch, but it appears after applying
> patches[1-9].
Maybe I do something wrong, but I reset to the top of mainstream, applied
1-9 patches, rebuilt QEMU and didn't see any abort.

> Obviously It can be debugged and the reason is that
> parallels_fill_used_bitmap() returns after
>
>   s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
>      if (s->used_bmap_size == 0) {
>          return 0;
>      }
>
> Because DIV_ROUND_UP(payload_bytes, s->cluster_size); gives a 0;
>
> So subsequent parallels_free_used_bitmap() called from
> parallels_close() causes an assert.
>
> So, the first invocation of parallels_free_used_bitmap is:
>    * frame #0: 0x0000000100091830 qemu-img`parallels_check_leak
> [inlined] parallels_free_used_bitmap(bs=0x0000000101011600) at
> parallels.c:263:33 [opt]
>      frame #1: 0x0000000100091830
> qemu-img`parallels_check_leak(bs=0x0000000101011600,
> res=0x000000016fdff5d8, fix=BDRV_FIX_LEAKS, explicit=true) at
> parallels.c:811:9 [opt]
>      frame #2: 0x0000000100090d80
> qemu-img`parallels_co_check(bs=0x0000000101011600,
> res=0x000000016fdff5d8, fix=BDRV_FIX_LEAKS) at parallels.c:1014:15
> [opt]
>      frame #3: 0x0000000100014f6c
> qemu-img`bdrv_co_check_entry(opaque=0x000000016fdff560) at
> block-gen.c:556:14 [opt]
>
> And the second generates abort from there:
>    * frame #0: 0x000000010008fef8 qemu-img`parallels_close [inlined]
> parallels_free_used_bitmap(bs=<unavailable>) at parallels.c:263:33
In this line we have:

    BDRVParallelsState *s = bs->opaque;

So there is only one possibility to abort - incorrect bs. I don't know 
how it
could be possible.

> [opt]
>      frame #1: 0x000000010008fef8
> qemu-img`parallels_close(bs=0x0000000101011600) at parallels.c:1501:5
> [opt]
>      frame #2: 0x0000000100019d3c qemu-img`bdrv_unref [inlined]
> bdrv_close(bs=0x0000000101011600) at block.c:5164:13 [opt]
>
> After the first parallels_free_used_bitmap(), there is an actual image
> truncation happens, so there is no payload at the moment of the next
> parallels_fill_used_bitmap(),
>
> PS: there are a chances that some patches were not applied clearly,
> I'll recheck this later.
I just reset to the mainstream top and apply 1-9 patches:

    $ git reset --hard 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
    HEAD is now at 2f3913f4b2 Merge tag 'for_upstream' of
    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
    $ git am *.eml
    Applying: parallels: Move inactivation code to a separate function
    Applying: parallels: Add mark_unused() helper
    Applying: parallels: Move host clusters allocation to a separate
    function
    Applying: parallels: Set data_end value in parallels_check_leak()
    Applying: parallels: Recreate used bitmap in parallels_check_leak()
    Applying: parallels: Add a note about used bitmap in
    parallels_check_duplicate()
    Applying: parallels: Create used bitmap even if checks needed
    Applying: parallels: Make mark_used() and mark_unused() global functions
    Applying: parallels: Add dirty bitmaps saving

> It would be nice if it was possible to fetch changes from some repo,
> rather than extracting  it from gmail.
You can fetch it here (branch "parallels") - 
https://github.com/AlexanderIvanov-Virtuozzo/qemu.git
>
> Regards,
> Mike.

-- 
Best regards,
Alexander Ivanov


