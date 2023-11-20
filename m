Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587BC7F0D90
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 09:30:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4zff-0000Zg-Ii; Mon, 20 Nov 2023 03:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r4zfb-0000ZH-E9
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:30:15 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r4zfY-0007aV-V9
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 03:30:15 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc535cd5cso23689271cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700469010; x=1701073810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHxYgjC+gD36m+e76/fyBP8R926d378TuEOX+6KFfrI=;
 b=I84SrEO9MThh3yY5yuqW6uhm9eA96SPm9i86Xgjq4UhVKqcj0bzsv83aX4dD7FFPzS
 gt5t/tUjoYgaNUlIqPUVHh5i2fAbrcwF2oQcv7GOl0iyiLsZDvk089PfY62xfWM4e7FZ
 yDjjFS+2vLGQjCvOM80Q0Tu0kqskFQA4mK9BDM22MKjSBukVViv5QuujVZc2PIky6U0b
 jM/gC/xzx+swuuY1hYDsyNhk+idJav9h3Edl3qpYnGG9rhzoYRjX05w2iDiXX8ocrcbY
 j+ykAAtebAyykaDbtI2wD6nd49XkEQN2b641ApMP1kFdqucabHsDbjTmLFN8NfioQ6Mn
 IMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700469010; x=1701073810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHxYgjC+gD36m+e76/fyBP8R926d378TuEOX+6KFfrI=;
 b=c1DQ3jJpEdjsHfSK6zBtADWo4M4quySqYRBrCx4qyMkpuNLwR2pHeIQLfvWbFpeQXl
 qtAR6MIUpqTpWWXkyQeIsjojo2ZAGTWgfZGiiCKe6BXVNgdlMogR92Bvrfey/V6v6rt0
 SYNpG6PDuQm722itTBsg5cIotOgDyeUHXVndFEucFOY4/vg9G8Ik7jFL7lLVMnB7qp5N
 cLbEE81KMZgMVmRukeu/4U1Lmic7kETfNeSHXIajm3siIe7BgsvRGIPqw7AncWFanwbX
 CC3ekj8AdI0lfRBWb/KxuEmT7/5luboWuyJWkIrjdseju1AEf9H2fm7FTeEtGHyQupaf
 uk5w==
X-Gm-Message-State: AOJu0Ywy4Z8eohhKsRfFv1mTbpf0DJF6PGsm8OaFZcawFxeIf280B1Vl
 HjO5RT9mi7dV7mDqDLlpfcapZKLfym1b/8Wve5w=
X-Google-Smtp-Source: AGHT+IFglhfhOvohgT1q6K3dowRyuTrwUMK+0ri5IVxGfuJl05zE0iPT3jTnrY2Ose2Nd1Cwg551H9giLakYL6wY6dE=
X-Received: by 2002:a05:622a:491:b0:410:9af1:f9b2 with SMTP id
 p17-20020a05622a049100b004109af1f9b2mr7841877qtx.3.1700469009813; Mon, 20 Nov
 2023 00:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <CAJ+F1CJunC52JX=YOiycHDeTVxVRwjuV9veQZ1QaN1=JCuo7nQ@mail.gmail.com>
 <CA+E+eSAd_NyD4WH5VEcz8G6pSD+AMZDcrkbPHgHB5KDmG=P+aQ@mail.gmail.com>
In-Reply-To: <CA+E+eSAd_NyD4WH5VEcz8G6pSD+AMZDcrkbPHgHB5KDmG=P+aQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Nov 2023 12:29:58 +0400
Message-ID: <CAJ+F1CK7gT1AC_985wy74KgB+eDwgw0LXQnpQA7Pydb2EmfAwg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] tpm: introduce TPM CRB SysBus device
To: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Nov 14, 2023 at 11:25=E2=80=AFPM Joelle van Dyne <j@getutm.app> wro=
te:
>
> On Tue, Nov 14, 2023 at 1:38=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Tue, Nov 14, 2023 at 6:10=E2=80=AFAM Joelle van Dyne <j@getutm.app> =
wrote:
> > >
> > > The impetus for this patch set is to get TPM 2.0 working on Windows 1=
1 ARM64.
> > > Windows' tpm.sys does not seem to work on a TPM TIS device (as verifi=
ed with
> > > VMWare's implementation). However, the current TPM CRB device uses a =
fixed
> > > system bus address that is reserved for RAM in ARM64 Virt machines.
> > >
> > > In the process of adding the TPM CRB SysBus device, we also went ahea=
d and
> > > cleaned up some of the existing TPM hardware code and fixed some bugs=
. We used
> > > the TPM TIS devices as a template for the TPM CRB devices and refacto=
red out
> > > common code. We moved the ACPI DSDT generation to the device in order=
 to handle
