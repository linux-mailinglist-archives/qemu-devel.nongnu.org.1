Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133B7EC0E3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:43:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3DM4-0005rz-Li; Wed, 15 Nov 2023 05:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3DM1-0005oN-8h
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:42:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3DLy-0005xH-G6
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700044955;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DBtY48dW5FDAaMIcFUThoBhO+9fnXcfuCT2ZrkWuo/I=;
 b=LQh2Kzhn5dera8Dwca87fEWnTpsgIfc+RAaQ0Bqm0evyDFp2lR1cp184D+VW2ghK0g3k4D
 UvuasTMUAeiaLfe8JJJFirGrOzq1M1nGtKuVN5IVuaEusbQ9tfLZ1fyJrm4tGy+xVVQcIC
 mCBgx5alx7t3ZKIfhDhFG0z111MN6No=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Azq19YFMPAeZP8aQ4aJB_A-1; Wed, 15 Nov 2023 05:42:32 -0500
X-MC-Unique: Azq19YFMPAeZP8aQ4aJB_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82893811E7B;
 Wed, 15 Nov 2023 10:42:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9C14C2E120;
 Wed, 15 Nov 2023 10:42:26 +0000 (UTC)
Date: Wed, 15 Nov 2023 10:42:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 10/70] kvm: handle KVM_EXIT_MEMORY_FAULT
Message-ID: <ZVSgkM1H7O0BLbEf@redhat.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-11-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-11-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 15, 2023 at 02:14:19AM -0500, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
> KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
> the memory conversion on the RAMBlock to turn the memory into desired
> attribute, i.e., private/shared.
> 
> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
> guest_memfd memory backend.
> 
> Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
> added.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c | 76 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 76e2404d54d2..58abbcb6926e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2902,6 +2902,50 @@ static void kvm_eat_signals(CPUState *cpu)
>      } while (sigismember(&chkset, SIG_IPI));
>  }
>  
> +static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
> +{
> +    MemoryRegionSection section;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
> +    void *addr;
> +    int ret = -1;
> +
> +    section = memory_region_find(get_system_memory(), start, size);
> +    if (!section.mr) {
> +        return ret;
> +    }
> +
> +    if (memory_region_has_guest_memfd(section.mr)) {
> +        if (to_private) {
> +            ret = kvm_set_memory_attributes_private(start, size);
> +        } else {
> +            ret = kvm_set_memory_attributes_shared(start, size);
> +        }
> +
> +        if (ret) {
> +            memory_region_unref(section.mr);
> +            return ret;
> +        }
> +
> +        addr = memory_region_get_ram_ptr(section.mr) +
> +               section.offset_within_region;
> +        rb = qemu_ram_block_from_host(addr, false, &offset);
> +        /*
> +         * With KVM_SET_MEMORY_ATTRIBUTES by kvm_set_memory_attributes(),
> +         * operation on underlying file descriptor is only for releasing
> +         * unnecessary pages.
> +         */
> +        ram_block_convert_range(rb, offset, size, to_private);
> +    } else {
> +        warn_report("Convert non guest_memfd backed memory region "
> +                    "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
> +                    start, size, to_private ? "private" : "shared");

Again, if you're returning '-1' to indicate error, then
using warn_report is wrong, it should be error_report.

warn_report is for when you return success, indicating
the problem was non-fatal.

> +    }
> +
> +    memory_region_unref(section.mr);
> +    return ret;
> +}
> +
>  int kvm_cpu_exec(CPUState *cpu)
>  {
>      struct kvm_run *run = cpu->kvm_run;
> @@ -2969,18 +3013,20 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret = EXCP_INTERRUPT;
>                  break;
>              }
> -            fprintf(stderr, "error: kvm run failed %s\n",
> -                    strerror(-run_ret));
> +            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
> +                fprintf(stderr, "error: kvm run failed %s\n",
> +                        strerror(-run_ret));
>  #ifdef TARGET_PPC
> -            if (run_ret == -EBUSY) {
> -                fprintf(stderr,
> -                        "This is probably because your SMT is enabled.\n"
> -                        "VCPU can only run on primary threads with all "
> -                        "secondary threads offline.\n");
> -            }
> +                if (run_ret == -EBUSY) {
> +                    fprintf(stderr,
> +                            "This is probably because your SMT is enabled.\n"
> +                            "VCPU can only run on primary threads with all "
> +                            "secondary threads offline.\n");
> +                }
>  #endif
> -            ret = -1;
> -            break;
> +                ret = -1;
> +                break;
> +            }
>          }
>  
>          trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
> @@ -3067,6 +3113,16 @@ int kvm_cpu_exec(CPUState *cpu)
>                  break;
>              }
>              break;
> +        case KVM_EXIT_MEMORY_FAULT:
> +            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
> +                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
> +                             (uint64_t)run->memory_fault.flags);
> +                ret = -1;
> +                break;
> +            }
> +            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
> +                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
> +            break;
>          default:
>              DPRINTF("kvm_arch_handle_exit\n");
>              ret = kvm_arch_handle_exit(cpu, run);
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


