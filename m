Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC967E6D70
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:31:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16yq-00074w-Av; Thu, 09 Nov 2023 10:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1r16yj-00070L-92
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:29:57 -0500
Received: from mail-mw2nam12on20618.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::618]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1r16ye-0002xX-UN
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:29:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxILAJHb4QGDdo43iyJcfz89yqcEIV4Y3xcOs9kitrz3dNzRFPGmfg7lATQa1RW49pvZ7zDNMxaInArbzCqPpRyupsm6jt4sWHlnMstfKmCoO9lhiFUHuPSxaaMl6jNAd8MKZxe5vLSjJDRo2xfuvdXjBSd+Ndl6bJIhEyqM6Hne2dA+fai3t0rkcaw7XDI4KcOzDWPqBikTMmPa27mHJt4MZHw6EPv+0+LWMD1BG8JRoQrSDImt36ksXHdkte1XNV958jTLts/2771TJLT3fYKJprg/ARmjrFcDjRJgRdC3wRSnOToAvrZQlXV7GZ4Q4lI5Xbht9fbAdOnCh7cusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abH2l1JZEG/pOgOn2Jq7mRxeeterOfC6hRQp+XCbqsU=;
 b=MGDmP2ZfeZAoHp3IMvgVobxro1GKNRWRSCxdEOxmHni1WZW2ZyzIfjWATSoXFlNDHy1eG3m34uyGQS3+gLoM0qAfB0Qv8Ss5brjJrB3hgwci6ckj9lsWQFIKJpAcjrcK7NitCwrKdajcfeTs4Gvv0Jl5C/S5AnLpxil6P4lCBBKNdF8VPp7gX3mJOqbX3PQj5xitAEMdE091BQZOPq2zfJM0WRxYtpb5Gbi4rUnhnElJlrL1ml34IgE77OLm4OXy8nQhcfgXISpFtFFNuLqeL9tEf4qkZRcUasDoOTvnRxFlI3l5cKa/fgMvhv3SOhljRQvoxCchnehmfj8+/gm2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abH2l1JZEG/pOgOn2Jq7mRxeeterOfC6hRQp+XCbqsU=;
 b=smqG6hXg2tXm6VQt8/mlxuJzVsR7a2KQAQOE1CXiInEIXSf4LTVp82FMrSaQ3+my2Y3WelwyTLtDWc3BG79rM25ywoGosL/oEqFInvzGyqIH6N2CEj0bm1m+xfL6CB8pEYxvR1m7fZbWZOyHx+zQbohCfV/281zBuddIuetQOYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 15:29:46 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::13ec:1cba:876:cf40]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::13ec:1cba:876:cf40%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 15:29:46 +0000
Message-ID: <626ce569-fa4f-c0e2-f187-a51b7f0d27b7@amd.com>
Date: Thu, 9 Nov 2023 20:59:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: Bui Quang Minh <minhquangbui99@gmail.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Phil Dennis-Jordan <lists@philjordan.eu>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
 <1c4cf652-9b31-4b22-8bb9-df27dce74cfd@gmail.com>
 <756919c3-13ed-4fcc-a4b2-30cd431746a4@oracle.com>
 <7a56029c-8637-4abd-a38f-7b838a059749@gmail.com>
