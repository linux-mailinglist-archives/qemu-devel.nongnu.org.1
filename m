Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B7742699
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:37:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEqss-0004bs-Ia; Thu, 29 Jun 2023 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEqsl-0004Kf-63
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:36:19 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEqse-0008EI-BK
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:36:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b01b43577fso492039fac.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688042162; x=1690634162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRFFHaWFLOqR2EmyGaUhLGYYnSoFDAHqhAV8bFz2QTc=;
 b=pGvdmEY3uPnDMb5a4T17tmQ2ngSPlYx7+p3Q3+s37UWuLYdQwM+jGuTnok54cXLlka
 T+0eSVGuXcQUE3CRBUgrW1UmEl3Su7P8DvNZFOYv9egZrBEqm5G2mjTnWjH9U+tELAv6
 9ZoYIGNMwNWvBW/esXPlbZ0WFh0nP8k3Cbn8cvyEBngZLTVcBxBHVDzhybZiYKAKRqj6
 8Jw9iqV+3X3yHPE03pxTxU+xrZmfPfjohhykyL0kiJ4Z8jUHCQhs7YaytlQV4lBMIY7r
 rqCdSF/IfJ3HnCIkZ/ktAGNiNbEikvpNlYCk8kMVVNksYVadW6+OhyphO7c10MoPdy1z
 ix0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688042162; x=1690634162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRFFHaWFLOqR2EmyGaUhLGYYnSoFDAHqhAV8bFz2QTc=;
 b=NsF4IJaW2UD3GREhQundA/zwWruCegGSccf9yYO965LX4C/dOXI0E0/k7nlX+Ydo/h
 7nNrydarXyB50skbjic5goMIGYs+DkZTKHBmlTl93aoi0yp4SdeW68sOfMHcgr2ERUNJ
 rZfKwi559haZkxTJCu0RGszbQToMqAE2rLmFHmyInepmtwJwIJvQ4OVhhJaMEFQFRPgK
 CnXPQBgV3TqNb9Ef3KzX1yUN1sTCpTSaVNK2IjJgnzgCMyblfnXnlUC45PUqhvDf98O0
 6UdoxHJGNhrcvgr697JymARiytPLz1gPh4BIMv3XLgaqZVTeQB6z7b+1VDqUOW1CTi4T
 1EUA==
X-Gm-Message-State: AC+VfDwCeOxHxA9CJhdsiyc3NTG/Ls/TfCqqBQa+ua76of+IN3i9tUug
 JkaCcvAcANAi9rNRLp+sLj0kOeefrOpTFwsLSw8=
X-Google-Smtp-Source: ACHHUZ49f10BKQ0CJS5pgJuIfKbJ0MLH/ukhfux79O5fNrIXKppxVY/7Heed3DKFZNyvAdwPnFZylJEJ+o3mc0Yy6dw=
X-Received: by 2002:a05:6870:713:b0:1b0:68f7:da8 with SMTP id
 ea19-20020a056870071300b001b068f70da8mr5921053oab.12.1688042161831; Thu, 29
 Jun 2023 05:36:01 -0700 (PDT)
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
In-Reply-To: <CACGkMEvCV6JcQ3LOQvCx=9KXKqE_SAQwzxFXe1c+PdSMH_KbDg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Jun 2023 14:35:49 +0200
Message-ID: <CAJSP0QUtCnE49YWA6PmVSExMaFf2VZi3St1Wysk9ruDS37ALHg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x30.google.com
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

On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
> > > >
> > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > > >
> > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > > >
> > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maxi=
mets@ovn.org> wrote:
> > > > > > > >
> > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.=
maximets@ovn.org> wrote:
> > > > > > > > >>
> > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jas=
owang@redhat.com> wrote:
> > > > > > > > >>>>
> > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets =
<i.maximets@ovn.org> wrote:
> > > > > > > > >> It is noticeably more performant than a tap with vhost=
=3Don in terms of PPS.
> > > > > > > > >> So, that might be one case.  Taking into account that ju=
st rcu lock and
> > > > > > > > >> unlock in virtio-net code takes more time than a packet =
copy, some batching
> > > > > > > > >> on QEMU side should improve performance significantly.  =
And it shouldn't be
> > > > > > > > >> too hard to implement.
> > > > > > > > >>
> > > > > > > > >> Performance over virtual interfaces may potentially be i=
mproved by creating
> > > > > > > > >> a kernel thread for async Tx.  Similarly to what io_urin=
g allows.  Currently
> > > > > > > > >> Tx on non-zero-copy interfaces is synchronous, and that =
doesn't allow to
> > > > > > > > >> scale well.
> > > > > > > > >
> > > > > > > > > Interestingly, actually, there are a lot of "duplication"=
 between
