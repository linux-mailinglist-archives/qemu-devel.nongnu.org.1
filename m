Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 387107793F5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUiW-0002hP-Kb; Fri, 11 Aug 2023 12:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUUiU-0002h4-0h
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:10:22 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qUUiR-0001XM-E9
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:10:21 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bc9d16c317so2028895a34.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691770218; x=1692375018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZvaG8KiYl6nZlzu99ijnOSdhZip4r736KeQzfSYteQ=;
 b=NxeJqsyXR3iNXPywloFhyLwF/t6EWkCAHW4WNI2cvPgOicPEeKFjDBWuLml3KBYzSB
 1uSctwFZHwEiQKQnNYxwftF12KU3l549y81X8jzgQgeH3SUPSzxCXrT/wPvM4kbtrVy6
 VL6oA7K9a+ubH2KbuqJ7LQT1SpiLKccRM9wPlvYAkNUDADEYlTXhD4TrnRNJ1uTSj0N3
 GjVgeO0UxdgNrPQIje8CFxYkHZLD758rJjkDzae5ZHBWKuwjeuvp3W8h9vxlexK8q1Xj
 RFpR2iNwk3SvJG8TzY3VftfFMh/Je8yKbrus8hhhEScF+JQ3w9Mj24zZ47Y0AGV7QGRS
 9mGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770218; x=1692375018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZvaG8KiYl6nZlzu99ijnOSdhZip4r736KeQzfSYteQ=;
 b=WUQFXe6dZ9N1bJonNwPWOBptrfnBZSmuvrdcCLCI29XdN5dLZUpx7vemk1KX/dUNE7
 zGA31wzeHqBLtIzsT6iLAhQK2Auoowjd72AGy+ES9c516J8FeKfHrgKGavwLZz6Q+6zA
 6M6JJ7DjCJBO13QmmuNkGeruqZ5yHSrr6oinms70nZN66uvrEfuu0zvVfILdy/Q2+2pl
 oeKuP03Z+HH9Ofh980LUc/nr/2KJQ5FetYifOja0WQVYYOM9q37ePFXdtSbXFgvGFy8h
 m4qjRtGmqSgdXW5ev2wh0v9zfSI7Ae+4sO05SC2YK88NeU3svyhjS8d+69k9dayhV+mt
 9lxw==
X-Gm-Message-State: AOJu0YyjyM8WrlVVh5xZ1QxQKSGjAyBCIK+mNOlBSs1sbvt0MKWdvyKb
 SmE/DZSeusdzspJEs6TN27ZI6KohsIR94e0Sld/N3CEHBKzxJiLG
X-Google-Smtp-Source: AGHT+IG4J7ATumQezNhg7ykMHD1QiDhP47tO67OemZkf8O55PZnFcnJJmyrYegdFo0I87gF/G+avkoCz7i4QbZBe5Qg=
X-Received: by 2002:a05:6358:6f09:b0:135:24ed:5108 with SMTP id
 r9-20020a0563586f0900b0013524ed5108mr2420237rwn.10.1691770217545; Fri, 11 Aug
 2023 09:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691509717.git.alistair.francis@wdc.com>
 <20230809131104.00006ea1@Huawei.com>
 <CAKmqyKMQjE4OSiicxv+G3wp_gqbwguWDTXWpQGve_RDThQPCTA@mail.gmail.com>
 <20230810111844.00000795@Huawei.com>
In-Reply-To: <20230810111844.00000795@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Aug 2023 12:09:51 -0400
Message-ID: <CAKmqyKMHwdpYdeET=riwcyQJ4_kSYSAtz+yQf10s=5jxp3rYHw@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Initial support for SPDM
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, 
 Alistair Francis <alistair.francis@wdc.com>, stefanb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 10, 2023 at 6:18=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 9 Aug 2023 12:45:35 -0400
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Wed, Aug 9, 2023 at 8:11=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue,  8 Aug 2023 11:51:21 -0400
> > > Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > > The Security Protocol and Data Model (SPDM) Specification defines
> > > > messages, data objects, and sequences for performing message exchan=
ges
> > > > over a variety of transport and physical media.
> > > >  - https://www.dmtf.org/sites/default/files/standards/documents/DSP=
0274_1.3.0.pdf
> > > >
> > > > This series is a very initial start on adding SPDM support to QEMU.
> > > >
> > > > This series uses libspdm [1] which is a reference implementation of
> > > > SPDM.
> > > >
> > > > The series starts by adding support for building and linking with
> > > > libspdm. It then progresses to handling SPDM requests in the NVMe d=
evice
> > > > over the PCIe DOE protocol.
> > > >
> > > > This is a very early attempt. The code quality is not super high, t=
he C
> > > > code hasn't been tested at all. This is really just an RFC to see i=
f
> > > > QEMU will accept linking with libspdm.
> > > >
> > > > So, the main question is, how do people feel about linking with lib=
spdm
> > > > to support SPDM?
> > > >
> > > > 1: https://github.com/DMTF/libspdm
> > >
> > > Hi Alastair,
> > >
> > > For reference / background we've had SPDM support for CXL emulated de=
vices
> > > in our staging tree for quite a while - it's not upstream because of
> > > exactly this question (+ no one had upstreaming this as a high priori=
ty
> > > as out of tree was fine for developing the kernel stack - it's well
> > > isolated in the code so there was little cost in rebasing this featur=
e)
> > > - and because libspdm is packaged by almost no one. There were proble=
ms
> > > building it with external crypto libraries etc.
> >
> > Thanks for pointing that out! I didn't realise there was existing QEMU
> > work. I'm glad others are looking into it
> >
> > Building with libspdm is difficult. Even this series does have weird
> > issues with openssl's crypto library. I have been working towards
> > packaging libspdm into buildroot, which has helped cleanup libspdm to
> > be more user friendly. libspdm 3.0 for example is now a lot easier to
> > build/package, but I expect to continue to improve things.
> >
> > There will need to be more improvements to libspdm before this series
> > could be merged.
> >
> > >
> > > Looks like you have had a lot more success than I ever did in getting=
 that
