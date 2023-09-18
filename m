Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4C87A4AF6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEoe-0004vb-Ua; Mon, 18 Sep 2023 10:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiEod-0004vF-DL
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qiEob-0002vV-LU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695045688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXwo33lGJ12w0TugzJdTJJsO9EqhjlsTzVP6gblcrIw=;
 b=W0H1KyL2NcFDBmxqFcuvNChe/y1/5OVSV7FKuLb8hW2oqRBLGItZ7n38iKWlprK+v8vXSd
 h66MqkiF6hRXtIV4i1RdH5/OylwbBbLkHd72C94gd5NBO4gqTunXjdrzQR/+k9lmu8quqB
 8allWsxRs208GmLswDlcl8H/Jd1Q5I0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-nRpEMwwfPvuzQ6UBpCfVHQ-1; Mon, 18 Sep 2023 10:01:26 -0400
X-MC-Unique: nRpEMwwfPvuzQ6UBpCfVHQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5009796123dso5431526e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695045685; x=1695650485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXwo33lGJ12w0TugzJdTJJsO9EqhjlsTzVP6gblcrIw=;
 b=PAWf+gHQLwF4LIwWkBl9tTkiqlDB8+NE22tvTMh28RlTWZVuPBNQudLrhoNQoxqoJj
 y9u9XrN3GZNF+BKNkmub+J8nIq+nLHGKVHNVmMZUTJJjSenlA5ZejmmsrHhalx2KZAwL
 9YSbuTkSU/6A2LES/QyUp8Qhyyc+i2//YtZ1vBfLDbVX6ebIt+AmR7y0ZxQdn7eCwYgv
 I7dNpzgdTc70A07lCmI7RPVjSRj/7Atvgy6qrneVASciwnMV+PMPS3rB6pigJSHpegkO
 XhzCqOnjt8o4L4jubF3GXWqem9Fb4aEXMjSp74HUUj/pshq2rg9wXSvLxqDBI2uh5NAT
 +mRA==
X-Gm-Message-State: AOJu0YyNmGVRu8+VptULM9BWgOMSQOppQw1L17EhqEYifPd2LFdJMJEB
 aZ/3uVBYsJS+2xFmfk2uhTiR0TjPz2AOC/xNxNhHMaoDuC/qRYq0u5kHXTv5B2+Y7DFWkjSt68T
 55Z4t/MwFweRtl0w=
X-Received: by 2002:ac2:5586:0:b0:500:b5db:990b with SMTP id
 v6-20020ac25586000000b00500b5db990bmr6773881lfg.47.1695045684917; 
 Mon, 18 Sep 2023 07:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0IhY00aXtpU/SqHP9VDzxBlU7hLfgHJUv6DO03Ya0bAl5amzYCtXjA1HzYH7aD24oMZfEQA==
X-Received: by 2002:ac2:5586:0:b0:500:b5db:990b with SMTP id
 v6-20020ac25586000000b00500b5db990bmr6773806lfg.47.1695045683061; 
 Mon, 18 Sep 2023 07:01:23 -0700 (PDT)
Received: from redhat.com ([2.52.3.35]) by smtp.gmail.com with ESMTPSA id
 f23-20020a056402161700b00525503fac84sm6012742edv.25.2023.09.18.07.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:01:22 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:01:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: david@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
Message-ID: <20230918095905-mutt-send-email-mst@kernel.org>
References: <20230918135448.90963-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918135448.90963-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 07:24:48PM +0530, Ani Sinha wrote:
> 32-bit systems do not have a reserved memory for hole64 but they may have a
> reserved memory space for memory hotplug. Since, hole64 starts after the
> reserved hotplug memory, the unaligned hole64 start address gives us the
> end address for this memory hotplug region that the processor may use.
> Fix this. This ensures that the physical address space bound checking works
> correctly for 32-bit systems as well.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>


I doubt we can make changes like this without compat machinery. No?

> ---
>  hw/i386/pc.c | 60 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..c8abcabd53 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -904,13 +904,43 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
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
> +    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    MachineState *ms = MACHINE(pcms);
> +    uint64_t hole64_start = 0;
> +    ram_addr_t size = 0;
> +
> +    if (pcms->cxl_devices_state.is_enabled) {
> +        hole64_start = pc_get_cxl_range_end(pcms);
> +    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
> +        pc_get_device_memory_range(pcms, &hole64_start, &size);
> +        if (!pcmc->broken_reserved_end) {
> +            hole64_start += size;
> +        }
> +    } else {
> +        hole64_start = pc_above_4g_end(pcms);
> +    }
> +
> +    return hole64_start;
> +}
> +
>  static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>  {
>      X86CPU *cpu = X86_CPU(first_cpu);
>  
> -    /* 32-bit systems don't have hole64 thus return max CPU address */
> -    if (cpu->phys_bits <= 32) {
> -        return ((hwaddr)1 << cpu->phys_bits) - 1;
> +    /*
> +     * 32-bit systems don't have hole64, but we might have a region for
> +     * memory hotplug.
> +     */
> +    if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        return pc_pci_hole64_start_unaligned() - 1;
>      }
>  

I see you are changing cpu->phys_bits to a CPUID check.
Could you explain why in the commit log?

>      return pc_pci_hole64_start() + pci_hole64_size - 1;
> @@ -1147,30 +1177,10 @@ void pc_memory_init(PCMachineState *pcms,
>      pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
>  }
>  
> -/*
> - * The 64bit pci hole starts after "above 4G RAM" and
> - * potentially the space reserved for memory hotplug.
> - */
> +/* returns 1 GiB aligned hole64 start address */
>  uint64_t pc_pci_hole64_start(void)
>  {
> -    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> -    MachineState *ms = MACHINE(pcms);
> -    uint64_t hole64_start = 0;
> -    ram_addr_t size = 0;
> -
> -    if (pcms->cxl_devices_state.is_enabled) {
> -        hole64_start = pc_get_cxl_range_end(pcms);
> -    } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
> -        pc_get_device_memory_range(pcms, &hole64_start, &size);
> -        if (!pcmc->broken_reserved_end) {
> -            hole64_start += size;
> -        }
> -    } else {
> -        hole64_start = pc_above_4g_end(pcms);
> -    }
> -
> -    return ROUND_UP(hole64_start, 1 * GiB);
> +    return ROUND_UP(pc_pci_hole64_start_unaligned(), 1 * GiB);
>  }
>  
>  DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
> -- 
> 2.39.1


