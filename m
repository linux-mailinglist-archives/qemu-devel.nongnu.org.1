Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF9777D7D
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU88R-0004oj-K0; Thu, 10 Aug 2023 12:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qU88O-0004l0-L8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:03:36 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com
 ([40.107.244.87] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1qU88L-0000Cd-9K
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:03:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRIjlYRl4zV5AFc8PjWTVuialD3oF6S/K0wMJb+bDymEsMTz5ecGv3dgN/XbTTgdZiKb1q5PdGPR9DchktoJP9/qWz5Bn2TxnBh37jPxshcHpj7JWMVD64z8AgRJutDA9aJqthJ+yzvmxr83W/Sos7znkg/x2n3VhPqCi3iQdiIQBQO3hlbz9v9IIlNJY2Dg8eYGstlZbxKLMzZGsX99uUS3+VbdzhjKhNUdSf4/kDNPV0gBBntCvvxUbtIGO5mEEk9e3dhiANoVJ/1xIIwGsEijW4lHPVuBgmt28Jpd4qpgqNtvNWYtt55cokwsOumH0wyVxA1gxuiVowGugZ5Hcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnwCOXXW328VRcJ9DphkQVVDfhk1R5a2Ymu0WuO2BT0=;
 b=hXlu9/znQXH7EZGaOvLf30Vb2H4QfXA5EASE5Akvcj1dNcOxW9oQIzVMz4uu1WgsSsIPgw9sPL0Qo8n82jGKlZ6wPcrctLX4xkeg12XHh42pf68QvPOZ5nolb/njAZbeDj/AfSCFcZ6Q1d1ZrmWTrZpujgj5mIqB5fFrO9NrUq1bxUEojcm8kD3YsfddLEy7idirpsPU20vJ5U8Sa1RYX5gywQHxWzzi0Mx6SmrIerJ3SgwOvqpwRV1Sw7bh8S70vZq33VjsrxMGs3vhZURn9QERVGkcXntR+XJS4xb+ngZILIawIoFuakiej6bOzvcvIYWqyIyn4DCrxweVZV7nGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnwCOXXW328VRcJ9DphkQVVDfhk1R5a2Ymu0WuO2BT0=;
 b=Wn1tvKke4aMSlRTRt280YqlRIkjLpX9SarFyM3cehgZDxDieDGZ4lPMl5p925KxqiE0djj/sf3+budR4NPnrXGZc5dbl1I9WnnH5kR8s/Yu/YFbopbelwYIPp/cT/X7f1pdWRyHEQ0wY/8QIgWFqXQPU+RxU0Ad/upfdVHbmPE0=
Received: from CY8PR11CA0005.namprd11.prod.outlook.com (2603:10b6:930:48::18)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:58:26 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::7d) by CY8PR11CA0005.outlook.office365.com
 (2603:10b6:930:48::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 15:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 15:58:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 10:58:25 -0500
Date: Thu, 10 Aug 2023 10:58:09 -0500
To: Xiaoyao Li <xiaoyao.li@intel.com>
CC: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, David
 Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, Chao Peng
 <chao.p.peng@linux.intel.com>, <isaku.yamahata@gmail.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 00/19] QEMU gmem implemention
