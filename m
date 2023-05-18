Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D412707AC8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 09:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzY1q-0004Lq-L9; Thu, 18 May 2023 03:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzY1o-0004Lc-9M
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:26:24 -0400
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62a]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1pzY1m-0000om-1j
 for qemu-devel@nongnu.org; Thu, 18 May 2023 03:26:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGyrRKvGXunOR/zvbtzmazD/wS9RbtCkzBQ8C3v3+GaDPlSIRnBJZWoNsHiGT9Of9cXIVAyKNKZTBC/RGK1/Jh2lSMTWYH+araaFND5XmEDA4DJ1TsSNoFMDZ5jlipEoiuLeNeDgmHsWBKLOIOQJynyMQLY130RGlrNNICHIBdusZJ/XgmlXc9b7feRd1IYwrh1gF6E1F4tHd5PmKjWi5FM9FU3fSXS6DQ2aiCar1BKRj5iab+BPYj7fTYEsQE/xuolKNuQZSdV6VyEXAEkZVqegBuxl+rcqLG2JcIQjzKePwauJoJ2eE24bczzKIGiL2lieO4eIEoAQj2hciH9WuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm7FTmBfnMcIctCDSenzCbv2SULhhgd3DOLETJWNAJs=;
 b=dTqs9vdLdfRse4g0tDrW5zeNizR7NeyJwYAePa4YSIA1CMBGbmwzI0XGjV/++OsyT98cOWf7nR9nTH+bZQwkjqQDj87daCH9q/kYPhTdBpcmsNtfPD78/KWefaOhyZq0yKdvHuqRdJKVZkQTGp5w9xNvBiZDUW4qWKZpoJ/onJlwdL2lGu1BI65nK169hWq9U7zpM2ZVwbGCpQe/rqs5HkTA+Bye2A6w5VDrTOlumLcv95EXKhDktqXLfl2LYqRf+YxRzUnvpz7wWlede3+9aBiw5UA3J9vsE2JZ3jJ08zqj+1jB4+3yhxO58kREE5yvLmLNX40QYdxdIteYPedvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm7FTmBfnMcIctCDSenzCbv2SULhhgd3DOLETJWNAJs=;
 b=AShpzp3uYSUKQ1gMhNgC296CoDmj2VzdZlj6RZp8pXhX8/jDd7iG8MrUHIFoNLCTJ1QcjW6mLxAQZH7A2W+PDeP4LwxukOU9LaMiQIOcE09wVRrjfxwfQlWRgHClmHzMPuYt7ZtzYKPh/TIHDcNwNipM0Dn13d3jFWAa11Ix+t/k9zjWEMVLxmiuRnWqvqG+bvmWI8HpYTeIrO/pBaD2rlcEBSr1YAF9lHcfTBn6BEdb3s4T/3dVnDe+QjtcUgsR8jFqj99E3qWGajjzPK1grae5UfwOEYxo1QO2rGXMDQPgnBQT/Jo+ADOM3Ye938zzNrPKNCAHG8MXd4aIjpVkJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.25; Thu, 18 May
 2023 07:26:16 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::a29a:c3cf:5edf:9dad%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 07:26:15 +0000
