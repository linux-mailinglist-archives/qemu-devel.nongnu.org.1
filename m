Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2E74D608
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqNj-00053F-LN; Mon, 10 Jul 2023 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qIqNh-000537-Rs
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:52:45 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qIqNf-0005I8-Qf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:52:45 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5703cb4bcb4so47923577b3.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688993562; x=1691585562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uS76XiMMKZ/gqyVmuiK87au4Mq1zPAmWZ8g8zutLXCM=;
 b=3+nwh2ZLmxhtsn8qPT0cRYW2A/+dgtjhO9Xv0bCmtsNB+hXtM/evxlLX7KpLEk29YT
 fzqjSS04bkG2G6VOluFuO+PZBJyewSiElqnQf88we9JBKdDCazHBulpa/uZvdP12uKPb
 aVeXCyZ3fpLE7wkz843KwXM+5s/cvK3RAvzTn+2xvMlpvyA1qGK50q0aQmespXFytE8V
 g6VYj/BcP1jwwBSFjl4ZxiK9TWDS0YgjQos7dLR8JKPLzAjGhJaQmp4M2ElVKUOh13Rh
 4K8w/s3p/1zxTd9RrAFnCbS7WKfSnyTdkqcPEHxoCAjvOZltXqkAhUtAa+DLmhN847b7
 X6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688993562; x=1691585562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uS76XiMMKZ/gqyVmuiK87au4Mq1zPAmWZ8g8zutLXCM=;
 b=dj94TIURddjQPYQLbeLrPyiMR6+2OSWDH2CoWFJF1XEVSx1gNhW/Zl059Z7nlDZHIu
 WfhF3LtYcssFR4SrNAnBdC+xkDVDuiaSmwQTCpQr7nq/dehqi0D9++ymRdx/NA3XtJuu
 zJHOGEJHcDmqdcf7Jgw5XTA1N/XV/9yhPqlO8r5WD2Hqt6H24kPU1LArCjnQP7tDE/Zs
 FfxRbgO/9tA92+4QJsXWxvPriweJbOWaJ8pNJXSsT3f6IJb6T+JN3E6bj7YOV/NwGgBE
 OEM8wkkObDpJhlBv3u3rBkr3E2tm+hxltZY+ErGfv5qWugeYeCVSnoQMy5j/CsTewmzM
 zHiA==
X-Gm-Message-State: ABy/qLau444kf3LWpyDo5BzZdCdWMbG/Qko/73IHcoqagBzb/f+fzijf
 fxCqzo/xr3a5VAVB2S7vHmcavZJRcZ60v6bd/piTJg==
X-Google-Smtp-Source: APBJJlGNO0/pcYbcjoVzNW6meHj1O7Ybidz404WycVxieYrBEL82jGo41+a31L2lECbicBtCVsWwS8X3fE89s+8sxhg=
X-Received: by 2002:a25:f819:0:b0:c75:2ea9:e955 with SMTP id
 u25-20020a25f819000000b00c752ea9e955mr5627469ybd.31.1688993562039; Mon, 10
 Jul 2023 05:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230614221026.56950-1-andrew@daynix.com>
 <20230614221026.56950-6-andrew@daynix.com>
 <87edlkj67s.fsf@pond.sub.org>
In-Reply-To: <87edlkj67s.fsf@pond.sub.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 10 Jul 2023 15:52:31 +0300
Message-ID: <CABcq3pGoKz20iBvqOe9E9cL5CFNYrqY_QN+AWBPR0DbJYJCobw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] qmp: Added new command to retrieve eBPF blob.
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::1132;
 envelope-from=andrew@daynix.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,


On Fri, Jul 7, 2023 at 2:45=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Andrew Melnychenko <andrew@daynix.com> writes:
>
> > Added command "request-ebpf". This command returns
> > eBPF program encoded base64. The program taken from the
> > skeleton and essentially is an ELF object that can be
> > loaded in the future with libbpf.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>
> In review of v2, I asked why we need to provide eBPF programs via QMP,
> and not simply via the filesystem, like all the other build artifacts.
> Daniel explained
>
>     Fetching it from QEMU gives us a strong guarantee that the eBPF
>     code actually matches the QEMU binary we're talking to, which is
>     useful if you're dealing with RPMs which can be upgraded behind
>     your back, or have multiple parallel installs of QEMU.
>
> I asked to work this rationale into the QAPI schema doc comments and the
> commit message.
>
> Only the doc comments are updated in this version.  Please update the
> commit message as well.

Ah, my bad. I'll update the commit message in v4.

