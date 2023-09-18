Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A197A4457
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9RS-0007h1-PO; Mon, 18 Sep 2023 04:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9RP-0007aY-Ud
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:17:11 -0400
Received: from mail-vi1eur05on20726.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::726]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9RL-0001Y1-EI
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQZbEQiJZ8pxuIr2jGKO1lJS6NwjOEmriK3XVD0VOtLbXvjkwShQD9s0hAguEyzeeTcjSKMi8w3ZldmLX/c7vGCDf+2+KdetO7oz1KOXpT7YPeM8BD/qipyJT4AnRLBp9N59dJotnxVEATGtnHiK/omVeHc80ySi6nlwKikn5NhhXLwRE99Fgqx8Uu8+J6f1Ari5Ca5rYIPvGDVb3WM45uFaKpOOzfIQRIpSN9FeN8YLFjqLZ5sb+7AL+ICWmUsgFj0G+ruSdC6REUvg+xmSULia/2YNis0x1nxG4J8bdl/qpm3u76wkuIJwQc0txn9qZcZga0Onz5b6fWvD2AJFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl6Ix90MPJztq2cl6nOWCdtEagULnhjS73ldzByP7YA=;
 b=daVXQtHyKYaNE7j9BIEwVAqOJElm/CgcdB8NXYdVVgwxACWqxptNCJezvJbqBQ/WiHaV9sK62jS4/wM70RuMtAR71if7vug1+hL4Z/prlbc/T3fCHGWweyR6x4TgBCrn79p8SLqZ4a0a8i8EHqZnnXG/qG8Gf7B7vR4gCRLaOfMo4zcNtypwUqfORmvzwhFlQHtVTh818C9lwjL6BorYghtfkMvJa3CZBYuMAtZi/ULOei5n08Bm9ZLA3uMu4kLPFO3F6rH3MrsRWgqejgFlvVQ54T2LWbGZpGpdref6yxJuHQeYaXbAnBep7G5orM1EjpyRfLQodiYkg455b8pc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl6Ix90MPJztq2cl6nOWCdtEagULnhjS73ldzByP7YA=;
 b=wpZ3FHuk89FQ6SNhWgRZTzUjtPwmIslTQOjfspW+4dcuEo/83Rqz5oJiQ2aOlYliHGxN0yFEcQrEFQxuELlnquV2n+u3dfpeeCAeQ4GDHbnU4+1Jg+fPyUE8MNFNhgka+PmRxzpowPaVQGuGYXppthrO7ToHej6pGlKhNOEWy4biQQ1eLVBnBULNU6X9LniClaLw4G6ajD3HcRreMOHl7600TO52WqnyQuRlX0hw/Yyw/Qj6pfT0QgfizkQAdwJhdW8l05RqK05DPSFSTYc/MUy5iAcd1rnyrnY1/YqUkKZLgU8YJZm+pPtPCHypHmtLGuxV4FzymEPS1IzUoxJzmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB10179.eurprd08.prod.outlook.com (2603:10a6:20b:62e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:17:04 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:17:04 +0000
Message-ID: <16b4ef5c-7d09-66b8-27f5-6b340aada822@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/21] parallels: return earler in fail_format branch in
 parallels_open()
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-6-den@openvz.org>
 <6e54ed39-bc33-887e-9585-d7fe04a1bbf2@virtuozzo.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <6e54ed39-bc33-887e-9585-d7fe04a1bbf2@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::22) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bf6fd3-e7db-424c-a014-08dbb81fa47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXxa84OMcQ/cnZpXX1l3bVovkrPRvru6ngxDl0YpQ+KaM5oifhd8DA2xi8tXF04Kqe6Wjljdi+gg9y1RrjobMsS2nEQciyGOkP7VdwMicejBK2Lcl/7waSszMFQF5iPM9fXeZgT66qcIM0DqJ72JpFZxUQ2y+2kpyrVmdI+ykp31F9aQIxBV9KOWiSjwDDiT/N2s6Bwvj7UvUjeGwwQFAakOwG+CbLDV+4dbIfciMRiv69aKoPkqRVX/1y55mkWPzy8GIGWeDzF68lr3THC60QNp0zU3qsDf/0uQ3QNYkU87z9g0HQ9j1lUFRj4vMhP1mHdaIAX768/NUdQWLvOrX12PiqtcnV99Xi1/Zu1Lj6qwCBLxpOtZ1a87L9XDElwTGSnpziZbBRRKqm8uvIou89mVxbS9Oi1n3zY436sEcg7ZNuT9/gtL9n6CaKV8I/tJtfAlDpEOktksZ9v0zmZLSPwm0EmVOJn8HJcClAiPkT+21inW+ZW3oj3YXNrGxT56zHRunVq6wtNc4+SaMp/DlJdB3KEuic3Z5nXnkvEsTkpHyBRRKZh5jTAaiMkeWc0PVMtj8+tbfWS4ZunvBD0i6EgDW+V8dVLDKKaB710nrnqZTQY5MVgwBJPxPvo0aLCCVM0dlGqK3lZvntxRKZuEBjq3DgFqoqJ+ItUYBngZo0RM62ilivFzVWquEknwwBCq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39850400004)(346002)(376002)(1800799009)(186009)(451199024)(53546011)(52116002)(6666004)(6486002)(6506007)(6512007)(83380400001)(478600001)(26005)(2616005)(2906002)(44832011)(66476007)(66556008)(66946007)(316002)(6916009)(8676002)(5660300002)(8936002)(41300700001)(38350700002)(31696002)(86362001)(36756003)(38100700002)(31686004)(66899024)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3RBYldyVFM0bG5BZDkzSHMvZFJ0cFBsNC9HK1RzWnpKcy9CekpaNWNUYWNS?=
 =?utf-8?B?eTFxUzM0RVcxWVgzZ3p4NnlNR1FGRFhzQ2lPTklYeGZzdWtrUEltSTFuYkQw?=
 =?utf-8?B?ZW1FTzdhNHN5QXFodTk3T3R0WVFkVHByaGhRWVZCNDZaK0NqRC9sL1ZYVW5K?=
 =?utf-8?B?QUJKM0JQcWVudnM2SHdPYk5EL3BON0k0UE0vQ0VPUk1yNEhwa2J3NnVLcFdI?=
 =?utf-8?B?ZGh6YjhGM3VuSUcxMlFGTHV2NGpFOGtBVGNSOUkwWnN3UXdXdnE2eU1rbnZl?=
 =?utf-8?B?em5PeTJKMjFqMGdxYzNMdndVc0xEbjZEZzZBSVpkVlkva0VReXRPdGxoVWJ6?=
 =?utf-8?B?c0pCU1hWb2IwdEtLZWdJbG5va1k1MlozU0ZyWUJFamNUNFB6WmlkbC83VDlL?=
 =?utf-8?B?azBDYjYySFBuTjFSVXNUckZIaGhUREJDTy9NeEhLc3R0SGhwT2lnOVZkVFBR?=
 =?utf-8?B?cEROSjFWajY2VlZjaHJQcGIvS3RKb0Z3RlNRckRBU0x5SXVDYVQwQzZDdlNQ?=
 =?utf-8?B?VUVETnJRUnl5Y3lYL1Jxc0hpV0N2YkpwdlN1aEdnb0JrMmxvTW81TUJ3VDFw?=
 =?utf-8?B?QjJYc0RmTGxCU0hVVExCNDREWW13RGYrVkJpQmc5UFBNR1Q5ak5mTjNsMDNQ?=
 =?utf-8?B?ck1NR0t3d3o5V3BjYWtibE9ncTRhekVpWkd6MzRheUJUWmlJaXVJNW1HbjlU?=
 =?utf-8?B?MTh4aDRFOVllV1A4ZTM0aU9yZXFHbHpTekx3TjF3UWMzYisrU2NVeFZ1RkxU?=
 =?utf-8?B?OTZoRVF2cmdhanA2M2ZrQnVKOTIzdDFLSDZqVTFMeDhCYWtmTGVZSzVYc3Rj?=
 =?utf-8?B?alNxOGIwMG9rUVpsSzE1eWhpVTVSeS9nS3Z4RjNveWJHbHZRdlBNeEZqWVI3?=
 =?utf-8?B?bWV2Tk1PRXh5Sk9NNjNNbDVpKzAxc2ZHb1Fnb05FelpRbEFnUlpqRGVVMzla?=
 =?utf-8?B?K3kxZWRxamtGM1l6N1oxSVVvMzFLQjArV2poblVNSS9XK0htZ2RsMWlNMmtZ?=
 =?utf-8?B?OUtpeTg4anZMbSsxbyt2S1Z3OUhkaEI5TzNrRlQxT05NcFlNUE9GWXZDNWtW?=
 =?utf-8?B?WmZzQVpvRVJKUGlweUNiTTVGZ0ZxVGhRQXpTYkJUYjZRQlZlM0lhR3dKS0Fm?=
 =?utf-8?B?QWdpRm1EUld3a28rVnF3Q2Fham5DYnJnemtFOXp4RXhUbVdJMnNpMm96QW5W?=
 =?utf-8?B?ZFhsNHJleTRxVmlOSFdpWlE2a21IalFId2xoQ0grRDNZV1BOVGxiRGdOSk5y?=
 =?utf-8?B?V1JXQ1c5V0FFYUUvdyszN2FYU2JQUmJ1OG9KTGQxSUxzRXJKTE1VUkc2bzk3?=
 =?utf-8?B?a2F4UGZYVDVUUHV0S09jWjh1SWoxUmUreUp2SXI0bDB1RjI4V3BoWXNUSk1W?=
 =?utf-8?B?R2VMZ2NSaHpnNjRhb1NLd3RxUFhZQ1hhK1NPUTdmRXE5MkovcXNIOWhhM2VB?=
 =?utf-8?B?dUFjR1ByUVFIcTFiRy81TGpYVFZROThObXpCQVNUTDJsVHU5a3EyQld3UzJB?=
 =?utf-8?B?TktRSUxxOS9IcWJ6QjRwRm1obGJxM0d6cHZJbzN1R1hXZmUzOUIxTHU3S2h5?=
 =?utf-8?B?aU01M0Vad0N0OUtCT2c4eEhkVW5paHBCbkMvRzhpM1VkR3ZudlZwRHo5SDk1?=
 =?utf-8?B?NUpDK0p6YnJkdXFnM25QL3VZYUtZc2JmSFJheXBwS3RHeUdCVnpIb2VOa2Jv?=
 =?utf-8?B?d1ZSVTVISHoxWnJIeFdWVnQrYUJ5cUhzMmMvT1J0dDJ5SGtVYW1nVVYyUEph?=
 =?utf-8?B?NFpCbnNwUVZGY1U2TnNuaUwvc0JrWUU0UUpYcmFKR283a3JhTjNiNUdRSnNL?=
 =?utf-8?B?SWtvQ3dqdjhZQXY3djh0cGRRbkpXeXptZVZHdTAyclRXaVlRSW1URitnSGZP?=
 =?utf-8?B?Q3ludDBZOVNrYnFtbXRnaStxQXN0a281Qmp4NkNSeTVvekRvZUZxYnJWNkpx?=
 =?utf-8?B?UlpvTnZyYXRIQ2ZMWVVJRUl5Z1N0K2VWSnhmNjNVeW5HQzJ5cEZyM1E0VUdT?=
 =?utf-8?B?ZHpac2JEWHVSZWc5T3pWVlNnR1h1WGc3eGVHUDA1SXI0bk1Ecy9SQUVJNEgw?=
 =?utf-8?B?OE1yZ2xLb0xBNEdZaXdqNXg3RUU0MzMrdE1RQS9oZkxrR050UnJqWCt2Wmcz?=
 =?utf-8?B?T2JKOGI2bURadWo4RDlTRGY0M2hpYlBTRnVlY3M0ZDB4WGRvRVN2STZuT1lh?=
 =?utf-8?Q?pzxBItuRmTtbiLS6wsU2QYA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bf6fd3-e7db-424c-a014-08dbb81fa47a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:17:04.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdImvXPHV7kRG4FAGT8bMywkOoppWqyN8/n9JWeFvb4OxllZYls1mqxakLgXWixIcGs5/pAVv8Y5nqRvE3xgUC2zdDlk/WONQ3CITOC9K/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10179
Received-SPF: pass client-ip=2a01:111:f400:7d00::726;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Oh, sorry, I see it in the next patch. =)

On 9/18/23 10:14, Alexander Ivanov wrote:
> This is not the case with this patch, but it seems that the 5 first 
> "goto fail;" could be
> replaced by returns. The first allocation, freeing at the "fail" 
> label, is at 1127 line.
> The next error handling and all the previous ones can make return 
> instead goto fail.
>
> On 9/15/23 20:41, Denis V. Lunev wrote:
>> We do not need to perform any deallocation/cleanup if wrong format is
>> detected.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>>   block/parallels.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 1d5409f2ba..0f127427bf 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -1226,7 +1226,8 @@ static int parallels_open(BlockDriverState *bs, 
>> QDict *options, int flags,
>>     fail_format:
>>       error_setg(errp, "Image not in Parallels format");
>> -    ret = -EINVAL;
>> +    return -EINVAL;
>> +
>>   fail:
>>       /*
>>        * "s" object was allocated by g_malloc0 so we can safely
>

-- 
Best regards,
Alexander Ivanov


