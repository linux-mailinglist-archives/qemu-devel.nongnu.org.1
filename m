Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53F7484D1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2PE-0007Tj-TW; Wed, 05 Jul 2023 09:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qH2P8-0007TE-US
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:18:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qH2P4-000718-5r
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:18:46 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 365D4O4W016845; Wed, 5 Jul 2023 06:18:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=JXmlNSwmDTiOhu5Ivoo7ovnorfKbIe7veHadZZ4BNLo=;
 b=POf12YU/qEB3jNkJbMFD9qhtbzUNAnuQ2tIf1kwc7Luimceu/vAgIqUj1PeSHqM+Hc1j
 pHQ+VxmOHv1NcgCCKiAGfvpxwIJGWsmTEULvFWj9/hvWqV842KDBduz9dGgf5I1a+03g
 pgZITiQi6GyYPkygg2XmMHS68BX96T67L75o9mMWIq3YaJQTe51vvKto1nh9IZQb6Gt5
 /AXj1gQG+D+subiCglfSiSRGRWOQNEikvA7AqGm3YNmV+zCHF3aAEUTlXCCphLBHnNDc
 9pa8/VZFeOL83B9wOm9NSn7vh532B6gT0i391SCS7448YQxRx9FexohlO/s9q8qyQ99k Qg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rjk7dpt7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 06:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHOOUkVGc3l6QZOktt4uOTGUwet3jaIH+kQkPxyimXk3wM3E4eAfsN8w7/5nbDHG5uAabm56zsnAtg0JoiU70Gh1t4LCRMeaC1mKQMXaXAH9IJuGPbW1qiPoVJMfZNaqvE0eWyflQVPe8wtv2fc4oJd6Uq4GGHa2DWRGNoPQML6fOdqrOlDRUbFIg0z70sU1LmTgZaTsuXtl8ipPGreKaPwp1+yWZCs9+OtmbZJtbovVImjt+TmY3y7BeoyndkxNgl1pDS2HrvP57u2mSSEtg7Qb6iWS3T7+FMmDBWNXHUpW5izsj/kSQ3UOW82pG0uOCBsP3GIswOo4aXfJoJSmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXmlNSwmDTiOhu5Ivoo7ovnorfKbIe7veHadZZ4BNLo=;
 b=F1/jZO3LY/mya0AkRpUeEbOA7bL3n7KiIw1AtE3lRZ79dIFbgRSQkwy+ozAp4VBX3XTFZOPaJjeX4DqbFyASxmFK1k/prR6zePDucE9AXehARW3ZGdwFSyaRMf0zvmL9DFsHNOpR8gmPlAymQ9XEZtlmZC7H1p+sJqnRe5amHlXGCyLX6q1n0UO9BRQhQkB0iU4Ax0rZ//VsryWv4UbPAZL+QafSBzu0ei3FKy+KqBsB4JLCBxDJX5/uocElgyQ1AVkUZ1P9nm1ZXlbXaJHQGB7dTUe93aHZBipZ1/7tdXZoXvn1cOhhMYKiSTGVMqRU8lNXSH+SiYyaJjSFA7XEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXmlNSwmDTiOhu5Ivoo7ovnorfKbIe7veHadZZ4BNLo=;
 b=qjjHXQDmxJYKi8BWDTRfOnCEROJMjRSXtltspFJtlumPwAUWvu8MS96xOaOrX8DNKG0xchBs+AmIT9rPm5IadNe48PcrYKnIeAK9EnQxNDgQ9a0PNyduDFiZIBRzXBS/qggH5l1V5k+EGiCXYzd0TTu1JCxnjD98MjAsW7Au+PKr13DUmNRjZZ2iInDh6TL2XOCAaJVWVJA0e7gpfBdwv87mAKMceOt4w21qtMdfayALdKKxAaHgsR7zLLH+2hiT2yv35LkeqM2vlHA/ENV9atE40/DWcb8ROkXiDOA7uIITJRgBq/jodKyulRbMpxL2WCLBzf99HP9E7ujjnoC+bQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by SA3PR02MB9947.namprd02.prod.outlook.com (2603:10b6:806:394::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:18:34 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:18:34 +0000
Message-ID: <7f991a0b-c61d-e573-baff-9cc991201702@nutanix.com>
Date: Wed, 5 Jul 2023 18:48:19 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v6 2/9] migration: convert uri parameter into
 'MigrateAddress' struct
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-3-het.gala@nutanix.com> <877creiokr.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <877creiokr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|SA3PR02MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb47a76-06c8-46c1-b199-08db7d5a5591
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxM6tSC3nAjlPJklcawnahnAUScXjMbyczdaYlTWU5ZgnkH4L7mCP6fR6OvaIPfzwC5pEq4QZCnAa1ZyO0yIDp7dUbFSFWvP9WgC4dnso35DvhrLxBfqFyIz/ZXH88MIOXvUqPdOGwRZwFvtWF+ZGx0W17yRm80dx7ch6O/T8jd0rVRD+lNszhUEJw8u3h203q/TBQFZKE5I847DoespRpGY84h0dVmgvy4HNUDcGftZLO4J8hVU5LpA0i10mFaZ7tD1iA5tlNyui5UFQ/pRGp6NbKPO5rf5MUDIoGSLnrovzihJzw0zNlDspBNZdvpVSl93oGN5q69GKDb7tRJVlTX1jDPq0ZU5xyTaGFAgHAOW1+s0y2h4R37S2uhJJZSOnsRqtJ+FaQB7pknHvshY3MNYU2t3FGH5ZFliq1Oa4YPcOBlccKRLb6ApqqbBido49YBEkKkceoS2S3rLMcD1Qt6zbkbWjrNvJQ1QMAZq9XUn/K531CfySLOcLo11PptSk0Y4GrLCvM/8aTz5+m9X1aeZU53RNkTI0TFynp3WOI8CppeO+sgBw201/xC2I4YQdo4mSxxNJz1rHO97wQsa/rXHVjkZ5ksPk/sVjFuoPk0VHFXKd6XXDPPS8IoaiOrGXpoWNuFJmh3RgJ1KPscURg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(478600001)(6486002)(6666004)(53546011)(186003)(6506007)(107886003)(6512007)(2906002)(41300700001)(66476007)(66556008)(316002)(8676002)(5660300002)(44832011)(8936002)(66946007)(38100700002)(4326008)(6916009)(86362001)(31696002)(36756003)(2616005)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNqaUtFNTBINEZPRnJpb01UQitoVW9UaEYwdUNFQlhrMEt6M0E1Z1hQU0hJ?=
 =?utf-8?B?MTNCOGU5eWFQR1ZPUzJ5TEM3TDhIY2VFMERpYlFVYU1sNU9lS1M4Uk4yZm5a?=
 =?utf-8?B?UGJYTVpVNkJ4bVVkTjZUekxXZjRZcWVqREtoVGpnZWFyNWNPQ013dkNFZ281?=
 =?utf-8?B?SWppUTh2TFEvQ3doUFpGYzNMb3JIWjVHMlhGTEZsOTV0RXc3Mm12SHhHWWMz?=
 =?utf-8?B?ME5EKzYrUlFNbVFTdXNzVzVHR2Q3M1BDanRYYkxvTlJKNXR6eDNjL0RuM2My?=
 =?utf-8?B?SThJV3hrMXBFbWREcUxObWZuK1oxNGFJTDhHa0hxdi91Y0duRFk3QTBqeTJG?=
 =?utf-8?B?V1pveTVKOHVCVWtVWTNKeDBjQkd3N1JBeTJ1VmdGWlNORnFueldlK0Y3ZW1W?=
 =?utf-8?B?SGJLbTZqQWcvVXFvZWJ0RlBMdDYxOXFLOG1NbzI3NGMwUkMxZDdBbEtzWE9Z?=
 =?utf-8?B?c3RlK2ZrMVBzOFZCcnlTcTZWeEU5OUpaWS9LMklSZWdlOEtLWktqbWQzbXVZ?=
 =?utf-8?B?RWFxcloxWlpIVUM4OWh0a01DejUwY05qT0FpdDhVMmxEa0lONnl0eWs2c0Fi?=
 =?utf-8?B?b2RVMm4wQ3JRMkdnYjltL3dxUWFYdnA4ZkoxNTJsYzFJeWNxVEkwMTkyQk0v?=
 =?utf-8?B?WmNQL2dZcEFTaXJlaFBFM0tQM3JTRi9RS1o5WGhxK0sxV1ZsUkk2R3JKcWdJ?=
 =?utf-8?B?WFNqN3kvVWpURHZRdkpXZWZsWEk5UHJ2MVdjVXVDZ0U4VzVVVHUzcVVxSUI1?=
 =?utf-8?B?bHpob0E2ZzZFOFZLTjBwUlRISXhYaUVnTFZRVHQzYWUvam5IdkI5MnM0STdq?=
 =?utf-8?B?dVhZblMxQmIvTjdndFk1NXk5K2dCN0V5dWZsQUg2MEVUektSaHFrWnpNYUk2?=
 =?utf-8?B?UkIrZjFiT0llcTlCRWNnVlFDWG4xMWs5SGwwTnFEMERrblNwWnhRTkFFUUow?=
 =?utf-8?B?OG5FMDFMWEIzVEtrcU1FdkhsSHpoSmdyOHFIVEVuRjNMQ0s1bDRwM2dVeW9k?=
 =?utf-8?B?RnU4TWs5OFJOcXUyQm41NkRMZjhRUmJ5dnB6djlaWTVSWWg1cFVYVUNEa01O?=
 =?utf-8?B?UmVlTGcxUWZWZzhFS2d0MWdQQ084KzdwL09uUld6SHcxZHB2SW9WS3R2a1cw?=
 =?utf-8?B?cy9zSm40QVB1NjlSMlcrM1doUkd2KzJBcEVnTFVVUU1xbWpnOXpOWDFxYWNF?=
 =?utf-8?B?Tm1IbFRtUE1taGp5bjkrc0pNMmF5cEdkYWVkT251QVAwN2J0dEhHNmgwcWN5?=
 =?utf-8?B?MFZRbTdjcW9tcHd3b1ZLVXB2VExLZkRUVk0yVUlJbURwY0UycWgyblR1WW80?=
 =?utf-8?B?MHR1TDNPbnV5Q2d6aENvUG5RSWc0TVh2SzUrS0dyaGZ2Nzk5Q0VJekVCZ0dQ?=
 =?utf-8?B?WEFKV3JPSXl6Q1VtNWJiMnhCanAraW1WcXh3ank0dkpSclJlVWExd0VOanFk?=
 =?utf-8?B?emdNZitWWFNVUW54OVdXK3V2VEhRTnc5QnFqVTN0a2xDbzh1N2x0U0dGNzcw?=
 =?utf-8?B?YnpjdS9ETUVURVdzbkptSjRTVnhnSnBZd1hGSDl2SU1HQzVVY3hDRGo4WGwz?=
 =?utf-8?B?NXJNektmLzJwb3ZPUnlYOS9BZ2F6YXN6dmxiYnVoQ0labkZPUlRnU0ZkTmdS?=
 =?utf-8?B?MThuUW1RWTJjL2lmTDd0aUxRTU1HUExMeHJDT1hESmRpUkw3QnUralZtZE5z?=
 =?utf-8?B?UTlUKzRGNk9xZXI1VDVtbmRQOVIzOTk2TVRsK3VlcUttaFVOZXVlTUtsUFFC?=
 =?utf-8?B?MVNobGFWZVJoNjRmODVVNkhGQlZERUx5Wnl4UUpMd1I2bm9hQ1gzcjEvUVl1?=
 =?utf-8?B?SVBacHRnSjgwc0JHbHZrL2V0MTJ3djVOMGNGSFgxUk9OY2lkbFFJU1ViTVF3?=
 =?utf-8?B?em5BRXR1YU9rUWdkajI2QXRDLzMxNUNjaUxQcExYUVNJbFh5dkgyeEFCNVl1?=
 =?utf-8?B?MThKUmxoekxzU24rTGE3ZktETWx1bW9Tc0FxbXV6Q2Znclo0cUh1YWxSRDFR?=
 =?utf-8?B?a3EvYjlZeDhDSXV1ZXQzdGNXVFpyZXZtZmRIS3BwT0VCbGRuUHdqTHdmSFpN?=
 =?utf-8?B?RTFFMUlURzRIbkk3cVUzN3VZRDZ5SmJmR3VuOGx5dmhVRzQ1cTkwWXZ0MVo5?=
 =?utf-8?B?dG1UamNadmhyVno0S1JPUnUvanprSXh0QnRjdFM4VlpncDVhZSt3dk03anZN?=
 =?utf-8?Q?qb0/ihtJSMzcalSMsYJLf+DOXHSYyPFAEqtawyX4nt0v?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb47a76-06c8-46c1-b199-08db7d5a5591
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:18:34.3029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49WEMkaHFLdA7N7mbqfWjDOyPKIrQJ2D11xQCkFvXurG5t63dTsIjZr0f652uNa+4DCf7aKv4vYl72MVDzmMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9947
X-Proofpoint-ORIG-GUID: M5msRjNPl8AmxxyKx_ndBGnNZZ607Ymd
X-Proofpoint-GUID: M5msRjNPl8AmxxyKx_ndBGnNZZ607Ymd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_05,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 05/07/23 4:59 pm, Markus Armbruster wrote:
> Drive-by comment...
>
> Het Gala <het.gala@nutanix.com> writes:
>
>> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri' parameter
>> with all the migration connection related information and stores them
>> inside well defined 'MigrateAddress' struct.
>>
>> Misc: limit line width in exec.c to 80 characters recommended by Qemu.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
> [...]
>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index dc05c6f6ea..0eb25bb5a4 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -64,6 +64,7 @@
>>   #include "yank_functions.h"
>>   #include "sysemu/qtest.h"
>>   #include "options.h"
>> +#include "qemu/sockets.h"
>>   
>>   static NotifierList migration_state_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
>> @@ -420,15 +421,63 @@ void migrate_add_address(SocketAddress *address)
>>                         QAPI_CLONE(SocketAddress, address));
>>   }
>>   
>> +static bool migrate_uri_parse(const char *uri,
>> +                              MigrationAddress **channel,
>> +                              Error **errp)
>> +{
>> +    g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);
> @addrs suggests plural, yet it points to a single MigrationAddress.
> Recommend @addr.
>
> Same elsewhere.
Ack.
> [...]
Regards,
Het Gala

