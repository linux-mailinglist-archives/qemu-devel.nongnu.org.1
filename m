Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D896F746F25
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGdcz-0000GF-Ho; Tue, 04 Jul 2023 06:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGdco-0000Ft-4V
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:51:15 -0400
Received: from mail-bn8nam04on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::60e]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qGdcm-0000Xa-2G
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FewzCtFmVwAyvWF2q4DPtnZTTrs3aZvvsC+Yrc+Znd4B7wm/+ILxlLLeLhj7BR+/msgh3UqMj3W8dLgA5SYUqcwRZ/NRewh0FKxzaAxdKAlUJeFYKZcL3Ihukl29smgz63ZlpTP8MG7ZuhsLiL5L5lVQLDtT5YHqlKDe2jnOLZUy9BxDjet92wKxlgVJrpoAxP4CWfX4sYb1YzwBGdz+/AkQHZ4EnnojF3TcUyGscFxj3fIjB2dd//sRD2kscj+UjrIJ1sRkPiM7TQokzXfNj5t+FmhnMHUbBO0YJTwgOpjtGhMRJYoioQnw6RiPsMb2Ed6wF9rHm8l+YY6wwukJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r9RuUq+vVbUoCkD2DObOS82j9qt/8s1RKTDyNawXbg=;
 b=eGFjOdQWRrJ8Myac5FNEgJVSgEPPfygtsoE7HZDrAwH3zW9kQOcTsXlM4ivotQue/Uik28nxtjIvi8GQQfxfOXsCdUSYuUccASRnjgYkSF2+1uG+oYcwqdyYh4/j2ZjJvJOzx/w1YyLFvtGsuLqjoeFZbZweTEYuyQLzCdUtfmawkQhXtGLizdICR2gJXHKfBl2gJp8ctPvzKJpy6w4nga/+a0KH6mfqY3fidywUxuFXTU/G7/UKX2JJly7r8riPKv5jZNQtra03Iu65cMPfpYPhQWAITqMbqWUvdQWv7TtoN65vMOTo2pHrkqQ+O+IgbHN2h78+qUdIsAr70Kmn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r9RuUq+vVbUoCkD2DObOS82j9qt/8s1RKTDyNawXbg=;
 b=pxCTIKjNiPduC3eujQ3e1gLYBm0BJhazB6xvIBTuZ18ltLaBdTUxlNx8aLRJeuVxyrfloDmjvRzHe3jmbmqfUVQ8ynKCo25Y7QEnnpU3VDPKtAAQbtmj0LokqLhymvyowce09vPmnNWRmhBj2hWpl5PpxkmzxgXygx8SLjbpw4PttfOVUHJkykViw8NX7cX9QOKR9q7RuOMhJIgiwnvdGY/OOgnRpDChTh1NsRYkt+GfbP3vBpiBXYRIzjUoRemGvY8YL9MKMIJiB7X7e9YTwrjBbP2AHsbkmKZovpq5H1dRLHubqc41dxupTdg+PqKkiy6Ll293L0dXIsFdRAHqEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 10:51:07 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::dbd4:621f:5387:9e2b%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:51:07 +0000
