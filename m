Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D290E7F87E2
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 03:40:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6iZu-0008ND-Fw; Fri, 24 Nov 2023 21:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6iZs-0008Mi-1P
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 21:39:28 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r6iZq-0001JJ-1I
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 21:39:27 -0500
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-6cbb71c3020so2457607b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 18:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700879964; x=1701484764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gfmdm3JEeBqLD0AYzN19uEqXAyFceaQHLoNhXyefwRU=;
 b=ZGHmjiXhy5YdLg0tzzRswGm+jiA7Lr4i3SU2XpaZHQwvFpbgr3CgHtc431CAr0BZVK
 5KinAP+fJwsq2vwMOoqqIETQLjn8g1AJfnsBEbm5EHAJ5OsWY1ux6NPP7z0nDrWmJuPK
 8TXZQcVK95J3VYeHPFrwl51z2DsMMbz/kHjYZp226EnJrz2xbEZVsYbJULp8hmuLpM9m
 b2nE3k/Iwah4wYQndhSYXmjZH/aFhd5HtbZELz5yUo4d6yr+VtmsdT19X8nVsGqL4Gyh
 q6k9Bvnc0WM4uoOITsMn82kVe5Gq24mW7ZrRtVl95NPbOahoR+n+bMNIDhZbk0BxWd1h
 nYeQ==
X-Gm-Message-State: AOJu0Yz9EptpbfTOR0PnC1fWJluRYaBxsYv6eXKqzEt75/u3nWLJc5sj
 x9rBnpIusiR6ZArmu63gdH/Ag0JBuxc=
X-Google-Smtp-Source: AGHT+IF86ak2iUMCl8+Bexu/w8fGfQFLmD/sQ4VDOcokdhm2WwbOy7Wqn2SWxymvs6L3UFBzo1BTaQ==
X-Received: by 2002:a05:6a20:e118:b0:18c:26cc:c054 with SMTP id
 kr24-20020a056a20e11800b0018c26ccc054mr2491091pzb.7.1700879963656; 
 Fri, 24 Nov 2023 18:39:23 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com.
 [209.85.215.179]) by smtp.gmail.com with ESMTPSA id
 u14-20020aa7838e000000b006c8b14f3f0asm3454794pfm.117.2023.11.24.18.39.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 18:39:23 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-5be24d41bb8so1736742a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 18:39:23 -0800 (PST)
X-Received: by 2002:a17:90a:d185:b0:285:7e62:2822 with SMTP id
 fu5-20020a17090ad18500b002857e622822mr7754769pjb.16.1700879962991; Fri, 24
 Nov 2023 18:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-13-j@getutm.app>
 <CAJ+F1CKx_MfZapE_vcb_e-nk=CMC2e8FN0QrONb4mzda_KNKUQ@mail.gmail.com>
 <b1542ca5-18a6-44bd-a639-5765580bdc4d@linux.ibm.com>
 <718d155f-004b-417e-8cba-d79ca4475850@linux.ibm.com>
 <7412f9ab-6826-4e64-a583-a4dc8a921b70@linux.ibm.com>
 <CA+E+eSDnC9cnm2CfPxFkp=yYkcjuBDaLbxb6Uwz3A4nzwAM3CQ@mail.gmail.com>
 <d850ca40-d822-4e7d-b2ee-848f6d4208a7@linux.ibm.com>
 <CA+E+eSANrNo23jcRk=rwLY1E19FHBROz+ifdr6mhEQ88xE0cOw@mail.gmail.com>
 <a375b8d6-ae8e-45cd-816d-9b2737370b7b@linux.ibm.com>
In-Reply-To: <a375b8d6-ae8e-45cd-816d-9b2737370b7b@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 24 Nov 2023 18:39:12 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCgUU=-f8XJw8i5RPFG2JauOW-SePyhMZbgB5XRfTMqRw@mail.gmail.com>
Message-ID: <CA+E+eSCgUU=-f8XJw8i5RPFG2JauOW-SePyhMZbgB5XRfTMqRw@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f179.google.com
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

