Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C67AB7FF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 19:44:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkBt-000539-A6; Fri, 22 Sep 2023 13:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qjkBr-00052o-NA
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:43:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qjkBp-0001JU-PG
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 13:43:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so20955205ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695404620; x=1696009420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a2yOU2tFkJGeyQQijMlrCR1AC3BfTRpV8XjGZ7FUE1w=;
 b=M7EKW5Okv/PieilBOqHw6yUV8xqMtNpkgoub6t4p+uljWICrGGBQQgecNK8YmLJN8D
 Fql2kVncOFUvoSZ/Vj3vEcp1j1dP32GvIOhmOg1UqMp47oWG7ilYDgAypME6bQVkNkUE
 pQeaqRxgQmaZlj/YyxMX7KHu/UoTJe0A2So1AGfPIyt0BEBNN+UEweRM9LAgKcf9WMQM
 jeH9agzF8wLELpJloeCiPtJ2wyHxBO1Ngrpt0nA+booWXSQPdiglBeUgkzd8g+1vLEvN
 48uA9MBOfvjjLlEIZwB9OW1hREIjTP1M1hIjKjJkZKkHZZb7UW1TVfc9Nb6qx1QFW44o
 P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695404620; x=1696009420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a2yOU2tFkJGeyQQijMlrCR1AC3BfTRpV8XjGZ7FUE1w=;
 b=PUKQqZC99/fUYMPqaaZxZzrE7g02sCwWkWR4gNwKlh2ngi47ROBZEIFK6PVi7/V6oH
 yoMByCFrHMekCOg8KoPtLA66Jyx6Ee3HPY9MrTdY/fno/+Q78yJGJj10gVY+4I0GQ6Vv
 XiCwMIDVWQnLNoIRr3ReTtpZbpk+xm9P/7MYuzSbjelGfnvFH2JBh0tGDVM+YixKb5JE
 oCe77q6r5UEyoXTVWPKALEZ4vJ42Fdf2nHcw8/MKShAiMR5a/C/Lxs4dAACwFO3weAOv
 /IocsbQlh+N8vqi/Q3xum5Kb187RL/VE7wrY9Ds4ETNsL+hpF6rjKyYKwb5/L6k39LFr
 ujNA==
X-Gm-Message-State: AOJu0Yy6W17AVpCrlZsSu5IbIf2wD8n2BQCwisMuhyRsniKmiW48qqAR
 3nmNpUghRgdauHblv5aGnt8=
X-Google-Smtp-Source: AGHT+IFaS8MzcwraPr5A5GEiWovwt7petQgtY957Q51KN3oAYYyJEz4Vjn2ZJ7qQxyIu2FWyCVFOdA==
X-Received: by 2002:a17:903:244e:b0:1c5:a09e:170a with SMTP id
 l14-20020a170903244e00b001c5a09e170amr217113pls.54.1695404620105; 
 Fri, 22 Sep 2023 10:43:40 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.42.59])
 by smtp.gmail.com with ESMTPSA id
 jk23-20020a170903331700b001bb04755212sm3767825plb.228.2023.09.22.10.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 10:43:39 -0700 (PDT)
Message-ID: <f7fca6b0-ed28-8f72-e960-f73f2bc8fcbe@gmail.com>
Date: Fri, 22 Sep 2023 14:43:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Help wanted for enabling -Wshadow=local
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alberto Garcia <berto@igalia.com>,
 Alistair Francis <alistair.francis@wdc.com>, Andrew Jeffery
 <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Brian Cain <bcain@quicinc.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Auger <eric.auger@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fan Ni <fan.ni@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <laurent@vivier.eu>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <87r0mqlf9x.fsf@pond.sub.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <87r0mqlf9x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus,


Can you publish your branch with the current -Wshadow=local patches in
gitlab/github? I'm hitting (and fixing) a lot of errors that aren't listed
here, meaning they're either fixed already in your local branch or needs to
be fixed.


Thanks,

Daniel


