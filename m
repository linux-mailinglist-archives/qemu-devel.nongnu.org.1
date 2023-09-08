Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628637984E1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeXtx-0003lX-Qn; Fri, 08 Sep 2023 05:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qeXts-0003l0-8P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:35:42 -0400
Received: from mail-bn7nam10on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::62a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qeXto-0007s7-UU
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:35:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9F+vRgET+GnrxEdy1DLO75AtOufhO9ysFoXk3ld2+ReiIkitlAeMPLRg+jo+4HX6CwN59mZvlL+WuXCjgoP6EITZ3SuYk/Y034nGo71JfVi/A1ge/BwFJca+TRzb0AbdlxRZ67MZxIw3W92olJW1um9bzASeTssH3SpurZS0WeZJ+lIJEU6oL58a78eL+L48NJqsg6LhZNB0P5uXA9MviHhkhVtAzAfKzLg7Fzrir42L1+vvRQwOqu/JkZ6tZaMpF+28TootG7OQLxvV9CHAY63BULHiOzXmte6oreT3SgRgU0dj+r4LGyYGna+MPKljXg0gbIcmB5538m1FCZX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YO3mf6PP/nUA86I9c/zVADHPtD6LSHyFUuT6iLY+GU=;
 b=fXopRDhRVx7kGGOSruhVfweRBn3mdlTK0ri2+sudd8GlxuIo7sy9sWk97MyADablHlD6aGAYaZAgbB7Im1IYC5jjWAkfbtszWFXj54rHZLrQjRnAJcf/7ttDrWAdLqpYZNk1gG7dLT1Rgm+NqnqdGCZx8bSlqj7M/bjAqGO9a0ob5KKjY6vdKkxaIU4f8rRlPxuUlzc/VsAay6RI+w4P0QquweqOuP1JCCwwzIWnayC9/LoRFQ+jIEVB0CnhKwm4cvT3Wkypb5BBlPB1czlKWdlirAvNM9GYtoGsdMKnOrjtAggmqZUQ7UmUnY4pD8QGaBpbMmMNuGvJ1vtval8klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YO3mf6PP/nUA86I9c/zVADHPtD6LSHyFUuT6iLY+GU=;
 b=flDaZ2THwCSPKiyaguV2PgaO6z6GTuHHfhkvk1m3kFSrfR37TkB8uFcctuFp5u5PNol2zGhBfvjurMNe/3dzbriusuKVoEBd2pxxZFFR3MHKSFxrjXcFmtbr2P7IbF5QQKkJgs9a9ddIDI7IAqEmWKCrRl83J2tez/1tV/xev6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 09:35:31 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 09:35:30 +0000
