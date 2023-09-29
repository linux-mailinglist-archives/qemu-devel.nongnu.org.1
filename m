Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF417B3196
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBuI-0001XJ-QZ; Fri, 29 Sep 2023 07:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qmBuG-0001XA-Cv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qmBuB-0003tO-U4
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695987815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=x18LnHGAzmuY/5OCCQJlioY3OA9b09mhznNvaHcEsgI=;
 b=EHggWXZOzAHHQwP24QfgWIO6dPSYTaitkB2xodv1gj3sj3nwqywBtkml2ETb4WVgNddDsO
 0/9UmtrhBUTsj3IbDjjRjbu2fsQPgYs8sC2lcBMVL8Hwf4jlQXWpRTHT8GNK+2bNTTKPEP
 8wrO6yBU8QS/L7yiahP9g1t74gFJusE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-crqdoSxqPlKX3jvYEXhHUQ-1; Fri, 29 Sep 2023 07:43:32 -0400
X-MC-Unique: crqdoSxqPlKX3jvYEXhHUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE893C0D19E
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 11:43:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C3C40C6EBF
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 11:43:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8047921E6904; Fri, 29 Sep 2023 13:43:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: MAINTAINERS still leaves more files uncovered than I'd like
Date: Fri, 29 Sep 2023 13:43:30 +0200
Message-ID: <87lecp6w7x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Back in 2014 (time flies), I posted

    Subject: MAINTAINERS leaves too many files uncovered
    Message-ID: <87mw8rumhb.fsf@blackfin.pond.sub.org>
    https://lore.kernel.org/qemu-devel/87mw8rumhb.fsf@blackfin.pond.sub.org/

I updated my findings in 2015, 2016 (at commit e00da552a0d), and 2018
(at v3.1.0-rc2).  This is another update, at commit 36e9aab3c56.

Unsurprisingly, the number of files in the tree

    $ git-ls-files | wc -l

grows over time:

    year  2014  2015  2016  2018  2023
    #     3746  4387  4921  6461  9788

Looks exponential to me, doubling every seven years or so.

The number of .c files has grown more slowly:

    year  2014  2015  2016  2018  2023
    #     1836  1945  2132  2633  3588

The number of .c files not covered by MAINTAINERS

    $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unmaintained-files
    $ grep -c '\.c$' unmaintained-files

went down a lot after my first post, but has since flatlined:

    year  2014  2015  2016  2018  2023
    #     1066   461   402   259   246

It looks like we've pretty much stopped adding more unmaintained .c
files, i.e. cherry-picking the kernel's 13f1937ef33 (checkpatch: emit a
warning on file add/move/delete) as commit 4be6131e329 worked.

On the other hand, we're not making progress on the remaining old ones
anymore.


Currently unmaintained files by extension, with a long tail that doesn't
add up to anything interesting omitted:

                #files                percent
    ext     unmaintained  total     unmaintained
    h               329    2504         13%
    c               246    3588          7%
    rst             103     240         43%
    <none>           95     716         13%
    build            52     211         25%
    mak              47     104         45%
    decode           44      77         57%
    txt              23      53         43%
    bin              20      27         75%
    rom              15      15        100%
    inc              14     147         10%
    cocci            14      23         61%

Observations:

1. More unmaintained .h than .c.  Suggests sloppy accounting in
   MAINTAINERS.  Low-hanging fruit?

2. The number of unmaintained .rst and .txt suggests we're less
   interested in maintaining documentation.

3. The number of unmaintained .build and .mak suggests we're less
   interested in maintaining the build system.


Where are the remaining unmaintained files now?  Top-scoring
directories, files in sub-directories not counted:

    $ sed 's,/[^/]*$,/,;s,^[^/]*$,./,' unmaintained-files | sort | uniq -c | sort -nr

      # directory
     84 include/qemu/
     56 util/
     50 pc-bios/
     46 tests/unit/
     45 tests/decode/
     40 include/standard-headers/linux/
     38 docs/system/
     35 pc-bios/keymaps/
     30 docs/devel/
     26 configs/targets/
     26 ./
     25 roms/
     22 target/i386/
     22 hw/core/
     19 scripts/
     19 include/exec/
     19 hw/display/
     14 tests/multiboot/
     14 scripts/coccinelle/
     14 include/sysemu/
     14 include/hw/
     12 po/
     12 hw/misc/
     12 hw/intc/
     12 docs/
     11 pc-bios/optionrom/
     11 docs/specs/
     10 tests/tcg/riscv64/
     10 tests/tcg/ppc64/
     10 disas/


Which unmaintained files are we still changing?  Unmaintained files
sorted by number of commits in the past year (since commit 5433af7697b):

    $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list 5433af7697b.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn

    186 MAINTAINERS
     65 target/i386/cpu.c
     54 qemu-options.hx
     45 target/i386/cpu.h
     22 tests/unit/test-bdrv-drain.c
     21 target/i386/ops_sse.h
     21 VERSION
     19 tests/unit/test-cutils.c
     19 include/monitor/hmp.h
     18 docs/system/arm/emulation.rst
     16 include/qemu/osdep.h
     16 hw/misc/meson.build
     15 hw/virtio/meson.build
     14 util/meson.build
     12 include/qemu/typedefs.h
     12 docs/about/removed-features.rst
     11 util/cutils.c
     10 tests/unit/test-block-iothread.c
    [82 more with fewer than 10 changes]

Several of these we clearly need to cover in MAINTAINERS.


Full list of unmaintained files:

