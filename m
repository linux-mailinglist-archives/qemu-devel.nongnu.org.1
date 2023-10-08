Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76B7BCEA6
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpUFE-0001ru-Md; Sun, 08 Oct 2023 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qpUFB-0001r2-Nq; Sun, 08 Oct 2023 09:54:53 -0400
Received: from mail-vi1eur02on20729.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::729]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qpUF8-0000gL-CJ; Sun, 08 Oct 2023 09:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leW+3yO38aTF8qE3xn7Rk3oPoqaJI8o32uuvRsYt4jv5h5upm0smq8lbgCZtZxfTNnfPpQOYk1nNO4yi2zm5wN1JnEc+Y6ekgCDprIqAKc4BkQEeZUcBraVR+nQ1ChB6KIc+3DrafxpFwLsrckHYOXvptpUSsmw0/EZEzKBAK3D11s2c2srEmTP+daQh8Jo/JpuwDq4dogeJTkuMVBCfUhlwyJwkz2FtcTUFG6lckbHkGCjIFq1UMUjkb9TVb3Wf3fKOQfTr9BGjl+e5NbYCvSfXUMn7XlFRlN68fL3quKBmnLlGYF+9G2/av4rt01XIcz2EC/W0WNK2gMqSH480BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0FNBLaHW5cHaJpAFuHuBe65L3Wb37nhxkyBhPpaV6w=;
 b=Xm3S+EWQ2Y0cRbbywTfF19w2XhfTHIlEQH+99myfxtkwELv6YiGvDwPqPA0URN2D09E88NOQ1V0UIZtzeez6IB73UAPJzc5iPiMJ4g/P3b2A+bZe+YNA6VERBMqZURD46Y2dTQ7UaZ+K5mRkh9aYpEItS+UFJSDuupNulAbfFiYNVLaMmdY2c/0fzFMC+EVeEW5rppgIi2N84nznogftIQpwq+5l7DVLKK2oj+D1uQ4YsCcooHbIdo6gFeRXdVx8OvQftQClDXv+TOwZuA9a4PqRzpkSLAgMfv70V0Aji7/HHbhxPYrpxMSxBu7iLuXFWpnPdaUDWA7tVe1VIExTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0FNBLaHW5cHaJpAFuHuBe65L3Wb37nhxkyBhPpaV6w=;
 b=oqzBr3yXOktIiSYKKerHygCGRoDoyZtG5hz5Y+BknX5SQVDk45nEeXfKTt8VUD/zuVykAuHwaTg76POCotdd1i3VI/jNJcAJeOaEZPPpfrMvdZsOdi0dh7M3Ai/fip8JJFZnU10xQ9aE/fOvdSOG78iUDf/3yyWFIAfpBlWQFFFIGM2hOX0M1nv2PmJXxgoKLRP/6d7rodLRQx8CxRxhMMH5/pV60G50oFZVPYNiA+0s3iQvUfZ03UpP0vNrDKHBGvFvbjcqStBWohmqSJBXDxgYvJ7bpmMe4V3nU/GimYfNwdbR6dMKcOM2zfCcBVa70ajPKB3kJuVsVc1XV/OEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by PAVPR08MB9723.eurprd08.prod.outlook.com (2603:10a6:102:31e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 13:54:43 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%10]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 13:54:42 +0000
