Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3A7A9891
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNn7-0006J3-O0; Thu, 21 Sep 2023 13:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Yazen.Ghannam@amd.com>)
 id 1qjNlx-000678-59
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:47:29 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com
 ([40.107.223.64] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Yazen.Ghannam@amd.com>)
 id 1qjNlf-0001Cv-3P
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:47:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/RMTJwWYhBltF9uQY7cKvngrhkhkqcG8mCRaKCTzvIYpO+cc/Zbpw+ewKqDjcJFKaCozWYhCEfxGS6QKglYZFBHHhWm7KPKUuc/H29agcZbWY9jQ4bZazODKIPY6ieCrqDjKBdFTJc61CC+jphmmctPZxBZn4qnrA0PpYzaB1iV7Bwmz4pUo5JNytZL1U28UxHWwMQSSdIV+mQ/T3ZEvxaPwCqJdgeJy/cOc71eAJkxn3cLcmbmMwExnczXJQOnnZHdSsoJk0g0ZunaBvu1qNyJ9JCaCfeVThVnk6N+YX7AR1B0wcElwFxx0zOOszfQGvvPczMbuzwE6N8dfI+sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlZLTURWdr05B9bWP/ET9laWtTxFizJkmyDuKlJPtag=;
 b=BsA9OVMqqmUO+BaE+w1mRvUyHKcjzR2aP/XuTpZP6+xwHVjU1a7s99IUaHOCZIMw7wau80GfYiN+CZCd9dVamtihzlRFD28fYkK+ixYsCk/4ALbcNuUweCAWbsCPPVVT1L0MBlc9kQtEtMtKSDl3Gzqm8ElJhTw+Dk8HljPG9BWzs3FOjCYnPCjQihRCsThl7UBZ8iGRtrzm6T8wsNwKhGmqyS8xT6YAzAY2FNYFVvjh6W+KBQtjhXlcrJCzlzaaMZzVFGVhgWqSwxKSmJm0GO7WTE7p/iJqCg0f02O/oA7UgU6j3YvVCanKwkf/cn+Y4j9jmDWJwg5g9aJzpneTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZLTURWdr05B9bWP/ET9laWtTxFizJkmyDuKlJPtag=;
 b=A20aZvSHnKz1Kv6v+9ljtwToxEDmSlZWUBYyrEKNq0KM8WD/iJ8TBNt6/GO3hqybHWrmd1klqSp/r0UdbP+0i6jCZzBHVeOin7L8HN31m2DMC2Rj+aMAaxZqOdyWJ7xNwXxJ0Hq01ASVBpDmIcaLyD31PXMAuvyJP+sRnsqokFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 17:42:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 17:42:02 +0000
