Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876A7825E1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 10:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY0gm-0003Tx-8u; Mon, 21 Aug 2023 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY0gk-0003Td-1l
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY0gh-0005hK-Cz
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692608101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=64IlXoHcWFuk1BuC9R5Kab266MUuvHk4NUheIKlqxCY=;
 b=OT6OCteJXGqzp3pjQ43N6a+pcX8TP5hrgUpP+5GnU2PzU6mswuGzbvjeR67cnkRFuimh/4
 qhgf0JuprpEl29GscWZ5WmyHQzt97Ip4OnMEw5pqEmepRXqglSmJ5yDyFP4yGMDpoa/zVW
 nOli9/gFBaqXhwQD0aZ/v5hcNQUq4BY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-ixjq0Id4Muqt63CrqJU3ig-1; Mon, 21 Aug 2023 04:54:58 -0400
X-MC-Unique: ixjq0Id4Muqt63CrqJU3ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0F33813F21;
 Mon, 21 Aug 2023 08:54:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFB011121314;
 Mon, 21 Aug 2023 08:54:54 +0000 (UTC)
Date: Mon, 21 Aug 2023 09:54:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 14/58] i386/tdx: Initialize TDX before creating TD vcpus
Message-ID: <ZOMmXC26ZgzMDssh@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-15-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-15-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 18, 2023 at 05:49:57AM -0400, Xiaoyao Li wrote:
> Invoke KVM_TDX_INIT in kvm_arch_pre_create_vcpu() that KVM_TDX_INIT
> configures global TD configurations, e.g. the canonical CPUID config,
> and must be executed prior to creating vCPUs.
> 
> Use kvm_x86_arch_cpuid() to setup the CPUID settings for TDX VM.
> 
> Note, this doesn't address the fact that QEMU may change the CPUID
> configuration when creating vCPUs, i.e. punts on refactoring QEMU to
> provide a stable CPUID config prior to kvm_arch_init().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  accel/kvm/kvm-all.c        |  9 +++++++-
>  target/i386/kvm/kvm.c      |  8 +++++++
>  target/i386/kvm/tdx-stub.c |  5 +++++
>  target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h      |  4 ++++
>  5 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 5071af917ae0..fceec7f2a83f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -435,10 +435,17 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>  
>      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  
> +    /*
> +     * tdx_pre_create_vcpu() may call cpu_x86_cpuid(). It in turn may call
> +     * kvm_vm_ioctl(). Set cpu->kvm_state in advance to avoid NULL pointer
> +     * dereference.
> +     */
> +    cpu->kvm_state = s;
>      ret = kvm_arch_pre_create_vcpu(cpu);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "%s: kvm_arch_pre_create_vcpu() failed",
>                          __func__);
> +        cpu->kvm_state = NULL;
>          goto err;
>      }
>  
> @@ -446,11 +453,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu failed (%lu)",
>                           kvm_arch_vcpu_id(cpu));
> +        cpu->kvm_state = NULL;
>          goto err;
>      }
>  
>      cpu->kvm_fd = ret;
> -    cpu->kvm_state = s;
>      cpu->vcpu_dirty = true;
>      cpu->dirty_pages = 0;
>      cpu->throttle_us_per_full = 0;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9ee41fffc445..d51067fdc12a 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2331,6 +2331,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      return r;
>  }
>  
> +int kvm_arch_pre_create_vcpu(CPUState *cpu)
> +{
> +    if (is_tdx_vm())
> +        return tdx_pre_create_vcpu(cpu);

Curly braces needed for coding style - run 'scripts/checkpatch.pl'
to validate it.

> +
> +    return 0;
> +}
> +
>  int kvm_arch_destroy_vcpu(CPUState *cs)
>  {
>      X86CPU *cpu = X86_CPU(cs);
> diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
> index 1d866d5496bf..61f70cc0d1d9 100644
> --- a/target/i386/kvm/tdx-stub.c
> +++ b/target/i386/kvm/tdx-stub.c
> @@ -6,3 +6,8 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
>  {
>      return -EINVAL;
>  }
> +
> +int tdx_pre_create_vcpu(CPUState *cpu)
> +{
> +    return -EINVAL;
> +}
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 29f50fb9529e..3d313ed46bd1 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -458,6 +458,49 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
>      return 0;
>  }
>  
> +int tdx_pre_create_vcpu(CPUState *cpu)

Add 'Error **errp' to this method

> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    struct kvm_tdx_init_vm *init_vm;
> +    int r = 0;
> +
> +    qemu_mutex_lock(&tdx_guest->lock);
> +    if (tdx_guest->initialized) {
> +        goto out;
> +    }
> +
> +    init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
> +                        sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
> +
> +    r = kvm_vm_enable_cap(kvm_state, KVM_CAP_MAX_VCPUS, 0, ms->smp.cpus);
> +    if (r < 0) {
> +        error_report("Unable to set MAX VCPUS to %d", ms->smp.cpus);

Use error_setg / error_setg_errno in this method.

> +        goto out_free;
> +    }
> +
> +    init_vm->cpuid.nent = kvm_x86_arch_cpuid(env, init_vm->cpuid.entries, 0);
> +
> +    init_vm->attributes = tdx_guest->attributes;
> +
> +    do {
> +        r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
> +    } while (r == -EAGAIN);
> +    if (r < 0) {
> +        error_report("KVM_TDX_INIT_VM failed %s", strerror(-r));
> +        goto out_free;
> +    }
> +
> +    tdx_guest->initialized = true;
> +
> +out_free:
> +    g_free(init_vm);
> +out:
> +    qemu_mutex_unlock(&tdx_guest->lock);
> +    return r;
> +}
> +
>  /* tdx guest */
>  OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>                                     tdx_guest,
> @@ -470,6 +513,8 @@ static void tdx_guest_init(Object *obj)
>  {
>      TdxGuest *tdx = TDX_GUEST(obj);
>  
> +    qemu_mutex_init(&tdx->lock);
> +
>      tdx->attributes = 0;
>  }
>  
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index 06599b65b827..46a24ee8c7cc 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -17,6 +17,9 @@ typedef struct TdxGuestClass {
>  typedef struct TdxGuest {
>      ConfidentialGuestSupport parent_obj;
>  
> +    QemuMutex lock;
> +
> +    bool initialized;
>      uint64_t attributes;    /* TD attributes */
>  } TdxGuest;
>  
> @@ -29,5 +32,6 @@ bool is_tdx_vm(void);
>  int tdx_kvm_init(MachineState *ms, Error **errp);
>  void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
>                               uint32_t *ret);
> +int tdx_pre_create_vcpu(CPUState *cpu);
>  
>  #endif /* QEMU_I386_TDX_H */
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


