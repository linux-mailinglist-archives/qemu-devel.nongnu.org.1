Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C407A4BE6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiG5I-0004Na-0S; Mon, 18 Sep 2023 11:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiG56-0004Ll-8k
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiG53-00030N-7t
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695050550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhPKhEKas+a8AfY2MIZoynJjZDKWmqdGxlMEMJXe3F8=;
 b=bqo+3fNtRuTY8HdusRUseVrHs5r9Xk2V0SrTPgafar2WmCn8a3mJy6U4pU46NbVx7GbUfz
 lUs1sAKR0Uolil1s0cse8wCATaa+Q3pkdnxJLxg258aHrlfyRglwAyJe2kDHhwDzZbxKL8
 y/CFK7XTNcBlcuFYTEawh8WfWLGwOd0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-6goR7hmVN_CqLxkkWaIHJA-1; Mon, 18 Sep 2023 11:22:29 -0400
X-MC-Unique: 6goR7hmVN_CqLxkkWaIHJA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c0212e79b3so1617961fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695050548; x=1695655348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhPKhEKas+a8AfY2MIZoynJjZDKWmqdGxlMEMJXe3F8=;
 b=my9zi6z0P5rV4R5r3D8yoNieFTL3TlFxyIK8RB/dbiOWwfFl72/qizqHe4lbz1e7ii
 WqCdGjLasN3deTDCgWCqQIucmjnQkkb1GFHMrCr7nfbxh4dBtiNdYZ8Bjz9mRnekPWrW
 Ds8jnYtAAw1vCs6P4PzwXmKPAnt7CSbGD5XSWM2PUbq3hNRVlapHEulWLxCKoJD+6tue
 fL5l2JWsShiDbxD85VwGy8wphea0qLgA/2Bi5YU+hy3cmHhgzEYbLxKlVM90XiG8aDJW
 FKrMIi29DQS9yon1c1E8VaDd3YlAAitL5daGYlW+jcNaL+RFz+Sp8GmkQRoY2K9Uu1es
 UxFQ==
X-Gm-Message-State: AOJu0YxsvkiAh7bJAF9eObGquVFzIGj9TOhCPW8neRx8AusZGzWhO3Cx
 gxmoGFqRkqPVqxO5JUsG0jZRP5IEc6VK76IV5ZhSgIBRrv5DnID/EdJM/RimAERFZY/9tiRD6X5
 iaRxpN6JTqBiGrmUUj7YD0hUx5MiE8jw=
X-Received: by 2002:a2e:7213:0:b0:2bc:f41a:d9c6 with SMTP id
 n19-20020a2e7213000000b002bcf41ad9c6mr7471003ljc.0.1695050547848; 
 Mon, 18 Sep 2023 08:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHYUDyoThJTjMHx4a4Iu3v6NUFbLv3bPieXZOVJpOe9Kca0+irZHpQLMzl3Ln2Rg5yJ37hINsoy2SS+MoUUq4=
X-Received: by 2002:a2e:7213:0:b0:2bc:f41a:d9c6 with SMTP id
 n19-20020a2e7213000000b002bcf41ad9c6mr7470986ljc.0.1695050547506; Mon, 18 Sep
 2023 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135448.90963-1-anisinha@redhat.com>
In-Reply-To: <20230918135448.90963-1-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 18 Sep 2023 20:52:16 +0530
Message-ID: <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
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

On Mon, Sep 18, 2023 at 7:25=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
>
> 32-bit systems do not have a reserved memory for hole64 but they may have=
 a
> reserved memory space for memory hotplug. Since, hole64 starts after the
> reserved hotplug memory, the unaligned hole64 start address gives us the
> end address for this memory hotplug region that the processor may use.
> Fix this. This ensures that the physical address space bound checking wor=
ks
> correctly for 32-bit systems as well.

This patch breaks some unit tests. I am not sure why it did not catch
it when I tested it before sending.
Will have to resend after fixing the tests.

>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/pc.c | 60 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..c8abcabd53 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -904,13 +904,43 @@ static uint64_t pc_get_cxl_range_end(PCMachineState=
 *pcms)
>      return start;
>  }
>
> +/*
> + * The 64bit pci hole starts after "above 4G RAM" and
> + * potentially the space reserved for memory hotplug.
> + * This function returns unaligned start address.
> + */
> +static uint64_t pc_pci_hole64_start_unaligned(void)
> +{
> +    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> +    MachineState *ms =3D MACHINE(pcms);
> +    uint64_t hole64_start =3D 0;
> +    ram_addr_t size =3D 0;
> +
> +    if (pcms->cxl_devices_state.is_enabled) {
> +        hole64_start =3D pc_get_cxl_range_end(pcms);
> +    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_s=
ize)) {
> +        pc_get_device_memory_range(pcms, &hole64_start, &size);
> +        if (!pcmc->broken_reserved_end) {
> +            hole64_start +=3D size;
> +        }
> +    } else {
> +        hole64_start =3D pc_above_4g_end(pcms);
> +    }
> +
> +    return hole64_start;
> +}
> +
>  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_=
size)
>  {
>      X86CPU *cpu =3D X86_CPU(first_cpu);
>
> -    /* 32-bit systems don't have hole64 thus return max CPU address */
> -    if (cpu->phys_bits <=3D 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64, but we might have a region for
> +     * memory hotplug.
> +     */
> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        return pc_pci_hole64_start_unaligned() - 1;
>      }
>
>      return pc_pci_hole64_start() + pci_hole64_size - 1;
> @@ -1147,30 +1177,10 @@ void pc_memory_init(PCMachineState *pcms,
>      pcms->memhp_io_base =3D ACPI_MEMORY_HOTPLUG_BASE;
>  }
>
> -/*
> - * The 64bit pci hole starts after "above 4G RAM" and
> - * potentially the space reserved for memory hotplug.
> - */
> +/* returns 1 GiB aligned hole64 start address */
>  uint64_t pc_pci_hole64_start(void)
>  {
> -    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    MachineState *ms =3D MACHINE(pcms);
> -    uint64_t hole64_start =3D 0;
> -    ram_addr_t size =3D 0;
> -
> -    if (pcms->cxl_devices_state.is_enabled) {
> -        hole64_start =3D pc_get_cxl_range_end(pcms);
> -    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_s=
ize)) {
> -        pc_get_device_memory_range(pcms, &hole64_start, &size);
> -        if (!pcmc->broken_reserved_end) {
> -            hole64_start +=3D size;
> -        }
> -    } else {
> -        hole64_start =3D pc_above_4g_end(pcms);
> -    }
> -
> -    return ROUND_UP(hole64_start, 1 * GiB);
> +    return ROUND_UP(pc_pci_hole64_start_unaligned(), 1 * GiB);
>  }
>
>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
> --
> 2.39.1
>


