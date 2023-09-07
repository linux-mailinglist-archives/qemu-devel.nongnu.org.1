Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15E7972C7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:15:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEce-0002ed-TY; Thu, 07 Sep 2023 09:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcV-0002ar-GO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcP-0006mA-GS
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gnTkrcweSf8aEUeGtizsPv53Wz/ii6LVtbYKqFEpLnI=;
 b=Ld4mNtdCZI/4PWqLFToHt/IjFqOXnHF/HjvzfvGwGoxd3zmrztaWVuRK9gGM52HU16q9YW
 tmC+hCq73eT2D+KeqcEINDDrCaebbQN5CVAc4psBlapyw80nmzr4ZQ0hgreeiK03j+sZBu
 meeBRsvRMnOb1fgQx4AcI+piR0HBLT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-jkUJ_kEtPTyBUXuCJF6xpg-1; Thu, 07 Sep 2023 09:00:15 -0400
X-MC-Unique: jkUJ_kEtPTyBUXuCJF6xpg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401db0c9d3eso6886955e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091607; x=1694696407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnTkrcweSf8aEUeGtizsPv53Wz/ii6LVtbYKqFEpLnI=;
 b=Z6jFVHw2cAvelgkpAQrO1+pHZbBvfHIIVfvvjkay0oQNLoXDcXFLuXdc7/AXx+FZNJ
 OPGqmr28MZSSQ839jbnlgTmlauGELteoHLmk6raWaR425BHkaZyri8FI3SC/HCGl0QvZ
 pE2X1TDCzA2/NRZVe6HdHIvfMrKuIfwdehSQLwCmskMyMrpr+SJ6E6ok4mdfd+m0BrIl
 JidZmKJ4seyLwlmZkxthZfClFgyLgyt7Z4qLwcJ/HUwRn0bc4S/N/zrD4p1bT7z5KVWy
 6Ao2uOYFRFYDV5S5XhwPMF1dQv7ArV/PfZqLBHrXrud/56vlX2UFi1vMgTHklbsSoox/
 n7Ng==
X-Gm-Message-State: AOJu0YxcO82pB2rHQnAE6ouPHisaJgZBFhq9QHBgaKMpjSRz97ddPHSP
 qRb4LPMcECYZbf1Gzv0WRFesahW7Vq2AJiw9p3ilwQNs3fdsZ5RzRPEB3KWhpobSdTDyLLqQ0NT
 qNhukAbmSWWM94LZG/8hyMULG4olmMAINDXgw7n4kDEcsL+awht7SvjPpLSmlEQdMvypaAbvzgX
 M=
X-Received: by 2002:a7b:cd97:0:b0:3f8:2777:15e with SMTP id
 y23-20020a7bcd97000000b003f82777015emr5338538wmj.31.1694091607366; 
 Thu, 07 Sep 2023 06:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP52i9JqkxSdW0mtEDwJliSJ8I0oNl6QmgsoHf9bxKrmn1pErSof6C9RM1rEffmHdVEOHM3w==
X-Received: by 2002:a7b:cd97:0:b0:3f8:2777:15e with SMTP id
 y23-20020a7bcd97000000b003f82777015emr5338513wmj.31.1694091606871; 
 Thu, 07 Sep 2023 06:00:06 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a1c7c05000000b003fef5402d2dsm2481337wmc.8.2023.09.07.06.00.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/51] Build system, i386 changes for 2023-09-07
Date: Thu,  7 Sep 2023 14:59:09 +0200
Message-ID: <20230907130004.500601-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:

  Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 34e8182053c065e5e99017f798fb79259e26f583:

  docs/system/replay: do not show removed command line option (2023-09-07 13:32:37 +0200)

----------------------------------------------------------------
* only build util/async-teardown.c when system build is requested
* target/i386: fix BQL handling of the legacy FERR interrupts
* target/i386: fix memory operand size for CVTPS2PD
* target/i386: Add support for AMX-COMPLEX in CPUID enumeration
* compile plugins on Darwin
* configure and meson cleanups
* drop mkvenv support for Python 3.7 and Debian10
* add wrap file for libblkio
* tweak KVM stubs

----------------------------------------------------------------
Michael Tokarev (8):
      include/sysemu/os-posix.h: move *daemonize* declarations together
      os-posix.c: create and export os_set_runas()
      os-posix.c: create and export os_set_chroot()
      os-posix.c, softmmu/vl.c: move os_parse_cmd_args() into qemu_init()
      os-posix.c: move code around
      os-posix.c: remove unneeded #includes
      softmmu/vl.c: inline include/qemu/qemu-options.h into vl.c
      util/async-teardown.c: move to softmmu/, only build it when system build is requested

Paolo Bonzini (25):
      linux-user, bsd-user: disable on unsupported host architectures
      target/i386: raise FERR interrupt with iothread locked
      target/i386: generalize operand size "ph" for use in CVTPS2PD
      target/i386: fix memory operand size for CVTPS2PD
      contrib/plugins: remove -soname argument
      contrib/plugins: add Darwin support
      meson: do not unnecessarily use cmake for dependencies
      meson: update unsupported host/CPU messages
      configure: remove HOST_CC
      configure: create native file with contents of $host_cc
      meson: compile bundled device trees
      configure: remove boolean variables for targets
      configure: move --enable-debug-tcg to meson
      contrib/plugins: use an independent makefile
      configure: unify recursion into sub-Makefiles
      configure, meson: move --enable-plugins to meson
      configure, meson: remove CONFIG_SOLARIS from config-host.mak
      configure, meson: remove target OS symbols from config-host.mak
      meson: list leftover CONFIG_* symbols
      configure: remove dead code
      Python: Drop support for Python 3.7
      mkvenv: assume presence of importlib.metadata
      Revert "mkvenv: work around broken pip installations on Debian 10"
      subprojects: add wrap file for libblkio
      docs/system/replay: do not show removed command line option

