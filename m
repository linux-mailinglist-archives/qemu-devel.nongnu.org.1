Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DEF797EA0
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:11:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeNCl-0006fS-Gp; Thu, 07 Sep 2023 18:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeNCg-0006Zy-LF; Thu, 07 Sep 2023 18:10:22 -0400
Received: from mail-he1eur01on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::706]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeNCc-0002W9-SU; Thu, 07 Sep 2023 18:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXW5NGiIDGem9eHIcGYd0/N9r7Fph84OBzRgNW0boEPQwCtk7rr3xAt7wzlunPp4WXwaE8HZj4tq9x+2nCHgjHOvaCHF3hWe8xmT9ANa8EpoStZ2m+7Na2WeXp2qKT2ZA4rsnUPqanXVwIEwl67NHIyvQHIi+anUK0mr5XaEsvEZL2W7RjymUUK9pJIAAtCpdp3ffSRymlMc06XruAspoq66IUGChuiLy/taDylpE4IMfxUrotf6iXc1k64z3IBD20e9KQLkou9hGrFvdT/yQV1Xt/GUD5x+JkFtrPeQIG266VbMZHDtOc8aP5IsWjGsEq6sSbwjl1rCcCC3E8Oyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJvkdlSIaQPg4/CHf6zKlvMTommoVlFeWyZwtJ2UCb8=;
 b=EbwWARqkhry7zo5uAks1esjM5t9/jW//+tzItJwJihNOIKwq0BWKvFHpjj/5QJrk2UICi3q/9xVdpA2MPJhdY1Lx/yHqO3hsU3DiGOIsmXhg1FiSZFhaqjryOAazmUTxH1csk5BisXaWSPMfAlKIiQu1Vk70/RKQi8kbXSc2z23i8b0C55CKgkrc+6WYEnqL4VJO/98+fk40p5MfQuiubIhD/oRKMPr33v3mChHvFcm4vrBbCcZe43i7c4tCYJb2arGCpxk9Ic5NASw8i3sYiTElrBO9fONdrWvIBVyvFRbe/Jk8m/MiYh56btK2Dm2DZQP7qT1Ojjk4IQdAF9+BIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJvkdlSIaQPg4/CHf6zKlvMTommoVlFeWyZwtJ2UCb8=;
 b=IM+//AX3tBtzpytDUbrv6kj6px10UHYveEimc3qY+tjerFoc0R6yiRkHxQIRFgkZ5FlctfKGmBeZlko8n0orJdOiqWmSTvDo92eKSapTlVAuJyB2rEBw7HPzo2BJNibthCm3KLQYvCtmBEnSFjrSQ7hEwIi+2o6oaJWU8EPqJ3Lr5MzuV0EgT/4I40eZDVK2XuRLJiO9SjJrbx7EhBvA05MlqXZ8Btz3T5NDQp4B+W7wyCoO9vH2hJ3HhLIQkDHj9AxRdVYGT3lER/ogoqpZ9KSKvHAo5QZuSMxpIEMxJaQrUZjikarYCM4AMqMdzNuYyUsyc6x/hs8p6DBDuNIdhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS4PR08MB8093.eurprd08.prod.outlook.com (2603:10a6:20b:588::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 22:10:13 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 22:10:13 +0000