Message-ID: <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
Date: Thu, 21 Sep 2023 13:41:59 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
To: Joao Martins <joao.m.martins@oracle.com>,
 William Roche <william.roche@oracle.com>, John Allen <john.allen@amd.com>,
 qemu-devel@nongnu.org
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
 <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:408:f5::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb5001a-69a5-4ca9-5231-08dbbaca0ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1/nfoM+GxOXVxTlud8Aia1Gal/bdmOKc/mXi8NPwr+MGKIjJ3ORTpcnJXKYELlJg5bKxhf23iNMaA3ZwW/bIXSslml1ofy/lyqsb7izBJ+uEDaXmjP6he9K3vmrLqibTvF4VFEJBLovYRuPyBNH5DSTqsyAsF4ikTRAKceHTGMv9QKh5kHLAxpdKkI1EF2Ps9CxveGEiTpq/8KGjcpUfdjK8VBADLrz4774CmybCp9Lbg2MpAbqUhARqW9rYabacg9xP9M6vY3yWGOXRbJgsgVxJmIJ7I3xSz6mRmnOcZHrO9V8Z9gBjgeZrxZYfzZrJWxdhv1KqkV9rlGeKC1c5oauh7AfiDxhPdtuz+0JsTpKf8gFpNOKCYwWMHnED3IMIhMXBq/5lg4x7+Ci3KR6RB9xY7ndODxres8XSbV/0Z8seS1JZxHCniXYVjqGz5mEwNtAOnIQsqt5ukA90iXhd5zLGarXFkXvzyNvZb4UKSNxc34B206nuPgdeHPcA6VNQCLNn61d8LoK7G9tOvgDHpPUBIH4hN/g7UiwbJQIpPL69KHHW34+OnroyuUVV/mWK+Xy2JWBXQKLHAdlKAjsimyh/Ik+5SzkUbcYbz5JbFDs14IpGKISsksClAH9IKahGeIwx29lHW4GYJUjPjn9IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(53546011)(6506007)(6486002)(31686004)(86362001)(66476007)(41300700001)(110136005)(66946007)(478600001)(316002)(66556008)(31696002)(38100700002)(8936002)(4326008)(8676002)(36756003)(26005)(66899024)(44832011)(5660300002)(2906002)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStISmRLYlI0NjJIbzVCZlhDNzhxU3BleE5JYXJHWkJpZUNYQnUxVWs4Q1Z4?=
 =?utf-8?B?YUdlUk10OU1tZkdpK3VJaEJDaVZVSjUxZlpCWElPZlNldGd6Q3J5OFMyeVhB?=
 =?utf-8?B?T0MyRVNhUGV0a2RYdWpLNjh1MFVmRVVYNzVrYmlocCt4aTN3NExwTlp0T05Z?=
 =?utf-8?B?aUswWU1PRXlreGFwRXVDYk1uWUZFVWUyTTZSaGE3Z083Rzg1a2tFT1hUcmZW?=
 =?utf-8?B?ZTcvSFFjdkZQdUR6azlRTG9vNmxnRDFQUjFZcTNEKzRYUEZ0dmdLWWhyZlpQ?=
 =?utf-8?B?ZHhpYVNoT1ZxYW5la0kzL2NDbDJnRUZKZ1dtZGVzcUxwQ0xqU1pEVmYyV1k2?=
 =?utf-8?B?OUtlbmFTZE5mZmo2V0YvVTNXRWE1N2V0RThKaGhJUWcyeXJiUzdxYlNGNXRt?=
 =?utf-8?B?c3ZEbzZEVDRFMTQ5L3pNSW4rMjZlVTB0NkNDdDVpU2dnS0NCYkpLRHZwd0RM?=
 =?utf-8?B?NTIzL3c1dGtibGZETU1QMjQxNmFWREpXYjIzTWVGTDRBMlBUTHE2dFA3VUpV?=
 =?utf-8?B?M2dxMWhrS1VRby8wUS9mWVE2d0E5ZFNjVHlFdGlXRzc0MzBGUVh0OUNUUW41?=
 =?utf-8?B?MkdqN0FsK0h4K1RLMUFmTUw1SmJiTFBsRU9MVDZFRkhVdXI2aG5hK1c4aGZR?=
 =?utf-8?B?V2M1aHVwakY2Zi9QQ3Z1TDgza0dhNmpPL1IyMDVLL2xFYUpJT0s4SXU4TmM4?=
 =?utf-8?B?aUd3Z1N4Z3VEYmptWHdST2F0NmtUOWRpN1MvR2FwSEs3emYzK0JtV2ZvMFEw?=
 =?utf-8?B?ZWp5eFM0TDFqTnZzUzlnZHlmOFlwbWNMZ2hqUktFUG9zeStmb1pqd3U1R0ZN?=
 =?utf-8?B?cC9GazBzaWJadnVnNFFHbU8vNkZVVGJwT1NQbEtoSmJ0UnppOTRSMW40Vmo5?=
 =?utf-8?B?OGkrcVVLclR2YTJxT2N0REk3OXBaaTd4aTN3eTFGcWNWcmdJNmNRNHFhOXhY?=
 =?utf-8?B?TnNKaTZHbWtjZkRwaTZXd1lWQkUycHJPUWtDQUlqbUtiMnVQWjBmTFQrQnJG?=
 =?utf-8?B?Z01MR2VkbDRyamZkWDZNenJXS0pPNGxMN3dxVEt2MzFvQlNqcURmbGhMQ2Jx?=
 =?utf-8?B?SkduNmFFbjAreWRCUDVvdjlibmlveUhaTVlGd3g0RGRnRzZGQURzQWtCM05y?=
 =?utf-8?B?YkVOd2JSZHZLVG5ZMTRBdDdNNmN2TzdNT2dEeWExbjJDL3BuZ05hdFk3ZUlL?=
 =?utf-8?B?ZHVKRUFkQzJEOGVTU09UbkNvOU84enk5RmhTVXJINnFzMGFORDlhLzdXK3gv?=
 =?utf-8?B?TjlyeklmSk1TeFNGRjNSWnFSZWs5NThJS3VaVWNKZG9DSm1rc3lLOEFYK3RS?=
 =?utf-8?B?WFIxeHY4bWhTUjRWUzYxU3lvT1A1MjJsSm10aTlVd0VSSkp1dHRtWDRjcTcw?=
 =?utf-8?B?Nm15UzlRSUdRRllKcTRmK3JjUElGUGhGWHZhY0pDTGxUMVlkdFdoTXphTldW?=
 =?utf-8?B?NUViQzVKdElvSFlrcTlyMTJhSWZtV2NMK3FzQ0xDSFJGTFZsaXp6NGJFZzk5?=
 =?utf-8?B?WEhqUzBnWGVEN3lWVGtvUmxoZmR5eUlvVXkxSHVGWTB1NWNJUVFETktrYzlE?=
 =?utf-8?B?QVB2TFhidng2SDZYRlJuTUpFNW03WU4vZG0yd2ZKVWllM3Y1dHZ3RUg4bFZp?=
 =?utf-8?B?MlF1bWNhTC9FeDVDSUpTVGtrWll5NVVwelFQdmdRV05Zb2RGVmhZa2xZNnda?=
 =?utf-8?B?SkhzZ093bGdCRUx3M2NPVkQvNEhiT3FaTUhtck56TTIwTGRSRko0Q1dKYTcz?=
 =?utf-8?B?MTZWc0VVK2FWNjVZMWxjRzhGaGhLUjJSRDA0RndwVWNsTy9Jc1VXMzA2N0Rq?=
 =?utf-8?B?WXhZSmV0SVRFYVZ3VUJJWlVoU2JZU21HUExCT3pERS9CbHRra282SXBnVzhW?=
 =?utf-8?B?VnFGb2dBVUpXbDhVclMzQmJNTlM3aGdkM3ROT1pnQ3REZ2ZkQk9mSmpzSHJG?=
 =?utf-8?B?K2psK2NsdGVXSWRJYXZwVkUxVlQrbEZ6bUpOYU03RGZOOTl5MTRkWUlhVEk4?=
 =?utf-8?B?VGhmVnNhMDFGTk92QjNqdHVhcmtBckhFcEsvYWFXRlhDc0tSNDhpOXp2MDBW?=
 =?utf-8?B?L2dzYURSZmJXOGN5VUxKdS9yYkpaMFFGM1N6WC9ZYUJwaGF3cmRYTEhmRUZl?=
 =?utf-8?Q?w/SJ3C96txwjpp6e8Ev3XFtW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb5001a-69a5-4ca9-5231-08dbbaca0ff7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 17:42:01.9407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAb/TgdTNJYJJqkxJgBYqwuyoEbx5oVCjydhCGzlq5a92uarWWEWKMtTJZ/oy4FOaO0350Xo50JRP183lJfs8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
