Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D3745807
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFTO-0007eQ-3P; Mon, 03 Jul 2023 05:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qGFTL-0007eB-UT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:03:52 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qGFTK-0006Cw-19
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:03:51 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-565db4666d7so1859905eaf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688375027; x=1690967027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJKu3TI7NEuDtjDEdXHnRJNzjZ8vVeFGshp9lQeJJH4=;
 b=BTOQ2wDReU49bQbiMfBrWLmYV8oBdzD8GDs90P7FoLh/AhrEXd7aIG7ykuwVBz4aPd
 I9PW9w7tHDPOOkbqsJc88iJ33stzFHpgQgIrJbmH+mSdokxLNIW/+DC+/oqs3OXqffZm
 W54DW4TrgTM0uwNvk5yj6xcSFJuDO9yBb3adMOMa24kimsPxDpXieYLbWwiKDlIFjN8M
 jPJLFCOuBVr3jp3ps3GyGun9uZvLVqZU7pHCwN/Fy1SFCEk1hP3Qv3HPbx1Sk0o9HZ+4
 Jii6Yt4x+GysdQNsXZAotv8WgGIecn3PoqsVNDocOpqHXBJ9spr5YhOaiqdCFWZG1Nl+
 BeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688375027; x=1690967027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJKu3TI7NEuDtjDEdXHnRJNzjZ8vVeFGshp9lQeJJH4=;
 b=L7ikuAjbRdagBCdmkVlcx31dj7aZL5wQey8vSDQDXYG8Ob+Tm6cwtW3LP0UUQ9XLHC
 ueRK4FlwaAtb2TKJegDHyfTP1TpA8W0tPYwvdN/j+tTgdjTegdaQ/+f5o8HoM5Bj1LtD
 Vo/YJjRse3s5EtvusEIyfS89SxtoaGf7bByq1M07DZS1dypzk9cb4EXVLwwBh7ScUcNE
 X+8/rU0HGoZP7LG+NcX44Yks6R4b/XpzbqZXC22BgZbCKuOI95Ncx3LJcy23unGHT0pt
 0xputFMdIORp6lTAZ5WZRzEyz8x/jaI0+3bH8raEPZ2yXVWAMpfi62f69HXbPrZBQP0b
 U4fg==
X-Gm-Message-State: AC+VfDxfpi6h33jOn5zkpEp/rgyDergAPo8/OHLu/ZjwYukBB7N0HcAU
 XaF1m6wJKShvMFuSt5pI8R+W4LqOY2tYX+XgE/Q=
X-Google-Smtp-Source: ACHHUZ7NK8gcd9X1nVp6Tqw1XCwuv2Ay/R/cWNOIWlZWOit+9aBH7/UXiCy6K1U86eav9NBv87t+J4oIsjFRrTJCMwQ=
X-Received: by 2002:a4a:524f:0:b0:563:5666:5c03 with SMTP id
 d76-20020a4a524f000000b0056356665c03mr6373167oob.5.1688375027342; Mon, 03 Jul
 2023 02:03:47 -0700 (PDT)
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
 <CAJSP0QW22f18V0pXTO-w4BXONJ3wLCbczMjKSKCRnxiF+7W=eg@mail.gmail.com>
 <CACGkMEvCV6JcQ3LOQvCx=9KXKqE_SAQwzxFXe1c+PdSMH_KbDg@mail.gmail.com>
 <CAJSP0QUtCnE49YWA6PmVSExMaFf2VZi3St1Wysk9ruDS37ALHg@mail.gmail.com>
 <CACGkMEu1V4HBdP3JFYV-+Uec1s6f0U3fj5f9tV0FApQ+U8rbrw@mail.gmail.com>
In-Reply-To: <CACGkMEu1V4HBdP3JFYV-+Uec1s6f0U3fj5f9tV0FApQ+U8rbrw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Jul 2023 11:03:34 +0200
Message-ID: <CAJSP0QU-p_cKCevxTabKhfq9T2=UShLqcced-OCmfCx3dE+6rQ@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
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

On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
> > > >
> > > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > > >
> > > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > > >
> > > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.=
maximets@ovn.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets=
 <i.maximets@ovn.org> wrote:
> > > > > > > > > > >>
> > > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang =
<jasowang@redhat.com> wrote:
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maxim=
ets <i.maximets@ovn.org> wrote:
> > > > > > > > > > >> It is noticeably more performant than a tap with vho=
st=3Don in terms of PPS.
> > > > > > > > > > >> So, that might be one case.  Taking into account tha=
t just rcu lock and
> > > > > > > > > > >> unlock in virtio-net code takes more time than a pac=
ket copy, some batching
> > > > > > > > > > >> on QEMU side should improve performance significantl=
y.  And it shouldn't be
> > > > > > > > > > >> too hard to implement.
> > > > > > > > > > >>
> > > > > > > > > > >> Performance over virtual interfaces may potentially =
be improved by creating
> > > > > > > > > > >> a kernel thread for async Tx.  Similarly to what io_=
uring allows.  Currently
> > > > > > > > > > >> Tx on non-zero-copy interfaces is synchronous, and t=
hat doesn't allow to
> > > > > > > > > > >> scale well.
> > > > > > > > > > >
> > > > > > > > > > > Interestingly, actually, there are a lot of "duplicat=
ion" between
> > > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > > >
> > > > > > > > > > > 1) both have similar memory model (user register)
> > > > > > > > > > > 2) both use ring for communication
> > > > > > > > > > >
> > > > > > > > > > > I wonder if we can let io_uring talks directly to AF_=
XDP.
> > > > > > > > > >
> > > > > > > > > > Well, if we submit poll() in QEMU main loop via io_urin=
g, then we can
> > > > > > > > > > avoid cost of the synchronous Tx for non-zero-copy mode=
s, i.e. for
> > > > > > > > > > virtual interfaces.  io_uring thread in the kernel will=
 be able to
