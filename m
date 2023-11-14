Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B27EB6DD
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2z2K-00035L-6r; Tue, 14 Nov 2023 14:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2z2D-00033W-TQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:25:18 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2z2B-0006lg-J9
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:25:17 -0500
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-6c4d06b6ddaso4130842b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699989913; x=1700594713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QYKPDnIRsROURo/RnMhqWUuUuWhuyCCAyvIL9Iqwqc=;
 b=mgOm2dHWebgr+6C0GdYpthrMOY1HVCAQLdCR8KbFHf6+c+uhfV42kvmj+zhSP3TcoC
 w/D+RmxfGiIW9hcQsj9d3SJkJmPLYV+vboQDgmnoDKv6fkOrU1eKuwY0wmHfQNEuLYgY
 FBTQcfubKwpkGtCLx77kHezO6ZmkSWCcFbDFj5Yz/Y9k9U2njFDXrFhsXHXgaanzmGLu
 zeNWIYc0oM90bTSW4rx/dISm0lzdlf+ovlQuAEQdCEw4T40crUWUm5rs50bzwvEh0nuu
 TeLXBxc/u2KFGGFl4d+HChXvmhaaWvwD4sjbTsC2i2BDFvzD6yQaE7ens/eyTkyVxfJ4
 /xAw==
X-Gm-Message-State: AOJu0YwFx/rCB9DwFxYwL9W1W3s5jPYHFEK36Pi+LLDHzBh8u/CbSQ7x
 Yhv7iIDp2dek1p/av6LWH+OfS4XvwNg=
X-Google-Smtp-Source: AGHT+IEhnar9Z+wZa8ZysSPxp/kg+HDnTqkMC3G5xdsluzzSr5vXgHE4Ku3Hg42ILFC3oNO5ofqSiQ==
X-Received: by 2002:a05:6a00:1d8e:b0:690:d4fa:d43d with SMTP id
 z14-20020a056a001d8e00b00690d4fad43dmr9418785pfw.6.1699989912618; 
 Tue, 14 Nov 2023 11:25:12 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com.
 [209.85.216.49]) by smtp.gmail.com with ESMTPSA id
 s19-20020a62e713000000b006c43296c8f3sm1524663pfh.52.2023.11.14.11.25.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 11:25:12 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-280165bba25so4967181a91.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:25:12 -0800 (PST)
X-Received: by 2002:a17:90b:4b8b:b0:27d:58a8:fa7f with SMTP id
 lr11-20020a17090b4b8b00b0027d58a8fa7fmr8756073pjb.37.1699989911763; Tue, 14
 Nov 2023 11:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <CAJ+F1CJunC52JX=YOiycHDeTVxVRwjuV9veQZ1QaN1=JCuo7nQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJunC52JX=YOiycHDeTVxVRwjuV9veQZ1QaN1=JCuo7nQ@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 14 Nov 2023 11:25:00 -0800
X-Gmail-Original-Message-ID: <CA+E+eSAd_NyD4WH5VEcz8G6pSD+AMZDcrkbPHgHB5KDmG=P+aQ@mail.gmail.com>
Message-ID: <CA+E+eSAd_NyD4WH5VEcz8G6pSD+AMZDcrkbPHgHB5KDmG=P+aQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] tpm: introduce TPM CRB SysBus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.181; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f181.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 14, 2023 at 1:38=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Nov 14, 2023 at 6:10=E2=80=AFAM Joelle van Dyne <j@getutm.app> wr=
ote:
> >
> > The impetus for this patch set is to get TPM 2.0 working on Windows 11 =
ARM64.
> > Windows' tpm.sys does not seem to work on a TPM TIS device (as verified=
 with
