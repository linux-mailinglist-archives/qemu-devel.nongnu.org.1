Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CB571816F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:23:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Lmw-0001cO-AO; Wed, 31 May 2023 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.guittot@linaro.org>)
 id 1q4LFm-0004Xw-UM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:48:39 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincent.guittot@linaro.org>)
 id 1q4LFk-0005d0-Sy
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:48:38 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5346d150972so5074940a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685537313; x=1688129313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/MnoC95jVY7JUwLeYUzQX1bQ2/paihg1ZFHf4gLHqE=;
 b=Uuwsr0pE4aRUYnz95zQBDbglzCKEOMSMxmfrkvaB3cPq20S8eeUXUCNdkxP3ogMqN8
 /Lghsa1GO6E0yNuw752B2yAumOhF5JKJdtAA28H7f2pQHbRel2RfliKl/ANaTgmIEVvg
 HqeI9aF4H1gj/BxXXsmI0lZiqBH0FgrZfQge4jT/HXQXRvEO1gZB5uOTMY4W1gVDRI3a
 hjHXqT5uR0JnE31zg499Qncdbaw5u8vnVycrCppKuWuW2O3DlLeX27aHhORY4E2W4u/N
 /6WRkX/Vs3Av5b4P/xk2bCEyE+RTIEOOvZiBwdSTnE1Y0yYvYcFOSJU1oBEmJPHX7QIC
 i8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685537313; x=1688129313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/MnoC95jVY7JUwLeYUzQX1bQ2/paihg1ZFHf4gLHqE=;
 b=dNSTVnopIanqYbDV6ZL/Dap3UcFtSEWmEVNih6IgN5h+ysX0usXpZisHQ3qTK/7v8K
 8kkZSRjpZxch8DyB+TVeS7Vk/BJFTb4pGDu4Pmj876CypqiyeIhg+jENhLAg/Yo+3e59
 j+LMVJcFAgW5y5BjJCVUIroLiBHghacptiGfIJ+uNMSEWTVl6YU+1gnJoxjaUuXaRDVK
 cAHs3pIt+QwLNm8sWM/YrSYxSPqW8FwdG3eOruZcP+/zrW5J3N5snpBrARgxbNhQbjeG
 WZRWmN5emhCyLaU+BV/8gSMk1p7rtU3F5JnKUBMAoWHQieGFBtN/x22jtAz8Dmat9ms0
 x01Q==
X-Gm-Message-State: AC+VfDxKoLT/mr5JUZh/71wgTJx1SfVImux9HhtKrJOwHJ7aVf7qH/bq
 uygpHpiVf2O5jEUA8axEOv3RlIO3+nGBE3Hq14+qjg==
X-Google-Smtp-Source: ACHHUZ4YCc1RmcOVbbw/ub5CWEhay8XtOEb2s7T83+NEEszp4MlaRirM3BiieyLUThFmrwZrnnSjR2i5BuT+e/KseI0=
X-Received: by 2002:a17:90a:86ca:b0:253:30f9:1849 with SMTP id
 y10-20020a17090a86ca00b0025330f91849mr5628001pjv.12.1685537312850; Wed, 31
 May 2023 05:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685476786.git.mzamazal@redhat.com>
 <871qiwd9uq.fsf@linaro.org> <87edmw7lxm.fsf@redhat.com>
In-Reply-To: <87edmw7lxm.fsf@redhat.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 31 May 2023 14:48:21 +0200
Message-ID: <CAKfTPtAL-7JdWjvBzY7foR_DJ2sykJ80esEc7AH-N-_AJGOS=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add SCMI vhost-user VIRTIO device
To: Milan Zamazal <mzamazal@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, mst@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=vincent.guittot@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 May 2023 09:22:47 -0400
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

On Wed, 31 May 2023 at 13:57, Milan Zamazal <mzamazal@redhat.com> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Milan Zamazal <mzamazal@redhat.com> writes:
> >
> >> This patch series adds a vhost-user VIRTIO device for SCMI.
> >> It's similar to other similar vhost-user VIRTIO devices.
> >>
> >> I'm aware of the work in progress by Alex Benn=C3=A9e to simplify simi=
lar devices
> >> and avoid excessive code duplication.  I think the SCMI device support
> >> doesn't bring anything special and it can be rebased on the given work
> >> if/once it is merged.
> >
> > \o/ - I'll try and get the next iteration done in the next few weeks.
>
> Great, looking forward.
>
> > Out of interest have you tested your scmi backend with those patches? O=
h
> > and also which backend are you using?
>
> I have tested the patches with my proof-of-concept SCMI backend
> (emulating a fake sensor) based on rust-vmm and a Linux guest OS.  I
> plan to change the prototype into something publishable in the next
> weeks and to post patches to rust-vmm/vhost-device.
>
> > Vincent did a bunch of work over the last year or so on SCMI although i=
n
> > his case the backend was a RTOS running in a separate domain using some
> > shared memory between the SCMI domain and a couple of guests.
>
> I have seen recordings of some related presentations.  The work is
> primarily based on crosvm, right?  I'd be interested in what kind of

I have used qemu for my tests

> SCMI interface the domain provides and whether it would make sense to be
> able to connect it with the QEMU SCMI device via some vhost-user daemon,
> an already existing one, if any, and/or the one I work on.

My PoC is based on the SCP-firmware that is usually running on a
dedicated power coprocessor. We have extended it to run in several
env. The PoC runs the SCP firmware in a VM and uses a vhost user scmi
bridge to connect the guest vm with this virtual power coprocessor.
One reason for using SCP-firmware is that It follows SCMI specs and
its updates so I don't have to re-implement it myself and can leverage
on their devs

For test purpose I also have enabled it as a simple linux vhost user daemon

>
> >> Milan Zamazal (4):
> >>   hw/virtio: Add boilerplate for vhost-user-scmi device
> >>   hw/virtio: Add vhost-user-scmi-pci boilerplate
> >>   tests/qtest: Fix a comment typo in vhost-user-test.c
> >>   tests/qtest: enable tests for virtio-scmi
> >>
> >>  MAINTAINERS                         |   7 +
> >>  hw/virtio/Kconfig                   |   5 +
> >>  hw/virtio/meson.build               |   2 +
> >>  hw/virtio/vhost-user-scmi-pci.c     |  68 +++++++
> >>  hw/virtio/vhost-user-scmi.c         | 306 +++++++++++++++++++++++++++=
+
> >>  include/hw/virtio/vhost-user-scmi.h |  30 +++
> >>  tests/qtest/libqos/meson.build      |   1 +
> >>  tests/qtest/libqos/virtio-scmi.c    | 174 ++++++++++++++++
> >>  tests/qtest/libqos/virtio-scmi.h    |  34 ++++
> >>  tests/qtest/vhost-user-test.c       |  46 ++++-
> >>  10 files changed, 672 insertions(+), 1 deletion(-)
> >>  create mode 100644 hw/virtio/vhost-user-scmi-pci.c
> >>  create mode 100644 hw/virtio/vhost-user-scmi.c
> >>  create mode 100644 include/hw/virtio/vhost-user-scmi.h
> >>  create mode 100644 tests/qtest/libqos/virtio-scmi.c
> >>  create mode 100644 tests/qtest/libqos/virtio-scmi.h
>

