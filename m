Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9D57293ED
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Xtg-00034p-TH; Fri, 09 Jun 2023 04:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q7XtZ-00033w-4w; Fri, 09 Jun 2023 04:54:57 -0400
Received: from mail-he1eur04on0712.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::712]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1q7XtT-0006Wg-7o; Fri, 09 Jun 2023 04:54:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HximiPIahi+v3WnzR6eM+1ZbeTbAOigl6oFoh1ENoXIT7aZYbmKgb6h5OUOkuUrjaHfYkX8ZT3gU8MtkuPPjhzXui7KVm9cbGOcRwGgd6bkNlX4lu+eARKf8JhLG4e+nww8PaOLXq+iwhjd2tOZRHLscz+Xtbji8AP4a6AhMXmTV3mIyz2oBde1FmiHvuH1sLOdxyO50ZGKAWex4bkdolKYwvzgt0mbjIoS5oUVI1bhH6ZErPKWiaB1RTrAlmvbA4x7Kb5+51/TTNHNA8bvfqP/wRVAAikQ2R1w3UHfHPZld3pBLl29D/BbbHgZCg0M8qr5hYB0R/4xk4/MwQarHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmNas5Hg4OvFodMPi/LlZG8ehP6x3YhN4crUIN/Cs6E=;
 b=Y2/cxK+lPoDx6nwmHkPWSEdXevZcHoLsp+nd+0JKgxvRSgWLLv/LdF4eWLtEzD9IsVCWTEsfBcyyJFIQfuOLBEJBeXLmT+uWkIYbpTseokEwKJnmflWRgqtdPz4oGmY27ajqtp1J+7JMe+ZYE+2TtqhL7cRhERoiaB1KyPICWDdaEGCIET98j07DBMv/rmk8mg9PSNJRMfQPcXWeHU3pVEgLUPtVEzzEBp2CcrN4SMMODYpf5tJXzYhkiJ1Su6RW6UudfNgernt8nW5lQqeelCwd0qhc/LGHxpq7WonUOC7L7OrCGD9N+MnCUTD/GzuzovZYD4trUgHJCbDyAV6gIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmNas5Hg4OvFodMPi/LlZG8ehP6x3YhN4crUIN/Cs6E=;
 b=SDljVNeXvEyM1ZKyVZx6YTKw4/eog1ASEp7vr0TXNBhn/GHFbuZBTyeAIHECviv+f0G8PshbvF0ycGMo1RieHEuZh5mLBCk5NrzPde0yYmV+dSt7UcPHniQcBXIhJPJG91eDUuAu5djLuO51qOfiMwsobUJM4poEvGzy6G5UyyEN7j2+NjoLRTt1Ao5VnzVO62wNud5QUsoKSsbnJFa0U2fMhQC5bmnX01ShWUS3GOaKVOasOPWEfE5CLR9gPkyu+nmXPS+8Z6EGNQ82sMfrpvo9QxPEeYwM8V6/WWyIqtV8/5FRYX73e1tpF+azXIyVgpVmwb51jqeXp9XeIz8Uqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GV2PR08MB9925.eurprd08.prod.outlook.com (2603:10a6:150:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 08:54:43 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::b50f:b94:a801:adaa%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 08:54:43 +0000
Message-ID: <6e75f538-443a-46bd-1471-1cf182c345f6@virtuozzo.com>
Date: Fri, 9 Jun 2023 10:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 05/17] parallels: Out of image offset in BAT leads to image
 inflation
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-6-hreitz@redhat.com>
 <a6dca05c-aebf-fe39-6cfa-cd626475865e@tls.msk.ru>
 <fcd7669d-92ec-fd24-1485-e746c2e358c7@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <fcd7669d-92ec-fd24-1485-e746c2e358c7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0601CA0020.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::30) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GV2PR08MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cf37ed-851c-46f4-08a6-08db68c72aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2zzIK9+S10Ri9bJS2YzEn3kW9rBrlQqbSJHN78JFyM2+tY6UK7E1T43RXJYo84rBzaSi/a6Kjprn4kZCHoH3BoO0q1PeopO8PLXFRldWwbrN8IAh8mOK++Lg6cDbPT+VtViP9WFD4Q9nUvW6lMdyxj0C/OOR9lMF9IuCiunBhi4mbaM/IGa7W5VPbjDZFKdp7iLELIku8q/8EUgjs3FRB7ZedhCol0fmPNZbvuGA8W0zsNN/GUKeG6qqLC27Y3pe/iLK2lUyc1E/eeLDz3yYSEUkP4iboWH+3wYPSNCEkg69JodaVBAT5GhBFWreXNK2CPGDYzlN6QX2M4SdBHJ6fjE8FVJJQSvTbANejGjgcboPntt7eQkIFUBJ+fuUhThypG+h5cHzMRxOGiH/ktIJwV2jlOVc/kL03PS+XA+hk3FONs2+Zj8R4FrAzBkX4d12hNQ5tsLNkF3NktOcugztArUj6EoeGM4fKxMesmEgg99tmXrj0bus38PMGg5hW+p9eThsgtzJmWqVV/lIROkmduyeIgY1YDrlEmnwqmmaLFp2QCuusjSuBvt9sXO7UVzcQEmiaFUKjGJZjWAxGf1C/7tZd/WIc0ulbI1c/6Ur4kjirWDNK9hmRtfgSm/ooPLye0wu51E+MInYBnjklSE8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39850400004)(451199021)(83380400001)(186003)(2616005)(2906002)(31696002)(36756003)(38100700002)(41300700001)(6486002)(316002)(6506007)(5660300002)(110136005)(86362001)(8676002)(8936002)(54906003)(478600001)(66556008)(66476007)(66946007)(6636002)(31686004)(4326008)(53546011)(6512007)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlWMHpCNytuK2dZUkhWUktBbitiMlpaVldxVjc3TzBvRGRhTEcyQkR1N2lK?=
 =?utf-8?B?SXhxL0oyRGlSTGlkMUpRbllUSGQrbnk2UHYvM0VrczcrQVVUQ3VPMzhtdEJL?=
 =?utf-8?B?Z2lJU2l5ZzJUQzN3bEp1YnR5OWdoY09KTVcrd0xMWTNRUzFVTEVHTmwyTEJZ?=
 =?utf-8?B?VUE3Z094TE1iY2pTL3Q0aU5zRzl0dVVYcGh4YzNrTVNiam51L25VeDlNMklI?=
 =?utf-8?B?UjY2YlBEQkdTRWxDZTBtdzZvMFZpV1RIdGtSekxuS21LczNacWVpNzAxVXV2?=
 =?utf-8?B?V1Bkdno0SFBxeDFPT0dvdzhzdnQzWVhVNW9HWHdnU0hQVDFIWVR6WDF0MWxL?=
 =?utf-8?B?S2VDaXBQMVRZQ0VHM3lrcnFYSjYzMDE3LzZablBjNEhPSnpsWUU0K1NQVThz?=
 =?utf-8?B?cFR2MXVTMVk1MEhlaXhoT0k2UXcvV0NWSDIreHIwWGFPWXFuQ2kvWGpITTNn?=
 =?utf-8?B?M3RvbG4rc2tZSHpJTG1Zb0ovN1NCbG1rclhJQ2lrV3p0bzIwNHVZM1pVZDdm?=
 =?utf-8?B?OE9pWlFYb3pCTWd2NjVFUUU2djBidGYrekZKMW1DalRiRTlFaG92QTF0Ti8z?=
 =?utf-8?B?ZzBVMXBlOXFwTW04dVY0ZGtqUjh2RUk2dnNCOWlaUTNvWUJXYUpnZVFETUs0?=
 =?utf-8?B?TFZPbC9nRkRvOVdNTy9IaEJUOFNYVUdIbENWMVpNUTgya1hjNDQvQmFVMUJV?=
 =?utf-8?B?NEdaN2wwa1RLS05Id0tlR0syN0YzOWRBUjRWTFlUMHlBNDRMeFpjd0J0dDFE?=
 =?utf-8?B?V2Y1dUtmeUt1WXpnOEVqLzljeUdZVmtVMVF4VzRqK3FoajEzSjRkVXhlMSsx?=
 =?utf-8?B?Tkl0cUJRNFlLVTVuZ0VuS0ZTWXMrWGlEcTRiZHkvVG9WdWhxTmpyNlhkdjhr?=
 =?utf-8?B?c3pEdmhSQnNERVk3VmhENDJXYzFOUWFuaFBhY2xTUlh0cGgvekdaenNqQkhY?=
 =?utf-8?B?Mk4wUU01cUlnRDlwbWNPdEJVWkhMNDBjY1FxZ3ZWYmlWakZNSWttZHJlYlJu?=
 =?utf-8?B?a3Y5S09Xdnc4YlpvQUJmNFZ4aTBRdGQvdWdONFcxVEEzQm90eWJ6S0FaU1Fk?=
 =?utf-8?B?ZVAzKy84WDN0emFxV3lFOHZCVk9RWkNvSHRnZzZRVkpSSGdoSjN0azlqZ0Jw?=
 =?utf-8?B?cjVyZ2FmRk41WUlPWHBQaDQ4SjBZMXhITDRQNGFpenlBdTdiQ0N2U3dVc1Fr?=
 =?utf-8?B?TnpaUXdBUXBpN1hjRmtCMEIxZ2dLMkRhZWg4T090S0J4c2U4bzVCNEthWG9r?=
 =?utf-8?B?azlrbVdwRGVOMjc3a1U2QzBOODlkZC80a1ViQldNaTZ3M01XZU1DRWxOc1NM?=
 =?utf-8?B?OW12MEljVXEycmZSZVJoL25TZEsxYWlxRWFvVWlza3o3cXlqSFVvYWtRZ29t?=
 =?utf-8?B?TDNhZXlDeDhQdDdEaVIxWDJlaFluVnlHM1AyWGpiWnNSbTNBajVGajFSbnpu?=
 =?utf-8?B?NHRac0tUdHhwRnVlZ1U4bWw5MmhNcTVIVmxUK3NNOFU3S2U4R0ZHV1lQTHhN?=
 =?utf-8?B?bDJJcDBYOTR0NUdFalRyZGZYbnJpTzZPMzVnaGZ1eDVCSllsZ09GcldaVTV3?=
 =?utf-8?B?ZkFub0tLRVhNeVo4QW12SWd5dUNMa0RYczM0b1dDTW9lV0dQczZGZnRRdmRJ?=
 =?utf-8?B?czkxUHF4Q3kzUTgyUXJLUC9pcE84bkkwLzJnOUFVUlJ4SWJLMnZlNWlVU2JK?=
 =?utf-8?B?M3prdFNSdktCSjZRUEs4d1JzaU5FaHlxVzRHd0VYRW03bHJ3UVNTcjR6dGx0?=
 =?utf-8?B?MWJVd3FsUUd1Y3JKWEJZeG8zSkkzaXowSUdmTEdLaFRPa1dIMnRJak5vRGJo?=
 =?utf-8?B?ajZ3UXZNR2l4dmVzYk02L0JqN3NpM1BoNlpHR0I0TVNaVmxxVW96NS9KUHVu?=
 =?utf-8?B?dm8vaDVGVDhXV1hudFQ5eE5WTllOVEIycUR2UlVxcnJFZHpnRVQ2V1FreHJu?=
 =?utf-8?B?dUFKSkxPZENEWGdoQVJRY0Vzd0k4RUN6cHJ6d05PczVtVzhJeVI3Z3ZkNmJW?=
 =?utf-8?B?d2dvb1RWNjhjSWxkcVVNSHE5eGVzL1FNRU1hYThYUUhLU2ZXWlRHdzUxcHRT?=
 =?utf-8?B?ajNtNWJHdWZZRUpkbFJnZGg0bWc1eUlGVEs4dEdJUTF6akFhVGJJMXoycnhS?=
 =?utf-8?Q?KTijV3f5/D85Eq48u5uK49cr3?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cf37ed-851c-46f4-08a6-08db68c72aec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 08:54:43.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sCyJsuWBjv1aoIa55noGWaQYtunsjk17p4G8iif480qp94ndTDkiw2V12hWommzu8VdLxQFY9RqNt8vdgGVjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9925
