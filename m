Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43715754989
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKghW-0001MK-PD; Sat, 15 Jul 2023 10:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKghV-0001MB-HC
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 10:56:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKghT-0003Xn-NK
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 10:56:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-668704a5b5bso3006843b3a.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689433006; x=1692025006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E2GtRKXYsLZONxJUa7zeLzFbLaTRXP9nOiNObFY+8po=;
 b=qqbImAjC8Iw6UGwbZkMjXF8WsDINfD8uITFlCjowQ3ALJYaqyACwkSJBLoomkNq3PF
 RZppIvke7Idg90lHF+CvgKKyLigvw3/aT9pnpdFh8o1HbeqY8LbMq7waysN7dFUTLMMx
 Zeto0d3JvY8HOlf2jSWYBhY7PYIbUaOxXgnk1RTuoERXAqXj6bF1+ytAissUK8b5Yzn+
 t25ohsciashCRviXCfNhEd8lICwsadnScINlk9CxKcuZbe3n2DI+B6X3xhYSCF6sCbf5
 NaYxe7Gc9X9x2KapljIa7X4oReSFVbhA7VCEGaHWs8TJ+B2pvI6Xq2nfhD8NefK1/2CP
 ZIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689433006; x=1692025006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2GtRKXYsLZONxJUa7zeLzFbLaTRXP9nOiNObFY+8po=;
 b=jGi25bmv/nVuOz3vPbNfJp0N3glmIVEweVsL0I6ZR6kLCEItaVXGHv9c4iqB/5DpQB
 B8UxYkEiR+giOZ3hCoDWKnM0N7Aci3Hy06G9QOvtH6WrmnWfPsEHiQKtl0wyAqDJDgsk
 2TxcOosB2gS054Zh/gpRlY5I8e+Ippt40qDPM3wCzUncdFhfj3m8VPUFhTiz2Ib6btYx
 tHgrqfDtnMY7WQL0TA9eoe3Omf60m/KXpm5CfvCXCfIYk/FI2sApFBYZ6nUntyp/MLdy
 ih39fTpPCpYlXT97FgFHFtKr8BOAn8Pr2TEBUmgCF6qo2641oUIEhQUHV9yTu/IEQ/x6
 RSIQ==
X-Gm-Message-State: ABy/qLY+t2SYYHTB6OAclHoUaYQPoe+MRwfeF9G4vVpK4/vaHeR/PyXY
 ATuHgZL1JFUPd7tp7TmUkupZVIzXsDRv+g==
X-Google-Smtp-Source: APBJJlEpmYC6hqVvlAeHCV1zhmPtMlFr9VWFWHiF4veLwFemrHqhAbSYy9vr880dr81NQjRRyjnOtg==
X-Received: by 2002:aa7:8888:0:b0:682:e24c:f4e0 with SMTP id
 z8-20020aa78888000000b00682e24cf4e0mr10632816pfe.11.1689433005894; 
 Sat, 15 Jul 2023 07:56:45 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4fb3:b780:7c3c:1099:10bd:2e8b?
 ([2001:ee0:4fb3:b780:7c3c:1099:10bd:2e8b])
 by smtp.gmail.com with ESMTPSA id
 g8-20020aa78188000000b006783ee5df8asm8902173pfi.189.2023.07.15.07.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jul 2023 07:56:45 -0700 (PDT)
Message-ID: <3ade0311-881c-df7b-b9da-23ce894d2491@gmail.com>
Date: Sat, 15 Jul 2023 21:56:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/5] Support x2APIC mode with TCG accelerator
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230715142820.37120-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230715142820.37120-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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