.dir-locals.el
.editorconfig
.exrc
.gdbinit
.git-blame-ignore-revs
.gitattributes
.gitignore
.gitlab/issue_templates/bug.md
.gitlab/issue_templates/feature_request.md
.gitmodules
.gitpublish
.mailmap
.patchew.yml
.readthedocs.yml
COPYING
COPYING.LIB
LICENSE
MAINTAINERS
README.rst
VERSION
accel/accel-softmmu.h
accel/dummy-cpus.c
accel/meson.build
accel/stubs/meson.build
accel/stubs/xen-stub.c
backends/confidential-guest-support.c
backends/dbus-vmstate1.xml
backends/meson.build
backends/trace-events
backends/trace.h
configs/devices/aarch64-softmmu/default.mak
configs/devices/aarch64-softmmu/minimal.mak
configs/devices/alpha-softmmu/default.mak
configs/devices/arm-softmmu/default.mak
configs/devices/cris-softmmu/default.mak
configs/devices/i386-softmmu/default.mak
configs/devices/m68k-softmmu/default.mak
configs/devices/microblaze-softmmu/default.mak
configs/devices/microblazeel-softmmu/default.mak
configs/devices/or1k-softmmu/default.mak
configs/devices/ppc-softmmu/default.mak
configs/devices/ppc64-softmmu/default.mak
configs/devices/riscv32-softmmu/default.mak
configs/devices/riscv64-softmmu/default.mak
configs/devices/rx-softmmu/default.mak
configs/devices/sh4-softmmu/default.mak
configs/devices/sh4eb-softmmu/default.mak
configs/devices/sparc-softmmu/default.mak
configs/devices/sparc64-softmmu/default.mak
configs/devices/tricore-softmmu/default.mak
configs/devices/x86_64-softmmu/default.mak
configs/targets/aarch64-softmmu.mak
configs/targets/alpha-softmmu.mak
configs/targets/arm-softmmu.mak
configs/targets/avr-softmmu.mak
configs/targets/cris-softmmu.mak
configs/targets/hppa-softmmu.mak
configs/targets/i386-softmmu.mak
configs/targets/m68k-softmmu.mak
configs/targets/microblaze-softmmu.mak
configs/targets/microblazeel-softmmu.mak
configs/targets/nios2-softmmu.mak
configs/targets/or1k-softmmu.mak
configs/targets/ppc-softmmu.mak
configs/targets/ppc64-softmmu.mak
configs/targets/riscv32-softmmu.mak
configs/targets/riscv64-softmmu.mak
configs/targets/rx-softmmu.mak
configs/targets/s390x-softmmu.mak
configs/targets/sh4-softmmu.mak
configs/targets/sh4eb-softmmu.mak
configs/targets/sparc-softmmu.mak
configs/targets/sparc64-softmmu.mak
configs/targets/tricore-softmmu.mak
configs/targets/x86_64-softmmu.mak
configs/targets/xtensa-softmmu.mak
configs/targets/xtensaeb-softmmu.mak
contrib/ivshmem-client/ivshmem-client.c
contrib/ivshmem-client/ivshmem-client.h
contrib/ivshmem-client/main.c
contrib/ivshmem-client/meson.build
contrib/ivshmem-server/ivshmem-server.c
contrib/ivshmem-server/ivshmem-server.h
contrib/ivshmem-server/main.c
contrib/ivshmem-server/meson.build
contrib/systemd/qemu-guest-agent.service
contrib/systemd/qemu-pr-helper.service
contrib/systemd/qemu-pr-helper.socket
disas/capstone.c
disas/disas-internal.h
disas/disas-mon.c
disas/disas.c
disas/meson.build
disas/riscv-xthead.c
disas/riscv-xthead.h
disas/riscv-xventana.c
disas/riscv-xventana.h
disas/riscv.h
docs/about/build-platforms.rst
docs/about/emulation.rst
docs/about/index.rst
docs/about/license.rst
docs/about/removed-features.rst
docs/bypass-iommu.txt
docs/config/ich9-ehci-uhci.cfg
docs/config/mach-virt-graphical.cfg
docs/config/mach-virt-serial.cfg
docs/config/q35-emulated.cfg
docs/config/q35-virtio-graphical.cfg
docs/config/q35-virtio-serial.cfg
docs/defs.rst.inc
docs/devel/atomics.rst
docs/devel/bitops.rst
docs/devel/blkdebug.txt
docs/devel/blkverify.txt
docs/devel/block-coroutine-wrapper.rst
docs/devel/ci-definitions.rst.inc
docs/devel/ci-jobs.rst.inc
docs/devel/ci-runners.rst.inc
docs/devel/ci.rst
docs/devel/control-flow-integrity.rst
docs/devel/ebpf_rss.rst
docs/devel/index-api.rst
docs/devel/index-build.rst
docs/devel/index-internals.rst
docs/devel/index-process.rst
docs/devel/index-tcg.rst
docs/devel/index.rst
docs/devel/loads-stores.rst
docs/devel/maintainers.rst
docs/devel/memory.rst
docs/devel/modules.rst
docs/devel/multi-thread-tcg.rst
docs/devel/multiple-iothreads.txt
docs/devel/qdev-api.rst
docs/devel/qom-api.rst
docs/devel/reset.rst
docs/devel/secure-coding-practices.rst
docs/devel/stable-process.rst
docs/devel/writing-monitor-commands.rst
docs/devel/zoned-storage.rst
docs/image-fuzzer.txt
docs/index.rst
docs/interop/barrier.rst
docs/interop/index.rst
docs/interop/live-block-operations.rst
docs/interop/pr-helper.rst
docs/interop/prl-xml.txt
docs/interop/qed_spec.txt
docs/interop/vhost-vdpa.rst
docs/interop/vnc-ledstate-pseudo-encoding.rst
docs/memory-hotplug.txt
docs/meson.build
docs/multi-thread-compression.txt
docs/multiseat.txt
docs/qcow2-cache.txt
docs/qemupciserial.inf
docs/rdma.txt
docs/specs/acpi_erst.rst
docs/specs/edu.txt
docs/specs/fw_cfg.rst
docs/specs/index.rst
docs/specs/ivshmem-spec.txt
docs/specs/pvpanic.txt
docs/specs/sev-guest-firmware.rst
docs/specs/standard-vga.txt
docs/specs/virt-ctlr.txt
docs/specs/vmcoreinfo.txt
docs/specs/vmw_pvscsi-spec.txt
docs/sphinx-static/custom.js
docs/sphinx-static/theme_overrides.css
docs/spin/aio_notify.promela
docs/spin/aio_notify_accept.promela
docs/spin/aio_notify_bug.promela
docs/spin/tcg-exclusive.promela
docs/spin/win32-qemu-event.promela
docs/system/arm/bananapi_m2u.rst
docs/system/arm/emulation.rst
docs/system/arm/xenpvh.rst
docs/system/authz.rst
docs/system/barrier.rst
docs/system/bootindex.rst
docs/system/confidential-guest-support.rst
docs/system/cpu-hotplug.rst
docs/system/device-emulation.rst
docs/system/device-url-syntax.rst.inc
docs/system/devices/can.rst
docs/system/devices/ccid.rst
docs/system/devices/cxl.rst
docs/system/devices/ivshmem.rst
docs/system/devices/keyboard.rst
docs/system/devices/net.rst
docs/system/devices/usb-u2f.rst
docs/system/devices/vhost-user.rst
docs/system/devices/virtio-pmem.rst
docs/system/i386/hyperv.rst
docs/system/i386/kvm-pv.rst
docs/system/i386/pc.rst
docs/system/i386/xen.rst
docs/system/images.rst
docs/system/index.rst
docs/system/introduction.rst
docs/system/invocation.rst
docs/system/keys.rst
docs/system/keys.rst.inc
docs/system/linuxboot.rst
docs/system/managed-startup.rst
docs/system/monitor.rst
docs/system/mux-chardev.rst
docs/system/mux-chardev.rst.inc
docs/system/openrisc/emulation.rst
docs/system/openrisc/virt.rst
docs/system/ppc/embedded.rst
docs/system/ppc/ppce500.rst
docs/system/pr-manager.rst
docs/system/qemu-block-drivers.rst
docs/system/qemu-block-drivers.rst.inc
docs/system/qemu-cpu-models.rst
docs/system/qemu-manpage.rst
docs/system/riscv/microchip-icicle-kit.rst
docs/system/riscv/shakti-c.rst
docs/system/riscv/sifive_u.rst
docs/system/riscv/virt.rst
docs/system/secrets.rst
docs/system/security.rst
docs/system/target-i386-desc.rst.inc
docs/system/target-i386.rst
docs/system/target-m68k.rst
docs/system/target-openrisc.rst
docs/system/target-ppc.rst
docs/system/target-riscv.rst
docs/system/target-sparc.rst
docs/system/target-sparc64.rst
docs/system/target-xtensa.rst
docs/system/targets.rst
docs/system/tls.rst
docs/system/virtio-net-failover.rst
docs/system/vnc-security.rst
docs/tools/index.rst
docs/tools/qemu-pr-helper.rst
docs/tools/virtfs-proxy-helper.rst
docs/user/index.rst
docs/user/main.rst
docs/xbzrle.txt
event-loop-base.c
fsdev/virtfs-proxy-helper.c
host/include/aarch64/host/atomic128-cas.h
host/include/aarch64/host/atomic128-ldst.h
host/include/aarch64/host/load-extract-al16-al8.h
host/include/aarch64/host/store-insert-al16.h
host/include/generic/host/atomic128-cas.h
host/include/generic/host/atomic128-ldst.h
host/include/generic/host/load-extract-al16-al8.h
host/include/generic/host/store-insert-al16.h
host/include/x86_64/host/atomic128-ldst.h
host/include/x86_64/host/load-extract-al16-al8.h
hw/9pfs/9p-proxy.c
hw/9pfs/9p-proxy.h
hw/core/cpu-common.c
hw/core/cpu-sysemu.c
hw/core/fw-path-provider.c
hw/core/gpio.c
hw/core/guest-loader.h
hw/core/hotplug-stubs.c
hw/core/hotplug.c
hw/core/irq.c
hw/core/loader.c
hw/core/machine-hmp-cmds.c
hw/core/meson.build
hw/core/nmi.c
hw/core/or-irq.c
hw/core/platform-bus.c
hw/core/ptimer.c
hw/core/reset.c
hw/core/resettable.c
hw/core/split-irq.c
hw/core/sysbus-fdt.c
hw/core/trace-events
hw/core/trace.h
hw/core/vm-change-state-handler.c
hw/cpu/core.c
hw/cpu/meson.build
hw/display/acpi-vga-stub.c
hw/display/acpi-vga.c
hw/display/artist.c
hw/display/ati.c
hw/display/ati_2d.c
hw/display/ati_dbg.c
hw/display/ati_int.h
hw/display/ati_regs.h
hw/display/framebuffer.c
hw/display/framebuffer.h
hw/display/g364fb.c
hw/display/i2c-ddc.c
hw/display/meson.build
hw/display/sii9022.c
hw/display/ssd0303.c
hw/display/ssd0323.c
hw/display/trace-events
hw/display/trace.h
hw/display/vmware_vga.c
hw/dma/meson.build
hw/dma/soc_dma.c
hw/dma/trace-events
hw/dma/trace.h
hw/gpio/gpio_key.c
hw/gpio/gpio_pwr.c
hw/gpio/meson.build
hw/gpio/trace-events
hw/gpio/trace.h
hw/hyperv/hyperv.c
hw/hyperv/hyperv_testdev.c
hw/hyperv/meson.build
hw/hyperv/syndbg.c
hw/hyperv/trace-events
hw/hyperv/trace.h
hw/i2c/bitbang_i2c.c
hw/i2c/meson.build
hw/i2c/trace-events
hw/i2c/trace.h
hw/input/ads7846.c
hw/input/hid.c
hw/input/lasips2.c
hw/input/meson.build
hw/input/ps2.c
hw/input/trace-events
hw/input/trace.h
hw/intc/gicv3_internal.h
hw/intc/intc.c
hw/intc/meson.build
hw/intc/nios2_vic.c
hw/intc/ompic.c
hw/intc/openpic_kvm.c
hw/intc/riscv_aclint.c
hw/intc/riscv_aplic.c
hw/intc/riscv_imsic.c
hw/intc/trace-events
hw/intc/trace.h
hw/intc/vgic_common.h
hw/isa/isa-bus.c
hw/isa/meson.build
hw/isa/trace-events
hw/isa/trace.h
hw/m68k/meson.build
hw/mem/cxl_type3_stubs.c
hw/mem/meson.build
hw/mem/trace-events
hw/mem/trace.h
hw/meson.build
hw/misc/applesmc.c
hw/misc/auxbus.c
hw/misc/axp2xx.c
hw/misc/i2c-echo.c
hw/misc/ivshmem.c
hw/misc/meson.build
hw/misc/pvpanic-isa.c
hw/misc/pvpanic-pci.c
hw/misc/pvpanic.c
hw/misc/sbsa_ec.c
hw/misc/trace-events
hw/misc/trace.h
hw/nvram/ds1225y.c
hw/nvram/eeprom93xx.c
hw/nvram/eeprom_at24c.c
hw/nvram/meson.build
hw/nvram/trace-events
hw/nvram/trace.h
hw/pci-host/gpex-acpi.c
hw/pci-host/gpex.c
hw/pci-host/meson.build
hw/pci-host/trace-events
hw/pci-host/trace.h
hw/pcmcia/meson.build
hw/pcmcia/pcmcia.c
hw/ppc/fdt.c
hw/ppc/fw_cfg.c
hw/ppc/meson.build
hw/ppc/pef.c
hw/ppc/ppc405.h
hw/ppc/ppc440.h
hw/ppc/ppce500_spin.c
hw/ppc/trace-events
hw/ppc/trace.h
hw/remote/meson.build
hw/remote/trace-events
hw/remote/trace.h
hw/rtc/ds1338.c
hw/rtc/m48t59-internal.h
hw/rtc/m48t59.c
hw/rtc/meson.build
hw/rtc/trace-events
hw/rtc/trace.h
hw/sd/meson.build
hw/sd/trace-events
hw/sd/trace.h
hw/sensor/dps310.c
hw/sensor/emc141x.c
hw/sensor/lsm303dlhc_mag.c
hw/sensor/max31785.c
hw/sensor/meson.build
hw/sensor/tmp105.c
hw/sensor/tmp421.c
hw/timer/altera_timer.c
hw/timer/meson.build
hw/timer/trace-events
hw/timer/trace.h
hw/virtio/meson.build
hw/virtio/trace.h
hw/virtio/vdpa-dev-pci.c
hw/virtio/vdpa-dev.c
hw/watchdog/meson.build
hw/watchdog/sbsa_gwdt.c
hw/watchdog/trace-events
hw/watchdog/trace.h
hw/watchdog/watchdog.c
include/disas/capstone.h
include/disas/dis-asm.h
include/disas/disas.h
include/elf.h
include/exec/address-spaces.h
include/exec/confidential-guest-support.h
include/exec/hwaddr.h
include/exec/log.h
include/exec/memattrs.h
include/exec/memopidx.h
include/exec/memory_ldst.h.inc
include/exec/memory_ldst_cached.h.inc
include/exec/memory_ldst_phys.h.inc
include/exec/page-vary.h
include/exec/plugin-gen.h
include/exec/poison.h
include/exec/ramlist.h
include/exec/target_page.h
include/exec/tlb-common.h
include/exec/translate-all.h
include/exec/translation-block.h
include/exec/translator.h
include/exec/tswap.h
include/exec/user/abitypes.h
include/exec/user/guest-base.h
include/exec/user/thunk.h
include/glib-compat.h
include/hw/arm/boot.h
include/hw/arm/fdt.h
include/hw/arm/linux-boot-if.h
include/hw/arm/soc_dma.h
include/hw/arm/xen_arch_hvm.h
include/hw/block/block.h
include/hw/char/cadence_uart.h
include/hw/char/escc.h
include/hw/char/riscv_htif.h
include/hw/char/serial.h
include/hw/core/split-irq.h
include/hw/core/sysbus-fdt.h
include/hw/core/sysemu-cpu-ops.h
include/hw/cpu/core.h
include/hw/display/i2c-ddc.h
include/hw/elf_ops.h
include/hw/fw-path-provider.h
include/hw/hotplug.h
include/hw/hw.h
include/hw/hyperv/hyperv-proto.h
include/hw/hyperv/hyperv.h
include/hw/i2c/bitbang_i2c.h
include/hw/input/hid.h
include/hw/input/lasips2.h
include/hw/input/pl050.h
include/hw/input/ps2.h
include/hw/intc/i8259.h
include/hw/intc/intc.h
include/hw/intc/kvm_irqcount.h
include/hw/intc/loongson_liointc.h
include/hw/intc/nios2_vic.h
include/hw/intc/riscv_aclint.h
include/hw/intc/riscv_aplic.h
include/hw/intc/riscv_imsic.h
include/hw/ipack/ipack.h
include/hw/irq.h
include/hw/isa/isa.h
include/hw/loader-fit.h
include/hw/loader.h
include/hw/mem/sparse-mem.h
include/hw/misc/auxbus.h
include/hw/misc/ivshmem.h
include/hw/misc/pvpanic.h
include/hw/misc/raspberrypi-fw-defs.h
include/hw/nmi.h
include/hw/nvram/eeprom93xx.h
include/hw/nvram/eeprom_at24c.h
include/hw/openrisc/boot.h
include/hw/or-irq.h
include/hw/pci-bridge/pci_expander_bridge.h
include/hw/pci-bridge/xio3130_downstream.h
include/hw/pci-host/gpex.h
include/hw/pcmcia.h
include/hw/platform-bus.h
include/hw/ppc/fdt.h
include/hw/ppc/pef.h
include/hw/ptimer.h
include/hw/rdma/rdma.h
include/hw/resettable.h
include/hw/sd/cadence_sdhci.h
include/hw/sensor/emc141x_regs.h
include/hw/sensor/tmp105.h
include/hw/sensor/tmp105_regs.h
include/hw/sysbus.h
include/hw/timer/cadence_ttc.h
include/hw/timer/stellaris-gptm.h
include/hw/timer/tmu012.h
include/hw/watchdog/sbsa_gwdt.h
include/hw/xtensa/mx_pic.h
include/libdecnumber/dconfig.h
include/libdecnumber/decContext.h
include/libdecnumber/decDPD.h
include/libdecnumber/decNumber.h
include/libdecnumber/decNumberLocal.h
include/libdecnumber/dpd/decimal128.h
include/libdecnumber/dpd/decimal128Local.h
include/libdecnumber/dpd/decimal32.h
include/libdecnumber/dpd/decimal64.h
include/monitor/hmp.h
include/monitor/monitor.h
include/monitor/qmp-helpers.h
include/qapi/qmp/dispatch.h
include/qemu-io.h
include/qemu-main.h
include/qemu/async-teardown.h
include/qemu/atomic.h
include/qemu/atomic128.h
include/qemu/base64.h
include/qemu/bcd.h
include/qemu/bitmap.h
include/qemu/bitops.h
include/qemu/bswap.h
include/qemu/cacheflush.h
include/qemu/cacheinfo.h
include/qemu/clang-tsa.h
include/qemu/compiler.h
include/qemu/config-file.h
include/qemu/cpu-float.h
include/qemu/cpuid.h
include/qemu/crc-ccitt.h
include/qemu/crc32c.h
include/qemu/ctype.h
include/qemu/cutils.h
include/qemu/datadir.h
include/qemu/drm.h
include/qemu/envlist.h
include/qemu/event_notifier.h
include/qemu/fifo32.h
include/qemu/fifo8.h
include/qemu/futex.h
include/qemu/guest-random.h
include/qemu/help-texts.h
include/qemu/help_option.h
include/qemu/host-utils.h
include/qemu/hw-version.h
include/qemu/id.h
include/qemu/int128.h
include/qemu/interval-tree.h
include/qemu/iov.h
include/qemu/jhash.h
include/qemu/keyval.h
include/qemu/lockable.h
include/qemu/log-for-trace.h
include/qemu/log.h
include/qemu/madvise.h
include/qemu/memalign.h
include/qemu/memfd.h
include/qemu/mmap-alloc.h
include/qemu/module.h
include/qemu/mprotect.h
include/qemu/notify.h
include/qemu/nvdimm-utils.h
include/qemu/option_int.h
include/qemu/osdep.h
include/qemu/path.h
include/qemu/plugin-event.h
include/qemu/plugin-memory.h
include/qemu/plugin.h
include/qemu/pmem.h
include/qemu/processor.h
include/qemu/progress_meter.h
include/qemu/qdist.h
include/qemu/qemu-plugin.h
include/qemu/qemu-progress.h
include/qemu/qht.h
include/qemu/qsp.h
include/qemu/qtree.h
include/qemu/queue.h
include/qemu/range.h
include/qemu/ratelimit.h
include/qemu/readline.h
include/qemu/selfmap.h
include/qemu/seqlock.h
include/qemu/stats64.h
include/qemu/sys_membarrier.h
include/qemu/systemd.h
include/qemu/thread-context.h
include/qemu/thread.h
include/qemu/timed-average.h
include/qemu/timer.h
include/qemu/tsan.h
include/qemu/typedefs.h
include/qemu/unicode.h
include/qemu/units.h
include/qemu/uri.h
include/qemu/vfio-helpers.h
include/qemu/xattr.h
include/qemu/xxhash.h
include/standard-headers/asm-m68k/bootinfo-virt.h
include/standard-headers/asm-s390/virtio-ccw.h
include/standard-headers/asm-x86/bootparam.h
include/standard-headers/asm-x86/kvm_para.h
include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
include/standard-headers/drm/drm_fourcc.h
include/standard-headers/linux/const.h
include/standard-headers/linux/ethtool.h
include/standard-headers/linux/fuse.h
include/standard-headers/linux/if_ether.h
include/standard-headers/linux/input-event-codes.h
include/standard-headers/linux/input.h
include/standard-headers/linux/kernel.h
include/standard-headers/linux/pci_regs.h
include/standard-headers/linux/pvpanic.h
include/standard-headers/linux/sysinfo.h
include/standard-headers/linux/types.h
include/standard-headers/linux/udmabuf.h
include/standard-headers/linux/vhost_types.h
include/standard-headers/linux/virtio_9p.h
include/standard-headers/linux/virtio_balloon.h
include/standard-headers/linux/virtio_blk.h
include/standard-headers/linux/virtio_bt.h
include/standard-headers/linux/virtio_config.h
include/standard-headers/linux/virtio_console.h
include/standard-headers/linux/virtio_crypto.h
include/standard-headers/linux/virtio_fs.h
include/standard-headers/linux/virtio_gpio.h
include/standard-headers/linux/virtio_gpu.h
include/standard-headers/linux/virtio_i2c.h
include/standard-headers/linux/virtio_ids.h
include/standard-headers/linux/virtio_input.h
include/standard-headers/linux/virtio_iommu.h
include/standard-headers/linux/virtio_mem.h
include/standard-headers/linux/virtio_mmio.h
include/standard-headers/linux/virtio_net.h
include/standard-headers/linux/virtio_pci.h
include/standard-headers/linux/virtio_pcidev.h
include/standard-headers/linux/virtio_pmem.h
include/standard-headers/linux/virtio_ring.h
include/standard-headers/linux/virtio_rng.h
include/standard-headers/linux/virtio_scmi.h
include/standard-headers/linux/virtio_scsi.h
include/standard-headers/linux/virtio_snd.h
include/standard-headers/linux/virtio_types.h
include/standard-headers/linux/virtio_vsock.h
include/standard-headers/rdma/vmw_pvrdma-abi.h
include/sysemu/arch_init.h
include/sysemu/blockdev.h
include/sysemu/cpu-throttle.h
include/sysemu/cpu-timers.h
include/sysemu/dma.h
include/sysemu/event-loop-base.h
include/sysemu/hw_accel.h
include/sysemu/iothread.h
include/sysemu/qtest.h
include/sysemu/reset.h
include/sysemu/rtc.h
include/sysemu/stats.h
include/sysemu/sysemu.h
include/sysemu/watchdog.h
iothread.c
libdecnumber/decContext.c
libdecnumber/decNumber.c
libdecnumber/dpd/decimal128.c
libdecnumber/dpd/decimal32.c
libdecnumber/dpd/decimal64.c
libdecnumber/meson.build
memory_ldst.c.inc
module-common.c
monitor/fds.c
monitor/meson.build
monitor/trace-events
monitor/trace.h
pc-bios/QEMU,cgthree.bin
pc-bios/QEMU,tcx.bin
pc-bios/README
pc-bios/bamboo.dtb
pc-bios/bamboo.dts
pc-bios/bios-256k.bin
pc-bios/bios.bin
pc-bios/descriptors/meson.build
pc-bios/efi-e1000.rom
pc-bios/efi-e1000e.rom
pc-bios/efi-eepro100.rom
pc-bios/efi-ne2k_pci.rom
pc-bios/efi-pcnet.rom
pc-bios/efi-rtl8139.rom
pc-bios/efi-virtio.rom
pc-bios/efi-vmxnet3.rom
pc-bios/keymaps/ar
pc-bios/keymaps/bepo
pc-bios/keymaps/cz
pc-bios/keymaps/da
pc-bios/keymaps/de
pc-bios/keymaps/de-ch
pc-bios/keymaps/en-gb
pc-bios/keymaps/en-us
pc-bios/keymaps/es
pc-bios/keymaps/et
pc-bios/keymaps/fi
pc-bios/keymaps/fo
pc-bios/keymaps/fr
pc-bios/keymaps/fr-be
pc-bios/keymaps/fr-ca
pc-bios/keymaps/fr-ch
pc-bios/keymaps/hr
pc-bios/keymaps/hu
pc-bios/keymaps/is
pc-bios/keymaps/it
pc-bios/keymaps/ja
pc-bios/keymaps/lt
pc-bios/keymaps/lv
pc-bios/keymaps/meson.build
pc-bios/keymaps/mk
pc-bios/keymaps/nl
pc-bios/keymaps/no
pc-bios/keymaps/pl
pc-bios/keymaps/pt
pc-bios/keymaps/pt-br
pc-bios/keymaps/ru
pc-bios/keymaps/sl
pc-bios/keymaps/sv
pc-bios/keymaps/th
pc-bios/keymaps/tr
pc-bios/kvmvapic.bin
pc-bios/linuxboot.bin
pc-bios/linuxboot_dma.bin
pc-bios/meson.build
pc-bios/multiboot.bin
pc-bios/multiboot_dma.bin
pc-bios/openbios-ppc
pc-bios/optionrom/Makefile
pc-bios/optionrom/flat.lds
pc-bios/optionrom/linuxboot.S
pc-bios/optionrom/linuxboot_dma.c
pc-bios/optionrom/multiboot.S
pc-bios/optionrom/multiboot_dma.S
pc-bios/optionrom/optionrom.h
pc-bios/optionrom/optrom.h
pc-bios/optionrom/optrom_fw_cfg.h
pc-bios/optionrom/pvh.S
pc-bios/optionrom/pvh_main.c
pc-bios/palcode-clipper
pc-bios/petalogix-ml605.dtb
pc-bios/petalogix-ml605.dts
pc-bios/petalogix-s3adsp1800.dtb
pc-bios/petalogix-s3adsp1800.dts
pc-bios/pvh.bin
pc-bios/pxe-e1000.rom
pc-bios/pxe-eepro100.rom
pc-bios/pxe-ne2k_pci.rom
pc-bios/pxe-pcnet.rom
pc-bios/pxe-rtl8139.rom
pc-bios/pxe-virtio.rom
pc-bios/qboot.rom
pc-bios/qemu-nsis.bmp
pc-bios/qemu-nsis.ico
pc-bios/qemu.rsrc
pc-bios/qemu_logo.svg
pc-bios/s390-netboot.img
pc-bios/u-boot-sam460-20100605.bin
pc-bios/vgabios-ati.bin
pc-bios/vgabios-bochs-display.bin
pc-bios/vgabios-cirrus.bin
pc-bios/vgabios-qxl.bin
pc-bios/vgabios-ramfb.bin
pc-bios/vgabios-stdvga.bin
pc-bios/vgabios-virtio.bin
pc-bios/vgabios-vmware.bin
pc-bios/vgabios.bin
po/LINGUAS
po/POTFILES
po/bg.po
po/de_DE.po
po/fr_FR.po
po/hu.po
po/it.po
po/meson.build
po/sv.po
po/tr.po
po/uk.po
po/zh_CN.po
pythondeps.toml
qemu-keymap.c
qemu-options.hx
roms/Makefile
roms/QemuMacDrivers
roms/SLOF
roms/config.seabios-128k
roms/config.seabios-256k
roms/config.seabios-microvm
roms/config.vga-ati
roms/config.vga-bochs-display
roms/config.vga-cirrus
roms/config.vga-isavga
roms/config.vga-qxl
roms/config.vga-ramfb
roms/config.vga-stdvga
roms/config.vga-virtio
roms/config.vga-vmware
roms/configure-seabios.sh
roms/ipxe
roms/openbios
roms/opensbi
roms/qboot
roms/qemu-palcode
roms/seabios
roms/seabios-hppa
roms/skiboot
roms/u-boot
scripts/analyze-inclusions
scripts/checkpatch.pl
scripts/clean-header-guards.pl
scripts/clean-includes
scripts/cleanup-trace-events.pl
scripts/cocci-macro-file.h
scripts/coccinelle/cpu-reset.cocci
scripts/coccinelle/cpu_restore_state.cocci
scripts/coccinelle/exec_rw_const.cocci
scripts/coccinelle/inplace-byteswaps.cocci
scripts/coccinelle/overflow_muldiv64.cocci
scripts/coccinelle/remove_muldiv64.cocci
scripts/coccinelle/return_directly.cocci
scripts/coccinelle/round.cocci
scripts/coccinelle/simplify_muldiv64.cocci
scripts/coccinelle/swap_muldiv64.cocci
scripts/coccinelle/tcg_gen_extract.cocci
scripts/coccinelle/timer-del-timer-free.cocci
scripts/coccinelle/typecast.cocci
scripts/coccinelle/use-g_new-etc.cocci
scripts/device-crash-test
scripts/disas-objdump.pl
scripts/extract-vsssdk-headers
scripts/fix-multiline-comments.sh
scripts/get_maintainer.pl
scripts/git.orderfile
scripts/hxtool
scripts/kernel-doc
scripts/make-config-poison.sh
scripts/make-release
scripts/meson.build
scripts/modules/module_block.py
scripts/qemu-version.sh
scripts/qemugdb/__init__.py
scripts/qemugdb/coroutine.py
scripts/qemugdb/mtree.py
scripts/qemugdb/tcg.py
scripts/qemugdb/timers.py
scripts/refresh-pxe-roms.sh
softmmu/arch_init.c
softmmu/async-teardown.c
softmmu/datadir.c
softmmu/globals.c
softmmu/meson.build
softmmu/rtc.c
softmmu/timers-state.h
softmmu/trace-events
softmmu/trace.h
stats/meson.build
stats/stats-hmp-cmds.c
stats/stats-qmp-cmds.c
subprojects/.gitignore
subprojects/berkeley-softfloat-3.wrap
subprojects/berkeley-testfloat-3.wrap
subprojects/dtc.wrap
subprojects/keycodemapdb.wrap
subprojects/libblkio.wrap
subprojects/packagefiles/berkeley-softfloat-3/meson.build
subprojects/packagefiles/berkeley-softfloat-3/meson_options.txt
subprojects/packagefiles/berkeley-testfloat-3/meson.build
subprojects/packagefiles/berkeley-testfloat-3/meson_options.txt
subprojects/slirp.wrap
target/i386/arch_dump.c
target/i386/arch_memory_mapping.c
target/i386/cpu-dump.c
target/i386/cpu-internal.h
target/i386/cpu-param.h
target/i386/cpu-qom.h
target/i386/cpu-sysemu.c
target/i386/cpu.c
target/i386/cpu.h
target/i386/gdbstub.c
target/i386/helper.c
target/i386/helper.h
target/i386/host-cpu.c
target/i386/host-cpu.h
target/i386/machine.c
target/i386/meson.build
target/i386/monitor.c
target/i386/ops_sse.h
target/i386/svm.h
target/i386/trace-events
target/i386/trace.h
target/i386/xsave_helper.c
target/meson.build
tests/bench/atomic64-bench.c
tests/bench/atomic_add-bench.c
tests/bench/meson.build
tests/bench/qht-bench.c
tests/bench/qtree-bench.c
tests/bench/test_akcipher_keys.inc
tests/data/test-qga-config
tests/data/test-qga-os-release
tests/dbus-vmstate-daemon.sh
tests/decode/err_argset1.decode
tests/decode/err_argset2.decode
tests/decode/err_field1.decode
tests/decode/err_field10.decode
tests/decode/err_field2.decode
tests/decode/err_field3.decode
tests/decode/err_field4.decode
tests/decode/err_field5.decode
tests/decode/err_field6.decode
tests/decode/err_field7.decode
tests/decode/err_field8.decode
tests/decode/err_field9.decode
tests/decode/err_init1.decode
tests/decode/err_init2.decode
tests/decode/err_init3.decode
tests/decode/err_init4.decode
tests/decode/err_overlap1.decode
tests/decode/err_overlap2.decode
tests/decode/err_overlap3.decode
tests/decode/err_overlap4.decode
tests/decode/err_overlap5.decode
tests/decode/err_overlap6.decode
tests/decode/err_overlap7.decode
tests/decode/err_overlap8.decode
tests/decode/err_overlap9.decode
tests/decode/err_pattern_group_empty.decode
tests/decode/err_pattern_group_ident1.decode
tests/decode/err_pattern_group_ident2.decode
tests/decode/err_pattern_group_nest1.decode
tests/decode/err_pattern_group_nest2.decode
tests/decode/err_pattern_group_nest3.decode
tests/decode/err_pattern_group_overlap1.decode
tests/decode/err_width1.decode
tests/decode/err_width2.decode
tests/decode/err_width3.decode
tests/decode/err_width4.decode
tests/decode/meson.build
tests/decode/succ_argset_type1.decode
tests/decode/succ_function.decode
tests/decode/succ_ident1.decode
tests/decode/succ_named_field.decode
tests/decode/succ_pattern_group_nest1.decode
tests/decode/succ_pattern_group_nest2.decode
tests/decode/succ_pattern_group_nest3.decode
tests/decode/succ_pattern_group_nest4.decode
tests/guest-debug/run-test.py
tests/include/meson.build
tests/keys/README
tests/keys/id_rsa
tests/keys/id_rsa.pub
tests/keys/vagrant
tests/keys/vagrant.pub
tests/meson.build
tests/multiboot/Makefile
tests/multiboot/aout_kludge.S
tests/multiboot/aout_kludge.out
tests/multiboot/libc.c
tests/multiboot/libc.h
tests/multiboot/link.ld
tests/multiboot/mmap.c
tests/multiboot/mmap.out
tests/multiboot/module.txt
tests/multiboot/modules.c
tests/multiboot/modules.out
tests/multiboot/multiboot.h
tests/multiboot/run_test.sh
tests/multiboot/start.S
tests/perf/block/qcow2/convert-blockstatus
tests/tcg/README
tests/tcg/hppa/Makefile.target
tests/tcg/hppa/stby.c
tests/tcg/m68k/Makefile.target
tests/tcg/m68k/denormal.c
tests/tcg/m68k/trap.c
tests/tcg/minilib/Makefile.target
tests/tcg/minilib/minilib.h
tests/tcg/minilib/printf.c
tests/tcg/ppc/Makefile.target
tests/tcg/ppc64/Makefile.target
tests/tcg/ppc64/bcdsub.c
tests/tcg/ppc64/byte_reverse.c
tests/tcg/ppc64/mffsce.c
tests/tcg/ppc64/mtfsf.c
tests/tcg/ppc64/non_signalling_xscv.c
tests/tcg/ppc64/signal_save_restore_xer.c
tests/tcg/ppc64/test-aes.c
tests/tcg/ppc64/vector.c
tests/tcg/ppc64/xxspltw.c
tests/tcg/ppc64le/Makefile.target
tests/tcg/ppc64le/float_convs.ref
tests/tcg/ppc64le/float_madds.ref
tests/tcg/riscv64/Makefile.softmmu-target
tests/tcg/riscv64/Makefile.target
tests/tcg/riscv64/issue1060.S
tests/tcg/riscv64/noexec.c
tests/tcg/riscv64/semicall.h
tests/tcg/riscv64/semihost.ld
tests/tcg/riscv64/test-aes.c
tests/tcg/riscv64/test-div.c
tests/tcg/riscv64/test-fcvtmod.c
tests/tcg/riscv64/test-noc.S
tests/tcg/sh4/Makefile.target
tests/tcg/sparc64/Makefile.target
tests/test-qht-par.c
tests/tsan/blacklist.tsan
tests/tsan/suppressions.tsan
tests/unit/io-channel-helpers.c
tests/unit/io-channel-helpers.h
tests/unit/iothread.c
tests/unit/iothread.h
tests/unit/meson.build
tests/unit/ptimer-test-stubs.c
tests/unit/ptimer-test.c
tests/unit/ptimer-test.h
tests/unit/socket-helpers.c
tests/unit/socket-helpers.h
tests/unit/test-aio-multithread.c
tests/unit/test-aio.c
tests/unit/test-base64.c
tests/unit/test-bdrv-drain.c
tests/unit/test-bdrv-graph-mod.c
tests/unit/test-bitcnt.c
tests/unit/test-bitmap.c
tests/unit/test-bitops.c
tests/unit/test-block-backend.c
tests/unit/test-block-iothread.c
tests/unit/test-blockjob-txn.c
tests/unit/test-blockjob.c
tests/unit/test-bufferiszero.c
tests/unit/test-char.c
tests/unit/test-cutils.c
tests/unit/test-div128.c
tests/unit/test-error-report.c
tests/unit/test-image-locking.c
tests/unit/test-int128.c
tests/unit/test-interval-tree.c
tests/unit/test-iov.c
tests/unit/test-logging.c
tests/unit/test-mul64.c
tests/unit/test-nested-aio-poll.c
tests/unit/test-qdist.c
tests/unit/test-qgraph.c
tests/unit/test-qht.c
tests/unit/test-qtree.c
tests/unit/test-shift128.c
tests/unit/test-thread-pool.c
tests/unit/test-timed-average.c
tests/unit/test-util-sockets.c
tests/unit/test-vmstate.c
tests/unit/test-write-threshold.c
tests/unit/test-xbzrle.c
tests/unit/test-xs-node.c
tests/vhost-user-bridge.c
tools/meson.build
util/aiocb.c
util/atomic64.c
util/base64.c
util/bitmap.c
util/bitops.c
util/block-helpers.c
util/block-helpers.h
util/bufferiszero.c
util/compatfd.c
util/crc-ccitt.c
util/crc32c.c
util/cutils.c
util/envlist.c
util/error-report.c
util/fifo8.c
util/getauxval.c
util/guest-random.c
util/hexdump.c
util/host-utils.c
util/id.c
util/int128.c
util/interval-tree.c
util/iov.c
util/lockcnt.c
util/log.c
util/memalign.c
util/memfd.c
util/meson.build
util/mmap-alloc.c
util/module.c
util/notify.c
util/nvdimm-utils.c
util/osdep.c
util/path.c
util/qdist.c
util/qemu-co-timeout.c
util/qemu-config.c
util/qemu-thread-common.h
util/qemu-timer-common.c
util/qht.c
util/qsp.c
util/qtree.c
util/range.c
util/readline.c
util/selfmap.c
util/stats64.c
util/sys_membarrier.c
util/systemd.c
util/thread-context.c
util/thread-pool.c
util/timed-average.c
util/trace-events
util/trace.h
util/unicode.c
util/uri.c
util/vfio-helpers.c
version.rc


