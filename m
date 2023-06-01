Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690571F522
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 23:55:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qGD-0002Yc-KU; Thu, 01 Jun 2023 17:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q4qGB-0002YO-Ir
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:55:07 -0400
Received: from mail-co1nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::623]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1q4qG7-0001Ui-Vh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:55:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGJ5nUE26gPgQzot5/ywGF0Hmpj8nLyLX7yzkWQuW12VyCE774UB8+7OuI3Ltc9GS36cA84h+vvMhav0yK73GLQBK1hqZTYSlDidu2MjT8A8bj3vIFxAEj6SraawJTXjkdiJgff7q92g3r15g8bAeQkGkKSb01n4C9QXjXvx/kEEc180diRTuk0tUhEoqGgKMSVysU9laSEsotPjQbPoVOOaPuiMFj1te+zfyi9yktoiCNft6800eqicJ5Wczhq0kCGLi96CtwHfvU/0RBU94tdjojUlk48El2+/imLDNpDGZO+3hyvSryQdnyzVJvEGMdphS7O0pjMhv73ltJYwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe9J5f+L9gKNfQNztsbV/LspkVTrLYa/Vy5wknW+CuE=;
 b=NFISUTABsWDDy2twA8zKcsKyGn8qu8dTxkJrlzmD8zXDF/hnSY86E4vU3ujKvKDFXJhlS4NbtdCwm0dmtZHAhqttVL6CmnwsjAB9aQW8ifFkTDJRJH75IzPhZqnpw9AHeY+c9Ar5mLyIHTaFkClWd7MQ911xPgGGdHhURIMnU4n+hdJOFVSzs3ksjOB4BahkVzVMXij2TAe8EEoxv1dFd0Zq1B1n6Jdn8gs1C8V5D9kGExaCLBfjJqxAl+niNC3BFAsLSW6QtAcuXJbzFnR8voHhY70C1ypobdV+ooHxMYc7WrW54vPMsOAUoYrklfmhN87Iix5jKEir63YICR/YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe9J5f+L9gKNfQNztsbV/LspkVTrLYa/Vy5wknW+CuE=;
 b=BIkiRFQKBhQQSpGzrTCgf8hgmTwy/aD7XIF6HHhAdOr94cHm9pn402aftAzchhkEtzqDERu6ctl3LzGziCgTlN2O54b9DV1Ks5lkNfxkiM+8u4UDgM8p24/OhSg07zfmPKt/tK3Lc0ZaIu+usnpNB/xowXtCgfRXuylMErIayAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 21:54:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 21:54:57 +0000