Message-ID: <e3c825f9-dbe1-01a3-a078-a18f6f9af18c@nvidia.com>
Date: Tue, 4 Jul 2023 13:51:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230703163953.18526-1-avihaih@nvidia.com>
 <7c4c2bc7-add6-6e45-c753-af163de3e216@linaro.org>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <7c4c2bc7-add6-6e45-c753-af163de3e216@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0220.eurprd08.prod.outlook.com
 (2603:10a6:802:15::29) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea2d9c8-080c-46b7-f3e4-08db7c7c9209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qBMo9J+uWv6APJtFoCI9QCdKw0p30xbkeA9rvjl+1X1hjQTIvjbb6h2DQbO/6qzCz0ys+zLwvUKOwyYcVDUerD+CjSJKuQ5cmySVn1Bp8xfN135ZFhvjS9Jl0FknBqi5OIsl24NTIq1ui5MF9vcjxFXGo/KVEpF/AONrOTBkBhWacO/ZYIUxp1YJdpM0y6k2tL+xmb3KESPf8+lE57ewBlyv65EeXf7jSz2M/WtnYzkaVF1nf9hhZV9g1Wzp+VOZJxLOApcCT7hyNxfRUuHkEpUWB6j3TAROmqeR5EkTFrBY5JvSwfDsLJEYvh97SuuLM4IeQckGkcMFFr2helD4uh8eHxxaXl1i40ysLY8G5XmUuSY/d570feQ4MUAjmvHYrIbX8siWezd2gZCblJ39A2V+snY44f3cDBs4IEk3kC+hWEkFRxwWgLDbaU/+B+01a6EZwuMxhWCov68Ijj9/CEqsQD8B/IHv/hWN4benXJ9TpUtJWAGrO4lLNjNw4ZzpjZx81x3OUYa9m855uWV6qaGOaa4WiLnONLo/gpmu8ODCQyI+UevVAEEjHM2fzidN/dd4h7dfqZbkXk027GNFmTS9pu9xhywJ8RkxU1Th/jm4xgex42KUgPTSqx9yJjuybwiwRdGjEdGK/BW7aJEZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(31696002)(41300700001)(86362001)(38100700002)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(53546011)(26005)(6512007)(54906003)(2906002)(478600001)(36756003)(316002)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(31686004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVjbUpWdFhmZmEzL2p5Uis5WUFHcWtQaFNsamRXcERabHEzQTZkc1EvT2p3?=
 =?utf-8?B?VkRKNjBPTGFiOU9oMEUxTi91M0ZUMmlWWkZ0WEMyeTJWc0hlT3BkL3BoL1VM?=
 =?utf-8?B?aEZCNk9xR20vQlRBbWp6T2FubysxUFpJRE1OczloZUxRRkprYmFCa0FsOHlL?=
 =?utf-8?B?RnVWS3h1cmVXMTRlb3NNbTB5aVlTbkFKVUlVZFlzTXp0Y2lBRE5QaXJuZ1lm?=
 =?utf-8?B?RU1vQ3lhd3orUEdyTkRDU3BMbzBKckxFODRIbit1YlBaRTVjVkdCaktNR2FJ?=
 =?utf-8?B?UE8rNnZIeFBZSEtpTUE0eHZiblV4c0ZlbTRtSWJPc1AwUlBUZDJCMFh5elpn?=
 =?utf-8?B?Z1dIM3BRUVdsb1NiTVdraFRuWEEzRDNhQ0UrdzhNakdPd3REckU1UTVjZm1F?=
 =?utf-8?B?NG5sM2JjUU9uelV1V05FQ1B1d3JoNnlvYXVhZzhBWEtYc3V4c3JGSFNBd3Q5?=
 =?utf-8?B?WG5pVmFxTFlhdEhQV2ZJcCtja2FRYlUzR2Qxd1I5aDBReVV2ZDltaW9hNi84?=
 =?utf-8?B?Z3NOSUFNNkhRZldVampod093emc5aW1jbURNT05zVkd2OHhaVXJPVW5SbURn?=
 =?utf-8?B?WXJ6TmlxUVpaWkt6QmFKMXpjOGZhTzZybW0zb2xzMHpsNTU1VGJJMG05bVls?=
 =?utf-8?B?endlb0FZNVM0V042Rktzb0YyZmJGNnZBQlRVZjVtb3M3TjRoTkJFQVZYME5Z?=
 =?utf-8?B?azVFd2tlMFpvTWxqNXgvNEVjMXk1bFhleXlEVHJ5d29ZUE0xR0pWMVU5aDNk?=
 =?utf-8?B?ZzlCcGpOdjVKZnVxb2Z3dFU2WXNSMENnanBHUjBxYTZ2Nmg2dDQvRVF0U2VJ?=
 =?utf-8?B?VU1GZkdvN1M5U05DbFFnZmMxcnM5TWNFbTg0RGRSMlJPSEJXd3NGaDV0Z3Jm?=
 =?utf-8?B?bjczbnJJV3o2cFZ6UWJrdm4vOGRQeGZUbXRmNWZsb3pRTGFVSCs5SWFraGN0?=
 =?utf-8?B?ZHYxaExJS0ZHUFYyNFBFTUdPK1MwRyt5cjluc0luZHNOM0FqQ1Vnc2VKK3RQ?=
 =?utf-8?B?dzVkTlhvZzVUWEdnaVJHdm1UbDJLa0htSTVHT1BpU1Y5OVNJRlNEbVpIL2dO?=
 =?utf-8?B?aW1YQzNyZGdEUkFHaUZJRnZpa1J1ZDFlOTZEU3JIWDgvNWxFTkJyQUZyVG5r?=
 =?utf-8?B?ZGZYdXB3UDV6MUFFUDZoamFCTnhuTkpuYVZuWE5kT1l5VGc1RnpqZnU0TVNR?=
 =?utf-8?B?TzVHMi9TbWU0cFppUytHbWR1K1d5L2xiRk42L2JhOGJuVkVTdG54R0o3NjBh?=
 =?utf-8?B?dUJCNTZzWC95eDhvcU5Ha1REbE81aE92MEt3U2tGOVpKWHdrMzhKSFlPWlUz?=
 =?utf-8?B?cXlDdHJRS2s3aHprOFRCL0YzbnpIZ2ZSM3hoUHBQTmhGNVJvMUhjMzQyVkNz?=
 =?utf-8?B?amR1alc2NDd5elovSVdoaTBWeDErNFhZVWxLeGRLZVdSckJud1FoUDZ6OWJm?=
 =?utf-8?B?WnV5d3JKUVduWkRMT0k0WE1IY3o5RVRobUcrN20wZENKWXNkTmsyZHByZlJZ?=
 =?utf-8?B?WU9GSWdOdUVDRERrNFV2c002ODVKMUpPblp2cTFMWHpqRlkyc2lZczluV3Iv?=
 =?utf-8?B?RjNPNjVYWi9jMHpjdVdaN0xTRERuTWd1Sld2QWFEeHRzRWRMYVVaZUpYU0o5?=
 =?utf-8?B?NmFUVXFjdS9JNFVhUU9teEZadXZTZEROU1FSOTlFamN1SUg2K2gvbENjVytV?=
 =?utf-8?B?YmxHVElaeWZmRzg1cFVhTWVZWVdyc2t0QlBqRG5abzNSVGNzWlNEYnRXVXo5?=
 =?utf-8?B?ZXArclM1NEdSL3hEZ2xLeUtKK0pxNmgwS2dPTEhmalkxVGlVZ29maW5pZzBj?=
 =?utf-8?B?ditTaDJVSVJsdHVwSmx6MU1qMTVRTmptWnIwTUF2dTdreW1sQ0J6eVB3bXVN?=
 =?utf-8?B?MERXM0FpdkE0QjlMaVMybzExenlvcjdJVFNpYzYvWUxVeWt0WTB2eC9OTG1r?=
 =?utf-8?B?V3NudDFzNkF1N0RGK0ExeWU2cFdQSU12UzAxL3lGc205WDBSd20ycUFNMTcy?=
 =?utf-8?B?R2lweU1laXU3dnJLTm5zMzhXS1ZzKzhyQ0Fyd2tINmRsSEdBeEJmOE0zOFV2?=
 =?utf-8?B?RVlsVFVaWFhXeGQvZ01kSWZZS1pUNDNKcW5PL3BSeGY1RlVCK3YwbDBEaG15?=
 =?utf-8?Q?7v4EiVxBbqCc/QySVa1GmyweL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2d9c8-080c-46b7-f3e4-08db7c7c9209
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:51:07.6205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IYwIDcwfEgthGq8K0ZG9UJbO0nibrMgIXhtctWdqVwZrDXIbFQF88PXeyzJUFKw0wTUYFUUHIgGDFAZ0d2N6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::60e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 03/07/2023 19:56, Philippe Mathieu-Daudé wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/7/23 18:39, Avihai Horon wrote:
>> vfio_realize() has the following flow:
>> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
>> 2. msix_early_setup().
>> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
>>
>> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
>> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
>> allocated.
>>
>> In this case, vfio_bars_finalize() is called as part of the error flow
>> to free the bars' resources. However, vfio_bars_finalize() calls
>> object_unparent() for VFIOBAR->mr unconditionally and thus we get a null
>> pointer dereference.
>>
>> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
>>
>> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ab6645ba60..95e077082b 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1752,7 +1752,7 @@ static void vfio_bars_finalize(VFIOPCIDevice 
>> *vdev)
>>
>>           vfio_bar_quirk_finalize(vdev, i);
>>           vfio_region_finalize(&bar->region);
>> -        if (bar->size) {
>> +        if (bar->size && bar->mr) {
>>               object_unparent(OBJECT(bar->mr));
>>               g_free(bar->mr);
>>           }
>
> What about:
>
>             if (bar->mr) {
>                 assert(bar->size);
>                 object_unparent(OBJECT(bar->mr));
>                 g_free(bar->mr);
>                 bar->mr = NULL;
>             }
>
> ?

Nice touch, it's indeed more accurate.

Will change and post v2.

Thanks!


