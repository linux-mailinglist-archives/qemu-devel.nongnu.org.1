Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4177BCC87
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpN3D-0003Ei-6D; Sun, 08 Oct 2023 02:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpN3B-0003Cm-E2
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qpN38-0004Gf-LK
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696745636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6TSjE9x4fxGFKinGc2F4/ho0wZ6Ztx3zrHjAWU1qHBM=;
 b=DrV4QqSNwS2x1ple1Sa/mPYFoUeBv603ZN7LmNuz00p5cP9gQ5YWgcfAmkSFrvyStYLOnE
 /vLoE7/jOU8SqA8Y8/qIlqmfCFKz4P1jgncr/5UGLThfEQyz/dl6zQSJ3pG7ms1KcFKoZ6
 UmyjpqzY0hFFZIMRaKFfnMnAYyuaQqk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-9xtJF31jMSGL1LeHSzPGlA-1; Sun, 08 Oct 2023 02:13:53 -0400
X-MC-Unique: 9xtJF31jMSGL1LeHSzPGlA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7740829f2beso427509085a.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 23:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696745632; x=1697350432;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TSjE9x4fxGFKinGc2F4/ho0wZ6Ztx3zrHjAWU1qHBM=;
 b=d0FLVkEz5x8t+ZSvUraoTnAbD8AowaZMCjpIdFnkhINbHkUDRnaFOJx1boOLYBQ+Gg
 vIl7SQ9ugqUAT8GO3sN04qmokbqG2vjcO00zL/0eB4W9lKdy1s/wiF8um3tYc0npfuZ8
 WKp9crJYj7O3b3SPxjPCPtPWdzsN2AJ8Mq39TcbrDoyJ9h5hPZppQp1Utqlg+pgSB97J
 3OrDDwgfKdhoWvQZJfrspwJowrYbKDZzGg/PWiJVUp2zAynnnbPohxWXKdmQVjkN1bL5
 IIMFAwBd8uqzsR0v4u5G/z4P4Y2pJnAtOwkGndXRuGXyzfwrVZ9HkrcrXltjI31xeYmu
 nrEQ==
X-Gm-Message-State: AOJu0YyiowOGl6uWKsd37AC7EYuju+9dYs9nyt2uJdUeIMrFIOhoy4nG
 BtUprK8n8wuozbcFUfF0yeqjiJC026j4MkZcbjNJhikHnZ0o5PiRzY2eKPlTOw0XKieEalHQ+Ih
 WdPgflum1V1Zo+WbrH5gnf3nQBmbs7ooxSenUoBY=
X-Received: by 2002:a05:620a:458b:b0:775:96c8:f560 with SMTP id
 bp11-20020a05620a458b00b0077596c8f560mr14822884qkb.31.1696745632125; 
 Sat, 07 Oct 2023 23:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGW7Z3zCLixyLdnK7GpSq7fbdLebo/BCh/fkUmzVVYrhQuR9L5EdjwRYN3gBX2V1S8Y1ydgdVYIM5GKCHCMWw=
