Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F74740B5A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQUw-0005zF-7D; Wed, 28 Jun 2023 04:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEQUt-0005z3-MR
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:25:55 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEQUr-0007n4-SS
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:25:55 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5636425bf98so1584958eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687940752; x=1690532752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfReUOTnblAaLscCYz9+GWkRAFXHYF4bBFhJBrQXq1E=;
 b=leYQhurw912dzfDd8YSEYD1L4ODd5Rx5F3jeY7C8Df5Gf1X156vQZyMU9lhdQ8bNBq
 JdQC5UYi78I1R5YpMcKRgAeRR8/k3j+dsTosvfGmC7nU/ZhBGPcMoE6ote2J/75GJ9vh
 LSkDrkJUe5sfItuc5TcE9GQEamvo3MEg69GvJ9Mrh/Mzh0AKVyOk7rNqY9TkqJ4VtE8p
 zJ+7sc/QR/V1NZMQz2ULWqJzki3bcXQ8qAdm5bdU85Zr6GVDLzqRLl7MikW8JsE4Z/Lo
 hMqXRFDNkkw/S3mkT4GXOpjn+IEwa3JvVfhQ+zP+H5bwafWSiKaMehW+YAiJVuLJefSE
 FodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687940752; x=1690532752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfReUOTnblAaLscCYz9+GWkRAFXHYF4bBFhJBrQXq1E=;
 b=dvOvagx97/VdMQ+8wjFzm9YZf4ba+1qL61N6OPivDiYTwFgtAaNL6JJrVvEunFfH46
 O3javNtl7qQGmJxyvyH7kRxBy9IlTFDuicRl7ryGwIQKVM/te+1TuVJMFC99YrsYggMP
 Y4u3Xnfg09gDbFI1dZB6PglgCOs1Pjb9cF9yoNMnmkXXYAJHpZmAkFOCEJPM2GxIGaQf
 /dqCVcTw6hXm2jQEThtG5i5a20Si7P05TEuhb3tQj89C+h5TFbs42OsZnlUzy4VB9006
 iJ1GCLuJiJopUdlI5ogyZ1S1lqhemw2LCr78EW4HODf9lk8FOUwO73QhYzBltg5rJlqr
 dyTg==
X-Gm-Message-State: AC+VfDxpOvtaoXstvSQCKM9VvBNV/ty7DRvRZpVpY+6w8FEj/x4WKDjv
 qRm0QMoZz8MaCf/COmTz6sQe89P2dGcjM2FUn6I=
X-Google-Smtp-Source: ACHHUZ4VGfOib8d9adANzRqNCmFRFAl9YvUX3nNHrMYKADxHR75fQsRTJqiud3I2lzz+ImBkN2a5BtY8t1j+31YG4Gs=
X-Received: by 2002:a4a:dc45:0:b0:560:c32a:8e10 with SMTP id
 q5-20020a4adc45000000b00560c32a8e10mr12740257oov.0.1687940752534; Wed, 28 Jun
 2023 01:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
 <CACGkMEuN_PeXZhqaN4EJP8rKRVK=wftpkH3--y267j9+7smCOw@mail.gmail.com>
 <CAJSP0QVg-mmtnMXZpxRKutbdgpdNeawJT45iQSp4cf=MRedZAQ@mail.gmail.com>
 <CACGkMEtdk-Qi+5M+pEa9v=S_ehRs=m7Ux4=Sf6aqk0EqNzyQ5g@mail.gmail.com>
In-Reply-To: <CACGkMEtdk-Qi+5M+pEa9v=S_ehRs=m7Ux4=Sf6aqk0EqNzyQ5g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Jun 2023 10:25:40 +0200
Message-ID: <CAJSP0QW22f18V0pXTO-w4BXONJ3wLCbczMjKSKCRnxiF+7W=eg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc30.google.com
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

On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
> > > >
> > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > > >
> > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets=
@ovn.org> wrote:
> > > > > >
> > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maxi=
mets@ovn.org> wrote:
> > > > > > >>
> > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > >>>>
> > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.m=
aximets@ovn.org> wrote:
> > > > > > >> It is noticeably more performant than a tap with vhost=3Don =
in terms of PPS.
> > > > > > >> So, that might be one case.  Taking into account that just r=
cu lock and
> > > > > > >> unlock in virtio-net code takes more time than a packet copy=
, some batching
> > > > > > >> on QEMU side should improve performance significantly.  And =
it shouldn't be
> > > > > > >> too hard to implement.
> > > > > > >>
> > > > > > >> Performance over virtual interfaces may potentially be impro=
ved by creating
> > > > > > >> a kernel thread for async Tx.  Similarly to what io_uring al=
lows.  Currently
> > > > > > >> Tx on non-zero-copy interfaces is synchronous, and that does=
n't allow to
> > > > > > >> scale well.
> > > > > > >
> > > > > > > Interestingly, actually, there are a lot of "duplication" bet=
ween
> > > > > > > io_uring and AF_XDP:
> > > > > > >
> > > > > > > 1) both have similar memory model (user register)
> > > > > > > 2) both use ring for communication
> > > > > > >
> > > > > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > > > > >
> > > > > > Well, if we submit poll() in QEMU main loop via io_uring, then =
we can
> > > > > > avoid cost of the synchronous Tx for non-zero-copy modes, i.e. =
for
> > > > > > virtual interfaces.  io_uring thread in the kernel will be able=
 to
> > > > > > perform transmission for us.
> > > > >
> > > > > It would be nice if we can use iothread/vhost other than the main=
 loop
> > > > > even if io_uring can use kthreads. We can avoid the memory transl=
ation
> > > > > cost.
> > > >
> > > > The QEMU event loop (AioContext) has io_uring code
> > > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm worki=
ng
> > > > on patches to re-enable it and will probably send them in July. The
> > > > patches also add an API to submit arbitrary io_uring operations so
> > > > that you can do stuff besides file descriptor monitoring. Both the
> > > > main loop and IOThreads will be able to use io_uring on Linux hosts=
.
> > >
> > > Just to make sure I understand. If we still need a copy from guest to
> > > io_uring buffer, we still need to go via memory API for GPA which
> > > seems expensive.
> > >
> > > Vhost seems to be a shortcut for this.
> >
> > I'm not sure how exactly you're thinking of using io_uring.
> >
> > Simply using io_uring for the event loop (file descriptor monitoring)
> > doesn't involve an extra buffer, but the packet payload still needs to
> > reside in AF_XDP umem, so there is a copy between guest memory and
> > umem.
>
> So there would be a translation from GPA to HVA (unless io_uring
> support 2 stages) which needs to go via qemu memory core. And this
> part seems to be very expensive according to my test in the past.

Yes, but in the current approach where AF_XDP is implemented as a QEMU
netdev, there is already QEMU device emulation (e.g. virtio-net)
happening. So the GPA to HVA translation will happen anyway in device
emulation.

Are you thinking about AF_XDP passthrough where the guest directly
interacts with AF_XDP?

> > If umem encompasses guest memory,
>
> It requires you to pin the whole guest memory and a GPA to HVA
> translation is still required.

Ilya mentioned that umem uses relative offsets instead of absolute
memory addresses. In the AF_XDP passthrough case this means no address
translation needs to be added to AF_XDP.

Regarding pinning - I wonder if that's something that can be refined
in the kernel by adding an AF_XDP flag that enables on-demand pinning
of umem. That way only rx and tx buffers that are currently in use
will be pinned. The disadvantage is the runtime overhead to pin/unpin
pages. I'm not sure whether it's possible to implement this, I haven't
checked the kernel code.

Stefan

