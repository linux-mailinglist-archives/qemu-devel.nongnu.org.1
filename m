Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF437EF8E2
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 21:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r45nZ-0003l6-Oi; Fri, 17 Nov 2023 15:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45nQ-0003kp-Dc
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:50:37 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45nN-0007eR-II
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700254233; x=1731790233;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RFVvuGTL3ufLBRPYTUl62P95336f8JzOxnBgSPK8YSA=;
 b=Y/mahUyGAkCNApoX5Cwpg+1pQjlNsrQ6JaR7pcJnaDHjkZZ/5WKwFq0N
 Cn5cCoBYGtZOEVGDQ3u5NHA/38UqNkttZ5YQyflcAwUF+VXmPnO82NqlH
 9mphNFMkn63G41pu3g5uiaPEtcZlNOwKKwhBazqvVkBcFtleirDNDXMmk
 lIEwXoaBXIXNzHs9mrqqldmvcfmPWEnMym7tb0rpASwUprdfWW9rBcemT
 h+2Ms1DieLvPBJzOMM8mKVawOiwHy2naTZKlOFSUr2iw62ydHgNOMB+iL
 FWRuUYLglMpqEJBugHvIDAvKUMUIOmIhsQH7FBGztgSeHUerYX9z1lGBB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="371544844"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="371544844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 12:50:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="742182242"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="742182242"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 12:50:28 -0800
Date: Fri, 17 Nov 2023 12:50:28 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 05/70] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for
 memslot
Message-ID: <20231117205028.GB1645850@ls.amr.corp.intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-6-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-6-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 15, 2023 at 02:14:14AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.
> 
> With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
> backend'ed both by hva-based shared memory and guest memfd based private
> memory.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c      | 56 ++++++++++++++++++++++++++++++++++------
>  accel/kvm/trace-events   |  2 +-
>  include/sysemu/kvm_int.h |  2 ++
>  3 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9f751d4971f8..69afeb47c9c0 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -293,35 +293,69 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
>  static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, bool new)
>  {
>      KVMState *s = kvm_state;
> -    struct kvm_userspace_memory_region mem;
> +    struct kvm_userspace_memory_region2 mem;
> +    static int cap_user_memory2 = -1;
>      int ret;
>  
> +    if (cap_user_memory2 == -1) {
> +        cap_user_memory2 = kvm_check_extension(s, KVM_CAP_USER_MEMORY2);
> +    }
> +
> +    if (!cap_user_memory2 && slot->guest_memfd >= 0) {
> +        error_report("%s, KVM doesn't support KVM_CAP_USER_MEMORY2,"
> +                     " which is required by guest memfd!", __func__);
> +        exit(1);
> +    }
> +
>      mem.slot = slot->slot | (kml->as_id << 16);
>      mem.guest_phys_addr = slot->start_addr;
>      mem.userspace_addr = (unsigned long)slot->ram;
>      mem.flags = slot->flags;
> +    mem.guest_memfd = slot->guest_memfd;
> +    mem.guest_memfd_offset = slot->guest_memfd_offset;
>  
>      if (slot->memory_size && !new && (mem.flags ^ slot->old_flags) & KVM_MEM_READONLY) {
>          /* Set the slot size to 0 before setting the slot to the desired
>           * value. This is needed based on KVM commit 75d61fbc. */
>          mem.memory_size = 0;
> -        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +
> +        if (cap_user_memory2) {
> +            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
> +        } else {
> +            ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +	    }
>          if (ret < 0) {
>              goto err;
>          }
>      }
>      mem.memory_size = slot->memory_size;
> -    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +    if (cap_user_memory2) {
> +        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION2, &mem);
> +    } else {
> +        ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
> +    }
>      slot->old_flags = mem.flags;
>  err:
>      trace_kvm_set_user_memory(mem.slot >> 16, (uint16_t)mem.slot, mem.flags,
>                                mem.guest_phys_addr, mem.memory_size,
> -                              mem.userspace_addr, ret);
> +                              mem.userspace_addr, mem.guest_memfd,
> +                              mem.guest_memfd_offset, ret);
>      if (ret < 0) {
> -        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
> -                     " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
> -                     __func__, mem.slot, slot->start_addr,
> -                     (uint64_t)mem.memory_size, strerror(errno));
> +        if (cap_user_memory2) {
> +                error_report("%s: KVM_SET_USER_MEMORY_REGION2 failed, slot=%d,"
> +                        " start=0x%" PRIx64 ", size=0x%" PRIx64 ","
> +                        " flags=0x%" PRIx32 ", guest_memfd=%" PRId32 ","
> +                        " guest_memfd_offset=0x%" PRIx64 ": %s",
> +                        __func__, mem.slot, slot->start_addr,
> +                        (uint64_t)mem.memory_size, mem.flags,
> +                        mem.guest_memfd, (uint64_t)mem.guest_memfd_offset,
> +                        strerror(errno));
> +        } else {
> +                error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=%d,"
> +                            " start=0x%" PRIx64 ", size=0x%" PRIx64 ": %s",
> +                            __func__, mem.slot, slot->start_addr,
> +                            (uint64_t)mem.memory_size, strerror(errno));
> +        }
>      }
>      return ret;
>  }
> @@ -477,6 +511,9 @@ static int kvm_mem_flags(MemoryRegion *mr)
>      if (readonly && kvm_readonly_mem_allowed) {
>          flags |= KVM_MEM_READONLY;
>      }
> +    if (memory_region_has_guest_memfd(mr)) {
> +        flags |= KVM_MEM_PRIVATE;
> +    }

Nitpick: it was renamed to KVM_MEM_GUEST_MEMFD
As long as the value is defined to same value, it doesn't matter, though.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>