X-Received: by 2002:a05:620a:458b:b0:775:96c8:f560 with SMTP id
 bp11-20020a05620a458b00b0077596c8f560mr14822874qkb.31.1696745631675; Sat, 07
 Oct 2023 23:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231006111412.13130-1-pbonzini@redhat.com>
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 8 Oct 2023 08:13:39 +0200
Message-ID: <CABgObfbHC_cd51w3bMpv5ZKDVhUmPW2ZFfWe4sAMkJro018kTQ@mail.gmail.com>
Subject: Re: [PULL 00/26] Audio, source reorg, HVF changes for 2023-10-06
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a6910f06072e60e3"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a6910f06072e60e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 6 ott 2023, 13:14 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> The following changes since commit
> da1034094d375afe9e3d8ec8980550ea0f06f7e0:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> staging (2023-10-03 07:43:44 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0451b622193aa405c4d9f9ef251aa9ce580adc7f:
>
>   audio, qtest: get rid of QEMU_AUDIO_DRV (2023-10-05 18:43:02 +0200)
>

There are conflicts so I will update the tag.

Paolo


> ----------------------------------------------------------------
> * util/log: re-allow switching away from stderr log file
> * finish audio configuration rework
> * cleanup HVF stubs
> * remove more mentions of softmmu
>
> ----------------------------------------------------------------
> Fiona Ebner (1):
>       util/log: re-allow switching away from stderr log file
>
> Paolo Bonzini (9):
>       configure: change $softmmu to $system
>       cutils: squelch compiler warnings with custom paths
>       audio: error hints need a trailing \n
>       audio: disable default backends if -audio/-audiodev is used
>       audio: extract audio_define_default
>       audio: extend -audio to allow creating a default backend
>       audio: do not use first -audiodev as default audio device
>       audio: reintroduce default audio backend for VNC
>       audio, qtest: get rid of QEMU_AUDIO_DRV
>
> Philippe Mathieu-Daud=C3=A9 (16):
>       target/i386/hvf: Remove unused includes in 'hvf-i386.h'
>       sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86 targets
>       target/i386: Check for USER_ONLY definition instead of SOFTMMU one
>       softmmu/trace-events: Fix a typo
>       travis-ci: Correct invalid mentions of 'softmmu' by 'system'
>       cpu: Correct invalid mentions of 'softmmu' by 'system-mode'
>       fuzz: Correct invalid mentions of 'softmmu' by 'system'
>       tcg: Correct invalid mentions of 'softmmu' by 'system-mode'
>       accel: Rename accel_softmmu* -> accel_system*
>       gdbstub: Rename 'softmmu' -> 'system'
>       semihosting: Rename softmmu_FOO_user() -> uaccess_FOO_user()
>       target/i386: Rename i386_softmmu_kvm_ss -> i386_kvm_ss
>       hw/virtio/meson: Rename softmmu_virtio_ss -> system_virtio_ss
>       meson: Rename softmmu_mods -> system_mods
>       meson: Rename target_softmmu_arch -> target_system_arch
>       system: Rename softmmu/ directory as system/
>
>  .travis.yml                                        |  4 +-
>  MAINTAINERS                                        | 44 +++++------
>  accel/accel-common.c                               |  2 +-
>  accel/{accel-softmmu.c =3D> accel-system.c}          |  6 +-
>  accel/{accel-softmmu.h =3D> accel-system.h}          |  6 +-
>  accel/meson.build                                  |  2 +-
>  accel/stubs/meson.build                            | 10 +--
>  accel/tcg/user-exec.c                              |  2 +-
>  audio/audio.c                                      | 85
> +++++++++-------------
>  audio/audio.h                                      |  3 +
>  configure                                          | 10 +--
>  cpu.c                                              |  2 +-
>  docs/about/deprecated.rst                          |  6 --
>  docs/about/removed-features.rst                    | 20 ++++-
>  docs/devel/build-system.rst                        |  4 +-
>  docs/devel/qtest.rst                               |  2 +-
>  docs/devel/testing.rst                             |  2 +-
>  gdbstub/internals.h                                |  4 +-
>  gdbstub/meson.build                                | 10 +--
>  gdbstub/{softmmu.c =3D> system.c}                    |  2 +-
>  gdbstub/trace-events                               |  2 +-
>  hw/core/cpu-common.c                               |  4 +-
>  hw/virtio/meson.build                              | 22 +++---
>  include/qemu/atomic128.h                           |  4 +-
>  .../semihosting/{softmmu-uaccess.h =3D> uaccess.h}   | 24 +++---
>  include/sysemu/hvf.h                               |  3 -
>  include/sysemu/runstate-action.h                   |  2 +-
>  include/tcg/tcg-op-common.h                        |  2 +-
>  meson.build                                        | 22 +++---
>  qemu-options.hx                                    | 29 ++++++--
>  scripts/checkpatch.pl                              |  2 +-
>  scripts/coverity-scan/COMPONENTS.md                |  2 +-
>  scripts/get_maintainer.pl                          |  2 +-
>  scripts/oss-fuzz/build.sh                          |  6 +-
>  semihosting/arm-compat-semi.c                      |  4 +-
>  semihosting/config.c                               |  2 +-
>  semihosting/guestfd.c                              |  2 +-
>  semihosting/syscalls.c                             |  2 +-
>  semihosting/uaccess.c                              | 14 ++--
>  softmmu/trace.h                                    |  1 -
>  stubs/semihost.c                                   |  4 +-
>  {softmmu =3D> system}/arch_init.c                    |  0
>  {softmmu =3D> system}/async-teardown.c               |  0
>  {softmmu =3D> system}/balloon.c                      |  0
>  {softmmu =3D> system}/bootdevice.c                   |  0
>  {softmmu =3D> system}/cpu-throttle.c                 |  0
>  {softmmu =3D> system}/cpu-timers.c                   |  0
>  {softmmu =3D> system}/cpus.c                         |  0
>  {softmmu =3D> system}/datadir.c                      |  0
>  {softmmu =3D> system}/device_tree.c                  |  0
>  {softmmu =3D> system}/dirtylimit.c                   |  0
>  {softmmu =3D> system}/dma-helpers.c                  |  0
>  {softmmu =3D> system}/globals.c                      |  0
>  {softmmu =3D> system}/icount.c                       |  0
>  {softmmu =3D> system}/ioport.c                       |  0
>  {softmmu =3D> system}/main.c                         |  0
>  {softmmu =3D> system}/memory.c                       |  2 +-
>  {softmmu =3D> system}/memory_mapping.c               |  0
>  {softmmu =3D> system}/meson.build                    |  0
>  {softmmu =3D> system}/physmem.c                      |  6 +-
>  {softmmu =3D> system}/qdev-monitor.c                 |  0
>  {softmmu =3D> system}/qemu-seccomp.c                 |  0
>  {softmmu =3D> system}/qtest.c                        |  0
>  {softmmu =3D> system}/rtc.c                          |  0
>  {softmmu =3D> system}/runstate-action.c              |  0
>  {softmmu =3D> system}/runstate-hmp-cmds.c            |  0
>  {softmmu =3D> system}/runstate.c                     |  0
>  {softmmu =3D> system}/timers-state.h                 |  0
>  {softmmu =3D> system}/tpm-hmp-cmds.c                 |  0
>  {softmmu =3D> system}/tpm.c                          |  0
>  {softmmu =3D> system}/trace-events                   |  2 +-
>  system/trace.h                                     |  1 +
>  {softmmu =3D> system}/vl.c                           | 34 ++++++---
>  {softmmu =3D> system}/watchpoint.c                   |  0
>  target/alpha/meson.build                           |  2 +-
>  target/arm/meson.build                             |  2 +-
>  target/avr/meson.build                             |  2 +-
>  target/cris/meson.build                            |  2 +-
>  target/hppa/meson.build                            |  2 +-
>  target/i386/cpu.c                                  |  3 +-
>  target/i386/hvf/hvf-cpu.c                          |  1 +
>  target/i386/hvf/hvf-i386.h                         |  6 +-
>  target/i386/hvf/x86_cpuid.c                        |  1 +
>  target/i386/kvm/meson.build                        | 10 +--
>  target/i386/meson.build                            |  2 +-
>  target/i386/tcg/misc_helper.c                      |  2 +-
>  target/i386/tcg/translate.c                        |  6 +-
>  target/loongarch/meson.build                       |  2 +-
>  target/m68k/m68k-semi.c                            |  2 +-
>  target/m68k/meson.build                            |  2 +-
>  target/microblaze/meson.build                      |  2 +-
>  target/mips/meson.build                            |  2 +-
>  target/mips/tcg/sysemu/mips-semi.c                 |  2 +-
>  target/nios2/meson.build                           |  2 +-
>  target/nios2/nios2-semi.c                          |  2 +-
>  target/openrisc/meson.build                        |  2 +-
>  target/ppc/meson.build                             |  2 +-
>  target/riscv/meson.build                           |  2 +-
>  target/riscv/vector_helper.c                       |  2 +-
>  target/rx/meson.build                              |  2 +-
>  target/s390x/meson.build                           |  2 +-
>  target/sh4/meson.build                             |  2 +-
>  target/sparc/meson.build                           |  2 +-
>  target/tricore/meson.build                         |  2 +-
>  target/xtensa/meson.build                          |  2 +-
>  tcg/aarch64/tcg-target.c.inc                       |  4 +-
>  tcg/arm/tcg-target.c.inc                           |  2 +-
>  tcg/i386/tcg-target.c.inc                          |  2 +-
>  tcg/loongarch64/tcg-target.c.inc                   |  4 +-
>  tcg/meson.build                                    |  6 +-
>  tcg/mips/tcg-target.c.inc                          |  4 +-
>  tcg/ppc/tcg-target.c.inc                           |  4 +-
>  tcg/region.c                                       |  4 +-
>  tcg/riscv/tcg-target.c.inc                         |  4 +-
>  tcg/s390x/tcg-target.c.inc                         |  4 +-
>  tcg/sparc64/tcg-target.c.inc                       |  4 +-
>  tcg/tcg.c                                          | 11 +--
>  tests/qtest/fuzz/fuzz.c                            |  2 +-
>  tests/qtest/fuzz/fuzz.h                            |  4 +-
>  tests/qtest/libqtest.c                             |  4 +-
>  tests/tcg/Makefile.target                          |  2 +-
>  tests/tcg/multiarch/gdbstub/interrupt.py           |  2 +-
>  tests/tcg/multiarch/gdbstub/memory.py              |  2 +-
>  tests/tcg/multiarch/system/memory.c                |  4 +-
>  tests/tcg/s390x/pgm-specification-softmmu.S        |  2 +-
>  tests/tcg/s390x/pgm-specification.mak              |  2 +-
>  tests/tcg/s390x/softmmu.ld                         |  2 +-
>  tests/tcg/xtensa/Makefile.softmmu-target           |  2 +-
>  tests/tcg/xtensaeb/Makefile.softmmu-target         |  2 +-
>  tests/unit/meson.build                             |  2 +-
>  ui/vnc.c                                           |  2 +
>  util/cutils.c                                      |  9 +++
>  util/log.c                                         |  2 +
>  133 files changed, 315 insertions(+), 286 deletions(-)
>  rename accel/{accel-softmmu.c =3D> accel-system.c} (96%)
>  rename accel/{accel-softmmu.h =3D> accel-system.h} (77%)
>  rename gdbstub/{softmmu.c =3D> system.c} (99%)
>  rename include/semihosting/{softmmu-uaccess.h =3D> uaccess.h} (75%)
>  delete mode 100644 softmmu/trace.h
>  rename {softmmu =3D> system}/arch_init.c (100%)
>  rename {softmmu =3D> system}/async-teardown.c (100%)
>  rename {softmmu =3D> system}/balloon.c (100%)
>  rename {softmmu =3D> system}/bootdevice.c (100%)
>  rename {softmmu =3D> system}/cpu-throttle.c (100%)
>  rename {softmmu =3D> system}/cpu-timers.c (100%)
>  rename {softmmu =3D> system}/cpus.c (100%)
>  rename {softmmu =3D> system}/datadir.c (100%)
>  rename {softmmu =3D> system}/device_tree.c (100%)
>  rename {softmmu =3D> system}/dirtylimit.c (100%)
>  rename {softmmu =3D> system}/dma-helpers.c (100%)
>  rename {softmmu =3D> system}/globals.c (100%)
>  rename {softmmu =3D> system}/icount.c (100%)
>  rename {softmmu =3D> system}/ioport.c (100%)
>  rename {softmmu =3D> system}/main.c (100%)
>  rename {softmmu =3D> system}/memory.c (99%)
>  rename {softmmu =3D> system}/memory_mapping.c (100%)
>  rename {softmmu =3D> system}/meson.build (100%)
>  rename {softmmu =3D> system}/physmem.c (99%)
>  rename {softmmu =3D> system}/qdev-monitor.c (100%)
>  rename {softmmu =3D> system}/qemu-seccomp.c (100%)
>  rename {softmmu =3D> system}/qtest.c (100%)
>  rename {softmmu =3D> system}/rtc.c (100%)
>  rename {softmmu =3D> system}/runstate-action.c (100%)
>  rename {softmmu =3D> system}/runstate-hmp-cmds.c (100%)
>  rename {softmmu =3D> system}/runstate.c (100%)
>  rename {softmmu =3D> system}/timers-state.h (100%)
>  rename {softmmu =3D> system}/tpm-hmp-cmds.c (100%)
>  rename {softmmu =3D> system}/tpm.c (100%)
>  rename {softmmu =3D> system}/trace-events (99%)
>  create mode 100644 system/trace.h
>  rename {softmmu =3D> system}/vl.c (99%)
>  rename {softmmu =3D> system}/watchpoint.c (100%)
> --
> 2.41.0
>

--000000000000a6910f06072e60e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPklsIHZlbiA2IG90dCAyMDIzLCAxMzoxNCBQ
YW9sbyBCb256aW5pICZsdDs8YSBocmVmPSJtYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbSI+cGJv
bnppbmlAcmVkaGF0LmNvbTwvYT4mZ3Q7IGhhIHNjcml0dG86PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0
OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPlRoZSBmb2xsb3dpbmcgY2hhbmdlcyBz
aW5jZSBjb21taXQgZGExMDM0MDk0ZDM3NWFmZTllM2Q4ZWM4OTgwNTUwZWEwZjA2ZjdlMDo8YnI+
DQo8YnI+DQrCoCBNZXJnZSB0YWcgJiMzOTtmb3ItdXBzdHJlYW0mIzM5OyBvZiA8YSBocmVmPSJo
dHRwczovL2dpdGxhYi5jb20vYm9uemluaS9xZW11IiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0bGFiLmNvbS9ib256aW5pL3FlbXU8L2E+IGlu
dG8gc3RhZ2luZyAoMjAyMy0xMC0wMyAwNzo0Mzo0NCAtMDQwMCk8YnI+DQo8YnI+DQphcmUgYXZh
aWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDo8YnI+DQo8YnI+DQrCoCA8YSBocmVmPSJo
dHRwczovL2dpdGxhYi5jb20vYm9uemluaS9xZW11LmdpdCIgcmVsPSJub3JlZmVycmVyIG5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGxhYi5jb20vYm9uemluaS9xZW11Lmdp
dDwvYT4gdGFncy9mb3ItdXBzdHJlYW08YnI+DQo8YnI+DQpmb3IgeW91IHRvIGZldGNoIGNoYW5n
ZXMgdXAgdG8gMDQ1MWI2MjIxOTNhYTQwNWM0ZDlmOWVmMjUxYWE5Y2U1ODBhZGM3Zjo8YnI+DQo8
YnI+DQrCoCBhdWRpbywgcXRlc3Q6IGdldCByaWQgb2YgUUVNVV9BVURJT19EUlYgKDIwMjMtMTAt
MDUgMTg6NDM6MDIgKzAyMDApPGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0i
YXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5UaGVyZSBhcmUgY29uZmxpY3RzIHNvIEkg
d2lsbCB1cGRhdGUgdGhlIHRhZy48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj5QYW9sbzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQoqIHV0aWwvbG9nOiByZS1h
bGxvdyBzd2l0Y2hpbmcgYXdheSBmcm9tIHN0ZGVyciBsb2cgZmlsZTxicj4NCiogZmluaXNoIGF1
ZGlvIGNvbmZpZ3VyYXRpb24gcmV3b3JrPGJyPg0KKiBjbGVhbnVwIEhWRiBzdHViczxicj4NCiog
cmVtb3ZlIG1vcmUgbWVudGlvbnMgb2Ygc29mdG1tdTxicj4NCjxicj4NCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+DQpG
aW9uYSBFYm5lciAoMSk6PGJyPg0KwqAgwqAgwqAgdXRpbC9sb2c6IHJlLWFsbG93IHN3aXRjaGlu
ZyBhd2F5IGZyb20gc3RkZXJyIGxvZyBmaWxlPGJyPg0KPGJyPg0KUGFvbG8gQm9uemluaSAoOSk6
PGJyPg0KwqAgwqAgwqAgY29uZmlndXJlOiBjaGFuZ2UgJHNvZnRtbXUgdG8gJHN5c3RlbTxicj4N
CsKgIMKgIMKgIGN1dGlsczogc3F1ZWxjaCBjb21waWxlciB3YXJuaW5ncyB3aXRoIGN1c3RvbSBw
YXRoczxicj4NCsKgIMKgIMKgIGF1ZGlvOiBlcnJvciBoaW50cyBuZWVkIGEgdHJhaWxpbmcgXG48
YnI+DQrCoCDCoCDCoCBhdWRpbzogZGlzYWJsZSBkZWZhdWx0IGJhY2tlbmRzIGlmIC1hdWRpby8t
YXVkaW9kZXYgaXMgdXNlZDxicj4NCsKgIMKgIMKgIGF1ZGlvOiBleHRyYWN0IGF1ZGlvX2RlZmlu
ZV9kZWZhdWx0PGJyPg0KwqAgwqAgwqAgYXVkaW86IGV4dGVuZCAtYXVkaW8gdG8gYWxsb3cgY3Jl
YXRpbmcgYSBkZWZhdWx0IGJhY2tlbmQ8YnI+DQrCoCDCoCDCoCBhdWRpbzogZG8gbm90IHVzZSBm
aXJzdCAtYXVkaW9kZXYgYXMgZGVmYXVsdCBhdWRpbyBkZXZpY2U8YnI+DQrCoCDCoCDCoCBhdWRp
bzogcmVpbnRyb2R1Y2UgZGVmYXVsdCBhdWRpbyBiYWNrZW5kIGZvciBWTkM8YnI+DQrCoCDCoCDC
oCBhdWRpbywgcXRlc3Q6IGdldCByaWQgb2YgUUVNVV9BVURJT19EUlY8YnI+DQo8YnI+DQpQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSAoMTYpOjxicj4NCsKgIMKgIMKgIHRhcmdldC9pMzg2L2h2Zjog
UmVtb3ZlIHVudXNlZCBpbmNsdWRlcyBpbiAmIzM5O2h2Zi1pMzg2LmgmIzM5Ozxicj4NCsKgIMKg
IMKgIHN5c2VtdS9rdm06IFJlc3RyaWN0IGh2Zl9nZXRfc3VwcG9ydGVkX2NwdWlkKCkgdG8geDg2
IHRhcmdldHM8YnI+DQrCoCDCoCDCoCB0YXJnZXQvaTM4NjogQ2hlY2sgZm9yIFVTRVJfT05MWSBk
ZWZpbml0aW9uIGluc3RlYWQgb2YgU09GVE1NVSBvbmU8YnI+DQrCoCDCoCDCoCBzb2Z0bW11L3Ry
YWNlLWV2ZW50czogRml4IGEgdHlwbzxicj4NCsKgIMKgIMKgIHRyYXZpcy1jaTogQ29ycmVjdCBp
bnZhbGlkIG1lbnRpb25zIG9mICYjMzk7c29mdG1tdSYjMzk7IGJ5ICYjMzk7c3lzdGVtJiMzOTs8
YnI+DQrCoCDCoCDCoCBjcHU6IENvcnJlY3QgaW52YWxpZCBtZW50aW9ucyBvZiAmIzM5O3NvZnRt
bXUmIzM5OyBieSAmIzM5O3N5c3RlbS1tb2RlJiMzOTs8YnI+DQrCoCDCoCDCoCBmdXp6OiBDb3Jy
ZWN0IGludmFsaWQgbWVudGlvbnMgb2YgJiMzOTtzb2Z0bW11JiMzOTsgYnkgJiMzOTtzeXN0ZW0m
IzM5Ozxicj4NCsKgIMKgIMKgIHRjZzogQ29ycmVjdCBpbnZhbGlkIG1lbnRpb25zIG9mICYjMzk7
c29mdG1tdSYjMzk7IGJ5ICYjMzk7c3lzdGVtLW1vZGUmIzM5Ozxicj4NCsKgIMKgIMKgIGFjY2Vs
OiBSZW5hbWUgYWNjZWxfc29mdG1tdSogLSZndDsgYWNjZWxfc3lzdGVtKjxicj4NCsKgIMKgIMKg
IGdkYnN0dWI6IFJlbmFtZSAmIzM5O3NvZnRtbXUmIzM5OyAtJmd0OyAmIzM5O3N5c3RlbSYjMzk7
PGJyPg0KwqAgwqAgwqAgc2VtaWhvc3Rpbmc6IFJlbmFtZSBzb2Z0bW11X0ZPT191c2VyKCkgLSZn
dDsgdWFjY2Vzc19GT09fdXNlcigpPGJyPg0KwqAgwqAgwqAgdGFyZ2V0L2kzODY6IFJlbmFtZSBp
Mzg2X3NvZnRtbXVfa3ZtX3NzIC0mZ3Q7IGkzODZfa3ZtX3NzPGJyPg0KwqAgwqAgwqAgaHcvdmly
dGlvL21lc29uOiBSZW5hbWUgc29mdG1tdV92aXJ0aW9fc3MgLSZndDsgc3lzdGVtX3ZpcnRpb19z
czxicj4NCsKgIMKgIMKgIG1lc29uOiBSZW5hbWUgc29mdG1tdV9tb2RzIC0mZ3Q7IHN5c3RlbV9t
b2RzPGJyPg0KwqAgwqAgwqAgbWVzb246IFJlbmFtZSB0YXJnZXRfc29mdG1tdV9hcmNoIC0mZ3Q7
IHRhcmdldF9zeXN0ZW1fYXJjaDxicj4NCsKgIMKgIMKgIHN5c3RlbTogUmVuYW1lIHNvZnRtbXUv
IGRpcmVjdG9yeSBhcyBzeXN0ZW0vPGJyPg0KPGJyPg0KwqAudHJhdmlzLnltbMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA0ICst
PGJyPg0KwqBNQUlOVEFJTkVSU8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgNDQgKysrKystLS0tLS08YnI+DQrCoGFjY2VsL2FjY2Vs
LWNvbW1vbi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgMiArLTxicj4NCsKgYWNjZWwve2FjY2VsLXNvZnRtbXUuYyA9Jmd0OyBhY2NlbC1zeXN0ZW0u
Y33CoCDCoCDCoCDCoCDCoCB8wqAgNiArLTxicj4NCsKgYWNjZWwve2FjY2VsLXNvZnRtbXUuaCA9
Jmd0OyBhY2NlbC1zeXN0ZW0uaH3CoCDCoCDCoCDCoCDCoCB8wqAgNiArLTxicj4NCsKgYWNjZWwv
bWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgMiArLTxicj4NCsKgYWNjZWwvc3R1YnMvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDEwICstLTxicj4NCsKgYWNjZWwvdGNnL3Vz
ZXItZXhlYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKg
IDIgKy08YnI+DQrCoGF1ZGlvL2F1ZGlvLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDg1ICsrKysrKysrKy0tLS0tLS0tLS0tLS08YnI+
DQrCoGF1ZGlvL2F1ZGlvLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgMyArPGJyPg0KwqBjb25maWd1cmXCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDEwICstLTxi
cj4NCsKgY3B1LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZG9jcy9hYm91dC9kZXByZWNh
dGVkLnJzdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA2IC0tPGJy
Pg0KwqBkb2NzL2Fib3V0L3JlbW92ZWQtZmVhdHVyZXMucnN0wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfCAyMCArKysrLTxicj4NCsKgZG9jcy9kZXZlbC9idWlsZC1zeXN0ZW0ucnN0wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQgKy08YnI+DQrCoGRvY3MvZGV2
ZWwvcXRlc3QucnN0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgMiArLTxicj4NCsKgZG9jcy9kZXZlbC90ZXN0aW5nLnJzdMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGdkYnN0dWIvaW50ZXJu
YWxzLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
NCArLTxicj4NCsKgZ2Ric3R1Yi9tZXNvbi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTAgKy0tPGJyPg0KwqBnZGJzdHViL3tzb2Z0bW11LmMg
PSZndDsgc3lzdGVtLmN9wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+
DQrCoGdkYnN0dWIvdHJhY2UtZXZlbnRzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgaHcvY29yZS9jcHUtY29tbW9uLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICstPGJyPg0KwqBo
dy92aXJ0aW8vbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8IDIyICsrKy0tLTxicj4NCsKgaW5jbHVkZS9xZW11L2F0b21pYzEyOC5owqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNCArLTxicj4NCsKgLi4uL3Nl
bWlob3N0aW5nL3tzb2Z0bW11LXVhY2Nlc3MuaCA9Jmd0OyB1YWNjZXNzLmh9wqAgwqB8IDI0ICsr
Ky0tLTxicj4NCsKgaW5jbHVkZS9zeXNlbXUvaHZmLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAzIC08YnI+DQrCoGluY2x1ZGUvc3lzZW11L3J1bnN0
YXRlLWFjdGlvbi5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKg
aW5jbHVkZS90Y2cvdGNnLW9wLWNvbW1vbi5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIDIgKy08YnI+DQrCoG1lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCAyMiArKystLS08YnI+DQrCoHFl
bXUtb3B0aW9ucy5oeMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHwgMjkgKysrKysrLS08YnI+DQrCoHNjcmlwdHMvPGEgaHJlZj0iaHR0cDovL2No
ZWNrcGF0Y2gucGwiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+
Y2hlY2twYXRjaC5wbDwvYT7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgMiArLTxicj4NCsKgc2NyaXB0cy9jb3Zlcml0eS1zY2FuL0NPTVBPTkVOVFMubWTC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgc2NyaXB0cy88YSBocmVmPSJo
dHRwOi8vZ2V0X21haW50YWluZXIucGwiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+Z2V0X21haW50YWluZXIucGw8L2E+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHNjcmlwdHMvb3NzLWZ1enovYnVpbGQuc2jC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNiArLTxicj4NCsKgc2Vt
aWhvc3RpbmcvYXJtLWNvbXBhdC1zZW1pLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgNCArLTxicj4NCsKgc2VtaWhvc3RpbmcvY29uZmlnLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBzZW1paG9zdGluZy9n
dWVzdGZkLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
MiArLTxicj4NCsKgc2VtaWhvc3Rpbmcvc3lzY2FsbHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoHNlbWlob3N0aW5nL3VhY2Nlc3Mu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwgMTQgKystLTxi
cj4NCsKgc29mdG1tdS90cmFjZS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIDEgLTxicj4NCsKgc3R1YnMvc2VtaWhvc3QuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDQgKy08YnI+
DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vYXJjaF9pbml0LmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9hc3luYy10ZWFy
ZG93bi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsg
c3lzdGVtfS9iYWxsb29uLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMDxi
cj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9ib290ZGV2aWNlLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L2NwdS10aHJv
dHRsZS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZn
dDsgc3lzdGVtfS9jcHUtdGltZXJzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAw
PGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L2NwdXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIDA8YnI+DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vZGF0
YWRpci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDA8YnI+DQrCoHtzb2Z0
bW11ID0mZ3Q7IHN5c3RlbX0vZGV2aWNlX3RyZWUuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L2RpcnR5bGltaXQuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDA8YnI+DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0v
ZG1hLWhlbHBlcnMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAwPGJyPg0KwqB7c29m
dG1tdSA9Jmd0OyBzeXN0ZW19L2dsb2JhbHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L2ljb3VudC5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lz
dGVtfS9pb3BvcnQuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDA8YnI+
DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vbWFpbi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9tZW1vcnku
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoHtzb2Z0
bW11ID0mZ3Q7IHN5c3RlbX0vbWVtb3J5X21hcHBpbmcuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIDA8YnI+DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vbWVzb24uYnVpbGTCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9w
aHlzbWVtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNiArLTxicj4NCsKg
e3NvZnRtbXUgPSZndDsgc3lzdGVtfS9xZGV2LW1vbml0b3IuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIDA8YnI+DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vcWVtdS1zZWNjb21wLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0
ZW19L3F0ZXN0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMDxicj4N
CsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9ydGMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3J1bnN0YXRl
LWFjdGlvbi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDA8YnI+DQrCoHtzb2Z0bW11ID0mZ3Q7
IHN5c3RlbX0vcnVuc3RhdGUtaG1wLWNtZHMuY8KgIMKgIMKgIMKgIMKgIMKgIHzCoCAwPGJyPg0K
wqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3J1bnN0YXRlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCAwPGJyPg0KwqB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3RpbWVycy1zdGF0
ZS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsg
c3lzdGVtfS90cG0taG1wLWNtZHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDA8YnI+
DQrCoHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vdHBtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8wqAgMDxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS90cmFjZS1l
dmVudHPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBzeXN0ZW0v
dHJhY2UuaMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIDEgKzxicj4NCsKge3NvZnRtbXUgPSZndDsgc3lzdGVtfS92bC5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDM0ICsrKysrKy0tLTxicj4NCsKge3Nv
ZnRtbXUgPSZndDsgc3lzdGVtfS93YXRjaHBvaW50LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCAwPGJyPg0KwqB0YXJnZXQvYWxwaGEvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqB0YXJnZXQvYXJtL21lc29u
LmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiAr
LTxicj4NCsKgdGFyZ2V0L2F2ci9tZXNvbi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9jcmlzL21lc29uLmJ1aWxk
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrC
oHRhcmdldC9ocHBhL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9pMzg2L2NwdS5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDMgKy08YnI+DQrCoHRhcmdl
dC9pMzg2L2h2Zi9odmYtY3B1LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgMSArPGJyPg0KwqB0YXJnZXQvaTM4Ni9odmYvaHZmLWkzODYuaMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDYgKy08YnI+DQrCoHRhcmdldC9pMzg2L2h2Zi94
ODZfY3B1aWQuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAxICs8YnI+
DQrCoHRhcmdldC9pMzg2L2t2bS9tZXNvbi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHwgMTAgKy0tPGJyPg0KwqB0YXJnZXQvaTM4Ni9tZXNvbi5idWlsZMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqB0YXJnZXQv
aTM4Ni90Y2cvbWlzY19oZWxwZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCAyICstPGJyPg0KwqB0YXJnZXQvaTM4Ni90Y2cvdHJhbnNsYXRlLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNiArLTxicj4NCsKgdGFyZ2V0L2xvb25nYXJjaC9tZXNv
bi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrC
oHRhcmdldC9tNjhrL202OGstc2VtaS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9tNjhrL21lc29uLmJ1aWxkwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9t
aWNyb2JsYXplL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKg
IDIgKy08YnI+DQrCoHRhcmdldC9taXBzL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9taXBzL3RjZy9zeXNl
bXUvbWlwcy1zZW1pLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqB0
YXJnZXQvbmlvczIvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHzCoCAyICstPGJyPg0KwqB0YXJnZXQvbmlvczIvbmlvczItc2VtaS5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9vcGVu
cmlzYy9tZXNvbi5idWlsZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAy
ICstPGJyPg0KwqB0YXJnZXQvcHBjL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgdGFyZ2V0L3Jpc2N2L21lc29uLmJ1
aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4N
CsKgdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoHRhcmdldC9yeC9tZXNvbi5idWlsZMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqB0YXJnZXQv
czM5MHgvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCAyICstPGJyPg0KwqB0YXJnZXQvc2g0L21lc29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgdGFyZ2V0L3NwYXJjL21l
c29uLmJ1aWxkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiAr
LTxicj4NCsKgdGFyZ2V0L3RyaWNvcmUvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqB0YXJnZXQveHRlbnNhL21lc29uLmJ1aWxk
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoHRj
Zy9hYXJjaDY0L3RjZy10YXJnZXQuYy5pbmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCA0ICstPGJyPg0KwqB0Y2cvYXJtL3RjZy10YXJnZXQuYy5pbmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqB0Y2cvaTM4Ni90Y2ct
dGFyZ2V0LmMuaW5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIg
Ky08YnI+DQrCoHRjZy9sb29uZ2FyY2g2NC90Y2ctdGFyZ2V0LmMuaW5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgNCArLTxicj4NCsKgdGNnL21lc29uLmJ1aWxkwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDYgKy08YnI+DQrC
oHRjZy9taXBzL3RjZy10YXJnZXQuYy5pbmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgNCArLTxicj4NCsKgdGNnL3BwYy90Y2ctdGFyZ2V0LmMuaW5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNCArLTxicj4NCsKgdGNnL3JlZ2lv
bi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgNCArLTxicj4NCsKgdGNnL3Jpc2N2L3RjZy10YXJnZXQuYy5pbmPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICstPGJyPg0KwqB0Y2cvczM5MHgvdGNn
LXRhcmdldC5jLmluY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDQg
Ky08YnI+DQrCoHRjZy9zcGFyYzY0L3RjZy10YXJnZXQuYy5pbmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCA0ICstPGJyPg0KwqB0Y2cvdGNnLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDExICstLTxi
cj4NCsKgdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmjCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArLTxicj4NCsKgdGVz
dHMvcXRlc3QvbGlicXRlc3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIDQgKy08YnI+DQrCoHRlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXTCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgdGVzdHMvdGNnL211
bHRpYXJjaC9nZGJzdHViL2ludGVycnVwdC5wecKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+
DQrCoHRlc3RzL3RjZy9tdWx0aWFyY2gvZ2Ric3R1Yi9tZW1vcnkucHnCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgMiArLTxicj4NCsKgdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5LmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArLTxicj4NCsKgdGVzdHMvdGNnL3MzOTB4L3Bn
bS1zcGVjaWZpY2F0aW9uLXNvZnRtbXUuU8KgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqB0ZXN0
cy90Y2cvczM5MHgvcGdtLXNwZWNpZmljYXRpb24ubWFrwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKg
IDIgKy08YnI+DQrCoHRlc3RzL3RjZy9zMzkweC9zb2Z0bW11LmxkwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgdGVzdHMvdGNnL3h0ZW5zYS9NYWtl
ZmlsZS5zb2Z0bW11LXRhcmdldMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoHRlc3Rz
L3RjZy94dGVuc2FlYi9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldMKgIMKgIMKgIMKgIMKgfMKgIDIg
Ky08YnI+DQrCoHRlc3RzL3VuaXQvbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqB1aS92bmMuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIg
Kzxicj4NCsKgdXRpbC9jdXRpbHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA5ICsrKzxicj4NCsKgdXRpbC9sb2cuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IDIgKzxicj4NCsKgMTMzIGZpbGVzIGNoYW5nZWQsIDMxNSBpbnNlcnRpb25zKCspLCAyODYgZGVs
ZXRpb25zKC0pPGJyPg0KwqByZW5hbWUgYWNjZWwve2FjY2VsLXNvZnRtbXUuYyA9Jmd0OyBhY2Nl
bC1zeXN0ZW0uY30gKDk2JSk8YnI+DQrCoHJlbmFtZSBhY2NlbC97YWNjZWwtc29mdG1tdS5oID0m
Z3Q7IGFjY2VsLXN5c3RlbS5ofSAoNzclKTxicj4NCsKgcmVuYW1lIGdkYnN0dWIve3NvZnRtbXUu
YyA9Jmd0OyBzeXN0ZW0uY30gKDk5JSk8YnI+DQrCoHJlbmFtZSBpbmNsdWRlL3NlbWlob3N0aW5n
L3tzb2Z0bW11LXVhY2Nlc3MuaCA9Jmd0OyB1YWNjZXNzLmh9ICg3NSUpPGJyPg0KwqBkZWxldGUg
bW9kZSAxMDA2NDQgc29mdG1tdS90cmFjZS5oPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsg
c3lzdGVtfS9hcmNoX2luaXQuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBz
eXN0ZW19L2FzeW5jLXRlYXJkb3duLmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZn
dDsgc3lzdGVtfS9iYWxsb29uLmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsg
c3lzdGVtfS9ib290ZGV2aWNlLmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsg
c3lzdGVtfS9jcHUtdGhyb3R0bGUuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0
OyBzeXN0ZW19L2NwdS10aW1lcnMuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0
OyBzeXN0ZW19L2NwdXMuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0
ZW19L2RhdGFkaXIuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19
L2RldmljZV90cmVlLmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVt
fS9kaXJ0eWxpbWl0LmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVt
fS9kbWEtaGVscGVycy5jICgxMDAlKTxicj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3Rl
bX0vZ2xvYmFscy5jICgxMDAlKTxicj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0v
aWNvdW50LmMgKDEwMCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9pb3Bv
cnQuYyAoMTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L21haW4uYyAo
MTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L21lbW9yeS5jICg5OSUp
PGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9tZW1vcnlfbWFwcGluZy5jICgx
MDAlKTxicj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vbWVzb24uYnVpbGQgKDEw
MCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9waHlzbWVtLmMgKDk5JSk8
YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3FkZXYtbW9uaXRvci5jICgxMDAl
KTxicj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vcWVtdS1zZWNjb21wLmMgKDEw
MCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9xdGVzdC5jICgxMDAlKTxi
cj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vcnRjLmMgKDEwMCUpPGJyPg0KwqBy
ZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9ydW5zdGF0ZS1hY3Rpb24uYyAoMTAwJSk8YnI+
DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3J1bnN0YXRlLWhtcC1jbWRzLmMgKDEw
MCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS9ydW5zdGF0ZS5jICgxMDAl
KTxicj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vdGltZXJzLXN0YXRlLmggKDEw
MCUpPGJyPg0KwqByZW5hbWUge3NvZnRtbXUgPSZndDsgc3lzdGVtfS90cG0taG1wLWNtZHMuYyAo
MTAwJSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0OyBzeXN0ZW19L3RwbS5jICgxMDAlKTxi
cj4NCsKgcmVuYW1lIHtzb2Z0bW11ID0mZ3Q7IHN5c3RlbX0vdHJhY2UtZXZlbnRzICg5OSUpPGJy
Pg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgc3lzdGVtL3RyYWNlLmg8YnI+DQrCoHJlbmFtZSB7c29m
dG1tdSA9Jmd0OyBzeXN0ZW19L3ZsLmMgKDk5JSk8YnI+DQrCoHJlbmFtZSB7c29mdG1tdSA9Jmd0
OyBzeXN0ZW19L3dhdGNocG9pbnQuYyAoMTAwJSk8YnI+DQotLSA8YnI+DQoyLjQxLjA8YnI+DQo8
L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--000000000000a6910f06072e60e3--