Message-ID: <20230810155808.eqne5zzb53mirgcw@amd.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <ZMfmkCQImgsinE6T@redhat.com>
 <9b3a3e88-21f4-bfd2-a9c3-60a25832e698@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b3a3e88-21f4-bfd2-a9c3-60a25832e698@intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b86225-9f88-4a0b-03a1-08db99baa1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0xYvPDYb3jG65KkOlXMleFcYQ1dvIIQYc7S1joUZa1APjwisSpNxD+7MoplYl0Dfcg9OWhPHKqX+2SK2Z2N6znh0mP5d7EVQZRarWkccCZU+Unp2WscnVbiR/I6LZJm7l1peEbPaHkmolq+6jLDgp9xd6s5gccv2j89aHiMfjEYcoDBRJ26Q9HhKZtL3OVTxE+gSg8zj1uJ3VZ7eY38C77p1uf3UuClOZP2p+3IouueTEbQEs0HwZAyOPONIJa/YGZFvzy612YmM8sTajI7DcP8CZQTwbENfwZy6eLhDKTji2t6ZGGUkVjeyso7GAPyvUZGUYV43Nqv5vnLz67bTtfqAVU52sxDRjA/zp8E7hurI7pDnS7MdwooH/0W7SZu1B0diANl6G1a53+5ivwSbBUkGjHhXeFMudFJMXNIEagFJHNPw2bG40RrgTkiXCGr6Q7T2g6yNYy3waQjKPC05j8ENdUwTQe6VIHQqjmaa/bcxdpUWluxqKeiU7JAHJwpA+HKZy22AR6jQ0mdFuhstBWqJJ8C4AADbXZUC54I+ZgWQKZ1FNmPRm+e8bzO9gi5tFT8EGmydsCQL9/rWyc371i1V03hI9GmQbBuaYNmOFdvkK1HowvGqPAkgWF2O/z7QLFHn8yympTVv5hX94piIJDS1IjHxPgUz62/o3rDFPnZQfEWaMdYeDRcGzscj3g+AYk3WEn2Klg/J1t9ClZ4SbGirc3Pu+2D66eDQzHEGsu6aTrBa/3w3SxLR0wAmjAZIRgbrJwLFGg2WDaHzxXYuNv8GcB7GgJ8hHykiD0mqYA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400008)(451199021)(1800799006)(186006)(46966006)(36840700001)(40470700004)(8676002)(8936002)(26005)(53546011)(1076003)(41300700001)(82740400003)(40460700003)(36860700001)(36756003)(47076005)(83380400001)(426003)(2906002)(356005)(81166007)(2616005)(86362001)(44832011)(7416002)(16526019)(336012)(40480700001)(5660300002)(6916009)(70586007)(70206006)(4326008)(966005)(54906003)(478600001)(6666004)(66899021)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:58:26.0022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b86225-9f88-4a0b-03a1-08db99baa1d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954
