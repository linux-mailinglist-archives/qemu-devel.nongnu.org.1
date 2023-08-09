Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0677655B
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmK1-0000bq-HL; Wed, 09 Aug 2023 12:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTmJz-0000bI-CI
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:46:07 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTmJv-0001Mg-EE
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:46:07 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-44768e056e1so10531137.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691599562; x=1692204362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX/jFGC4ZS3jQr1CLcS1b53sMfmgVe5qtxLwlaq68V8=;
 b=HzWr7oKLV++eRUjZ2HvmQSaoOLROPApwhp16xFe52NtqveSrKPZ2Q1VXe+OI4BFSJ0
 k5CHJ+5ow3vgskYDLZTJ0qbtMHcmDOFIT3toSomr4QhYdTeiiKUBiqWr9R8KudBHuHZ6
 m9oXL2mg6D78NCLemvdsyNB9cSBVnc34X9pgwDNJn5rebm7JqAwRXFaE5COJEP5Fg6EE
 yISa8alCdyiSJJYTc908MSNLOBFpMO46WEIjCOj71rj2hlJkDvPygqaEA1RcFo0Ot3Z1
 /fTnGd0Gd2uxL5+3qzHc5WY6Xfy2wFdqxbdFIgPiyDWl8IH3D/QycrifBjdAmjT95Fc2
 Jgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691599562; x=1692204362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX/jFGC4ZS3jQr1CLcS1b53sMfmgVe5qtxLwlaq68V8=;
 b=BWyfByqyT3uaROKxZK8CEHD66g+jMuMrg7v3XQOO7QsENg8Ae4gj5uLbUX8Cod4Ma/
 A34IGTY4Ki2/XkO/vAn5rK3Q7wteYEspxxLuKd96qaendRpDTJRWV46v/mtgngjpvkbP
 I1hAEyOUJPtH4lp7l0hFSNX0nNBwx9ctxdIGuUvjm0IUmoBghSxNHNAlNTlJH70mir6n
 p2wurA+bo/aiMR39w/F/UfktGAA0oQVBgoZTg7ONEO4N5y1K6E7BR1EQtv65WazVOA2j
 3PpS8PfQNIWU/CQlYdT/TnMIBa/FYPG9lxNDBIWAZEH3tC83tFOIlo8OLsD9Wu/W8wUG
 XG5g==
X-Gm-Message-State: AOJu0YzKvFvnTLwg8bigCpR2p3nvGjuxNd43b8tg5gRQWWUJa9rcHeNp
 91xd6KgwPF+hSE3d3E8Gt6XFnTgEuCtLkfNUw7U=
X-Google-Smtp-Source: AGHT+IEUQu3EyEVIKezhzgaJBeiIa6fHDC6tDjc1h3yeYqkwxKRkS013nZDLfaXvqSCN8ufEV4PsixjZznfJ4XPN8nQ=
X-Received: by 2002:a67:f313:0:b0:444:bf88:c6d5 with SMTP id
 p19-20020a67f313000000b00444bf88c6d5mr3864269vsf.1.1691599562095; Wed, 09 Aug
 2023 09:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691509717.git.alistair.francis@wdc.com>
 <20230809131104.00006ea1@Huawei.com>
In-Reply-To: <20230809131104.00006ea1@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 Aug 2023 12:45:35 -0400
Message-ID: <CAKmqyKMQjE4OSiicxv+G3wp_gqbwguWDTXWpQGve_RDThQPCTA@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Initial support for SPDM
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Wed, Aug 9, 2023 at 8:11=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  8 Aug 2023 11:51:21 -0400
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > The Security Protocol and Data Model (SPDM) Specification defines
> > messages, data objects, and sequences for performing message exchanges
> > over a variety of transport and physical media.
> >  - https://www.dmtf.org/sites/default/files/standards/documents/DSP0274=
_1.3.0.pdf
> >
> > This series is a very initial start on adding SPDM support to QEMU.
> >
> > This series uses libspdm [1] which is a reference implementation of
> > SPDM.
> >
> > The series starts by adding support for building and linking with
> > libspdm. It then progresses to handling SPDM requests in the NVMe devic=
e
> > over the PCIe DOE protocol.
> >
> > This is a very early attempt. The code quality is not super high, the C
> > code hasn't been tested at all. This is really just an RFC to see if
> > QEMU will accept linking with libspdm.
> >
> > So, the main question is, how do people feel about linking with libspdm
> > to support SPDM?
> >
> > 1: https://github.com/DMTF/libspdm
>
> Hi Alastair,
>
> For reference / background we've had SPDM support for CXL emulated device=
s
> in our staging tree for quite a while - it's not upstream because of
> exactly this question (+ no one had upstreaming this as a high priority
> as out of tree was fine for developing the kernel stack - it's well
> isolated in the code so there was little cost in rebasing this feature)
> - and because libspdm is packaged by almost no one. There were problems
> building it with external crypto libraries etc.