Message-ID: <a82c2529-7e9f-3379-779d-4a3fcd03b16a@amd.com>
Date: Thu, 1 Jun 2023 14:54:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1024
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com, jusual@redhat.com,
 jon.grimm@amd.com, santosh.Shukla@amd.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20230531225127.331998-1-suravee.suthikulpanit@amd.com>
 <39a49814-28d8-ffc8-42b4-3af14bb9dd47@oracle.com>
 <ZHhwOrfXMjjOmcAK@redhat.com> <20230601070912-mutt-send-email-mst@kernel.org>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230601070912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BY5PR12MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: b869b953-6db2-45c6-43f1-08db62ead73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHjgBUrc8HQidmqUszzmFpXu+4Ylp1tGH/hEN0OrUw2Ll4PVVl5AlwNC9NwWqeJHFSMbvnRiEs/KO7l5awpzUGn9IVFoWcMC7n1mxZMaPzCrBwRs+INuKxwYcTf1CpZ1aNDy5vj0P5tu5GcXtAx7EOlUK6K+wAwy63snz0HfLrI/FSk9kcf6P8nzFXxGBcn+UQoeySWVELpHjkndKsBH5P6zoEaup3quAfNpJXHRdZYG0y4T0nmGu7v9geYxEbobhXZttE5FbRZWOCOYCurSlpHWbF9GDTv4LeW97mH5rYlq4Kz9lWw19Pj1y83EulyR1RxXqWtS7iGG0anc6IoNUVu09LsoVeO3mx5tAVsyi5HmsuGdaSZgRyBDZusQRdCSnY4mLpQhkzfBay9oNx8PiYlcqVUpk39ciIa+CURJ0dWokiQTLd/qVAUD8+Wxo3O7ZBT/j8y+GqISCl3BJ+PZOxUUEw03srg/2O3KueV/wK+yl82AsDygdfI4Gqecej6mmqIgpntly4Jh5hbZ42XhK51qXtxIiV2IcTl3UDgVeFThNDbkFAcUZOBimecdlUybeImwSZuRqKKICRSDMNPfBbMv5GRqkC81Jzz+u8LjK4GCGXbbb7wi/h4B/BVMOYjVhAkSGsOGptSIQZbzdn3mHf3kUhGwZw05YH4FaEr8xf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199021)(31696002)(41300700001)(6486002)(86362001)(316002)(4326008)(6666004)(36756003)(66556008)(66946007)(66476007)(7416002)(5660300002)(26005)(83380400001)(6506007)(31686004)(53546011)(54906003)(6512007)(186003)(2616005)(2906002)(478600001)(110136005)(8936002)(8676002)(38100700002)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1tRzZXUk9YU0lVQ2NndWZVWVYzN2wyWlkzRTRXZUd4alYrR3orRTBodnNZ?=
 =?utf-8?B?VHl5dlR1RTVaLzd2MGxRT0hsRWRzdEF3UmZFd2d3K0srL0kxOEZ3eWVlYjQ4?=
 =?utf-8?B?TkcwcmlHUzNrWWZheTNtQXNqTk9GbGdHeTJ2aDV6dUNnbnNkT01IWC9VKzFH?=
 =?utf-8?B?cFppcEpoYTJoNkNqVlNRdEhNTWZ1dmN2UDJhUm5nNjQyUFRsV0xvNFkzeVVk?=
 =?utf-8?B?YWdqUTdxYjB6TWNpWkZiVU9ab0FkdHJRSHk0dnhET3hTVU9aaDZyUnl3MDFS?=
 =?utf-8?B?N1VONm1CTDIva3NQeWt0ZTlIQjM2OHpFUTFPc2haL0l0SFUyU2RDZWpLRTh5?=
 =?utf-8?B?MGNTTnFPNEo5amVYRnpJVDE2UUFEUllQblVFVi9CbDVmTTgxaHFCcFhhbDVB?=
 =?utf-8?B?MGxmUGdTWXViTHYyZ0JMeVhZc3daREZLSThvUGxTZEFiRUNDL1ZPZ1l2MmUx?=
 =?utf-8?B?QmlJdmtrd3JuUTdWQTg3QXJTbVpnd09CcDN0cWtud1NQOXlrSHp6aW5CQWhm?=
 =?utf-8?B?VFlhdytZOTBHTkE5OUQzdzZYUmx4MEV2aHo0OHR5VnVEUmY0NVdsQWhMVHMy?=
 =?utf-8?B?OHU5WlRTblZFMEswWnhxRSt0R3Y2RHBwT0Rja2U4ckZqZUtnbmI5M0FERXRI?=
 =?utf-8?B?eDFndk9ScU1EZnNkc0h3Z3RiWjBxUXZ2ZG82U0xTL1ZNWWZHdWVuaXU5K0xH?=
 =?utf-8?B?RVhXUU9TWDlBOU5sOXNoRGQ0MWJnVDZ2STF5QW00WWNiWXgxck1LVUZnaXU3?=
 =?utf-8?B?V3lyek5Bd0xSWlI2UGxQaSt4b3FGckdkOEQzaWVRSnNuZW1NQUdxdUdESVdQ?=
 =?utf-8?B?ZDUyWG9tbFVKMmxJeE80Tkk2c0tuRGRoc0VRSGFoOTJLZXNpSVJEQmt5RFJy?=
 =?utf-8?B?ZjNoVE5WdzczK0F2L2cySDN0OHNqM3hVK3kyT1NrV0dJUURvWllTclJaOXpz?=
 =?utf-8?B?QnJNSUFtK0lUajlHdzZHK0VKS0dVMHNKWVhoSFg1ZW5LbjB4Z09zQjU1RkFG?=
 =?utf-8?B?L2NicDk1ZUErbU05dHBBV0NaWGdzZ2hDT1Z4V1g1Wm4vcmRkRUhEaHMraGFn?=
 =?utf-8?B?TElOaEsrdXlsWG5sTzRZaVovdEtMcWRJYW10L1g0OWlxdEh1ZEs0RW1SMmF5?=
 =?utf-8?B?ZW5MUmZBNGdCcXhVZlpqV0FsZDE4eFUvcU90ZUVHTkJZQWhUbHFHTXBEYkpH?=
 =?utf-8?B?WDZnb3VtN1BlUnVOVW8zNWpYTFQ2QkMrVTd0UGRDSzdMM0NKWkxVd2pVSEY1?=
 =?utf-8?B?aCt1cnlsU0d3YWdXQU1ySFR3dENYK0M4TVZ0K2F2L2VhdU9WRGZPdllFd3hS?=
 =?utf-8?B?RzExRlI3MHZDeXpVazFVc3Q3ZjM1R1luQnpXVjBtVEhwT2dNOXcyaUhkRzFY?=
 =?utf-8?B?KzJwMlRZbmFSZVhmc2F1aUk3bnZiaVpkY3FjdStMNkZhODFHZzRDTWswcEZR?=
 =?utf-8?B?elFrcFltK290VFZpdmRLTnJ2QVg0ajE3Z2Z2NDBybFdUaEM0U3pUWUJ6WWxW?=
 =?utf-8?B?bG1aK3lNWUZ1ZXZwMmlVY0lsOG9ONndqb21FMXJuMURtRjdRM2VwVExlbnNi?=
 =?utf-8?B?eGFET0RXZ3N1cWlWVVlSY3NvbzhvWVo5eXNBS1RoelNUeWNxMmtMeGZxVnhs?=
 =?utf-8?B?ZHZtajJvWjhOdTltYUE4TXVCMHBRV29lQWlLdEVsVSsrVFRZRDM1aXUzWm02?=
 =?utf-8?B?akZ1NEJYS00yVlprV3YrUk5MQVI4Y1VOMGQ4VUtFTlMrdzEwSDlZNHZUMGF2?=
 =?utf-8?B?N05QTUFIbW9pYXNxeVRNdzBYbzVsWVRrcnMyb3VoNjV0RXphM3l5ZVgyTkdJ?=
 =?utf-8?B?Z2ZQNUp6MlNBOUIxMEFKYkg5RTJXYXRrYjM5Vk1FQjJQSzBhU3lkL1ZYVUN3?=
 =?utf-8?B?NVFKblRISHJ3UUd0OStvRUJSTXFwd2MreGVHQnppOU83dkh6dlFTbGpjWjRP?=
 =?utf-8?B?ek5GcS9DZzR4YWRtTEJvanh0VW1wRFFzS2d6eFJnUHlhaSt6amFjdW1MWlpq?=
 =?utf-8?B?QVJVVTBaNkpDVkQ2eXROU1FPRmkxNEhpK0pVM1dGZlRHV1Y4b2l3b1prZE1z?=
 =?utf-8?B?T3hJbGZzTUM3eExudDhHMkV3OTJ2WDdLckkvcTZCZk5ySDBtaDdGSU9tV1Jz?=
 =?utf-8?Q?ohXr5AvrRkaCAKTAfq71sgOzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b869b953-6db2-45c6-43f1-08db62ead73e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 21:54:57.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSQhXXbpA4UoqqTeijLP8PHvoYeq0O713SKPW5WlO9B3n6ul1TzTW4Ed8TtpzsFBI4ETd0YquTeUF2Umty+4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
