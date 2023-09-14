Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC497A083D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnmx-0002Hc-VD; Thu, 14 Sep 2023 10:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qgnmv-00023k-T7; Thu, 14 Sep 2023 10:57:50 -0400
Received: from mail-vi1eur04on0722.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::722]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qgnmt-0004VM-V7; Thu, 14 Sep 2023 10:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1n+q9zBMIuj7WH18u5txuo8lOcOnCO8JXl7z4e9ET1gfeURx34ZxSfTOVEa2bRG+06kR6RgKGGJkn/F94OUlCEy2YIFd6aGnGw7yoKX5xfBFXJzo6EfUrDtiWaNyjCwDrwuoafaBFb0pSyokIWZoIit0TR/yFMqtnM1O/zWWQE8yfCw9prM9ftgiV8SlPu1wRhOJFAt//k7vIxxVdBD1/dcf4pwP3xG602RH+2xjRj1WsxaiPORnCbMobQALyGFYGwpNEDVKsWcF+fOKfav6N10jKFUqK4Tav2Io18tOHO+tRa6sYOfdsRsI4AadG3uvRxhdrBGzYRQFKTs3iltxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTRWTG1jJiZkIZJI8ZlIGDoPExKVrbYIPQux5aRH12k=;
 b=FfhzO2xQedJqavLuFPmPFSkcPFDUfJ+Nea70Xnit0nHnxUhcBgcC204vVkh9QnNb+YbEX+YtAKR/l/X2b/l/5qoJQuV1HIpkLkNBdg4MTwJHqjCmZv+tSim5d8ljQcYtOVsUj7Pc55cdZN3GU5wuXVLOmz03JytHr4VLklqeKkSlDT+skRQaj1bo2HqPwVu79zntZ5JxJQaMwYDDHFuWBqkQuOt90nP/qlvxMwF1svSWm1zhVjKJH+PsSO2guWoQCVtx1Zt/qDaIhcMqUQsvGtlDi509fDVYkrBOf4ghV5e7Zds17AAdSqqm2849N6G+nf/rvo4ULTtW9U0njkzA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTRWTG1jJiZkIZJI8ZlIGDoPExKVrbYIPQux5aRH12k=;
 b=p6fHR7KqU+YsTKpBV47x1r0yYpgHEHX1+pjlu6dWI5c9Yq/XTw7RoqbWGHtQt2SnmDU92Qvdyqa2NyO54+XvwAViFOsNbHoE3Ho8asu55kLyHy2w0iC9s1g7UKJXw7WKOxCcmOO19RixM/JJ7/p9w1lCQAfEgrt/JuazyNWtCUv9BSfCdVGGQsz/0Vty0irXgBa/MXJTDK9UMZ8Jx8lc1uHWJ5rcwFOwduWCtZ8z0fBKwK5Et7/WoxZvokLGX69smf+nLdLbTTvATYrhS7xUoFO0nQvp2KeWZsbLX+IkXsoVOLWZQ+MsBwYoSZS1stQmWISlkkZ5Z4+eAF/ABr0SRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU0PR08MB7882.eurprd08.prod.outlook.com (2603:10a6:10:3b2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:57:42 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::8ba1:5878:7574:628f%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 14:57:41 +0000
Message-ID: <4ddf0e25-a168-ebb0-d8b9-f8acbdeb110d@virtuozzo.com>
Date: Thu, 14 Sep 2023 16:57:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <22hgodp4wygkyjypqvfk7qfxbrwzvhhiwa6b7ajvh4dgayly3o@fnbvlimzupar>
 <urbpb7gwraskgsj5vplmeo5ik53ujqubzpeeaxn6x4of4bkycj@p32fhinqgcsm>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <urbpb7gwraskgsj5vplmeo5ik53ujqubzpeeaxn6x4of4bkycj@p32fhinqgcsm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::40) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU0PR08MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: fd61398b-2b64-4e99-5014-08dbb532f204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLBP62YfVISbOk4HeQ67WKwlm+25USRUhd+7u/l7wwvrMckeERE7Et64lCd2alNIM8wi94c4bLPzHJVyI+HL2T7l8Sn71+a4bjAYWAsi4xCDVfncuEDqFWExiZb0fK9Ts+AyYyLZ3V9/KjmVxahoxmw9GkNlzJ54bPD/bXniMJT3facPQimci2YM0OnurCC73QR4g5F7FHKYZyWoRNyCERYyhiTWYhJUs7ONDQ1Z9Ru8H6iPvwlk8d6lzQ83pZd11UGm35phEQyK1jmMX+ZutrS0jqLyn3HBVnOROyIGsMYsqt6I32hhMnNfIkJbIR396rs4U/1wSLHUBtCPB2p4UUbPqo8pApz/eLYf2XXuvktbppeFahYTIPk6xn1+df7ZgowAKwKSjCLV6sVsbwggm0ClpZG9CBFvJar2Z2xXPcL2lhuiPUqllchrovZ5CZ0qOOxpOCbW/MTSN8QsrsosH+ZxDwpdylSbzVdk/qPlcr93ryNsjqRp+72YunBdQyEsVZZmcYnCMRvlFGO/88GWKrNRgSVR3QQUv3ggsjpXOzC+aeobOZCPXs+v1eFsK7hoLEZkDzEWdx8KS1fNJYh9IteSs3GDg8G0miHJbC4OhyJbNJaXyK0fdOzX9RxzAtTs1ncrB4TvNqQD2k8+nUrDig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39850400004)(136003)(451199024)(1800799009)(186009)(38100700002)(2616005)(478600001)(36756003)(6486002)(6506007)(53546011)(41300700001)(66476007)(110136005)(66946007)(66556008)(54906003)(316002)(26005)(6512007)(31686004)(83380400001)(8936002)(4326008)(8676002)(2906002)(5660300002)(31696002)(66899024)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVlRVVqd2EzVXRyeVgwdTBrS1VWYkp6WEhVOWRKT0NORS9aaGZkQllsWlNW?=
 =?utf-8?B?WDljSG80eDB3OFNmYTZqTGYyMjFvdXBNZG8vU1VSS0ptSmhDOHdWaHlZWUlH?=
 =?utf-8?B?TWFtTnNqNzVSZlQzK0JuSUVkUkJUL3lndTRuQ2pxWTVTWGVwUlUvL0dhV2hY?=
 =?utf-8?B?MXBDdHVOaFpHSjhDN0UrVStPWEdrMWhFQWpwOFlqYklrSWFOZHg3bFMvZ0Z0?=
 =?utf-8?B?amJPSElhaG81dUVUeGdYOVB5bUpjRm1NMUpmZzcwMWxoNFpPWDVqT0N1RTdD?=
 =?utf-8?B?MzVHT1pha0lTQ0JtbnZyMFh4Z1lOM1lRcFYxU0w5ajZoSmZ3ZUZmQW5zWGpx?=
 =?utf-8?B?aWFLaGZQZTB6UUsxUTkvSEZxVE0rWkN0dUUrQWpnS3Z0L0pQOUxNZU0rSy8x?=
 =?utf-8?B?c2paTXk4OHVJbDNEOHY2Sm1QemxMNVo1cmk1Z2xDQzZJc1lNM0hsSU5wWW9r?=
 =?utf-8?B?RHpOZVdFSkpTY2haNm5nUlhKbUNVUXQ1WllhODk0Yi8raURCMkc3UlBNZ1BE?=
 =?utf-8?B?R25wN0VnYnZnS1lBREdBZnpjQ1JWZ0I4UzFpRFF2U05hZGhicWMwS2xmQTJ1?=
 =?utf-8?B?S3I5bG9uOS8xenNGcnN5SGxDc3hYRGtNNDhlQVk0ME5iYisvb0lwLzNCeWkr?=
 =?utf-8?B?YVVNdnk2RHpaV1lid2JBcVJmclE3eDZSWVRPR0ljajlKMG1SeHdQQUhSQW5M?=
 =?utf-8?B?bGFaSWZHTnljdmVRLzY3NkFwSUVMSW5XSk95cC9CdzNlK3Z4L0JxeEo5Q0Zy?=
 =?utf-8?B?dzVrazhvekdBS2M4K3pqL1R5QldIVHhma0FReC9qWnd6ZW1TNmRBWHgzZldH?=
 =?utf-8?B?SmZDb0pEZk9DYW5lNy92WHpNNWZIVlhSUVVBOVlub3dNdktLTGVBajd1NzdP?=
 =?utf-8?B?UkJGdFNxUXlNZVVRTnFmU0VORzZKZis5dWhjdXluUGh6bU9TdkhQYmtrZ0lS?=
 =?utf-8?B?NXgybDBqRy9qbXNYWTkzVVRXT0UwbWdEZjVVV000dW5Rc3p5ZlU3ZDhoYjV1?=
 =?utf-8?B?ZGNPWGN2eWxERitna0hqeC9DVjEwNTR1bk1HM1BrKy93R29SeVVSMzRtWXV4?=
 =?utf-8?B?Y29vVWlHRkdMTTEwS0x4WGhEcE5pTVhUVVBJWXBrVjR0L0VKWFUrQW5jTTVn?=
 =?utf-8?B?YmxGSi95bjEvQUN6OUFnazdTeTF0b1NGQWFhU3lCeElXTWkwYjF1d2d5Ykly?=
 =?utf-8?B?K09icm5lbE90b05samtvVTVjbGpESU54ZkZ2dUZPbGFETXprRldxSmNaaXdV?=
 =?utf-8?B?aU4xc0F1U1k2d3ZHeDFFemE5TlhwUHk5R3hYWWJDY3cvak5JeFVJRkZtK2tY?=
 =?utf-8?B?aGY1b25SV051VkxqK3EyUzNWYTR4bng3RVN2c2hOQko5WGtudXlYMy8yUy9t?=
 =?utf-8?B?RXZuNkYvdWQyVjZYSnFUUSt6OXdtekpCNFVya0VjZWN3YWphSnZoeGpFUkFy?=
 =?utf-8?B?T0prVGxUN1IxVzBJVjljZGpyNTZVZDQ1OFFkVUluU1c5QTQrRWVqN1pHalN0?=
 =?utf-8?B?clZWMHpTZldoSjFhbERrait0cDdSNzM2RFFPZ2JtUTZIWVl6bDZXYmN2YlNM?=
 =?utf-8?B?dFdFNEJQZnd0d05VS1lMSmFqUnpsTlZaWGI4SFlNK3dWa1dFQ3FjMnBrYVFF?=
 =?utf-8?B?MmVVSmNPY1JZcWVReWp5SDNQbDAwcWhKekNzcnhZOXRkTWpHL21KMFlZN1FX?=
 =?utf-8?B?TXpIRG01aHJqcTUwdDdhWVlNOTZSS1NDRjl0ZXlMb0htbkh3aXFJaGdBT0Ey?=
 =?utf-8?B?ekdCMDlpWGYvMWJTREgyMS9jbEZ4Wk9DRERyYllnTk9LUXZQN281QzB5SExi?=
 =?utf-8?B?bTZwQ0hYZFVTZlZQVUE1eGNTOW5mWGZRZk0yaEhHWDlFdTE0ckk3UTZ0bEdp?=
 =?utf-8?B?UnJRbmN5ZVFSNmhmRkFYckNzTThFeVcxSHpGL1lId1FPV3VlS25BRlJ6WHkr?=
 =?utf-8?B?R2tMOTJrZ2MwYU5nL3FOdG9wUzRma3ZaS3pLWW10TWRJQ245TTZSMEEzQjA1?=
 =?utf-8?B?Rjd2TFFBVW11OXZ4VmEzWXY1VDViM01oYTR4S1N4NzRjdXJPWjUrTGxkN0tS?=
 =?utf-8?B?cHpaT1Rra3ZJWUVVYW90cUNNQms1Z1JwVnI2Mm1tMXE2MmtEM3pLZDRtYVZD?=
 =?utf-8?Q?8YeuTrMTZ6brcDYJpgYoSwUxa?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61398b-2b64-4e99-5014-08dbb532f204
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:57:41.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDRz1sFUqQPa9AIn5harqZV5oLmo+Rv+wCuFnCvjgiDuOI851F4/QzdyZ6KTXbClIk+kNaA5W7bWacMuH7YdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7882
Received-SPF: pass client-ip=2a01:111:f400:fe0e::722;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

