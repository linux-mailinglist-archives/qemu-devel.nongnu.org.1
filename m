Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6296FA9CD11
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 17:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzA-0008WF-Kh; Fri, 25 Apr 2025 11:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kz4-0008VY-CJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kyv-0003Ur-0p
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:28:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so16116925e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594926; x=1746199726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p/vZpE9FSruRd6RlaxodEMQTLesSgKFe2cjfcqzO7iQ=;
 b=WGoyPfoP0t3BSrZUhlj3vUmfZ5mKzoBIjsMqZL1PqgS1POrbow9UA+OxeyDkaIJcNP
 MKPsqq/TRboHLB52TYtvR20y3VLOtdoFEIwe2Rs8L7H5LoLhSzBbvzU9Zk0gDOGdqKKI
 8u7iDTr846zQeXb5j6XFeDt4LiaXfdeTYGsAf13z6rx5JrvdG8Ti21dvSlJqQBaIA6qZ
 kO6Lm5ueZqFrxj9T1ZB6D57c/3s4bgIig8+puUAlbWXfGhvEPjQqJfIxvgGTxVDIlZSJ
 LpQVr3lhP/m2SPcOtpw+GiXrcAGNn34Gdw8UYdpHNZDFwWssNbh6/9x7CXQWSPFMhiZY
 G97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594926; x=1746199726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p/vZpE9FSruRd6RlaxodEMQTLesSgKFe2cjfcqzO7iQ=;
 b=VAS9KP0lpdIvtF7HSYeBS3/lje0aOYNC9xTondazprM4TCwloIaerTxWG7pCaI04zG
 L5yDTHfRBBdArWGb45G5kl7F4xWmqTvcYMzzhcH4yVflbqPuIKYeMuUbbymBfgseMhzA
 4Z6Iy8wUONXgPkBZ2nVmyQ+DgIfoywI9Ni71Z01g/kN5FNdJcg/2d+xy4q3zYvlTJYAb
 1HMJ3CqAhbBMe4xY7/KmRW7aYe5DWdfkKmpVcK5mozzu00p9YZ1ffEcfqp4VCrPcq2M6
 XKw8xI0NyUge72DMh+IxJim3t4H2H+NsNeOTFpMN6ag7XEWxAwWGZgR7hg9N9XRcfhMY
 +Vbw==
X-Gm-Message-State: AOJu0YybrZc2lF7OsEbSO+jqILOJT7KOH79yolrBbC7nUx3zLZbP2wL+
 KNjf0vFlQEUV/5LyXMIvJVwdEUytxSch5Pb1Xt5D1cND5TIg3n7ZM2cHrbGQ7bI3y1KvVvEz4Al
 k
X-Gm-Gg: ASbGncs2+Gtu6Q1s4NEATaZkjxBn6P8WJX2krUyjY0Z3ZPSI4US4m9+14HB4MUFM+cP
 nbzFNBTDxpu/GcAz/sDcMD4X6ZhaoNe5hXg40EyUGsfJpQSChIwlgimVzLDinELaLKyKlphkq7F
 ppK2ZtXhOkF8J5r8Q3kEg4/ZiBBflvo5TBmU0rCEh7IdiVv5Q/gkmNxycNhKi1RTcennsuBJ1QW
 IuM91p033I48ayZVCRbdIEBb6P8gbJAxm8OWJLH8ke2zlHiRjnc3S4/5MdR49GOLCEreQ7hGvOe
 1dfdYD1ljM3Uvt4eaQLeswnsiAiLUWPHTVf+KRC4G5LXU8OxkArXl7d79TQA/oqhja7CBgc2qCb
 BIcMhNRciQT0PcFk=
X-Google-Smtp-Source: AGHT+IGbrc3zu6Dzcl6wg7u9R2E4M3ZFj4Ij6ZGe4f0irNwDCq4bE/VsyE0UmGYGRPIUbY8wzlJc3w==
X-Received: by 2002:a05:600c:1c23:b0:43c:ec72:3daf with SMTP id
 5b1f17b1804b1-4409c513fa7mr70304565e9.14.1745594925067; 
 Fri, 25 Apr 2025 08:28:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d264sm2698655f8f.95.2025.04.25.08.28.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/58] Misc single binary patches for 2025-04-25
