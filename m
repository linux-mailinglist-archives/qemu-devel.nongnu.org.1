Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF767BB634
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:17:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimq-00080O-6F; Fri, 06 Oct 2023 07:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimo-000807-E2
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimf-0000Dh-Px
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rofMbpBNsUnRi9JKYr/EXNS2JHDuF/KSROx/3djKF/E=;
 b=MeXFBFYIBujOHFjVEcB3nOKsij7qqFetZyIeIcR78vzHofJ5eifJqtsBzzvojOIyvMRvYu
 +c7ZenruHERzbExTqdDviVxnTj+OC8WtCgMjjtTsHGGJZIIO2P/+jJr9YkIl1eva4WKCzF
 za3VafIvCHClmW4X5YElkNyrh0oasqw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-5P7Q7DqHPE6d67Hotbl_9g-1; Fri, 06 Oct 2023 07:14:15 -0400
X-MC-Unique: 5P7Q7DqHPE6d67Hotbl_9g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b98bbf130cso169448266b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590854; x=1697195654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rofMbpBNsUnRi9JKYr/EXNS2JHDuF/KSROx/3djKF/E=;
 b=t7hcBExLFKdKyJUDNVBPWq3B2ejEFJa8X0AoVzxuTSdbr2/u3RMsOHiWUaxZ9knhgg
 TwN1y13/FC34ZVwq4at/9Z2Z9v6nyODOoKnwaGPiGmndYLqaTH7z6P+Y67mDvde/32WY
 Fn3byAZJaEOqAg3quOuwourwCtgnncsBsvZS0U83nKytzAq9vtvlA4itSQnAGZpYp6z7
 o3qmuinmIRVrA9VDRskEizi01P5DS9wD8EBvzi28QWIwvGZjPkpHQAAcFsj03B2XT+o/
 PqQ46qZgjjFSHzUZr/q8UUjf510z2ZldnIRC1VWy6rR5w+gIw8OLFuxXoc4mQWYUb8j9
 p21A==
X-Gm-Message-State: AOJu0Yziii1u+S9/YMKafqE404JLhNzhnrQgk41T5pBVo+UseCvT19+s
 nu7cYW4OMvv1+79X9A+kbskJRkL4LNbNV2IBEMcCkzaJAN+jhrvAcv+Gbcg7dhpjWhVmenN0B3X
 BkMg9xZne9StYNRFXIlQA3nq0ReUlk6twpLlU2ZKHAApuQVTwsErdnaIdCVel2I8/nT48jH9ciO
 U=
X-Received: by 2002:a17:906:24d:b0:9a5:ca42:f3a9 with SMTP id
 13-20020a170906024d00b009a5ca42f3a9mr7720798ejl.2.1696590854106; 
 Fri, 06 Oct 2023 04:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYLcCKbgVtTFKn9icgSOywVhBOrDCXqzXGXBoKRudcSRKyaXveClOr4uSIhcBWO98EAIXGfg==
X-Received: by 2002:a17:906:24d:b0:9a5:ca42:f3a9 with SMTP id
 13-20020a170906024d00b009a5ca42f3a9mr7720767ejl.2.1696590853609; 
 Fri, 06 Oct 2023 04:14:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a17090648d500b00997d76981e0sm2651885ejt.208.2023.10.06.04.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] Audio, source reorg, HVF changes for 2023-10-06
Date: Fri,  6 Oct 2023 13:13:46 +0200
Message-ID: <20231006111412.13130-1-pbonzini@redhat.com>
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

The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-10-03 07:43:44 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0451b622193aa405c4d9f9ef251aa9ce580adc7f:

  audio, qtest: get rid of QEMU_AUDIO_DRV (2023-10-05 18:43:02 +0200)

----------------------------------------------------------------
* util/log: re-allow switching away from stderr log file
* finish audio configuration rework
* cleanup HVF stubs
* remove more mentions of softmmu

