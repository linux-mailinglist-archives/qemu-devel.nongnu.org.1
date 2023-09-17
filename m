Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B97A35A0
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 15:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhrTe-00047O-4J; Sun, 17 Sep 2023 09:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qhrTa-00046G-DE; Sun, 17 Sep 2023 09:06:14 -0400
Received: from mail-am6eur05on2070b.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::70b]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qhrTY-0008O5-3J; Sun, 17 Sep 2023 09:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnnTvsrWWCE3WcK4MYSBbgRCGXaE0ssDRihTYSGQrnHwTHmBFJuhg+VK2eFkSDbPSo4tahbcx8g09BTx9JnK/8P933Un7c+2VhCWPGmhFO0xh8R9XC1ywzv+CL3ybg5ZWlMPPx/3Vma39KHs640ejBnCZ8Nb+6/5FXWYXbnavyj6XqWEHFOMhpR+WvPlXYYt46jtIUDP5LbAYoKKFhjNDW635hhzR62awy7nbd6ZUpvLK6k5lkC6tzot+s4uNsjTdAbS/dW2xm3bDlsjLwGVw6xXLJeIkmO50tt1OGBdRsbkrckisMneijsvUdWOQadl7t0JsCOAAcyaE/sLMLwBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FTYJMLRnQAMi+KkhcOQbx0bTZHG0ArJGt7+tz6TD60=;
 b=QFfz1+PDPRBa0/T/mtTcgmmjipRquKZCPapcpTyONz5+6USurlc0qdAw8Xi5TsdIgwIBHLvo6GWMOr12kVUlS3OmbeqVW429V/QfKMmnBWOfb4aCMKGIzkMJfwTBmVc3LkTVou9GotyZFEj3LUKGSiLPmW34MGpp/b5spGmFkpuHd8XSEKuJlUu8P/zoZn0ewGHpSb3EXgpOk2xqGhdrWlRIN5Br7JOXrWBS10E4BurgWd0c1uVw/yZcekFi6xXVHEVGkW2cfQp2+lC/LRpV7qGV5P+Aj3yjY0TnxRZ+4Qe/Bl6mZ2I9XFoRz5JI6u0utYKIcLDhykvvAdCru7A9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FTYJMLRnQAMi+KkhcOQbx0bTZHG0ArJGt7+tz6TD60=;
 b=X7Dokbu+sqb5PBE3OSCVQFie/lzyPohHpXIXcWqpML2qT2wCJbRuMGn0Fvjdplr4LmwAio960X4pT8vduRKAUGLKSKVJ1FhqhqyvXupBogXXJwPiV1+C/tnqLveFrO5jBPIDlzmvwGNy5lRJ1LxGoEiRN/Bv3wdhU9IpFvHgXwR4ZRTEax90u3Bi6WGswelkhuDPuNCXMU4d92IlMp+caTkaSPZI/rOt4CAf1CujuBKfq9k3LayPkpnNmSr6VBPrUMr6+U44ctaap52B0qGxKYsdmRm1EsOR/1zxjtKw3P31I1/BIkeTTXifveM9fWUajECjKJtzeC0cZPoaVw/BJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB9PR08MB6700.eurprd08.prod.outlook.com (2603:10a6:10:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sun, 17 Sep
 2023 13:06:05 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.024; Sun, 17 Sep 2023
 13:06:05 +0000
Message-ID: <ed8bddaa-3f75-bb3c-e207-7219c6e39e90@virtuozzo.com>
Date: Sun, 17 Sep 2023 15:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/21] parallels: invent parallels_opts_prealloc() helper
 to parse prealloc opts
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>, "Denis V. Lunev"
 <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 alexander.ivanov@virtuozzo.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-5-den@openvz.org>
 <CAL77WPBGUyrLmYLeosKmcDTiifi0j77TqdSQoGrmnC2pPzaxuA@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAL77WPBGUyrLmYLeosKmcDTiifi0j77TqdSQoGrmnC2pPzaxuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0169.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::26) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB9PR08MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1eace0-a969-4883-ba78-08dbb77ed9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbR6+xMk5flsnwmVwrclq6am12youVUNcT0kO+PQJW09rjELzaVurYZRZ5T7WbXJnY+2cQaxH0+17hvDeC85Na90THXrJuRpuFSevhOalF0CuKpJbiSkB5+UdPxKSPDCepUdOYdWKjP3xXJOXOUcY7bEqR/OHGhrOJriBpVanq0OLrdYi624M4vNsSEgdeCv8iywKXfgSOJ4nVqsTM/f+wcdR63HIZPdy4OPROTI9nxzwcHcHVZXGcTclspbvByY4yz9F/3FUDl76L7Zc8sfq7OmjhyxCbgW8woOZlLDExM9V30hbgFyw9rxDnqQROqH+zYKHdGYvmubj0j2nITXMwxLAYSKwNxz+JDqQnNqTtvQLg+V9Z8xZjtuSYa1GH4ET1D648D9q6Ka5Aj5cqnaQfeABwV3FcB15bF4rIKVEMS1xUwb2zmJWscZW/RzCYXNOMkkdmj8fbEpOD8PhYGHm/pX8g2hRUknx88QbCzBEKZXpvPkiKgDLYCAmP2ofl7+DMtauMv3JZeGdnkyXb/mAW+bg8h3p9qlZdkONlO+div2RGfcdQdLfQP7P5u1OzTwWDKqyORhDazjBI9jJT7OBXKRzyOj2JyHJySkYSYYqTp+pJHRVDFN/qWJLxzS5bqsdEl8rsf5LJKQyfzxu3W9qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(39840400004)(366004)(186009)(1800799009)(451199024)(83380400001)(478600001)(38100700002)(31686004)(107886003)(6486002)(6506007)(26005)(86362001)(6512007)(66899024)(53546011)(6666004)(2616005)(31696002)(8676002)(5660300002)(4326008)(8936002)(66946007)(66556008)(66476007)(41300700001)(2906002)(36756003)(110136005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xiUFR5cXZHOUxUeTcwclRxVW9QOTBlZjBHSnhRelBDZjdqSDN6UjBDN0ph?=
 =?utf-8?B?WUlsb0xrNmo1YmxYMkNQZnFyeTJGSVh2cE03T0EyUjUvbzRWRnBZWFA4L0Fn?=
 =?utf-8?B?bTZ0dlB2MGdrUXVYeGRIWXFPbDBtMHdyM2V2S3drcW9VdXFIZDhrbE5UV1h5?=
 =?utf-8?B?dzlNcDlYTHNTQVBpSHI5bTNyY3NGS0p6V0RDWEIyODFIcmVsQjNtM041amp6?=
 =?utf-8?B?ckFmVkNSc29rODY4TVNweDAvdU0weGNpQ3l1VURsZzZUTmFJUmZZRUcrcEt1?=
 =?utf-8?B?YTJSVGpmSmdBZ21mY0RDcDZsRTlsbFQzVG1sNkt5aWxuSUJFS1ZobnFONC9i?=
 =?utf-8?B?TlZYc1JwZGFpb0xWS3p0ekhPUEVjUDZ0YVFkdEg3cFhQTWFvWFBuY3UvS3A5?=
 =?utf-8?B?YUZlSFRiVXFtRFU3Zm4rVS9HbmF5em1QRFVBa0ZnYlFla3o1U2JpS3BiMG1T?=
 =?utf-8?B?VjcvVkxKZ2M5Q2xnOFBHdVZjQUVwaTZhdjB5MCtpc1JzVFBDc1JOWlViek56?=
 =?utf-8?B?WUsvNHdmMlVtUmxDdEhNbFlTRk5VNFJMUnpZb2s4SE9pU2dkRHNkOXBuRGZF?=
 =?utf-8?B?RDlRYkhRUUI1TFBmb3VFVE1UeWFad21NRFNtc3N4aTVRVlF5b3k5QkdKNU01?=
 =?utf-8?B?c3B6dEdnblNVQjQ1M0xLNUFxWmVQTW8xaWRweXlveDdiYnFuUkR6TlUzMlF2?=
 =?utf-8?B?cXAxTkxsM0dFZ0FMVzJydnhNSjJFMDBMeEw5RE9kRXhJOG9aWVdEVzV5U1Ry?=
 =?utf-8?B?QWxWb0E2M054VVRlYmwyZEY3UFl6MUdmU3JOd3N4ZHhsZjN4WU54ZFNuS3BQ?=
 =?utf-8?B?NzB6YU1qdnJMaWdJb3FVS1YzMU5WU2pRZUFLQ3MzTllDb1FlbWoyN0haWklw?=
 =?utf-8?B?Vi9RVEFmeUVjZ3BtUlVnUjF5WUh6VVd3MlcyZXNocmVSNkwzdlovaGp2V3JR?=
 =?utf-8?B?MmdDRjB3eFlvVG5va2hPQ1ZBTXdiL1pZMUE1Nm1JOWxEYVFxQk43RjNOb2Ew?=
 =?utf-8?B?MTJyV0hqMXoxcE4wZWE4Q29HVGh1QkpEd0J5NU55N25aNFNHb3l1aHI2VjVO?=
 =?utf-8?B?dzdUa1FjTzF2QUZMTGpJaG1UWmxXTzN3S3l6TWtGaE53bnk5c3hseXRSQ1hn?=
 =?utf-8?B?L2N3dkZVNFRrZ0dHNVl3Mm9Vck8rcVNFSXV1SjJMZDQ5S0lvMGZibi9pL3Nu?=
 =?utf-8?B?UzVXVjRLbm1Wd0dZYytXOW05UGFYdFNRVGlsdnQ1MXpZN2dPVk56WUtVTElR?=
 =?utf-8?B?QXVoR1BEMENMdzZVUnkrT3kvRUpHUUdYM3JXMHFsOEtiZkZBVzZFRElZQmNQ?=
 =?utf-8?B?V2d2eVpndnJQRGVjYkE2RmEwcWZIVTRnc0kvUWlIdmRFQlA2RzBQRXY4YlNt?=
 =?utf-8?B?bWhuNWdiancwcy9objRlUnpSUmhaMlNhZExmMlJMSEV3V0RZcWY1ZWlWWGFh?=
 =?utf-8?B?alBKQnhlNFQrN3EzMEpDNnF1TWltNkMramJiWjAzeDhuUkZSQ291eklmdGNS?=
 =?utf-8?B?dk41czlTN0hxV3FFUXJhcEk1ODcwTCtHcll0V3lUYUtXZW56M3hVcGsxekpG?=
 =?utf-8?B?UnhPcWVZMURHWnFFZlc3YmNLNnF2Ymx6L2NLZGpnalVSdk4wMGtvQUxKTDc1?=
 =?utf-8?B?MFVXQlUrZFVWR0tHa053bGhZQy8ySGhPbEc0UGtRMEdqbnZrMElWaWR4emtv?=
 =?utf-8?B?dWNCTjlHMEM1TUFaOUJyTmJEMkRvMWpEQVBFTE5oRWFGazUxdm1GMG5PTnNx?=
 =?utf-8?B?b3NOendDMThCUWN4RlBHNnV6UE1LT0FjYVVSeUNrSFBlZFYzdWV6b3BrWHEx?=
 =?utf-8?B?U0p5ZjE4dEdwVmtKbWx5VnhKd0lJcmx1TWJkZk5WM3FmeVBVb2x2T3VwbWVJ?=
 =?utf-8?B?ZnBuenplSlIxZDJ3MnBuMi9QdSsvck9ua25FNVczSTJvSys1S0tZcWxKWDJS?=
 =?utf-8?B?blBZOFVHS001eVRzUnJRdUFmUnBBbWtMeTNwRkZHdGg5TnVHTFpUR25TOEdU?=
 =?utf-8?B?d3ozYUxRWGs4aGhRYTl2RTRvdVZ4SUY3MmU0VFVNRTU4L0haYTR4RDk1bTdj?=
 =?utf-8?B?OEI5VGZnVDlkd0EvVHdadmRDK3FxQkM4SXdJYnY4akxvWHJva3JUTEhSRWtC?=
 =?utf-8?Q?5167/T6tRzxZwvuTeKG/RIprw?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1eace0-a969-4883-ba78-08dbb77ed9e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2023 13:06:05.3126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeSDwy22V95I8tjyQ5UI0dQ4pUrDQBxZNWs17KgNvCQj2cgktrugoHlKbVuEMMqnKF4OryUDWMwboftYlwVcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6700
Received-SPF: pass client-ip=2a01:111:f400:7e1b::70b;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 9/17/23 13:40, Mike Maslenkin wrote:
> This is not introduced by this patch,
> but looks like qemu_opts_del(opts) missed.
nice spot!


> On Fri, Sep 15, 2023 at 9:41 PM Denis V. Lunev <den@openvz.org> wrote:
>> This patch creates above mentioned helper and moves its usage to the
>> beginning of parallels_open(). This simplifies parallels_open() a bit.
>>
>> The patch also ensures that we store prealloc_size on block driver state
>> always in sectors. This makes code cleaner and avoids wrong opinion at
>> the assignment that the value is in bytes.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 65 +++++++++++++++++++++++++++--------------------
>>   1 file changed, 38 insertions(+), 27 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 428f72de1c..1d5409f2ba 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1025,6 +1025,38 @@ static int parallels_update_header(BlockDriverState *bs)
>>       return bdrv_pwrite_sync(bs->file, 0, size, s->header, 0);
>>   }
>>
>> +
>> +static int parallels_opts_prealloc(BlockDriverState *bs, QDict *options,
>> +                                   Error **errp)
>> +{
>> +    char *buf;
>> +    int64_t bytes;
>> +    BDRVParallelsState *s = bs->opaque;
>> +    Error *local_err = NULL;
>> +    QemuOpts *opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
>> +    if (!opts) {
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    bytes = qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
>> +    s->prealloc_size = bytes >> BDRV_SECTOR_BITS;
> qemu_opt_get_size_del returns uint64_t, so what's a reason to declare
> "bytes" variable  as int64_t
> and then shift it to the right?  I see here it can not be negative,
> but it's a common to use signed values and not to add explicit check
> before shifting to right In this file
> I takes time to ensure that initial values are not negative.
>
> Regards,
> Mike.
>

apparently no specific reason. Just all variables here
dealing with offsets are int64_t. Will change.

Thanks,
     Den

