Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAA9761D19
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 17:15:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJjT-0006Ya-FP; Tue, 25 Jul 2023 11:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOJjP-0006YE-SW; Tue, 25 Jul 2023 11:13:48 -0400
Received: from mail-vi1eur04on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70b]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOJjJ-000480-J1; Tue, 25 Jul 2023 11:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ4njw08TRMFV6t3ZlhTIcSmsv0rb8c96Kw9D3WyHLmwr0+kFxkAPy4eXbnqr6A9awHt0uj+83oIuVV5/BfsQfG7S/Q3YW0D8QskShiRP9hAwCWleTmDqGhPitDX0fQtZw7Nocs6QxRXV49OEtngvee00eAVIisL2ZDASiS7H8iv6L8tl1DSz62BtnpCP1x8PC+nh/U6eGn+mU/9BndIvwB37yPXX4ePWzN+05p8tLAjDczi0Yp7fPO0YyZcCcb1Lw3pPvJTeCeNL9t8zyU2Zrv/YYLRyRj6u5lW+YGdpZT1Vh0XyZ9YI31+7j2/OmG9nlMwkBV95Lu57clTWLbwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljGxJGp/xXLTjrguX+eC/Sc7apY+tdIp63hNgcA2WqQ=;
 b=APpsQbemF5zPuaC4yR9l6QgmTchvvkcYXPO1FUjEDvNe/TEHXaLEyXhFSXkOZSwatGYogLYoOPkZc9TI/B8wBbxI2+dDZ9Vsxvx7PbRiq+PK2CiiHq0IF6b4f8RJ/ePkFsXPZjo9DIhChvORsBPQYblVKlVMp7Vux/AgQLJxUOnQRXhEHzdhC8Rquvi0bwYQ3zhMQ2YD3ATRXsPxFobOQIxcTIfN7ZXl2xyRY/IiereS/n4KV07nY/QRYcJX1ItKaaO4JX04Li4ASlSpSWGNVLbjhPDqgL+ljVRhnoz7w/vh8G0WaVMratVOh4/VQYW17RwKDL0tgP6G+pBTs00e8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljGxJGp/xXLTjrguX+eC/Sc7apY+tdIp63hNgcA2WqQ=;
 b=APSx5QzfEFKPz+/G2ExLyb75ow7lO+qZX8ysns7grr55AJiJthzOckrNyF01TX/HlV9gaEOAq7HDhYhx3s3ftwdwJPrk7jv7VvK8mLdWrPOCk39D8BZ47mOwnzbFRc+ez5DX1mzr7wsQGMwhe6tQdVVxnjg0jwTzqFq50y0jiCBVlLfkrHlzgGRHTKTxKtXApZywEJscNddcShakI4EIjl6DTGiVzSrjABtMUs/pHuu/N6giFf2yQM8hE2eFHNyS8pyVHLmfDPMI2LS181GsgRv3cnBFeF2BxRBRhWDpgWPjsWqm5Y6Km9n/cECg8RzEedq9fBetOnx/rQQcIHvpAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB5959.eurprd08.prod.outlook.com (2603:10a6:20b:298::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 15:13:26 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:13:26 +0000
Message-ID: <056da915-b243-bf5a-dea6-43a7a8c9ec9e@virtuozzo.com>
Date: Tue, 25 Jul 2023 17:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] block/stream:add flush l2_table_cache,ensure data
 integrity
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Evanzhang <Evanzhang@archeros.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <cover.1690166344.git.Evanzhang@archeros.com>
 <bce1328c87f7e5d877dead476e9e66036cc4f7d8.1690166344.git.Evanzhang@archeros.com>
 <9e3f6e08-92d5-7292-e94c-5f626f65d6c2@yandex-team.ru>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <9e3f6e08-92d5-7292-e94c-5f626f65d6c2@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:803:64::45) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 619a4001-1c7c-454e-6046-08db8d21b1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYGq+Hut4KHBDwXz5AH1I+ggjcfUYq7Qk+/aysSEaiuUZ2rkakktenFcd79vbOSiO3ULLOFvUPTEFrWQu9dbLeAADFVvdHvb3IgHq18B94XHcSy2SzyhvFArtj1XbSZLaCV2FjZ00n829u2HgNSyQto1TU0Xi5HQfYLxIUTisn9LHD7iL+1C7baCcNhA81yY9GkSvVKa3C2cXidDMzVwaWBa1akfVSeZpYLA8aZb0IVmbmO/hEn5nMkyvhecDRsjNmgUVUaqkSw1Qo3wE6TmBMCed4/OesyQBeFQPGPZYEu/cavKG+LxlmHntlwlUTAXOSXf407wTObIClZDvUxenZKcR3RRWaPXbizGCSTtRCRMLAypkg+ZowsS1lg/hheNOySghCXR55+DDDJ/BVcMiEIj7JCLdA867bVcuBR3l/VaJfEwZNprcsvO+0xNOKxFid/jfr3KlzSaCTI74t6itazsJtwssyFvfOaApydG4x7/hNlNYeqYgoMaSOK3WLJlM0kdNj1j7Q1pqsiu+QSXw7N3jzGgT9ndLfttTGWxaVZCzZ7UBXVwrKGLblvGJl0gvH5gOeEHTa0pt6b2yshlj6HeEum/lzKZI9rgyJrMJmz4eM+Dluu9plupHvFpon9K6ah5Se/aSIxJ0OReYHU1Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(186003)(6506007)(53546011)(5660300002)(31696002)(36756003)(8676002)(8936002)(2906002)(2616005)(86362001)(38100700002)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6512007)(966005)(6486002)(83380400001)(41300700001)(31686004)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25wMXhmQ0RkU203TE1YS3JGcnd6M2hqaDdKam1KdGgyQk84NGlNdmlZaTZv?=
 =?utf-8?B?b0NtMHFpUWlMM2VFNGljWjNTbFhSN2gxblJlRVU5WXlHdHViNDA0aVZuS2ph?=
 =?utf-8?B?SFYxcWl3ZE8rNUtqYnh5WjFhMXBFamhpa2VFU3RlODAvSkROOXNtNkJva2to?=
 =?utf-8?B?ZFR1SDBGOVc3RWxzK210RnYxNFdyNlNFeWhZTDd1dVo5Yktkb05kS1B5MEw4?=
 =?utf-8?B?S1JGNnhSYm5veVlZZXRjd2c3dzMyUGRoaUUybE0wOXJZaXhJVTBEUHZLRTcr?=
 =?utf-8?B?eHREdnpmM3Q5TGovSW5QaytGMkdUWnJyVWt4bFNvN2dINm5ZTEJxOHhHM0hB?=
 =?utf-8?B?TU93YjBqREdYNUpFenpuanE1KzVQeG1OZFQyb1hyRVRzWUY1bG9URHBpY1Fn?=
 =?utf-8?B?K002QlFUS3ZIUDIrQ3hVQTRjY281WFlHV3pockdMc2VQTVl5dTVUNXY4YmJl?=
 =?utf-8?B?QW9TYWVnTFFMSEhja1JubU44L1dLTTI0dU1vN1pkRHJtcjZVUXF6d0N5a210?=
 =?utf-8?B?clA4WUdDdUFDWlpYSHlmRXhVRkFHdWtFb3luTzRsQWFBVC9oNHIxOVBwTWZm?=
 =?utf-8?B?N2l0YzFtL25qTmthNkVESytuNFllR3QyUFk5NzZVSXFlTllFdTc0bW1TQU5k?=
 =?utf-8?B?d2NJek9TeVRmdmJrckRtMnVhdzhPL1YyUUxSOVVKT1lzamt3MEtKWnEwSDZ0?=
 =?utf-8?B?Mys4RTVGajlBZFBPUUJ1VzhGNWRPZ3BqTmQrdm9nUE1JVkp0SUt0azBtZHUz?=
 =?utf-8?B?Smcwa1JjeXRWcGp5aHBoNzVaQ3NmdjQrZmxrbzhBOWJQNWFXTlo4UHplNDdm?=
 =?utf-8?B?WWFpRmxzQmFTUzh4ajVwMXFuMll2VkpVeTNjd05yVDBZZzNpZkZhc3c1U1Yv?=
 =?utf-8?B?NkZXMHVqVkJJOTllZklib0xFZXF4VkZaa1hFUzFvQ09nYVlTcXFEQzVQS3c3?=
 =?utf-8?B?R0k3dmJhTC9hb3pLYnM2S1ZZYWcvc1JHSzU3SER6YlpoR2NXWGxyVUVxblFU?=
 =?utf-8?B?K01EdjMvRS9KcVZOZmxQaUhmZkkrbXEyekVMWHR1TDl0cy82cGRmWGpWM1F0?=
 =?utf-8?B?aTZyZ1FRYUhHOGo3TDlYTk9aNWordUkrNGZZeWZSU2tjMDduU1F5RmRXNnNK?=
 =?utf-8?B?QTVSeW94TUVFMlBEU2g0ZkpnVXZzS20zQWRxOFJnZUlhdytFNkhXWnVXV3hS?=
 =?utf-8?B?Q29BVm50b05xVXBKQjFmK3FtRHh2cU5MNmlEcmNjUWVoUzhjbGRyODdNUjU3?=
 =?utf-8?B?Q1V5UTVHK2xXcjl5bTl4RnlMMDdUeWxPcklhMllPemZ3NVF4OHJwTzMwc0JG?=
 =?utf-8?B?Y2RyTnFNVzNhR2drN1RZcUx0U2toSFZqY3hMYkF4cEVPZXNFNjZzaml1cWZt?=
 =?utf-8?B?WlFjTTRueVQxV3FyakFqQWJ4WGh0dVpJVmlTcTVURWpkaXZLVzlQblhpMUha?=
 =?utf-8?B?UmpYYW0xT0RsLzJWN0dkcFdZRitKUlAvbnk2Qnd1SzBsOW5veDB3SWNiRE1q?=
 =?utf-8?B?TjRoVUxhcERvZ0hZSCtaVjJqcFVzd0pidHlXSEcyMDVURjBjcWRyNjhjVnRh?=
 =?utf-8?B?eVBUOTE1RnY1U2ZGK3NhMExZS0puQm1wcmxENXRmUWQrTWR6ZVMwV0dvZGtu?=
 =?utf-8?B?OCswaDRJYWh1cFQ0VWlWZXMydklyd05iQU8veXcvOUIwVWdTRGo2WFJLeW9v?=
 =?utf-8?B?cDNLYlh6UWorRFIzQkhSM3pud3p0RDlLWjNNYS84NThHVUFkazRiZWtIcUtH?=
 =?utf-8?B?YUw4Y1o5eXg2UVZoeW9DN2lsT1pwS2d6Uk9KempFMW92NWpkazg1WXQ5cHNL?=
 =?utf-8?B?c29MOHZtaEZQMXJxbHRlamZPQTdyZGVjMXdoaDB3OUFWN0FsWUNiTkRqVVht?=
 =?utf-8?B?L2JidnNDRGE2aHBwVjA3MElxL1JncHEwOUtDK1lOeHVqbDA4Tld5RVBvWFZK?=
 =?utf-8?B?NHppWHgxTlBJNUszVGZ3RVRyZWp2d3I0MU81UkU4YjZSL2c4Sm1Pdk91QTBD?=
 =?utf-8?B?RU1COXpNdDhUSFR1ZTd2U0lmNGhFN3VpRUZQKzBlekdmSGUrdHl0YlpvZVNr?=
 =?utf-8?B?NjF3T1o1SnpVdWp3UStQVFVJalNSU0NVa04xZ3dLZmh4aWE1azlDc1d4cnRE?=
 =?utf-8?Q?82PA+1DogUMkcgLKQWXrHhQu/?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619a4001-1c7c-454e-6046-08db8d21b1d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:13:26.0996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmJWz71GRljOHBdQuuSbHPkVcEUjgWhzdV5+GuBjls9jThqNtT6pgajNk1d37GeSq12vSV6EIR/anLaPp+OwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5959
