Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921298484FD
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Feb 2024 10:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCG7-0002gX-J5; Sat, 03 Feb 2024 04:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWCG4-0002gP-NO
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:24:20 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWCG2-0003aV-A1
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706952258; x=1738488258;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kw3OOTRz9AfhneBs+qlsMv0+ql7UK40PdaE6fG3rIDE=;
 b=HwnIZjYEoEeiGk25x5GMGI3gMAI0JVpdHPQAPKojL4XBBSTKLksnDav6
 5s3AgwqrAiD6JeJ0J4ECYqFtcH8OAH+4R/I/zfUDoGd7o6z86C8bNljyd
 7ba7N3f/lA7fKZdyP4PsDIDbg9PZ4CZ6dVxPnr1pGQncScblbQifkVIV9
 aDrVdRWU8HxpY5T6kan2AIQ0QcnZ8idod/vqzLsMN8qp6J505+kc0Qdak
 VE3VdFRKnC3W6drRZe1XWEf4De87RdY9sOKsm1Oe1RgzbGbtVScIhSTem
 WFSMR5sR5O1/iXPxBYWxV1RwojaV3vgKcwX5agrf3+H7EnBhzKtwFAybn Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="209289"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="209289"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="4913836"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2024 01:24:13 -0800
Date: Sat, 3 Feb 2024 17:37:45 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 0/6] Intel Thread Director Virtualization Support in QEMU
Message-ID: <Zb4JaZ+aNzsSsTp2@intel.com>
References: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 03, 2024 at 05:30:48PM +0800, Zhao Liu wrote:
> Date: Sat, 3 Feb 2024 17:30:48 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [RFC 0/6] Intel Thread Director Virtualization Support in QEMU
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is our refreshed RFC to support our ITD virtualization patch
> series [1] in KVM, and bases on bd2e12310b18 ("Merge tag
> 'qga-pull-2024-01-30' of https://github.com/kostyanf14/qemu into
> staging").
> 
> ITD is Intel's client specific feature to optimize scheduling on Intel
> hybrid platforms. Though this feature depends on hybrid topology

s/depends/doesn't depend/

Regards,
Zhao

> details, in our parctice on Win11 Guest, ITD works with hyrbid topolohy
> and CPU affinity can achieve the most performance improvement in Win11
> Guest (for example, on i9-13900K, up to 14%+ improvement on
> 3DMARK). More data or details, can be found in [1]. Thus, the ITD for
> Win11 is also a typical use case of hybrid topology.
> 
> 
> Welcome your feedback!
> 
> 
> 1. Background and Motivation
> ============================
> 
> ITD allows the hardware to provide scheduling hints to the OS to help
> optimize scheduling performance, and under the Intel hybrid
> architecture, since Core and Atom have different capabilities
> (performance, energy effency, etc.),  scheduling based on hardware
> hints can take full advantage of this hybrid architecture. This is also
> the most ideal scheduling model for intel hybrid architecture.
> 
> Therefore, we want to virtualize the ITD feature so that ITD can benefit
> performance of the virtual machines on the hybrid machines as well.
> 
> Currently, our ITD virtualization is a software virtualization solution.
> 
> 
> 2. Introduction to HFI and ITD
> ==============================
> 
> Intel provides Hardware Feedback Interface (HFI) feature to allow
> hardware to provide guidance to the OS scheduler to perform optimal
> workload scheduling through a hardware feedback interface structure in
> memory [2]. This hfi structure is called HFI table.
> 
> As for now, the guidance includes performance and energy enficency hints,
> and it could update via thermal interrupt as the actual operating
> conditions of the processor change during run time.
> 
> And Intel Thread Director (ITD) feature extends the HFI to provide
> performance and energy efficiency data for advanced classes of
> instructions.
> 
> The virtual HFI table is maintained in KVM, and for QEMU, we just need
> to handle HFI/ITD/HRESET (and their dependent features: ACPI, TM and
> PTS) related CPUIDs and MSRs.
> 
> 
> 3. Package level MSRs handling
> ==============================
> 
> PTS, HFI and ITD are all have package level features, such as package
> level MSRs and package level HFI tables. But since KVM hasn't
> support msr-topology and it just handle these package-level MSRs and
> HFI table at VM level, in order to avoid potential contention problems
> caused by multiple virtual-packages, we restrict VMs to be able to
> enable PTC/HFI/ITD iff there's only 1 package (and only 1 die for
> ITD/HFI).
> 
> 
> 4. HFI/ITD related info in CPUID
> ================================
> 
> KVM provides some basic HFI info in CPUID.0x06 leaf, which is associated
> with the virtual HFI table in KVM.
> 
> QEMU should configure HFI table index for each vCPU. Here we set the HFI
> table index to vCPU index so that different vCPUs have different HFI
> entries to avoid unnecessary competition problems.
> 
> 
> 5. Compatibility issues
> =======================
> 
> HFI is supported in both server (SPR) and client (ADL/RPL/MTL) platform
> products while ITD is the client specific feature.
> 
> For client platform, ITD (with HFI) could be enabled in Guest to improve
> scheduling, but for server platform, HFI (without ITD) is only useful
> on Host and Guest doesn't need it.
> 
> To simplify the enabling logic and avoid impacting the common topology
> of the Guest, we set PTS, HFI, and ITD as feature bits that are not
> automatically enabled.
> 
> Only when the user actively specifies these features, QEMU will check
> and decide whether to enable them based on the topology constraints and
> the ITD constraints.
> 
> 
> 6. New option "enable-itd"
> ============================
> 
> ITD-related features include PTS, HFI, ITD, and HRESET.
> 
> To make it easier for users to enable ITD for Guest without specifying
> the above feature bits one by one, we provide a new option "enable-itd"
> to set the above feature bits for Guest all at once.
> 
> "enable-itd" does not guarantee that ITD will be enabled for Guest.
> The success of enabling ITD for guest depends on topology constraints,
> platform support, etc., which are checked in QEMU.
> 
> 
> 7. Patch Summary
> ================
> 
> Patch 1: Add support save/load for ACPI feature related thermal MSRs
>          since ACPI feature CPUID has been added in QEMU.
> Patch 2: Add support for PTS (package) thermal MSRs and its CPUID
> Patch 3: Add support for HFI MSRs and its CPUID
> Patch 4: Add support ITD CPUID and MSR_IA32_HW_FEEDBACK_THREAD_CONFIG.
> Patch 5: Add support HRESET CPUID and MSR_IA32_HW_HRESET_ENABLE.
> Patch 6: Add "enable-itd" to help user set ITD related feature bits.
> 
> # 8. References
> 
> [1]: KVM RFC: [RFC 00/26] Intel Thread Director Virtualization
>      https://lore.kernel.org/kvm/20240203091214.411862-1-zhao1.liu@linux.intel.com/T/#t
> [2]: SDM, vol. 3B, section 15.6 HARDWARE FEEDBACK INTERFACE AND INTEL
>      THREAD DIRECTOR
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (2):
>   target/i386: Add support for Intel Thread Director feature
>   i386: Add a new property to set ITD related feature bits for Guest
> 
> Zhuocheng Ding (4):
>   target/i386: Add support for save/load of ACPI thermal MSRs
>   target/i386: Add support for Package Thermal Management feature
>   target/i386: Add support for Hardware Feedback Interface feature
>   target/i386: Add support for HRESET feature
> 
>  target/i386/cpu.c     | 108 ++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h     |  37 +++++++++++++++
>  target/i386/kvm/kvm.c |  84 ++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+), 4 deletions(-)
> 
> -- 
> 2.34.1
> 

