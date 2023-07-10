Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B229274DD7D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvnH-0005LB-IR; Mon, 10 Jul 2023 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvn8-0005JV-5e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvn4-0007M2-PG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689014358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5y36uEjnU+oe2HyoPgWJgpl0Tu3KXRgATIaWuLOnCAA=;
 b=bBIp5SVksZFg12fA9tFMnQeZx1BXkyRV380c2Ub91NdqirfKtOcGNc0Q7s5hl54212be9v
 eodqWUoPJZcqTTJWoQ+DdeFzPBH9gv9FT5rRD5V6CFpZ9a+LsuFq/6pPTT12heOqRjWFNq
 U6xLqGqdxmsUOZkS0LLoRUVV9W4oTxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-II1YRlToMfyFUUWTkZPotw-1; Mon, 10 Jul 2023 14:39:15 -0400
X-MC-Unique: II1YRlToMfyFUUWTkZPotw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3141c6f4173so2587659f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 11:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689014354; x=1691606354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y36uEjnU+oe2HyoPgWJgpl0Tu3KXRgATIaWuLOnCAA=;
 b=l5rqoi12eHFSlRnX6/N0OJcVr2Ef7DzNqX7gMPj9DiXKe5IBivDlY39ranFgvql00h
 p7Q6IRTTW6rlLqFFUMTX7z7eY8hS0wlo2G1patO8LH+jOpD27d0LDtPdiiIVFzndKs47
 UYUtzvgeQNzRD32EfL2HFEleOpvVcN8KYrcy2rLDKELejEfMj3AqFgSaXUO89TjJw2vk
 CS17QvV0OBNq1yUUiw6dFENHZ9XRK8l+JjqBdFlIK9K5xD1lstWdLdJOxP+cnUf9nWcc
 bVFvCqLwoqhQWovLsw/J/26y2BQKGiAT7tVuFmSc+lxmcnYf2J4Huvo2x0t+2AOXPF30
 tgtA==
X-Gm-Message-State: ABy/qLZWuigwOBUKrQszKBh1p7nTAiYOIZ20nIAdLB/XPmd53C39tU1K
 0bT7m09Htpv2K3GjGqEoQcqiwiAJP4BGHP8Iwa/Z0RTmV6wA7kvLz4PUtinmJ0LIDpFvkXxXqBk
 dzQOskcKIFvfNr1s=
X-Received: by 2002:adf:e349:0:b0:313:e9be:24e7 with SMTP id
 n9-20020adfe349000000b00313e9be24e7mr6721919wrj.59.1689014354235; 
 Mon, 10 Jul 2023 11:39:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFX/N3L4/DhDIVu0TAjg6OOQMAOfm4jdMymv+raQyPIKUzWQe3c5RN7c7Q8esr5hE+EIyX7Yg==
X-Received: by 2002:adf:e349:0:b0:313:e9be:24e7 with SMTP id
 n9-20020adfe349000000b00313e9be24e7mr6721894wrj.59.1689014353597; 
 Mon, 10 Jul 2023 11:39:13 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm97827wrw.113.2023.07.10.11.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 11:39:13 -0700 (PDT)
Date: Mon, 10 Jul 2023 14:39:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 0/5] Support x2APIC mode with TCG accelerator
Message-ID: <20230710143726-mutt-send-email-mst@kernel.org>
References: <20230522163157.9754-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522163157.9754-1-minhquangbui99@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 22, 2023 at 11:31:52PM +0700, Bui Quang Minh wrote:
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

So, I'm not sure how safe it is to merge as is - are we
creating a way for users to shoot themselves in the foot?
Would be better to just fix these issues before we merge.


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
> Bui Quang Minh (5):
>   i386/tcg: implement x2APIC registers MSR access
>   apic: add support for x2APIC mode
>   apic, i386/tcg: add x2apic transitions
>   intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>   amd_iommu: report x2APIC support to the operating system
> 
>  hw/i386/acpi-build.c                 | 127 +++++----
>  hw/i386/amd_iommu.c                  |  21 +-
>  hw/i386/amd_iommu.h                  |  16 +-
>  hw/i386/intel_iommu.c                |  11 -
>  hw/i386/x86.c                        |   8 +-
>  hw/intc/apic.c                       | 395 +++++++++++++++++++++------
>  hw/intc/apic_common.c                |  16 +-
>  hw/intc/trace-events                 |   4 +-
>  include/hw/i386/apic.h               |   6 +-
>  include/hw/i386/apic_internal.h      |   7 +-
>  target/i386/cpu-sysemu.c             |  18 +-
>  target/i386/cpu.c                    |   5 +-
>  target/i386/cpu.h                    |   9 +
>  target/i386/tcg/sysemu/misc_helper.c |  31 +++
>  14 files changed, 500 insertions(+), 174 deletions(-)
> 
> -- 
> 2.25.1


