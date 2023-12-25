Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F55181E178
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHnMj-0007Pv-RG; Mon, 25 Dec 2023 10:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnMh-0007PZ-Uf
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnMd-0003rG-Os
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 10:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703519975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zszghrc7EHl0qGSdaHnBG4JrZiauS6V4Zu0F5roFAxQ=;
 b=ZZ//rCMYXgWk3oztH03KNfjD03kWRid++wySQvpvnnI1QBmJO2DEc2kgcgj/K6niPys99N
 rxW2KD9/8i6/T4YWJsNrHVIUxoZIgCzU3jo29q8kvWnlgyZN0WQzO4vnp70M5GxdBFcAIh
 S3dxn1mzzGM+Vne/OxAhY2M6BxvNJbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-SnoScV0xOi6PkHD2V8MiOQ-1; Mon, 25 Dec 2023 10:59:33 -0500
X-MC-Unique: SnoScV0xOi6PkHD2V8MiOQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d55db3e91so8781815e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 07:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703519972; x=1704124772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zszghrc7EHl0qGSdaHnBG4JrZiauS6V4Zu0F5roFAxQ=;
 b=OgWFreF1NBF4jPkp0kjNX9rxPCPW+imfJ8AoFQbIzJWw6YHqnNWMvyUh3jEta0p26x
 ByBNvTLuLCNGe4FBMQ4EZvuPZWKn4BMCiU5SVTZEqOmU/emW9SvywzC3JKo5+enMrSY6
 n9dUs63iFrmNxqtpF3r4IWPRcL5GjShMm3DPJnECnQAJ3VisaXZCn6wKKc4PcN8QuZ0C
 fUcqyYukL7UD2CwZ1UDCpOgwxd6ZW7TFcpLL6i7FZCBUWb/PUPEp120Tt45ZzewMNlMi
 QpFQe/J/sUrbTeyQJ48TokAJz2tDiNJGw9X1zqDp5Y/wEJpQsaCMHFeauoBCCawhd9ON
 48wg==
X-Gm-Message-State: AOJu0Yw5V7KGG8CZI6DxluHDlyiwjv3ldi41tKK+GPx9acJqYFtMVSdj
 /CZx5KVtNKNQNm7Ymx3XIFuHh9cVqoCXhjsVtdNVfjAt97RetnT4DdtrjOOl4ldAQF7FisAkLjH
 Aur9fCdo06lAeBlYvfioXIeQ=
X-Received: by 2002:a5d:490e:0:b0:336:bfe3:3111 with SMTP id
 x14-20020a5d490e000000b00336bfe33111mr1628090wrq.111.1703519972472; 
 Mon, 25 Dec 2023 07:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9V1Ii2DcAE3rSMbp1LM4iUy3XYoNpUkdDZDoKG880pqk+9A4Tla9h80jVPP7xnIF3raMi2A==
X-Received: by 2002:a5d:490e:0:b0:336:bfe3:3111 with SMTP id
 x14-20020a5d490e000000b00336bfe33111mr1628082wrq.111.1703519972105; 
 Mon, 25 Dec 2023 07:59:32 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a5d6346000000b0033683574772sm10580481wrw.65.2023.12.25.07.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:59:31 -0800 (PST)
Date: Mon, 25 Dec 2023 10:59:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>
Subject: Re: [PATCH v10 0/7] Support x2APIC mode with TCG accelerator
Message-ID: <20231225105902-mutt-send-email-mst@kernel.org>
References: <20231109151924.267515-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109151924.267515-1-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Nov 09, 2023 at 10:19:17PM +0700, Bui Quang Minh wrote:
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

Now that release is out I'd like to apply this.
Could you please rebase on latest master and repost?

Thanks!