On 7/15/23 21:28, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series implements x2APIC mode in userspace local APIC and the
> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
> using either Intel or AMD iommu.
> 
> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
> with enabled x2APIC and can enumerate CPU with APIC ID 257
> 
> Using Intel IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>    -smp 2,maxcpus=260 \
>    -cpu qemu64,x2apic=on \
>    -machine q35 \
>    -device intel-iommu,intremap=on,eim=on \
>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>    -m 2G \
>    -kernel $KERNEL_DIR \
>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>    -drive file=$IMAGE_DIR,format=raw \
>    -nographic \
>    -s
> 
> Using AMD IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>    -smp 2,maxcpus=260 \
>    -cpu qemu64,x2apic=on \
>    -machine q35 \
>    -device amd-iommu,intremap=on,xtsup=on \
>    -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>    -m 2G \
>    -kernel $KERNEL_DIR \
>    -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>    -drive file=$IMAGE_DIR,format=raw \
>    -nographic \
>    -s
> 
> Testing the emulated userspace APIC with kvm-unit-tests, disable test
> device with this patch
> 
> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
> index 1734afb..f56fe1c 100644
> --- a/lib/x86/fwcfg.c
> +++ b/lib/x86/fwcfg.c
> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
>   
>          if ((str = getenv("TEST_DEVICE")))
>                  no_test_device = !atol(str);
> +       no_test_device = true;
>   
>          if ((str = getenv("MEMLIMIT")))
>                  fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
> 
> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
> ./run_tests.sh -v -g apic
> 
> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
> apic-split (54 tests, 8 unexpected failures, 1 skipped)
> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
> 6 unexpected failures, 2 skipped)
> 
>    FAIL: apic_disable: *0xfee00030: 50014
>    FAIL: apic_disable: *0xfee00080: f0
>    FAIL: apic_disable: *0xfee00030: 50014
>    FAIL: apic_disable: *0xfee00080: f0
>    FAIL: apicbase: relocate apic
> 
> These errors are because we don't disable MMIO region when switching to
> x2APIC and don't support relocate MMIO region yet. This is a problem
> because, MMIO region is the same for all CPUs, in order to support these we
> need to figure out how to allocate and manage different MMIO regions for
> each CPUs. This can be an improvement in the future.
> 
>    FAIL: nmi-after-sti
>    FAIL: multiple nmi
> 
> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
> 
>    FAIL: TMCCT should stay at zero
> 
> This error is related to APIC timer which should be addressed in separate
> patch.
> 
> Version 5 changes,
> - Patch 3:
>    + Rebase to master and fix conflict
> - Patch 5:
>    + Create a helper function to get amdvi extended feature register instead
>    of storing it in AMDVIState
> 
> Version 4 changes,
> - Patch 5:
>    + Instead of replacing IVHD type 0x10 with type 0x11, export both types
>    for backward compatibility with old guest operating system
>    + Flip the xtsup feature check condition in amdvi_int_remap_ga for
>    readability
> 
> Version 3 changes,
> - Patch 2:
>    + Allow APIC ID > 255 only when x2APIC feature is supported on CPU
>    + Make physical destination mode IPI which has destination id 0xffffffff
>    a broadcast to xAPIC CPUs
>    + Make cluster address 0xf in cluster model of xAPIC logical destination
>    mode a broadcast to all clusters
>    + Create new extended_log_dest to store APIC_LDR information in x2APIC
>    instead of extending log_dest for backward compatibility in vmstate
> 
> Version 2 changes,
> - Add support for APIC ID larger than 255
> - Adjust AMD iommu for x2APIC suuport
> - Reorganize and split patch 1,2 into patch 1,2,3 in version 2
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (5):
>    i386/tcg: implement x2APIC registers MSR access
>    apic: add support for x2APIC mode
>    apic, i386/tcg: add x2apic transitions
>    intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>    amd_iommu: report x2APIC support to the operating system
> 
>   hw/i386/acpi-build.c                 | 127 +++++----
>   hw/i386/amd_iommu.c                  |  30 +-
>   hw/i386/amd_iommu.h                  |  16 +-
>   hw/i386/intel_iommu.c                |  11 -
>   hw/i386/x86.c                        |   8 +-
>   hw/intc/apic.c                       | 395 +++++++++++++++++++++------
>   hw/intc/apic_common.c                |  16 +-
>   hw/intc/trace-events                 |   4 +-
>   include/hw/i386/apic.h               |   6 +-
>   include/hw/i386/apic_internal.h      |   7 +-
>   target/i386/cpu-sysemu.c             |  18 +-
>   target/i386/cpu.c                    |   8 +-
>   target/i386/cpu.h                    |   9 +
>   target/i386/tcg/sysemu/misc_helper.c |  31 +++
>   14 files changed, 510 insertions(+), 176 deletions(-)

I'm so sorry everyone, please ignore this version, the change in patch 5 
is incorrect, I will send a new version.

Thank you,
Quang Minh.

