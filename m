Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160C7AB3B8
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhAy-0003X5-TO; Fri, 22 Sep 2023 10:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Yazen.Ghannam@amd.com>)
 id 1qjhAv-0003Wk-Rj
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:30:33 -0400
Received: from mail-sn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::62e]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Yazen.Ghannam@amd.com>)
 id 1qjhAs-0004on-Ll
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U89fZYdeBDTft7RmomUgtI6jf7lPyrSQy+oOMT8iiGkeMINSbkclmIdGo9EfnElpe7Y9fXKn1H2ENS9mBxnNfr9uf9eC1N41Y52NliIje+G9DRqmytzwqO822P19y4PEc9XwRk3dt0FpneFKS2L2Prz/j2hQrHX+AfQupCFrgliJymmj8h7CJ+Y6aNc/6llrkO4QFYlPbfk3L4aT9I5MZQp6oSG5TsVXkdRvNDZHaHRv1Qtha2SUS2gb7b6pIi6BGphKbe7ShgHte1k0TXsjmLXgXwwIMY8jaGwVSVIPRUY9RBFFe8r2gnOw8h14GTWCW2wevcjFkGrh1GQlicMyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNDW1TQiT+a2UCqsmexbnDRQdASy3WIzvbyBvfCZeBA=;
 b=MvtqIzXMoNtguZfkLk4HD1+8JsDkQTtZyBf1Ylfns61pwjWN+t3WU60LsXFKA18Cn5/YDdp5N/26hGfozSZ86erTodrUp9yAi0ias/kBwnm0UfTl/rW2SVczKDT97VbkjX9hCaLLPzHj1TP/2te2l/BeN9CoEfABq90lqdcpANabQAVGpxbPKWVy8WW4r7BmiQWwhQzLTpJEDW4tGCZbVcp9IkOm5GnwODTGY6kq+3+PEsSu9wu72UyucJRN3emCJPZ2wqLLL7Xi93LB/P4kiJGlYElkYuQh0bbqe5mE5LgXBkRuFTDuYclI6eYd7HsVqDL8gL76eQooQSHwuRxUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNDW1TQiT+a2UCqsmexbnDRQdASy3WIzvbyBvfCZeBA=;
 b=WcaACvs9VeLxaa5MXlkJ87MLriqT1FKVS0Wlk4I06fejlDommNYsRYCok5BdM1sw5BZXBaOm7kDIzmqENLsfl/m/Nb3jSNywj5hNc9wzIDoYpt6GjztMgTmTeQEKoyVIwS3m4iKOPgEGbE8SRHm4QPSBX4bfzHaiJmzbksG2xQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 14:30:08 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:30:08 +0000
