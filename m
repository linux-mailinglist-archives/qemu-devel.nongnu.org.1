Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5705872517E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 03:25:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6huE-00010N-U9; Tue, 06 Jun 2023 21:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6huC-0000zg-PD
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:24:08 -0400
Received: from mail-dm6nam10on20613.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::613]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q6hu7-0003WY-D8
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 21:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+2GF3ewzUe2SvXn/2dtOnk3gRytuJwwwuX2SRc4AuqqzouW0aRY8i7p5q2FYrbug5HXXMZ1tS1UlXbGr5tFUwO4+TJtrGxUxffwceCdxX3yvQj5tj5/kCxGEa9VLrfjuPe4S2g2/Cz7qCj9bTicW1Jve8HI3EYurIEiXwbvKsOFGYRdM5oG0Wb3nNNtI3SdauE0cXd7AAa+XT5HJfcbKDvGbrjoi9dQwuEeTiEs1tD3tQNUHTiCSoHhzE+OYmWHIMp0H9Ey9IRc02H53Ml886fOrHhAmSgK7E1HajS3g85Ftk10zBm3Jf0Kqz0aq34Wx2BTh8b2gHe0pMIP60waAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKSIjHu0SQgOwO0JATFs+iT3rEr6Qioqinsg7MBikn8=;
 b=b4jvdTbuMb3dLG6WOxJ6wPShDBF9UStC1IOvgGWVRO6w0J/on5OlfmoRHbUZd3OEpy3szNUBLOT+pBuR3WB3cIiFbQoIKUwb9+sDovAmhJQuUw/8U9Iki/pI9q7UqA3hU5uo9TBAxdGWIIY2pKB/mfLnXMEtHnQfBHuiAf06qsZDNaPF5Rg+3qRkMWxWGBUBI2zGE7fdlg5sNOb6Mx3baBrw+8IElKX75RE9D+1/Yr9JOFYf2ADtwXUmA8QrkOtTQJqxF8mE76W3aaynMlyL3m4seTcdu/OGYm05EVWouto6uM/q6Zr7YfZUww1a5o26W/Hez3NAMd9XPorvF9Y53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKSIjHu0SQgOwO0JATFs+iT3rEr6Qioqinsg7MBikn8=;
 b=lW2Fs4/VXpjEl/XJjXUoVKjIun6zK0UEAQcJJ9B5fyQa8LotuJTPZLKuagSig/c/TDZ/9qQa4900GN4+q7LLkokwVEJ8tpuIiyXBFwq4mXdnbO0SlYQ5i7bN2nH6n8+iLtCb4QJMpspyMAxIV1SEAlHA6peFt1FGKYmlHQD4Wlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 01:23:26 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 01:23:26 +0000
