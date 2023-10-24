Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 513017D5616
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJFJ-0003r8-KP; Tue, 24 Oct 2023 11:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJF0-0003f8-19
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:22:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qvJEt-0003Gh-Hr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:22:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso3337178b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698160957; x=1698765757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dy5Zl7QqcsVg+9QhTIu0qlyQo9ViWIlkSqOrUhiGARs=;
 b=KMEaKkRLmRfnvyGj9orSuvji/vnSIXtJMceJsDdlE1pe4EXlcjcFIkrNQlWmQBnkEy
 Cdsund2/7VSztUJbJIOsTzjM/pgSHIPPXi9ZTLVXj9LegRiafqcQkmWE6Rn/xTg9GSs8
 pcsi5o0k6czBMDXytYZwcJ10zVqyix3PAJpSCv82sERyPNefzgu7QRRUjp0hhhQpgyMS
 KQuYU9XaFiwyiA0P79FoYOYOinhq1z+fO2TjorhuG3fkAiZJZZEbRd4ruAdCXfBPZ5CY
 ntQ2IMMZ4tvtiKAwUIPEWjcWwCL6nentOy6CEpvemoY2AKHoAJPXasbELKvnT2IKqCaB
 IgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698160957; x=1698765757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dy5Zl7QqcsVg+9QhTIu0qlyQo9ViWIlkSqOrUhiGARs=;
 b=s0mOSbdeY65O7T+r/qqJ3196lTm1qVdRVbbABVyYkTn0i9efF6sGCVbm1XWiCIzQy4
 jX4Tj35EJ1gEbLtC1Bw/muIt8lJ1YpwDo+bovsQlr4VUN3jP4bPyZsiIlwpxZFvEzZ+n
 Y7+P1yT9+juwqF4YvyYZnsuSaQhKTaUFuBIFd/l4mzI+bYr0s+R+e/vfF3BlatsFq4k8
 V23V9XhWv0uBnu5/6/05+axABTij68APb2lkVr0jCjUkBORHDra7mx+Eo6NvydrmwZJX
 7nm5bpNDOJ/D9HU49cOP8u1LQZXrS3U33B8fKoC7IL2aRAvvvdx27fKq8zCKVQWkfZQX
 I4rw==
X-Gm-Message-State: AOJu0YzyuEBkCJSJrRjn7rSft1Isizz+PanGPCN/pGMhWeDCuLSIUvur
 1D4wwID+IjcmxbrcdSie2BjGrrCXPbQsyg==
X-Google-Smtp-Source: AGHT+IGLCqsJXR8xlQ/SvVOmiozTJtiV5jocOQ+ZEI55wgdHcpeOr0lcN5D4FgHS5QhoZCYweRPmvQ==
X-Received: by 2002:a05:6a21:6d89:b0:159:c07d:66f0 with SMTP id
 wl9-20020a056a216d8900b00159c07d66f0mr3838666pzb.6.1698160957210; 
 Tue, 24 Oct 2023 08:22:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:647f:b391:99d7:635d])
 by smtp.googlemail.com with ESMTPSA id
 t29-20020a63445d000000b005ab46970aaasm7196180pgk.17.2023.10.24.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:22:35 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
Date: Tue, 24 Oct 2023 22:21:00 +0700
Message-Id: <20231024152105.35942-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi everyone,

This series implements x2APIC mode in userspace local APIC and the
RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
using either Intel or AMD iommu.

Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
with enabled x2APIC and can enumerate CPU with APIC ID 257

Using Intel IOMMU

qemu/build/qemu-system-x86_64 \
  -smp 2,maxcpus=260 \
  -cpu qemu64,x2apic=on \
  -machine q35 \
  -device intel-iommu,intremap=on,eim=on \
  -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
  -m 2G \
  -kernel $KERNEL_DIR \
  -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=$IMAGE_DIR,format=raw \
  -nographic \
  -s

Using AMD IOMMU

qemu/build/qemu-system-x86_64 \
  -smp 2,maxcpus=260 \
  -cpu qemu64,x2apic=on \
  -machine q35 \
  -device amd-iommu,intremap=on,xtsup=on \
  -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
  -m 2G \
  -kernel $KERNEL_DIR \
  -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=$IMAGE_DIR,format=raw \
  -nographic \
  -s

Testing the emulated userspace APIC with kvm-unit-tests, disable test
device with this patch

diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
index 1734afb..f56fe1c 100644
--- a/lib/x86/fwcfg.c
+++ b/lib/x86/fwcfg.c
@@ -27,6 +27,7 @@ static void read_cfg_override(void)

        if ((str = getenv("TEST_DEVICE")))
                no_test_device = !atol(str);