Message-ID: <60d3f74a-a1a8-4fed-a102-9985c47c69c8@amd.com>
Date: Fri, 22 Sep 2023 10:30:04 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
To: William Roche <william.roche@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>, John Allen <john.allen@amd.com>,
 qemu-devel@nongnu.org
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
 <f287de21-8eed-0c88-98a4-69f00bd73be9@oracle.com>
 <948a0ac5-379d-44a7-92b1-d2cc0995e187@oracle.com>
 <39a471b1-9ef6-47e9-97a8-b315f63b4917@amd.com>
 <bd6f1942-4f6e-a353-8929-77fdc30bf06e@oracle.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <bd6f1942-4f6e-a353-8929-77fdc30bf06e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:408:f6::16) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 41963356-b06e-4b17-574d-08dbbb786b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67s5KundIIdUOrKkeE42RNT9MeMFVtmVX9wTbn4M1mxJoHy9PYPSWzrZiTx6KooITncx9rlTGYy0aQIs6dC/kJfsawuoNHbCmzBWMchA6aS3S9SYr/DwQZ6e6t+j/i0C+mnvPPHUxdVNslbaMWcOZ3wAS2K/YFKoc4+nAy+11JaR/KK3crPpnb54Z07QP0aCYZkFGdONMbYLyakWSRBhgL99tduW7xIXVahrLOYkaad4RZBKDnGV1F7N1FHurkaWGIMaIFTRrRFl02PXiwB1u8aiGPOD3lXJiME8l3pQW2noJEJPFpHQzq/QRjB5qARuSFXU1lam7W3TiLCSKDz5oQxDynnhz/bxsyayJ4qRJizv2rDHvKDnrYGG2ybAxgUSwNUbubdCUrtmDnHdDvJjZdA718kuUyI8UcRL9JbiizPc2DJFrQLs7AGauZVjBz+ilCUagPJeu1mhQCj/jwqVtlrRBZrpmWgkiC/gJGIHvajX3bDLmtRKvu/UqxbYQmg/AsiRXKbiceT545dPJAlKz0JEVbclSYZw/gXJUyF81uBO2TJAilkXimu80gywMp9kKZKdZpLF0geBsNz472UWAqcNfEVtLawxdqiS0FMy3Bk59FpI9OQhtgcqVNsaVN848SZ/2a4N1qU1YVpYmlXHqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(186009)(451199024)(1800799009)(2906002)(316002)(66476007)(66946007)(66556008)(110136005)(4326008)(8936002)(44832011)(8676002)(5660300002)(66899024)(41300700001)(2616005)(83380400001)(36756003)(26005)(31686004)(31696002)(86362001)(38100700002)(6506007)(6666004)(6512007)(6486002)(53546011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJqWUxLcXM1cUdrUjZweUdQQXZsOGxQT1phMVlKWjRLbDFtV3lDeURwOTlI?=
 =?utf-8?B?KzZLZnR6TVlaV0Evc2FEZFh0bGFiOUZtcHlrUWQ1LzBLeUJ3cjJHVkVUdXgz?=
 =?utf-8?B?Z0crSm1LOXlvWFJGdXZkUWpiK1pPZmdQYzR3alpzYSs3cytabC9RTVYyYVM2?=
 =?utf-8?B?Ty8vSUQ3Z0pvT1dCeDdVK1NZa3FwTlkzYmhNZmpUY0gzTStXWEFtcUNQT1Q5?=
 =?utf-8?B?S0xHREg3MThCeE5MSFVZSGRRUHJtN1ZhMTE1YXF2SUkwcmtsQVVxcXp5cCtE?=
 =?utf-8?B?dVJVNG52QUh4T2thVU9DaTc2alhmaldERVcvZ1NtVktzaFI4ZWhNaWZqM1Q2?=
 =?utf-8?B?ditSZjllZlpFaFVnRE9CWHJYNHBOeU85SExvNFg5S0dRaXNxbzRkZE9PU3Fm?=
 =?utf-8?B?b2ZmZGFmcHc5WnpJTFlScEFwZjQ0MW10bUExMmNDOVNWay9ZTXFkZTZ4OFNv?=
 =?utf-8?B?NTM2dWo4N25jZUM5c3RJZjYrelJydmtSTDkwcnZGR3hMUXUzUFNLVG1CeFhK?=
 =?utf-8?B?ZDJHa2Nmc091SmlzaDdkSGVoRkZOenNkclUyd0Ird1dGWkJ3WjN2cHdwN1RT?=
 =?utf-8?B?dk5RL0RCZHhqbVoxaFRFMFFhTVZ6RU1Od2N0V0dKdXk2V1F3MnZ1KzNyL0xa?=
 =?utf-8?B?TTVFNjQweFpqYW9uTGtHK0pmdWRUclJQYWhRSStrVERYLzdvc1NUU1pidGs0?=
 =?utf-8?B?TmFkRk9jTGRTYlBxWGdaeVNCOHJhcGtia2diNnVpR29ZSnQ4TmNtWkZOT2w2?=
 =?utf-8?B?N1h4V0JQalRwZmpFaFpjcHZxRlYxdnJUVy9LUTZ1VzNHUkRMWGRmMlJURzlT?=
 =?utf-8?B?bHhrVXBwVWxnUzdYMXhvVEc2ZUxZeDRTM21lM3dDUXRzM1ZHRWdkcmRmWlV2?=
 =?utf-8?B?MFZidVNLQkY1LyttN2VRKzZjVXpQcDB0S0ZkWVRhNHY2aEFJb2JQb1QrY3BH?=
 =?utf-8?B?NWpsY0F1MldMWlNleVpndDROZ2hjZllvaXZuUDhONDFFK2hsNXZ2UzJJK2ho?=
 =?utf-8?B?UmhkUTkzd0lGZ0N0MW1zVHZqT0l2QzV6emVQNGFFaGszbG1NdDlKaDBlSDRR?=
 =?utf-8?B?d2VZRW91WmNxSy9PaGpGOVBaTDZseVoyeHJDazYrVm1Ua0FsWFlOZTVnY3V1?=
 =?utf-8?B?Nk1JV3JaQnBOWlo0SG4vL3UycDRiVy8reWs3cGpnekEvdFMyNzdtcmpLWmtG?=
 =?utf-8?B?ZFRYZ1hxTjBaajQ1NUdwR3kzVlNTanMxZkFtM3Zab2l5NWdQc2UrMG42akU5?=
 =?utf-8?B?OTJzWnBSaGxGMU5OaGdidSttQnppeFZZK212V0srOU95RCsyTDBPQjhKUlB4?=
 =?utf-8?B?ZEhPTWY1UnVqQytQV2JwaFF0SjRNbWFhWjJtb29YYXB1c0RtMXhvYlR4cUFF?=
 =?utf-8?B?VHk2OG1jd0NaaDF2MHYvVStXWExlVXM0RzFUU2x0ZmhBM1dhVnRPL0VUczFx?=
 =?utf-8?B?ZFJLK1NybnIzWlh1akU1OWhaaXZNS3dBdG5kVStyVlBaT091MWlsWVg5VzZU?=
 =?utf-8?B?UEtvNE1zalp2NEtCSEFLYXVSQzUrci9vNTFYTHo0eGp3VTIxV2IvMi81V2dY?=
 =?utf-8?B?bGh0WjlqZmF4QmVTTFlFSjBtL2taSDlNUHBBM1ZDbmdPbmhEa2hwQkZTRGFr?=
 =?utf-8?B?TWk5aFFObGJzV243YVI5VjFYNjVKejlaWngwT2RtR1RiU0tCMThCSUdzeUZC?=
 =?utf-8?B?Mzl1bEp2NHVrR1g2TUJSVEdyS0tOSUVYUGZVU0F5dnNnVFpld1pDZUdrcnQv?=
 =?utf-8?B?SjNSM2lrbHBxWVZySEdUcTNUUUJTOUhBQ3JWakNOVkJRMWhrRzU4NEVtd2pz?=
 =?utf-8?B?eitubnRSMU8xdlhDN2hkT1JOa3ZPS1E2MmJ2VCtBQ3BoZTM3WHkrYUR4dVhB?=
 =?utf-8?B?U2RHRjhKNXJzU3BlVWVUQmRuMm5Qc1dreU9SdkM1NVZYRmsvV2tGcmpsdXVk?=
 =?utf-8?B?ZkZubmtUN2ozcXUzOVFIQ0ZrZWtEYTdzdzNBSEJjYjY1akROQnNyTGliQlBK?=
 =?utf-8?B?NDNmS081K3lzTmR5T3pvdmFUWTRXYXMzbW03WE9IWjVkdXNFSmlOMG9JejNw?=
 =?utf-8?B?TkEyZTZEM0xlM09EN25iNHpSU1I1RGEwMjBzS0lldzFBQnd5OHpoMTF0ZTNO?=
 =?utf-8?Q?Oq+bjdgFMT54cDnbQTwG9M+jY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41963356-b06e-4b17-574d-08dbbb786b68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:30:08.1176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv2JDs2AgrbHqzjZoqvIJRBJR4jTGjo02cvMZeGO+9NiN3c5hYvxUhPZuemcSkiKEzNmGUwcFJB7lHtuo8IKcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::62e;
 envelope-from=Yazen.Ghannam@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/23 4:36 AM, William Roche wrote:
> On 9/21/23 19:41, Yazen Ghannam wrote:
>> On 9/20/23 7:13 AM, Joao Martins wrote:
>>> On 18/09/2023 23:00, William Roche wrote:
>>>> [...]
>>>> So it looks like the mechanism works fine... unless the VM has migrated
>>>> between the SRAO error and the first time it really touches the poisoned
>>>> page to get an SRAR error !  In this case, its new address space
>>>> (created on the migration destination) will have a zero-page where we
>>>> had a poisoned page, and the AMD VM Kernel (that never dealt with the
>>>> SRAO) doesn't know about the poisoned page and will access the page
>>>> finding only zeros...  We have a memory corruption !
>>
>> I don't understand this. Why would the page be zero? Even so, why would
>> that affect poison?
> 
> The migration of a VM moves the memory content from a source platform to
> a destination. This is mainly the qemu processes reading the data and
> replicating it on the destination. The source qemu where a memory page
> is poisoned is(will be[*]) able to skip the poisoned pages it knows
> about to indicate to the destination machine to populate the associated
> page(s) with zeros as there is no "poison destination page" mechanism in
> place for this migration transfer.
> 
>>
>> Also, during page migration, does the data flow through the CPU core?
>> Sorry for the basic question. I haven't done a lot with virtualization.
> 
> Yes, in most cases (with the exception of RDMA) the data flow through
> the CPU cores because the migration verifies if the area to transfer has
> some empty pages.
>

If the CPU moves the memory, then the data will pass through the core/L1
caches, correct? If so, then this will result in a MCE/poison
consumption/AR event in that core.

So it seems to me that migration will always cause an AR event, and the
gap you describe will not occur. Does this make sense? Sorry if I
misunderstood.

In general, the hardware is designed to detect and mark poison, and to
not let poison escape a system undetected. In the strictest case, the
hardware will perform a system reset if poison is leaving the system. In
a more graceful case, the hardware will continue to pass the poison
marker with the data, so the destination hardware will receive it. In
both cases, the goal is to avoid silent data corruption, and to do so in
the hardware, i.e. without relying on firmware or software management.
The hardware designers are very keen on this point.

BTW, the RDMA case will need further discussion. I *think* this would
fall under the "strictest" case. And likely, CPU-based migration will
also. But I think we can test this and find out. :)