> > > to work. I tried a few times in the past and ended up sticking with
> > > the Avery design folks approach of a socket connection to spdm-emu
> > > Given you cc'd them I'm guessing you came across that work which is w=
hat
> > > we used for testing the kernel code Lukas is working on currently.
> > >
> > > https://lore.kernel.org/qemu-devel/20210629132520.00000d1f@Huawei.com=
/
> > >
> > > https://gitlab.com/jic23/qemu/-/commit/9864fb29979e55c1e37c20edf00907=
d9524036e8
> >
> > Thanks for that!
> >
> > In the past the QEMU community has refused to accept upstream changes
> > that expose QEMU internals via sockets. So I suspect linking with
> > libspdm will be a more upstreamable approach.
> >
> > On top of that requiring user to run an external socket application is =
clunky.
> >
> > >
> > > So I think we have 2 choices here.
> > > 1) Do what you have done and build the library as you are doing.
> > >  - Can fix a version - so don't care if they change the ABI etc other
> > >    than needing to move the version QEMU uses forwards when we need
> > >    to for new features.
> >
> > I agree
> >
> > >  - Cert management is going to add a lot of complexity into QEMU.
> > >    I've not looked at how much infrastructure we can reuse from elsew=
here.
> > >    Maybe this is a solved problem.
> >
> > Could we not just point to a cert when running QEMU?
>
> Yes, but it's going to be multiple cert trees per PCI device with all the
> association with particular SPDM instances etc. Not too bad I guess.
>
> >
> > >
> > > 2) Keep the SPDM emulation external.
> > >  - I'm not sure the socket protocol used by spdm-emu is fixed in ston=
e
> > >    as people tend to change both ends.
> > >  - Cert management and protocol options etc are already available.
> >
> > I suspect this will never get upstream though. My aim is to get
> > something upstream, so this is probably a no go (unless someone jumps
> > in and says this is ok).
>
> There is precedence with the TPM stuff using swtpm as the provider.
> https://qemu.readthedocs.io/en/latest/specs/tpm.html#the-qemu-tpm-emulato=
r-device

Good point. I forgot about the TPM.

I have CCed Stefan in case they have any comments

>
> >
> > >
> > > Personally I prefer the control option 1 gives us, even if it's a lot=
 more
> > > code.  Option 2 also rather limits our ability to do anything with
> > > the encrypted data as well. It's fine if the aim is just verification
> > > of simple flows, but if we need to inject particular measurements etc
> > > it doesn't really work.
> >
> > I like option 1 as well :)
> >
> > I don't envisage QEMU supporting extremely complex flows. I was more
> > aiming for a certificate and some measurement data and maybe a
> > manifest. My hope was basic SPDM support, not a complete test suite.
>
> I do envision complex flows. Need to be able to do TDISP for the
> confidential computing stuff (and other specs that aren't released yet).
>
> Most of the interest we've had in SPDM in general has been to get things
> up and running for that stuff.

Hmmm.... That might be trickier to get with an inbuilt library.

Let's wait for feedback on this RFC and then go from there

Alistair

>
> Jonathan
>
>
> >
> > Alistair
> >
> > >
> > > Jonathan
> > >
> > >
> > >
> > > >
> > > > Alistair Francis (3):
> > > >   subprojects: libspdm: Initial support
> > > >   hw: nvme: ctrl: Initial support for DOE
> > > >   hw: nvme: ctrl: Process SPDM requests
> > > >
> > > >  meson.build                   | 78 +++++++++++++++++++++++++++++++=
++++
> > > >  hw/nvme/nvme.h                |  4 ++
> > > >  include/hw/pci/pcie_doe.h     |  1 +
> > > >  hw/nvme/ctrl.c                | 35 ++++++++++++++++
> > > >  .gitmodules                   |  3 ++
> > > >  meson_options.txt             |  3 ++
> > > >  scripts/meson-buildoptions.sh |  3 ++
> > > >  subprojects/.gitignore        |  1 +
> > > >  subprojects/libspdm.wrap      |  5 +++
> > > >  9 files changed, 133 insertions(+)
> > > >  create mode 100644 subprojects/libspdm.wrap
> > > >
> > >
>