Received-SPF: pass client-ip=2a01:111:f400:fe0e::70b;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/25/23 16:25, Vladimir Sementsov-Ogievskiy wrote:
> On 24.07.23 10:30, Evanzhang wrote:
>> block_stream will not actively flush l2_table_cache,when qemu
>> process exception exit,causing disk data loss
>>
>> Signed-off-by: Evanzhang <Evanzhang@archeros.com>
>> ---
>>   block/stream.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index e522bbd..a5e08da 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -207,6 +207,12 @@ static int coroutine_fn stream_run(Job *job, 
>> Error **errp)
>>           }
>>       }
>>   +    /*
>> +     * Complete stream_populate,force flush l2_table_cache,to
>> +     * avoid unexpected termination of process, l2_table loss
>> +     */
>> +    qcow2_cache_flush(bs, ((BDRVQcow2State 
>> *)bs->opaque)->l2_table_cache);
>> +
>>       /* Do not remove the backing file if an error was there but 
>> ignored. */
>>       return error;
>>   }
>
> Hi!
>
> I think, it's more correct just call bdrv_co_flush(bs), which should 
> do all the job. Also, stream_run() should fail if flush fails.
>
> Also, I remember I've done it for all (or at least several) blockjobs 
> generically, so that any blockjob must succesfully flush target to 
> report success.. But now I can find neither my patches nor the code :( 
> Den, Kevin, Hanna, don't you remember this topic?
>
This was a part of compressed write cache series, which was postponed.

https://lore.kernel.org/all/20210305173507.393137-1-vsementsov@virtuozzo.com/T/#m87315593ed5ab16e5d0e4e7a5ae6d776fbbaec77

We have it ported to 7.0 QEMU.

Not a problem to port to master and resend.
Will this make a sense?

Den