Thanks for pointing that out! I didn't realise there was existing QEMU
work. I'm glad others are looking into it

Building with libspdm is difficult. Even this series does have weird
issues with openssl's crypto library. I have been working towards
packaging libspdm into buildroot, which has helped cleanup libspdm to
be more user friendly. libspdm 3.0 for example is now a lot easier to
build/package, but I expect to continue to improve things.

There will need to be more improvements to libspdm before this series
could be merged.

>
> Looks like you have had a lot more success than I ever did in getting tha=
t
> to work. I tried a few times in the past and ended up sticking with
> the Avery design folks approach of a socket connection to spdm-emu
> Given you cc'd them I'm guessing you came across that work which is what
> we used for testing the kernel code Lukas is working on currently.
>
> https://lore.kernel.org/qemu-devel/20210629132520.00000d1f@Huawei.com/
>
> https://gitlab.com/jic23/qemu/-/commit/9864fb29979e55c1e37c20edf00907d952=
4036e8

Thanks for that!

In the past the QEMU community has refused to accept upstream changes
that expose QEMU internals via sockets. So I suspect linking with
libspdm will be a more upstreamable approach.

On top of that requiring user to run an external socket application is clun=
ky.

>
> So I think we have 2 choices here.
> 1) Do what you have done and build the library as you are doing.
>  - Can fix a version - so don't care if they change the ABI etc other
>    than needing to move the version QEMU uses forwards when we need
>    to for new features.

I agree

>  - Cert management is going to add a lot of complexity into QEMU.
>    I've not looked at how much infrastructure we can reuse from elsewhere=
.
>    Maybe this is a solved problem.

Could we not just point to a cert when running QEMU?

>
> 2) Keep the SPDM emulation external.
>  - I'm not sure the socket protocol used by spdm-emu is fixed in stone
>    as people tend to change both ends.
>  - Cert management and protocol options etc are already available.

I suspect this will never get upstream though. My aim is to get
something upstream, so this is probably a no go (unless someone jumps
in and says this is ok).

>
> Personally I prefer the control option 1 gives us, even if it's a lot mor=
e
> code.  Option 2 also rather limits our ability to do anything with
> the encrypted data as well. It's fine if the aim is just verification
> of simple flows, but if we need to inject particular measurements etc
> it doesn't really work.

I like option 1 as well :)

I don't envisage QEMU supporting extremely complex flows. I was more
aiming for a certificate and some measurement data and maybe a
manifest. My hope was basic SPDM support, not a complete test suite.

Alistair

>
> Jonathan
>
>
>
> >
> > Alistair Francis (3):
> >   subprojects: libspdm: Initial support
> >   hw: nvme: ctrl: Initial support for DOE
> >   hw: nvme: ctrl: Process SPDM requests
> >
> >  meson.build                   | 78 +++++++++++++++++++++++++++++++++++
> >  hw/nvme/nvme.h                |  4 ++
> >  include/hw/pci/pcie_doe.h     |  1 +
> >  hw/nvme/ctrl.c                | 35 ++++++++++++++++
> >  .gitmodules                   |  3 ++
> >  meson_options.txt             |  3 ++
> >  scripts/meson-buildoptions.sh |  3 ++
> >  subprojects/.gitignore        |  1 +
> >  subprojects/libspdm.wrap      |  5 +++
> >  9 files changed, 133 insertions(+)
> >  create mode 100644 subprojects/libspdm.wrap
> >
>