>
> I remain unconvinced this justifies adding an entirely new transport.
> If we want to guard against mismatch, we can do it the usual way: bake
> the version into the build artifacts that must match, then check they
> do.
>
> Since I feel vetoing the change would overstep my authority as a QAPI
> maintainer, I'm asking you to treat my objection as advice.
>
> If you you elect not to follow my advice, I want you to describe the
> path not chosen in the commit message.  I.e. briefly explain the need
> for an exact version match, describe the ways to ensure it we
> considered, and the reasons for your pick.

In the v1 of this feature, we tried to implement it using an
additional file including
the ebpf (ebpf helper) built together with QEMU. Unfortunately, during long=
 v1
discussion it was found that this approach still leaves an open issue in ca=
se
of QEMU update when the running instance is present + later hotplug of
virtio-net device.
The existing approach (v2,v3,...) seems to solve all the problems with
little effort.
We'll document all the reasons in the commit message.
Thank you for the advice.

>
> > ---
> >  qapi/ebpf.json        | 55 +++++++++++++++++++++++++++++++++++++++++++
> >  qapi/meson.build      |  1 +
> >  qapi/qapi-schema.json |  1 +
> >  3 files changed, 57 insertions(+)
> >  create mode 100644 qapi/ebpf.json
> >
> > diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> > new file mode 100644
> > index 00000000000..6f9a1f1a0c9
> > --- /dev/null
> > +++ b/qapi/ebpf.json
> > @@ -0,0 +1,55 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=3Dpython
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> > +# See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D Machines
>
> Copy-pasta :)

Oh :3

>
> > +##
> > +
> > +{ 'include': 'common.json' }
> > +
> > +##
> > +# @EbpfObject:
> > +#
> > +# Structure that holds eBPF ELF object encoded in base64.
> > +#
> > +# Since: 8.1
> > +#
> > +##
> > +{ 'struct': 'EbpfObject',
> > +  'data': {'object': 'str'} }
> > +
> > +##
> > +# @EbpfProgramID:
> > +#
> > +# An enumeration of the eBPF programs. Currently, only RSS is presente=
d.
> > +# RSS - Receive side scaling, technology that allows steering traffic
> > +# between queues by calculation hash. Users may set up indirection tab=
le
> > +# and hash/packet types configurations. Used with virtio-net.
>
> Let's stick to the common way to document enum members, like this:
>
>    # The eBPF programs that can be gotten with request-ebpf.
>    #
>    # @rss: ...
>

Ok, I'll update it.

> > +#
> > +# Since: 8.1
> > +##
> > +{ 'enum': 'EbpfProgramID',
> > +  'data': [ { 'name': 'rss', 'if': 'CONFIG_EBPF' } ] }
>
> Uh, this makes just the member @rss conditional on CONFIG_EBPF.
> Why not the entire enum?
>

I'll change it for entire enum.

> > +
> > +##
> > +# @request-ebpf:
> > +#
> > +# Returns eBPF object that can be loaded with libbpf.
> > +# Management applications (g.e. libvirt) may load it and pass file
> > +# descriptors to QEMU. Which allows running QEMU without BPF capabilit=
ies.
> > +# It's crucial that eBPF program/map is compatible with QEMU, so it's
> > +# provided through QMP.
> > +#
> > +# Returns: RSS eBPF object encoded in base64.
> > +#
> > +# Since: 8.1
> > +#
> > +##
> > +{ 'command': 'request-ebpf',
> > +  'data': { 'id': 'EbpfProgramID' },
> > +  'returns': 'EbpfObject',
> > +  'if': 'CONFIG_EBPF' }
> > +
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index 9fd480c4d81..12a1cb1f9c2 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -52,6 +52,7 @@ qapi_all_modules =3D [
> >    'transaction',
> >    'virtio',
> >    'yank',
> > +  'ebpf',
>
> Keep this list alphabetically sorted, please.
>

Ok!

> >  ]
> >  if have_system
> >    qapi_all_modules +=3D [
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 6594afba312..169cfe8d386 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -79,3 +79,4 @@
> >  { 'include': 'virtio.json' }
> >  { 'include': 'cryptodev.json' }
> >  { 'include': 'cxl.json' }
> > +{ 'include': 'ebpf.json' }
>
> This puts it at the end of the QMP reference manual.  Is this the best
> spot?
>

I think I'll put it next "net". Although, future eBPF programs can be
used not only for networks.
On the other hand, practical use of eBPF that I can come up with
related to the net, g.e. virtio/vhost net filters.