Received-SPF: softfail client-ip=40.107.223.64;
 envelope-from=Yazen.Ghannam@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:48:37 -0400
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

On 9/20/23 7:13 AM, Joao Martins wrote:
> On 18/09/2023 23:00, William Roche wrote:
>> Hi John,
>>
>> I'd like to put the emphasis on the fact that ignoring the SRAO error
>> for a VM is a real problem at least for a specific (rare) case I'm
>> currently working on: The VM migration.
>>
>> Context:
>>
>> - In the case of a poisoned page in the VM address space, the migration
>> can't read it and will skip this page, considering it as a zero-filled
>> page. The VM kernel (that handled the vMCE) would have marked it's
>> associated page as poisoned, and if the VM touches the page, the VM
>> kernel generates the associated MCE because it already knows about the
>> poisoned page.
>>
>> - When we ignore the vMCE in the case of a SIGBUS/BUS_MCEERR_AO error
>> (what this patch does), we entirely rely on the Hypervisor to send an
>> SRAR error to qemu when the page is touched: The AMD VM kernel will
>> receive the SIGBUS/BUS_MCEERR_AR and deal with it, thanks to your
>> changes here.
>>
>> So it looks like the mechanism works fine... unless the VM has migrated
>> between the SRAO error and the first time it really touches the poisoned
>> page to get an SRAR error !  In this case, its new address space
>> (created on the migration destination) will have a zero-page where we
>> had a poisoned page, and the AMD VM Kernel (that never dealt with the
>> SRAO) doesn't know about the poisoned page and will access the page
>> finding only zeros...  We have a memory corruption !