On 9/22/23 06:37, Markus Armbruster wrote:
> If you are in To:, we need your help to enable -Wshadow=local.
> 
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
> 
> Enabling -Wshadow would prevent bugs like this one.  But we have to
> clean up all the offenders first.
> 
> I collected the patches posted so far:
> 
>      [PATCH v3 0/7] Steps towards enabling -Wshadow=local
>      Message-ID: <20230921121312.1301864-1-armbru@redhat.com>
> 
>      [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow
>      Message-ID: <20230904161235.84651-1-philmd@linaro.org>
> 
>      [PATCH 0/3] (few more) Steps towards enabling -Wshadow [3 more]
>      Message-ID: <20230904162824.85385-1-philmd@linaro.org>
> 
>      [PATCH 0/8] ppc: Clean up local variable shadowing
>      Message-ID: <20230918145850.241074-1-clg@kaod.org>
> 
> Thanks, Philippe & Cedric!
> 
> In my local build with -Wshadow=local, warnings remain in just 56 files.
> 
> Sorted by subsystems, files covered by multiple subsystems marked
> "(*NUMBER*)", files not covered in MAINTAINERS marked (*guess*):
> 
> Guest CPU cores (TCG)
> ---------------------
> ARM TCG CPUs
> M: Peter Maydell <peter.maydell@linaro.org>
>      hw/arm/smmuv3-internal.h(*2*)
>      hw/arm/smmuv3.c(*2*)
> 
> ARM SMMU
> M: Eric Auger <eric.auger@redhat.com>
>      hw/arm/smmuv3-internal.h(*2*)
>      hw/arm/smmuv3.c(*2*)
> 
> Hexagon TCG CPUs
> M: Brian Cain <bcain@quicinc.com>
>      target/hexagon/gen_helper_funcs.py
>      target/hexagon/mmvec/macros.h
>      target/hexagon/op_helper.c
>      target/hexagon/translate.c
> 
> M68K TCG CPUs
> M: Laurent Vivier <laurent@vivier.eu>
>      disas/m68k.c
> 
> PowerPC TCG CPUs
> M: Nicholas Piggin <npiggin@gmail.com>
> M: Daniel Henrique Barboza <danielhb413@gmail.com>
> R: Cédric Le Goater <clg@kaod.org>
>      target/ppc/int_helper.c
> 
> RISC-V TCG CPUs
>      hw/riscv/opentitan.c(*2*)
>      target/riscv/cpu.c
>      target/riscv/vector_helper.c
> 
> X86 TCG CPUs
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Richard Henderson <richard.henderson@linaro.org>
> M: Eduardo Habkost <eduardo@habkost.net>
>      hw/i386/acpi-build.c(*3*)
>      hw/i386/acpi-microvm.c(*2*)
>      hw/i386/intel_iommu.c(*3*)
>      hw/i386/pc.c(*2*)
>      hw/i386/x86.c(*2*)
>      target/i386/cpu.c(*guess*)
>      target/i386/tcg/seg_helper.c
>      target/i386/tcg/sysemu/svm_helper.c
>      target/i386/tcg/translate.c
> 
> Guest CPU Cores (KVM)
> ---------------------
> X86 KVM CPUs
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Marcelo Tosatti <mtosatti@redhat.com>
>      target/i386/kvm/kvm.c
> 
> ARM Machines
> ------------
> ARM cores
> M: Peter Maydell <peter.maydell@linaro.org>
>      hw/intc/arm_gicv3_its.c
> 
> Versatile PB
> M: Peter Maydell <peter.maydell@linaro.org>
>      hw/misc/arm_sysctl.c
> 
> ASPEED BMCs
> M: Cédric Le Goater <clg@kaod.org>
> M: Peter Maydell <peter.maydell@linaro.org>
> R: Andrew Jeffery <andrew@aj.id.au>
> R: Joel Stanley <joel@jms.id.au>
>      hw/i2c/aspeed_i2c.c
>      hw/misc/aspeed_i3c.c
> 
> LoongArch Machines
> ------------------
> Virt
> M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> M: Song Gao <gaosong@loongson.cn>
>      hw/loongarch/virt.c
> 
> RISC-V Machines
> ---------------
> OpenTitan
> M: Alistair Francis <Alistair.Francis@wdc.com>
>      hw/riscv/opentitan.c(*2*)
> 
> X86 Machines
> ------------
> PC
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>      hw/i386/acpi-build.c(*3*)
>      hw/i386/acpi-microvm.c(*2*)
>      hw/i386/intel_iommu.c(*3*)
>      hw/i386/pc.c(*2*)
>      hw/i386/x86.c(*2*)
> 
> PC Chipset
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Paolo Bonzini <pbonzini@redhat.com>
>      hw/i2c/pm_smbus.c
> 
> Devices
> -------
> ACPI/SMBIOS
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Igor Mammedov <imammedo@redhat.com>
> R: Ani Sinha <anisinha@redhat.com>
>      hw/acpi/cpu_hotplug.c
>      hw/i386/acpi-build.c(*3*)
>      hw/smbios/smbios.c
> 
> Network devices
> M: Jason Wang <jasowang@redhat.com>
>      hw/net/vhost_net.c(*2*)
> 
> SCSI
> M: Paolo Bonzini <pbonzini@redhat.com>
> R: Fam Zheng <fam@euphon.net>
>      hw/scsi/mptsas.c
> 
> USB
> M: Gerd Hoffmann <kraxel@redhat.com>
>      hw/usb/desc.c
>      hw/usb/dev-hub.c
>      hw/usb/dev-storage.c
>      hw/usb/hcd-xhci.c
>      hw/usb/host-libusb.c
> 
> vhost
> M: Michael S. Tsirkin <mst@redhat.com>
>      contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>      contrib/vhost-user-gpu/vugpu.h(*2*)
>      hw/net/vhost_net.c(*2*)
>      hw/virtio/vhost.c
> 
> virtio
> M: Michael S. Tsirkin <mst@redhat.com>
>      hw/virtio/virtio-pci.c
>      include/hw/virtio/virtio-gpu.h(*2*)
> 
> nvme
> M: Keith Busch <kbusch@kernel.org>
> M: Klaus Jensen <its@irrelevant.dk>
>      hw/nvme/ns.c
> 
> virtio-gpu
> M: Gerd Hoffmann <kraxel@redhat.com>
>      include/hw/virtio/virtio-gpu.h(*2*)
> 
> vhost-user-gpu
> M: Marc-André Lureau <marcandre.lureau@redhat.com>
> R: Gerd Hoffmann <kraxel@redhat.com>
>      contrib/vhost-user-gpu/vhost-user-gpu.c(*2*)
>      contrib/vhost-user-gpu/vugpu.h(*2*)
> 
> Subsystems
> ----------
> Overall Audio backends
> M: Gerd Hoffmann <kraxel@redhat.com>
> M: Marc-André Lureau <marcandre.lureau@redhat.com>
>      audio/audio.c
> 
> Open Sound System (OSS) Audio backend
> M: Gerd Hoffmann <kraxel@redhat.com>
>      audio/ossaudio.c
> 
> Compute Express Link
> M: Jonathan Cameron <jonathan.cameron@huawei.com>
> R: Fan Ni <fan.ni@samsung.com>
>      include/hw/cxl/cxl_device.h
> 
> Device Tree
> M: Alistair Francis <alistair.francis@wdc.com>
> R: David Gibson <david@gibson.dropbear.id.au>
>      softmmu/device_tree.c
> 
> Dump
> M: Marc-André Lureau <marcandre.lureau@redhat.com>
>      dump/dump.c
> 
> Main loop
> M: Paolo Bonzini <pbonzini@redhat.com>
>      softmmu/vl.c
> 
> qtest
> M: Thomas Huth <thuth@redhat.com>
> M: Laurent Vivier <lvivier@redhat.com>
> R: Paolo Bonzini <pbonzini@redhat.com>
>      tests/qtest/m48t59-test.c
> 
> Seccomp
> M: Daniel P. Berrange <berrange@redhat.com>
>      softmmu/qemu-seccomp.c
> 
> Cryptography
> M: Daniel P. Berrange <berrange@redhat.com>
>      crypto/tls-cipher-suites.c
> 
> Throttling infrastructure
> M: Alberto Garcia <berto@igalia.com>
>      tests/unit/test-throttle.c
> 
> VT-d Emulation
> M: Michael S. Tsirkin <mst@redhat.com>
> M: Peter Xu <peterx@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
>      hw/i386/intel_iommu.c(*3*)
> 
> Usermode Emulation
> ------------------
> Linux user
> M: Laurent Vivier <laurent@vivier.eu>
>      linux-user/flatload.c
>      linux-user/mmap.c
>      linux-user/syscall.c
> 
> Block drivers
> -------------
> Network Block Device (NBD)
> M: Eric Blake <eblake@redhat.com>
> M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>      qemu-nbd.c
> 

