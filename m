Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CD70C384
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:34:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q18Sv-0007xN-2U; Mon, 22 May 2023 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18SP-0007x3-1d
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:32:25 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1q18SM-00073X-Rl
 for qemu-devel@nongnu.org; Mon, 22 May 2023 12:32:24 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2554696544cso1392195a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684773140; x=1687365140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x8tlFNuQZN9Wi00C4ghMAR+1duem5K1cRwccOkliQOI=;
 b=lgSXRRn8HlfKOfvPzRwsWpwSCgP8umQEq6rfKU+2aRCVf28T1EI1PF5WATq0ZrrXp0
 YBquZWynfMCEw0ZSHI3DaI+SDs2uH0NL9UvHH5s7VRBdaF5U1+DNLZflDp9zB8aEiz/o
 IedIuY5XtO4Oxd+d3CjOQjtDbo8bnKHKmUJcizCmUQDjuJgQ2Qac+tEf4nkX6GVjB8ua
 Vv0Z7hQTF8e6BB9XJcLG7Sy7ZS8zFKfGyd4ivVCvPvhYhHoL+pN6x6Gewc5+yX27HC2C
 pqZEbQQoihBWui1uOtkjPrftaWzVb7xkzzelsPI3JZtuH3iHO9N+oG3L5Awmv77WJzmV
 I2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684773140; x=1687365140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8tlFNuQZN9Wi00C4ghMAR+1duem5K1cRwccOkliQOI=;
 b=TsfnkjdFdHL88sP8EzUwS6yGgUO1k+EjFb4QPQu5X91nLwxik7dws7nqbpqRmqirI/
 vhXsZjAxKwVdF7y8kzcitLtbZiYElYI+i7/FewFMm143ZqUszseqZHP7013wPOQjAJKj
 8DZnnM0Q+GocR8G53jVHB00jErqDdRlGkjOVeFtmH1rit4iQwDGfbSH1FonFOGUACY+P
 sOJupFKZY1jxUfAB84Q3jKjYSjVE2KBkQ6LgYDOPJ1I13SHJ5JfbZvlCl+PfSN3MIhRR
 leGDXFD58YHyRcG/wRlxCM3ag4+zMJ0V1Rd9UqyHze+u31ck958sbjhvQRbhFGmoLBZ1
 fttg==
X-Gm-Message-State: AC+VfDywcKZ6242zwlJiuv53M6sGGjfG31L3P78igEoq2owZq2GqcMAc
 DCdelZm+KCmVm1xmA5QISUQ8Nlqlntk=
X-Google-Smtp-Source: ACHHUZ5ctRWAQhfPX0WqrlMNvHzppzlVSXBm4oHIY2ZQJPqu51zWy+C4XApnudYtH9sR/tSs3lONWg==
X-Received: by 2002:a17:90a:e150:b0:253:8260:f9aa with SMTP id
 ez16-20020a17090ae15000b002538260f9aamr9377188pjb.6.1684773139930; 
 Mon, 22 May 2023 09:32:19 -0700 (PDT)
Received: from localhost.localdomain ([113.173.119.15])
 by smtp.googlemail.com with ESMTPSA id
 s5-20020a17090a2f0500b0025393752cd5sm12293253pjd.1.2023.05.22.09.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 09:32:19 -0700 (PDT)
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
Subject: [PATCH v4 0/5] Support x2APIC mode with TCG accelerator
Date: Mon, 22 May 2023 23:31:52 +0700
Message-Id: <20230522163157.9754-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pj1-x1035.google.com
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

 hw/i386/acpi-build.c                 | 127 +++++----
 hw/i386/amd_iommu.c                  |  21 +-
 hw/i386/amd_iommu.h                  |  16 +-
 hw/i386/intel_iommu.c                |  11 -
 hw/i386/x86.c                        |   8 +-
 hw/intc/apic.c                       | 395 +++++++++++++++++++++------
 hw/intc/apic_common.c                |  16 +-
 hw/intc/trace-events                 |   4 +-
 include/hw/i386/apic.h               |   6 +-
 include/hw/i386/apic_internal.h      |   7 +-
 target/i386/cpu-sysemu.c             |  18 +-
 target/i386/cpu.c                    |   5 +-
 target/i386/cpu.h                    |   9 +
 target/i386/tcg/sysemu/misc_helper.c |  31 +++
 14 files changed, 500 insertions(+), 174 deletions(-)

-- 
2.25.1