Message-ID: <7984ec3f-8197-0028-d9dc-bc916c758e75@amd.com>
Date: Fri, 8 Sep 2023 11:35:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US
To: William Roche <william.roche@oracle.com>, John Allen
 <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230906205308.50334-1-john.allen@amd.com>
 <20230906205308.50334-3-john.allen@amd.com>
 <6efe4fc0-3c9a-dc91-4a04-498b38c66374@amd.com>
 <81389375-3ed7-48c1-f8d1-4eeb67a3a8e0@oracle.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <81389375-3ed7-48c1-f8d1-4eeb67a3a8e0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed819b9-8167-4a0f-d05d-08dbb04eeb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SMYtprAs8Ljjyg6p8hTDXg+Q7fEUhOAd7X3Wc7H8oh7zLXHuWp8e2iIQwltYc2pRZPVCt/ihz8jMp0Tf8rjjWvioRWLurkauDF3CNvCoVlNib8512/Q9anevWm9hZkU35UmdX3dFNFloRTqyF+dK6ngZ8k1nA0M4D6aDt2QXbMsW6Tf5DcxPznFLl3h90o21nbiJTRNHvrdHq8gQZF4k8K18+gNP1bTGGEsuPb8Qu7TiZYG86WtlmT+skhoB0V2k4FtJS0teuZritIMsE35RVpiTMFIKTlVgCIlZJwCZow3jWDrszm19Kjl2Ib5GCXJYkAnuroayYcWm0mNG5pKnxge2C3yk/aKVSF+qiN+DsTPVuQWNlIcoXi0jUMuC+2ZOXZtomlUi97i0BDSSK8GJU0CMzWncvYYKVI+geACTTQHnUxOQeoX5eVm9J+R45Rlzf4r2SEioUL8XxNaKgtYIIbCYp/dx+u+Tkidw49XLtzzjI/UArjMpiGXFuffcPp47RAxJpVKIEX98rFZpEC0vJ+ehSMjiIgaDf1Ipk0GQiwzb07lqbRfvM7UdLSMnLGbHg7SBE10rtXDhBWnjw8u3yurCYcm+CQyAdBEI5I4gkROSEzXyWuH49zd47pxfc3gXjEJ7VkMkTly26SYJBGF4R0/4dpHjE/DueNXH9/pXWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2810.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(1800799009)(186009)(451199024)(41300700001)(26005)(31696002)(478600001)(86362001)(36756003)(110136005)(66476007)(2906002)(66556008)(66946007)(6506007)(6486002)(38100700002)(6512007)(6666004)(2616005)(83380400001)(316002)(5660300002)(31686004)(8936002)(8676002)(4326008)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alE2T2M5azRkN2lLWG1HOVhpZEFTNURJcko3aDl3d3Jua2N1TlViODhLVDBM?=
 =?utf-8?B?U0c5allCWnJPMUJIZFFmWkJPNHNkL0s1NE5laTRCdVpPK01DcUZlU21kR1pX?=
 =?utf-8?B?VDkreS9iK3hNVmVHaFIyaUE0TFhEYnVHWVh6cjV2UE04bDRrN21qQi84NEUz?=
 =?utf-8?B?MkdLZkZ0MkZLRFdRa016eWZkNjBvTTEwUTU3aFBUREY0Z3ppK1Ixb3NPN0Ju?=
 =?utf-8?B?WWJxakpjQnlSZ0UxclVNaStremMxNUUxamZrTDNwV2luZ0FldEpnUm0rUHNK?=
 =?utf-8?B?S3RzTDhKOFNETUh3cWYvWWV6ekN4bTZaVWtMaVZIRzR2Nm5QTnF0dXpDckgw?=
 =?utf-8?B?NHMvaGQ3VTZ5Vk5JQ2F2clp6UFNRQjhOZGxCa1BaSHMvc1NqOE8zOGdGVEc5?=
 =?utf-8?B?THBBQ1ZxWHFvVm15YzVOKzJJUytoMmRHbzBLU1dDTVdVMFp1a3dISWNXMUky?=
 =?utf-8?B?NEFaWm1YbFRHak45WTlpWVIwc2pjUFdIOUxaWWtuTDB4a0ZRU2I2R0Uxa2pY?=
 =?utf-8?B?MHpLNzlwRkF2K3NWN0dxcmNNci92R3ZTbDhLVzJYMTcweTFsQW0xQmRuVXVh?=
 =?utf-8?B?MmxDa3hkeElod3p0VXE2eHdqbS9FT2RZTk9rZytIN0JUS0lyU2ZBNlU2OVI5?=
 =?utf-8?B?VVEzZ0ZoNjFTNkR3L2lXbTJ2MFZxcjZ0L25SOFVQSVVpcTZNemNsdWVpZlRm?=
 =?utf-8?B?dkxtdGxuOEY3a1ZUOWYzNzBXdDh6UXBVdDJNeDI5QWxWWDdRTVlrM1kzUVJB?=
 =?utf-8?B?dWwzeW1OM3NQaW0wNkhYL3pZMlJrWTYzVnZ2cUwvMUdVaWlWaWVKOUY5ZXgr?=
 =?utf-8?B?TE1ZZlFzMm5WYmx1MUJNcC8rSDlBMDdoRlJ4SXIvMUsrRklCME9ObWIzK3dM?=
 =?utf-8?B?R2hSTVhQdm1LSGhveDBURDdRa0RhWWlQTTNRekVxSy9pL1JEMU5kT2dJcXp6?=
 =?utf-8?B?V3VKa2Y1eFVCZzBhVkxuQlhCQ0RxelVZTjlsdXdvWDVJLytNblp1d1FaSFc3?=
 =?utf-8?B?TTNxRGZMbDVMdDJueDJmNXRGeG1RUFRJMGlDOTV2ZHFpZTlWemxsU0szYmhD?=
 =?utf-8?B?WHdhNWFsNlRtNmlONmE4RE0rM0pQTnBOVUJDbTFvcnl4SGFvZmVzMWZ3Q2ZG?=
 =?utf-8?B?NGEzZXR5UTVPbjIxSEpabFFKRGFTNzdKUGJJWlk1Q1NoeitWeEdCWEJKMXNG?=
 =?utf-8?B?TkM2V2ttNjhpWHk4WEIwSlhSYVRkcDJjMi91UmRUdHlCMUF3ZkZkb0tXVTVo?=
 =?utf-8?B?bW9KOXY3S0FRazJaSW5DSGc4U3pRVHF0SzJ1NWhFSWhicVBEbFJIc3VUN3JD?=
 =?utf-8?B?WWhaZlNLNHVYa3ZlUzEzSGovdUxsbi83ZHpVbzVSRVFNQkkvTUVUeHlDT1dh?=
 =?utf-8?B?SFNxbTM2WVZTcDV4NmpEL05zekozM3FtNy9sYWZwenlxOTFTYXc2U2ZTdEZL?=
 =?utf-8?B?RkNYUUVPQnNndzEvMVVEQWtIT0JDQTROYTNQVUFDTUx6RGVPUWthd2FpeU9H?=
 =?utf-8?B?dG4vNlhwSXlTbDFnSHVGVkpONjdzR0l5dWZaR1VqZVhSRWlNV2RrY1RaNHRF?=
 =?utf-8?B?dk9GOGpEQmdMZ215NzkwT1IvbUNsZW9UWVJoZjc3Wm9FdENJVU81Umdrc2I1?=
 =?utf-8?B?UVQ1aEQzZGNKdFQzS002VkNiVFZvcWdQdW92NUFuMVJQSWNiN25QMGZHY3ky?=
 =?utf-8?B?eEZRcnpYM3VpR3U1U1JqeXJybXJVVFdIS3RuUTQ1QkhpeTF2N2k3a25VdEx5?=
 =?utf-8?B?ZmdCWHFodXBocGMrdWhIMWc0RXVmckszTVdYWldteVBVVXlmd1N4VFByVWJO?=
 =?utf-8?B?SDJwWVRQd3lnS2s1K2U3NmN0cU5sa2xGMVZ0cmxiTEthZjYycFhnWElvRWtw?=
 =?utf-8?B?dysyVnE2cEsxQnMrOVFMc3Z0bDVCNjI3WUVrZ2ptT0ZWV1Nuc3ZTSHBwRG1G?=
 =?utf-8?B?Z3FFMGtDNnY0aWJLN0tlWlhWSitHNnRXbDFhVEM5SzZCdGJaajJ0T3VIWnZL?=
 =?utf-8?B?RlNROG9kbWg2Q1hNVkpJcnlSdUJyZU1FUGphb1lsZWU5N1dvV29Vd2NkMFRo?=
 =?utf-8?B?dEh4VlFBcFZhdEU2RlZ3ZndRRzdRUzNHaWRGYWdNWjh6L2JjUWVsMkM0WFdj?=
 =?utf-8?Q?rNdly/bDZTvH+49PbjXgQ/AHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed819b9-8167-4a0f-d05d-08dbb04eeb34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:35:30.4095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W2OCxnIeaIMPFDq6StwcuLRVMat/rgSp8zm1jiRQqPMWRDeHq2WmwPfe23aHTomV78Z+omeaaNIrFQf4zio4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::62a;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
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


