Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5607F69FD
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 01:57:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6KUp-0007CG-02; Thu, 23 Nov 2023 19:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6KUn-0007C5-Tl
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 19:56:38 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6KUm-0006uR-0g
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 19:56:37 -0500
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso10712085ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 16:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700787393; x=1701392193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQGxeP2xohEykkMhwakjLcH4oiee3XYNnokcNout0Y4=;
 b=tBJQo0b7dWWALuMM8KAAsGHQEOf7Amx3lY8eVds4z0KYyA2jHe9jgkbd8ptV8n4MWe
 UKyXOt/4We4oeW5wCLUNk++REB9MKdCb5oTuTgl3USsBQIqO0ZmuX5I092Ge8/HK1Due
 f7PX3HC2wYvp3kdzOKE6UUbjNHxBf2bIosM3uijETM6F+meI1isYNIKj7Q1CBzmeg5zp
 9kTy0dwbvrA9f8whGt7RpqI400nz0tDq+5IAf3q7XmAuy//709V80OWUEoxpPNvmbQz+
 Sqfj8dIXfHx8AUlfv5sEutCtRAEdfmo/ma7H04Gvel07gFS9MM5yLmz1zGPcDXxu7aMc
 VJOA==
X-Gm-Message-State: AOJu0YxAylDEjnCrF3eUR1yZxFw3YvFFxogka+1M9Ivq7hXWVfyCQjQL
 UYzuFBpmJJy5IfOl2btnp3IR7+xUQ10=
X-Google-Smtp-Source: AGHT+IEJtoLah2vsymQTJTnPAExEa3sKN7nmS4ThHyF/+CkcN8B8rEnUIwh3iBF5aCRvnWYweChaLQ==
X-Received: by 2002:a17:902:cecf:b0:1cf:a105:6a0b with SMTP id
 d15-20020a170902cecf00b001cfa1056a0bmr1084149plg.62.1700787393158; 
 Thu, 23 Nov 2023 16:56:33 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com.
 [209.85.214.177]) by smtp.gmail.com with ESMTPSA id
 ji12-20020a170903324c00b001cf53cd1508sm1971859plb.67.2023.11.23.16.56.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 16:56:32 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso10711985ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 16:56:32 -0800 (PST)
X-Received: by 2002:a17:90b:4b07:b0:281:5550:ce3c with SMTP id
 lx7-20020a17090b4b0700b002815550ce3cmr1102775pjb.38.1700787392033; Thu, 23
 Nov 2023 16:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
 <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
 <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
 <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
In-Reply-To: <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 23 Nov 2023 16:56:21 -0800
X-Gmail-Original-Message-ID: <CA+E+eSDnC9cnm2CfPxFkp=yYkcjuBDaLbxb6Uwz3A4nzwAM3CQ@mail.gmail.com>
Message-ID: <CA+E+eSDnC9cnm2CfPxFkp=yYkcjuBDaLbxb6Uwz3A4nzwAM3CQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.178; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f178.google.com
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

On Tue, Nov 14, 2023 at 4:12=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 11/14/23 16:05, Stefan Berger wrote:
> >
> >
> > On 11/14/23 13:03, Stefan Berger wrote:
> >>
> >>
> >> On 11/14/23 04:36, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi
> >>>
> >>> On Tue, Nov 14, 2023 at 6:12=E2=80=AFAM Joelle van Dyne <j@getutm.app=
> wrote:
> >>>>
> >>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>
> >>> nit: you also added tests for x86, could be a different patch?
> >>>
> >>> For arm, the test fails until next patch with:
> >>>
> >>> # starting QEMU: exec ./qemu-system-aarch64 -qtest
> >>> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
> >>> socket,path=3D/tmp/qtest-991279.qmp,id=3Dchar0 -mon
> >>> chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine vir=
t
> >>> -accel tcg -nodefaults -nographic -drive
> >>> if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-aarch64-code.fd,readonly=
=3Don
> >>> -drive if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,snaps=
hot=3Don
> >>> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
> >>> -cpu cortex-a57 -chardev
> >>> socket,id=3Dchr,path=3D/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3GE2=
/sock
> >>> -tpmdev emulator,id=3Ddev,chardev=3Dchr -device tpm-crb-device,tpmdev=
=3Ddev
> >>> -accel qtest
> >>> Warning! zero length expected file
> >>> 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
> >>> Warning! zero length expected file
> >>> 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
> >>> acpi-test: Warning!  binary file mismatch. Actual
> >>> [aml:/tmp/aml-GO4ME2], Expected
> >>> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
> >>> See source file tests/qtest/bios-tables-test.c for instructions on ho=
w
> >>> to update expected files.
> >>> acpi-test: Warning!  binary file mismatch. Actual
> >>> [aml:/tmp/aml-6N4ME2], Expected
> >>> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
> >>> See source file tests/qtest/bios-tables-test.c for instructions on ho=
w
> >>> to update expected files.
> >>> to see ASL diff between mismatched files install IASL, rebuild QEMU
> >>> from scratch and re-run tests with V=3D1 environment variable set**
> >>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
> >>> failed: (all_tables_match)
> >>> not ok /aarch64/acpi/virt/tpm2-crb -
> >>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertion
> >>> failed: (all_tables_match)
> >>> Bail out!
> >>> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the TPM=
:
> >>> Resource temporarily unavailable
> >>> Unexpected error in qio_channel_socket_writev() at
> >>> ../io/channel-socket.c:622:
> >>> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unable
> >>> to write to socket: Bad file descriptor
> >>>
> >>
> >> Travis testing on s390x I see the following failures for this patchset
> >> (search for 'ERROR'):
> >>
> >> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/26723036=
3
> >>
> >> Summary of Failures:
> >>
> >> 134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-test
> >> ERROR           0.70s   killed by signal 6 SIGABRT
> >>
> >> 219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test
> >> ERROR           0.88s   killed by signal 6 SIGABRT
> >>
> >>
> >> Summary of Failures:
> >>
> >> 271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test
> >> ERROR           0.59s   killed by signal 6 SIGABRT
> >>
> >>
> >> My guess is it's an endianess issue on big endian machines due to
> >> reading from the ROM device where we lost the .endianess:
> >>
> >> +const MemoryRegionOps tpm_crb_memory_ops =3D {
> >> +    .read =3D tpm_crb_mmio_read,
> >> +    .write =3D tpm_crb_mmio_write,
> >> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >> +    .valid =3D {
> >> +        .min_access_size =3D 1,
> >> +        .max_access_size =3D 4,
> >> +    },
> >> +};
> >>
> >
> > I think we need a 2nd set of registers to support the endianess
> > conversion. It's not exactly nice, though. Basically the saved_regs
> > could be used for this directly, even though I did not do that but
> > introduced n_regs:
> > https://github.com/stefanberger/qemu-tpm/commit/90f6b21c0dd93dbb13d9e80=
a628f5b631fd07d91
> >
> > This patch allows the tests on s390x to run farther but the execution o=
f
> > the command doesn't seem to work maybe due to command data that were
> > also written in wrong endianess. I don't know. I would have to get
> > access to a big endian / s390 machine to be able to fix it.
> >
> >
>
> The latest version now passes on Travis s390x:
> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267245220
>

Are the tests failing on S390X due to the added code or are they
failing because previously it was untested? I don't think the original
code took account of endianness and that should be fixed, but feels
like it should be in a separate patch set?