>>
>> Please note that current AMD systems use an internal poison marker on
>> memory. This cannot be cleared through normal memory operations. The
>> only exception, I think, is to use the CLZERO instruction. This will
>> completely wipe a cacheline including metadata like poison, etc.
>>
>> So the hardware should not (by design) loose track of poisoned data.
> 
> This would be better, but virtualization migration currently looses
> track of this.
> Which is not a problem for VMs where the kernel took note of the poison
> and keeps track of it. Because this kernel will handle the poison
> locations it knows about, signaling when these poisoned locations are
> touched.
>

Can you please elaborate on this? I would expect the host kernel to do
all the physical, including poison, memory management.

Or do you mean in the nested poison case like this?
1) The host detects an "AO/deferred" error.
2) The host can try to recover the memory, if clean, etc.
3) Otherwise, the host passes the error info, with "AO/deferred" severity
to the guest.
4) The guest, in nested fashion, can try to recover the memory, if
clean, etc. Or signal its own processes with the AO SIGBUS.

>>
>>>>
>>>> It is a very rare window, but in order to fix it the most reasonable
>>>> course of action would be to make the AMD emulation deal with SRAO
>>>> errors, instead of ignoring them.
>>>>
>>>> Do you agree with my analysis ?
>>>
>>> Under the case that SRAO aren't handled well in the kernel today[*] for AMD, we
>>> could always add a migration blocker when we hit AO sigbus, in case ignoring
>>> is our only option. But this would be less than ideal to propagating the
>>> SRAO into the guest.
>>>
>>> [*] Meaning knowing that handling the SRAO would generate a crash in the guest
>>>
>>> Perhaps as an improvement, perhaps allow qemu to choose to propagate should this
>>> limitation be lifted via a new -action value and allow it to ignore/propagate or
>>> not e.g.
>>>
>>>   -action mce=none # default on Intel to propagate all MCE events to the guest
>>>   -action mce=ignore-optional # Ignore SRAO
> 
> Yes we may need to create something like that, but missing SRAO has
> technical consequences too.
> 
>>>
>>> I suppose the second is also useful for ARM64 considering they currently ignore
>>> SRAO events too.
>>>
>>>> Would an AMD platform generate SRAO signal to a process
>>>> (SIGBUS/BUS_MCEERR_AO) in case of a real hardware error ?
>>>>
>>> This would be useful to confirm.
>>>
>>
>> There is no SRAO signal on AMD. The closest equivalent may be a
>> "Deferred" error interrupt. This is an x86 APIC LVT interrupt, and it's
>> sent when a deferred (uncorrectable non-urgent) error is detected by a
>> memory controller.
>>
>> In this case, the CPU will get the interrupt and log the error (in the
>> host).
>>
>> An enhancement will be to take the MCA error information collected
>> during the interrupt and extract useful data. For example, we'll need to
>> translate the reported address to a system physical address that can be
>> mapped to a page.
> 
> This would be great, as it would mean that a kernel running in a VM can
> get notified too.
>

