Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2180A72561A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6noD-00043v-S4; Wed, 07 Jun 2023 03:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6no4-00042q-Jn
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:42:13 -0400
Received: from mail-dm6nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::618]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1q6no1-0002oH-VG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSi5NsP9xg+ctcn19d9HzU5Ktonf8ALbofbrqE7BVc8Rb8SMdEhdpeyNyvmL2VnsyHEjkpEFMfhSKQn0TD0tiPhtreu4ULUwFbcuej5Cx97PK4qAel2L/IsBtM04VuK3IPntn1yTSzmtMLUI1vHpmhhh9GRgxVP14w7ZobQxYJ/TKnQEXdHGLYTFcTMS8RA9XGTp/P2i8gneKGWhaRT6XvuBNL5JOzNauByNh982XTC7A+pOi182uxuxdiHF9krSmaTcBFTgg4iU0RFDLNHNuxZHBmADkXv9U05px6n960oEanzTH0RdCAsd6mEdEXv/vuBaZqHPe4enOrro7RzReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Y5Yau4WviAP25vSCxN02dr34pG2OMKAcz2eenB+2w=;
 b=SbTd+7508b/arAbrfErURzTjNE5GXKBhUH8Pce6pQL8HOOPSv+z3m1WOUB5Hk3m8aeQm6+A1d254W0Lccy1qGst5ahpNWcIeyZ4M62zo7syakt/VDnvdt6g/TuF9KMhQA7MCKf2Hb8r9A5iIVwIiah3ukoWTkaJXs6WF4Mvd4vtqSqz/cV2S28yVPjmwqepbQyQguyNzCKyEd/FlBVyRMonmU9ZuXBCCn2Rtiz0qek2Ii7HeAjnMrFDHh/Hwa9vLZHUJOtNkgucwvpB4QvOHhUMQrub2oLhZJXxZ29ht55u8Kxeo7fURbt83wvluMIcPnZTm/DsLEzdXIobLnD8l6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Y5Yau4WviAP25vSCxN02dr34pG2OMKAcz2eenB+2w=;
 b=hDxDpALafM8p6ilEZtF1I0UQbhrVFc38evFkYpfZcIbcVBE5T2ct3lQ3n1gYelrGo6QsaLr3V/Aag1Dkuhywt4GyqwR/NTGC3vq0RQmmOeFsm+D6vO/Gfl3G2uWffM3SQzvnCKgz2A2POQ87ghFB96j3F+yN+TZaj0eu//htIK3WJ1r7ob8nTfdONPnoFQAYnEf81zDK2g7C8OIPSQa59DhrzFq+6Q3sie8V3OVYfN1BXxmKXG4mVcuhDBwKklXyIJtyo1UDIWsOzcAAR54qCKD/wlzP/WQ2d+BUFe6vAb4ZAhWL3gvJLqEQ/ecoxVaZ43SQxz56CB2vqCAo5WQP9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 07:42:06 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::77ef:9cbf:2fdc:a6c4]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::77ef:9cbf:2fdc:a6c4%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 07:42:06 +0000
