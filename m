Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B27EC0D6
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:39:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3DHv-0002yl-7M; Wed, 15 Nov 2023 05:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3DHt-0002yP-Sy
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3DHp-0004wD-Si
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700044700;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rcG7n1tgHsaIQSQt+tUDuJ97KkMlvUzZyKbsQC5/QQw=;
 b=YMS1Wtd9lj1WnFnL2jij8XO/QfrHMNFt9bR/RXMLvpidY66SMQ/KZplOk/1+SqxXWqCuQ4
 svChp3GtYifORynqaTnwyZwVTEEsxqLAiZUuGQa3ewn0jvE5k9dE8b5M/09DQ2PNCGGH1g
 xQ742Kt/DUROjx05Y+sACA0PvMxaBHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-AhCX-E2_MXGcuAz137XuOg-1; Wed, 15 Nov 2023 05:38:17 -0500
X-MC-Unique: AhCX-E2_MXGcuAz137XuOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7864101A53B;
 Wed, 15 Nov 2023 10:38:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8AC22166B28;
 Wed, 15 Nov 2023 10:38:12 +0000 (UTC)
Date: Wed, 15 Nov 2023 10:38:10 +0000
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
Subject: Re: [PATCH v3 06/70] kvm: Introduce support for memory_attributes
Message-ID: <ZVSfkgidWqUYHHSO@redhat.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-7-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-7-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 15, 2023 at 02:14:15AM -0500, Xiaoyao Li wrote:
> Introduce the helper functions to set the attributes of a range of
> memory to private or shared.
> 
> This is necessary to notify KVM the private/shared attribute of each gpa
> range. KVM needs the information to decide the GPA needs to be mapped at
> hva-based shared memory or guest_memfd based private memory.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  accel/kvm/kvm-all.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/kvm.h |  3 +++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 69afeb47c9c0..76e2404d54d2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -102,6 +102,7 @@ bool kvm_has_guest_debug;
>  static int kvm_sstep_flags;
>  static bool kvm_immediate_exit;
>  static bool kvm_guest_memfd_supported;
> +static uint64_t kvm_supported_memory_attributes;
>  static hwaddr kvm_max_slot_size = ~0;
>  
>  static const KVMCapabilityInfo kvm_required_capabilites[] = {
> @@ -1305,6 +1306,44 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
>      kvm_max_slot_size = max_slot_size;
>  }
>  
> +static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
> +{
> +    struct kvm_memory_attributes attrs;
> +    int r;
> +
> +    attrs.attributes = attr;
> +    attrs.address = start;
> +    attrs.size = size;
> +    attrs.flags = 0;
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
> +    if (r) {
> +        warn_report("%s: failed to set memory (0x%lx+%#zx) with attr 0x%lx error '%s'",
> +                     __func__, start, size, attr, strerror(errno));

This is an error condition rather than an warning condition.

Also again I think __func__ is generally not required in an error message,
if the error message text is suitably descriptive - applies to other
patches in this series too.

> +    }
> +    return r;
> +}
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
> +{
> +    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
> +        return -EINVAL;
> +    }
> +
> +    return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
> +{
> +    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
> +        return -EINVAL;
> +    }
> +
> +    return kvm_set_memory_attributes(start, size, 0);
> +}
> +
>  /* Called with KVMMemoryListener.slots_lock held */
>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                               MemoryRegionSection *section, bool add)
> @@ -2440,6 +2479,9 @@ static int kvm_init(MachineState *ms)
>  
>      kvm_guest_memfd_supported = kvm_check_extension(s, KVM_CAP_GUEST_MEMFD);
>  
> +    ret = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> +    kvm_supported_memory_attributes = ret > 0 ? ret : 0;
> +
>      if (object_property_find(OBJECT(current_machine), "kvm-type")) {
>          g_autofree char *kvm_type = object_property_get_str(OBJECT(current_machine),
>                                                              "kvm-type",
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index fedc28c7d17f..0e88958190a4 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -540,4 +540,7 @@ bool kvm_dirty_ring_enabled(void);
>  uint32_t kvm_dirty_ring_size(void);
>  
>  int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
> +
> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size);
> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size);
>  #endif
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