Received-SPF: softfail client-ip=2a01:111:f400:7eab::623;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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



On 6/1/2023 6:09 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 01, 2023 at 11:17:30AM +0100, Daniel P. Berrangé wrote:
>> On Thu, Jun 01, 2023 at 11:09:45AM +0100, Joao Martins wrote:
>>>
>>> On 31/05/2023 23:51, Suravee Suthikulpanit wrote:
>>>> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
>>>> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
>>>>
>>>> In case KVM could not support the specified number of vcpus, QEMU would
>>>> return the following error message:
>>>>
>>>>    qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument
>>>>
>>>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>>>> ---
>>>>
>>>> Changes from V1:
>>>> (https://lore.kernel.org/all/YnkDGsIi1vFvXmiP@redhat.com/T/)
>>>>   * Bump from 512 to KVM_MAX_VCPUS (per Igor's suggestion)
>>>>
>>>> Note:
>>>>   From the last discussion, Daniel mentioned that SMBIO 2.1 tables might
>>>>   cause overflow at approx 720 CPUs, and it might require using the
>>>>   SMBIO 3.0 entry point. Also, we might need to change the default for
>>>>   the x86 machine type to SMBIO 3.0. However, I do not know the status
>>>>   of this.
>>>>
>>> I suspect smbios 3.0 (64-bit entry point) is already supported.
>>>
>>> With current qemu and all the smbios fixes in the last cycle, perhaps this is
>>> mainly just setting smbios_entry_point_type to SMBIOS_ENTRY_POINT_TYPE_64 if
>>> MachineState::smp::max_cpus is bigger than 720 (e.g. in pc_q35_init()?)
>> >> The need for the 64-bit entry point depends on a combination of RAM 
config
>> and CPU count. IMHO we need to unconditionally switch the latest machine
>> types to use the 64-bit entry point by default, rather than trying to infer
>> some special condition to dynamically change on the fly.
> Yes, makes sense.

Thanks all for the feedback. So, IIUC, here is how the SMBIOS entry 
point types would be affected by the QEMU options:

- pc-q35-8.1 and later, default to SMBIOS EP type 64.
- pc-q35-8.0 and older, default to SMBIOS EP type 32.
- User can override the type w/ QEMU option "-M .., 
smbios-entry-point-type=[32|64]"

Please let me know if I am missing anything. If this is accurate, I'll 
send out v3 with this change.

Thanks,
Suravee



