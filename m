Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCC7F78D1
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:22:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Yvs-00023G-8a; Fri, 24 Nov 2023 11:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6Yvp-00021T-C5
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:21:29 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6Yvn-0003EK-Ax
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:21:29 -0500
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1cf8e569c35so12596605ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 08:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700842885; x=1701447685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4ri4AoQu5BgoiWk3AZuekgIDlX6G8kc/ultIcssWoo=;
 b=CiO3pBEf1bT5u6i3TRs5lduQpqQB/Df9FDgIiXve06N+LoPOXCtz0SpxDJ/4JoVRJP
 1QTbzBi1KmNUTtqtUg2+wcbjDd+6F+TJhChT3SU1DMBG0hoaDWvrvuETamDwDCMUHuMP
 uw7AA89F9eHj+dBW3VdROagcjC0iIHDwHtJy6g9JAO1BIcpBp59JF86djMVEFNIwnPfW
 dIAvyB220FkbZPNT54+d3TQ/+Fh6hkgreNIBMVJ3h6nODnHgP+bE0pPbphoLL0c94JER
 y/0VPrtVlDH+383T65N9kWwgtzTYXJMX7M85B02KVEYB8WlYMYcNRQak2wQ94YVsb5Tc
 3nhA==
X-Gm-Message-State: AOJu0YynrAgHZyOpHO1UYobXqRYwYyK5Ut5JX411oeuiBjP2l7TRCddG
 5TmMxCR1V+t/5t2rXaD5TAFPdB9r278=
X-Google-Smtp-Source: AGHT+IEEaXiz53RVD3Waufg23sVJ7kyWC2V88PxYRHI9HoINpI+sK7c9VSAMFjoyDTF6BqFSe/Sa+Q==
X-Received: by 2002:a17:903:228c:b0:1cc:ec21:9a64 with SMTP id
 b12-20020a170903228c00b001ccec219a64mr3400716plh.17.1700842885094; 
 Fri, 24 Nov 2023 08:21:25 -0800 (PST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com.
 [209.85.215.173]) by smtp.gmail.com with ESMTPSA id
 a5-20020a170902ee8500b001cf8a4882absm3379376pld.196.2023.11.24.08.21.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 08:21:25 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-5c19a328797so1482695a12.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 08:21:25 -0800 (PST)
X-Received: by 2002:a17:90a:e7cf:b0:285:73ed:b84f with SMTP id
 kb15-20020a17090ae7cf00b0028573edb84fmr3459358pjb.5.1700842884720; Fri, 24
 Nov 2023 08:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
 <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
 <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
 <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
 <CA+E+eSDnC9cnm2CfPxFkp=yYkcjuBDaLbxb6Uwz3A4nzwAM3CQ@mail.gmail.com>
 <d850ca40-d822-4e7d-b2ee-848f6d4208a7@linux.ibm.com>
In-Reply-To: <d850ca40-d822-4e7d-b2ee-848f6d4208a7@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 24 Nov 2023 08:21:13 -0800
X-Gmail-Original-Message-ID: <CA+E+eSANrNo23jcRk=rwLY1E19FHBROz+ifdr6mhEQ88xE0cOw@mail.gmail.com>
Message-ID: <CA+E+eSANrNo23jcRk=rwLY1E19FHBROz+ifdr6mhEQ88xE0cOw@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
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

