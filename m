Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0087EAD2B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:39:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2psS-00018f-V1; Tue, 14 Nov 2023 04:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2psR-00018C-C9
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:38:35 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2psP-0007xA-EH
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:38:35 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cba6e8e65so31531621cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699954712; x=1700559512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyPycBvqaj7209NicDfmYhp5/emcCPiyTYtIel/tW6I=;
 b=Ntc9qBfyZp1pPo2wJXpas8nmdVAHnYnfBvm/caCLrs2MChIFO1ezSiqWTS4VEu2Amc
 uZKSuR4hvh3D883MhN7aCQAISspmFA+MgYobs2y5T4bNi675+ra/JxBxVQSSvysoR8YY
 w3ZwTNhmSqLU6hovBwxVThAVZv78KMShhGIuFRzoCVViEsUMkLdtaMRrp2sJ4QksDnQv
 d80VRb1lLCVYUIBI8y3Y2EDLm+Mt5cwYZxMJousHypCSikWpxlom+9Ht8UrFB+WOwyw5
 ZlRWZJSXj+dmkt9jJixCHE3KPXEYP9v8KHm0xO3DERG66oBu1TWS5eHSRdUfOKqwD3Qa
 CXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699954712; x=1700559512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyPycBvqaj7209NicDfmYhp5/emcCPiyTYtIel/tW6I=;
 b=Ezeiyt4xdOm+scA00wwajyKYZZKaKjX8NX04//KVhu3Uxd2ku57e9G/yozJ9sA9yA/
 2amH/obmRDqxaWn3FxENLRswd1/cf1+SLK8f8qf9JO8LaicMmbLnCDT8NtkHdQ5+Ii4r
 VGUoXOdvg/iOBQWmTL+zZU/R4bJWuNQEdfO1Z4NJ2DjnwGd13/VMGRkukzEbhCdKqQzM
 Rz31j2yu/cRHvIxhFYwqFbo3Jqf6sllLyldxatMBIMVcaEZrJj85/hKG9weXfZTnib6q
 Jt13ow8j5oO8XWAqGgjQ15JoHyjAzrF+9zZuAY/j7hS2nazsGizTial04mPG4ld/jxE6
 CPKg==
X-Gm-Message-State: AOJu0YxWVonu976dtNXWN4Lcgmdg0etlckdi0rzk50wnV+kndY/HUJIi
 wXRxFs5oRGojymhzLBmkUDo9TJD4h5C0TYCDU4wIyu1iUeM=
X-Google-Smtp-Source: AGHT+IHwlbTJcAey9uhdFPyod7MxGNQ2FW0avlG7grUuKdthzCMvjDJvf3RTYgdOg0FxzyzKgdcfRaYXA6mqL2cLtWA=
X-Received: by 2002:a05:622a:38d:b0:412:bf83:e759 with SMTP id
 j13-20020a05622a038d00b00412bf83e759mr1799302qtx.42.1699954712148; Tue, 14
 Nov 2023 01:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 13:38:21 +0400
Message-ID: <CAJ+F1CJunC52JX=YOiycHDeTVxVRwjuV9veQZ1QaN1=JCuo7nQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] tpm: introduce TPM CRB SysBus device
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

On Tue, Nov 14, 2023 at 6:10=E2=80=AFAM Joelle van Dyne <j@getutm.app> wrot=
e:
>
> The impetus for this patch set is to get TPM 2.0 working on Windows 11 AR=
M64.
> Windows' tpm.sys does not seem to work on a TPM TIS device (as verified w=
ith
> VMWare's implementation). However, the current TPM CRB device uses a fixe=
d
> system bus address that is reserved for RAM in ARM64 Virt machines.
>
> In the process of adding the TPM CRB SysBus device, we also went ahead an=
d
> cleaned up some of the existing TPM hardware code and fixed some bugs. We=
 used