Message-ID: <bd2bf4eb-2f3d-83ce-609a-9b48a592d88e@nvidia.com>
Date: Thu, 18 May 2023 10:26:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/7] migration: Enable precopy initial data capability
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-4-avihaih@nvidia.com> <ZGT72DLNTevauf9N@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZGT72DLNTevauf9N@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dffef7-259b-4372-21b8-08db57712a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqgAP//i25HFV249PKekKPHhT8j/CtWVbKk1TPmL5CsubtKT1CDJkFFhmW+nhWi77zttrLOAgIMsFQngg2RfAEM0LtT29ZcloiU33igzmckSkWlhEUn3/8+tD5h6vsj9qFtnp6x0FcGy99ScslxJRKlFVTWt7+pf3+qZBzxnfSrCWMh8kOe/L7BOTTR8XylAeK0xpLG3D7GMGp3zcwDlRskZONO+Ehx5ZcXHOSogBK6QSPePY07ELW9Wq057RSE9uCZzknPuKsyOBlxA4nGuyF0NlaXGZCR1N8C1tWGQLZfFMsXmHW74gBaIi6rmwzz2eOGWwK4gnjMvIkXVnlxLAidObf6HweM20EHQerVnY+tBudfa2qBopI8DYGVJva/TGjV29WyUzHMnB8z8a+nlfjH7cMB3dH4lrnzMWxcCJIZYs9Ru91/+MoxP6WbWE13/O5FInkAD5zQ5FFH001pg239w3DmJepRU0BYfid5OTmt60+//MZUzpd+nURiEMMq3wLyQYR+7tYKBbYI18o+kCxxS1gF/MVqkLo53tFUYvfnn0nboxWhnUu5mM9KR9XX/oQFZtIWZz4a6kvW3OqfTEBIRybGFtvwVDlcWasbN1zNR2gohiEynHWJr8jN5/bP/6vIwFSG6J517e0we+r5u2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(86362001)(36756003)(4326008)(6916009)(6486002)(54906003)(66946007)(66556008)(478600001)(66476007)(316002)(38100700002)(41300700001)(5660300002)(7416002)(8676002)(2906002)(31696002)(8936002)(6666004)(186003)(53546011)(2616005)(83380400001)(26005)(6512007)(6506007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmFoSGVGQ2lRMlNiZUJyVmFWaE42VVVPbXdwSERSSDVFVm44Q2U3V2ZFemJX?=
 =?utf-8?B?VkRvb0l2NGVXNXlBK1BMNlI1VEtwdDhDNUp0ME5pb2RkTjhrTG5JT1RBOUh3?=
 =?utf-8?B?SGZYQ21nako2aWs2RFJrdC9TWUpER3hicnJXaVFVMklYTTBXSnZ0aVNSNTRQ?=
 =?utf-8?B?Q1gvUTllT3dwbTQ3aXEzUkZBQXpLc1NreWZUN1dTWFpvUjZrdjh0dUEzNS8y?=
 =?utf-8?B?Y0x3VjdZYUlXSlhWT2g1aFJmS2EvOGxWTks1ZmJVTnRiVWZvekx4SXR5RnF5?=
 =?utf-8?B?QU5tNExoK3B6RDUwNm5GQmJlTnRSeFNTR2w1ZldITFFSelFTR2dQaVhZcGRP?=
 =?utf-8?B?VHNpcHBSa0NrVDF2em1sV2RMcTUwUitEdjU4dVFTckRFbUNkY3U3Y3B3NUVz?=
 =?utf-8?B?RnRwVjZqTWZjR1NJbkRrdksxMm9obHVVSTFvNFBIQnFoN2dEU2lMWkRXU2w0?=
 =?utf-8?B?UVFiV2E1NUhYRE1LVk9zcCs5ak5KVmtZd3liM3RUMUVRbWNYaGhBMHExOU9M?=
 =?utf-8?B?dW5yK0lRMm4vemN5ZHRqcFNoOEUwTDRyb0VOcmN0VVRZREp4ZjRBRldjeWNJ?=
 =?utf-8?B?L0UyK3JZZGJCZjNuSVIzN1lIdnI5elBoNWIvczYyNWczUFIvSmp0SHYyQlVh?=
 =?utf-8?B?Yis1Z1FDSW1neUNmRWtpYWxBNWtCMFZub2hxdEs0ektVRnVLMnNqekdSNWlF?=
 =?utf-8?B?K2EwdDRJTTR3NHlrZFJ0SDYydUZ6R040Y3cwWWZNT05ZcVVaRkxqSFdWWndZ?=
 =?utf-8?B?d2I3Y0RFYjlCaG95NU1pQWNuU1dQbnV3Y2Z5S1o4VDh0QzNlaVk0MUNxTVBM?=
 =?utf-8?B?UThxSTZSTEZtSkRhQzJ5SXVlaHl4M1FBK1FLTVgvenZJUE1VS1RaMXVSQlVC?=
 =?utf-8?B?cVFVWVF3TWlsRHZ5Z1ZzQTlqUzQyZ0lxekxSNGl5UHQ5ZXBPcTZhR3V4L1Vm?=
 =?utf-8?B?djNGNFEyM1hVbVpWaVpSUEMyeDRZaDA0UjVpaGZiZHNocXFMYysrdll6NmtS?=
 =?utf-8?B?T2FHNTlmdTlGdmpRb3RCVDQ1K2hHVnU0b3ZJWlM2cVI2OFlJcExvMVpOSE5R?=
 =?utf-8?B?b2FYVGdJaEJPTTJqSkZKdTJNaFlna255SzZ4SVRUN0xiWjl3TUkxUzlMd3V4?=
 =?utf-8?B?ZGVRSmVUL3d3V0dReEVYSy8raitielN2T2dESVIwa2ExeXRnMGNKRERHdmVQ?=
 =?utf-8?B?dDV6bWJjcVhQenRGZTBFdEZlNFpYck5Wd20xeDg3UUpQWkppYWJ2a3lYeXdy?=
 =?utf-8?B?OExpM29rOGxNU3RGNFc1NDR0aTlMRUlsMjdNMVRZN1dnMDFHS2hWeXRKWXR4?=
 =?utf-8?B?aUkxRFI4L2IrNjA5SnU1dlkwRjVXS21NK2dyY3BDaWl3UTlCUE4xNVlBUkU3?=
 =?utf-8?B?T1c3alFqS2gxMTNQTjJwZFdaVlBjOUJGcjVqeVQzM3ZRM0JNSzR1QmJkZjFW?=
 =?utf-8?B?UVBDRWQ1TW1qVWh6YnY4Qzlnbk9GbksyTWlNeVNEUzZMUjQyeG9YT1NIMFky?=
 =?utf-8?B?L0t2RFJUaWhCSHQ3SGVnbU5RanpPUHlIWXJidHVnQUVYM0tWN1V4VHBObS9k?=
 =?utf-8?B?SklwTy9nZ3k4djc0TGZRWU9rbVpIbjJtSkMvRmFFL0tOdngwMFhZMTlMc0lv?=
 =?utf-8?B?ZzllQXh5aFhkNllleWg2NC9RVERlZjJsWnk3L2FLbm5CT1BBVDZHRzE2OTlK?=
 =?utf-8?B?SmJCOTdSZWVJUmNBUWg5bU9iQzMzODdEcmIvSlk2cU5uRjZ6eVFTK2JsTit6?=
 =?utf-8?B?Z01yYTNybmpzb3N2YTg3cDZkZjdha1FvRm8yTXhyL1Q4UEsyT2J6UGhRWEJS?=
 =?utf-8?B?VTlBT3NIUTJocGhsMytPekJjVFlNOEpsckcxSkNZaUpDZG5HalExWHNCSDQz?=
 =?utf-8?B?WWFtaW5wUjNlOE1QS29nT2VHcloveDFkMkRkT0JCdGY1THRWVmx0WXltL00z?=
 =?utf-8?B?ZjhyMnJCdiszdzdnakt0SkROQXVobDZ1d2tDajhySjUwRUl5Q0FzTjdwU0Fx?=
 =?utf-8?B?V2FtZUFQY3lLRXR6VzROTStWTlc5amU2Sk0yc2VYZFdJR0ZXOFJmR05QSmUy?=
 =?utf-8?B?Z2hMRGFKVlUrd09DSGRhYS9JOURWdG9HUmx4VXdGMVRmRmZ4YzZ5TjBWaXkz?=
 =?utf-8?Q?l6U+eaw8qgRbtOrew3gytU2vd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dffef7-259b-4372-21b8-08db57712a0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:26:15.8362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOeHZfPWw0Gq+EgwAnxxBbzqx6Ntmrov9WnkoiTQmTvj4qYgciTDf5vJCQIG+fwGApWslRZ4vhVbS/1+A+4dJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::62a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 17/05/2023 19:07, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, May 17, 2023 at 06:52:15PM +0300, Avihai Horon wrote:
>> Now that precopy initial data logic has been implemented, enable the
>> capability.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/options.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/migration/options.c b/migration/options.c
>> index 0a31921a7a..3449ce4f14 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -561,10 +561,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>                                "capability 'return-path'");
>>               return false;
>>           }
>> -
>> -        /* Disable this capability until it's implemented */
>> -        error_setg(errp, "'precopy-initial-data' is not implemented yet");
>> -        return false;
>>       }
> I'm always confused why we need this and not having this squashed into
> patch 1 (or say, never have these lines).
>
> The only thing it matters is when someone backports patch 1 but not
> backport the rest of the patches.  But that's really, really weird already
> as a backporter doing that, and I doubt its happening.
>
> Neither should we merge patch 1 without merging follow up patches to
> master, as we should just always merge the whole feature or just keep
> reworking on the list.
>
> I'd like to know if I missed something else..

There are also git bisect considerations.
This practice is useful for git bisect for features that are enabled by 
default, so you won't mistakenly run "half a feature" if you do bisect.
But here the capability must be manually enabled, so maybe it's not that 
useful in this case.

I like it for the sake of good order, so this capability can't be 
enabled before it's fully implemented (even if it's unlikely that 
someone would do that).

>
> PS: sorry to be late on replying to your email for previous version due to
> travelling last week, I'll reply to your series instead.  Actually I was
> just writting up the reply to your previous version when receiving this
> one. :)

No worries, thanks :)