On Fri, Nov 24, 2023 at 8:17=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 11/23/23 19:56, Joelle van Dyne wrote:
> > On Tue, Nov 14, 2023 at 4:12=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >>
> >>
> >> On 11/14/23 16:05, Stefan Berger wrote:
> >>>
> >>>
> >>> On 11/14/23 13:03, Stefan Berger wrote:
> >>>>
> >>>>
> >>>> On 11/14/23 04:36, Marc-Andr=C3=A9 Lureau wrote:
> >>>>> Hi
> >>>>>
> >>>>> On Tue, Nov 14, 2023 at 6:12=E2=80=AFAM Joelle van Dyne <j@getutm.a=
pp> wrote:
> >>>>>>
> >>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>>>
> >>>>> nit: you also added tests for x86, could be a different patch?
> >>>>>
> >>>>> For arm, the test fails until next patch with:
> >>>>>
> >>>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest
> >>>>> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
> >>>>> socket,path=3D/tmp/qtest-991279.qmp,id=3Dchar0 -mon
> >>>>> chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine v=
irt
> >>>>> -accel tcg -nodefaults -nographic -drive
> >>>>> if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-aarch64-code.fd,readon=
ly=3Don
> >>>>> -drive if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,sna=
pshot=3Don
> >>>>> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qco=
w2
> >>>>> -cpu cortex-a57 -chardev
> >>>>> socket,id=3Dchr,path=3D/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ3G=
E2/sock
> >>>>> -tpmdev emulator,id=3Ddev,chardev=3Dchr -device tpm-crb-device,tpmd=
ev=3Ddev
> >>>>> -accel qtest
> >>>>> Warning! zero length expected file
> >>>>> 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
> >>>>> Warning! zero length expected file
> >>>>> 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
> >>>>> acpi-test: Warning!  binary file mismatch. Actual
> >>>>> [aml:/tmp/aml-GO4ME2], Expected
> >>>>> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
> >>>>> See source file tests/qtest/bios-tables-test.c for instructions on =
how
> >>>>> to update expected files.
> >>>>> acpi-test: Warning!  binary file mismatch. Actual
> >>>>> [aml:/tmp/aml-6N4ME2], Expected
> >>>>> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
> >>>>> See source file tests/qtest/bios-tables-test.c for instructions on =
how
> >>>>> to update expected files.
> >>>>> to see ASL diff between mismatched files install IASL, rebuild QEMU
> >>>>> from scratch and re-run tests with V=3D1 environment variable set**
> >>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertio=
n
> >>>>> failed: (all_tables_match)
> >>>>> not ok /aarch64/acpi/virt/tpm2-crb -
> >>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assertio=
n
> >>>>> failed: (all_tables_match)
> >>>>> Bail out!
> >>>>> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the T=
PM:
> >>>>> Resource temporarily unavailable
> >>>>> Unexpected error in qio_channel_socket_writev() at
> >>>>> ../io/channel-socket.c:622:
> >>>>> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Unabl=
e
> >>>>> to write to socket: Bad file descriptor
> >>>>>
> >>>>
> >>>> Travis testing on s390x I see the following failures for this patchs=
et
> >>>> (search for 'ERROR'):
> >>>>
> >>>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267230=
363
> >>>>
> >>>> Summary of Failures:
> >>>>
> >>>> 134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-test
> >>>> ERROR           0.70s   killed by signal 6 SIGABRT
> >>>>
> >>>> 219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test
> >>>> ERROR           0.88s   killed by signal 6 SIGABRT
> >>>>
> >>>>
> >>>> Summary of Failures:
> >>>>
> >>>> 271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test
> >>>> ERROR           0.59s   killed by signal 6 SIGABRT
> >>>>
> >>>>
> >>>> My guess is it's an endianess issue on big endian machines due to
> >>>> reading from the ROM device where we lost the .endianess:
> >>>>
> >>>> +const MemoryRegionOps tpm_crb_memory_ops =3D {
> >>>> +    .read =3D tpm_crb_mmio_read,
> >>>> +    .write =3D tpm_crb_mmio_write,
> >>>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >>>> +    .valid =3D {
> >>>> +        .min_access_size =3D 1,
> >>>> +        .max_access_size =3D 4,
> >>>> +    },
> >>>> +};
> >>>>
> >>>
> >>> I think we need a 2nd set of registers to support the endianess
> >>> conversion. It's not exactly nice, though. Basically the saved_regs
> >>> could be used for this directly, even though I did not do that but
> >>> introduced n_regs:
> >>> https://github.com/stefanberger/qemu-tpm/commit/90f6b21c0dd93dbb13d9e=
80a628f5b631fd07d91
> >>>
> >>> This patch allows the tests on s390x to run farther but the execution=
 of
> >>> the command doesn't seem to work maybe due to command data that were
> >>> also written in wrong endianess. I don't know. I would have to get
> >>> access to a big endian / s390 machine to be able to fix it.
> >>>
> >>>
> >>
> >> The latest version now passes on Travis s390x:
> >> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/26724522=
0
> >>
> >
> > Are the tests failing on S390X due to the added code or are they
> > failing because previously it was untested? I don't think the original
> > code took account of endianness and that should be fixed, but feels
> > like it should be in a separate patch set?
>
> They are failing because something like the topmost one or two patches
> as in this branch here are missing for a big endian host:
>
> https://github.com/stefanberger/qemu-tpm/tree/joelle.v5%2B2nd_registers

Right, but is this issue new due to the patchset? i.e. if just the
tests were added without the other patches, would they still fail? If
so, I think the fixes should be in another patchset while we disable
them in this patchset.

