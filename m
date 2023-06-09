Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352C72A070
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fCQ-00078M-G9; Fri, 09 Jun 2023 12:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7fCG-000781-D5
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:42:44 -0400
Received: from mail-mw2nam12on20630.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::630]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q7fCC-00064J-VD
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 12:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLM6A1h7YHEIHsyLlVgU/RQ2+uovM1bqCN/l2H80Dm2plMfEZLjLhcbQueW1qQuSlAederrGEqF65mFFbtk+k3u/8KvPNlHvrGCf0UXKCP2aWPI0b84xQoGGv9XQIAN4vE8/MQm7t3SWP9L26Lu6UZuX930U7SBwf3JUaHw1NmpadS3JRT+78kgfFHa7hUOgMLCuBecb8AnfNUJ+5RdYB3WlRtdImSByMBk8ccBL6r8opcCsXv5yGintpFtQhJJjZrwF3Ho4ifhZ+74Le+WyQB5WsdsjlJB/DNygdyqeyQjwgx+OVCmXMT9bss7eq13uugr+5n1x7mbu/vDIAmGAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUbwUWoimGJz+z2ZAMvO/BkXEQTWVfAoj2tJuCDkDCo=;
 b=bjgRkDs3eb5CG5P5jLjb1giHujDubCwQ2pvl4NK2ZludHomV7gJl0QSF+NqM+ENCREqM2B3Y+e5Dnn6LgaPEF/YVSlHNhpcCipeB8HayaaWhMIASVUlJbuE2praQ+4UGENb4xlhTe8C/shrGqssvPrLS1/BmfQ52nECNWGNs8KPMGoMG0MB9rjLgWhhm+YE+0GrAqzKAVmfhW75m5qrkSvJCDdX2jpQY7XIrs7X0VxF88LwOzFXd4w7252bsjJ1tNShPb3Am2Uro25YaDsj1g48FHrkG0wqgrqnXHvlbvRebnjgyX23aUlRS9KTUtpc5RdEgB5QOx5MJvPYcosUiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUbwUWoimGJz+z2ZAMvO/BkXEQTWVfAoj2tJuCDkDCo=;
 b=ZVO9bnTt3qIzmKLbTBNh7h4oZYpJHJbT1VBV5QM0qooPaWFjiVaRSqI7xyJqGfL+yTX/YxjShaxNXihGOG1dYGkwZhbsEabijiqFFphNjxIbR5KE0AMx0wdd7mbAcxqg66TMm7nVaX7yzKu5gkf5VLWfXtYGHOJsZLt1/OgyUE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Fri, 9 Jun 2023 16:42:23 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 16:42:23 +0000