> > > > > > > > > > perform transmission for us.
> > > > > > > > >
> > > > > > > > > It would be nice if we can use iothread/vhost other than =
the main loop
> > > > > > > > > even if io_uring can use kthreads. We can avoid the memor=
y translation
> > > > > > > > > cost.
> > > > > > > >
> > > > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I=
'm working
> > > > > > > > on patches to re-enable it and will probably send them in J=
uly. The
> > > > > > > > patches also add an API to submit arbitrary io_uring operat=
ions so
> > > > > > > > that you can do stuff besides file descriptor monitoring. B=
oth the
> > > > > > > > main loop and IOThreads will be able to use io_uring on Lin=
ux hosts.
> > > > > > >
> > > > > > > Just to make sure I understand. If we still need a copy from =
guest to
> > > > > > > io_uring buffer, we still need to go via memory API for GPA w=
hich
> > > > > > > seems expensive.
> > > > > > >
> > > > > > > Vhost seems to be a shortcut for this.
> > > > > >
> > > > > > I'm not sure how exactly you're thinking of using io_uring.
> > > > > >
> > > > > > Simply using io_uring for the event loop (file descriptor monit=
oring)
> > > > > > doesn't involve an extra buffer, but the packet payload still n=
eeds to
> > > > > > reside in AF_XDP umem, so there is a copy between guest memory =
and
> > > > > > umem.
> > > > >
> > > > > So there would be a translation from GPA to HVA (unless io_uring
> > > > > support 2 stages) which needs to go via qemu memory core. And thi=
s
> > > > > part seems to be very expensive according to my test in the past.
> > > >
> > > > Yes, but in the current approach where AF_XDP is implemented as a Q=
EMU
> > > > netdev, there is already QEMU device emulation (e.g. virtio-net)
> > > > happening. So the GPA to HVA translation will happen anyway in devi=
ce
> > > > emulation.
> > >
> > > Just to make sure we're on the same page.
> > >
> > > I meant, AF_XDP can do more than e.g 10Mpps. So if we still use the
> > > QEMU netdev, it would be very hard to achieve that if we stick to
> > > using the Qemu memory core translations which need to take care about
> > > too much extra stuff. That's why I suggest using vhost in io threads
> > > which only cares about ram so the translation could be very fast.
> >
> > What does using "vhost in io threads" mean?
>
> It means a vhost userspace dataplane that is implemented via io threads.

AFAIK this does not exist today. QEMU's built-in devices that use
IOThreads don't use vhost code. QEMU vhost code is for vhost kernel,
vhost-user, or vDPA but not built-in devices that use IOThreads. The
built-in devices implement VirtioDeviceClass callbacks directly and
use AioContext APIs to run in IOThreads.

Do you have an idea for using vhost code for built-in devices? Maybe
it's fastest if you explain your idea and its advantages instead of me
guessing.

> > > > Regarding pinning - I wonder if that's something that can be refine=
d
> > > > in the kernel by adding an AF_XDP flag that enables on-demand pinni=
ng
> > > > of umem. That way only rx and tx buffers that are currently in use
> > > > will be pinned. The disadvantage is the runtime overhead to pin/unp=
in
> > > > pages. I'm not sure whether it's possible to implement this, I have=
n't
> > > > checked the kernel code.
> > >
> > > It requires the device to do page faults which is not commonly
> > > supported nowadays.
> >
> > I don't understand this comment. AF_XDP processes each rx/tx
> > descriptor. At that point it can getuserpages() or similar in order to
> > pin the page. When the memory is no longer needed, it can put those
> > pages. No fault mechanism is needed. What am I missing?
>
> Ok, I think I kind of get you, you mean doing pinning while processing
> rx/tx buffers? It's not easy since GUP itself is not very fast, it may
> hit PPS for sure.

Yes. It's not as fast as permanently pinning rx/tx buffers, but it
supports unpinned guest RAM.

There are variations on this approach, like keeping a certain amount
of pages pinned after they have been used so the cost of
pinning/unpinning can be avoided when the same pages are reused in the
future, but I don't know how effective that is in practice.

Is there a more efficient approach without relying on hardware page
fault support?

My understanding is that hardware page fault support is not yet
deployed. We'd be left with pinning guest RAM permanently or using a
runtime pinning/unpinning approach like I've described.

Stefan