Message-ID: <050ed1cd-a5fa-3d58-ca5d-6ab3eee736dd@amd.com>
Date: Tue, 6 Jun 2023 18:23:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/3] hw/i386/pc: Refactor logic to set SMBIOS set
 defaults
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-2-suravee.suthikulpanit@amd.com>
 <20230606094519.75a38aa5@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230606094519.75a38aa5@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cbf04a-9dc1-453a-b919-08db66f5cb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTNT6+LIdxZepeRExWjzwbs5uSHfbW435Xuzj5c8XCVmRRiU85Woi4Q17i2UKOo1J8j6HCF8Z41QL2/O0dabvqQI3XMk3yqQYYHZpSDqfWTWTtZVh30Iraaxtgx9kGj5K7LHMIpVbQ/1r//GoPPGDl+rbZ271QzDyYPAn8lFoGWYl8Jcu7SejfXFfx8r9S97RUohMuStM9oFC9wWTB+WTx+wGgRNuKIEzjmE8d8hhZrYUwAG0EGdhd3G1WAoXLvsEJGBpuob22p1EWAEkZew5Chu5DjYnaiRLWxV4Nizp6vlW8ffqnQ7fcChZicrley2F3/VMUQjgoK2zZeXhB3r+PdHtxUEM694f4bSxYk1nif0LhmubEVfmzoO89WCGX02hH70Dfo4RYmseQ1eydFSLT9gj4SCpb6sGlfu8mOr7M7cTYp55tj3ZtFzEmiZ5FrT2jUUjz4xRKKT7qPL8Rm7yea4tsq2IhwfnrAIDWwDNwOhrJvpG7rjlfHhTJghKrud8VRSroo+Sa27yLDt7poyJv+j41iBnX2KhIV+UuShdQQ2grdq0HjCRjS92bXNQPZVjSl/YqkQITH2gr2y0GZhxM7a9wSYe3lujEwC0XFkUwaq4u5zfIZ5F9sviJgIAvwf56vpVZmEGPI0CMKjWKdX0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(83380400001)(2906002)(2616005)(31696002)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(8936002)(8676002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(7416002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFLaWhhRjZOYmtpM1cyWlU5cWE0c0QwbDVkMytxWEhHUk03Q1ZIdzJPcTI3?=
 =?utf-8?B?UFpVSWFyOHArS2x0RzZ0NnFLeUlxQTZHK3V2RXJ0c2lhMGI3ejR5ZXZKdytE?=
 =?utf-8?B?bWVST3VkMG04T084YU9YR1lzZ1grMThzb0RnS0hTdTlEcU9CSDhWTU5lT21Y?=
 =?utf-8?B?WG5RUHkrbExYREdyWWEwd2lZMmN3OXBXM1N6RXNLWDFsSnVoMGpvTE5qb2cv?=
 =?utf-8?B?Ti9nY3JKNlBNYVo5QVY5WHBGOFkvbkRkMlpVUEhkdFlvbmVERXc4U0xiV2xp?=
 =?utf-8?B?ZGYxZTltaCtFalNuSWhEUjlkREVRQnVCcDNlQ1ZtYnJFZThDL2wrenJsK1p3?=
 =?utf-8?B?c0doRGpjK2VBcFZJKzFpczVRc0pSSVhwU1A1Y3dndE5FaUdKd3UwVHoxZHF4?=
 =?utf-8?B?aStERnZCUjZCVFZpajJtR2RJbE1YczkrVFVTdHFjWWZLZys4OFEzeFpic3ZC?=
 =?utf-8?B?amg1SlFIaWpJRzUyWXU5ZCs0dnBxWkV4QnpicC9mcUFON2ZtZW1ZdkZlakJ0?=
 =?utf-8?B?bXQ3a0J5UnBRWStCY1daRWkxRkVYTWJEa1pUUDlaNlJiTGtNdmNreStJVFhL?=
 =?utf-8?B?ejhrdmxHVWtRdmFuZ2FENnBUWFAvM2xLTXQvOGlwemRlVExlZWtlTFRDMlRH?=
 =?utf-8?B?SUcrV3VCYkJsWnhob090THpBdEdDclZZNmZxSUlET3BwSDBZYSt5L2tDSVpE?=
 =?utf-8?B?ZWFMakJHalo1U28xQnpkUmdyaXZrb2VPZzBLVm5OVm02cWs1KzJYRHg4dXpS?=
 =?utf-8?B?QUVadkZkRGZzc0Q5ZmtnK2NyQWphckhGTnFuVEo2dXRiVkVBNldha1BvWHpt?=
 =?utf-8?B?ZDZzSTFZZFd2NlgvdUVhNDR0NnlZYXc1ZGZYN3QxVWRzZGx1UzBLN0JXZnlG?=
 =?utf-8?B?NTVkT3hrTGZpeGZUcE5kbkJwdGhRZmVaaE8xMjZRK0diWmUvaG9YcUx5VDVX?=
 =?utf-8?B?VlYwOW1EakJGN3diTHZjZWZDR1V0bW8rQ2xSR1F5ODVWT3VCc3J0blhmMHR2?=
 =?utf-8?B?M2V1ZTNYWWtCVzVSNHNla2I5cWg3K3dxVzVMMVpoVkI4MFJnbmFIQnlJTEdr?=
 =?utf-8?B?L3Z1Z283a3JUSzAxTjlrLzhibDMvSTRrTE5OUVB0cjR5eHdDN2E5emVHSlFQ?=
 =?utf-8?B?Z1Y0eFVQUThhQzY5KzN2ZURxRnlnVE94d1o3c1lhUEJVK1lGSXVHVWRaaHBR?=
 =?utf-8?B?amxDRWZhUnd3c0NuV0F5ekFBWThIRi9va1VDUWh2T1JHeFNzVHpQbFNhY01I?=
 =?utf-8?B?K1pETFhOZy9STnpTQkRTL200YThTUURkOWx3NElOc3llOHB3NzUvTDcwMHZF?=
 =?utf-8?B?eGpUcUlKUDkyOUtSOWY5Vzh2YVphTnFuR2krcmErZU1JZU1OdEovR1ZHMXhw?=
 =?utf-8?B?bmNOVlF6SXZUWVBOZlB5SUpxU09CUkx3VWc0SEo1ODlWZUJBUkhyQ1FxNHlN?=
 =?utf-8?B?OERDSmRzWUFQSkJHUFQzZzhOREpBa1FaVlUyYTlaZXg3L0VIREFqdk8xNE8y?=
 =?utf-8?B?OWV2ak5JR29XVzlKSUROYU82MG1jSmkwWExzYUsrYXQ2UXk1ZldIaGx0Vmhl?=
 =?utf-8?B?eVozWmluOFI3bndjWUQ4UVd4RHJMTUxrQjhENi9YWEM3R3IyaG5UOG40VEk3?=
 =?utf-8?B?Wm5neVZ6bEtXMWVxczliTlFiRjRjbkxvd2NDWXNJUlJia0VPN29FY0t0UEhs?=
 =?utf-8?B?b2lkYXYzNm1XVXBJTFd3eUZaTlNxcFR1VDZRSStxMVhxOStlMDBtSFhOYWFW?=
 =?utf-8?B?R1lGeTRIc3k0d0oxMVViZiszTEE0bU15d0g1eEo2cEhYd01RVTl0OGwvaFZm?=
 =?utf-8?B?TGhaS1ZJMDhFc1VsM3dIVFFWWG83MW1WalkzMUswS1B1MVlXSjZFQjVxMXpz?=
 =?utf-8?B?ZlRnQkNsMU5KdWtkcXd5OW44cWM4OG95S1ZyREVNR2ZCMy80NlRDRzN3WE1T?=
 =?utf-8?B?OHlkck5VSklDZG5aTFVRa1hiZzJ1YWtTOVlxV1F1Wk9LYmR3WFlEUTVsWXFB?=
 =?utf-8?B?YWM2WmdvMVZBTERzaHp0L3lsaVFZNUVGbW1lV1pGVy9UYUk1RW5Cakw2UjBD?=
 =?utf-8?B?UDNwYmhJK0lsWHdkWnA3RkttbytpVmhsVS9oYWZqRHRPQTlvdDFMdW4rM3Fy?=
 =?utf-8?Q?g76r3XGqF1g0wNhPMComoCayj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cbf04a-9dc1-453a-b919-08db66f5cb46
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 01:23:26.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5a++djLjMK7tU/3rlYX3McKM9h1kC9BCcOXBROiECnAxtOK2Tip8lhe9qnScQiHBI6tpYDZlea/6CWdF+j9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
Received-SPF: softfail client-ip=2a01:111:f400:7e88::613;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 NICE_REPLY_A=-0.094, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Igore,