> the TPM TIS devices as a template for the TPM CRB devices and refactored =
out
> common code. We moved the ACPI DSDT generation to the device in order to =
handle
> dynamic base address requirements as well as reduce redundent code in dif=
ferent
> machine ACPI generation. We also changed the tpm_crb device to use the IS=
A bus
> instead of depending on the default system bus as the device only was bui=
lt for
> the PC configuration.
>
> Another change is that the TPM CRB registers are now mapped in the same w=
ay that
> the pflash ROM devices are mapped. It is a memory region whose writes are
> trapped as MMIO accesses. This was needed because Apple Silicon does not =
decode
> LDP (AARCH64 load pair of registers) caused page faults. @agraf suggested=
 that
> we do this to avoid having to do AARCH64 decoding in the HVF backend's fa=
ult
> handler.
>
> Unfortunately, it seems like the LDP fault still happens on HVF but the i=
ssue
> seems to be in the HVF backend which needs to be fixed in a separate patc=
h.
>
> One last thing that's needed to get Windows 11 to recognize the TPM 2.0 d=
evice
> is for the OVMF firmware to setup the TPM device. Currently, OVMF for ARM=
64 Virt
> only recognizes the TPM TIS device through a FDT entry. A workaround is t=
o
> falsely identify the TPM CRB device as a TPM TIS device in the FDT node b=
ut this
> causes issues for Linux. A proper fix would involve adding an ACPI device=
 driver
> in OVMF.
>
> This has been tested on ARM64 with `tpm-crb-device` and on x86_64 with
> `tpm-crb`. Additional testing should be performed on other architectures =
(RISCV
> and Loongarch for example) as well as migration cases.
>
> v5:
> - Fixed a typo in "tpm_crb: use a single read-as-mem/write-as-mmio mappin=
g"
> - Fixed ACPI tables not being created for pc CRB device
>
> v4:
> - Fixed broken test blobs
>
> v3:
> - Support backwards and forwards migration of existing tpm-crb device
> - Dropped patch which moved tpm-crb to ISA bus due to migration concerns
> - Unified `tpm_sysbus_plug` handler for ARM and Loongarch
> - Added ACPI table tests for tpm-crb-device
> - Refactored TPM CRB tests to run on tpm-crb-device for ARM Virt
>
> v2:
> - Fixed an issue where VMstate restore from an older version failed due t=
o name
>   collision of the memory block.
> - In the ACPI table generation for CRB devices, the check for TPM 2.0 bac=
kend is
>   moved to the device realize as CRB does not support TPM 1.0. It will er=
ror in
>   that case.
> - Dropped the patch to fix crash when PPI is enabled on TIS SysBus device=
 since
>   a separate patch submitted by Stefan Berger disables such an option.
> - Fixed an issue where we default tpmEstablished=3D0 when it should be 1.
> - In TPM CRB SysBus's ACPI entry, we accidently changed _UID from 0 to 1.=
 This
>   shouldn't be an issue but we changed it back just in case.
> - Added a patch to migrate saved VMstate from an older version with the r=
egs
>   saved separately instead of as a RAM block.
>
> Joelle van Dyne (14):
>   tpm_crb: refactor common code
>   tpm_crb: CTRL_RSP_ADDR is 64-bits wide
>   tpm_ppi: refactor memory space initialization
>   tpm_crb: use a single read-as-mem/write-as-mmio mapping
>   tpm_crb: move ACPI table building to device interface
>   tpm-sysbus: add plug handler for TPM on SysBus
>   hw/arm/virt: connect TPM to platform bus
>   hw/loongarch/virt: connect TPM to platform bus
>   tpm_tis_sysbus: move DSDT AML generation to device
>   tests: acpi: prepare for TPM CRB tests
>   tpm_crb_sysbus: introduce TPM CRB SysBus device
>   tests: acpi: implement TPM CRB tests for ARM virt
>   tests: acpi: updated expected blobs for TPM CRB
>   tests: add TPM-CRB sysbus tests for aarch64

The series looks good to me.
Have you checked there are no regressions with Windows HLK?

thanks

