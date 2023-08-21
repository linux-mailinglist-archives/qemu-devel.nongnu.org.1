Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B923A78264E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1FW-00057z-Cx; Mon, 21 Aug 2023 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1FS-00051R-97
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1FP-00050J-P4
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692610254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EYCyGoQNEU4xYIbssbxjHO1jV4aXkCa+aYH+TfRpxsM=;
 b=KTKO/rnKEigFzMwEWfm0v2GzWXBsPcKHWmx7uBtxVw+4C5UXg/gClBKwp9nODKEYAsA5W/
 GTUncdg0UaXVLtMx+NxaYtgd26t9rrAbFBdk8bxFQL3aWQC9mf1kT1ThAc4PgFof+hsfgB
 9VY1r/0LVdMgn1mAB64DJ0GMzH12vSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-2G95SBrCNEeaqwzaCninFQ-1; Mon, 21 Aug 2023 05:30:50 -0400
X-MC-Unique: 2G95SBrCNEeaqwzaCninFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8ED785CBEE;
 Mon, 21 Aug 2023 09:30:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26BD3492C13;
 Mon, 21 Aug 2023 09:30:47 +0000 (UTC)
Date: Mon, 21 Aug 2023 10:30:45 +0100
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
Subject: Re: [PATCH v2 21/58] i386/tdx: Implement user specified tsc frequency
Message-ID: <ZOMuxfyS8J0pUIph@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-22-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-22-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Aug 18, 2023 at 05:50:04AM -0400, Xiaoyao Li wrote:
> Reuse "-cpu,tsc-frequency=" to get user wanted tsc frequency and call VM
> scope VM_SET_TSC_KHZ to set the tsc frequency of TD before KVM_TDX_INIT_VM.
> 
> Besides, sanity check the tsc frequency to be in the legal range and
> legal granularity (required by TDX module).
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes from RFC v4:
>   - Use VM scope VM_SET_TSC_KHZ to set the TSC frequency of TD since KVM
>     side drop the @tsc_khz field in struct kvm_tdx_init_vm
> ---
>  target/i386/kvm/kvm.c |  9 +++++++++
>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index d51067fdc12a..4a146bc42f63 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -859,6 +859,15 @@ static int kvm_arch_set_tsc_khz(CPUState *cs)
>      int r, cur_freq;
>      bool set_ioctl = false;
>  
> +    /*
> +     * TSC of TD vcpu is immutable, it cannot be set/changed via vcpu scope
> +     * VM_SET_TSC_KHZ, but only be initialized via VM scope VM_SET_TSC_KHZ
> +     * before ioctl KVM_TDX_INIT_VM in tdx_pre_create_vcpu()
> +     */
> +    if (is_tdx_vm()) {
> +        return 0;
> +    }
> +
>      if (!env->tsc_khz) {
>          return 0;
>      }
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 33d015a08c34..a72badfbfd65 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -32,6 +32,9 @@
>                                       (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
>                                       (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
>  
> +#define TDX_MIN_TSC_FREQUENCY_KHZ   (100 * 1000)
> +#define TDX_MAX_TSC_FREQUENCY_KHZ   (10 * 1000 * 1000)
> +
>  #define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>  #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>  #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
> @@ -513,6 +516,27 @@ int tdx_pre_create_vcpu(CPUState *cpu)
>          goto out_free;
>      }
>  
> +    r = -EINVAL;
> +    if (env->tsc_khz && (env->tsc_khz < TDX_MIN_TSC_FREQUENCY_KHZ ||
> +                         env->tsc_khz > TDX_MAX_TSC_FREQUENCY_KHZ)) {
> +        error_report("Invalid TSC %ld KHz, must specify cpu_frequency between [%d, %d] kHz",
> +                      env->tsc_khz, TDX_MIN_TSC_FREQUENCY_KHZ,
> +                      TDX_MAX_TSC_FREQUENCY_KHZ);
> +        goto out;
> +    }
> +
> +    if (env->tsc_khz % (25 * 1000)) {
> +        error_report("Invalid TSC %ld KHz, it must be multiple of 25MHz", env->tsc_khz);
> +        goto out;
> +    }
> +
> +    /* it's safe even env->tsc_khz is 0. KVM uses host's tsc_khz in this case */
> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
> +    if (r < 0) {
> +        error_report("Unable to set TSC frequency to %" PRId64 " kHz", env->tsc_khz);
> +        goto out;
> +    }

error_setg(errp, ....) in all of these cases.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


