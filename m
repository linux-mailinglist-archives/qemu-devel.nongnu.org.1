Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C8A80A409
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 13:59:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBaQm-0001Tr-JY; Fri, 08 Dec 2023 07:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBaQk-0001TO-4f
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:58:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBaQi-0006NH-5w
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702040286;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vVTgsxxKHeVxDAxU5EoOtsmfcdHjO90oRXoAUu5XcE=;
 b=JhlCVd0U+A8gGwxpBUE1T7gbn6VlV/s7R4E0PC044ofEqvG15Z7C85Q+QVuWnTDodPuRAc
 9xmjaYTpsjs4npV5dmdjMc1mugWTjot/xulQajngnv2ODxQIhBKEe0PWTmRj7iknGKOjQx
 7/9JAYURe5gKWMGqLxj5Wk2JlVX3//c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-rzuaRjAnMwyTph50CA28yA-1; Fri,
 08 Dec 2023 07:58:03 -0500
X-MC-Unique: rzuaRjAnMwyTph50CA28yA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F91C1C06340;
 Fri,  8 Dec 2023 12:58:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9442026D66;
 Fri,  8 Dec 2023 12:58:01 +0000 (UTC)
Date: Fri, 8 Dec 2023 12:57:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 4096
Message-ID: <ZXMS15q8x5-cWPA3@redhat.com>
References: <20231208122611.32311-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208122611.32311-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Fri, Dec 08, 2023 at 05:56:11PM +0530, Ani Sinha wrote:
> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> enabled in the kernel. So bump up the max_cpus value for q35 machines versions
> 8.3 and newer to 4096. Older q35 machines versions 8.2 and older continue to
> support 1024 maximum vcpus as before.
> 
> If KVM is not able to support the specified number of vcpus, QEMU would
> return the following error messages:
> 
> $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 4096
> qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (4096) exceeds the recommended cpus supported by KVM (12)
> Number of SMP cpus requested (4096) exceeds the maximum cpus supported by KVM (1024)
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc_q35.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

What testing has been done to confirm if QEMU is actually capable of
booting a guest with this CPU count, either UEFI or SeaBIOS or both ?

Historically every time we wanted to raise max cpus we've seen limits
or scalability problems that needed fixing first. The previous bump to
1024 had been implicitly proven via downstream testing we had done in
RHEL, and had required the switch to SMBIOS v3 entrypoint.

> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 4f3e5412f6..2ed57814e1 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_nic = "e1000e";
>      m->default_kernel_irqchip_split = false;
>      m->no_floppy = 1;
> -    m->max_cpus = 1024;
> +    m->max_cpus = 4096;
>      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> @@ -383,12 +383,22 @@ static void pc_q35_machine_options(MachineClass *m)
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
>  }
>  
> -static void pc_q35_8_2_machine_options(MachineClass *m)
> +static void pc_q35_8_3_machine_options(MachineClass *m)
>  {
>      pc_q35_machine_options(m);
>      m->alias = "q35";
>  }
>  
> +DEFINE_Q35_MACHINE(v8_3, "pc-q35-8.3", NULL,
> +                   pc_q35_8_3_machine_options);
> +
> +static void pc_q35_8_2_machine_options(MachineClass *m)
> +{
> +    pc_q35_8_3_machine_options(m);
> +    m->alias = NULL;
> +    m->max_cpus = 1024;
> +}
> +
>  DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
>                     pc_q35_8_2_machine_options);
>  
> @@ -396,7 +406,6 @@ static void pc_q35_8_1_machine_options(MachineClass *m)
>  {
>      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_8_2_machine_options(m);
> -    m->alias = NULL;
>      pcmc->broken_32bit_mem_addr_check = true;
>      compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>      compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
> -- 
> 2.42.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