Message-ID: <0e0d5fbd-0e0f-15f8-5586-81ac60389578@nvidia.com>
Date: Wed, 7 Jun 2023 10:41:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-9-avihaih@nvidia.com>
 <20230601142231.78b15326.alex.williamson@redhat.com>
 <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
 <20230605085612.32f4ef95.alex.williamson@redhat.com>
 <9bb2d05c-d4e3-1d4a-ec99-2780895ae7c5@nvidia.com>
 <ffa8db05-aa4d-2ad7-3165-72c05b4de2d7@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ffa8db05-aa4d-2ad7-3165-72c05b4de2d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 71508971-adaa-4cc5-6cfc-08db672ab0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ab3JysShFD3xj0dLQtjRBpPk2i6jO9+lA2RVFsVLiYSL6xgQTkG6s3ud6Jn77/lDiav6QDjbCMSQzsirxkfgGqxGOW+ni/K9S0EqAirNFTJB3eHRCHAhUyX9X2HV2tZ/cq//LMOYWvRiBJcZz06jBicnEwaRsnXN9anyxjZIvk+tC79sr58YT2g8D7jLBURuicIWHu8MLBL6QpYQfKhXd/u9h+916X4m/DEhKTWdlCx+9o5TCc6UJK6qEsEblyWnFguEqoHC/0b7t50H6J9sZBjQxqud66fml2E9PM48J3bXYy+k++s9pw6zwg3TA6AobRv364wbzsbEkjOkH1mTDA0crOI0l286NMHUgYVCrfE21q4MyT6mJ/qWstQLBH33Eaj14MwylYk/HQlOgbY9rMIV8HNxhAWQe9F08Dk/WQTjqoH1mYto1aA0OgcdpA6S20djyQajrnK+C8EnqOAZjiGsZkb2ostog99wCyRyKpH9W2qq0ZHh83WdNwXsz7SqcH7tKdG3W0oUyUlI9PMBL16RadK6+XVBs8NgjoXROMp+0EsnPPHesvbfJTOUS8eQVQY5M9/stfawVTvx8N081q92YiaqggSIGu4Ta46s/bU0Ipj7F1yQcxYcdxKyFAEs+4zkSoBxnu5A1Bga4SbAQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(53546011)(26005)(6512007)(6506007)(31686004)(186003)(2616005)(7416002)(83380400001)(66574015)(6666004)(36756003)(6486002)(2906002)(8676002)(8936002)(110136005)(54906003)(478600001)(66476007)(31696002)(38100700002)(5660300002)(316002)(86362001)(4326008)(66556008)(41300700001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZtWlBGYjE3Wkk2T05BMTZrd2NqS3ljRTFRNGtJeWR1MWZ3TGJUaE5Gdy9i?=
 =?utf-8?B?cmhRTHJkQnlrTW1zZTlKMGdjcHIwb0lud1BTSHJROE5YZjMxdGI2Mjl4V05W?=
 =?utf-8?B?UFNybWVrYTRUVDRjdWdhTHFBN0U0ckJkUlNNU0Y1VDFSWWZuMVBGSDBnWXBl?=
 =?utf-8?B?YXhtSWNXc3Q0RU9aYlpseWRZbi9KMWcwRTE3UjlBZEpBNWFxTUtqL2FPbzlM?=
 =?utf-8?B?b3JTMmtqdVZoSVU0K0gzZ0Q2TGhLV0FhUDBuNDZUamtDcXdnYXgrOUtiSytZ?=
 =?utf-8?B?WXYzcEk1SGV0a0YraFNWSDYzSnhoYUFuRHJ5dmZySmF5bTNjY1plQWpTRkZW?=
 =?utf-8?B?UXArNDc0NHpoaUg4MHNLMXVpVGlOQXB5bjVzeXlIWEd1K3duR0JVaklqSERa?=
 =?utf-8?B?b0dvbHRxRndYU2tMQ093eTVjNytFV1hiRVlkdlJKUGJWY01KcytYWXE0Vzgz?=
 =?utf-8?B?VnRiWjFLdmxEK0VXbUF5Zjh2MW5xVVRjYVU1RjkrazVCTzhac0VkWWt3Q3Ba?=
 =?utf-8?B?U0MyU0tBR1p5Vm1rL0lQSW5HWG5ZRGlvRnFrUzhlQWhPOWkyS3owYlY0ZUJN?=
 =?utf-8?B?dFFuSTk1VUNTUWVwMXZYbFJzSVhQbkFMQnpUZUZBUlNjekM5andmVmsxcldQ?=
 =?utf-8?B?VXdzb1FhR1FLdTE0Y3FCd0lKSjFxL2VjQ3dIYW12U3NnSFpWZW8xbitCaitP?=
 =?utf-8?B?d1FTSzVRTWdGUEh6TTNGT3ZRUytjb2hnaU9ka2I3dTZvQ1VJck9iSUxzaHZI?=
 =?utf-8?B?citBMXZ2a2dLazVZOTFBWWxhMVN1eitLYlJHQmxTaGxxc1gzSXJRSjFTa1JY?=
 =?utf-8?B?ZjZabHZtZThDM1d1ODJISWxpQ0JxSEcxV01jcHRzRGxiR0tDMmlCMGJUcUlJ?=
 =?utf-8?B?a1VTYXVPS2lGeGJpRXU0K2hsU2FsTHFNcGlBMVQ2VDhVZmhyY09vOVlWUEdC?=
 =?utf-8?B?dHgwOGJsUGJJNnA3NWl6Y05ZNzN1WXJKQ1crVG5hWTUyR3NYM2FRTVpUa0ta?=
 =?utf-8?B?RGY4d0M3aHBmZWdVblJrT1lBWW1nZ2VMTjVhaTdmM3pIamlvdTBpblFhVFgw?=
 =?utf-8?B?WlBQQ1NGZlhGblVzenIrdFZCc2ZXd1RBUEF0bGZSQS9yTEdDS1dWN3JFLzJn?=
 =?utf-8?B?ek5nbXdtRXFlQ0toWEV1ZEhvT1FBdHpFUEk5SXdodjlSNlZnYVUvWGFVdW03?=
 =?utf-8?B?M2ROUS9SdkRsU3hERE0za3Z3Nlc4WkVqSzRMZmRmSCtIZUVWSXhBY2d0WkhM?=
 =?utf-8?B?dnlEVlNQK1pMRGJKRkJMVVN6TWg5K0craE95K1FjNDdFend4bkxFNWZibTFM?=
 =?utf-8?B?NnZXR0tpaXpkYnlNMEMxajUycWNzNXdRTkxtYVdhbEpQNlRLeGJKc3Rsck9u?=
 =?utf-8?B?WkFCMlZuMC8zNHVUbXQrMjZzMjVYejFITGJ5dnZoSTR6eXluZkY2a2NHSE9D?=
 =?utf-8?B?VkVpWkM1S1JSZ29WZ3FKQ0ZVSGI4ekgxRnF6bDhRZlhrQzQ0TXJZOHJISktP?=
 =?utf-8?B?QThuQWZPNGwveHFLM3gxWldFWWEydGR0U3RROHF4dnJITGZyWGh0L2FkQVJu?=
 =?utf-8?B?M1FIK2MrRXd3dmk1clhYeXp0Z2JHVXBCWm5YVjhWY1ZDTzY3WHprUEVQeWZa?=
 =?utf-8?B?c2xsUXlVcDdxdTNYblJjZFFtSzNyaEhaellJL3lBRVhFNUhXK29IaVZ1SFZu?=
 =?utf-8?B?ZUhJa05zRXExUkhPYU1YY0xoSkRPMEdqbSsraWFLQnJ1MEZVaktWNkRZYlYx?=
 =?utf-8?B?bkVidUl5SWEvMEoxMzkyNklyRHRZc2ZXcG54emhESUJVN1JvMGdFdmN0TEFU?=
 =?utf-8?B?YVFYT2RjTVF4MEk4bXpHS2psUTZjTjNFVjFXUjNDS2ZpNXdUSzE0SlJEdFEz?=
 =?utf-8?B?Zk53M3V2MDJyc2FteEdBc1R3eWYwRHhxelVJaDVsUE55OHRhVjgvY2RtUTE5?=
 =?utf-8?B?QisvMmtKajdVbFZtV1gvUXY3YysrSFoveUVMcXc2QjNISHlJbXlMZnorcG1C?=
 =?utf-8?B?T3E5QU5jR3R0cFhiZUVwbjloT214QzNmODBMYk55OVYzWWRoVDg3QnBVTkMw?=
 =?utf-8?B?ejFHajNmS3Y0RElCTm5Va3BmMTJRT1p1VlcyOExEOFlsTjIvUFVOR1JTQ1Z0?=
 =?utf-8?Q?LtFjQGKERymhnNDyOxoCgd4QL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71508971-adaa-4cc5-6cfc-08db672ab0ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 07:42:06.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3PFu0+caAhen9gv10pSeYyj8owXXxUibKWRa9z5WD0yeO+7tmYcMBAacBaiNLLloAR7v/DAsRYft9tsO3GEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
