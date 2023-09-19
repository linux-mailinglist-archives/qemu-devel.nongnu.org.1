Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCB7A61BD
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZHg-0006Rx-QM; Tue, 19 Sep 2023 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiZHZ-0006Rb-RE
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiZHY-0006dv-2b
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695124362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGpwzm7WblMPIQD4RW4ViuVqDccUCcv9k+f6C2RKHps=;
 b=R2lpEljTn8sCFxxg6hygcTwu9REqmj/iJStSO+tS/4fd+fhU57ymbUgRC3XZwu/RyuhpIy
 zoaVU9pp91Wsbt+SUCQTYCd+90PTnXvTkKX8SR3jU1/WlZJ4JsJAqMvyLSwJ343qhbW/4g
 DwqcgBRd8XtOxHXmcY1nPGiB7FN370s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-__xrihZQNkKSdrd-2sgxJA-1; Tue, 19 Sep 2023 07:52:41 -0400
X-MC-Unique: __xrihZQNkKSdrd-2sgxJA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so410574466b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695124360; x=1695729160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGpwzm7WblMPIQD4RW4ViuVqDccUCcv9k+f6C2RKHps=;
 b=hf3dPvlUQiPof5UlFAIiGvOaATyqh5yBsa8b+ad1I1b6pxpWY6CpdautpIRWZOMHNR
 VS5x0Lo9Zi3zvtMd/nb6ftfiCRhxOU3Rlo6deqULc2P93wa15/VRFN6iprfhLTwlY6XJ
 5nO4SibV57G7lnmgnkRY/GqtDxu8WACRySr92bLVrcLHOVGZBDkitcXSYX6TOgMe0cJM
 XUbPXeMIf7Is3O6GGXr4KKb+JLRx+nwWGaUO9u2nt1egpPYauX42lF3PGlXZihZ+Kj0Q
 mN5JWx8tIBDJe/w43FsdjCZdxWT2Owo0f4naLJ6pVpUGDyO0D56z93lL7FMs0kcdgwSA
 SQKg==
X-Gm-Message-State: AOJu0Yw4jG01UG2KEOEq9mq45FpCflfSxseEJYB8OA6uPNDY5bK0yrx2
 Fpjdk6iAcXt6dTlDzTNBTJGsYTjJmbJNlXJiYjYeL3VAvmx5a671ouu2D90ajUVMEFxwGwnUKcy
 0sSTY64i0+wAkC44b4PccqimHerkhWYE=
X-Received: by 2002:a17:907:2724:b0:9a9:e4ba:2da7 with SMTP id
 d4-20020a170907272400b009a9e4ba2da7mr9626858ejl.49.1695124360163; 
 Tue, 19 Sep 2023 04:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH+iWbC6g1O9Uy0ZjYVnhxSPiITPRWFdHJ8mrnftODsC/dSqa2pSf+bkxiQxCMLlzuH+kmQtDretfZa8xHZIQ=
X-Received: by 2002:a17:907:2724:b0:9a9:e4ba:2da7 with SMTP id
 d4-20020a170907272400b009a9e4ba2da7mr9626839ejl.49.1695124359748; Tue, 19 Sep
 2023 04:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230919103838.249317-1-anisinha@redhat.com>
In-Reply-To: <20230919103838.249317-1-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 19 Sep 2023 17:22:28 +0530
Message-ID: <CAK3XEhPqRTjSCuvsUHkdfH+1Yi=5TPREB3VWA0Chr+c_jdTiKQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/pc: improve physical address space bound check
 for 32-bit systems
To: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 4:08=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> 32-bit systems do not have a reserved memory for hole64 and memory hotplu=
g is
> not supported on those systems. Therefore, the maximum limit of the guest
> physical address coincides with the end of "above 4G memory space" region=
.
> Make sure that the end of "above 4G memory" is still addressible by the
> guest processor with its available address bits. For example, previously =
this
> was allowed:
>
> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
>
> Now it is no longer allowed:
>
> $ ./qemu-system-x86_64 -cpu pentium -m size=3D10G
> qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bit=
s too low (32)
>
> After calling CPUID with EAX=3D0x80000001, all AMD64 compliant processors
> have the longmode-capable-bit turned on in the extended feature flags (bi=
t 29)
> in EDX. The absence of CPUID longmode can be used to differentiate betwee=
n
> 32-bit and 64-bit processors and is the recommended approach. QEMU takes =
this
> approach elsewhere (for example, please see x86_cpu_realizefn()) and with
> this change, pc_max_used_gpa() also takes the same approach to detect 32-=
bit
> processors.
>
> Finally, a new compatibility flag is introduced to retain the old behavio=
r
> for pc_max_used_gpa() for macines 8.1 and older.
typo - will fix in v3                   ^^^^^^^^

btw, does this patch break it for processors < 32-bit? For them clearly

x86ms->above_4g_mem_start =3D 4 * GiB;

does not work.


>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc.c         | 17 ++++++++++++++---
>  hw/i386/pc_piix.c    |  4 ++++
>  include/hw/i386/pc.h |  3 +++
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> changelog:
> v2: removed memory hotplug region from max_gpa. added compat knobs.
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..fea97ee258 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -907,10 +907,20 @@ static uint64_t pc_get_cxl_range_end(PCMachineState=
 *pcms)
>  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_=
size)
>  {
>      X86CPU *cpu =3D X86_CPU(first_cpu);
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>
> -    /* 32-bit systems don't have hole64 thus return max CPU address */
> -    if (cpu->phys_bits <=3D 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64 and does not support
> +     * memory hotplug.
> +     */
> +    if (pcmc->fixed_32bit_mem_addr_check) {
> +        if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +            return pc_above_4g_end(pcms) - 1;
> +        }
> +    } else {
> +        if (cpu->phys_bits <=3D 32) {
> +            return ((hwaddr)1 << cpu->phys_bits) - 1;
> +        }
>      }
>
>      return pc_pci_hole64_start() + pci_hole64_size - 1;
> @@ -1867,6 +1877,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      pcmc->pvh_enabled =3D true;
>      pcmc->kvmclock_create_always =3D true;
>      pcmc->resizable_acpi_blob =3D true;
> +    pcmc->fixed_32bit_mem_addr_check =3D true;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>      mc->hotplug_allowed =3D pc_hotplug_allowed;
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8321f36f97..f100a5de8b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -517,9 +517,13 @@ DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
>
>  static void pc_i440fx_8_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +
>      pc_i440fx_8_2_machine_options(m);
>      m->alias =3D NULL;
>      m->is_default =3D false;
> +    pcmc->fixed_32bit_mem_addr_check =3D false;
> +
>      compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
>      compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
>  }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 0fabece236..5a70d163d0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -129,6 +129,9 @@ struct PCMachineClass {
>
>      /* resizable acpi blob compat */
>      bool resizable_acpi_blob;
> +
> +    /* fixed 32-bit processor address space bound check for memory */
> +    bool fixed_32bit_mem_addr_check;
>  };
>
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> --
> 2.39.1
>


