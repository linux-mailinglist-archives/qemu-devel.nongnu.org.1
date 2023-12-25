Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FB81E19D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHo1e-00066P-Uy; Mon, 25 Dec 2023 11:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo1c-000660-Pd
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:41:56 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo1a-0001fX-Rc
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:41:56 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9b37f4804so503987b3a.1
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703522513; x=1704127313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bDU3wrjKoGrjBCvKGLZA2uZ8/xalQQ/3+a3imodbwn0=;
 b=G6fU8QM37KWlOL8TRpdYO1qgA1ih9vIobn4DL0AE2JFpmWC1CVdyI5YcK6QSdwMwRn
 SAUt/b6n+lroT22c6UgLHgfvCxQQSflNwOzdBdBX5WUAt9Q3aplG9su8dwkP3lo9VPaq
 C567hnH4s2DoLQ1q4Yx3f4VJfLgBc4oLWdxJ2o/+PwR6u07ZQE0mmg6KPAGzRDkxb56i
 xj4tmTj+rita8ikEkoiEKO40HXbaMAAiwUyxuh/vxnAIRXT+VAjKXYwBrrcTbqaQNk7D
 Y5g6BWnTIM7WVPDbk6gm49GLBjyuFW6xlGmvS4bMIt+5IF6vgCEMBJlTEKii+74pAC1c
 a1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703522513; x=1704127313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bDU3wrjKoGrjBCvKGLZA2uZ8/xalQQ/3+a3imodbwn0=;
 b=ZXTVcNMXFWIqHuXMeuusR2FykBUT0Qv3PsFqcniIy72LfMXCwsvbCPEUHn8UVnmu01
 u3mKkGk9P9CbVwNwvvfyZ4fEB3/5JED8XlSYO0CdTY2dsu2obNDNvaHjIgknpXLnT0Is
 7T8n36iPN+gc67Dxp0d1ZhxxmCLX4PWZHAUa7AYTw5b4gsT0QD2LOPDLFKAJHpI70lzU
 lz5dWOIprnCbWJYDNZ+NF34S9Ctwvr3cAEdC4C9ghNsZn6OKagaTu439CYU6Lw/1EMDa
 gVUsbp6FHc+uEtohidtK3YJR7qqH4yKsr28CqbRGane60a/P4MZZvnI7Ot3C6PfNXiPA
 ZdEg==
X-Gm-Message-State: AOJu0YxzqiD4+g+ghRTHp4fZNGUcluSwlfvz16JMJrQf6HhzqmwVBhk+
 CvpA4LpMAn8pBuOlljtlsuLstqmXwRIawA==
X-Google-Smtp-Source: AGHT+IEgFJn7EKFTV2kwMzhbYuIYZrrxsGdWl2/ZwzfIM+oRO4LvqDwjiiJxXClp31uz+T9cXpURXA==
X-Received: by 2002:a05:6a21:3814:b0:195:dcf5:b8e6 with SMTP id
 yi20-20020a056a21381400b00195dcf5b8e6mr300034pzb.28.1703522512574; 
 Mon, 25 Dec 2023 08:41:52 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:d7ef:8aab:5b58:14b2])
 by smtp.googlemail.com with ESMTPSA id
 x22-20020a63fe56000000b005b92e60cf57sm8092928pgj.56.2023.12.25.08.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 08:41:52 -0800 (PST)
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
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v11 0/7] Support x2APIC mode with TCG accelerator
Date: Mon, 25 Dec 2023 23:40:54 +0700
Message-Id: <20231225164101.105958-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x431.google.com
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

Version 11 changes,
- Patch 2:
  + Rebase to master and fix conflict with commit c04cfb4596 (hw/i386: fix
    short-circuit logic with non-optimizing builds)

Version 10 changes,
- Patch 2:
  + Fix null pointer dereference due to uninitialized local_apics when using
  machine none
- Patch 5, 7:
  + These patches are added to follow the bios-tables-test instructions to
  commit the new changed IVRS.ivrs binary file

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
- Adjust AMD iommu for x2APIC support
- Reorganize and split patch 1,2 into patch 1,2,3 in version 2

Thanks,
Quang Minh.

Bui Quang Minh (7):
  i386/tcg: implement x2APIC registers MSR access
  apic: add support for x2APIC mode
  apic, i386/tcg: add x2apic transitions
  intel_iommu: allow Extended Interrupt Mode when using userspace APIC
  test: bios-tables-test: prepare IVRS change in ACPI table
  amd_iommu: report x2APIC support to the operating system
  test: bios-tables-test: add IVRS changed binary

 hw/i386/acpi-build.c                 | 129 +++++---
 hw/i386/amd_iommu.c                  |  29 +-
 hw/i386/amd_iommu.h                  |  16 +-
 hw/i386/intel_iommu.c                |   6 +-
 hw/i386/kvm/apic.c                   |   3 +-
 hw/i386/x86.c                        |   6 +-
 hw/i386/xen/xen_apic.c               |   3 +-
 hw/intc/apic.c                       | 473 +++++++++++++++++++++------
 hw/intc/apic_common.c                |  22 +-
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   8 +-
 include/hw/i386/apic_internal.h      |   9 +-
 target/i386/cpu-sysemu.c             |  18 +-
 target/i386/cpu.c                    |   9 +-
 target/i386/cpu.h                    |   9 +
 target/i386/tcg/sysemu/misc_helper.c |  41 ++-
 target/i386/whpx/whpx-apic.c         |   3 +-
 tests/data/acpi/q35/IVRS.ivrs        | Bin 104 -> 176 bytes
 18 files changed, 600 insertions(+), 188 deletions(-)

-- 
2.25.1


