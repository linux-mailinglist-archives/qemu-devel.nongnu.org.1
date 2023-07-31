Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC6769C7E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:29:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVkd-0003bd-A2; Mon, 31 Jul 2023 12:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVka-0003ay-I5
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:28:04 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVkX-0008I7-Jo
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690820881; x=1722356881;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xEZHx0KbCw3rxQuoCBZM6LeOuuc/cDcIdUS8q7SYhFA=;
 b=LRjXJny1vjX68Tc79AVBcPHdF70xNiPr5W7X/mMvt0jhuETY8rzhyYoT
 mJtN/quqm1n1z0GI5mMDfPCht7gbLMHDcznnELdKTUJ/V6nhTmc/idjjT
 V0Z6Ing8Zok+kToGDW3iO+DSgDDYv9BxgtTxb0D7UUaYgYTOToSdhrkCZ
 SgD279mpHE7SQKhFurO3v+5jKOh488gfKMTdS0ucst+0SPs9cSX/WArly
 zrsdGnN5gWXT5TsFV1Do25842FrrCfhhZ7g9RuJVOfjQh+piLt5S5R23c
 +xN1J2XJgTmltTlJMMm1KMJGMRN6LysKDoSJ1MipZudHAkXzT8PiCzsMB A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993275"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993275"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757983862"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757983862"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:24:47 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 00/19] QEMU gmem implemention
Date: Mon, 31 Jul 2023 12:21:42 -0400
Message-Id: <20230731162201.271114-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is the first RFC version of enabling KVM gmem[1] as the backend for
private memory of KVM_X86_PROTECTED_VM.

It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
and introduces 'private' property for memory backend. When the vm type
is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
it will call KVM gmem ioctl to allocate private memory for the backend.

    $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
          -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
	  ...

Unfortunately this patch series fails the boot of OVMF at very early
stage due to triple fault because KVM doesn't support emulate string IO
to private memory. We leave it as an open to be discussed.

There are following design opens that need to be discussed:

1. how to determine the vm type?

   a. like this series, specify the vm type via machine property
      'kvm-type'
   b. check the memory backend, if any backend has 'private' property
      set, the vm-type is set to KVM_X86_PROTECTED_VM.

2. whether 'private' property is needed if we choose 1.b as design 

   with 1.b, QEMU can decide whether the memory region needs to be
   private (allocates gmem fd for it) or not, on its own.

3. What is KVM_X86_SW_PROTECTED_VM going to look like? What's the
   purose of it and what's the requirement on it. I think it's the
   questions for KVM folks than QEMU folks.

Any other idea/open/question is welcomed.


Beside, TDX QEMU implemetation is based on this series to provide
private gmem for TD private memory, which can be found at [2].
And it can work corresponding KVM [3] to boot TDX guest. 

[1] https://lore.kernel.org/all/20230718234512.1690985-1-seanjc@google.com/
[2] https://github.com/intel/qemu-tdx/tree/tdx-upstream-wip
[3] https://github.com/intel/tdx/tree/kvm-upstream-2023.07.27-v6.5-rc2-workaround

Chao Peng (4):
  RAMBlock: Support KVM gmemory
  kvm: Enable KVM_SET_USER_MEMORY_REGION2 for memslot
  physmem: Add ram_block_convert_range
  kvm: handle KVM_EXIT_MEMORY_FAULT

Isaku Yamahata (4):
  HostMem: Add private property to indicate to use kvm gmem
  trace/kvm: Add trace for page convertion between shared and private
  pci-host/q35: Move PAM initialization above SMRAM initialization
  q35: Introduce smm_ranges property for q35-pci-host

Xiaoyao Li (11):
  trace/kvm: Split address space and slot id in
    trace_kvm_set_user_memory()
  *** HACK *** linux-headers: Update headers to pull in gmem APIs
  memory: Introduce memory_region_can_be_private()
  i386/pc: Drop pc_machine_kvm_type()
  target/i386: Implement mc->kvm_type() to get VM type
  i386/kvm: Create gmem fd for KVM_X86_SW_PROTECTED_VM
  kvm: Introduce support for memory_attributes
  kvm/memory: Introduce the infrastructure to set the default
    shared/private value
  i386/kvm: Set memory to default private for KVM_X86_SW_PROTECTED_VM
  physmem: replace function name with __func__ in
    ram_block_discard_range()
  i386: Disable SMM mode for X86_SW_PROTECTED_VM

 accel/kvm/kvm-all.c         | 166 +++++++++++++++++++++++++++++++++---
 accel/kvm/trace-events      |   4 +-
 backends/hostmem.c          |  18 ++++
 hw/i386/pc.c                |   5 --
 hw/i386/pc_q35.c            |   3 +-
 hw/i386/x86.c               |  27 ++++++
 hw/pci-host/q35.c           |  61 ++++++++-----
 include/exec/cpu-common.h   |   2 +
 include/exec/memory.h       |  24 ++++++
 include/exec/ramblock.h     |   1 +
 include/hw/i386/pc.h        |   4 +-
 include/hw/i386/x86.h       |   4 +
 include/hw/pci-host/q35.h   |   1 +
 include/sysemu/hostmem.h    |   2 +-
 include/sysemu/kvm.h        |   3 +
 include/sysemu/kvm_int.h    |   2 +
 linux-headers/asm-x86/kvm.h |   3 +
 linux-headers/linux/kvm.h   |  50 +++++++++++
 qapi/qom.json               |   4 +
 softmmu/memory.c            |  27 ++++++
 softmmu/physmem.c           |  97 ++++++++++++++-------
 target/i386/kvm/kvm.c       |  84 ++++++++++++++++++
 target/i386/kvm/kvm_i386.h  |   1 +
 23 files changed, 517 insertions(+), 76 deletions(-)

-- 
2.34.1