Date: Fri, 25 Apr 2025 17:27:44 +0200
Message-ID: <20250425152843.69638-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 019fbfa4bcd2d3a835c241295e22ab2b5b56129b:

  Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging (2025-04-24 13:44:57 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20250425

for you to fetch changes up to 3d881164d4fb2b0f6791cf28d9725926b8ded0d6:

  qemu: Convert target_name() to TargetInfo API (2025-04-25 17:09:58 +0200)

----------------------------------------------------------------
Various patches loosely related to single binary work:

- Replace cpu_list() definition by CPUClass::list_cpus() callback
- Remove few MO_TE definitions on Hexagon / X86 targets
- Remove target_ulong uses in  ARMMMUFaultInfo and ARM CPUWatchpoint
- Remove DEVICE_HOST_ENDIAN definition
- Evaluate TARGET_BIG_ENDIAN at compile time and use target_needs_bswap() more
- Rename target_words_bigendian() as target_big_endian()
- Convert target_name() and target_cpu_type() to TargetInfo API
- Constify QOM TypeInfo class_data/interfaces fields
- Get default_cpu_type calling machine_class_default_cpu_type()
- Correct various uses of GLibCompareDataFunc prototype
- Simplify ARM/Aarch64 gdb_get_core_xml_file() handling a bit
- Move device tree files in their own pc-bios/dtb/ subdir
- Correctly check strchrnul() symbol availability on macOS SDK
- Move target-agnostic methods out of cpu-target.c and accel-target.c
- Unmap canceled USB XHCI packet
- Use deposit/extract API in designware model
- Fix MIPS16e translation
- Few missing header fixes

Following checkpatch errors deliberately ignored:

  13/58 Checking commit 16f9997f3e8f (qom: Have class_init() take a const data argument)
  WARNING: line over 80 characters
  #21029: FILE: scripts/codeconverter/codeconverter/qom_type_info.py:801:
  +#                yield self.prepend(('static void %s_class_init(ObjectClass *oc,\n'

  WARNING: line over 80 characters
  #21030: FILE: scripts/codeconverter/codeconverter/qom_type_info.py:802:
  +#                                                              'const void *data)\n'

  total: 0 errors, 2 warnings, 13722 lines checked

  57/58 Checking commit 95be355a03e5 (accel: Move target-agnostic code from accel-target.c -> accel-common.c)
  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #21: 
  new file mode 100644

  WARNING: Saw acceptable license 'MIT' but note 'GPL-2.0-or-later' is preferred for new files unless the code is derived from a source file with an existing declared license that must be retained. Please explain the license choice in the commit message.
  total: 0 errors, 2 warnings, 288 lines checked

  Patch 57/58 has style problems, please review.  If any of these errors

----------------------------------------------------------------

Akihiko Odaki (5):
  hw/usb/hcd-xhci: Unmap canceled packet
  meson: Use has_header_symbol() to check getcpu()
  meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
  meson: Share common C source prefixes
  meson: Use osdep_prefix for strchrnul()

BALATON Zoltan (3):
  hw/intc/i8259: Remove unused DEBUG_PIC define
  system/datadir: Add new type constant for DTB files
  pc-bios: Move device tree files in their own subdir

Hauke Mehrtens (1):
  target/mips: Fix MIPS16e translation

Kohei Tokunaga (5):
  qom/object: Fix type conflict of GLib function pointers
  hw/core/loader: Fix type conflict of GLib function pointers
  hw/net/can: Fix type conflict of GLib function pointers
  contrib/plugins: Fix type conflict of GLib function pointers
  system/vl: Fix type conflict of GLib function pointers

Peter Maydell (5):
  hw/core/cpu: gdb_arch_name string should not be freed
  gdbstub: Allow gdb_core_xml_file to be set at runtime
  target/arm: Handle AArch64 in TYPE_ARM_CPU gdb_arch_name
  target/arm: Handle gdb_core_xml_file in TYPE_ARM_CPU
  target/arm: Handle AArch64 gdb read/write regs in TYPE_ARM_CPU

Philippe Mathieu-Daudé (38):
  target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
  target/hexagon: Replace MO_TE -> MO_LE
  target/i386: Replace MO_TE* -> MO_LE*
  cpus: Introduce CPUClass::list_cpus() callback
  target/i386: Register CPUClass:list_cpus
  target/ppc: Register CPUClass:list_cpus
  target/sparc: Register CPUClass:list_cpus
  target/s390x: Register CPUClass:list_cpus
  cpus: Remove #ifdef check on cpu_list definition
  hw/pci-host/designware: Use deposit/extract API
  hw/misc/edu: Convert type_init() -> DEFINE_TYPES()
  qom: Have class_base_init() take a const data argument
  qom: Have class_init() take a const data argument
  qom: Constify TypeInfo::class_data
  qom: Constify TypeInfo::interfaces
  qom: Make InterfaceInfo[] uses const
  hw/core: Get default_cpu_type calling machine_class_default_cpu_type()
  target/arm: Replace target_ulong -> hwaddr in ARMMMUFaultInfo
  target/arm: Replace target_ulong -> vaddr for CPUWatchpoint
  exec: Rename target_words_bigendian() -> target_big_endian()
  system/memory: Remove DEVICE_HOST_ENDIAN definition
  accel/tcg: Correct list of included headers in tcg-stub.c
  target/hexagon: Include missing 'accel/tcg/getpc.h'
  linux-user/elfload: Use target_needs_bswap()
  accel/kvm: Use target_needs_bswap()
  target/mips: Check CPU endianness at runtime using env_is_bigendian()
  target/xtensa: Evaluate TARGET_BIG_ENDIAN at compile time
  hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
  hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile time
  qapi: Rename TargetInfo structure as QemuTargetInfo
  qemu: Introduce target_cpu_type()
  cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
  cpus: Move target-agnostic methods out of cpu-target.c
  accel: Implement accel_init_ops_interfaces() for both system/user mode
  accel: Include missing 'qemu/accel.h' header in accel-internal.h
  accel: Make AccelCPUClass structure target-agnostic
  accel: Move target-agnostic code from accel-target.c -> accel-common.c
  qemu: Convert target_name() to TargetInfo API

Pierrick Bouvier (1):
  system/kvm: make functions accessible from common code

 MAINTAINERS                                   |  13 +-
 docs/devel/qom.rst                            |   8 +-
 docs/devel/reset.rst                          |   2 +-
 docs/devel/virtio-backends.rst                |   2 +-
 meson.build                                   |  85 +++++------
 qapi/machine.json                             |  10 +-
 accel/{accel-system.h => accel-internal.h}    |  10 +-
 hw/usb/hcd-uhci.h                             |   2 +-
 include/accel/accel-cpu-target.h              |  12 +-
 include/accel/accel-cpu.h                     |  23 +++
 include/exec/cpu-common.h                     |   6 -
 include/exec/tswap.h                          |  12 +-
 include/hw/boards.h                           |   2 +-
 include/hw/core/cpu.h                         |  12 +-
 include/hw/i386/pc.h                          |   5 +-
 include/hw/virtio/virtio-pci.h                |   4 +-
 include/qemu/datadir.h                        |  11 +-
 include/qemu/target-info-impl.h               |  26 ++++
 include/qemu/target-info.h                    |  26 ++++
 include/qom/object.h                          |  12 +-
 include/system/kvm.h                          |   8 +-
 system/memory-internal.h                      |   5 +-
 target/arm/cpu.h                              |   2 +-
 target/arm/internals.h                        |  20 ++-
 target/hexagon/macros.h                       |  11 +-
 target/hexagon/mmvec/macros.h                 |   1 +
 target/i386/cpu.h                             |   3 -
 target/ppc/cpu.h                              |   7 +-
 target/s390x/cpu.h                            |   7 -
 target/s390x/cpu_models.h                     |   3 +
 target/sparc/cpu.h                            |   3 -
 accel/accel-common.c                          | 142 ++++++++++++++++++
 accel/accel-system.c                          |   4 +-
 accel/accel-target.c                          | 134 -----------------
 accel/accel-user.c                            |   6 +
 accel/hvf/hvf-accel-ops.c                     |   4 +-
 accel/kvm/kvm-accel-ops.c                     |   2 +-
 accel/kvm/kvm-all.c                           |  32 ++--
 accel/qtest/qtest.c                           |   4 +-
 accel/stubs/tcg-stub.c                        |   3 +-
 accel/tcg/tcg-accel-ops.c                     |   2 +-
 accel/tcg/tcg-all.c                           |   7 +-
 accel/xen/xen-all.c                           |   4 +-
 authz/list.c                                  |   4 +-
 authz/listfile.c                              |   4 +-
 authz/pamacct.c                               |   4 +-
 authz/simple.c                                |   4 +-
 backends/confidential-guest-support.c         |   3 +-
 backends/cryptodev-builtin.c                  |   2 +-
 backends/cryptodev-lkcf.c                     |   2 +-
 backends/cryptodev-vhost-user.c               |   2 +-
 backends/cryptodev.c                          |   4 +-
 backends/dbus-vmstate.c                       |   4 +-
 backends/host_iommu_device.c                  |   2 +-
 backends/hostmem-epc.c                        |   2 +-
 backends/hostmem-file.c                       |   2 +-
 backends/hostmem-memfd.c                      |   2 +-
 backends/hostmem-ram.c                        |   2 +-
 backends/hostmem-shm.c                        |   2 +-
 backends/hostmem.c                            |   4 +-
 backends/iommufd.c                            |   6 +-
 backends/rng-builtin.c                        |   2 +-
 backends/rng-egd.c                            |   2 +-
 backends/rng-random.c                         |   2 +-
 backends/rng.c                                |   4 +-
 backends/tpm/tpm_emulator.c                   |   2 +-
 backends/tpm/tpm_passthrough.c                |   2 +-
 backends/vhost-user.c                         |   2 +-
 block/throttle-groups.c                       |   5 +-
 chardev/baum.c                                |   2 +-
 chardev/char-console.c                        |   2 +-
 chardev/char-fd.c                             |   2 +-
 chardev/char-file.c                           |   2 +-
 chardev/char-hub.c                            |   2 +-
 chardev/char-mux.c                            |   2 +-
 chardev/char-null.c                           |   2 +-
 chardev/char-parallel.c                       |   2 +-
 chardev/char-pipe.c                           |   2 +-
 chardev/char-pty.c                            |   2 +-
 chardev/char-ringbuf.c                        |   2 +-
 chardev/char-serial.c                         |   2 +-
 chardev/char-socket.c                         |   2 +-
 chardev/char-stdio.c                          |   2 +-
 chardev/char-udp.c                            |   2 +-
 chardev/char-win-stdio.c                      |   2 +-
 chardev/char-win.c                            |   2 +-
 chardev/char.c                                |   2 +-
 chardev/msmouse.c                             |   2 +-
 chardev/spice.c                               |   6 +-
 chardev/testdev.c                             |   2 +-
 chardev/wctablet.c                            |   2 +-
 contrib/plugins/cache.c                       |  12 +-
 contrib/plugins/cflow.c                       |  10 +-
 contrib/plugins/hotblocks.c                   |   4 +-
 contrib/plugins/hotpages.c                    |   4 +-
 contrib/plugins/howvec.c                      |   4 +-
 contrib/plugins/hwprofile.c                   |   8 +-
 cpu-target.c                                  |  86 +----------
 crypto/secret.c                               |   2 +-
 crypto/secret_common.c                        |   4 +-
 crypto/secret_keyring.c                       |   2 +-
 crypto/tls-cipher-suites.c                    |   5 +-
 crypto/tlscreds.c                             |   2 +-
 crypto/tlscredsanon.c                         |   4 +-
 crypto/tlscredspsk.c                          |   4 +-
 crypto/tlscredsx509.c                         |   4 +-
 event-loop-base.c                             |   5 +-
 gdbstub/gdbstub.c                             |  23 ++-
 gdbstub/system.c                              |   2 +-
 hw/9pfs/virtio-9p-device.c                    |   2 +-
 hw/acpi/erst.c                                |   4 +-
 hw/acpi/generic_event_device.c                |   4 +-
 hw/acpi/pci.c                                 |   4 +-
 hw/acpi/piix4.c                               |   4 +-
 hw/acpi/vmclock.c                             |   2 +-
 hw/acpi/vmgenid.c                             |   2 +-
 hw/adc/aspeed_adc.c                           |  10 +-
 hw/adc/npcm7xx_adc.c                          |   2 +-
 hw/adc/stm32f2xx_adc.c                        |   2 +-
 hw/adc/zynq-xadc.c                            |   2 +-
 hw/alpha/typhoon.c                            |   2 +-
 hw/arm/allwinner-a10.c                        |   2 +-
 hw/arm/allwinner-h3.c                         |   2 +-
 hw/arm/allwinner-r40.c                        |   2 +-
 hw/arm/armsse.c                               |   6 +-
 hw/arm/armv7m.c                               |   4 +-
 hw/arm/aspeed.c                               |  59 +++++---
 hw/arm/aspeed_ast10x0.c                       |   2 +-
 hw/arm/aspeed_ast2400.c                       |   4 +-
 hw/arm/aspeed_ast2600.c                       |   2 +-
 hw/arm/aspeed_ast27x0.c                       |   4 +-
 hw/arm/aspeed_soc_common.c                    |   2 +-
 hw/arm/b-l475e-iot01a.c                       |   2 +-
 hw/arm/bcm2835_peripherals.c                  |   2 +-
 hw/arm/bcm2836.c                              |   8 +-
 hw/arm/bcm2838.c                              |   2 +-
 hw/arm/bcm2838_peripherals.c                  |   2 +-
 hw/arm/collie.c                               |   2 +-
 hw/arm/digic.c                                |   2 +-
 hw/arm/exynos4210.c                           |   2 +-
 hw/arm/exynos4_boards.c                       |   4 +-
 hw/arm/fby35.c                                |   2 +-
 hw/arm/fsl-imx25.c                            |   2 +-
 hw/arm/fsl-imx31.c                            |   2 +-
 hw/arm/fsl-imx6.c                             |   2 +-
 hw/arm/fsl-imx6ul.c                           |   2 +-
 hw/arm/fsl-imx7.c                             |   2 +-
 hw/arm/fsl-imx8mp.c                           |   2 +-
 hw/arm/highbank.c                             |   6 +-
 hw/arm/integratorcp.c                         |   6 +-
 hw/arm/microbit.c                             |   2 +-
 hw/arm/mps2-tz.c                              |  12 +-
 hw/arm/mps2.c                                 |  10 +-
 hw/arm/mps3r.c                                |   4 +-
 hw/arm/msf2-soc.c                             |   2 +-
 hw/arm/musca.c                                |   6 +-
 hw/arm/musicpal.c                             |  14 +-
 hw/arm/npcm7xx.c                              |   6 +-
 hw/arm/npcm7xx_boards.c                       |  12 +-
 hw/arm/npcm8xx.c                              |   2 +-
 hw/arm/npcm8xx_boards.c                       |   4 +-
 hw/arm/nrf51_soc.c                            |   2 +-
 hw/arm/omap_sx1.c                             |   4 +-
 hw/arm/raspi.c                                |  10 +-
 hw/arm/raspi4b.c                              |   2 +-
 hw/arm/realview.c                             |   8 +-
 hw/arm/sbsa-ref.c                             |   2 +-
 hw/arm/smmu-common.c                          |   2 +-
 hw/arm/smmuv3.c                               |   4 +-
 hw/arm/stellaris.c                            |  10 +-
 hw/arm/stm32f100_soc.c                        |   2 +-
 hw/arm/stm32f205_soc.c                        |   2 +-
 hw/arm/stm32f405_soc.c                        |   2 +-
 hw/arm/stm32l4x5_soc.c                        |   8 +-
 hw/arm/strongarm.c                            |  13 +-
 hw/arm/versatilepb.c                          |   6 +-
 hw/arm/vexpress.c                             |   6 +-
 hw/arm/virt.c                                 |   6 +-
 hw/arm/xen-pvh.c                              |   2 +-
 hw/arm/xilinx_zynq.c                          |   2 +-
 hw/arm/xlnx-versal-virt.c                     |   2 +-
 hw/arm/xlnx-versal.c                          |   2 +-
 hw/arm/xlnx-zcu102.c                          |   2 +-
 hw/arm/xlnx-zynqmp.c                          |   2 +-
 hw/audio/ac97.c                               |   4 +-
 hw/audio/adlib.c                              |   2 +-
 hw/audio/asc.c                                |   2 +-
 hw/audio/cs4231.c                             |   2 +-
 hw/audio/cs4231a.c                            |   2 +-
 hw/audio/es1370.c                             |   4 +-
 hw/audio/gus.c                                |   2 +-
 hw/audio/hda-codec.c                          |   8 +-
 hw/audio/intel-hda.c                          |  10 +-
 hw/audio/marvell_88w8618.c                    |   2 +-
 hw/audio/pcspk.c                              |   2 +-
 hw/audio/pl041.c                              |   2 +-
 hw/audio/sb16.c                               |   2 +-
 hw/audio/via-ac97.c                           |   8 +-
 hw/audio/virtio-snd-pci.c                     |   2 +-
 hw/audio/virtio-snd.c                         |   2 +-
 hw/audio/wm8750.c                             |   2 +-
 hw/avr/arduino.c                              |  10 +-
 hw/avr/atmega.c                               |  10 +-
 hw/block/fdc-isa.c                            |   4 +-
 hw/block/fdc-sysbus.c                         |   6 +-
 hw/block/fdc.c                                |   2 +-
 hw/block/m25p80.c                             |   6 +-
 hw/block/nand.c                               |   2 +-
 hw/block/pflash_cfi01.c                       |   2 +-
 hw/block/pflash_cfi02.c                       |   2 +-
 hw/block/swim.c                               |   4 +-
 hw/block/vhost-user-blk.c                     |   2 +-
 hw/block/virtio-blk.c                         |   2 +-
 hw/block/xen-block.c                          |   6 +-
 hw/char/avr_usart.c                           |   2 +-
 hw/char/bcm2835_aux.c                         |   2 +-
 hw/char/cadence_uart.c                        |   2 +-
 hw/char/cmsdk-apb-uart.c                      |   2 +-
 hw/char/debugcon.c                            |   2 +-
 hw/char/digic-uart.c                          |   2 +-
 hw/char/diva-gsp.c                            |   8 +-
 hw/char/escc.c                                |   2 +-
 hw/char/exynos4210_uart.c                     |   2 +-
 hw/char/goldfish_tty.c                        |   2 +-
 hw/char/grlib_apbuart.c                       |   2 +-
 hw/char/ibex_uart.c                           |   2 +-
 hw/char/imx_serial.c                          |   2 +-
 hw/char/ipoctal232.c                          |   2 +-
 hw/char/mcf_uart.c                            |   2 +-
 hw/char/mchp_pfsoc_mmuart.c                   |   2 +-
 hw/char/nrf51_uart.c                          |   2 +-
 hw/char/parallel.c                            |   4 +-
 hw/char/pl011.c                               |   2 +-
 hw/char/renesas_sci.c                         |   2 +-
 hw/char/sclpconsole-lm.c                      |   2 +-
 hw/char/sclpconsole.c                         |   2 +-
 hw/char/serial-isa.c                          |   4 +-
 hw/char/serial-mm.c                           |   2 +-
 hw/char/serial-pci-multi.c                    |  10 +-
 hw/char/serial-pci.c                          |   4 +-
 hw/char/serial.c                              |   2 +-
 hw/char/sh_serial.c                           |   2 +-
 hw/char/shakti_uart.c                         |   2 +-
 hw/char/sifive_uart.c                         |   2 +-
 hw/char/spapr_vty.c                           |   2 +-
 hw/char/stm32f2xx_usart.c                     |   2 +-
 hw/char/stm32l4x5_usart.c                     |   9 +-
 hw/char/terminal3270.c                        |   2 +-
 hw/char/virtio-console.c                      |   4 +-
 hw/char/virtio-serial-bus.c                   |   8 +-
 hw/char/xen_console.c                         |   2 +-
 hw/char/xilinx_uartlite.c                     |   2 +-
 hw/core/bus.c                                 |   4 +-
 hw/core/clock.c                               |   2 +-
 hw/core/cpu-common.c                          |  76 +++++++++-
 hw/core/cpu-system.c                          |   2 +-
 hw/core/generic-loader.c                      |   2 +-
 hw/core/guest-loader.c                        |   2 +-
 hw/core/loader.c                              |   4 +-
 hw/core/machine-qmp-cmds.c                    |  10 +-
 hw/core/machine.c                             |   4 +-
 hw/core/or-irq.c                              |   2 +-
 hw/core/platform-bus.c                        |   2 +-
 hw/core/qdev.c                                |   6 +-
 hw/core/register.c                            |   2 +-
 hw/core/reset.c                               |   2 +-
 hw/core/resetcontainer.c                      |   3 +-
 hw/core/split-irq.c                           |   2 +-
 hw/core/sysbus.c                              |   7 +-
 hw/cpu/a15mpcore.c                            |   2 +-
 hw/cpu/a9mpcore.c                             |   2 +-
 hw/cpu/arm11mpcore.c                          |   2 +-
 hw/cpu/cluster.c                              |   2 +-
 hw/cpu/core.c                                 |   2 +-
 hw/cpu/realview_mpcore.c                      |   2 +-
 hw/cxl/switch-mailbox-cci.c                   |   4 +-
 hw/display/artist.c                           |   2 +-
 hw/display/ati.c                              |   4 +-
 hw/display/bcm2835_fb.c                       |   2 +-
 hw/display/bochs-display.c                    |   4 +-
 hw/display/cg3.c                              |   2 +-
 hw/display/cirrus_vga.c                       |   4 +-
 hw/display/cirrus_vga_isa.c                   |   2 +-
 hw/display/dm163.c                            |   2 +-
 hw/display/dpcd.c                             |   2 +-
 hw/display/exynos4210_fimd.c                  |   2 +-
 hw/display/g364fb.c                           |   2 +-
 hw/display/i2c-ddc.c                          |   2 +-
 hw/display/jazz_led.c                         |   2 +-
 hw/display/macfb.c                            |   4 +-
 hw/display/next-fb.c                          |   2 +-
 hw/display/pl110.c                            |   2 +-
 hw/display/qxl.c                              |   8 +-
 hw/display/ramfb-standalone.c                 |   2 +-
 hw/display/sii9022.c                          |   2 +-
 hw/display/sm501.c                            |   6 +-
 hw/display/ssd0303.c                          |   2 +-
 hw/display/ssd0323.c                          |   2 +-
 hw/display/tcx.c                              |   2 +-
 hw/display/vga-isa.c                          |   2 +-
 hw/display/vga-mmio.c                         |   2 +-
 hw/display/vga-pci.c                          |   8 +-
 hw/display/vga.c                              |   2 +-
 hw/display/vhost-user-gpu.c                   |   2 +-
 hw/display/virtio-gpu-base.c                  |   2 +-
 hw/display/virtio-gpu-gl.c                    |   2 +-
 hw/display/virtio-gpu-pci-rutabaga.c          |   2 +-
 hw/display/virtio-gpu-pci.c                   |   2 +-
 hw/display/virtio-gpu-rutabaga.c              |   2 +-
 hw/display/virtio-gpu.c                       |   2 +-
 hw/display/virtio-vga.c                       |   2 +-
 hw/display/vmware_vga.c                       |   4 +-
 hw/display/xlnx_dp.c                          |   2 +-
 hw/dma/bcm2835_dma.c                          |   2 +-
 hw/dma/i82374.c                               |   2 +-
 hw/dma/i8257.c                                |   4 +-
 hw/dma/pl080.c                                |   2 +-
 hw/dma/pl330.c                                |   2 +-
 hw/dma/rc4030.c                               |   4 +-
 hw/dma/sifive_pdma.c                          |   2 +-
 hw/dma/sparc32_dma.c                          |  10 +-
 hw/dma/xilinx_axidma.c                        |   9 +-
 hw/dma/xlnx-zdma.c                            |   2 +-
 hw/dma/xlnx-zynq-devcfg.c                     |   2 +-
 hw/dma/xlnx_csu_dma.c                         |   4 +-
 hw/dma/xlnx_dpdma.c                           |   2 +-
 hw/fsi/aspeed_apb2opb.c                       |   2 +-
 hw/fsi/cfam.c                                 |   2 +-
 hw/fsi/fsi-master.c                           |   2 +-
 hw/fsi/fsi.c                                  |   2 +-
 hw/fsi/lbus.c                                 |   2 +-
 hw/gpio/aspeed_gpio.c                         |  16 +-
 hw/gpio/bcm2835_gpio.c                        |   2 +-
 hw/gpio/bcm2838_gpio.c                        |   2 +-
 hw/gpio/gpio_key.c                            |   2 +-
 hw/gpio/imx_gpio.c                            |   2 +-
 hw/gpio/mpc8xxx.c                             |   2 +-
 hw/gpio/npcm7xx_gpio.c                        |   2 +-
 hw/gpio/nrf51_gpio.c                          |   2 +-
 hw/gpio/omap_gpio.c                           |   2 +-
 hw/gpio/pca9552.c                             |   4 +-
 hw/gpio/pca9554.c                             |   2 +-
 hw/gpio/pcf8574.c                             |   2 +-
 hw/gpio/pl061.c                               |   2 +-
 hw/gpio/sifive_gpio.c                         |   2 +-
 hw/gpio/stm32l4x5_gpio.c                      |   2 +-
 hw/gpio/zaurus.c                              |   2 +-
 hw/hppa/machine.c                             |   8 +-
 hw/hyperv/hv-balloon.c                        |   2 +-
 hw/hyperv/hyperv.c                            |   2 +-
 hw/hyperv/hyperv_testdev.c                    |   2 +-
 hw/hyperv/syndbg.c                            |   2 +-
 hw/hyperv/vmbus.c                             |   6 +-
 hw/i2c/allwinner-i2c.c                        |   2 +-
 hw/i2c/aspeed_i2c.c                           |  17 ++-
 hw/i2c/bcm2835_i2c.c                          |   2 +-
 hw/i2c/bitbang_i2c.c                          |   2 +-
 hw/i2c/core.c                                 |   2 +-
 hw/i2c/exynos4210_i2c.c                       |   2 +-
 hw/i2c/i2c_mux_pca954x.c                      |   6 +-
 hw/i2c/imx_i2c.c                              |   2 +-
 hw/i2c/microbit_i2c.c                         |   2 +-
 hw/i2c/mpc_i2c.c                              |   2 +-
 hw/i2c/npcm7xx_smbus.c                        |   2 +-
 hw/i2c/omap_i2c.c                             |   2 +-
 hw/i2c/pmbus_device.c                         |   2 +-
 hw/i2c/ppc4xx_i2c.c                           |   2 +-
 hw/i2c/smbus_eeprom.c                         |   2 +-
 hw/i2c/smbus_ich9.c                           |   4 +-
 hw/i2c/smbus_slave.c                          |   2 +-
 hw/i386/amd_iommu.c                           |   9 +-
 hw/i386/intel_iommu.c                         |   4 +-
 hw/i386/kvm/apic.c                            |   2 +-
 hw/i386/kvm/clock.c                           |   2 +-
 hw/i386/kvm/i8254.c                           |   2 +-
 hw/i386/kvm/i8259.c                           |   2 +-
 hw/i386/kvm/ioapic.c                          |   2 +-
 hw/i386/kvm/xen_evtchn.c                      |   2 +-
 hw/i386/kvm/xen_gnttab.c                      |   2 +-
 hw/i386/kvm/xen_overlay.c                     |   2 +-
 hw/i386/kvm/xen_primary_console.c             |   2 +-
 hw/i386/kvm/xen_xenstore.c                    |   2 +-
 hw/i386/microvm.c                             |   4 +-
 hw/i386/nitro_enclave.c                       |   2 +-
 hw/i386/pc.c                                  |   4 +-
 hw/i386/port92.c                              |   2 +-
 hw/i386/sgx-epc.c                             |   4 +-
 hw/i386/vapic.c                               |   2 +-
 hw/i386/vmmouse.c                             |   2 +-
 hw/i386/vmport.c                              |   2 +-
 hw/i386/x86-iommu.c                           |   2 +-
 hw/i386/x86.c                                 |   4 +-
 hw/i386/xen/xen-pvh.c                         |   2 +-
 hw/i386/xen/xen_apic.c                        |   2 +-
 hw/i386/xen/xen_platform.c                    |   4 +-
 hw/i386/xen/xen_pvdevice.c                    |   4 +-
 hw/ide/ahci-allwinner.c                       |   2 +-
 hw/ide/ahci-sysbus.c                          |   2 +-
 hw/ide/cf.c                                   |   2 +-
 hw/ide/cmd646.c                               |   2 +-
 hw/ide/ich.c                                  |   4 +-
 hw/ide/ide-bus.c                              |   2 +-
 hw/ide/ide-dev.c                              |   6 +-
 hw/ide/isa.c                                  |   2 +-
 hw/ide/macio.c                                |   2 +-
 hw/ide/mmio.c                                 |   2 +-
 hw/ide/pci.c                                  |   2 +-
 hw/ide/piix.c                                 |   4 +-
 hw/ide/sii3112.c                              |   2 +-
 hw/ide/via.c                                  |   2 +-
 hw/input/adb-kbd.c                            |   2 +-
 hw/input/adb-mouse.c                          |   2 +-
 hw/input/adb.c                                |   4 +-
 hw/input/lasips2.c                            |   8 +-
 hw/input/pckbd.c                              |   6 +-
 hw/input/pl050.c                              |   6 +-
 hw/input/ps2.c                                |   6 +-
 hw/input/stellaris_gamepad.c                  |   2 +-
 hw/input/virtio-input-hid.c                   |   6 +-
 hw/input/virtio-input-host.c                  |   2 +-
 hw/input/virtio-input.c                       |   2 +-
 hw/intc/allwinner-a10-pic.c                   |   2 +-
 hw/intc/apic.c                                |   2 +-
 hw/intc/apic_common.c                         |   2 +-
 hw/intc/arm_gic.c                             |   2 +-
 hw/intc/arm_gic_common.c                      |   4 +-
 hw/intc/arm_gic_kvm.c                         |   2 +-
 hw/intc/arm_gicv2m.c                          |   2 +-
 hw/intc/arm_gicv3.c                           |   2 +-
 hw/intc/arm_gicv3_common.c                    |   4 +-
 hw/intc/arm_gicv3_its.c                       |   2 +-
 hw/intc/arm_gicv3_its_common.c                |   2 +-
 hw/intc/arm_gicv3_its_kvm.c                   |   2 +-
 hw/intc/arm_gicv3_kvm.c                       |   2 +-
 hw/intc/armv7m_nvic.c                         |   2 +-
 hw/intc/aspeed_intc.c                         |   6 +-
 hw/intc/aspeed_vic.c                          |   2 +-
 hw/intc/bcm2835_ic.c                          |   2 +-
 hw/intc/bcm2836_control.c                     |   2 +-
 hw/intc/exynos4210_combiner.c                 |   2 +-
 hw/intc/exynos4210_gic.c                      |   2 +-
 hw/intc/goldfish_pic.c                        |   4 +-
 hw/intc/grlib_irqmp.c                         |   2 +-
 hw/intc/heathrow_pic.c                        |   2 +-
 hw/intc/i8259.c                               |   7 +-
 hw/intc/i8259_common.c                        |   4 +-
 hw/intc/imx_avic.c                            |   2 +-
 hw/intc/imx_gpcv2.c                           |   2 +-
 hw/intc/ioapic.c                              |   2 +-
 hw/intc/ioapic_common.c                       |   4 +-
 hw/intc/loongarch_extioi.c                    |   2 +-
 hw/intc/loongarch_extioi_common.c             |   5 +-
 hw/intc/loongarch_ipi.c                       |   4 +-
 hw/intc/loongarch_pch_msi.c                   |   2 +-
 hw/intc/loongarch_pch_pic.c                   |   2 +-
 hw/intc/loongarch_pic_common.c                |   3 +-
 hw/intc/loongson_ipi.c                        |   2 +-
 hw/intc/loongson_ipi_common.c                 |   2 +-
 hw/intc/m68k_irqc.c                           |   4 +-
 hw/intc/mips_gic.c                            |   2 +-
 hw/intc/omap_intc.c                           |   2 +-
 hw/intc/ompic.c                               |   2 +-
 hw/intc/openpic.c                             |   2 +-
 hw/intc/openpic_kvm.c                         |   2 +-
 hw/intc/pl190.c                               |   2 +-
 hw/intc/pnv_xive.c                            |   4 +-
 hw/intc/pnv_xive2.c                           |   4 +-
 hw/intc/ppc-uic.c                             |   2 +-
 hw/intc/realview_gic.c                        |   2 +-
 hw/intc/riscv_aclint.c                        |   4 +-
 hw/intc/riscv_aplic.c                         |   2 +-
 hw/intc/riscv_imsic.c                         |   2 +-
 hw/intc/rx_icu.c                              |   2 +-
 hw/intc/s390_flic.c                           |   4 +-
 hw/intc/s390_flic_kvm.c                       |   2 +-
 hw/intc/sifive_plic.c                         |   2 +-
 hw/intc/slavio_intctl.c                       |   4 +-
 hw/intc/spapr_xive.c                          |   4 +-
 hw/intc/xics.c                                |   4 +-
 hw/intc/xics_pnv.c                            |   2 +-
 hw/intc/xics_spapr.c                          |   4 +-
 hw/intc/xilinx_intc.c                         |   2 +-
 hw/intc/xive.c                                |  10 +-
 hw/intc/xive2.c                               |   6 +-
 hw/intc/xlnx-pmu-iomod-intc.c                 |   2 +-
 hw/intc/xlnx-zynqmp-ipi.c                     |   2 +-
 hw/ipack/ipack.c                              |   2 +-
 hw/ipack/tpci200.c                            |   4 +-
 hw/ipmi/ipmi.c                                |   4 +-
 hw/ipmi/ipmi_bmc_extern.c                     |   2 +-
 hw/ipmi/ipmi_bmc_sim.c                        |   2 +-
 hw/ipmi/isa_ipmi_bt.c                         |   4 +-
 hw/ipmi/isa_ipmi_kcs.c                        |   4 +-
 hw/ipmi/pci_ipmi_bt.c                         |   4 +-
 hw/ipmi/pci_ipmi_kcs.c                        |   4 +-
 hw/ipmi/smbus_ipmi.c                          |   4 +-
 hw/isa/fdc37m81x-superio.c                    |   2 +-
 hw/isa/i82378.c                               |   4 +-
 hw/isa/isa-bus.c                              |   6 +-
 hw/isa/isa-superio.c                          |   2 +-
 hw/isa/lpc_ich9.c                             |   4 +-
 hw/isa/pc87312.c                              |   2 +-
 hw/isa/piix.c                                 |   8 +-
 hw/isa/smc37c669-superio.c                    |   2 +-
 hw/isa/vt82c686.c                             |  20 +--
 hw/loongarch/virt.c                           |   4 +-
 hw/m68k/mcf5206.c                             |   2 +-
 hw/m68k/mcf_intc.c                            |   2 +-
 hw/m68k/next-cube.c                           |   8 +-
 hw/m68k/next-kbd.c                            |   2 +-
 hw/m68k/q800-glue.c                           |   4 +-
 hw/m68k/q800.c                                |   2 +-
 hw/m68k/virt.c                                |   4 +-
 hw/mem/cxl_type3.c                            |   4 +-
 hw/mem/npcm7xx_mc.c                           |   2 +-
 hw/mem/nvdimm.c                               |   2 +-
 hw/mem/pc-dimm.c                              |   4 +-
 hw/mem/sparse-mem.c                           |   2 +-
 hw/microblaze/boot.c                          |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  12 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |   3 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  14 +-
 hw/mips/cps.c                                 |   2 +-
 hw/mips/jazz.c                                |  15 +-
 hw/mips/loongson3_virt.c                      |   2 +-
 hw/mips/malta.c                               |  21 +--
 hw/mips/mipssim.c                             |  11 +-
 hw/misc/a9scu.c                               |   2 +-
 hw/misc/allwinner-a10-ccm.c                   |   2 +-
 hw/misc/allwinner-a10-dramc.c                 |   2 +-
 hw/misc/allwinner-cpucfg.c                    |   2 +-
 hw/misc/allwinner-h3-ccu.c                    |   2 +-
 hw/misc/allwinner-h3-dramc.c                  |   2 +-
 hw/misc/allwinner-h3-sysctrl.c                |   3 +-
 hw/misc/allwinner-r40-ccu.c                   |   2 +-
 hw/misc/allwinner-r40-dramc.c                 |   2 +-
 hw/misc/allwinner-sid.c                       |   2 +-
 hw/misc/allwinner-sramc.c                     |   4 +-
 hw/misc/applesmc.c                            |   4 +-
 hw/misc/arm11scu.c                            |   2 +-
 hw/misc/arm_l2x0.c                            |   2 +-
 hw/misc/arm_sysctl.c                          |   2 +-
 hw/misc/armsse-cpu-pwrctrl.c                  |   2 +-
 hw/misc/armsse-cpuid.c                        |   2 +-
 hw/misc/armsse-mhu.c                          |   2 +-
 hw/misc/armv7m_ras.c                          |   2 +-
 hw/misc/aspeed_hace.c                         |  12 +-
 hw/misc/aspeed_i3c.c                          |   4 +-
 hw/misc/aspeed_lpc.c                          |   2 +-
 hw/misc/aspeed_peci.c                         |   2 +-
 hw/misc/aspeed_sbc.c                          |   4 +-
 hw/misc/aspeed_scu.c                          |  14 +-
 hw/misc/aspeed_sdmc.c                         |  10 +-
 hw/misc/aspeed_sli.c                          |   6 +-
 hw/misc/aspeed_xdma.c                         |   8 +-
 hw/misc/auxbus.c                              |   6 +-
 hw/misc/avr_power.c                           |   2 +-
 hw/misc/axp2xx.c                              |   6 +-
 hw/misc/bcm2835_cprman.c                      |  10 +-
 hw/misc/bcm2835_mbox.c                        |   2 +-
 hw/misc/bcm2835_mphi.c                        |   2 +-
 hw/misc/bcm2835_powermgt.c                    |   2 +-
 hw/misc/bcm2835_property.c                    |   2 +-
 hw/misc/bcm2835_rng.c                         |   2 +-
 hw/misc/bcm2835_thermal.c                     |   2 +-
 hw/misc/debugexit.c                           |   2 +-
 hw/misc/djmemc.c                              |   2 +-
 hw/misc/eccmemctl.c                           |   2 +-
 hw/misc/edu.c                                 |  23 ++-
 hw/misc/empty_slot.c                          |   2 +-
 hw/misc/exynos4210_clk.c                      |   2 +-
 hw/misc/exynos4210_pmu.c                      |   2 +-
 hw/misc/exynos4210_rng.c                      |   2 +-
 hw/misc/grlib_ahb_apb_pnp.c                   |   4 +-
 hw/misc/i2c-echo.c                            |   2 +-
 hw/misc/imx25_ccm.c                           |   2 +-
 hw/misc/imx31_ccm.c                           |   2 +-
 hw/misc/imx6_ccm.c                            |   2 +-
 hw/misc/imx6_src.c                            |   2 +-
 hw/misc/imx6ul_ccm.c                          |   2 +-
 hw/misc/imx7_ccm.c                            |   4 +-
 hw/misc/imx7_gpr.c                            |   2 +-
 hw/misc/imx7_snvs.c                           |   2 +-
 hw/misc/imx7_src.c                            |   2 +-
 hw/misc/imx8mp_analog.c                       |   2 +-
 hw/misc/imx8mp_ccm.c                          |   2 +-
 hw/misc/imx_rngc.c                            |   2 +-
 hw/misc/iosb.c                                |   2 +-
 hw/misc/iotkit-secctl.c                       |   2 +-
 hw/misc/iotkit-sysctl.c                       |   2 +-
 hw/misc/iotkit-sysinfo.c                      |   2 +-
 hw/misc/ivshmem-flat.c                        |   2 +-
 hw/misc/ivshmem-pci.c                         |   8 +-
 hw/misc/lasi.c                                |   2 +-
 hw/misc/led.c                                 |   2 +-
 hw/misc/mac_via.c                             |   4 +-
 hw/misc/macio/cuda.c                          |   4 +-
 hw/misc/macio/gpio.c                          |   4 +-
 hw/misc/macio/mac_dbdma.c                     |   2 +-
 hw/misc/macio/macio.c                         |   8 +-
 hw/misc/macio/pmu.c                           |   4 +-
 hw/misc/mchp_pfsoc_dmc.c                      |   5 +-
 hw/misc/mchp_pfsoc_ioscb.c                    |   2 +-
 hw/misc/mchp_pfsoc_sysreg.c                   |   2 +-
 hw/misc/mips_cmgcr.c                          |   2 +-
 hw/misc/mips_cpc.c                            |   2 +-
 hw/misc/mips_itu.c                            |   2 +-
 hw/misc/mos6522.c                             |   2 +-
 hw/misc/mps2-fpgaio.c                         |   2 +-
 hw/misc/mps2-scc.c                            |   2 +-
 hw/misc/msf2-sysreg.c                         |   2 +-
 hw/misc/npcm7xx_mft.c                         |   2 +-
 hw/misc/npcm7xx_pwm.c                         |   2 +-
 hw/misc/npcm7xx_rng.c                         |   2 +-
 hw/misc/npcm_clk.c                            |  12 +-
 hw/misc/npcm_gcr.c                            |   6 +-
 hw/misc/nrf51_rng.c                           |   2 +-
 hw/misc/pc-testdev.c                          |   2 +-
 hw/misc/pci-testdev.c                         |   4 +-
 hw/misc/pvpanic-isa.c                         |   4 +-
 hw/misc/pvpanic-mmio.c                        |   2 +-
 hw/misc/pvpanic-pci.c                         |   4 +-
 hw/misc/sbsa_ec.c                             |   2 +-
 hw/misc/sifive_e_aon.c                        |   2 +-
 hw/misc/sifive_u_otp.c                        |   2 +-
 hw/misc/sifive_u_prci.c                       |   2 +-
 hw/misc/slavio_misc.c                         |   2 +-
 hw/misc/stm32_rcc.c                           |   2 +-
 hw/misc/stm32f2xx_syscfg.c                    |   2 +-
 hw/misc/stm32f4xx_exti.c                      |   2 +-
 hw/misc/stm32f4xx_syscfg.c                    |   2 +-
 hw/misc/stm32l4x5_exti.c                      |   2 +-
 hw/misc/stm32l4x5_rcc.c                       |   6 +-
 hw/misc/stm32l4x5_syscfg.c                    |   2 +-
 hw/misc/tz-mpc.c                              |   4 +-
 hw/misc/tz-msc.c                              |   2 +-
 hw/misc/tz-ppc.c                              |   2 +-
 hw/misc/unimp.c                               |   2 +-
 hw/misc/virt_ctrl.c                           |   2 +-
 hw/misc/vmcoreinfo.c                          |   2 +-
 hw/misc/xlnx-versal-cframe-reg.c              |   6 +-
 hw/misc/xlnx-versal-cfu.c                     |  10 +-
 hw/misc/xlnx-versal-crl.c                     |   2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c            |   3 +-
 hw/misc/xlnx-versal-trng.c                    |   2 +-
 hw/misc/xlnx-versal-xramc.c                   |   2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c                |   2 +-
 hw/misc/xlnx-zynqmp-crf.c                     |   2 +-
 hw/misc/zynq_slcr.c                           |   2 +-
 hw/net/allwinner-sun8i-emac.c                 |   3 +-
 hw/net/allwinner_emac.c                       |   2 +-
 hw/net/cadence_gem.c                          |   2 +-
 hw/net/can/can_kvaser_pci.c                   |   4 +-
 hw/net/can/can_mioe3680_pci.c                 |   4 +-
 hw/net/can/can_pcm3680_pci.c                  |   4 +-
 hw/net/can/ctucan_pci.c                       |   4 +-
 hw/net/can/xlnx-versal-canfd.c                |   6 +-
 hw/net/can/xlnx-zynqmp-can.c                  |   2 +-
 hw/net/dp8393x.c                              |   2 +-
 hw/net/e1000.c                                |   6 +-
 hw/net/e1000e.c                               |   4 +-
 hw/net/eepro100.c                             |   4 +-
 hw/net/fsl_etsec/etsec.c                      |   2 +-
 hw/net/ftgmac100.c                            |   4 +-
 hw/net/igb.c                                  |   4 +-
 hw/net/igbvf.c                                |   4 +-
 hw/net/imx_fec.c                              |   2 +-
 hw/net/lan9118.c                              |   2 +-
 hw/net/lan9118_phy.c                          |   2 +-
 hw/net/lance.c                                |   2 +-
 hw/net/lasi_i82596.c                          |   2 +-
 hw/net/mcf_fec.c                              |   2 +-
 hw/net/mipsnet.c                              |   2 +-
 hw/net/msf2-emac.c                            |   2 +-
 hw/net/mv88w8618_eth.c                        |   2 +-
 hw/net/ne2000-isa.c                           |   2 +-
 hw/net/ne2000-pci.c                           |   4 +-
 hw/net/npcm7xx_emc.c                          |   2 +-
 hw/net/npcm_gmac.c                            |   2 +-
 hw/net/npcm_pcs.c                             |   2 +-
 hw/net/opencores_eth.c                        |   2 +-
 hw/net/pcnet-pci.c                            |   4 +-
 hw/net/rocker/rocker.c                        |   4 +-
 hw/net/rtl8139.c                              |   4 +-
 hw/net/smc91c111.c                            |   2 +-
 hw/net/spapr_llan.c                           |   2 +-
 hw/net/stellaris_enet.c                       |   2 +-
 hw/net/sungem.c                               |   4 +-
 hw/net/sunhme.c                               |   4 +-
 hw/net/tulip.c                                |   4 +-
 hw/net/virtio-net.c                           |   2 +-
 hw/net/vmxnet3.c                              |   4 +-
 hw/net/xen_nic.c                              |   2 +-
 hw/net/xgmac.c                                |   2 +-
 hw/net/xilinx_axienet.c                       |  11 +-
 hw/net/xilinx_ethlite.c                       |   2 +-
 hw/nubus/mac-nubus-bridge.c                   |   2 +-
 hw/nubus/nubus-bridge.c                       |   2 +-
 hw/nubus/nubus-bus.c                          |   2 +-
 hw/nubus/nubus-device.c                       |   2 +-
 hw/nubus/nubus-virtio-mmio.c                  |   2 +-
 hw/nvme/ctrl.c                                |   4 +-
 hw/nvme/ns.c                                  |   2 +-
 hw/nvme/subsys.c                              |   2 +-
 hw/nvram/bcm2835_otp.c                        |   2 +-
 hw/nvram/ds1225y.c                            |   2 +-
 hw/nvram/eeprom_at24c.c                       |   2 +-
 hw/nvram/fw_cfg.c                             |   6 +-
 hw/nvram/mac_nvram.c                          |   2 +-
 hw/nvram/npcm7xx_otp.c                        |   6 +-
 hw/nvram/nrf51_nvm.c                          |   2 +-
 hw/nvram/spapr_nvram.c                        |   2 +-
 hw/nvram/xlnx-bbram.c                         |   2 +-
 hw/nvram/xlnx-efuse.c                         |   2 +-
 hw/nvram/xlnx-versal-efuse-cache.c            |   2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c             |   2 +-
 hw/nvram/xlnx-zynqmp-efuse.c                  |   2 +-
 hw/openrisc/openrisc_sim.c                    |   2 +-
 hw/openrisc/virt.c                            |   2 +-
 hw/pci-bridge/cxl_downstream.c                |   4 +-
 hw/pci-bridge/cxl_root_port.c                 |   4 +-
 hw/pci-bridge/cxl_upstream.c                  |   4 +-
 hw/pci-bridge/gen_pcie_root_port.c            |   2 +-
 hw/pci-bridge/i82801b11.c                     |   4 +-
 hw/pci-bridge/ioh3420.c                       |   2 +-
 hw/pci-bridge/pci_bridge_dev.c                |   6 +-
 hw/pci-bridge/pci_expander_bridge.c           |  18 +--
 hw/pci-bridge/pcie_pci_bridge.c               |   4 +-
 hw/pci-bridge/pcie_root_port.c                |   4 +-
 hw/pci-bridge/simba.c                         |   4 +-
 hw/pci-bridge/xio3130_downstream.c            |   4 +-
 hw/pci-bridge/xio3130_upstream.c              |   4 +-
 hw/pci-host/articia.c                         |  10 +-
 hw/pci-host/astro.c                           |   6 +-
 hw/pci-host/bonito.c                          |   6 +-
 hw/pci-host/designware.c                      |  59 +++-----
 hw/pci-host/dino.c                            |   2 +-
 hw/pci-host/fsl_imx8m_phy.c                   |   2 +-
 hw/pci-host/gpex.c                            |   6 +-
 hw/pci-host/grackle.c                         |   6 +-
 hw/pci-host/gt64120.c                         |   6 +-
 hw/pci-host/i440fx.c                          |   6 +-
 hw/pci-host/mv64361.c                         |   8 +-
 hw/pci-host/pnv_phb.c                         |   4 +-
 hw/pci-host/pnv_phb3.c                        |   6 +-
 hw/pci-host/pnv_phb3_msi.c                    |   2 +-
 hw/pci-host/pnv_phb3_pbcq.c                   |   4 +-
 hw/pci-host/pnv_phb4.c                        |   8 +-
 hw/pci-host/pnv_phb4_pec.c                    |   8 +-
 hw/pci-host/ppc440_pcix.c                     |   2 +-
 hw/pci-host/ppc4xx_pci.c                      |   6 +-
 hw/pci-host/ppce500.c                         |   6 +-
 hw/pci-host/q35.c                             |   6 +-
 hw/pci-host/raven.c                           |   6 +-
 hw/pci-host/remote.c                          |   2 +-
 hw/pci-host/sabre.c                           |   6 +-
 hw/pci-host/sh_pci.c                          |   6 +-
 hw/pci-host/uninorth.c                        |  27 ++--
 hw/pci-host/versatile.c                       |   6 +-
 hw/pci-host/xen_igd_pt.c                      |   3 +-
 hw/pci-host/xilinx-pcie.c                     |   6 +-
 hw/pci/pci.c                                  |  10 +-
 hw/pci/pci_bridge.c                           |   4 +-
 hw/pci/pci_host.c                             |   2 +-
 hw/pci/pcie_port.c                            |   6 +-
 hw/ppc/amigaone.c                             |   2 +-
 hw/ppc/e500plat.c                             |   4 +-
 hw/ppc/mac_newworld.c                         |   4 +-
 hw/ppc/mac_oldworld.c                         |   4 +-
 hw/ppc/mpc8544ds.c                            |   2 +-
 hw/ppc/pef.c                                  |   2 +-
 hw/ppc/pegasos2.c                             |   4 +-
 hw/ppc/pnv.c                                  |  33 ++--
 hw/ppc/pnv_adu.c                              |   4 +-
 hw/ppc/pnv_chiptod.c                          |  10 +-
 hw/ppc/pnv_core.c                             |  14 +-
 hw/ppc/pnv_homer.c                            |   8 +-
 hw/ppc/pnv_i2c.c                              |   4 +-
 hw/ppc/pnv_lpc.c                              |  10 +-
 hw/ppc/pnv_n1_chiplet.c                       |   4 +-
 hw/ppc/pnv_nest_pervasive.c                   |   4 +-
 hw/ppc/pnv_occ.c                              |   8 +-
 hw/ppc/pnv_pnor.c                             |   2 +-
 hw/ppc/pnv_psi.c                              |  12 +-
 hw/ppc/pnv_sbe.c                              |   6 +-
 hw/ppc/ppc440_bamboo.c                        |   2 +-
 hw/ppc/ppc440_uc.c                            |   2 +-
 hw/ppc/ppc4xx_devs.c                          |   8 +-
 hw/ppc/ppc4xx_sdram.c                         |   4 +-
 hw/ppc/ppce500_spin.c                         |   2 +-
 hw/ppc/prep_systemio.c                        |   2 +-
 hw/ppc/rs6000_mc.c                            |   2 +-
 hw/ppc/sam460ex.c                             |   2 +-
 hw/ppc/spapr.c                                |   6 +-
 hw/ppc/spapr_cpu_core.c                       |   4 +-
 hw/ppc/spapr_drc.c                            |  16 +-
 hw/ppc/spapr_iommu.c                          |   5 +-
 hw/ppc/spapr_nvdimm.c                         |   2 +-
 hw/ppc/spapr_pci.c                            |   4 +-
 hw/ppc/spapr_rng.c                            |   2 +-
 hw/ppc/spapr_rtc.c                            |   2 +-
 hw/ppc/spapr_tpm_proxy.c                      |   2 +-
 hw/ppc/spapr_vio.c                            |   6 +-
 hw/ppc/virtex_ml507.c                         |   2 +-
 hw/remote/machine.c                           |   4 +-
 hw/remote/proxy.c                             |   4 +-
 hw/remote/remote-obj.c                        |   4 +-
 hw/remote/vfio-user-obj.c                     |   4 +-
 hw/riscv/microchip_pfsoc.c                    |   5 +-
 hw/riscv/opentitan.c                          |   4 +-
 hw/riscv/riscv-iommu-pci.c                    |   4 +-
 hw/riscv/riscv-iommu-sys.c                    |   2 +-
 hw/riscv/riscv-iommu.c                        |   4 +-
 hw/riscv/riscv_hart.c                         |   2 +-
 hw/riscv/shakti_c.c                           |   4 +-
 hw/riscv/sifive_e.c                           |   4 +-
 hw/riscv/sifive_u.c                           |   4 +-
 hw/riscv/spike.c                              |   2 +-
 hw/riscv/virt.c                               |   4 +-
 hw/rtc/allwinner-rtc.c                        |   8 +-
 hw/rtc/aspeed_rtc.c                           |   2 +-
 hw/rtc/ds1338.c                               |   2 +-
 hw/rtc/exynos4210_rtc.c                       |   2 +-
 hw/rtc/goldfish_rtc.c                         |   2 +-
 hw/rtc/ls7a_rtc.c                             |   2 +-
 hw/rtc/m41t80.c                               |   2 +-
 hw/rtc/m48t59-isa.c                           |   6 +-
 hw/rtc/m48t59.c                               |   7 +-
 hw/rtc/mc146818rtc.c                          |   4 +-
 hw/rtc/pl031.c                                |   2 +-
 hw/rtc/rs5c372.c                              |   2 +-
 hw/rtc/sun4v-rtc.c                            |   2 +-
 hw/rtc/xlnx-zynqmp-rtc.c                      |   2 +-
 hw/rx/rx-gdbsim.c                             |   6 +-
 hw/rx/rx62n.c                                 |   6 +-
 hw/s390x/3270-ccw.c                           |   2 +-
 hw/s390x/ap-bridge.c                          |   6 +-
 hw/s390x/ap-device.c                          |   2 +-
 hw/s390x/ccw-device.c                         |   2 +-
 hw/s390x/css-bridge.c                         |   6 +-
 hw/s390x/event-facility.c                     |   4 +-
 hw/s390x/ipl.c                                |   2 +-
 hw/s390x/s390-ccw.c                           |   2 +-
 hw/s390x/s390-pci-bus.c                       |   9 +-
 hw/s390x/s390-skeys-kvm.c                     |   2 +-
 hw/s390x/s390-skeys.c                         |   4 +-
 hw/s390x/s390-stattrib-kvm.c                  |   2 +-
 hw/s390x/s390-stattrib.c                      |   4 +-
 hw/s390x/s390-virtio-ccw.c                    |   8 +-
 hw/s390x/sclp.c                               |   2 +-
 hw/s390x/sclpcpu.c                            |   2 +-
 hw/s390x/sclpquiesce.c                        |   2 +-
 hw/s390x/tod-kvm.c                            |   2 +-
 hw/s390x/tod-tcg.c                            |   2 +-
 hw/s390x/tod.c                                |   2 +-
 hw/s390x/vhost-scsi-ccw.c                     |   2 +-
 hw/s390x/vhost-user-fs-ccw.c                  |   2 +-
 hw/s390x/vhost-vsock-ccw.c                    |   2 +-
 hw/s390x/virtio-ccw-9p.c                      |   2 +-
 hw/s390x/virtio-ccw-balloon.c                 |   2 +-
 hw/s390x/virtio-ccw-blk.c                     |   2 +-
 hw/s390x/virtio-ccw-crypto.c                  |   2 +-
 hw/s390x/virtio-ccw-gpu.c                     |   2 +-
 hw/s390x/virtio-ccw-input.c                   |   2 +-
 hw/s390x/virtio-ccw-md.c                      |   2 +-
 hw/s390x/virtio-ccw-mem.c                     |   2 +-
 hw/s390x/virtio-ccw-net.c                     |   2 +-
 hw/s390x/virtio-ccw-rng.c                     |   2 +-
 hw/s390x/virtio-ccw-scsi.c                    |   2 +-
 hw/s390x/virtio-ccw-serial.c                  |   2 +-
 hw/s390x/virtio-ccw.c                         |   4 +-
 hw/scsi/esp-pci.c                             |   6 +-
 hw/scsi/esp.c                                 |   4 +-
 hw/scsi/lsi53c895a.c                          |   6 +-
 hw/scsi/megasas.c                             |  10 +-
 hw/scsi/mptsas.c                              |   4 +-
 hw/scsi/scsi-bus.c                            |   6 +-
 hw/scsi/scsi-disk.c                           |   8 +-
 hw/scsi/scsi-generic.c                        |   2 +-
 hw/scsi/spapr_vscsi.c                         |   2 +-
 hw/scsi/vhost-scsi.c                          |   4 +-
 hw/scsi/vhost-user-scsi.c                     |   4 +-
 hw/scsi/virtio-scsi.c                         |   6 +-
 hw/scsi/vmw_pvscsi.c                          |   4 +-
 hw/sd/allwinner-sdhost.c                      |  15 +-
 hw/sd/aspeed_sdhci.c                          |  10 +-
 hw/sd/bcm2835_sdhost.c                        |   2 +-
 hw/sd/cadence_sdhci.c                         |   2 +-
 hw/sd/npcm7xx_sdhci.c                         |   2 +-
 hw/sd/omap_mmc.c                              |   2 +-
 hw/sd/pl181.c                                 |   4 +-
 hw/sd/sd.c                                    |   8 +-
 hw/sd/sdhci-pci.c                             |   4 +-
 hw/sd/sdhci.c                                 |   4 +-
 hw/sd/ssi-sd.c                                |   2 +-
 hw/sensor/adm1266.c                           |   2 +-
 hw/sensor/adm1272.c                           |   2 +-
 hw/sensor/dps310.c                            |   2 +-
 hw/sensor/emc141x.c                           |   4 +-
 hw/sensor/isl_pmbus_vr.c                      |   8 +-
 hw/sensor/lsm303dlhc_mag.c                    |   2 +-
 hw/sensor/max31785.c                          |   2 +-
 hw/sensor/max34451.c                          |   2 +-
 hw/sensor/tmp105.c                            |   2 +-
 hw/sensor/tmp421.c                            |   4 +-
 hw/sparc/sun4m.c                              |  28 ++--
 hw/sparc/sun4m_iommu.c                        |   5 +-
 hw/sparc64/niagara.c                          |   2 +-
 hw/sparc64/sun4u.c                            |  16 +-
 hw/sparc64/sun4u_iommu.c                      |   5 +-
 hw/ssi/allwinner-a10-spi.c                    |   2 +-
 hw/ssi/aspeed_smc.c                           |  36 ++---
 hw/ssi/bcm2835_spi.c                          |   2 +-
 hw/ssi/ibex_spi_host.c                        |   2 +-
 hw/ssi/imx_spi.c                              |   2 +-
 hw/ssi/mss-spi.c                              |   2 +-
 hw/ssi/npcm7xx_fiu.c                          |   2 +-
 hw/ssi/npcm_pspi.c                            |   2 +-
 hw/ssi/pl022.c                                |   2 +-
 hw/ssi/pnv_spi.c                              |   4 +-
 hw/ssi/sifive_spi.c                           |   2 +-
 hw/ssi/ssi.c                                  |   4 +-
 hw/ssi/stm32f2xx_spi.c                        |   2 +-
 hw/ssi/xilinx_spi.c                           |   2 +-
 hw/ssi/xilinx_spips.c                         |   6 +-
 hw/ssi/xlnx-versal-ospi.c                     |   2 +-
 hw/timer/a9gtimer.c                           |   2 +-
 hw/timer/allwinner-a10-pit.c                  |   2 +-
 hw/timer/arm_mptimer.c                        |   2 +-
 hw/timer/arm_timer.c                          |   2 +-
 hw/timer/armv7m_systick.c                     |   2 +-
 hw/timer/aspeed_timer.c                       |  12 +-
 hw/timer/avr_timer16.c                        |   2 +-
 hw/timer/bcm2835_systmr.c                     |   2 +-
 hw/timer/cadence_ttc.c                        |   2 +-
 hw/timer/cmsdk-apb-dualtimer.c                |   2 +-
 hw/timer/cmsdk-apb-timer.c                    |   2 +-
 hw/timer/digic-timer.c                        |   2 +-
 hw/timer/exynos4210_mct.c                     |   2 +-
 hw/timer/exynos4210_pwm.c                     |   2 +-
 hw/timer/grlib_gptimer.c                      |   2 +-
 hw/timer/hpet.c                               |   2 +-
 hw/timer/i8254.c                              |   2 +-
 hw/timer/i8254_common.c                       |   2 +-
 hw/timer/ibex_timer.c                         |   2 +-
 hw/timer/imx_epit.c                           |   2 +-
 hw/timer/imx_gpt.c                            |   2 +-
 hw/timer/mss-timer.c                          |   2 +-
 hw/timer/npcm7xx_timer.c                      |   2 +-
 hw/timer/nrf51_timer.c                        |   2 +-
 hw/timer/pxa2xx_timer.c                       |   4 +-
 hw/timer/renesas_cmt.c                        |   2 +-
 hw/timer/renesas_tmr.c                        |   2 +-
 hw/timer/sifive_pwm.c                         |   2 +-
 hw/timer/slavio_timer.c                       |   2 +-
 hw/timer/sse-counter.c                        |   2 +-
 hw/timer/sse-timer.c                          |   2 +-
 hw/timer/stellaris-gptm.c                     |   2 +-
 hw/timer/stm32f2xx_timer.c                    |   2 +-
 hw/timer/xilinx_timer.c                       |   2 +-
 hw/tpm/tpm_crb.c                              |   4 +-
 hw/tpm/tpm_spapr.c                            |   4 +-
 hw/tpm/tpm_tis_i2c.c                          |   4 +-
 hw/tpm/tpm_tis_isa.c                          |   4 +-
 hw/tpm/tpm_tis_sysbus.c                       |   4 +-
 hw/tricore/tc27x_soc.c                        |   4 +-
 hw/tricore/triboard.c                         |   2 +-
 hw/tricore/tricore_testdevice.c               |   2 +-
 hw/uefi/var-service-sysbus.c                  |   4 +-
 hw/ufs/lu.c                                   |   2 +-
 hw/ufs/ufs.c                                  |   6 +-
 hw/usb/bus.c                                  |   6 +-
 hw/usb/canokey.c                              |   2 +-
 hw/usb/ccid-card-emulated.c                   |   2 +-
 hw/usb/ccid-card-passthru.c                   |   2 +-
 hw/usb/chipidea.c                             |   2 +-
 hw/usb/dev-audio.c                            |   2 +-
 hw/usb/dev-hid.c                              |   8 +-
 hw/usb/dev-hub.c                              |   2 +-
 hw/usb/dev-mtp.c                              |   2 +-
 hw/usb/dev-network.c                          |   2 +-
 hw/usb/dev-serial.c                           |   6 +-
 hw/usb/dev-smartcard-reader.c                 |   6 +-
 hw/usb/dev-storage-bot.c                      |   2 +-
 hw/usb/dev-storage-classic.c                  |   2 +-
 hw/usb/dev-storage.c                          |   2 +-
 hw/usb/dev-uas.c                              |   2 +-
 hw/usb/dev-wacom.c                            |   2 +-
 hw/usb/hcd-dwc2.c                             |   2 +-
 hw/usb/hcd-dwc3.c                             |   2 +-
 hw/usb/hcd-ehci-pci.c                         |   6 +-
 hw/usb/hcd-ehci-sysbus.c                      |  16 +-
 hw/usb/hcd-ohci-pci.c                         |   4 +-
 hw/usb/hcd-ohci-sysbus.c                      |   2 +-
 hw/usb/hcd-uhci.c                             |   6 +-
 hw/usb/hcd-xhci-nec.c                         |   2 +-
 hw/usb/hcd-xhci-pci.c                         |   6 +-
 hw/usb/hcd-xhci-sysbus.c                      |   2 +-
 hw/usb/hcd-xhci.c                             |  15 +-
 hw/usb/host-libusb.c                          |   2 +-
 hw/usb/imx-usb-phy.c                          |   2 +-
 hw/usb/redirect.c                             |   2 +-
 hw/usb/u2f-emulated.c                         |   2 +-
 hw/usb/u2f-passthru.c                         |   2 +-
 hw/usb/u2f.c                                  |   2 +-
 hw/usb/xlnx-usb-subsystem.c                   |   2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c           |   2 +-
 hw/vfio/amd-xgbe.c                            |   2 +-
 hw/vfio/ap.c                                  |   2 +-
 hw/vfio/calxeda-xgmac.c                       |   2 +-
 hw/vfio/ccw.c                                 |   2 +-
 hw/vfio/container.c                           |   4 +-
 hw/vfio/igd.c                                 |   5 +-
 hw/vfio/iommufd.c                             |   4 +-
 hw/vfio/pci.c                                 |   7 +-
 hw/vfio/platform.c                            |   2 +-
 hw/vfio/spapr.c                               |   2 +-
 hw/virtio/vdpa-dev-pci.c                      |   3 +-
 hw/virtio/vdpa-dev.c                          |   2 +-
 hw/virtio/vhost-scsi-pci.c                    |   2 +-
 hw/virtio/vhost-user-base.c                   |   2 +-
 hw/virtio/vhost-user-blk-pci.c                |   2 +-
 hw/virtio/vhost-user-device-pci.c             |   3 +-
 hw/virtio/vhost-user-device.c                 |   2 +-
 hw/virtio/vhost-user-fs-pci.c                 |   2 +-
 hw/virtio/vhost-user-fs.c                     |   2 +-
 hw/virtio/vhost-user-gpio-pci.c               |   2 +-
 hw/virtio/vhost-user-gpio.c                   |   2 +-
 hw/virtio/vhost-user-i2c-pci.c                |   2 +-
 hw/virtio/vhost-user-i2c.c                    |   2 +-
 hw/virtio/vhost-user-input.c                  |   2 +-
 hw/virtio/vhost-user-rng-pci.c                |   2 +-
 hw/virtio/vhost-user-rng.c                    |   2 +-
 hw/virtio/vhost-user-scmi-pci.c               |   2 +-
 hw/virtio/vhost-user-scmi.c                   |   2 +-
 hw/virtio/vhost-user-scsi-pci.c               |   2 +-
 hw/virtio/vhost-user-snd-pci.c                |   2 +-
 hw/virtio/vhost-user-snd.c                    |   2 +-
 hw/virtio/vhost-user-vsock-pci.c              |   3 +-
 hw/virtio/vhost-user-vsock.c                  |   2 +-
 hw/virtio/vhost-vsock-common.c                |   2 +-
 hw/virtio/vhost-vsock-pci.c                   |   2 +-
 hw/virtio/vhost-vsock.c                       |   2 +-
 hw/virtio/virtio-9p-pci.c                     |   2 +-
 hw/virtio/virtio-balloon-pci.c                |   2 +-
 hw/virtio/virtio-balloon.c                    |   2 +-
 hw/virtio/virtio-blk-pci.c                    |   2 +-
 hw/virtio/virtio-bus.c                        |   2 +-
 hw/virtio/virtio-crypto-pci.c                 |   2 +-
 hw/virtio/virtio-crypto.c                     |   2 +-
 hw/virtio/virtio-input-pci.c                  |   7 +-
 hw/virtio/virtio-iommu-pci.c                  |   2 +-
 hw/virtio/virtio-iommu.c                      |   4 +-
 hw/virtio/virtio-md-pci.c                     |   2 +-
 hw/virtio/virtio-mem-pci.c                    |   2 +-
 hw/virtio/virtio-mem.c                        |   7 +-
 hw/virtio/virtio-mmio.c                       |   4 +-
 hw/virtio/virtio-net-pci.c                    |   2 +-
 hw/virtio/virtio-nsm-pci.c                    |   2 +-
 hw/virtio/virtio-nsm.c                        |   2 +-
 hw/virtio/virtio-pci.c                        |  18 +--
 hw/virtio/virtio-pmem-pci.c                   |   2 +-
 hw/virtio/virtio-pmem.c                       |   2 +-
 hw/virtio/virtio-rng-pci.c                    |   2 +-
 hw/virtio/virtio-rng.c                        |   2 +-
 hw/virtio/virtio-scsi-pci.c                   |   2 +-
 hw/virtio/virtio-serial-pci.c                 |   2 +-
 hw/virtio/virtio.c                            |   4 +-
 hw/vmapple/aes.c                              |   2 +-
 hw/vmapple/bdif.c                             |   2 +-
 hw/vmapple/cfg.c                              |   2 +-
 hw/vmapple/virtio-blk.c                       |   5 +-
 hw/vmapple/vmapple.c                          |   2 +-
 hw/watchdog/allwinner-wdt.c                   |   6 +-
 hw/watchdog/cmsdk-apb-watchdog.c              |   2 +-
 hw/watchdog/sbsa_gwdt.c                       |   2 +-
 hw/watchdog/spapr_watchdog.c                  |   2 +-
 hw/watchdog/wdt_aspeed.c                      |  12 +-
 hw/watchdog/wdt_diag288.c                     |   2 +-
 hw/watchdog/wdt_i6300esb.c                    |   4 +-
 hw/watchdog/wdt_ib700.c                       |   2 +-
 hw/watchdog/wdt_imx2.c                        |   2 +-
 hw/xen/xen-bus.c                              |   6 +-
 hw/xen/xen-legacy-backend.c                   |   6 +-
 hw/xen/xen-pvh-common.c                       |   2 +-
 hw/xen/xen_pt.c                               |   4 +-
 hw/xen/xen_pt_graphics.c                      |   4 +-
 hw/xtensa/xtfpga.c                            |  16 +-
 io/channel-buffer.c                           |   2 +-
 io/channel-command.c                          |   2 +-
 io/channel-file.c                             |   2 +-
 io/channel-null.c                             |   2 +-
 io/channel-socket.c                           |   2 +-
 io/channel-tls.c                              |   2 +-
 io/channel-websock.c                          |   2 +-
 iothread.c                                    |   2 +-
 linux-user/elfload.c                          |  63 +++++---
 migration/channel-block.c                     |   2 +-
 migration/migration.c                         |   2 +-
 migration/rdma.c                              |   2 +-
 net/can/can_core.c                            |   4 +-
 net/can/can_host.c                            |   4 +-
 net/can/can_socketcan.c                       |   2 +-
 net/colo-compare.c                            |   4 +-
 net/dump.c                                    |   2 +-
 net/filter-buffer.c                           |   2 +-
 net/filter-mirror.c                           |   4 +-
 net/filter-replay.c                           |   2 +-
 net/filter-rewriter.c                         |   2 +-
 net/filter.c                                  |   4 +-
 plugins/loader.c                              |   2 +-
 qom/object.c                                  |  15 +-
 scsi/pr-manager-helper.c                      |   2 +-
 scsi/pr-manager.c                             |   2 +-
 system/datadir.c                              |   5 +-
 system/memory.c                               |   6 +-
 system/qtest.c                                |   6 +-
 system/vl.c                                   |   6 +-
 target-info-stub.c                            |  26 ++++
 target-info.c                                 |  16 ++
 target/alpha/cpu.c                            |   2 +-
 target/arm/cpu.c                              |  25 ++-
 target/arm/cpu64.c                            |  18 +--
 target/arm/gdbstub.c                          |  12 ++
 target/arm/hyp_gdbstub.c                      |   8 +-
 target/arm/tcg/cpu-v7m.c                      |   3 +-
 target/avr/cpu.c                              |   2 +-
 target/hexagon/cpu.c                          |   2 +-
 target/hexagon/genptr.c                       |   8 +-
 target/hexagon/idef-parser/parser-helpers.c   |   2 +-
 target/hexagon/translate.c                    |   6 +-
 target/hppa/cpu.c                             |   2 +-
 target/i386/confidential-guest.c              |   2 +-
 target/i386/cpu.c                             |  11 +-
 target/i386/host-cpu.c                        |   2 +-
 target/i386/hvf/hvf-cpu.c                     |   2 +-
 target/i386/kvm/kvm-cpu.c                     |   2 +-
 target/i386/nvmm/nvmm-accel-ops.c             |   2 +-
 target/i386/nvmm/nvmm-all.c                   |   2 +-
 target/i386/sev.c                             |   8 +-
 target/i386/tcg/tcg-cpu.c                     |   2 +-
 target/i386/whpx/whpx-accel-ops.c             |   2 +-
 target/i386/whpx/whpx-all.c                   |   2 +-
 target/i386/whpx/whpx-apic.c                  |   2 +-
 target/loongarch/cpu.c                        |   6 +-
 target/m68k/cpu.c                             |   6 +-
 target/microblaze/cpu.c                       |   2 +-
 target/mips/cpu.c                             |   6 +-
 target/mips/tcg/msa_helper.c                  |  34 ++---
 target/openrisc/cpu.c                         |   2 +-
 target/ppc/cpu-models.c                       |   2 +-
 target/ppc/cpu_init.c                         |  97 ++++++------
 target/ppc/kvm.c                              |   4 +-
 target/riscv/cpu.c                            |   4 +-
 target/riscv/kvm/kvm-cpu.c                    |   4 +-
 target/riscv/tcg/tcg-cpu.c                    |   2 +-
 target/rx/cpu.c                               |   2 +-
 target/s390x/cpu.c                            |   3 +-
 target/s390x/cpu_models.c                     |  14 +-
 target/s390x/kvm/pv.c                         |   2 +-
 target/sh4/cpu.c                              |   8 +-
 target/sparc/cpu.c                            |   9 +-
 target/tricore/cpu.c                          |   2 +-
 target/xtensa/cpu.c                           |   2 +-
 target/xtensa/helper.c                        |   4 +-
 target/xtensa/translate.c                     |  10 +-
 tests/tcg/plugins/mem.c                       |   4 +-
 tests/tcg/plugins/syscall.c                   |   4 +-
 tests/unit/check-qom-interface.c              |   4 +-
 tests/unit/check-qom-proplist.c               |   8 +-
 tests/unit/test-qdev-global-props.c           |   8 +-
 tests/unit/test-smp-parse.c                   |  23 +--
 ui/console-vc.c                               |   6 +-
 ui/console.c                                  |   4 +-
 ui/dbus-chardev.c                             |   2 +-
 ui/dbus.c                                     |   6 +-
 ui/gtk.c                                      |   2 +-
 ui/input-barrier.c                            |   4 +-
 ui/input-linux.c                              |   4 +-
 ui/spice-app.c                                |   2 +-
 ui/vdagent.c                                  |   2 +-
 util/main-loop.c                              |   2 +-
 util/thread-context.c                         |   4 +-
 target/i386/tcg/emit.c.inc                    |   6 +-
 target/mips/tcg/mips16e_translate.c.inc       |   4 +-
 accel/meson.build                             |   1 +
 hw/display/apple-gfx-mmio.m                   |   2 +-
 hw/display/apple-gfx-pci.m                    |   4 +-
 pc-bios/{ => dtb}/bamboo.dtb                  | Bin
 pc-bios/{ => dtb}/bamboo.dts                  |   0
 pc-bios/{ => dtb}/canyonlands.dtb             | Bin
 pc-bios/{ => dtb}/canyonlands.dts             |   0
 pc-bios/dtb/meson.build                       |  23 +++
 pc-bios/{ => dtb}/petalogix-ml605.dtb         | Bin
 pc-bios/{ => dtb}/petalogix-ml605.dts         |   0
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb    | Bin
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dts    |   0
 pc-bios/meson.build                           |  23 +--
 qemu.nsi                                      |   2 +-
 rust/qemu-api/src/qom.rs                      |   8 +-
 .../codeconverter/qom_type_info.py            |   3 +-
 .../codeconverter/test_regexps.py             |  12 +-
 1202 files changed, 2817 insertions(+), 2612 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)
 create mode 100644 include/accel/accel-cpu.h
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 include/qemu/target-info.h
 create mode 100644 accel/accel-common.c
 create mode 100644 target-info-stub.c
 create mode 100644 target-info.c
 rename pc-bios/{ => dtb}/bamboo.dtb (100%)
 rename pc-bios/{ => dtb}/bamboo.dts (100%)
 rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
 rename pc-bios/{ => dtb}/canyonlands.dts (100%)
 create mode 100644 pc-bios/dtb/meson.build
 rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

-- 
2.47.1