Message-ID: <71928e46-28c4-edec-eed6-cfa3778730c1@virtuozzo.com>
Date: Fri, 8 Sep 2023 00:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@openvz.org
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
 <775f32c9-6068-9481-9ae2-fb259ce5bde7@tls.msk.ru>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <775f32c9-6068-9481-9ae2-fb259ce5bde7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0144.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::28) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS4PR08MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcb9cdf-15df-4736-5c08-08dbafef35b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHZId2alK2CcOdJBHdOqoq7cHq0OXEVQd0yk2y1DBj9ndH0xMFsh/T5XGgB0hRVyuRvHuk7k1e+LuFVxhkE+t8WW8gAK0g+PA9FgS6KA/jitjCZvPYXCg15jB57DRJvIGlQhLSjFXHOyo/25Y+3n46SlfdFiZ1w8XEYQiCd70Y5hUb0DQEn/nuJCo14itT+sUzHfH+vApjS/PrLx6KjlqCjGrI5tmEX/IKPxCe3utLEmaUegj0+fFwBMmkCbzg7VGiVJ0ENn8lmERrlu2yoMRRTcWh6p1OQk+Ozu3B4L+/JThsJG7ZUisfGEKASV31+7NQ+nMYow57KTQaES+doHbSL0rI96tqpmD1gB4N7Dx1YTnx00ee4e9STaYG4N2KdUussLoB0Wyu1aYCwZwc9b13nbKd0NoycKzO1/YGM+/iQB/7jfd5JBdSlpwdnlRNuV221Adv70DTCVB6s5vqlQZK1MidCA7kVPdDNU2c3Rqdzp7cB46jNmMIRcJsKp8o1lj/9qolPgFa/KOZQF+tFmXXBSUCkRSSPA1vmAWeiZgBjTomCLhxE7MZ7gVyjhbnIrCf5TuriuNP6FSwus+WZ64ov7/DuyYkycTpkuOcHfKdHK6c0w8JrmnGqW6XuYsGNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39850400004)(186009)(1800799009)(451199024)(31686004)(53546011)(6506007)(6486002)(31696002)(86362001)(36756003)(38100700002)(107886003)(2616005)(26005)(41300700001)(966005)(6512007)(83380400001)(478600001)(110136005)(8676002)(8936002)(5660300002)(4326008)(2906002)(66556008)(316002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZBUndsYUgwcllzcld1R1VveW5HQUhSaEdWR09RclhMSDU2UWZxNEg4OUN1?=
 =?utf-8?B?b3RMMkZ6OW9jcTBuVitqL3I2TVVTVWFiRE9nWHdHNngxd1lFWGVzaWtTNXJr?=
 =?utf-8?B?djJyQzZmVmhuRGQ2V1l0cHpSVkdER1RNQnU4N2JnRnlTeU9VbVZsRDk2UzRq?=
 =?utf-8?B?dysrbmtTU2lCNnJGb0x1eUhUaE1RNWxINm5SV0QzbnFRby9BVUVCNG9BWklu?=
 =?utf-8?B?dG96WlBzRzVROXpuNUJ2KytFUi81WGZQWC9BUHhlNzVpZWxrS1p5bGJXRC84?=
 =?utf-8?B?d3U5QkxPM2NFb1l5QUJFTVQ2bTlLdGc1NjBKWU85ZlcvV2p5UVJzU0habjJp?=
 =?utf-8?B?L2hPRWpFK2RoVHZ5aC9sYUI4WnNXQVFzckZzdmM3MmFyeXhlL1BEbW4rT1VP?=
 =?utf-8?B?MEplRzlodkhZS1R2N01xUVpvSzMyaFRycU05TXR3bFZ5bHozQzZDSmtNTnZB?=
 =?utf-8?B?Qkp0Q2N3dHFaQldSNWFqcXM0R1p4VEtEOFcvckx1QmMwNUpKekUrS1NFd3M5?=
 =?utf-8?B?Z3lxRGtJRlF5a0VITjAzLzdQVTNlYUhwMXl6akRIeEpydUVJOXI3S1k4a2RI?=
 =?utf-8?B?ZVhicEpwNXhNOGxjYnZDN0loV09oYWlDbUlzTkIva2xndy8rNVM5ZHA3Mmt6?=
 =?utf-8?B?bWpIekM1ZlBVU29hS0RVZzFKWEdGcGl2WjBndGFYVlQvVTNQUVFjQTdzZzYx?=
 =?utf-8?B?ZGJSVFBTUC9VU204Rk5VUjVBMlF1UzU2c3NxMTNHb1VFQjBObE9GVFlOalgv?=
 =?utf-8?B?UEdOOE96WTJFNllWOVNXYllpc21KT3BmYmZvekRnaktYMDZxaS9jc3JtWUgy?=
 =?utf-8?B?YUZvY05Fdnd5dG1kVEZ5aVdPclVrZHcvUmNQUzRIQS9NOFdXTExYZ1hyM3dB?=
 =?utf-8?B?N1V4cDg0czVyTFcxK0VwTEpMVGNOVEJZNytyYmU4bDN5UmFpaGZvNVZubENP?=
 =?utf-8?B?bkFWb1ovNG5PSEgyb09wWnkzWFE2eHlDMm5XTzQ4R05HeGEwaW1HQzZ0d0xk?=
 =?utf-8?B?Y2xQUTJjYjhtKytzcXpjL0hnYStMUUt6Q3lPbDEwOEcrTXJKNWJiNUdLOE9k?=
 =?utf-8?B?SWFoN1ljZVUrLzBvK3BDRnRkcnlDNVRhREQ0SjVNRXlxL0xjOXRibmEydVFz?=
 =?utf-8?B?a3k4Wjd5Mi9OK3p0RWdwNkdWakhxY1hhcGhvSzJTblplWUg2T2Y2UGllVmJF?=
 =?utf-8?B?TWVwVlAyRnZNWEhRMUxiMVc4QXVqd0lXR3A3bzVXNGtIcjFVUU5iODhVSStX?=
 =?utf-8?B?VWlGSHBMWk4yQ0ZRZzhLZzVPQTRBMHJaNVljM1VRVmtsUC81OXh4VDQrdHZt?=
 =?utf-8?B?ODM0ZDhjd0ZEaE4ybUNVV0hUajlZcmZmbmZFSDhmK2Qxa0doRkVHWVY3Qndm?=
 =?utf-8?B?eXNMTWF4Q0FFa1JDdm5tZk82U2ZNYXRQYXNkeXV4Y0ViUlpsTHFHbVJ0Ykcy?=
 =?utf-8?B?RmowZjY5OGIvN1ZJeHY5MG1pR1pUYytVNy9kaUlkK1lkWjhZTGdBUFhoMzU2?=
 =?utf-8?B?TUNUYndETHNFTHFvQVpCd0pIVjE3MEdaRFkrNFdZZUFEMFZVZ2Zidk1oR3pw?=
 =?utf-8?B?UlJEVkpxdkQ4S0IzRHFIc1p2QS9wQlNiemlWczJ1WHFmOTV5V0I2bXI4cjcy?=
 =?utf-8?B?K3lmdlRIcFBDZVNPdWlJK20va2ZlMjdSMEF6UTF2ZnhmR3dsb0JYY2ZGVDRC?=
 =?utf-8?B?aUNsMXZOVUIvWTloR2hJWTdLRGtEZWkwSmpvRER5bmRHcTFMa2VGZ3dkenZF?=
 =?utf-8?B?eUoyRzQ1OXhFdXg0c0FuZ2g5TysrazJxZy9LMWltSlVMS2hHclY5SHp3elds?=
 =?utf-8?B?cUpxdjBjK2Zob0R1TzBHVnBkY3RIRkc5YnNJMkNHeWcrMWpaeUx6QmtJT05V?=
 =?utf-8?B?V3J5KytoMEEyOFFDZHEwWWlQSzI5c3dLVXJaSFA1YXZqYkppOU5BdythWlVz?=
 =?utf-8?B?cFFYK1ZON0dEUTlmSGZ3OVAwdmVvZGtSZGNwbkFITE1Rd1dLK3l4VlJNZ0Ex?=
 =?utf-8?B?bFlFOTdaNkYvZnlUNEVCUkx0RS9qVTVLQXhUM1VoV05WTDhEU2g5dVlQVzgy?=
 =?utf-8?B?emRXSVlUMG80bFRwcDdtRXhZTzJkQlhueExmL0pYaFJPVks3bVY0T3JsWndr?=
 =?utf-8?Q?YeCItXtpUEUfhr8JKcLdPy7kx?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcb9cdf-15df-4736-5c08-08dbafef35b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 22:10:13.7215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d84YeCnoOYnCDe28XYShnB0Z8mjKniBrFsV9APeePWWPN8EtO8e9p4dV2g3sSIcBWEAMClLB1LNbBrRn/n5RPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8093
Received-SPF: pass client-ip=2a01:111:f400:fe1e::706;
 envelope-from=den@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
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

On 9/7/23 22:11, Michael Tokarev wrote:
> 11.07.2023 20:25, Andrey Drobyshev via wrote:
>> v1 --> v2:
>>   * Fixed line indentation;
>>   * Fixed wording in a comment;
>>   * Added R-b.
>>
>> v1: 
>> https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00606.html
>>
>> Andrey Drobyshev (3):
>>    block: add subcluster_size field to BlockDriverInfo
>>    block/io: align requests to subcluster_size
>>    tests/qemu-iotests/197: add testcase for CoR with subclusters
>>
>>   block.c                      |  7 +++++
>>   block/io.c                   | 50 ++++++++++++++++++------------------
>>   block/mirror.c               |  8 +++---
>>   block/qcow2.c                |  1 +
>>   include/block/block-common.h |  5 ++++
>>   include/block/block-io.h     |  8 +++---
>>   tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>>   tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>>   8 files changed, 99 insertions(+), 33 deletions(-)
>
> So, given the size of patch series and amount of time the series
> were sitting there.. I'm hesitating to apply it to -stable.
> The whole issue, while real, smells like somewhat unusual case.
>
> Any comments on this?
>
> Thanks,
>
> /mjt

The issue was observed by us in the reality on not yet
released product, but the series requires correct, which
has been sent as 4/3 patch today by Andrey. Unit tests
are broken at the moment.

Thanks,
     Den