Yes, I agree.

>>
>> Once we have the page, then we can decide how we want to signal the
>> process(es). We could get a deferred/AO error in the host, and signal the
>> guest with an AR. So the guest handling could be the same in both cases. >
>> Would this be okay? Or is it important that the guest can distinguish
>> between the A0/AR cases?
> 
> 
> SIGBUS/BUS_MCEERR_AO and BUS_MCEERR_AR are not interchangeable, it is
> important to distinguish them.
> AO is an asynchronous signal that is only generated when the process
> asked for it -- indicating that an error has been detected in its
> address space but hasn't been touched yet.
> Most of the processes don't care about that (and don't get notified),
> they just continue to run, if the poisoned area is not touched, great.
> Otherwise a BUS_MCEERR_AR signal is generated when the area is touched,
> indicating that the execution thread can't access the location.
>

Yes, understood.

> 
>> IOW, will guests have their own policies on
>> when to take action? Or is it more about allowing the guest to handle
>> the error less urgently?
> 
> Yes to both questions. Any process can indicate if it is interested to
> be "early killed on MCE" or not. See proc(5) man page about
> /proc/sys/vm/memory_failure_early_kill, and prctl(2) about
> PR_MCE_KILL/PR_MCE_KILL_GET. Such a process could take actions before
> it's too late and it would need the poisoned data.
>