>
>  docs/specs/tpm.rst                        |   2 +
>  hw/tpm/tpm_crb.h                          |  79 ++++++
>  hw/tpm/tpm_ppi.h                          |  10 +-
>  include/hw/acpi/tpm.h                     |   3 +-
>  include/sysemu/tpm.h                      |   7 +
>  tests/qtest/tpm-tests.h                   |   2 +
>  tests/qtest/tpm-util.h                    |   4 +-
>  hw/acpi/aml-build.c                       |   7 +-
>  hw/arm/virt-acpi-build.c                  |  38 +--
>  hw/arm/virt.c                             |   8 +
>  hw/core/sysbus-fdt.c                      |   1 +
>  hw/i386/acpi-build.c                      |  16 +-
>  hw/loongarch/acpi-build.c                 |  38 +--
>  hw/loongarch/virt.c                       |   8 +
>  hw/riscv/virt.c                           |   1 +
>  hw/tpm/tpm-sysbus.c                       |  47 ++++
>  hw/tpm/tpm_crb.c                          | 302 ++++++----------------
>  hw/tpm/tpm_crb_common.c                   | 262 +++++++++++++++++++
>  hw/tpm/tpm_crb_sysbus.c                   | 162 ++++++++++++
>  hw/tpm/tpm_ppi.c                          |   5 +-
>  hw/tpm/tpm_tis_isa.c                      |   5 +-
>  hw/tpm/tpm_tis_sysbus.c                   |  37 +++
>  tests/qtest/bios-tables-test.c            |  47 +++-
>  tests/qtest/tpm-crb-device-swtpm-test.c   |  72 ++++++
>  tests/qtest/tpm-crb-device-test.c         |  71 +++++
>  tests/qtest/tpm-crb-swtpm-test.c          |   2 +
>  tests/qtest/tpm-crb-test.c                | 121 +--------
>  tests/qtest/tpm-tests.c                   | 121 +++++++++
>  tests/qtest/tpm-tis-device-swtpm-test.c   |   2 +-
>  tests/qtest/tpm-tis-device-test.c         |   2 +-
>  tests/qtest/tpm-tis-i2c-test.c            |   3 +
>  tests/qtest/tpm-tis-swtpm-test.c          |   2 +-
>  tests/qtest/tpm-tis-test.c                |   2 +-
>  tests/qtest/tpm-util.c                    |  16 +-
>  hw/arm/Kconfig                            |   1 +
>  hw/loongarch/Kconfig                      |   2 +
>  hw/riscv/Kconfig                          |   1 +
>  hw/tpm/Kconfig                            |   5 +
>  hw/tpm/meson.build                        |   5 +
>  hw/tpm/trace-events                       |   2 +-
>  tests/data/acpi/q35/DSDT.crb.tpm2         | Bin 0 -> 8355 bytes
>  tests/data/acpi/q35/TPM2.crb.tpm2         | Bin 0 -> 76 bytes
>  tests/data/acpi/virt/DSDT.crb-device.tpm2 | Bin 0 -> 5276 bytes
>  tests/data/acpi/virt/TPM2.crb-device.tpm2 | Bin 0 -> 76 bytes
>  tests/qtest/meson.build                   |   4 +
>  45 files changed, 1057 insertions(+), 468 deletions(-)
>  create mode 100644 hw/tpm/tpm_crb.h
>  create mode 100644 hw/tpm/tpm-sysbus.c
>  create mode 100644 hw/tpm/tpm_crb_common.c
>  create mode 100644 hw/tpm/tpm_crb_sysbus.c
>  create mode 100644 tests/qtest/tpm-crb-device-swtpm-test.c
>  create mode 100644 tests/qtest/tpm-crb-device-test.c
>  create mode 100644 tests/data/acpi/q35/DSDT.crb.tpm2
>  create mode 100644 tests/data/acpi/q35/TPM2.crb.tpm2
>  create mode 100644 tests/data/acpi/virt/DSDT.crb-device.tpm2
>  create mode 100644 tests/data/acpi/virt/TPM2.crb-device.tpm2
>
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