+       no_test_device = true;

        if ((str = getenv("MEMLIMIT")))
                fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;

~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
./run_tests.sh -v -g apic

TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
-cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
apic-split (54 tests, 8 unexpected failures, 1 skipped)
TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
6 unexpected failures, 2 skipped)

  FAIL: apic_disable: *0xfee00030: 50014
  FAIL: apic_disable: *0xfee00080: f0
  FAIL: apic_disable: *0xfee00030: 50014
  FAIL: apic_disable: *0xfee00080: f0
  FAIL: apicbase: relocate apic

These errors are because we don't disable MMIO region when switching to
x2APIC and don't support relocate MMIO region yet. This is a problem
because, MMIO region is the same for all CPUs, in order to support these we
need to figure out how to allocate and manage different MMIO regions for
each CPUs. This can be an improvement in the future.

  FAIL: nmi-after-sti
  FAIL: multiple nmi

These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.

  FAIL: TMCCT should stay at zero

This error is related to APIC timer which should be addressed in separate
patch.

Version 9 changes,
- Patch 1:
  + Create apic_msr_read/write which is a small wrapper around
  apic_register_read/write that have additional x2apic mode check
- Patch 2:
  + Remove raise_exception_ra which is is TCG specific. Instead, return -1
  and let the accelerator raise the appropriate exception
  + Refactor apic_get_delivery_bitmask a little bit to reduce line length
  + Move cpu_has_x2apic_feature and cpu_set_apic_feature from patch 3 to
  patch 2 so that patch 2 can be compiled without patch 3
- Patch 3:
  + set_base in APICCommonClass now returns an int to indicate error
  + Remove raise_exception_ra in apic_set base which is is TCG specific.
  Instead, return -1 and let the accelerator raise the appropriate
  exception

Version 8 changes,
- Patch 2, 4:
  + Rebase to master and resolve conflicts in these 2 patches

Version 7 changes,
- Patch 4:
  + If eim=on, keep checking if kvm x2APIC is enabled when kernel-irqchip
  is split

Version 6 changes,
- Patch 5:
  + Make all places use the amdvi_extended_feature_register to get extended
  feature register

Version 5 changes,
- Patch 3:
  + Rebase to master and fix conflict
- Patch 5:
  + Create a helper function to get amdvi extended feature register instead
  of storing it in AMDVIState

Version 4 changes,
- Patch 5:
  + Instead of replacing IVHD type 0x10 with type 0x11, export both types
  for backward compatibility with old guest operating system
  + Flip the xtsup feature check condition in amdvi_int_remap_ga for
  readability

Version 3 changes,
- Patch 2:
  + Allow APIC ID > 255 only when x2APIC feature is supported on CPU
  + Make physical destination mode IPI which has destination id 0xffffffff
  a broadcast to xAPIC CPUs
  + Make cluster address 0xf in cluster model of xAPIC logical destination
  mode a broadcast to all clusters
  + Create new extended_log_dest to store APIC_LDR information in x2APIC
  instead of extending log_dest for backward compatibility in vmstate

Version 2 changes,
- Add support for APIC ID larger than 255
- Adjust AMD iommu for x2APIC suuport
- Reorganize and split patch 1,2 into patch 1,2,3 in version 2

Thanks,
Quang Minh.

Bui Quang Minh (5):
  i386/tcg: implement x2APIC registers MSR access
  apic: add support for x2APIC mode
  apic, i386/tcg: add x2apic transitions
  intel_iommu: allow Extended Interrupt Mode when using userspace APIC
  amd_iommu: report x2APIC support to the operating system

 hw/i386/acpi-build.c                 | 129 +++++---
 hw/i386/amd_iommu.c                  |  29 +-
 hw/i386/amd_iommu.h                  |  16 +-
 hw/i386/intel_iommu.c                |   6 +-
 hw/i386/kvm/apic.c                   |   3 +-
 hw/i386/x86.c                        |   6 +-
 hw/i386/xen/xen_apic.c               |   3 +-
 hw/intc/apic.c                       | 464 +++++++++++++++++++++------
 hw/intc/apic_common.c                |  22 +-
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   8 +-
 include/hw/i386/apic_internal.h      |   9 +-
 target/i386/cpu-sysemu.c             |  18 +-
 target/i386/cpu.c                    |   9 +-
 target/i386/cpu.h                    |   9 +
 target/i386/tcg/sysemu/misc_helper.c |  41 ++-
 target/i386/whpx/whpx-apic.c         |   3 +-
 17 files changed, 591 insertions(+), 188 deletions(-)

-- 
2.25.1