Received-SPF: softfail client-ip=40.107.244.87;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 01, 2023 at 09:45:41AM +0800, Xiaoyao Li wrote:
> On 8/1/2023 12:51 AM, Daniel P. Berrangé wrote:
> > On Mon, Jul 31, 2023 at 12:21:42PM -0400, Xiaoyao Li wrote:
> > > This is the first RFC version of enabling KVM gmem[1] as the backend for
> > > private memory of KVM_X86_PROTECTED_VM.
> > > 
> > > It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
> > > and introduces 'private' property for memory backend. When the vm type
> > > is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
> > > it will call KVM gmem ioctl to allocate private memory for the backend.
> > > 
> > >      $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
> > >            -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
> > > 	  ...
> > > 
> > > Unfortunately this patch series fails the boot of OVMF at very early
> > > stage due to triple fault because KVM doesn't support emulate string IO
> > > to private memory. We leave it as an open to be discussed.
> > > 
> > > There are following design opens that need to be discussed:
> > > 
> > > 1. how to determine the vm type?
> > > 
> > >     a. like this series, specify the vm type via machine property
> > >        'kvm-type'
> > >     b. check the memory backend, if any backend has 'private' property
> > >        set, the vm-type is set to KVM_X86_PROTECTED_VM.
> > > 
> > > 2. whether 'private' property is needed if we choose 1.b as design
> > > 
> > >     with 1.b, QEMU can decide whether the memory region needs to be
> > >     private (allocates gmem fd for it) or not, on its own.
> > > 
> > > 3. What is KVM_X86_SW_PROTECTED_VM going to look like? What's the
> > >     purose of it and what's the requirement on it. I think it's the
> > >     questions for KVM folks than QEMU folks.
> > > 
> > > Any other idea/open/question is welcomed.
> > > 
> > > 
> > > Beside, TDX QEMU implemetation is based on this series to provide
> > > private gmem for TD private memory, which can be found at [2].
> > > And it can work corresponding KVM [3] to boot TDX guest.
> > 
> > We already have a general purpose configuration mechanism for
> > confidential guests.  The -machine argument has a property
> > confidential-guest-support=$OBJECT-ID, for pointing to an
> > object that implements the TYPE_CONFIDENTIAL_GUEST_SUPPORT
> > interface in QEMU. This is implemented with SEV, PPC PEF
> > mode, and s390 protvirt.
> > 
> > I would expect TDX to follow this same design ie
> > 
> >      qemu-system-x86_64 \
> >        -object tdx-guest,id=tdx0,..... \
> >        -machine q35,confidential-guest-support=tdx0 \
> >        ...
> > 
> > and not require inventing the new 'kvm-type' attribute at least.
> 
> yes.
> 
> TDX is initialized exactly as the above.
> 
> This RFC series introduces the 'kvm-type' for KVM_X86_SW_PROTECTED_VM. It's
> my fault that forgot to list the option of introducing sw_protected_vm
> object with CONFIDENTIAL_GUEST_SUPPORT interface.
> Thanks for Isaku to raise it https://lore.kernel.org/qemu-devel/20230731171041.GB1807130@ls.amr.corp.intel.com/
> 
> we can specify KVM_X86_SW_PROTECTED_VM this way:
> 
> qemu  \
>   -object sw-protected,id=swp0,... \
>   -machine confidential-guest-support=swp0 \
>   ...
> 
> > For the memory backend though, I'm not so sure - possibly that
> > might be something that still wants an extra property to identify
> > the type of memory to allocate, since we use memory-backend-ram
> > for a variety of use cases.  Or it could be an entirely new object
> > type such as "memory-backend-gmem"
> 
> What I want to discuss is whether providing the interface to users to allow
> them configuring which memory is/can be private. For example, QEMU can do it
> internally. If users wants a confidential guest, QEMU allocates private gmem
> for normal RAM automatically.

I think handling it automatically simplifies things a good deal on the
QEMU side. I think it's still worthwhile to still allow:

 -object memory-backend-memfd-private,...

because it provides a nice mechanism to set up a pair of shared/private
memfd's to enable hole-punching via fallocate() to avoid doubling memory
allocations for shared/private. It's also a nice place to control
potentially-configurable things like:

 - whether or not to enable discard/hole-punching
 - if discard is enabled, whether or not to register the range via
   RamDiscardManager interface so that VFIO/IOMMU mappings get updated
   when doing PCI passthrough. SNP relies on this for PCI passthrough
   when discard is enabled, otherwise DMA occurs to stale mappings of
   discarded bounce-buffer pages:

     https://github.com/AMDESE/qemu/blob/snp-latest/backends/hostmem-memfd-private.c#L449

But for other memory ranges, it doesn't do a lot of good to rely on
users to control those via -object memory-backend-memfd-private, since
QEMU will set up some regions internally, like the UEFI ROM.

It also isn't ideal for QEMU itself to internally control what
should/shouldn't be set up with a backing guest_memfd, because some
guest kernels do weird stuff, like scan for ROM regions in areas that
guest kernels might have mapped as encrypted in guest page table. You
can consider them to be guest bugs, but even current SNP-capable
kernels exhibit this behavior and if the guest wants to do dumb stuff
QEMU should let it.

But for these latter 2 cases, it doesn't make sense to attempt to do
any sort of discarding of backing pages since it doesn't make sense to
discard ROM pages.

So I think it makes sense to just set up the gmemfd automatically across
the board internally, and keep memory-backend-memfd-private around
purely as a way to control/configure discardable memory.

-Mike

> 
> 