>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index 5fce74aac5..4d42d3ed4c 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr 
>>> paddr, int code)
>>>               mcg_status |= MCG_STATUS_RIPV;
>>>           }
>>>       } else {
>>> +        if (code == BUS_MCEERR_AO) {
>>> +            /* XXX we don't support BUS_MCEERR_AO injection on AMD 
>>> yet */
>>> +            return;
>>> +        }
>>>           mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>>>       }
>>> @@ -655,7 +659,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int 
>>> code, void *addr)
>>>           if (ram_addr != RAM_ADDR_INVALID &&
>>>               kvm_physical_memory_addr_from_host(c->kvm_state, addr, 
>>> &paddr)) {
>>>               kvm_hwpoison_page_add(ram_addr);
>>> -            kvm_mce_inject(cpu, paddr, code);
>>> +            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO) {
>>
>> Isn't the 'optional' case we already handle inside kvm_mce_inject()?
>> So this check seems repetitive to me.
> 
> You are right, it is repetitive, but can be considered as a reminder of 
> the situation and an explanation of the "ignored on AMD guest" message 
> later in this function.
> 
> Of course it can be removed if you think that the code is easier to read 
> without it. When the AMD BUS_MCEERR_AO support is integrated, both 
> locations would need to be cleared, but this sounds reasonable to me.

Yes, I think it helps to read the code better and less conditional.

Thanks,
Pankaj

> 
> John, it's up to you.
> 
> William.