On 6/6/2023 2:45 PM, Igor Mammedov wrote:
> On Mon, 5 Jun 2023 16:39:04 -0500
> Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>  wrote:
> 
>> In preparation for subsequent code to upgrade default SMBIOS
>> entry point type. There is no functional change.
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> ---
>>   hw/i386/pc.c      | 12 ++++++++++++
>>   hw/i386/pc_piix.c |  9 ---------
>>   hw/i386/pc_q35.c  |  8 --------
>>   3 files changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bb62c994fa..8fc34f5454 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -781,6 +781,18 @@ void pc_machine_done(Notifier *notifier, void *data)
>>   
>>       acpi_setup();
>>       if (x86ms->fw_cfg) {
>> +        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>> +
>> +        if (pcmc->smbios_defaults) {
>> +            MachineClass *mc = MACHINE_GET_CLASS(pcms);
>> +
>> +            /* These values are guest ABI, do not change */
>> +            smbios_set_defaults("QEMU", mc->desc,
>> +                                mc->name, pcmc->smbios_legacy_mode,
>> +                                pcmc->smbios_uuid_encoded,
>> +                                pcms->smbios_entry_point_type);
>> +        }
>>
> well, pc_machine_done() is the hack for the last minute changes to
> board that can't done earlier otherwise (during machine_initfn time).
> So I'd prefer not adding anything there unless we have to.

Originally, I put it here because pc_machine_set_smbios_ep() is called 
between the pc_machine_init_fn() and pc_machine_done().


In this case, I'll move this code to the end of pc_machine_init_fn(). 
Then, I can call smbios_set_defaults() from pc_machine_set_smbios_ep() 
to override the previously set defaults.

Thanks,
Suravee