Message-ID: <a678d4ce-b98b-4ea9-89e9-7c30ee1e2017@virtuozzo.com>
Date: Sun, 8 Oct 2023 15:54:31 +0200
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
 <9240b820-9d8f-42bc-a4f1-7a69656635a4@virtuozzo.com>
 <CAL77WPC4ae+YzxBwNg9jLn93FUAuC8-b3vwzge7ktYBm62_1SQ@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPC4ae+YzxBwNg9jLn93FUAuC8-b3vwzge7ktYBm62_1SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|PAVPR08MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: e3149044-cdff-497a-b6bc-08dbc8061efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/hBE5CMQaWSXe1MamIYgyTQKZkOFddOZbpp1mPfPSmlOoe+p+PCfjN7Zcm3LrxlRX42VuqdsurCiSxxIl5S1pbXjtZu2SoYcDfHPbyWWG922Ya4oSFpyJcOYawkfLsD17gIud2I1lGA7/eI0D6jm9BOv5KWzoLcoabyDjCPbsvUuLogORn/l7P7CUYM/hzhRk7jlTjdEz2UjGJHEheJXy1DAMSv98iHt0cbm+HFkC56e6SqwreZlg/1/S+G4S/5fFvzIui5m7gNMxyboItu0lMmexZ8egnX4FqodYvAjiGnTiGPZcgKUi0YzrLMqi7TYyWuF2cXpG36YqHJRYqbF0ol9SfomxXBqkFmnPyPs4aZqcUSQCc6Hl425oLfCQrdOv/Q4YdHWu9C6UV3LecV5meQhXkXIuXu/7mE6JZVtZoGAdidYnTAnbb241w8hVjM4dZm17Wr/1ScqXd4is0YA+mKI/oY4+JL4TtJDUeJUmMnVlOpQ32pG1vDaFPDaE9pl92h82PDxo67RBHYZeWDy7CWMDob5/Q9CsHX9YGirqSzVi3bdcAnMK8HBxxDLkC+ev56D3sa7yllaaN849tXJTveORlGl44A+KuuQQYNODj4fV8SSrfBksCDtCJfgXSl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39830400003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(6666004)(53546011)(6486002)(6506007)(478600001)(966005)(2616005)(26005)(2906002)(316002)(41300700001)(44832011)(6916009)(5660300002)(4326008)(8936002)(8676002)(66476007)(66556008)(66946007)(16799955002)(38100700002)(31696002)(86362001)(30864003)(36756003)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxTOE1lMTAyWWdGNC9lSWlEekdMMzhoQVFlREY5clEvb3ZwQnozVmJZSmJQ?=
 =?utf-8?B?ekNlSVNSb0E0YmVzTzZLOUxTckFIY3JrQWhyTTN3N21JTUlmTEhid3JMbUZn?=
 =?utf-8?B?Ym1RREVkUHJwc1Y3dnQ0R2dVS0xPUlZ3NS84bTFoTUxNRXd1T2hpeGliSm90?=
 =?utf-8?B?dDNpUU1nNnJvaWU1WWdNUUFrY2RvbCtRTUxwNHREOFNNWkZSU1dJbExKV25H?=
 =?utf-8?B?R3I5SVZQRENPQXBqZHlHdEZKUlYrQjR1Ukt5cU1pU0c2QkRIL0pFM3kzemtU?=
 =?utf-8?B?T3U0d0dPM2dPMTJxV0xmRURycnpUaEt1N0x6NGQycnVUaHBaeXlrZlNaWkdK?=
 =?utf-8?B?eHM4UU5WYVVrMEVRdS9FTEtWeDNrTFVFQ21NTkgwamplbzMzdlpvQm5OMmY0?=
 =?utf-8?B?RHZDNXlNZVJlWTcxaEdubVhpRHN2ZFJzQ1Z2anI5b0J6U2pRTnRrOHY4TzFJ?=
 =?utf-8?B?cFhpOGRISnpqYkc1M1lCVHJyN0xWY1JZQXVFQ1l1NHN2VnEyT0V5dWV6cmdO?=
 =?utf-8?B?Mm5sYTJWNE1tRFZpUnJaazhzYlhkenJheUtQV1BuK1c2R2x2Y3dpRXlsNDRH?=
 =?utf-8?B?SkZmMDFjdzMrS3hNeFRRSm10NmwrdnFhYmVYNEN3RWsvT2QwZGd0OE5lVlZK?=
 =?utf-8?B?OHhqUFkwdWRHY3FZK3Z4bS85WWlNRWxBeC9iNWVOK205dWEwcjlsT0l2SlEr?=
 =?utf-8?B?RmJvaWdORjZUL0xRUmpEMGlLdkdDbXBub2NkRk10a2YzTTB4azAvVUFuYmlX?=
 =?utf-8?B?bjRETnFIbFZQdS9EVzMzbkl3MnV5SXJkc2IxdS82cHFGUElCSVdYbHY1ci80?=
 =?utf-8?B?NE5tYU9oMjhyQlg2NHZtclRFalpqMEIvQzVBbDJYMHZqcjlkK2tPRWhrWGQ5?=
 =?utf-8?B?R0xobWFtUGpkR01JM05NRjFnMXBTTEp6dVk4enVURkNtNDRiNmNDNUxNTGR5?=
 =?utf-8?B?T2xiS1Y0OE4vanVIQjJkOVVGV1Y2LzQ5NEhNb0syREZzSDBLdkx6cWVENmV1?=
 =?utf-8?B?dmVYVGxmOURndjFkc1ZHeEtDVy8rNHJwaysvL3QyalVrdTBRa1NjNE5rU1ZK?=
 =?utf-8?B?em15S2xlZVBQcXVGdmNjMCsvVXBCOC9VYkJreDRpWTJSUlJBYVJqaCtNbm0v?=
 =?utf-8?B?ZnF2Z0tQOGJMeHJUUGVwNDhaQ3hYWk1Ya3JlVlUrSXhZZG95OHNOTWwrUkJk?=
 =?utf-8?B?TVFEL2I5ajlRVnJJa1NrOE8zRFBKbmVERXlRcWRyWmN0OTV6aU5RWVkyc3Yv?=
 =?utf-8?B?VHZFd3hyaGRSOGtRR2NEbWlHYXFnYlp6YklML3pZRFptK0VEU3NGZFpHdWlz?=
 =?utf-8?B?b3JMK1VaYkloT3QzZ1JHalFNcXY1ZndRcGtDWStJL1hGNDlqdDdQeWl5V1Zx?=
 =?utf-8?B?TkRxQ2phMHlSY1kyWEFaZk1vZDdpQXFyWU5HUHgyL2xJM2g5YTdzMGRWQ1NW?=
 =?utf-8?B?U2lyVk1aeVdmdXpDcUtUWEZQUVNCckNjY2tXdDVkSkViK0kwdC9zd3MzOG1I?=
 =?utf-8?B?bEJEUzl5OFdRNE5iZEpQaFFsL2lWZDVlYUxvQkNLMmVkNnIvOHVsTHV1SE1k?=
 =?utf-8?B?SW5UZUhhaXc0eVlSOHBDbTJzUEI3VG1BSHRNYTQzZHNkQ0lnL3AvdWE0c2tD?=
 =?utf-8?B?Z1ptZWNTUGlCV0NITWpEVWJyRW41M0dncDlReEFka20vZDlFcVl4cnlCcjlO?=
 =?utf-8?B?a1c4aGJlZUh3UTV1SSs4Y2pyZ0hVSm15cTl0UU44SWQyQ3lOeEpOVE80ZHA5?=
 =?utf-8?B?N2MxVm9tbmtmTnlVb1ZaSTFtb2xSUGJhZXRkejE4QmdCRko0K1NlaFNNbVlW?=
 =?utf-8?B?QVg0VFppc3BsZUxBNnFyZVIwejhtY1RuUllKRXBzUmh4NCtOaWYyb3d0aU9m?=
 =?utf-8?B?WEh2NVIyTmorZGNaZWRndTM5bmJucEdpVklCS2VCOURJTFVQWlI5RTRlOTFu?=
 =?utf-8?B?R3RBalNSWW0rbkdhNFExNDdaUTdlSUdvdGM3VTF2WWpvY2ZFVW5DTy9DK0JB?=
 =?utf-8?B?cmZ0dU9DTmVEaldNL2kyUHB3NysxRmQ5eU0zVjYvNlFCUElZQ2YrNExaU1RT?=
 =?utf-8?B?dHp0U0d3Q205dTVadVNjL2lUdGtDb1lydkk5WUZJbGJ1N0dhV1BGQ0FGRVJK?=
 =?utf-8?B?RFcyZ0ZVbjlTNGl4ekZyYjZvUS9KNEhkSGxHVEtwTFd5bjVXb05FcU85K3Vs?=
 =?utf-8?Q?2U1rI8inY+KP+hOlhqjcFoo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3149044-cdff-497a-b6bc-08dbc8061efb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 13:54:42.1780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jITksw/CN4y5IX2L8HYmbLTitVS01KJp7PLisoos4eoR9EiB5+xpB4K6YNjvUCIQNLDEvwuq4fG/KcAFkqtOGPIPyPxETVR2Da5JXS5S1Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9723
