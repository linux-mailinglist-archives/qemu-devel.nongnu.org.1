Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 099637529EB
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:37:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK0ES-0003qk-LN; Thu, 13 Jul 2023 13:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0EQ-0003qM-K5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:35:58 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0EO-0006hq-TD
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:35:58 -0400
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so826034a34.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689269755; x=1691861755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTeMAgU0XuAC/Cu1skzkq3o4FJktkgVmMdzNdC8aocg=;
 b=A++Z6NHDonyvU4qdQOzZHitg2Uxf4e4Vw+R+SjBl5wuzixvivLKhTtT4SEdEdW8/OE
 SFBGxLJRNNqTxqIxHbaXb/7xqR27fc22tFs8QaE58T37/PkK1Cg47+9FRSkk/h4fsPvo
 kpl7rEKSfHpWmNuE9UuT439gfsPMlKUlunrenKeiCEY5zwKg/ws4BWr0L8kGJGyxwNas
 h4DeT3XNJNqjaphvK87EtXMEP6pl4QKpy7cJYPDZIBblGu/Bc9WrFM3qvDp+R+viloxY
 3ICqBXjTTLPFvgWVzLVnb7vSWv6jC4VzWHBwRQrXhFPYNBoRjiDOgXgJMiZdGstmDYUi
 DjAA==
X-Gm-Message-State: ABy/qLaJNt2n/+GCqeopHe2Dv4baTj6CHYoIv5/ay12p5SbG/W/wwI7U
 Q7bKHov7e1awGZgJAmcrEwBmZDhobeM=
X-Google-Smtp-Source: APBJJlGTlysYVue/Vlg6JJUTlonLHQ0/ibdJcMOjWoRLWL039Vs5TZQ1HzaKSoRqjTsiE65aBHJrmw==
X-Received: by 2002:a9d:6b93:0:b0:6b7:1fcd:1e22 with SMTP id
 b19-20020a9d6b93000000b006b71fcd1e22mr1968903otq.29.1689269754990; 
 Thu, 13 Jul 2023 10:35:54 -0700 (PDT)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com.
 [209.85.160.42]) by smtp.gmail.com with ESMTPSA id
 y7-20020a0568301d8700b006b8e8884f2fsm3050305oti.51.2023.07.13.10.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 10:35:54 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-1b730eb017bso804739fac.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:35:54 -0700 (PDT)
X-Received: by 2002:a05:6871:9b:b0:1b7:4c74:e1af with SMTP id
 u27-20020a056871009b00b001b74c74e1afmr3381886oaa.59.1689269754089; Thu, 13
 Jul 2023 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <c58eea48-413b-d7e8-2a4e-f5b189536e7a@linux.ibm.com>
In-Reply-To: <c58eea48-413b-d7e8-2a4e-f5b189536e7a@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 13 Jul 2023 10:35:43 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCNKbSAcgYn9BaZRU_LRvqgo8QGPxH4m1+kNVQO=iqw_g@mail.gmail.com>
Message-ID: <CA+E+eSCNKbSAcgYn9BaZRU_LRvqgo8QGPxH4m1+kNVQO=iqw_g@mail.gmail.com>
Subject: Re: [PATCH 00/11] tpm: introduce TPM CRB SysBus device
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.50; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f50.google.com
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

On Thu, Jul 13, 2023 at 6:07=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 7/12/23 23:51, Joelle van Dyne wrote:
> > The impetus for this patch set is to get TPM 2.0 working on Windows 11 =
ARM64.
> > Windows' tpm.sys does not seem to work on a TPM TIS device (as verified=
 with
> > VMWare's implementation). However, the current TPM CRB device uses a fi=
xed
> > system bus address that is reserved for RAM in ARM64 Virt machines.
>
> Thanks a lot for this work. The last sentence seems to hint at the curren=
t issue
> with TPM CRB on ARM64 and seems to be the only way forward there. You may=
 want
