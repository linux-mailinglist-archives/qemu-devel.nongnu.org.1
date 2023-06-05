Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B83723271
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6HzN-00048B-OB; Mon, 05 Jun 2023 17:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HzL-00045R-OP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:43:43 -0400
Received: from mail-dm3nam02on20617.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::617]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6HzJ-0002Ca-Jt
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfz1dbT9czKeWlYuARxv2vyD2i+lRs5vgTmOtyuzqvMiI5/fkM+CXInZFwRxzk5Be5QfnWeBNh4DBRG+le7sgrq7ufSu6vREfgFSWZQLjDRw2zMwRGRuUcnl1QaOCYL94JmzY3JYQBp4KzOpPqBX2oon3KozT8tVX79ha2VEuhCrzXc87bQZRdoquUNEzRn4cAbgs6baVp7cr2m5Lc+dmpVISWo1PU192iUQ/nEAtah6C0RDak7Ffy9kH1Yk2bNVRT8QTPJb3zCBFK1sas5JND6X4bh+przJXkTdlmCkIL6hLJLdOgw2T5Y4Tk7EY0RRctToGy5RsMXyBRbBDZtWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5ce0QfuEt9/4oGKY5iYXPcdmISWimClld9dyggZuro=;
 b=mHweT6ebGX6Q2Xx8QerGnqPsZ0ViE61U6T2XGEqBN+iW0Rr5W8MKaZI5JmnnpKLYf95VkjHJVUhCAdVZLKa6pHiQXTFoeDtaHvySmZTRasE+fKrp6KrJJTQsi4AhUXURgkEahqIidZPTxjy8B6Q+bNQ3ASbYVusu1MuamIdU5ZFrYM/U7CD1qB115QC1Fv2YUv1TAv47jMDvDxy9kStGJyJaXrs7uHJhQFHSb/AsPtE1GVj9OT2y3/mI1K8rXRI316o3kpWFnpo0m0b4k695Nahv4HZXaXWpBhhzxdU6MBUXkIrngRCuzokDWVSPbnqcdxvDMdo/M95vwWIYqWUOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5ce0QfuEt9/4oGKY5iYXPcdmISWimClld9dyggZuro=;
 b=dW69gm2Dfftz2OUPWUtZytOMuv7Ivr61yMZpdmmcCUCAWOs0FoR5zRJiiAwyEIF17riOdks6dZiFtKWkXBysc/WNVd1YEG6GHAr55hxJb15TOSf2UzFG6u75ogLJ9E/maA14ZRRUTMGtOXIqhmc8WSJf3VdYdKB/T0hOpvWLDIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 21:43:36 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 21:43:36 +0000