> > > > > > > > > io_uring and AF_XDP:
> > > > > > > > >
> > > > > > > > > 1) both have similar memory model (user register)
> > > > > > > > > 2) both use ring for communication
> > > > > > > > >
> > > > > > > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > > > > > > >
> > > > > > > > Well, if we submit poll() in QEMU main loop via io_uring, t=
hen we can
> > > > > > > > avoid cost of the synchronous Tx for non-zero-copy modes, i=
.e. for
> > > > > > > > virtual interfaces.  io_uring thread in the kernel will be =
able to
> > > > > > > > perform transmission for us.
> > > > > > >
> > > > > > > It would be nice if we can use iothread/vhost other than the =
main loop
> > > > > > > even if io_uring can use kthreads. We can avoid the memory tr=
anslation
> > > > > > > cost.
> > > > > >
> > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm w=
orking
> > > > > > on patches to re-enable it and will probably send them in July.=
 The
> > > > > > patches also add an API to submit arbitrary io_uring operations=
 so
> > > > > > that you can do stuff besides file descriptor monitoring. Both =
the
> > > > > > main loop and IOThreads will be able to use io_uring on Linux h=
osts.
> > > > >
> > > > > Just to make sure I understand. If we still need a copy from gues=
t to
> > > > > io_uring buffer, we still need to go via memory API for GPA which
> > > > > seems expensive.
> > > > >
> > > > > Vhost seems to be a shortcut for this.
> > > >
> > > > I'm not sure how exactly you're thinking of using io_uring.
> > > >
> > > > Simply using io_uring for the event loop (file descriptor monitorin=
g)
> > > > doesn't involve an extra buffer, but the packet payload still needs=
 to
> > > > reside in AF_XDP umem, so there is a copy between guest memory and
> > > > umem.
> > >
> > > So there would be a translation from GPA to HVA (unless io_uring
> > > support 2 stages) which needs to go via qemu memory core. And this
> > > part seems to be very expensive according to my test in the past.
> >
> > Yes, but in the current approach where AF_XDP is implemented as a QEMU
> > netdev, there is already QEMU device emulation (e.g. virtio-net)
> > happening. So the GPA to HVA translation will happen anyway in device
> > emulation.
>
> Just to make sure we're on the same page.
>
> I meant, AF_XDP can do more than e.g 10Mpps. So if we still use the
> QEMU netdev, it would be very hard to achieve that if we stick to
> using the Qemu memory core translations which need to take care about
> too much extra stuff. That's why I suggest using vhost in io threads
> which only cares about ram so the translation could be very fast.

What does using "vhost in io threads" mean? Is that a vhost kernel
approach where userspace dedicates threads (the stuff that Mike
Christie has been working on)? I haven't looked at how Mike's recent
patches work, but I wouldn't call that approach QEMU IOThreads,
because the threads probably don't run the AioContext event loop and
instead execute vhost kernel code the entire time.

But despite these questions, I think I'm beginning to understand that
you're proposing a vhost_net.ko AF_XDP implementation instead of a
userspace QEMU AF_XDP netdev implementation. I wonder if any
optimizations can be made when the AF_XDP user is kernel code instead
of userspace code.

> >
> > Are you thinking about AF_XDP passthrough where the guest directly
> > interacts with AF_XDP?
>
> This could be another way to solve, since it won't use Qemu's memory
> core to do the translation.
>
> >
> > > > If umem encompasses guest memory,
> > >
> > > It requires you to pin the whole guest memory and a GPA to HVA
> > > translation is still required.
> >
> > Ilya mentioned that umem uses relative offsets instead of absolute
> > memory addresses. In the AF_XDP passthrough case this means no address
> > translation needs to be added to AF_XDP.
>
> I don't see how it can avoid the translations as it works at the level
> of HVA. But what guests submit is PA or even IOVA.

In a passthrough scenario the guest is doing AF_XDP, so it writes
relative umem offsets, thereby eliminating address translation
concerns (the addresses are not PAs or IOVAs). However, this approach
probably won't work well with memory hotplug - or at least it will end
up becoming a memory translation mechanism in order to support memory
hotplug.

>
> What's more, guest memory could be backed by different memory
> backends, this means a single umem may not even work.

Maybe. I don't know the nature of umem. If there can be multiple vmas
in the umem range, then there should be no issue mixing different
memory backends.

>
> >
> > Regarding pinning - I wonder if that's something that can be refined
> > in the kernel by adding an AF_XDP flag that enables on-demand pinning
> > of umem. That way only rx and tx buffers that are currently in use
> > will be pinned. The disadvantage is the runtime overhead to pin/unpin
> > pages. I'm not sure whether it's possible to implement this, I haven't
> > checked the kernel code.
>
> It requires the device to do page faults which is not commonly
> supported nowadays.

I don't understand this comment. AF_XDP processes each rx/tx
descriptor. At that point it can getuserpages() or similar in order to
pin the page. When the memory is no longer needed, it can put those
pages. No fault mechanism is needed. What am I missing?

Stefan