> to reformulate it a bit because it's not clear how the 'however' related =
to
> CRB relates to TIS.
>
> >
> > In the process of adding the TPM CRB SysBus device, we also went ahead =
and
> > cleaned up some of the existing TPM hardware code and fixed some bugs. =
We used
>
> Please reorder bugs to the beginning of the series or submit in an extra =
patch set
> so we can backport them. Ideal would be description(s) for how to trigger=
 the bug(s).
>
> > the TPM TIS devices as a template for the TPM CRB devices and refactore=
d out
> > common code. We moved the ACPI DSDT generation to the device in order t=
o handle
> > dynamic base address requirements as well as reduce redundent code in d=
ifferent
> s/redundent/redundant
>
>
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
> > LDP caused page faults. @agraf suggested that we do this to avoid havin=
g to
>
> Afaik, LDP is an ARM assembly instruction that loads two 32bit or 64bit r=
egisters from
> consecutive addresses. May be worth mentioning for those wondering about =
it...
>
> > do AARCH64 decoding in the HVF fault handler.
>
> What is HVF?

Sorry, HVF is the QEMU backend for Apple's Hypervisor.framework which
runs on macOS including on Apple Silicon.

>
> Regards,
>     Stefan
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
> > Joelle van Dyne (11):
> >    tpm_crb: refactor common code
> >    tpm_crb: CTRL_RSP_ADDR is 64-bits wide
> >    tpm_ppi: refactor memory space initialization
> >    tpm_crb: use a single read-as-mem/write-as-mmio mapping
> >    tpm_crb: use the ISA bus
> >    tpm_crb: move ACPI table building to device interface
> >    hw/arm/virt: add plug handler for TPM on SysBus
> >    hw/loongarch/virt: add plug handler for TPM on SysBus
> >    tpm_tis_sysbus: fix crash when PPI is enabled
> >    tpm_tis_sysbus: move DSDT AML generation to device
> >    tpm_crb_sysbus: introduce TPM CRB SysBus device
> >
> >   docs/specs/tpm.rst          |   2 +
> >   hw/tpm/tpm_crb.h            |  74 +++++++++
> >   hw/tpm/tpm_ppi.h            |  10 +-
> >   include/hw/acpi/aml-build.h |   1 +
> >   include/hw/acpi/tpm.h       |   3 +-
> >   include/sysemu/tpm.h        |   3 +
> >   hw/acpi/aml-build.c         |   7 +-
> >   hw/arm/virt-acpi-build.c    |  38 +----
> >   hw/arm/virt.c               |  38 +++++
> >   hw/core/sysbus-fdt.c        |   1 +
> >   hw/i386/acpi-build.c        |  23 ---
> >   hw/loongarch/acpi-build.c   |  38 +----
> >   hw/loongarch/virt.c         |  38 +++++
> >   hw/riscv/virt.c             |   1 +
> >   hw/tpm/tpm_crb.c            | 307 ++++++++---------------------------=
-
> >   hw/tpm/tpm_crb_common.c     | 224 ++++++++++++++++++++++++++
> >   hw/tpm/tpm_crb_sysbus.c     | 178 +++++++++++++++++++++
> >   hw/tpm/tpm_ppi.c            |   5 +-
> >   hw/tpm/tpm_tis_isa.c        |   5 +-
> >   hw/tpm/tpm_tis_sysbus.c     |  43 +++++
> >   tests/qtest/tpm-crb-test.c  |   2 +-
> >   tests/qtest/tpm-util.c      |   2 +-
> >   hw/arm/Kconfig              |   1 +
> >   hw/riscv/Kconfig            |   1 +
> >   hw/tpm/Kconfig              |   7 +-
> >   hw/tpm/meson.build          |   3 +
> >   hw/tpm/trace-events         |   2 +-
> >   27 files changed, 703 insertions(+), 354 deletions(-)
> >   create mode 100644 hw/tpm/tpm_crb.h
> >   create mode 100644 hw/tpm/tpm_crb_common.c
> >   create mode 100644 hw/tpm/tpm_crb_sysbus.c
> >