On 9/14/23 16:10, Eric Blake wrote:
> On Wed, Sep 13, 2023 at 10:36:35AM -0500, Eric Blake wrote:
>> On Wed, Sep 06, 2023 at 04:09:17PM +0200, Denis V. Lunev wrote:
>>> Each particular testcase could skipped intentionally and accidentally.
>>> For example the test is not designed for a particular image format or
>>> is not run due to the missed library.
>>>
>>> The latter case is unwanted in reality. Though the discussion has
>>> revealed that failing the test in such a case would be bad. Thus the
>>> patch tries to do different thing. It adds additional status for
>>> the test case - 'skipped' and bound intentinal cases to that state.
>> intentional
>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Hanna Reitz <hreitz@redhat.com>
>>> CC: Eric Blake <eblake@redhat.com>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   tests/qemu-iotests/common.rc     | 23 ++++++++++++++++-------
>>>   tests/qemu-iotests/iotests.py    | 19 +++++++++++++++----
>>>   tests/qemu-iotests/testrunner.py | 17 +++++++++++++++--
>>>   3 files changed, 46 insertions(+), 13 deletions(-)
>> I agree that this makes it easier to identify skipped tests that can
>> never be run (not designed for that combination) vs tests that can
>> plausibly be run by addressing missing dependencies (such as
>> installing additional libraries, a different file system, ...).
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Because patch 1 impacts NBD testing, I can queue the series through my
>> NBD tree if no one else picks it up first.
> Given further conversation, I've removed patch 3 from my queue while
> conversation continues, but patch 1 and 2 are still queued (they are
> independently useful, whether or not we add another result category)
>
clear...

For me such a filter was very useful, as we
* have had problems in the past with the missed test cases due to 
non-satisfied reqs
* this separation gives positive feedback with test fixes (2 patches in 
the serie)
* there is no idea how this could be done in the ideal case and there is 
no idea
    how unclear ideal could be reached. Having something simple/useful looks
    preferred to me.

Den