Received-SPF: softfail client-ip=2a01:111:f400:fe59::618;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 06/06/2023 16:40, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai
>
> On 6/6/23 13:59, Avihai Horon wrote:
>>
>> On 05/06/2023 17:56, Alex Williamson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Sun, 4 Jun 2023 12:33:43 +0300
>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>
>>>> On 01/06/2023 23:22, Alex Williamson wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, 30 May 2023 17:48:20 +0300
>>>>> Avihai Horon <avihaih@nvidia.com> wrote:
>>>>>
>>>>>> Add a new VFIO device property x-allow-pre-copy to keep migration
>>>>>> compatibility to/from older QEMU versions that don't have VFIO 
>>>>>> pre-copy
>>>>>> support.
>>>>> This doesn't make sense to me, vfio migration is not currently
>>>>> supported, it can only be enabled via an experimental flag.  AFAIK we
>>>>> have no obligation to maintain migration compatibility against
>>>>> experimental features.  Is there any other reason we need a flag to
>>>>> disable pre-copy?
>>>> This could give flexibility to do migration between hosts without
>>>> matching VFIO device kernel drivers. E.g., source driver doesn't have
>>>> precopy support and dest driver has or vice versa.
>>> If these are valid scenarios, the protocol should support negotiation
>>> without requiring an experimental flag to do so.
>>
>> Thinking again, the two intree drivers we have support precopy and as 
>> you said, this is still experimental, so I assume that we can drop 
>> this patch in v6.
>
> No need to resend if there are no other changes.