Message-ID: <9cee57bb-18ef-f8d4-6d2c-3c888ad6bca0@amd.com>
Date: Fri, 9 Jun 2023 09:42:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v6 1/2] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607205717.737749-1-suravee.suthikulpanit@amd.com>
 <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
 <20230608104057.4c0ac74b@imammedo.users.ipa.redhat.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230608104057.4c0ac74b@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM8PR12MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fccd6a4-8fdf-41ae-9d02-08db69087fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3mqLj3xMaw7yEUa5c88QPQn6UgV1qdp3CNsRhhA5kwhnlI94CRboPvS50i/5UESrLdB67RBLu9v23h5xuOiNtjwRoz8Hbb0rW14k5AR07q08Zss2ciChTUXRLxBWrD99pixAt0Ri5L9JmSVEzczvymxqlhSWl1j7uJtVGacltNNHjGjDmiv+APtF//ly/5pj1dYnxZgk6BwnSKupp5wS4aCRCNUyJAn7JlmXU0bjnB/VXSJPUT/qRU+9zhxsk67q6w1RhpNXGglRHhDU2mWT72BMKEEeUUzfTHpIc121LOKJHCnGrvgYEvVSlNCTg1Ne8aUnXkqDgm/0qQJcYJHaMAWB5D7dcahtam2jOmlOAAjry5Sutb8sbWaAYp7Smjtaz1KflrUiwVndz2OCPplgrcnVf2UFOjbeipBwvrxCmHZI+GL7sPa8xWND4ZlndEzn48uEPEZ9BhWc6lyCgvvFD14KdOoQ7Htb3E9vvoKzgrfsiq/fnE4UE4Mi2JGADLYN1t2hzmvo3Uiv7terlc33c26o7UZh3e1Gwp/3ziueRooAAL6Q/o1qAjLQ01mZpg7z2RMSlMMvlUmwEKO5+Vw8QcgfJJpL0Fj+3/70vOYKVmJRaC1qZNiajaKUjofLrEcemTmW/HmrMOft4DD0fYkcxF+mr2CUY5A/xh1u7/M6EC3adDsGOryRc+SdUiJ933O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(86362001)(83380400001)(66476007)(38100700002)(4326008)(66946007)(66556008)(6916009)(6666004)(6486002)(478600001)(186003)(36756003)(8676002)(5660300002)(8936002)(41300700001)(2616005)(31696002)(2906002)(316002)(31686004)(7416002)(53546011)(6512007)(6506007)(26005)(170073001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXJ1MkRGdHNzeWk3bkZEWDV5Q0E4OXhlOHdxRENCQTRvY1NqelJDaVFxemx6?=
 =?utf-8?B?RjlpaStHL0RyWlBuMm1OZHlSem4xQWdvUzFZQ205WnhoUUYyLzZTTStVZmk3?=
 =?utf-8?B?R01KVE8vanV6OUI2cnQwRWRNVkJmSzZMU0FvVGYwMTFWaUZ3c0xvblNJeG9z?=
 =?utf-8?B?bjIrc2pxOUNoUTBpVElveUh5ZDFjNHBtdG5yNVE3bDJSN3R4Ym9rQlhJT2ty?=
 =?utf-8?B?dEUrK1ZPYlVPb2I3TUxZbmtMd3lVL2FMcWdGYkdkNlBkRXlLSDlpa0s5ekxs?=
 =?utf-8?B?aHpyc3dRQXZTUFY0bTZJVjY5RnFoSDFVeVZWaEFoSW1zMXV0VjlXZTkyRkdW?=
 =?utf-8?B?TU9IL25PY1h1Zk5Pa21FYnJvaGU4STVuQVRjMzlua1NaMktxSnpsc3lFUE82?=
 =?utf-8?B?c1lXN0JkRkZwM29oM3hOR2oxbU1odnpLbTRTMTdPMElTVE96U0tIUVdXOWY4?=
 =?utf-8?B?V0M5QWtjVTlKOUZxMksxUytrMVVPYkhUcWtnQUlTWk5sVVhDMEZ6R0dlMGhY?=
 =?utf-8?B?VmdORDhPYkkzUVFlYkRyQ0xKZXNNKytHU3pkcjBSNkZWVURpSnpuL01DeEtD?=
 =?utf-8?B?ZmVrUVVQZU1hS3FaRE9xa1Y1WGZkaThXMVk1TGZVdG5nOUs5SmdRV3pEakIr?=
 =?utf-8?B?M0w4MUdWSUxhRzdyUm8vb0lzNWI0MllJV1NQZzNsWHNUSFV4RHdienZOVHNR?=
 =?utf-8?B?S1ZTQUUrZTNCWXFRenhHYnFQSERmNk1SczQ4L1Q0UGRPMm1QbWw2ZkMvMmhV?=
 =?utf-8?B?TnZMZDNuclZSOVdYcTloWmN0dmt6VGpRMGp0T1hETDJuNzFzS0hlY3FOOHQv?=
 =?utf-8?B?MWRzMWRVcGtmUUpNYktQeWlMZGV3ZkhyTklYUFU3bzg5bmlJRDhJQkdlOVMz?=
 =?utf-8?B?bkU2ckQ1TkQyTDk5ajJJL1ErOWdhTEFzbHlISUNkK1dRK1RLVkUyWnFmT2ZI?=
 =?utf-8?B?SDFYVFY2NTRVZWtSejMxSVZaWjVqSDgrNndGOVphRTk3Z3BaRWJHS3MwYno3?=
 =?utf-8?B?R1JnU2M0cVhoN2FsSlJzbXgwNHdJMkpjZTJ5K29CQW1mZi9Kb0pSbk5vNGpj?=
 =?utf-8?B?N2RCV1pKWFN6T2JZQUg5VEJZa1ZtWVdkQmZiOGF6aGZicFdIaU5IQUUvakxI?=
 =?utf-8?B?ZXlnd05DTGNQSWNDYnZBL0FLNDZMNFoxaS91N2hWMkJtWHJteU0wVEYzRERY?=
 =?utf-8?B?R1NsWEs4TnhEajFyNmZhMjhZSnJpcHg0RFI2WjBPcXYvS0RRTEFkR3JvcVVR?=
 =?utf-8?B?dTlVU295aXphQ1hOeWhSbCtDLzhmZEttak1ITkI2RFBaNHZ0SXVuODFvTE9M?=
 =?utf-8?B?dlpqb3BQY1RFeXZ0OXI4d1Nzb0lCS0NaR3RISlFpMDRZYWE3NHlEb1VraHU0?=
 =?utf-8?B?ODQ0KzhCT2YzZW8yR3VydXN3ai9yYlppejk5SzR2dzZRcmp6U21DT0YyVS9v?=
 =?utf-8?B?cXArays2RVVkRDV0R1JFM2NQa3llT0JGMjFyVjFCQmMyeDRvYjJzbnhyejRM?=
 =?utf-8?B?N1YvZ0JkOHBzeVFsVURBY09EcmU3anFycWs2QmNLVEJ0L0JqbGFwZkZVbGNN?=
 =?utf-8?B?ZlZZQ1A2K21oZTYwckFCZm5EVm1YRHhLd3hpRHJXNTBXZi9kaWtwODAvVVpt?=
 =?utf-8?B?RTl2V0NQOWJiYnZKb2F0S1VQSXZHN3pVcnNqRC9lWnJTU204amswZys0Nm5t?=
 =?utf-8?B?WmRwNTMxQXZXY096WEV6VWUrNDBDbUdLaGh3Z3c5TllPYmR6R3pMaVJ4YmEv?=
 =?utf-8?B?cjFTaGVqL3Qxa1pGcEtkclMzYldZbDZzbGF5K3JYVm1MK29aQnpxOUhiTWxL?=
 =?utf-8?B?SDhBZ2dOc3Z4NVFzVmVadnR6cENuT3lodWFlNWM5dHIwTlliSmFHQ1IvOVZ2?=
 =?utf-8?B?ZHhtL3JHK1JYMWdVRjlnTDJFMU40VXhEa3dqekNocC9Uc0xWZGpONXBPcUVC?=
 =?utf-8?B?RlVOdTV1a3ByR2J4MUNHWjExVU1DVXAzemlaSzBaSkNqelg3ODk3TVlYRlpQ?=
 =?utf-8?B?WFVacHJEYU1DbGdUcXZlaFBoc1RVOEppUmJJcjAzNFFIWUVCc1VzajBiaWlY?=
 =?utf-8?B?YVdySE8yMnh3TU1ESWk5ZDdUU2Z6ZXlhYXkreXRXVEJOOGJrWURQRFpSRm1Q?=
 =?utf-8?Q?wjw+Pab+L4PG0oV0NkLUyvj0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fccd6a4-8fdf-41ae-9d02-08db69087fda
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:42:23.0814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeIf3uippByEFn8GJp0sYxehJxlhOG7x6vNGtkzcAumP+PzW2JGuqeJb0tAKFEQCTQzet9YswyLw2D1+0mBKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::630;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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



On 6/8/2023 3:40 PM, Igor Mammedov wrote:
> On Wed, 7 Jun 2023 15:57:16 -0500
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
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> Looks good to me (see comment below for extra cleanup possibility):
> 
> Reviewed-by: Igor Mammedov<imammedo@redhat.com>
> 
>> ---
>>   hw/i386/pc.c         | 4 +++-
>>   hw/i386/pc_piix.c    | 5 +++++
>>   hw/i386/pc_q35.c     | 5 +++++
>>   include/hw/i386/pc.h | 1 +
>>   4 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bb62c994fa..33ffb03a32 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1853,6 +1853,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
>>   static void pc_machine_initfn(Object *obj)
>>   {
>>       PCMachineState *pcms = PC_MACHINE(obj);
>> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> since you introduce this local,
> I suggest you to post an extra clean up patch on top of this series
> 
> here is a line to cleanup with 'pcmc'
> 
>      /* acpi build is enabled by default if machine supports it */
>      pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;

Sure just sent out the "[PATCH] hw/i386/pc: Clean up pc_machine_initfn".

Thanks,
Suravee

