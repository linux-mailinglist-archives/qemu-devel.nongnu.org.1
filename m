Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8737FDF35
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8P9a-0004R8-RX; Wed, 29 Nov 2023 13:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8P9Y-0004Qh-SE
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:19:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8P9W-0001wn-Og
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:19:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b54261442so338445e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701281952; x=1701886752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O67nj3ihOXab9yVHwsLpzpens1sh6+zrFKbF+LsLRw0=;
 b=RCgp8cVbn9IJY4kKc6o/UIbVHUTsD/UzDZ1ul+wxwQOaaXRurgunETu5Dg0Tfcpdwm
 hBEXbyVFC/gp+pLwWbcIN65ddeKXpe0RM+2q3LQj1amAxLXINGSEigsiPqT1rqeBhTH6
 ro3itmeIBiQ7EjPwhKaeOw71KAZJGbzlQqIXtSxu866ziwwfXXCpPBl5gSqgPiipGaKb
 m7So5ATt7uVwHusYdtuddckphISVSFkDVwoDYB0xwObCXEaW2/QhvvzWLYO/BFSrO9dz
 MNEZ0Ircjf6sEvFzvP8t3iw9Tw8iNQCneGcTBNDXo/7b2oLmUmHHzYq/ptfoEzOFdDNt
 azEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281952; x=1701886752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O67nj3ihOXab9yVHwsLpzpens1sh6+zrFKbF+LsLRw0=;
 b=b9HnpLswFd/T+VcGLaRL4MpUkwB8gdOK5byt1h32hEHYr5QCnqkNmyLW8CNbDDLLKB
 LLms7g4gp7rTbmeURJ3tHmB7zofFA/9K/t9ShWoaW9NUqAtKLl9LTbJU136rDkgEjlrl
 +Zp17zLGSTFml85MrYrEjiW4iBnzHLCn1f9EAkp/2EUitRSN1w+LDzoAeNOutGqCthQK
 Sv/pMah1t9NvUcnZCaQZ0fEKkSFNaDSf7180o7DGKMUT+mdv2BXxcsJy41SfrUWvCW05
 DJfaYb+jHNjd3KvEL3mzpqHWG4Egvo+hL5JHgLB+c7GiLz4u31VaogWoThK0ps934OVT
 60dA==
X-Gm-Message-State: AOJu0Yzwv+KvdOR2IFXJvh1vJCicaTYn9ZWS4z0Hg9qYT8g/f2W5LyTz
 gzcrNj1t9jBkf0ZIEvIfOkvFPA==
X-Google-Smtp-Source: AGHT+IFIfJVqRN14w+6y3/7CCk/zkoN6O9DNxJnb9/N0v99EPGQaodNgDTCzRNJpD8nnP7J2Idm+oA==
X-Received: by 2002:a05:600c:5118:b0:3f6:9634:c8d6 with SMTP id
 o24-20020a05600c511800b003f69634c8d6mr14139139wms.18.1701281952006; 
 Wed, 29 Nov 2023 10:19:12 -0800 (PST)
Received: from [192.168.110.175] (28.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.28]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b003fefaf299b6sm2990713wmq.38.2023.11.29.10.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:19:11 -0800 (PST)
Message-ID: <6d3b5c65-2442-459d-9bd7-8bbf01e69916@linaro.org>
Date: Wed, 29 Nov 2023 19:19:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Add ivshmem-flat device
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: thuth@redhat.com, Anton Kochkov <anton.kochkov@proton.me>
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
 <20231127052024.435743-2-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127052024.435743-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/11/23 06:20, Gustavo Romero wrote:
> Add a new device, ivshmem-flat, which is similar to the ivshmem PCI but
> does not require a PCI bus. It's meant to be used on machines like those
> with Cortex-M MCUs, which usually lack a PCI/PCIe bus, e.g. lm3s6965evb
> and mps2-an385.
> 
> The device currently only supports the sysbus bus.
> 
> The following is an example on how to create the ivshmem-flat device on
> a Stellaris machine:
> 
> $ qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nographic
>                    -net none -chardev stdio,id=con,mux=on
>                    -serial chardev:con -mon chardev=con,mode=readline
>                    -chardev socket,path=/tmp/ivshmem_socket,id=ivf
>                    -device ivshmem-flat,x-irq-qompath=/machine/unattached/device[1]/nvic/unnamed-gpio-in[0],x-bus-qompath="/sysbus",chardev=ivf
>                    -kernel zephyr_qemu.elf
> 
> The new device, just like the ivshmem PCI device, supports both peer
> notification via hardware interrupts and shared memory.
> 
> The IRQ QOM path for the target machine can be determined by creating
> the VM without the ivshmem-flat device, going to the QEMU console and
> listing the QOM nodes with 'info qom-tree'. In the Stellaris example
> above the input IRQ is in the NVIC IC.
> 
> The MMRs for status and control (notification) are mapped to the MMIO
> region at 0x400FF000 (default), whilst the shared memory region start
> is mapped at addr. 0x40100000 (default), but both addresses can be set
> when creating the device by using 'x-bus-address-{mmr,shmem}' options,
> respectively.
> 
> The device shared memory size can be set using the 'shmem-size' option
> and it defaults to 4 MiB, which is the default size of shmem allocated
> by the ivshmem server.
> 

Per https://gitlab.com/qemu-project/qemu/-/issues/1134#note_1667709336:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1134

> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/devices/ivshmem-flat.rst |  89 +++++
>   hw/arm/mps2.c                        |   2 +
>   hw/arm/stellaris.c                   |   5 +-
>   hw/arm/virt.c                        |   2 +
>   hw/core/sysbus-fdt.c                 |   1 +
>   hw/misc/Kconfig                      |   5 +
>   hw/misc/ivshmem-flat.c               | 477 +++++++++++++++++++++++++++
>   hw/misc/meson.build                  |   2 +
>   hw/misc/trace-events                 |  18 +
>   include/hw/misc/ivshmem-flat.h       |  72 ++++
>   10 files changed, 672 insertions(+), 1 deletion(-)
>   create mode 100644 docs/system/devices/ivshmem-flat.rst
>   create mode 100644 hw/misc/ivshmem-flat.c
>   create mode 100644 include/hw/misc/ivshmem-flat.h