----------------------------------------------------------------
Fiona Ebner (1):
      util/log: re-allow switching away from stderr log file

Paolo Bonzini (9):
      configure: change $softmmu to $system
      cutils: squelch compiler warnings with custom paths
      audio: error hints need a trailing \n
      audio: disable default backends if -audio/-audiodev is used
      audio: extract audio_define_default
      audio: extend -audio to allow creating a default backend
      audio: do not use first -audiodev as default audio device
      audio: reintroduce default audio backend for VNC
      audio, qtest: get rid of QEMU_AUDIO_DRV

Philippe Mathieu-Daudé (16):
      target/i386/hvf: Remove unused includes in 'hvf-i386.h'
      sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86 targets
      target/i386: Check for USER_ONLY definition instead of SOFTMMU one
      softmmu/trace-events: Fix a typo
      travis-ci: Correct invalid mentions of 'softmmu' by 'system'
      cpu: Correct invalid mentions of 'softmmu' by 'system-mode'
      fuzz: Correct invalid mentions of 'softmmu' by 'system'
      tcg: Correct invalid mentions of 'softmmu' by 'system-mode'
      accel: Rename accel_softmmu* -> accel_system*
      gdbstub: Rename 'softmmu' -> 'system'
      semihosting: Rename softmmu_FOO_user() -> uaccess_FOO_user()
      target/i386: Rename i386_softmmu_kvm_ss -> i386_kvm_ss
      hw/virtio/meson: Rename softmmu_virtio_ss -> system_virtio_ss
      meson: Rename softmmu_mods -> system_mods
      meson: Rename target_softmmu_arch -> target_system_arch
      system: Rename softmmu/ directory as system/

 .travis.yml                                        |  4 +-
 MAINTAINERS                                        | 44 +++++------
 accel/accel-common.c                               |  2 +-
 accel/{accel-softmmu.c => accel-system.c}          |  6 +-
 accel/{accel-softmmu.h => accel-system.h}          |  6 +-
 accel/meson.build                                  |  2 +-
 accel/stubs/meson.build                            | 10 +--
 accel/tcg/user-exec.c                              |  2 +-
 audio/audio.c                                      | 85 +++++++++-------------
 audio/audio.h                                      |  3 +
 configure                                          | 10 +--
 cpu.c                                              |  2 +-
 docs/about/deprecated.rst                          |  6 --
 docs/about/removed-features.rst                    | 20 ++++-
 docs/devel/build-system.rst                        |  4 +-
 docs/devel/qtest.rst                               |  2 +-
 docs/devel/testing.rst                             |  2 +-
 gdbstub/internals.h                                |  4 +-
 gdbstub/meson.build                                | 10 +--
 gdbstub/{softmmu.c => system.c}                    |  2 +-
 gdbstub/trace-events                               |  2 +-
 hw/core/cpu-common.c                               |  4 +-
 hw/virtio/meson.build                              | 22 +++---
 include/qemu/atomic128.h                           |  4 +-
 .../semihosting/{softmmu-uaccess.h => uaccess.h}   | 24 +++---
 include/sysemu/hvf.h                               |  3 -
 include/sysemu/runstate-action.h                   |  2 +-
 include/tcg/tcg-op-common.h                        |  2 +-
 meson.build                                        | 22 +++---
 qemu-options.hx                                    | 29 ++++++--
 scripts/checkpatch.pl                              |  2 +-
 scripts/coverity-scan/COMPONENTS.md                |  2 +-
 scripts/get_maintainer.pl                          |  2 +-
 scripts/oss-fuzz/build.sh                          |  6 +-
 semihosting/arm-compat-semi.c                      |  4 +-
 semihosting/config.c                               |  2 +-
 semihosting/guestfd.c                              |  2 +-
 semihosting/syscalls.c                             |  2 +-
 semihosting/uaccess.c                              | 14 ++--
 softmmu/trace.h                                    |  1 -
 stubs/semihost.c                                   |  4 +-
 {softmmu => system}/arch_init.c                    |  0
 {softmmu => system}/async-teardown.c               |  0
 {softmmu => system}/balloon.c                      |  0
 {softmmu => system}/bootdevice.c                   |  0
 {softmmu => system}/cpu-throttle.c                 |  0
 {softmmu => system}/cpu-timers.c                   |  0
 {softmmu => system}/cpus.c                         |  0
 {softmmu => system}/datadir.c                      |  0
 {softmmu => system}/device_tree.c                  |  0
 {softmmu => system}/dirtylimit.c                   |  0
 {softmmu => system}/dma-helpers.c                  |  0
 {softmmu => system}/globals.c                      |  0
 {softmmu => system}/icount.c                       |  0
 {softmmu => system}/ioport.c                       |  0
 {softmmu => system}/main.c                         |  0
 {softmmu => system}/memory.c                       |  2 +-
 {softmmu => system}/memory_mapping.c               |  0
 {softmmu => system}/meson.build                    |  0
 {softmmu => system}/physmem.c                      |  6 +-
 {softmmu => system}/qdev-monitor.c                 |  0
 {softmmu => system}/qemu-seccomp.c                 |  0
 {softmmu => system}/qtest.c                        |  0
 {softmmu => system}/rtc.c                          |  0
 {softmmu => system}/runstate-action.c              |  0
 {softmmu => system}/runstate-hmp-cmds.c            |  0
 {softmmu => system}/runstate.c                     |  0
 {softmmu => system}/timers-state.h                 |  0
 {softmmu => system}/tpm-hmp-cmds.c                 |  0
 {softmmu => system}/tpm.c                          |  0
 {softmmu => system}/trace-events                   |  2 +-
 system/trace.h                                     |  1 +
 {softmmu => system}/vl.c                           | 34 ++++++---
 {softmmu => system}/watchpoint.c                   |  0
 target/alpha/meson.build                           |  2 +-
 target/arm/meson.build                             |  2 +-
 target/avr/meson.build                             |  2 +-
 target/cris/meson.build                            |  2 +-
 target/hppa/meson.build                            |  2 +-
 target/i386/cpu.c                                  |  3 +-
 target/i386/hvf/hvf-cpu.c                          |  1 +
 target/i386/hvf/hvf-i386.h                         |  6 +-
 target/i386/hvf/x86_cpuid.c                        |  1 +
 target/i386/kvm/meson.build                        | 10 +--
 target/i386/meson.build                            |  2 +-
 target/i386/tcg/misc_helper.c                      |  2 +-
 target/i386/tcg/translate.c                        |  6 +-
 target/loongarch/meson.build                       |  2 +-
 target/m68k/m68k-semi.c                            |  2 +-
 target/m68k/meson.build                            |  2 +-
 target/microblaze/meson.build                      |  2 +-
 target/mips/meson.build                            |  2 +-
 target/mips/tcg/sysemu/mips-semi.c                 |  2 +-
 target/nios2/meson.build                           |  2 +-
 target/nios2/nios2-semi.c                          |  2 +-
 target/openrisc/meson.build                        |  2 +-
 target/ppc/meson.build                             |  2 +-
 target/riscv/meson.build                           |  2 +-
 target/riscv/vector_helper.c                       |  2 +-
 target/rx/meson.build                              |  2 +-
 target/s390x/meson.build                           |  2 +-
 target/sh4/meson.build                             |  2 +-
 target/sparc/meson.build                           |  2 +-
 target/tricore/meson.build                         |  2 +-
 target/xtensa/meson.build                          |  2 +-
 tcg/aarch64/tcg-target.c.inc                       |  4 +-
 tcg/arm/tcg-target.c.inc                           |  2 +-
 tcg/i386/tcg-target.c.inc                          |  2 +-
 tcg/loongarch64/tcg-target.c.inc                   |  4 +-
 tcg/meson.build                                    |  6 +-
 tcg/mips/tcg-target.c.inc                          |  4 +-
 tcg/ppc/tcg-target.c.inc                           |  4 +-
 tcg/region.c                                       |  4 +-
 tcg/riscv/tcg-target.c.inc                         |  4 +-
 tcg/s390x/tcg-target.c.inc                         |  4 +-
 tcg/sparc64/tcg-target.c.inc                       |  4 +-
 tcg/tcg.c                                          | 11 +--
 tests/qtest/fuzz/fuzz.c                            |  2 +-
 tests/qtest/fuzz/fuzz.h                            |  4 +-
 tests/qtest/libqtest.c                             |  4 +-
 tests/tcg/Makefile.target                          |  2 +-
 tests/tcg/multiarch/gdbstub/interrupt.py           |  2 +-
 tests/tcg/multiarch/gdbstub/memory.py              |  2 +-
 tests/tcg/multiarch/system/memory.c                |  4 +-
 tests/tcg/s390x/pgm-specification-softmmu.S        |  2 +-
 tests/tcg/s390x/pgm-specification.mak              |  2 +-
 tests/tcg/s390x/softmmu.ld                         |  2 +-
 tests/tcg/xtensa/Makefile.softmmu-target           |  2 +-
 tests/tcg/xtensaeb/Makefile.softmmu-target         |  2 +-
 tests/unit/meson.build                             |  2 +-
 ui/vnc.c                                           |  2 +
 util/cutils.c                                      |  9 +++
 util/log.c                                         |  2 +
 133 files changed, 315 insertions(+), 286 deletions(-)
 rename accel/{accel-softmmu.c => accel-system.c} (96%)
 rename accel/{accel-softmmu.h => accel-system.h} (77%)
 rename gdbstub/{softmmu.c => system.c} (99%)
 rename include/semihosting/{softmmu-uaccess.h => uaccess.h} (75%)
 delete mode 100644 softmmu/trace.h
 rename {softmmu => system}/arch_init.c (100%)
 rename {softmmu => system}/async-teardown.c (100%)
 rename {softmmu => system}/balloon.c (100%)
 rename {softmmu => system}/bootdevice.c (100%)
 rename {softmmu => system}/cpu-throttle.c (100%)
 rename {softmmu => system}/cpu-timers.c (100%)
 rename {softmmu => system}/cpus.c (100%)
 rename {softmmu => system}/datadir.c (100%)
 rename {softmmu => system}/device_tree.c (100%)
 rename {softmmu => system}/dirtylimit.c (100%)
 rename {softmmu => system}/dma-helpers.c (100%)
 rename {softmmu => system}/globals.c (100%)
 rename {softmmu => system}/icount.c (100%)
 rename {softmmu => system}/ioport.c (100%)
 rename {softmmu => system}/main.c (100%)
 rename {softmmu => system}/memory.c (99%)
 rename {softmmu => system}/memory_mapping.c (100%)
 rename {softmmu => system}/meson.build (100%)
 rename {softmmu => system}/physmem.c (99%)
 rename {softmmu => system}/qdev-monitor.c (100%)
 rename {softmmu => system}/qemu-seccomp.c (100%)
 rename {softmmu => system}/qtest.c (100%)
 rename {softmmu => system}/rtc.c (100%)
 rename {softmmu => system}/runstate-action.c (100%)
 rename {softmmu => system}/runstate-hmp-cmds.c (100%)
 rename {softmmu => system}/runstate.c (100%)
 rename {softmmu => system}/timers-state.h (100%)
 rename {softmmu => system}/tpm-hmp-cmds.c (100%)
 rename {softmmu => system}/tpm.c (100%)
 rename {softmmu => system}/trace-events (99%)
 create mode 100644 system/trace.h
 rename {softmmu => system}/vl.c (99%)
 rename {softmmu => system}/watchpoint.c (100%)
-- 
2.41.0