Received-SPF: pass client-ip=2a01:111:f400:fe0d::712;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 6/7/23 17:14, Hanna Czenczek wrote:
> On 07.06.23 08:51, Michael Tokarev wrote:
>> 05.06.2023 18:45, Hanna Czenczek wrote:
>>> From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>>
>>> data_end field in BDRVParallelsState is set to the biggest offset 
>>> present
>>> in BAT. If this offset is outside of the image, any further write will
>>> create the cluster at this offset and/or the image will be truncated to
>>> this offset on close. This is definitely not correct.
>>>
>>> Raise an error in parallels_open() if data_end points outside the image
>>> and it is not a check (let the check to repaire the image). Set 
>>> data_end
>>> to the end of the cluster with the last correct offset.
>>
>> Hi!
>>
>> This, and a few other parallels changes in this series:
>>
>>  parallels: Out of image offset in BAT leads to image inflation
>>  parallels: Fix high_off calculation in parallels_co_check()
>>  parallels: Fix image_end_offset and data_end after out-of-image check
>>  parallels: Fix statistics calculation (?)
>>
>> Should these be applied to -stable too, or is it not important?
>
> Personally, I don’t think they need to be in stable; but I’ll leave 
> the final judgment to Alexander.
>
> Hanna
>
>
I do not think that this needs to go to stable too.

Thanks you in advance,
     Den

