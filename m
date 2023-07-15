Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0E7549BE
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 17:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKh6V-0007cj-Pw; Sat, 15 Jul 2023 11:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKh6T-0007ai-1e
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 11:22:37 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qKh6R-0006oi-1l
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 11:22:36 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-263036d54b9so2003672a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689434553; x=1692026553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HWk7Zy8ECPT8HHuHTOWT13IojgjFsYzsFuNmvizE4FQ=;
 b=Gkb1pVncklRMJU+vRMAQvQQCb5t8vy9Fb3vqwkh857INO9B+fc0DEnyEwozLLv8VJo
 GHs87sLA7z9DdykKe7MvIOQzUw/uA61yEX4xKcNfsj/77iv5RbsdSh58OnLQNHek4Lql
 7auxFtkXJz0zvcYG8x7Y2ftKqpMTlQ/ZEA93aSA8Ao5QLB/FUqEUv8eAIdOH5MDceRZK
 j305yQOwbT2CpRaSI7nO0QfMY/nlO9iD4tf2RDJJc+DFQHoUxnHayJVuh4fGjqNEBnjr
 rbJ9YTB3ireJno/Nw2HwMC0LxSLB4jY5yT0E+NJR4K5a6kvaXjGwJ5SH4fnpQFtrv3UZ
 W0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689434553; x=1692026553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWk7Zy8ECPT8HHuHTOWT13IojgjFsYzsFuNmvizE4FQ=;
 b=lj5HuMOptY93LJCbWwR/urMbui2PeidBpaGD0w4fXZnqZ4ZKF+DaP9nbWzLG1Wdjfj
 k+5hpDMHCIehjd2uC98wLOe1ucrh2mVru6sYjHhHOsWcltry3ot0YqRezfTWIOm905+C
 NPmaRJXUxcZofWTLcDNGVNiGL5UucZSVGD1lKzr7aOgnbpMoz1m527icvVtdIKJKqPo2
 vhO8wjsmAq2+UZeV9oTNhQEhtsrIi61hFmCEAfj1D6UwrlPNYcCWx1ElUAtYlrj677B9
 y5pJGC/CpgtJkZ+emNueMMVA+n3Nqf2vyiy1EIUrrBM8RhKu7VknXnjqZBRzILhTh389
 1SCg==
X-Gm-Message-State: ABy/qLYe2AuLcduNhMVXzdIFfjJEQdVZlCLpWylGM5ZBHKfhcVm8hd60
 yM7upn+PVZPNdwqgdCT4jZcTpLKVT+KOXA==
X-Google-Smtp-Source: APBJJlGP5kOibRFI2FKMd6nwr/hooAGhfgG0DzP8HnycLclvz2gJ11dB5FIsQ1CJnEHW0NY5oOGuNQ==
X-Received: by 2002:a17:90a:9f85:b0:263:d1f4:77b7 with SMTP id
 o5-20020a17090a9f8500b00263d1f477b7mr6971855pjp.6.1689434552988; 
 Sat, 15 Jul 2023 08:22:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:7c3c:1099:10bd:2e8b])
 by smtp.googlemail.com with ESMTPSA id
 fv14-20020a17090b0e8e00b00256a4d59bfasm2638721pjb.23.2023.07.15.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 08:22:32 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 0/5] Support x2APIC mode with TCG accelerator
Date: Sat, 15 Jul 2023 22:22:19 +0700
Message-Id: <20230715152224.54757-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

 hw/i386/acpi-build.c                 | 129 +++++----
 hw/i386/amd_iommu.c                  |  29 +-
 hw/i386/amd_iommu.h                  |  16 +-
 hw/i386/intel_iommu.c                |  11 -
 hw/i386/x86.c                        |   8 +-
 hw/intc/apic.c                       | 395 +++++++++++++++++++++------
 hw/intc/apic_common.c                |  16 +-
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   6 +-
 include/hw/i386/apic_internal.h      |   7 +-
 target/i386/cpu-sysemu.c             |  18 +-
 target/i386/cpu.c                    |   8 +-
 target/i386/cpu.h                    |   9 +
 target/i386/tcg/sysemu/misc_helper.c |  31 +++
 14 files changed, 510 insertions(+), 177 deletions(-)

-- 
2.25.1