Received-SPF: pass client-ip=2a01:111:f400:fe16::729;
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



On 10/7/23 19:54, Mike Maslenkin wrote:
> On Sat, Oct 7, 2023 at 5:30 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com> wrote:
>>
>>
>> On 10/7/23 13:21, Mike Maslenkin wrote:
>>> On Sat, Oct 7, 2023 at 1:18 PM Alexander Ivanov
>>> <alexander.ivanov@virtuozzo.com>  wrote:
>>>> On 10/6/23 21:43, Mike Maslenkin wrote:
>>>>> On Mon, Oct 2, 2023 at 12:01 PM Alexander Ivanov
>>>>> <alexander.ivanov@virtuozzo.com>  wrote:
>>>>>> Since we have used bitmap, field data_end in BDRVParallelsState is
>>>>>> redundant and can be removed.
>>>>>>
>>>>>> Add parallels_data_end() helper and remove data_end handling.
>>>>>>
>>>>>> Signed-off-by: Alexander Ivanov<alexander.ivanov@virtuozzo.com>
>>>>>> ---
>>>>>>     block/parallels.c | 33 +++++++++++++--------------------
>>>>>>     block/parallels.h |  1 -
>>>>>>     2 files changed, 13 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/block/parallels.c b/block/parallels.c
>>>>>> index 48ea5b3f03..80a7171b84 100644
>>>>>> --- a/block/parallels.c
>>>>>> +++ b/block/parallels.c
>>>>>> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>>>>>>         g_free(s->used_bmap);
>>>>>>     }
>>>>>>
>>>>>> +static int64_t parallels_data_end(BDRVParallelsState *s)
>>>>>> +{
>>>>>> +    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
>>>>>> +    data_end += s->used_bmap_size * s->cluster_size;
>>>>>> +    return data_end;
>>>>>> +}
>>>>>> +
>>>>>>     int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>>>                                              int64_t *clusters)
>>>>>>     {
>>>>>> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>>>
>>>>>>         first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
>>>>>>         if (first_free == s->used_bmap_size) {
>>>>>> -        host_off = s->data_end * BDRV_SECTOR_SIZE;
>>>>>> +        host_off = parallels_data_end(s);
>>>>>>             prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
>>>>>>             bytes = prealloc_clusters * s->cluster_size;
>>>>>>
>>>>>> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>>>             s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
>>>>>>                                               new_usedsize);
>>>>>>             s->used_bmap_size = new_usedsize;
>>>>>> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
>>>>>> -            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
>>>>>> -        }
>>>>>>         } else {
>>>>>>             next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
>>>>>>
>>>>>> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
>>>>>>              * branch. In the other case we are likely re-using hole. Preallocate
>>>>>>              * the space if required by the prealloc_mode.
>>>>>>              */
>>>>>> -        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
>>>>>> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
>>>>>> +        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
>>>>>>                 ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
>>>>>>                 if (ret < 0) {
>>>>>>                     return ret;
>>>>>> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
>>>>>>             }
>>>>>>         }
>>>>>>
>>>>>> -    if (high_off == 0) {
>>>>>> -        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
>>>>>> -    } else {
>>>>>> -        res->image_end_offset = high_off + s->cluster_size;
>>>>>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>>>>>> -    }
>>>>>> -
>>>>>> +    res->image_end_offset = parallels_data_end(s);
>>>>>>         return 0;
>>>>>>     }
>>>>>>
>>>>>> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>>>>>>                 res->check_errors++;
>>>>>>                 return ret;
>>>>>>             }
>>>>>> -        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>>>>>>
>>>>>>             parallels_free_used_bitmap(bs);
>>>>>>             ret = parallels_fill_used_bitmap(bs);
>>>>>> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>>>>         }
>>>>>>
>>>>>>         s->data_start = data_start;
>>>>>> -    s->data_end = s->data_start;
>>>>>> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
>>>>>> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
>>>>>>             /*
>>>>>>              * There is not enough unused space to fit to block align between BAT
>>>>>>              * and actual data. We can't avoid read-modify-write...
>>>>>> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>>>>>>
>>>>>>         for (i = 0; i < s->bat_size; i++) {
>>>>>>             sector = bat2sect(s, i);
>>>>>> -        if (sector + s->tracks > s->data_end) {
>>>>>> -            s->data_end = sector + s->tracks;
>>>>>> +        if (sector + s->tracks > file_nb_sectors) {
>>>>>> +            need_check = true;
>>>>>>             }
>>>>>>         }
>>>>>> -    need_check = need_check || s->data_end > file_nb_sectors;
>>>>>>
>>>>>>         ret = parallels_fill_used_bitmap(bs);
>>>>>>         if (ret == -ENOMEM) {
>>>>>> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(BlockDriverState *bs)
>>>>>>             end_off = (end_off + 1) * s->cluster_size;
>>>>>>         }
>>>>>>         end_off += s->data_start * BDRV_SECTOR_SIZE;
>>>>>> -    s->data_end = end_off / BDRV_SECTOR_SIZE;
>>>>>>         return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
>>>>>>     }
>>>>>>
>>>>>> diff --git a/block/parallels.h b/block/parallels.h
>>>>>> index 18b4f8068e..a6a048d890 100644
>>>>>> --- a/block/parallels.h
>>>>>> +++ b/block/parallels.h
>>>>>> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
>>>>>>         unsigned int bat_size;
>>>>>>
>>>>>>         int64_t  data_start;
>>>>>> -    int64_t  data_end;
>>>>>>         uint64_t prealloc_size;
>>>>>>         ParallelsPreallocMode prealloc_mode;
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>> Is it intended behavior?
>>>>>
>>>>> Run:
>>>>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
>>>>> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
>>>>> 3. ./qemu-img check  $TEST_IMG
>>>>>           No errors were found on the image.
>>>>>           Image end offset: 150994944
>>>>>
>>>>> Without this patch `qemu-img check` reports:
>>>>>           ERROR space leaked at the end of the image 145752064
>>>>>
>>>>>          139 leaked clusters were found on the image.
>>>>>          This means waste of disk space, but no harm to data.
>>>>>          Image end offset: 5242880
>>>> The original intention is do nothing at this point if an image is opened as
>>>> RO. In the next patch parallels_check_leak() was rewritten to detect
>>>> unused clusters at the image end.
>>>>
>>>> But there is a bug: (end_off == s->used_bmap_size) case is handled in an
>>>> incorrect way. Will fix it, thank you.
>>>>> Note: there is another issue caused by previous commits exists.
>>>>> g_free asserts from parallels_free_used_bitmap() because of
>>>>> s->used_bmap is NULL.
>>>> Maybe I don't understand your point, but if you meant that g_free() could be
>>>> called with NULL argument, it's not a problem. GLib Manual says:
>>>>
>>>>       void g_free (/|gpointer
>>>>       <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Basic-Types.php#gpointer>
>>>>       mem|/);
>>>>
>>>>       If /|mem|/ is|NULL|
>>>>       <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
>>>>       it simply returns, so there is no need to check /|mem|/ against
>>>>       |NULL|
>>>>       <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.php#NULL:CAPS>
>>>>       before calling this function.
>>>>
>>>>> To reproduce this crash at revision before or without patch 15/19, run commands:
>>>>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
>>>>> 2. dd if=/dev/zero of=$TEST_IMG oseek=12  bs=1M count=128 conv=notrunc
>>>>> 3. ./qemu-img check -r leaks $TEST_IMG
>>>> Sorry, but I couldn't reproduce it. Reset to 14/19, made the three steps
>>>> and had such output:
>>>>
>>>>       $ ./qemu-img create -f parallels $TEST_IMG 1T
>>>>       Formatting 'test.img', fmt=parallels size=1099511627776
>>>>       cluster_size=1048576
>>>>
>>>>       $ dd if=/dev/zero of=$TEST_IMG seek=12  bs=1M count=128 conv=notrunc
>>>>       128+0 records in
>>>>       128+0 records out
>>>>       134217728 bytes (134 MB, 128 MiB) copied, 0.0797576 s, 1.7 GB/s
>>>>
>>>>       $ ./qemu-img check -r leaks $TEST_IMG
>>>>       Repairing space leaked at the end of the image 141557760
>>>>       The following inconsistencies were found and repaired:
>>>>
>>>>       135 leaked clusters
>>>>       0 corruptions
>>>>
>>>>       Double checking the fixed image now...
>>>>       No errors were found on the image.
>>>>       Image end offset: 5242880
>>> My comment regarding patch 15 is about 'check' operation is not able
>>> to detect leaked data anymore.
>>> So, after this patch I see:
>>>
>>> $ ./qemu-img info   leak.bin
>>> image: leak.bin
>>> file format: parallels
>>> virtual size: 1 TiB (1099511627776 bytes)
>>> disk size: 145 MiB
>>> Child node '/file':
>>>       filename: leak.bin
>>>       protocol type: file
>>>       file length: 146 MiB (153092096 bytes)
>>>       disk size: 145 MiB
>>>
>>> $ ./qemu-img check -r leaks leak.bin
>>> No errors were found on the image.
>>> Image end offset: 153092096
>>>
>>> After reverting this patch  'check' reports about:
>>> ERROR space leaked at the end of the image 148897792
>>>
>>> So, after reverting patch 15 I tried to repair such image
>>> and got abort trap.
>> Yes, I understand this part. OK, I think, I could place 16 patch before
>> 15 and
>> leaks would handle in the correct way at any point of the patch sequence.
>>> I rechecked with downloaded patches, rebuild from scratch and can tell
>>> that there is no abort on master branch, but it appears after applying
>>> patches[1-9].
>> Maybe I do something wrong, but I reset to the top of mainstream, applied
>> 1-9 patches, rebuilt QEMU and didn't see any abort.
>>
>>> Obviously It can be debugged and the reason is that
>>> parallels_fill_used_bitmap() returns after
>>>
>>>    s->used_bmap_size = DIV_ROUND_UP(payload_bytes, s->cluster_size);
>>>       if (s->used_bmap_size == 0) {
>>>           return 0;
>>>       }
>>>
>>> Because DIV_ROUND_UP(payload_bytes, s->cluster_size); gives a 0;
>>>
>>> So subsequent parallels_free_used_bitmap() called from
>>> parallels_close() causes an assert.
>>>
>>> So, the first invocation of parallels_free_used_bitmap is:
>>>     * frame #0: 0x0000000100091830 qemu-img`parallels_check_leak
>>> [inlined] parallels_free_used_bitmap(bs=0x0000000101011600) at
>>> parallels.c:263:33 [opt]
>>>       frame #1: 0x0000000100091830
>>> qemu-img`parallels_check_leak(bs=0x0000000101011600,
>>> res=0x000000016fdff5d8, fix=BDRV_FIX_LEAKS, explicit=true) at
>>> parallels.c:811:9 [opt]
>>>       frame #2: 0x0000000100090d80
>>> qemu-img`parallels_co_check(bs=0x0000000101011600,
>>> res=0x000000016fdff5d8, fix=BDRV_FIX_LEAKS) at parallels.c:1014:15
>>> [opt]
>>>       frame #3: 0x0000000100014f6c
>>> qemu-img`bdrv_co_check_entry(opaque=0x000000016fdff560) at
>>> block-gen.c:556:14 [opt]
>>>
>>> And the second generates abort from there:
>>>     * frame #0: 0x000000010008fef8 qemu-img`parallels_close [inlined]
>>> parallels_free_used_bitmap(bs=<unavailable>) at parallels.c:263:33
>> In this line we have:
>>
>>      BDRVParallelsState *s = bs->opaque;
>>
>> So there is only one possibility to abort - incorrect bs. I don't know
>> how it
>> could be possible.
>>
>>> [opt]
>>>       frame #1: 0x000000010008fef8
>>> qemu-img`parallels_close(bs=0x0000000101011600) at parallels.c:1501:5
>>> [opt]
>>>       frame #2: 0x0000000100019d3c qemu-img`bdrv_unref [inlined]
>>> bdrv_close(bs=0x0000000101011600) at block.c:5164:13 [opt]
>>>
>>> After the first parallels_free_used_bitmap(), there is an actual image
>>> truncation happens, so there is no payload at the moment of the next
>>> parallels_fill_used_bitmap(),
>>>
>>> PS: there are a chances that some patches were not applied clearly,
>>> I'll recheck this later.
>> I just reset to the mainstream top and apply 1-9 patches:
>>
>>      $ git reset --hard 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
>>      HEAD is now at 2f3913f4b2 Merge tag 'for_upstream' of
>>      https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>>      $ git am *.eml
>>      Applying: parallels: Move inactivation code to a separate function
>>      Applying: parallels: Add mark_unused() helper
>>      Applying: parallels: Move host clusters allocation to a separate
>>      function
>>      Applying: parallels: Set data_end value in parallels_check_leak()
>>      Applying: parallels: Recreate used bitmap in parallels_check_leak()
>>      Applying: parallels: Add a note about used bitmap in
>>      parallels_check_duplicate()
>>      Applying: parallels: Create used bitmap even if checks needed
>>      Applying: parallels: Make mark_used() and mark_unused() global functions
>>      Applying: parallels: Add dirty bitmaps saving
>>
>>> It would be nice if it was possible to fetch changes from some repo,
>>> rather than extracting  it from gmail.
>> You can fetch it here (branch "parallels") -
>> https://github.com/AlexanderIvanov-Virtuozzo/qemu.git
>>> Regards,
>>> Mike.
>> --
>> Best regards,
>> Alexander Ivanov
>>
> Thanks for the link. I've fetched your repo and reverted "parallels:
> Remove unnecessary data_end field" as it hides reproduction,
> because it makes 'check' blind for the case we are discussing.
> So the situation is the same:
> 1. parallels_open calls parallels_fill_used_bitmap(). A this time file
> size is 145M (i.e leaked clusters are there) and s->used_bmap_size =
> 139.
> 2  Then parallels_co_check()->parallels_check_leak () is invoked.
>       At the first parallels_check_leak calls
> bdrv_co_truncate(offset=5242880), that is true as we have only empty
> BAT on the image.
>       At this step image truncated to 5M i.e. contains only empty BAT.
>       So, on line 809 s->data_end = 10240 i.e 5M (10240<<9)
>        809:         s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
>
>        811:        parallels_free_used_bitmap(bs);
>        812:        ret = parallels_fill_used_bitmap(bs);
>
> Line 811 invalidates used_bmap and sets used_bmap_size to 0.
> parallels_fill_used_bitmap Invoked on line 812  returns 0, because
> payload_bytes = 0 (current file size 5M - s->data_start *
> BDRV_SECTOR_SIZE ),
> and s->used_bmap_size is NOT initialized.
>
> 3. parallels_close() invoked to finish work and exit process.
>     parallels_close() calls  parallels_free_used_bitmap() unconditionally.
>
> static void parallels_free_used_bitmap(BlockDriverState *bs)
> {
>      BDRVParallelsState *s = bs->opaque;
>      s->used_bmap_size = 0;
> ASSERT IS HERE >>>>  g_free(s->used_bmap);
Oh, now I see, s->used_bmap is not reset to NULL in 
parallels_free_used_bitmap().
That's why I could not reproduce the bug - on my system by a chance 
s->used_bmap
contained NULL.

Maybe it would be better to put NULL to s->used_bmap in
parallels_free_used_bitmap() and let g_free() handle NULL argument 
properly?
> }
>
> The fix is trivial...
>
> if (s->used_bmap_size) {
>     g_free(s->used_bmap);
>     s->used_bmap_size = 0;
> }
>
> PS: I retuned to your HEAD. Killed gdb thus made image marked is
> incorrectly closed.
> But 'qemu-img check' only removed  incorrectly closed flags and didn't
> remove leaked clusters.
Will work on it.
>
> Regards,
> Mike.

-- 
Best regards,
Alexander Ivanov