> > > dynamic base address requirements as well as reduce redundent code in=
 different
> > > machine ACPI generation. We also changed the tpm_crb device to use th=
e ISA bus
> > > instead of depending on the default system bus as the device only was=
 built for
> > > the PC configuration.
> > >
> > > Another change is that the TPM CRB registers are now mapped in the sa=
me way that
> > > the pflash ROM devices are mapped. It is a memory region whose writes=
 are
> > > trapped as MMIO accesses. This was needed because Apple Silicon does =
not decode
> > > LDP (AARCH64 load pair of registers) caused page faults. @agraf sugge=
sted that
> > > we do this to avoid having to do AARCH64 decoding in the HVF backend'=
s fault
> > > handler.
> > >
> > > Unfortunately, it seems like the LDP fault still happens on HVF but t=
he issue
> > > seems to be in the HVF backend which needs to be fixed in a separate =
patch.
> > >
> > > One last thing that's needed to get Windows 11 to recognize the TPM 2=
.0 device
> > > is for the OVMF firmware to setup the TPM device. Currently, OVMF for=
 ARM64 Virt
> > > only recognizes the TPM TIS device through a FDT entry. A workaround =
is to
> > > falsely identify the TPM CRB device as a TPM TIS device in the FDT no=
de but this
> > > causes issues for Linux. A proper fix would involve adding an ACPI de=
vice driver
> > > in OVMF.
> > >
> > > This has been tested on ARM64 with `tpm-crb-device` and on x86_64 wit=
h
> > > `tpm-crb`. Additional testing should be performed on other architectu=
res (RISCV
> > > and Loongarch for example) as well as migration cases.
> > >
> > > v5:
> > > - Fixed a typo in "tpm_crb: use a single read-as-mem/write-as-mmio ma=
pping"
> > > - Fixed ACPI tables not being created for pc CRB device
> > >
> > > v4:
> > > - Fixed broken test blobs
> > >
> > > v3:
> > > - Support backwards and forwards migration of existing tpm-crb device
> > > - Dropped patch which moved tpm-crb to ISA bus due to migration conce=
rns
> > > - Unified `tpm_sysbus_plug` handler for ARM and Loongarch
> > > - Added ACPI table tests for tpm-crb-device
> > > - Refactored TPM CRB tests to run on tpm-crb-device for ARM Virt
> > >
> > > v2:
> > > - Fixed an issue where VMstate restore from an older version failed d=
ue to name
> > >   collision of the memory block.
> > > - In the ACPI table generation for CRB devices, the check for TPM 2.0=
 backend is
> > >   moved to the device realize as CRB does not support TPM 1.0. It wil=
l error in
> > >   that case.
> > > - Dropped the patch to fix crash when PPI is enabled on TIS SysBus de=
vice since
> > >   a separate patch submitted by Stefan Berger disables such an option=
.
> > > - Fixed an issue where we default tpmEstablished=3D0 when it should b=
e 1.
> > > - In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 t=
o 1. This
> > >   shouldn't be an issue but we changed it back just in case.
> > > - Added a patch to migrate saved VMstate from an older version with t=
he regs
> > >   saved separately instead of as a RAM block.
> > >
> > > Joelle van Dyne (14):
> > >   tpm_crb: refactor common code
> > >   tpm_crb: CTRL_RSP_ADDR is 64-bits wide
> > >   tpm_ppi: refactor memory space initialization
> > >   tpm_crb: use a single read-as-mem/write-as-mmio mapping
> > >   tpm_crb: move ACPI table building to device interface
> > >   tpm-sysbus: add plug handler for TPM on SysBus
> > >   hw/arm/virt: connect TPM to platform bus
> > >   hw/loongarch/virt: connect TPM to platform bus
> > >   tpm_tis_sysbus: move DSDT AML generation to device
> > >   tests: acpi: prepare for TPM CRB tests
> > >   tpm_crb_sysbus: introduce TPM CRB SysBus device
> > >   tests: acpi: implement TPM CRB tests for ARM virt
> > >   tests: acpi: updated expected blobs for TPM CRB
> > >   tests: add TPM-CRB sysbus tests for aarch64
> >
> > The series looks good to me.
> > Have you checked there are no regressions with Windows HLK?
> I don't have any experience with Windows HLK. Is there any guide on
> running it with QEMU? Preferably with a prebuilt image? Or maybe
> someone in the mailing list can run it?
>