From: Santosh Shukla <santosh.shukla@amd.com>
In-Reply-To: <7a56029c-8637-4abd-a38f-7b838a059749@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|DM6PR12MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1faafad1-004d-44a4-b3fe-08dbe138b407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVKGC5+Jsj0wz3FrUhoWHWDvhSQ8bve3H6lGqzLosCfxyZYztPVCoVbJMnjcGWxZBdy/UpUhBcsmecyXlSQCg6ujo61rPfraT822KcN1hPGolcgZDyybgDblh670iBXc5ylNb5BzpT9dgA0QbRdSqpA+gychxGDuEP+g8RKBhpzpOpxHx2BDNhDy/ycL1ncMP63AVKAk8VxOW31QpbhThbZkFikj+3ggt5CfK6wiOOWR7siW6Sb5UBr+yp0ULgEYE/4PVVUdqi098K9A7v2gKv06xvy+TQ4glBrEAhw9hv7RPaIFQa08SV77Cio2uhyrC8+IYbb3dOR3wF8Wy9djOnU7TbdkY8baOTAbctn0N1jZOa1lbFuLZ6Uffbgu9TUDadbmGjaUk5J7RXOjp7AWgNO15OtqbdHCz0jZCAib1H2fP8v9JuiNTT9lymCTFP4bo7y4eBOLypXmM8NtSb2vZjE/bs0IbszzPmeSmjZHDLgy3GNOuJTsS8mIrJQNJIXfWVOKbAHkTFwZdsaVP8bs8CUwlW8+TgNGPYbO0YHufsJavEKxjIGC0fJ3Nzb6FHauQool7Ud4n7g+AsM5kE8ZgEDg1I/+/X3y/WX0Hw8Ecr6jm2bSwA73ZkJRCHgyVgE4GLuSO+rRtjcbXr2GmFRgXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(66946007)(6486002)(66556008)(110136005)(53546011)(66476007)(6666004)(36756003)(6512007)(478600001)(86362001)(31696002)(6506007)(2616005)(54906003)(38100700002)(2906002)(83380400001)(26005)(7416002)(41300700001)(4326008)(5660300002)(316002)(8676002)(8936002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUVQbHQrU00vYUhPK0l3SzhPUTJVb1BXZjlyTlBlL081NUdDemtDbTNBRnNq?=
 =?utf-8?B?UDdQMForeW43bjd2a3FiN0xUSGtkamdkTFhzTVVaV1dQNkxocFhCS3kveU05?=
 =?utf-8?B?MzVvakxQaVRnUXBoYWo5MVJFMkwvN2JuYy8xK2wxblZoT3dGeGRjTVJ3NjY1?=
 =?utf-8?B?amUrZTU1UE5rdnVEVExjSzhQZC9VS1N6YW52Y2d4SE0xTkd5RHp2cFQ1a3Ax?=
 =?utf-8?B?eStVU0lsUDhiUmJGVnYzaU95ZUUrcVM0TittR3p1VFRQdXptbmZtNEtsa3or?=
 =?utf-8?B?S1praHAxd1BndUJ1bzN6YURYaWtqaWxYSXo1MHlueHJDa3RQSVpSYU5vWmlH?=
 =?utf-8?B?am1wMjlYemRsSmlWN29ncno0eHpKSFczUkgzUitmWXlOeWJHcmpQNlRrUEFu?=
 =?utf-8?B?NVliUzJsQTJ3V3gvQ0tIUDRGMVFUM1o3T29CVklJWFhTV2tIajF1MW9wL1J3?=
 =?utf-8?B?djI2QzlRaENhTzBpQUFUY1Nzem9KZEtnWll2ZnpMNS9SNG1HcEFHSEp0Q0Ni?=
 =?utf-8?B?RGlhYTRwUEp4SWJqQldQLzhuc1N6MWNldUgzL0hRa2F4MEh2ZkxSd2lMY0lL?=
 =?utf-8?B?M3A3SzlNdVJYZm9EdlpXNmVsL0tqa3hYK3BrZ1RqUFkwcE9NME5sdkJ3Q0gy?=
 =?utf-8?B?NGc1SXByc0U4K3UzTDQ0R0I2MVBxN1RGendUWnZPaGllc0NOZ1lqbEpqMVA2?=
 =?utf-8?B?Y21uMFNKWTNzNVVVQkhxRFZ4U0puT0xSWCt2K2p4QVdaM2FhR0t2dGpQc1hM?=
 =?utf-8?B?dFM4L2RUV3R0Z2J2enNoSm9pVURzVm5JeTNqQVJVZjlQZ1V6Mm9wdXdkUWtm?=
 =?utf-8?B?KzREK3dWZGNvNzByUFB2bzVwTkJBR2JKUkZkcm96aWRMZDJTWmdSbVNHcFp4?=
 =?utf-8?B?Z3Q2YnY2TCtXT3MxWS8zOVNuekt0ckhSNGVCOFprK2w0UWlRRnpIbHBtS3ZO?=
 =?utf-8?B?L252Q3ZyZzhNYmlTdWxIUmFoT280NFJoRi93NytlRFhwblpHY3IzaC81L1ht?=
 =?utf-8?B?YS9yc2RNYnJTUTdFVFZNSDA2Z3N2YlkyRnNLWHl6UnpKa29hUmdhZ0U5akxj?=
 =?utf-8?B?S010TEtxY3lPamlOdkN1bTliTjhEQmE4V084dWVJS21tckRBU0VGSVVFbXpl?=
 =?utf-8?B?OUtBU0pyTXBpUms3d0lkMHNNTWNmejFnQzdBakxlL0JKZ0NGdW02MWFvdjhP?=
 =?utf-8?B?dGZ3M3JFaGM2VHlhTW9TNTRYelorT3QxZUtZakVrbWZ2SHAvWTdRVFh4dGJO?=
 =?utf-8?B?d01UNkFLR3NlMFBtN3NvTVpmT2M2Y1dLU2pHTkh1aHhoREhGN2VhNHhSWUhj?=
 =?utf-8?B?M2tWOWNNT1lCeitKeENobkdKMGJINTVWN3NQaklSZHMwWW95MXBzSVM1K1dQ?=
 =?utf-8?B?MXZ6OVBOSndvTDhXTU9zYVFpVU1Ramxqc3NEcWE0TTR5ZEVQVUgvZUJWNVIx?=
 =?utf-8?B?NDA4a09keU9LZTZ5MWs0QjRVUC80S0J0dHhyWW5sM1FPS0RBZWErRWNkeWRs?=
 =?utf-8?B?dGMvcWV0cko0b2VqQWxXOUJqSktXajNxMDYxbTdGSTZ5YWxXTzRNMVZJaXpz?=
 =?utf-8?B?MFVzN1YzVUc1WEMrVTkyalZrend2WW5qQTlSdkpaSlBoTUF4M29SZnVvRjZO?=
 =?utf-8?B?NS93clVuVkZDd252SlBRbEpKWGIya0dzcWY2OW8rbXlPRExGYzlGQzJZNlF0?=
 =?utf-8?B?UVdoTTBRQ3pKZ2U2ZFRBQlNra3lMNTViL0xRbjNSTUVia2ZaMjk2M3drdnNJ?=
 =?utf-8?B?OUQ1ZG9LcTNYU201RG0rb1NVdEMvSFZKZWlxKzZsSTFHZTkwMnVLREhqWjRF?=
 =?utf-8?B?SktWZ0E2TmN5WkhCa1ZKbVUwNEVrZTlWSXBiSUVWeGxqeGVnQjFFY0hpNTNM?=
 =?utf-8?B?aUo3S2loRlRzQUUvNjZXRDdBYjk2Vy92a3MxSFp5bkhydVEzcm1kcldhaG93?=
 =?utf-8?B?N25DajdTaERtK1MxYk85RzBlNW1EVkxJQzFyN25BZnl5OTVLVlVwRE9ucWF4?=
 =?utf-8?B?T3FFUWxKY28rKzRnU1psSVZ6ajZXZFhQK3BzR1MrMXpCbTF5RXJTT0x3MnM2?=
 =?utf-8?B?ZGQzNk5wM3VqU2Rmb0poZlI3clF0c0FVekREOHpMTzVkb2xwaHI4eDdFa0lF?=
 =?utf-8?Q?zwJVfkNgjlvsFCc3kpo46ymvD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faafad1-004d-44a4-b3fe-08dbe138b407
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:29:46.1880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awt3fLTC5DNDZ6Ro6FXdk+JWs3UncQRwzPi3ZVvUKVU5WPwunxrJE7oXLe1NnCbpv/hxpqsE8uASDHXX+4Z8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::618;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.265, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/9/2023 8:12 PM, Bui Quang Minh wrote:
> On 11/9/23 21:32, Joao Martins wrote:
>> On 09/11/2023 14:10, Bui Quang Minh wrote:
>>> On 11/9/23 17:11, Santosh Shukla wrote:
>>>> On 10/24/2023 8:51 PM, Bui Quang Minh wrote:
>>>>> Hi everyone,
>>>>>
>>>>> This series implements x2APIC mode in userspace local APIC and the
>>>>> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
>>>>> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
>>>>> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
>>>>> using either Intel or AMD iommu.
>>>>>
>>>>> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
>>>>> with enabled x2APIC and can enumerate CPU with APIC ID 257
>>>>>
>>>>> Using Intel IOMMU
>>>>>
>>>>> qemu/build/qemu-system-x86_64 \
>>>>>     -smp 2,maxcpus=260 \
>>>>>     -cpu qemu64,x2apic=on \
>>>>>     -machine q35 \
>>>>>     -device intel-iommu,intremap=on,eim=on \
>>>>>     -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>>>     -m 2G \
>>>>>     -kernel $KERNEL_DIR \
>>>>>     -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>>>> net.ifnames=0" \
>>>>>     -drive file=$IMAGE_DIR,format=raw \
>>>>>     -nographic \
>>>>>     -s
>>>>>
>>>>> Using AMD IOMMU
>>>>>
>>>>> qemu/build/qemu-system-x86_64 \
>>>>>     -smp 2,maxcpus=260 \
>>>>>     -cpu qemu64,x2apic=on \
>>>>>     -machine q35 \
>>>>>     -device amd-iommu,intremap=on,xtsup=on \
>>>>>     -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>>>>>     -m 2G \
>>>>>     -kernel $KERNEL_DIR \
>>>>>     -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial
>>>>> net.ifnames=0" \
>>>>>     -drive file=$IMAGE_DIR,format=raw \
>>>>>     -nographic \
>>>>>     -s
>>>>>
>>>>> Testing the emulated userspace APIC with kvm-unit-tests, disable test
>>>>> device with this patch
>>>>>
>>>>> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
>>>>> index 1734afb..f56fe1c 100644
>>>>> --- a/lib/x86/fwcfg.c
>>>>> +++ b/lib/x86/fwcfg.c
>>>>> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
>>>>>
>>>>>           if ((str = getenv("TEST_DEVICE")))
>>>>>                   no_test_device = !atol(str);
>>>>> +       no_test_device = true;
>>>>>
>>>>>           if ((str = getenv("MEMLIMIT")))
>>>>>                   fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
>>>>>
>>>>> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
>>>>> ./run_tests.sh -v -g apic
>>>>>
>>>>> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
>>>>> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
>>>>> apic-split (54 tests, 8 unexpected failures, 1 skipped)
>>>>> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
>>>>> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
>>>>> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
>>>>> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
>>>>> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
>>>>> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
>>>>> 6 unexpected failures, 2 skipped)
>>>>>
>>>>>     FAIL: apic_disable: *0xfee00030: 50014
>>>>>     FAIL: apic_disable: *0xfee00080: f0
>>>>>     FAIL: apic_disable: *0xfee00030: 50014
>>>>>     FAIL: apic_disable: *0xfee00080: f0
>>>>>     FAIL: apicbase: relocate apic
>>>>>
>>>>> These errors are because we don't disable MMIO region when switching to
>>>>> x2APIC and don't support relocate MMIO region yet. This is a problem
>>>>> because, MMIO region is the same for all CPUs, in order to support these we
>>>>> need to figure out how to allocate and manage different MMIO regions for
>>>>> each CPUs. This can be an improvement in the future.
>>>>>
>>>>>     FAIL: nmi-after-sti
>>>>>     FAIL: multiple nmi
>>>>>
>>>>> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
>>>>>
>>>>>     FAIL: TMCCT should stay at zero
>>>>>
>>>>> This error is related to APIC timer which should be addressed in separate
>>>>> patch.
>>>>>
>>>>> Version 9 changes,
>>>>
>>>> Hi Bui,
>>>>
>>>> I have tested v9 on EPYC-Genoa system with kvm acceleration mode on, I could
>>>> see > 255 vCPU for Linux and Windows Guest.
>>>>
>>>> Tested-by: Santosh Shukla <Santosh.Shukla@amd.com>
>>>
>>> Hi Santosh,
>>>
>>> With KVM enabled, you may be using the in kernel APIC from KVM not the emulated
>>> APIC in userspace as in this series.
>>>
>>
>> Your XTSup code isn't necessarily userspace APIC specific. You can have
>> accel=kvm with split irqchip and things will still work. I suspect that's how
>> Santosh tested it.
> 
That's correct.

> Ah, I got it. Thanks Santosh, Joao.
> Quang Minh.
> 

Thanks,
Santosh