> > VMWare's implementation). However, the current TPM CRB device uses a fi=
xed
> > system bus address that is reserved for RAM in ARM64 Virt machines.
> >
> > In the process of adding the TPM CRB SysBus device, we also went ahead =
and
> > cleaned up some of the existing TPM hardware code and fixed some bugs. =
We used
> > the TPM TIS devices as a template for the TPM CRB devices and refactore=
d out
> > common code. We moved the ACPI DSDT generation to the device in order t=
o handle
> > dynamic base address requirements as well as reduce redundent code in d=
ifferent
> > machine ACPI generation. We also changed the tpm_crb device to use the =
ISA bus
> > instead of depending on the default system bus as the device only was b=
uilt for
> > the PC configuration.
> >
> > Another change is that the TPM CRB registers are now mapped in the same=
 way that
> > the pflash ROM devices are mapped. It is a memory region whose writes a=
re
> > trapped as MMIO accesses. This was needed because Apple Silicon does no=
t decode
> > LDP (AARCH64 load pair of registers) caused page faults. @agraf suggest=
ed that
> > we do this to avoid having to do AARCH64 decoding in the HVF backend's =
fault
> > handler.
> >
> > Unfortunately, it seems like the LDP fault still happens on HVF but the=
 issue
> > seems to be in the HVF backend which needs to be fixed in a separate pa=
tch.
> >
> > One last thing that's needed to get Windows 11 to recognize the TPM 2.0=
 device
> > is for the OVMF firmware to setup the TPM device. Currently, OVMF for A=
RM64 Virt
> > only recognizes the TPM TIS device through a FDT entry. A workaround is=
 to
> > falsely identify the TPM CRB device as a TPM TIS device in the FDT node=
 but this
> > causes issues for Linux. A proper fix would involve adding an ACPI devi=
ce driver
> > in OVMF.
> >
> > This has been tested on ARM64 with `tpm-crb-device` and on x86_64 with
> > `tpm-crb`. Additional testing should be performed on other architecture=
s (RISCV
> > and Loongarch for example) as well as migration cases.
> >
> > v5:
> > - Fixed a typo in "tpm_crb: use a single read-as-mem/write-as-mmio mapp=
ing"
> > - Fixed ACPI tables not being created for pc CRB device
> >
> > v4:
> > - Fixed broken test blobs
> >
> > v3:
> > - Support backwards and forwards migration of existing tpm-crb device
> > - Dropped patch which moved tpm-crb to ISA bus due to migration concern=
s
> > - Unified `tpm_sysbus_plug` handler for ARM and Loongarch
> > - Added ACPI table tests for tpm-crb-device
> > - Refactored TPM CRB tests to run on tpm-crb-device for ARM Virt
> >
> > v2:
> > - Fixed an issue where VMstate restore from an older version failed due=
 to name
> >   collision of the memory block.
> > - In the ACPI table generation for CRB devices, the check for TPM 2.0 b=
ackend is
> >   moved to the device realize as CRB does not support TPM 1.0. It will =
error in
> >   that case.
> > - Dropped the patch to fix crash when PPI is enabled on TIS SysBus devi=
ce since
> >   a separate patch submitted by Stefan Berger disables such an option.
> > - Fixed an issue where we default tpmEstablished=3D0 when it should be =
1.
> > - In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 to =
1. This
> >   shouldn't be an issue but we changed it back just in case.
> > - Added a patch to migrate saved VMstate from an older version with the=
 regs
> >   saved separately instead of as a RAM block.
> >
> > Joelle van Dyne (14):
> >   tpm_crb: refactor common code
> >   tpm_crb: CTRL_RSP_ADDR is 64-bits wide
> >   tpm_ppi: refactor memory space initialization
> >   tpm_crb: use a single read-as-mem/write-as-mmio mapping
> >   tpm_crb: move ACPI table building to device interface
> >   tpm-sysbus: add plug handler for TPM on SysBus
> >   hw/arm/virt: connect TPM to platform bus
> >   hw/loongarch/virt: connect TPM to platform bus
> >   tpm_tis_sysbus: move DSDT AML generation to device
> >   tests: acpi: prepare for TPM CRB tests
> >   tpm_crb_sysbus: introduce TPM CRB SysBus device
> >   tests: acpi: implement TPM CRB tests for ARM virt
> >   tests: acpi: updated expected blobs for TPM CRB
> >   tests: add TPM-CRB sysbus tests for aarch64
>
> The series looks good to me.
> Have you checked there are no regressions with Windows HLK?
I don't have any experience with Windows HLK. Is there any guide on
running it with QEMU? Preferably with a prebuilt image? Or maybe
someone in the mailing list can run it?