I haven't done it for a while. (it wasn't that hard, just a bit
tedious: install a Controller on a Windows Server VM, and set up a
target VM)

There is also AutoHCK, but I never managed to use it.
(https://github.com/HCK-CI/AutoHCK)

For the current results, they are summarized here:
https://github.com/stefanberger/libtpms/wiki/Testing-of-libtpms-Functionali=
ty

Stefan, do you have a working setup? I'll try to make one if it can help.


> >
> > thanks
> >
> > >
> > >  docs/specs/tpm.rst                        |   2 +
> > >  hw/tpm/tpm_crb.h                          |  79 ++++++
> > >  hw/tpm/tpm_ppi.h                          |  10 +-
> > >  include/hw/acpi/tpm.h                     |   3 +-
> > >  include/sysemu/tpm.h                      |   7 +
> > >  tests/qtest/tpm-tests.h                   |   2 +
> > >  tests/qtest/tpm-util.h                    |   4 +-
> > >  hw/acpi/aml-build.c                       |   7 +-
> > >  hw/arm/virt-acpi-build.c                  |  38 +--
> > >  hw/arm/virt.c                             |   8 +
> > >  hw/core/sysbus-fdt.c                      |   1 +
> > >  hw/i386/acpi-build.c                      |  16 +-
> > >  hw/loongarch/acpi-build.c                 |  38 +--
> > >  hw/loongarch/virt.c                       |   8 +
> > >  hw/riscv/virt.c                           |   1 +
> > >  hw/tpm/tpm-sysbus.c                       |  47 ++++
> > >  hw/tpm/tpm_crb.c                          | 302 ++++++--------------=
--
> > >  hw/tpm/tpm_crb_common.c                   | 262 +++++++++++++++++++
> > >  hw/tpm/tpm_crb_sysbus.c                   | 162 ++++++++++++
> > >  hw/tpm/tpm_ppi.c                          |   5 +-
> > >  hw/tpm/tpm_tis_isa.c                      |   5 +-
> > >  hw/tpm/tpm_tis_sysbus.c                   |  37 +++
> > >  tests/qtest/bios-tables-test.c            |  47 +++-
> > >  tests/qtest/tpm-crb-device-swtpm-test.c   |  72 ++++++
> > >  tests/qtest/tpm-crb-device-test.c         |  71 +++++
> > >  tests/qtest/tpm-crb-swtpm-test.c          |   2 +
> > >  tests/qtest/tpm-crb-test.c                | 121 +--------
> > >  tests/qtest/tpm-tests.c                   | 121 +++++++++
> > >  tests/qtest/tpm-tis-device-swtpm-test.c   |   2 +-
> > >  tests/qtest/tpm-tis-device-test.c         |   2 +-
> > >  tests/qtest/tpm-tis-i2c-test.c            |   3 +
> > >  tests/qtest/tpm-tis-swtpm-test.c          |   2 +-
> > >  tests/qtest/tpm-tis-test.c                |   2 +-
> > >  tests/qtest/tpm-util.c                    |  16 +-
> > >  hw/arm/Kconfig                            |   1 +
> > >  hw/loongarch/Kconfig                      |   2 +
> > >  hw/riscv/Kconfig                          |   1 +
> > >  hw/tpm/Kconfig                            |   5 +
> > >  hw/tpm/meson.build                        |   5 +
> > >  hw/tpm/trace-events                       |   2 +-
> > >  tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8355 bytes
> > >  tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
> > >  tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
> > >  tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
> > >  tests/qtest/meson.build                   |   4 +
> > >  45 files changed, 1057 insertions(+), 468 deletions(-)
> > >  create mode 100644 hw/tpm/tpm_crb.h
> > >  create mode 100644 hw/tpm/tpm-sysbus.c
> > >  create mode 100644 hw/tpm/tpm_crb_common.c
> > >  create mode 100644 hw/tpm/tpm_crb_sysbus.c
> > >  create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
> > >  create mode 100644 tests/qtest/tpm-crb-device-test.c
> > >  create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
> > >  create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
> > >  create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
> > >  create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2
> > >
> > > --
> > > 2.41.0
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--
Marc-Andr=C3=A9 Lureau

