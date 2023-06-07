Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A21725181
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 03:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6hvS-0002xu-EL; Tue, 06 Jun 2023 21:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6hvQ-0002xL-6k
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:25:24 -0400
Received: from mail-dm6nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::609]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6hvO-0003qf-1h
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwH2AUoAt8I0UbGibK2x6kgVJi3unmoxwnodOyysLuKBS4BM+dZlwygB/YOP8SyzJZ9qTW1pRZJy2/D9UpoGFFNyJ8h6UEhnCBXEthY2odpNxf4tW6Lafmi2NfCcoOA18fBiujTr2dqlIlDEEuCzGfN4qppO1LgxrzfjLsDv+xEqn5tHnk4Rp6dqmy8YtqWs61mdZn2DBfkqonWuPve6cm+T+9Qww5R0zz1dbJYTqPHSKBm08a+j1LCwsXixItlHgCASZIYQdaoSoghJjSDTaRVINZD46Rm1iuCyr9THn6svWYt2SDsyfTIiRbikmPU2WE+SRMSn++ncXoL+pnEe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBXKiJ7ScHaDS8ImD45VWiAh44N/HFLwWUfkoVU3mxY=;
 b=Dmvm/1H1LRZkUBj0GRbqR6sxM/ywS1LliUbkZndz+swaW+HwL33b8EZgg25KdIOwy3vPrw+M/V5sWeNYXJQ60fE4aJz1GfYIGKC8w9uIdO3EYOUOWlYMMWXEkCH+6r2XfZ9GLpPMpYkqzpgpU6kYUcIekbyapikEo2TIdx4dKYILZHGrsIqJ6AQLzYT4CIvAvSRphjdYu0fepxjcphkNQUuKqrSoR1ptH8ZQ0jHHXVQoEbpyUjWWGMBUcmx35X+AxFcZlQiD/czpU8+ZBwsU04FH8A2wjFjbNrilC0jmHGGloFIBcGTYNKPzXz2021HFmEbvn0vMEwsdrPeW4yY9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBXKiJ7ScHaDS8ImD45VWiAh44N/HFLwWUfkoVU3mxY=;
 b=1/xtwgJuC5pAWeXFFps6B94fWZDk0iAggu8JDVCRp5BNeth87ZD6JlpHpuvbrDP/qStpRwemBZcvsSuzox6Eu/JXE2SCN0EjCn+6Xsq25rWGsqxpaiKmBJnF1nOSN2WO55y3d9/QN9ljioyTHLbrQDo1VS4CnrpWCmqJfVKioys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 01:25:16 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 01:25:16 +0000