>
> thanks
>
> >
> >  docs/specs/tpm.rst                        |   2 +
> >  hw/tpm/tpm_crb.h                          |  79 ++++++
> >  hw/tpm/tpm_ppi.h                          |  10 +-
> >  include/hw/acpi/tpm.h                     |   3 +-
> >  include/sysemu/tpm.h                      |   7 +
> >  tests/qtest/tpm-tests.h                   |   2 +
> >  tests/qtest/tpm-util.h                    |   4 +-
> >  hw/acpi/aml-build.c                       |   7 +-
> >  hw/arm/virt-acpi-build.c                  |  38 +--
> >  hw/arm/virt.c                             |   8 +
> >  hw/core/sysbus-fdt.c                      |   1 +
> >  hw/i386/acpi-build.c                      |  16 +-
> >  hw/loongarch/acpi-build.c                 |  38 +--
> >  hw/loongarch/virt.c                       |   8 +
> >  hw/riscv/virt.c                           |   1 +
> >  hw/tpm/tpm-sysbus.c                       |  47 ++++
> >  hw/tpm/tpm_crb.c                          | 302 ++++++----------------
> >  hw/tpm/tpm_crb_common.c                   | 262 +++++++++++++++++++
> >  hw/tpm/tpm_crb_sysbus.c                   | 162 ++++++++++++
> >  hw/tpm/tpm_ppi.c                          |   5 +-
> >  hw/tpm/tpm_tis_isa.c                      |   5 +-
> >  hw/tpm/tpm_tis_sysbus.c                   |  37 +++
> >  tests/qtest/bios-tables-test.c            |  47 +++-
> >  tests/qtest/tpm-crb-device-swtpm-test.c   |  72 ++++++
> >  tests/qtest/tpm-crb-device-test.c         |  71 +++++
> >  tests/qtest/tpm-crb-swtpm-test.c          |   2 +
> >  tests/qtest/tpm-crb-test.c                | 121 +--------
> >  tests/qtest/tpm-tests.c                   | 121 +++++++++
> >  tests/qtest/tpm-tis-device-swtpm-test.c   |   2 +-
> >  tests/qtest/tpm-tis-device-test.c         |   2 +-
> >  tests/qtest/tpm-tis-i2c-test.c            |   3 +
> >  tests/qtest/tpm-tis-swtpm-test.c          |   2 +-
> >  tests/qtest/tpm-tis-test.c                |   2 +-
> >  tests/qtest/tpm-util.c                    |  16 +-
> >  hw/arm/Kconfig                            |   1 +
> >  hw/loongarch/Kconfig                      |   2 +
> >  hw/riscv/Kconfig                          |   1 +
> >  hw/tpm/Kconfig                            |   5 +
> >  hw/tpm/meson.build                        |   5 +
> >  hw/tpm/trace-events                       |   2 +-
> >  tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8355 bytes
> >  tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
> >  tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
> >  tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
> >  tests/qtest/meson.build                   |   4 +
> >  45 files changed, 1057 insertions(+), 468 deletions(-)
> >  create mode 100644 hw/tpm/tpm_crb.h
> >  create mode 100644 hw/tpm/tpm-sysbus.c
> >  create mode 100644 hw/tpm/tpm_crb_common.c
> >  create mode 100644 hw/tpm/tpm_crb_sysbus.c
> >  create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
> >  create mode 100644 tests/qtest/tpm-crb-device-test.c
> >  create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
> >  create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
> >  create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
> >  create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2
> >
> > --
> > 2.41.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