Message-ID: <c1fae386-2564-32db-499f-612c04238441@amd.com>
Date: Mon, 5 Jun 2023 14:43:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230603032255.517970-1-suravee.suthikulpanit@amd.com>
 <20230603032255.517970-2-suravee.suthikulpanit@amd.com>
 <20230604085221-mutt-send-email-mst@kernel.org>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230604085221-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: a22c5ad1-59dc-481a-0868-08db660deab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMIUTYEgqdvfrFC+LSiZocczWznlKgjxnrbCGASAvw7pXzwLW0rmav69JtimuWxJzTvQQdBsWHcdf9jXpIc2u0IXIm6i/uNzN0F1kXz7yQSk4qp6GKqG/6wvxcRNDS850RTB7WBuGRDLs+nJbCKa4M4v7gfiZSKDCoLqMkthuX6UY7qiSHf5BCJYnmLirDFY0vh0KciFy8VkBcD49Bj0t1ZKu7yheTs4vXDzzXPZVfphtw7/g6FGJaQ8msa7YnrvD+vZGDszYD51tjn2Ji0Yl1lxkMweL+NAf8TlpkkCuQLDJe/g5VW2STldJE0lT+TFWRz4gI1qtlN5mcgSniIGsNpbk3HUgsIHqZ5bGYtd077oRXZNvDBmfBgidLCk2/pTdCDPByjQCRRHsK8KMl8nleHm5114rxEUgSreq1sdu659Oz5+ku9qztWsjOl/cLN/pgJuhxPuZiRusqEo3WGwgvdxS/zjkFHlPysHSE+yfmD+w7w3V+RXh8kL9toU0ZMvtaM0zvVgONZp/jWMBDu8s+034BiI9RvBwwlTDO5b/ckP2dyngHp0eh/Ia4k65lqHQa85rRQ3Z0ggmHhGausYt1gAjsZz/WxVpCITilEETLDV5Dzm78TJ5UAa4c4jQWe4YOGD0NDZin7gWsTojpmvp590Pwjhp8zXtM99EAd5SLlu5yq/YumXcAi6ZPRCwiXo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(7416002)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(31696002)(5660300002)(6916009)(4326008)(38100700002)(86362001)(6486002)(6666004)(36756003)(2906002)(26005)(6512007)(186003)(6506007)(31686004)(53546011)(2616005)(170073001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9keVFLSVVGZ0NzQkdkZzFwUEhpWUNmUW5aWWhkakNWR0kwM3RNQ0FsL0JK?=
 =?utf-8?B?QjNxNFR0VTZhR3lYZWJQWXhHdU01cFlpN3ZjdE9XbjJkL2VHUWJYTDZqMFQ2?=
 =?utf-8?B?QVJ6R0JiaVArOVAyelVGMEpVRnFmUWt5VktrcUFVRXVlWEFmUEJIdlV0WXNL?=
 =?utf-8?B?MTRnOFJ4WkxPSVlTbkVZZ3J2Wjg2QzB2NmszOU9XNCtlZjM1Y2hmVkVDb1dV?=
 =?utf-8?B?ZDZFNVhpMUErN2g0Y0J0cWhjZjAzUXY3S2toekF4R1ZQdlpSUHdiRDFicFY5?=
 =?utf-8?B?RStqQ0cxWGgxaXNIWUhlby9pOFhrOWg0cnhhZ1R1ZGFGWlgvYk9vOUVHYTdr?=
 =?utf-8?B?S2kwRkk1TFZOdVBWWG5Ec2xoTFVyUFJPV1pRZ0xOOEZ0a0dHNWhic2xDcVBk?=
 =?utf-8?B?a0ZmQjdwL0pjRDRiK2JyazEwQ3lLbndmWTV5WXdZajE1dFFBWGs4RkMvc0dv?=
 =?utf-8?B?eWRFdG9ZKy9MeXBONXgyb0Vqd1ZmWUpubkNnckw3NCs3NmVEOGh5NklmRGtU?=
 =?utf-8?B?WkJObThHZmk3bTJzdCtrT2FqZ0VJZzR2Wkh5cm14RkZqeXFFeGNxRHZYQU1I?=
 =?utf-8?B?V2NzMXRSNGJpVCtiRXpWTlhwMVRNU3ZGR3ZiMWl6YVl5NGl0d1NsWHBCT1gy?=
 =?utf-8?B?ODBIbDQyLzcvcGNvZ2NFZExLc1dnMDFSRDRwSmZIUnNHMHJ5SjZEVURNUXJ6?=
 =?utf-8?B?OTNvVDhsR25kVXJTQ1psWC9oQkZsK0NiaWVjdml6c3FlcjVuU3diU0xXU004?=
 =?utf-8?B?Tms1ZzFrNlpqeU5LeGlCTFByeUg4NWJqdG4yUExQV0ljYkx5M3RiOXpjTEtX?=
 =?utf-8?B?V05YeUhhT2IvM3gwemlzK09yelBHUjl4dEJjVGlJTlljTDRZcGoyc1J1SlNI?=
 =?utf-8?B?M1R4MExKdDl2cHhreUNLWlZtdk5raVM0aUpVKzlDZFNmSmdscmw2WVROQWVi?=
 =?utf-8?B?WHkvek5NNHhuR1ZJWjR4OU1wbk5GRjR6NzZBOUJKVEdXRms3OExnbSt0NkdY?=
 =?utf-8?B?ZndYSk4xOFBtdmtqZW5HcnZhY09HL0NDNDlaVURBZUl2b0FKUGRxSjBPLzAw?=
 =?utf-8?B?ZVpLczF0TUFMYmdMbUNsQjdIN0tiRExOR3cwc1c3YkRhTnBXWEdNS3VCYkNI?=
 =?utf-8?B?N2p6WGR4My9Ta29BMzdSQTF2TlFaK3VPWmhDb00xeFduWHovQmRVKzlpVmlC?=
 =?utf-8?B?UmZhKzZ2cjY5NXB5WCt4RnYrY1FDWXJMb0xCcmNyeE9halhSYjZVZmlsMlNH?=
 =?utf-8?B?aXNyMllqdkFjQ2duQVQrdFBpL3cxOTZ6MGxuWkZqUnVwM2s3Q1l2blQvd3dO?=
 =?utf-8?B?K0FOaHp2NXRkL3BON2NUSGZ5b1g1dDFtVm5NKzVSYXFzd3N4cjZnVlE2Slpl?=
 =?utf-8?B?NitTQ3dFemMxSFZZUDJ5MFdQeE5tdnBoeDN6ZUhldjhqZmFCSHV5Y2Y5MEps?=
 =?utf-8?B?a2hoQVVIQW5ISHZkV25ndG1abzZaNy9zQldHNlVSbzlzU1Nkb3owK0U0c2g3?=
 =?utf-8?B?QkZqY2pjdE9HUUt0R1krY050ckJSYzZlSHV0V2ZIWE1KQWZTWlhZVU1tTzZp?=
 =?utf-8?B?aHUvSHFzcktKTHlhQWlsVGhUWm15WnE4ZkhGd211QkoxcFAzbFVlVHFHN3lB?=
 =?utf-8?B?RXlxZzJma0tpZ1E4V3NJY2RreFFJSCtta2twVFpvREpoaU5KdFoyTlN3S0tk?=
 =?utf-8?B?NHpLZ3ZEOWNTVVkwRzNJR2xtZTRMblVQREJFSjE5Z0VUSFpHUWlyWEplYzhC?=
 =?utf-8?B?SlUzdWM3bnk3MGRRMy9iODFBQWpDYTQ5ZWhvWVp5NEpWQVN0UTVsNG5xN1kv?=
 =?utf-8?B?VXp4RndIOTNzMEdCYlUwb2JoL3VsV2dabUhLSUJHSDBBdXJoTFlOMGUyYkFG?=
 =?utf-8?B?ZUsrQys5VHNFMndsRHcrbmxCbVlLSWNDWnFQNjkwdVJFeUZUNGVIaFhMT29k?=
 =?utf-8?B?b29wTlMrZThMcEhyQ1oxdmI4QzJPemhqbk42cHl0VmJYRzVCdnRKdCtjT0Rp?=
 =?utf-8?B?dm1jczk5ZXI5b0pxdUNHaTN6a1VzM25WVjRGZzhYSVBFTEdFTnVhd3NJNW5z?=
 =?utf-8?B?cmNvaDRramYvNzVzU1hieFQ2cUV5U3pnU0ZidXZBb1l2TWlEK05JYkJDWHhE?=
 =?utf-8?Q?qWZBDoAPKtI30Jr6qMRcUGeUh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22c5ad1-59dc-481a-0868-08db660deab0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 21:43:36.3210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bhnXHg6x9OAmzeF/D0t65EBEg4NZLpRdR09K45U0w7FpFicUbY01P6PHj1VhCKej7ULlMCvKcLUzgBKo6kWdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
Received-SPF: softfail client-ip=2a01:111:f400:7e83::617;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

Michael,

On 6/4/2023 7:55 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 02, 2023 at 10:22:54PM -0500, Suravee Suthikulpanit wrote:
>> ....
>>
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -199,6 +199,14 @@ static void pc_q35_init(MachineState *machine)
>>       pc_guest_info_init(pcms);
>>   
>>       if (pcmc->smbios_defaults) {
>> +        /*
>> +         * Check if user has specified command line option to override
>> +         * the default SMBIOS default entry point type.
>> +         */
>> +        if (!pcms->smbios_use_cmdline_ep_type) {
>> +            pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
>> +        }
>> +
>>           /* These values are guest ABI, do not change */
>>           smbios_set_defaults("QEMU", mc->desc,
>>                               mc->name, pcmc->smbios_legacy_mode,
>> @@ -359,6 +367,7 @@ static void pc_q35_machine_options(MachineClass *m)
>>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>       pcmc->pci_root_uid = 0;
>>       pcmc->default_cpu_version = 1;
>> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>>   
>>       m->family = "pc_q35";
>>       m->desc = "Standard PC (Q35 + ICH9, 2009)";
>> @@ -387,10 +396,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
>>   
>>   static void pc_q35_8_0_machine_options(MachineClass *m)
>>   {
>> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +
>>       pc_q35_8_1_machine_options(m);
>>       m->alias = NULL;
>>       compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
>>       compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
>> +
>> +    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
>> +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>>   }
>>   
>>   DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index c661e9cc80..f754da5a38 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -50,6 +50,7 @@ typedef struct PCMachineState {
>>       bool i8042_enabled;
>>       bool default_bus_bypass_iommu;
>>       uint64_t max_fw_size;
>> +    bool smbios_use_cmdline_ep_type;
>>   
>>       /* ACPI Memory hotplug IO base address */
>>       hwaddr memhp_io_base;
>> @@ -110,6 +111,7 @@ struct PCMachineClass {
>>       bool smbios_defaults;
>>       bool smbios_legacy_mode;
>>       bool smbios_uuid_encoded;
>> +    SmbiosEntryPointType default_smbios_ep_type;
>>   
>>       /* RAM / address space compat: */
>>       bool gigabyte_align;
> 
> 
> Can't we avoid this code duplication?
> 
> E.g. can't we use the pc_compat_8_0 machinery?

I think we can. I have just submitted v4 with some code refactoring to 
avoid duplication when set up SMBIOS defaults.

Thanks,
Suravee