Message-ID: <ec4ce89b-1619-7195-52b6-4e63879a96ad@amd.com>
Date: Tue, 6 Jun 2023 18:25:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
 <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::25) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5851ea-284f-49b6-e567-08db66f60c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ka0XJ5B/WoAJaQPvt4I16BknFxqD5ALhrtbIGG+RyNsFdYgQ3Mxf3UsIMcUZ/AsvE/lXPjCtl2rS1h3SH3FbYIx5avAIRZ95bhDuyfGEHpyiP+bIjBT37jc/G5Ym0l21inTPWXGooguaRHbFNWu8TJXNJWD58humQw/fpxyuCzDGCFC5umf9HWhBJ79MICNynd1dC16Sfmmgr8erpiKt42mMGykNxr9e5zwAKaiqIZHo52Y92UW+O2XzDEvjOkLGZ/9g9KOIU3s+S4HAkCJPNrkOWqsOHrDe/QZMwhT8IMSU+dD97TPaAwGjecjIqdb9fnPBTfBpOhzz9dai+lF0N8XKQINnzixs5hbfz3zbQH1kt6h1fzDn337DagWY5S7RxxjVrn0WuoumMS2QyGFhTXVNzBnaXxEjxx1iB8WmSyTFXkK/OlLKO9wgP0FHpoDrW/n/bjH7lJXRz2WsSiwE+tmadqs5iy7oktzSogR2C5OH0o+XjjnvvZUZ5thVKbtKVFlfDkbSBI9rDBz+XiNniLAI1/3Nhxcyoorrx84zcYTmOZ8rhV3tgaHV1dVX/TpKKBtiGTnI0LnfYTdjtB4sYEEq+c82p/jm+gjRATpE5IQSTH5nx4HYIIoh4XG/Gv9Gy7LQw5VvC1mSUfWboH4FKw7hTCQFqx4MSR+zbI7GEcg4qhZhApiQQ1pYQNcOCK1+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(8936002)(8676002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(170073001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZpd1prQ1dicFZLSGNxdGZVOXBHeVB6eFRWRXozdjVDcHU2QzR4UVBWaGt2?=
 =?utf-8?B?d1d0OEpCUWlrTUREeXhCMUpXUWF0bTdXdy9vUms5NVNMMkY2T0labmVLVmFx?=
 =?utf-8?B?VUtwVlNjcGxZbEROeVBncVNXYmlmNFdVZnFQbGVwSnpIQ0hRVWt2QjJuY29h?=
 =?utf-8?B?UWNsUkhKaytZTkw2YXhFTjk5bXZjSmNnZHVDdGtaaDZuRTRrLzk1bUhkbzg2?=
 =?utf-8?B?c2RHMm9UVkdYZjlBM2s0ODNjc21xWWd2MTdnVy9WUXQ0TmZQMGdiRFNJbmZF?=
 =?utf-8?B?ZFNhR1VEa3FxdVJTNjRBSitqWTE4NFJMa1BKNHRsa0o5UjFXVklweE9JdFRy?=
 =?utf-8?B?UTZPZFZuOXJLUXNNc0xPSGFvakJBZ1pNbjc3eGdLb0hEREZsOE5hcnkyR0xo?=
 =?utf-8?B?STFXTW9TanFQSTRRVVY3NGZ1VW9IRE9ldFJibFo4UElBWEFsYUVxQW9JL1Uw?=
 =?utf-8?B?YkNCVTNQVFdMelQrUURYRGM3WTdtaERRVVozZGhsTjJkR3dKVEdzb080dzgx?=
 =?utf-8?B?V3pNNVhlUWV5cjJlNEt4VHRlYU5WbVJaT0YrMUxlSzNqMm5GTTdya0JxWVQz?=
 =?utf-8?B?RnZzVk5HZ2ZwRnBaRmlNeURlTWpwOXU2V0hYU3ZyL1JMbkRFakxJWjkxTWdz?=
 =?utf-8?B?SkpJOFhDbExoZlRTdkhNUk1sSk95SU9ZV3o4d2I1a3pVdklwTDI5WVl2aTlU?=
 =?utf-8?B?TnlFOGlFL3ZGUzdzd3RlOGttc2ZwMll3U3BHL0c2anE0YTluSFdKelBteWl5?=
 =?utf-8?B?eUwxT0dPaGxCRENnenl6UXRJKzQyN1BJVTd3cVpBNlVrSC83elFoWjVsOGt6?=
 =?utf-8?B?YWpaUlpGV212dittdWJiZ0lveEI0eU0xY00zME5XOG54R1VyZGpSRXh3aTBN?=
 =?utf-8?B?T25YUFZTa3J1RlpBK3Z0SHAwNkRNUE54S01ZUmlmK0REOFNvbjJJWDVtYnBP?=
 =?utf-8?B?c2FGOTZWcWt2aWp5MWZSRmhjQXhVUUo0YTFoWENzU1NPU2lqS05WMmREYjRG?=
 =?utf-8?B?ZFR0aWhqQjFPNkZlYzlFbDBPN2gxZEhlc2czSFRMVEU3bUk4M2JHcDdSSTVk?=
 =?utf-8?B?MUJPdHdITlU4QThCM1dlekIyUlgxUnEwRWdKeVVxb2JNRGQ2MVpZTk1UZ0pY?=
 =?utf-8?B?SENHUkJ2MzQrUzdXcys0RUJlelQ2NHhHdVFiam1malYrbnZzOE9zZkJnWmFR?=
 =?utf-8?B?aE9aQkZqb3ZhTkRUbHlySjdDN2I3VytGZm9tdHpZWUtXVnM0MFZwdTJvQjVQ?=
 =?utf-8?B?QURwUXI4d2Y2WTJUSlkxVFVWbVM0RWhTVjc1TjhOTVcwcHlRbFhVMy9GSEsv?=
 =?utf-8?B?cTltRmdpUUMrZ1E1a0hkbW1XcW5wMWx5TjV2YWVreU1yWVIvc3oxRUdPdWoy?=
 =?utf-8?B?MDFsNStXdE5PRnBKd09YNUpjL2loaER6RnlQbEtIQXVXM2FRak0zeTg5NURt?=
 =?utf-8?B?L05HMjNUZWZCVWRZWDJiUTh5VkxvVXp0NlRhSHoxd0hWZytvSnNDaEFIQ1R4?=
 =?utf-8?B?elRERTFQVDQzTnNERnpmUDgveU1ORFdMZzVVaXJHbi9yRks3Y0JyS3l2alpV?=
 =?utf-8?B?cmtmM0dhaVpzV0J5bHh1M2pHQXUrRzJZdU8rNE9yeEVBRHVXV2tIbUVLT1Br?=
 =?utf-8?B?VW9zNitPblBZczlBRFROS0J2V284d2tqRlNoRXl3RmpRalR0cGp1WDM2SEpK?=
 =?utf-8?B?a2pFdjFaNUdMQW9ZRFFxWE01RWVOcHJGTWRjRWNHMGc1S1ZMMEdnczhSZ3ZY?=
 =?utf-8?B?ZkszOExyb01GMVpuR1VKUDg5RmlycFhCM0k4NlpJWHFKWkV1T08rcTN0R0Z0?=
 =?utf-8?B?T29yZTFLY05sVEM4RzdSbjRoZHI2K3BsWkJwVmdNUHREQzBnQWlra0JwTEpj?=
 =?utf-8?B?c09XMlBqa1FTRm10a251MUNlU1ZLUDJiaVFFaE5KYnhKVTBTNlh6Y3J1SXY5?=
 =?utf-8?B?QnFDQ01QWjIyT0xqSU90SHhPdnAwSnFETG1SeGlQOVptZFdkbWdzbUhRNVh3?=
 =?utf-8?B?LzYzbTlHaXQ1VXZFc1VJeGxQdmh6TGtMQmpSaXlTVmY0R2FmcWR1akFtYkhM?=
 =?utf-8?B?NDdLSEVwdlNNMHFPQVdDak5lc1BkM1B4RzBPZHJaSTFzWnN3TzdrTS83MmI5?=
 =?utf-8?Q?v9H4PqyrPrhId+j/QFPCd2Zmn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5851ea-284f-49b6-e567-08db66f60c6d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 01:25:16.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fld7Oq4NWqfQRBn0r3+sYt9uAbNsh3fXhissVTflkVnUHMI4RicnrJXMC+QE4oMeabflBTI87RDH+0RpYLPBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
Received-SPF: softfail client-ip=2a01:111:f400:7e88::609;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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



On 6/6/2023 2:35 PM, Igor Mammedov wrote:
> On Mon, 5 Jun 2023 16:39:05 -0500
> Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>  wrote:
> 
>> Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
>> (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
>> supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
>> models. This is necessary to avoid the following message when launching
>> a VM with large number of vcpus.
>>
>>     "SMBIOS 2.1 table length 66822 exceeds 65535"
>>
>> Note that user can still override the entry point tyme w/ QEMU option
>> "-M ..., smbios-entry-point-type=[32|64].
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> ---
>>   hw/i386/pc.c         | 14 +++++++++++++-
>>   hw/i386/pc_piix.c    |  5 +++++
>>   hw/i386/pc_q35.c     |  5 +++++
>>   include/hw/i386/pc.h |  2 ++
>>   4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 8fc34f5454..5a87b82185 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -786,6 +786,14 @@ void pc_machine_done(Notifier *notifier, void *data)
>>           if (pcmc->smbios_defaults) {
>>               MachineClass *mc = MACHINE_GET_CLASS(pcms);
>>   
>> +            /*
>> +             * Check if user has specified a command line option
>> +             * to override the SMBIOS default entry point type.
>> +             */
>> +            if (!pcms->smbios_use_cmdline_ep_type) {
>> +                pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
>> +            }
> why pcms->smbios_entry_point_type that we already have is not enough
> we need to add extra pcms->smbios_use_cmdline_ep_type field?

I'll get rid of this in V5.

Suravee