Philippe Mathieu-Daudé (17):
      contrib/plugins/cache: Fix string format
      contrib/plugins/drcov: Fix string format
      contrib/plugins/howvec: Fix string format
      contrib/plugins/lockstep: Fix string format
      hw/i386/pc: Include missing 'sysemu/tcg.h' header
      hw/i386/pc: Include missing 'cpu.h' header
      hw/i386/fw_cfg: Include missing 'cpu.h' header
      target/i386/helper: Restrict KVM declarations to system emulation
      target/i386/cpu-sysemu: Inline kvm_apic_in_kernel()
      target/i386: Remove unused KVM stubs
      target/i386: Allow elision of kvm_enable_x2apic()
      target/i386: Allow elision of kvm_hv_vpindex_settable()
      target/i386: Restrict declarations specific to CONFIG_KVM
      sysemu/kvm: Restrict kvm_arch_get_supported_cpuid/msr() to x86 targets
      sysemu/kvm: Restrict kvm_get_apic_state() to x86 targets
      sysemu/kvm: Restrict kvm_has_pit_state2() to x86 targets
      sysemu/kvm: Restrict kvm_pc_setup_irq_routing() to x86 targets

Tao Su (1):
      target/i386: Add support for AMX-COMPLEX in CPUID enumeration

 Makefile                                  |  29 ++--
 accel/tcg/meson.build                     |   4 +-
 chardev/meson.build                       |   2 +-
 configure                                 | 176 +++++++------------
 contrib/plugins/Makefile                  |  22 ++-
 contrib/plugins/cache.c                   |  19 ++-
 contrib/plugins/drcov.c                   |   2 +-
 contrib/plugins/howvec.c                  |   6 +-
 contrib/plugins/lockstep.c                |  11 +-
 docs/devel/build-system.rst               |   8 +-
 docs/devel/kconfig.rst                    |   2 +-
 docs/system/replay.rst                    |   2 +-
 gdbstub/meson.build                       |   4 +-
 hw/i386/fw_cfg.c                          |   1 +
 hw/i386/intel_iommu.c                     |   2 +-
 hw/i386/kvm/i8254.c                       |   1 +
 hw/i386/kvm/ioapic.c                      |   1 +
 hw/i386/pc_piix.c                         |   1 +
 hw/i386/pc_q35.c                          |   2 +
 hw/i386/x86.c                             |  11 +-
 include/qemu/qemu-options.h               |  41 -----
 include/sysemu/kvm.h                      |  10 --
 include/sysemu/os-posix.h                 |  10 +-
 include/sysemu/os-win32.h                 |   1 -
 meson.build                               | 111 +++++++-----
 meson_options.txt                         |   4 +
 net/meson.build                           |  18 +-
 os-posix.c                                | 157 +++++------------
 pc-bios/Makefile                          |  19 ---
 pc-bios/meson.build                       |  25 ++-
 plugins/meson.build                       |  12 +-
 python/Makefile                           |   8 +-
 python/scripts/mkvenv.py                  | 272 +++++-------------------------
 python/setup.cfg                          |  16 +-
 python/tests/minreqs.txt                  |   2 +-
 qga/meson.build                           |   4 +-
 scripts/meson-buildoptions.sh             |   6 +
 scripts/qapi/mypy.ini                     |   2 +-
 {util => softmmu}/async-teardown.c        |   0
 softmmu/meson.build                       |   1 +
 softmmu/vl.c                              |  87 +++++++++-
 storage-daemon/meson.build                |   2 +-
 subprojects/libblkio.wrap                 |   6 +
 target/i386/cpu-sysemu.c                  |   4 +-
 target/i386/cpu.c                         |   2 +-
 target/i386/cpu.h                         |   2 +
 target/i386/helper.c                      |   2 +-
 target/i386/kvm/kvm-stub.c                |  51 ------
 target/i386/kvm/kvm.c                     |   4 +-
 target/i386/kvm/kvm_i386.h                |  36 ++--
 target/i386/kvm/meson.build               |   2 -
 target/i386/tcg/decode-new.c.inc          |  20 ++-
 target/i386/tcg/decode-new.h              |   2 +-
 target/i386/tcg/emit.c.inc                |  30 +++-
 target/i386/tcg/sysemu/fpu_helper.c       |   6 +
 target/i386/tcg/translate.c               |   8 +-
 tcg/meson.build                           |   2 +-
 tests/Makefile.include                    |   2 +-
 tests/meson.build                         |   8 +-
 tests/migration/meson.build               |   2 +-
 tests/qtest/meson.build                   |  14 +-
 tests/tcg/tricore/Makefile.softmmu-target |   2 +-
 tests/unit/meson.build                    |   6 +-
 util/meson.build                          |   1 -
 64 files changed, 551 insertions(+), 775 deletions(-)
 delete mode 100644 include/qemu/qemu-options.h
 delete mode 100644 pc-bios/Makefile
 rename {util => softmmu}/async-teardown.c (100%)
 create mode 100644 subprojects/libblkio.wrap
 delete mode 100644 target/i386/kvm/kvm-stub.c
-- 
2.41.0