Yes, agree. I think the "nested" case above would fall under this. Also,
an application, or software stack, with complex memory management could
benefit.

I'm thinking something like a long-running HPC application with multiple
checkpoints or stages. It could choose to ensure its memory space is
clean before starting a stage, or restart from an earlier checkpoint if
some data was bad, etc. In any case, the entire application doesn't need
to be killed if 4kB are bad within its entire 1TB address space, for
example.

> Now if an AMD system doesn't warn a process when a Deferred errors
> occurs, and only generates SIGBUS/BUS_MCEERR_AR errors when the poison
> is touched, it means that its processes don't benefit from an "early
> kill" and can't take actions to anticipate a synchronous error.
> 
> In such case, ignoring BUS_MCEERR_AO would just help qemu not to crash
> in case of "fake/software/injected" signals. And the case of reading the
> entire memory (like a migration) would need to be extra careful with a
> more probable SIGBUS/BUS_MCEERR_AR signal, which makes the mechanism
> more complicated, but would make more sense for AMD and ARM64 too.
> (Note that there are still cases where a BUS_MCEERR_AO capable system
> can miss an error that is revealed when reading the entire memory, in
> this case we currently crash)
> 
> 
> [*] See my patch proposal for:
>  "Qemu crashes on VM migration after an handled memory error"
> 
> In other words, having the AMD kernel to generate SIGBUS/BUS_MCEERR_AO
> signals and making AMD qemu able to relay them to the VM kernel would
> make things better for AMD platforms ;)
>

Yes, I agree. :)

Thanks,
Yazen

