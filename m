Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DC77AF049
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAbE-0001lL-V0; Tue, 26 Sep 2023 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAbB-0001l2-TU
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:07:45 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAb8-0001Y4-OP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:07:44 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27761d85b31so3195489a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695744460; x=1696349260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v0rW3CdhJgo3CMj4OIq/oUb2IK/QL3Lz6uSdQ50I7l8=;
 b=Gr7E/aGGpOc3PRRUWxXw6ggNuT+ksrcDXaxJDYT7GNkfHElvoEw6gqpoKGMKCqqOh8
 Cv8CAIVI1fzThkO1lskOtL/VEEWaK6evO5+HfKkv2N4dTsXj/VuNeT7wMElfHR7QI+8p
 hQAVMTiKp44yYwYhD7Y3EHC/aG7bKUmriJ1HN8IDbDPK/0lk7c1SMF41nE0ziIBdtzrP
 Zb5AahzpDpj610D+087jYfGtOtcisRmvtxxRt0jeF+2CHjhc2dKg1OqRQVLL6j+gsyJt
 QuMZhixdBge1td7cOLl6S10ZkclmAwx7pEEc86gI87A/sYIq0TB6axcWcPTCmuHtem+p
 cW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695744460; x=1696349260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0rW3CdhJgo3CMj4OIq/oUb2IK/QL3Lz6uSdQ50I7l8=;
 b=bKCppALkGU06Pt71NhrNINVcv6Jw+U4tAQltefvfCKuIMHKMDMDyywji+VevCxFhXs
 5HUCW5MxVClpWnFMhm0iWM+YiUUvr/Rn6ckQr2zXcLDwCLNSgst0Mfs/u40lAqirzzIY
 pB+DUcXX3VrGP07jtJqzMvFoCX/axbvfvEMcu1aM6cIDcnCwWEVsiNGe7SZ1VBf5RnFI
 CbkV7pjCkjhnDyBBpdz/H1oCQ4UYMqfLvWVwW59WG4U/so361BytCvHrYcMmr/+qkCY7
 aQKt0IZRnGRhTqlmxQwOwPKcBoN8h3id2IPUEUg69e3u41gpoM3L+/OGKFVoD5eo6FR9
 tmyw==
X-Gm-Message-State: AOJu0YzhRz+0D1b32vS0+sKcv3XdiqysPtCmLYtMPOShG8shkgizhDOa
 xnbuK8jsoRjb/Av+znPz7bgLe+sTf3ZGQQ==
X-Google-Smtp-Source: AGHT+IF36GFmcaTzrY9NUaRCbSWc+0+DgAaBbRqQXwwq6VGGqX38EFFUOHLWFUH0WRf/PughvoE+nQ==
X-Received: by 2002:a17:90a:a107:b0:26b:6a2f:7d96 with SMTP id
 s7-20020a17090aa10700b0026b6a2f7d96mr6973492pjp.18.1695744460175; 
 Tue, 26 Sep 2023 09:07:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:2173:954b:298f:df36])
 by smtp.googlemail.com with ESMTPSA id
 9-20020a17090a190900b0026fa1931f66sm11158410pjg.9.2023.09.26.09.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:07:39 -0700 (PDT)
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
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v8 0/5] Support x2APIC mode with TCG accelerator
Date: Tue, 26 Sep 2023 23:06:32 +0700
Message-Id: <20230926160637.27995-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x102d.google.com
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

 hw/i386/acpi-build.c                 | 129 +++++----
 hw/i386/amd_iommu.c                  |  29 +-
 hw/i386/amd_iommu.h                  |  16 +-
 hw/i386/intel_iommu.c                |   6 +-
 hw/i386/x86.c                        |   6 +-
 hw/intc/apic.c                       | 395 +++++++++++++++++++++------
 hw/intc/apic_common.c                |  16 +-
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   6 +-
 include/hw/i386/apic_internal.h      |   7 +-
 target/i386/cpu-sysemu.c             |  18 +-
 target/i386/cpu.c                    |   8 +-
 target/i386/cpu.h                    |   9 +
 target/i386/tcg/sysemu/misc_helper.c |  31 +++
 14 files changed, 510 insertions(+), 170 deletions(-)

-- 
2.25.1