On Fri, Nov 24, 2023 at 8:26=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 11/24/23 11:21, Joelle van Dyne wrote:
> > On Fri, Nov 24, 2023 at 8:17=E2=80=AFAM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >>
> >>
> >> On 11/23/23 19:56, Joelle van Dyne wrote:
> >>> On Tue, Nov 14, 2023 at 4:12=E2=80=AFPM Stefan Berger <stefanb@linux.=
ibm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 11/14/23 16:05, Stefan Berger wrote:
> >>>>>
> >>>>>
> >>>>> On 11/14/23 13:03, Stefan Berger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 11/14/23 04:36, Marc-Andr=C3=A9 Lureau wrote:
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> On Tue, Nov 14, 2023 at 6:12=E2=80=AFAM Joelle van Dyne <j@getutm=
.app> wrote:
> >>>>>>>>
> >>>>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>>>>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>>>>>
> >>>>>>> nit: you also added tests for x86, could be a different patch?
> >>>>>>>
> >>>>>>> For arm, the test fails until next patch with:
> >>>>>>>
> >>>>>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest
> >>>>>>> unix:/tmp/qtest-991279.sock -qtest-log /dev/null -chardev
> >>>>>>> socket,path=3D/tmp/qtest-991279.qmp,id=3Dchar0 -mon
> >>>>>>> chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machine=
 virt
> >>>>>>> -accel tcg -nodefaults -nographic -drive
> >>>>>>> if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-aarch64-code.fd,read=
only=3Don
> >>>>>>> -drive if=3Dpflash,format=3Draw,file=3Dpc-bios/edk2-arm-vars.fd,s=
napshot=3Don
> >>>>>>> -cdrom tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.q=
cow2
> >>>>>>> -cpu cortex-a57 -chardev
> >>>>>>> socket,id=3Dchr,path=3D/tmp/qemu-test_acpi_virt_tcg_crb-device.KZ=
3GE2/sock
> >>>>>>> -tpmdev emulator,id=3Ddev,chardev=3Dchr -device tpm-crb-device,tp=
mdev=3Ddev
> >>>>>>> -accel qtest
> >>>>>>> Warning! zero length expected file
> >>>>>>> 'tests/data/acpi/virt/TPM2.crb-device.tpm2'
> >>>>>>> Warning! zero length expected file
> >>>>>>> 'tests/data/acpi/virt/DSDT.crb-device.tpm2'
> >>>>>>> acpi-test: Warning!  binary file mismatch. Actual
> >>>>>>> [aml:/tmp/aml-GO4ME2], Expected
> >>>>>>> [aml:tests/data/acpi/virt/TPM2.crb-device.tpm2].
> >>>>>>> See source file tests/qtest/bios-tables-test.c for instructions o=
n how
> >>>>>>> to update expected files.
> >>>>>>> acpi-test: Warning!  binary file mismatch. Actual
> >>>>>>> [aml:/tmp/aml-6N4ME2], Expected
> >>>>>>> [aml:tests/data/acpi/virt/DSDT.crb-device.tpm2].
> >>>>>>> See source file tests/qtest/bios-tables-test.c for instructions o=
n how
> >>>>>>> to update expected files.
> >>>>>>> to see ASL diff between mismatched files install IASL, rebuild QE=
MU
> >>>>>>> from scratch and re-run tests with V=3D1 environment variable set=
**
> >>>>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assert=
ion
> >>>>>>> failed: (all_tables_match)
> >>>>>>> not ok /aarch64/acpi/virt/tpm2-crb -
> >>>>>>> ERROR:../tests/qtest/bios-tables-test.c:538:test_acpi_asl: assert=
ion
> >>>>>>> failed: (all_tables_match)
> >>>>>>> Bail out!
> >>>>>>> qemu-system-aarch64: tpm-emulator: Could not cleanly shutdown the=
 TPM:
> >>>>>>> Resource temporarily unavailable
> >>>>>>> Unexpected error in qio_channel_socket_writev() at
> >>>>>>> ../io/channel-socket.c:622:
> >>>>>>> /home/elmarco/src/qemu/buildall/tests/qtest/bios-tables-test: Una=
ble
> >>>>>>> to write to socket: Bad file descriptor
> >>>>>>>
> >>>>>>
> >>>>>> Travis testing on s390x I see the following failures for this patc=
hset
> >>>>>> (search for 'ERROR'):
> >>>>>>
> >>>>>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/2672=
30363
> >>>>>>
> >>>>>> Summary of Failures:
> >>>>>>
> >>>>>> 134/320 qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-crb-device-te=
st
> >>>>>> ERROR           0.70s   killed by signal 6 SIGABRT
> >>>>>>
> >>>>>> 219/320 qemu:qtest+qtest-x86_64 / qtest-x86_64/tpm-crb-test
> >>>>>> ERROR           0.88s   killed by signal 6 SIGABRT
> >>>>>>
> >>>>>>
> >>>>>> Summary of Failures:
> >>>>>>
> >>>>>> 271/537 qemu:qtest+qtest-i386 / qtest-i386/tpm-crb-test
> >>>>>> ERROR           0.59s   killed by signal 6 SIGABRT
> >>>>>>
> >>>>>>
> >>>>>> My guess is it's an endianess issue on big endian machines due to
> >>>>>> reading from the ROM device where we lost the .endianess:
> >>>>>>
> >>>>>> +const MemoryRegionOps tpm_crb_memory_ops =3D {
> >>>>>> +    .read =3D tpm_crb_mmio_read,
> >>>>>> +    .write =3D tpm_crb_mmio_write,
> >>>>>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >>>>>> +    .valid =3D {
> >>>>>> +        .min_access_size =3D 1,
> >>>>>> +        .max_access_size =3D 4,
> >>>>>> +    },
> >>>>>> +};
> >>>>>>
> >>>>>
> >>>>> I think we need a 2nd set of registers to support the endianess
> >>>>> conversion. It's not exactly nice, though. Basically the saved_regs
> >>>>> could be used for this directly, even though I did not do that but
> >>>>> introduced n_regs:
> >>>>> https://github.com/stefanberger/qemu-tpm/commit/90f6b21c0dd93dbb13d=
9e80a628f5b631fd07d91
> >>>>>
> >>>>> This patch allows the tests on s390x to run farther but the executi=
on of
> >>>>> the command doesn't seem to work maybe due to command data that wer=
e
> >>>>> also written in wrong endianess. I don't know. I would have to get
> >>>>> access to a big endian / s390 machine to be able to fix it.
> >>>>>
> >>>>>
> >>>>
> >>>> The latest version now passes on Travis s390x:
> >>>> https://app.travis-ci.com/github/stefanberger/qemu-tpm/builds/267245=
220
> >>>>
> >>>
> >>> Are the tests failing on S390X due to the added code or are they
> >>> failing because previously it was untested? I don't think the origina=
l
> >>> code took account of endianness and that should be fixed, but feels
> >>> like it should be in a separate patch set?
> >>
> >> They are failing because something like the topmost one or two patches
> >> as in this branch here are missing for a big endian host:
> >>
> >> https://github.com/stefanberger/qemu-tpm/tree/joelle.v5%2B2nd_register=
s
> >
> > Right, but is this issue new due to the patchset? i.e. if just the
>
> Yes, it is due to this patchset. The reason is that CRB switched to a
> ROMD interface where the fact that the MMIO registers are little endian
> got lost for existing x86_64 support.
>
> > tests were added without the other patches, would they still fail? If
> > so, I think the fixes should be in another patchset while we disable
> > them in this patchset.

I see, how do you want to best integrate your changes? Do you want me
to squash your changes into the patch that introduces the code? Or do
you want them to be separate commits?