I don't understand this. Why would the page be zero? Even so, why would
that affect poison?

Also, during page migration, does the data flow through the CPU core?
Sorry for the basic question. I haven't done a lot with virtualization.

Please note that current AMD systems use an internal poison marker on
memory. This cannot be cleared through normal memory operations. The
only exception, I think, is to use the CLZERO instruction. This will
completely wipe a cacheline including metadata like poison, etc.

So the hardware should not (by design) loose track of poisoned data.

>>
>> It is a very rare window, but in order to fix it the most reasonable
>> course of action would be to make the AMD emulation deal with SRAO
>> errors, instead of ignoring them.
>>
>> Do you agree with my analysis ?
> 
> Under the case that SRAO aren't handled well in the kernel today[*] for AMD, we
> could always add a migration blocker when we hit AO sigbus, in case ignoring
> is our only option. But this would be less than ideal to propagating the
> SRAO into the guest.
> 
> [*] Meaning knowing that handling the SRAO would generate a crash in the guest
> 
> Perhaps as an improvement, perhaps allow qemu to choose to propagate should this
> limitation be lifted via a new -action value and allow it to ignore/propagate or
> not e.g.
> 
>  -action mce=none # default on Intel to propagate all MCE events to the guest
>  -action mce=ignore-optional # Ignore SRAO
> 
> I suppose the second is also useful for ARM64 considering they currently ignore
> SRAO events too.
> 
>> Would an AMD platform generate SRAO signal to a process
>> (SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?
>>
> This would be useful to confirm.
>

There is no SRAO signal on AMD. The closest equivalent may be a
"Deferred" error interrupt. This is an x86 APIC LVT interrupt, and it's
sent when a deferred (uncorrectable non-urgent) error is detected by a
memory controller.

In this case, the CPU will get the interrupt and log the error (in the
host).

An enhancement will be to take the MCA error information collected
during the interrupt and extract useful data. For example, we'll need to
translate the reported address to a system physical address that can be
mapped to a page.

Once we have the page, then we can decide how we want to signal the
process(es). We could get a deferred/AO error in the host, and signal the
guest with an AR. So the guest handling could be the same in both cases.

Would this be okay? Or is it important that the guest can distinguish
between the A0/AR cases? IOW, will guests have their own policies on
when to take action? Or is it more about allowing the guest to handle
the error less urgently?

Thanks,
Yazen