I think that just the last paragraph of the commit message in patch #9 
should be removed.

Thanks.

>
>>
>>>
>>>>> OTOH, should this series finally remove the experimental migration
>>>>> flag?  Do we require Joao's vIOMMU support to finally make it
>>>>> supportable?  Is there something else?
>>>> I think that after precopy is accepted we can remove the experimental
>>>> flag, as we'll have the major parts of VFIO migration upstream.
>>>> After that we will still need to add Joao's vIOMMU support and P2P 
>>>> support.
>>>> Do you want me to add a patch to this series that makes VFIO migration
>>>> non-experimental?
>>> I'd keep it as a separate patch with a clearly described dependency on
>>> this series so that we can discuss it separately.
>>
>> Sure, so I will post it separately.
>>
>> Thanks.
>>
>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>>>> ---
>>>>>>    include/hw/vfio/vfio-common.h | 1 +
>>>>>>    hw/core/machine.c             | 1 +
>>>>>>    hw/vfio/migration.c           | 3 ++-
>>>>>>    hw/vfio/pci.c                 | 2 ++
>>>>>>    4 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h 
>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>> index 1db901c194..a53ecbe2e0 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>>>>>>        VFIOMigration *migration;
>>>>>>        Error *migration_blocker;
>>>>>>        OnOffAuto pre_copy_dirty_page_tracking;
>>>>>> +    bool allow_pre_copy;
>>>>>>        bool dirty_pages_supported;
>>>>>>        bool dirty_tracking;
>>>>>>    } VFIODevice;
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index 1000406211..64ac3fe38e 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -41,6 +41,7 @@
>>>>>>
>>>>>>    GlobalProperty hw_compat_8_0[] = {
>>>>>>        { "migration", "multifd-flush-after-each-section", "on"},
>>>>>> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>>>>>>    };
>>>>>>    const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>>>>>>
>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>> index d8f6a22ae1..cb6923ed3f 100644
>>>>>> --- a/hw/vfio/migration.c
>>>>>> +++ b/hw/vfio/migration.c
>>>>>> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice 
>>>>>> *vbasedev)
>>>>>>    {
>>>>>>        VFIOMigration *migration = vbasedev->migration;
>>>>>>
>>>>>> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>>>> +    return vbasedev->allow_pre_copy &&
>>>>>> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>>>>>>    }
>>>>>>
>>>>>>    /* 
>>>>>> ---------------------------------------------------------------------- 
>>>>>> */
>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>>> index 73874a94de..c69813af7f 100644
>>>>>> --- a/hw/vfio/pci.c
>>>>>> +++ b/hw/vfio/pci.c
>>>>>> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] = {
>>>>>> DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", 
>>>>>> VFIOPCIDevice,
>>>>>> vbasedev.pre_copy_dirty_page_tracking,
>>>>>>                                ON_OFF_AUTO_ON),
>>>>>> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
>>>>>> +                     vbasedev.allow_pre_copy, true),
>>>>>>        DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>>>>>>                                display, ON_OFF_AUTO_OFF),
>>>>>>        DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
>>
>

