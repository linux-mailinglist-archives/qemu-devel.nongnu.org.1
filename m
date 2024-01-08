Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07DD82747F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:53:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrvM-0008Lz-Uh; Mon, 08 Jan 2024 10:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrvG-0008La-MN
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:52:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMrvE-0007k2-Qk
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:52:18 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-557c46872d3so627381a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704729134; x=1705333934; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWOvJQCyo5Mu6qlyfT/l/TSETsIQ8Mh8a+/P64TOwR0=;
 b=gjWYy8d23Z7//PO16fRUCc4wusFcRGtWNhvF98KXTJ4+UN3upOn8Uhsz45g5f1bIRi
 V9mJcCZDFyjLpMCS/rGsQV0vpAC0/TC8Nu7U5uzJYhycVAb5vNEMsT9w/f8BcGC+By6z
 hPQe4w/sAL/RNPUQu2ppZ55Gm2ahFpIbxxkZo1LHUQTtO9Rb3ByZUdqVdqFL4GK9fMZ8
 7kk+jL+QL3zxbHQ1IX8lI6OCKRdv/Iq2MG/CACkiQSpVjV3LapUPdSDIJ+Aq8dyqc/Iy
 3EsaX7GC7rW4Enzo3QWV2ApUcESYSYxKTPouFL2qN2hhiZHuMX6jYuLxfXZtEjLMFH+y
 fPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704729134; x=1705333934;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWOvJQCyo5Mu6qlyfT/l/TSETsIQ8Mh8a+/P64TOwR0=;
 b=EKRNGYj+wKHnyTsrp4srmm5ULxhgbwSgIfWJfbgIFt45Ws88N2R8n7uIQ3DYrD3ewh
 R1wyFQjKvgB53HAmRBn1o0+T2XfNkbxBGjJtsCX4qmhSW8HP/NWu44hvk8hbYI6D4Afy
 igxscFcKmPZajFGnagup9e9SnQEdFI4eRgGIh/tb6ZKgDPvxormV2ogW967YHVDlc6A+
 VeTtJOHTfjOlBiZu0BwHCZAOWON43AvFq7+93e1RxQ4TCIC7LABxmTkpMWw2HqqQXEak
 qrvXNP3dKSfSfeTtAQcafCpJ6d1FWjMT1zt3juoO9OBRyPUEm3l08xTPdt1/dCT+y+a9
 3paw==
X-Gm-Message-State: AOJu0YzlgwgWC5nx1O4uLlQUT6nRgJtTkoSzx1vqPGXx/O3unHaW9GIl
 tStN16H0ZoTszyMJU9QBKyrymMG1JBurCvwnX+18rxIkqkHVZd+LwIHobrjR
X-Google-Smtp-Source: AGHT+IHrqonjqMpAuzICGuQ7jHfX3dN8LcBZXv9hscgC5chtwGmRgLT+9PdiIsb4PXQX9J9cfhytmxiz0ATTydEvzHQ=
X-Received: by 2002:a50:c050:0:b0:557:6958:2af6 with SMTP id
 u16-20020a50c050000000b0055769582af6mr2255441edd.26.1704729134402; Mon, 08
 Jan 2024 07:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20180622125713.15303-1-peter.maydell@linaro.org>
 <20180622125713.15303-14-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-14-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 15:52:03 +0000
Message-ID: <CAFEAcA9ZQ7FCS=eTCvPNy+knpeia6r4GrF2UN5W2bE6znvonSA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 13/28] hw/arm/virt: Use 256MB ECAM region by
 default
To: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 22 Jun 2018 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> With this patch, virt-3.0 machine uses a new 256MB ECAM region
> by default instead of the legacy 16MB one, if highmem is set
> (LPAE supported by the guest) and (!firmware_loaded || aarch64).
>
> Indeed aarch32 mode FW may not support this high ECAM region.

This is a rather old change by now, but I've been looking
at it because it exposes an issue which was previously
masked by a different bug...

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d8abf89e8c8..0f8bfa57d7e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1318,6 +1318,7 @@ static void machvirt_init(MachineState *machine)
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    bool aarch64 = true;
>
>      /* We can probe only here because during property set
>       * KVM is not available yet
> @@ -1433,6 +1434,8 @@ static void machvirt_init(MachineState *machine)
>          numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
>                            &error_fatal);
>
> +        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
> +
>          if (!vms->secure) {
>              object_property_set_bool(cpuobj, false, "has_el3", NULL);
>          }
> @@ -1491,6 +1494,8 @@ static void machvirt_init(MachineState *machine)
>          create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
>      }
>
> +    vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);

Do you remember why this conditional is the way it is?
As it stands, it will disable the high-memory ECAM for
an AArch32 VM that's loaded firmware, but leaves it enabled
if we're direct booting Linux. That's a problem because 32-bit
Linux falls over if you pass it a highmem-ECAM, even if LPAE
is enabled (somewhere along the line it discards the high 32
bits of the address of the ECAM in the dtb, so it thinks the
ECAM overlaps with another memory region, and won't recognize
the pci controller; I have a feeling this is a regression in
the kernel). Plus, we have no way to tell if the guest
kernel has LPAE enabled at all.

Maybe it would be safer to insist that the guest is aarch64
before we enable highmem ECAM?

thanks
-- PMM