> Using Intel IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>   -smp 2,maxcpus=260 \
>   -cpu qemu64,x2apic=on \
>   -machine q35 \
>   -device intel-iommu,intremap=on,eim=on \
>   -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>   -m 2G \
>   -kernel $KERNEL_DIR \
>   -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>   -drive file=$IMAGE_DIR,format=raw \
>   -nographic \
>   -s
> 
> Using AMD IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>   -smp 2,maxcpus=260 \
>   -cpu qemu64,x2apic=on \
>   -machine q35 \
>   -device amd-iommu,intremap=on,xtsup=on \
>   -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>   -m 2G \
>   -kernel $KERNEL_DIR \
>   -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>   -drive file=$IMAGE_DIR,format=raw \
>   -nographic \
>   -s
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
>         if ((str = getenv("TEST_DEVICE")))
>                 no_test_device = !atol(str);
> +       no_test_device = true;
> 
>         if ((str = getenv("MEMLIMIT")))
>                 fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
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
>   FAIL: apic_disable: *0xfee00030: 50014
>   FAIL: apic_disable: *0xfee00080: f0
>   FAIL: apic_disable: *0xfee00030: 50014
>   FAIL: apic_disable: *0xfee00080: f0
>   FAIL: apicbase: relocate apic
> 
> These errors are because we don't disable MMIO region when switching to
> x2APIC and don't support relocate MMIO region yet. This is a problem
> because, MMIO region is the same for all CPUs, in order to support these we
> need to figure out how to allocate and manage different MMIO regions for
> each CPUs. This can be an improvement in the future.
> 
>   FAIL: nmi-after-sti
>   FAIL: multiple nmi
> 
> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
> 
>   FAIL: TMCCT should stay at zero
> 
> This error is related to APIC timer which should be addressed in separate
> patch.
> 
> Version 10 changes,
> - Patch 2:
>   + Fix null pointer dereference due to uninitialized local_apics when using
>   machine none
> - Patch 5, 7:
>   + These patches are added to follow the bios-tables-test instructions to
>   commit the new changed IVRS.ivrs binary file
> 
> Version 9 changes,
> - Patch 1:
>   + Create apic_msr_read/write which is a small wrapper around
>   apic_register_read/write that have additional x2apic mode check
> - Patch 2:
>   + Remove raise_exception_ra which is is TCG specific. Instead, return -1
>   and let the accelerator raise the appropriate exception
>   + Refactor apic_get_delivery_bitmask a little bit to reduce line length
>   + Move cpu_has_x2apic_feature and cpu_set_apic_feature from patch 3 to
>   patch 2 so that patch 2 can be compiled without patch 3
> - Patch 3:
>   + set_base in APICCommonClass now returns an int to indicate error
>   + Remove raise_exception_ra in apic_set base which is is TCG specific.
>   Instead, return -1 and let the accelerator raise the appropriate
>   exception
> 
> Version 8 changes,
> - Patch 2, 4:
>   + Rebase to master and resolve conflicts in these 2 patches
> 
> Version 7 changes,
> - Patch 4:
>   + If eim=on, keep checking if kvm x2APIC is enabled when kernel-irqchip
>   is split
> 
> Version 6 changes,
> - Patch 5:
>   + Make all places use the amdvi_extended_feature_register to get extended
>   feature register
> 
> Version 5 changes,
> - Patch 3:
>   + Rebase to master and fix conflict
> - Patch 5:
>   + Create a helper function to get amdvi extended feature register instead
>   of storing it in AMDVIState
> 
> Version 4 changes,
> - Patch 5:
>   + Instead of replacing IVHD type 0x10 with type 0x11, export both types
>   for backward compatibility with old guest operating system
>   + Flip the xtsup feature check condition in amdvi_int_remap_ga for
>   readability
> 
> Version 3 changes,
> - Patch 2:
>   + Allow APIC ID > 255 only when x2APIC feature is supported on CPU
>   + Make physical destination mode IPI which has destination id 0xffffffff
>   a broadcast to xAPIC CPUs
>   + Make cluster address 0xf in cluster model of xAPIC logical destination
>   mode a broadcast to all clusters
>   + Create new extended_log_dest to store APIC_LDR information in x2APIC
>   instead of extending log_dest for backward compatibility in vmstate
> 
> Version 2 changes,
> - Add support for APIC ID larger than 255
> - Adjust AMD iommu for x2APIC suuport
> - Reorganize and split patch 1,2 into patch 1,2,3 in version 2
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (7):
>   i386/tcg: implement x2APIC registers MSR access
>   apic: add support for x2APIC mode
>   apic, i386/tcg: add x2apic transitions
>   intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>   test: bios-tables-test: prepare IVRS change in ACPI table
>   amd_iommu: report x2APIC support to the operating system
>   test: bios-tables-test: add IVRS changed binary
> 
>  hw/i386/acpi-build.c                 | 129 +++++---
>  hw/i386/amd_iommu.c                  |  29 +-
>  hw/i386/amd_iommu.h                  |  16 +-
>  hw/i386/intel_iommu.c                |   6 +-
>  hw/i386/kvm/apic.c                   |   3 +-
>  hw/i386/x86.c                        |   6 +-
>  hw/i386/xen/xen_apic.c               |   3 +-
>  hw/intc/apic.c                       | 473 +++++++++++++++++++++------
>  hw/intc/apic_common.c                |  22 +-
>  hw/intc/trace-events                 |   4 +-
>  include/hw/i386/apic.h               |   8 +-
>  include/hw/i386/apic_internal.h      |   9 +-
>  target/i386/cpu-sysemu.c             |  18 +-
>  target/i386/cpu.c                    |   9 +-
>  target/i386/cpu.h                    |   9 +
>  target/i386/tcg/sysemu/misc_helper.c |  41 ++-
>  target/i386/whpx/whpx-apic.c         |   3 +-
>  tests/data/acpi/q35/IVRS.ivrs        | Bin 104 -> 176 bytes
>  18 files changed, 600 insertions(+), 188 deletions(-)
> 
> -- 
> 2.25.1


