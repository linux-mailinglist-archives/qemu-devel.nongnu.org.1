Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB2741FDF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 07:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEkAb-0007dN-UY; Thu, 29 Jun 2023 01:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEkAU-0007Za-8t
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 01:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEkAQ-0002g5-RA
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 01:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688016364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kfIL9kqKZCduqltBfC2WmjL3xUpvvamz1WKjIdtTAg=;
 b=ahK31GMlBRFb/PHpTwzIVD19b8SCAmtFOGNmVNQIWO6rVY8AVGlHPUXJff6h2G/RCKeLLj
 g4os7+FOQQZ1bwcpxU8+i8147abI1gefzCW/dcVd6U2EZFPLywCjVWa4vLVxhQADJUgCf7
 JE2NYe7ksq8ZJ4uIqtBlIYrsaFysWt0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Oej58HrEP3GI-o-yBdUDOg-1; Thu, 29 Jun 2023 01:26:02 -0400
X-MC-Unique: Oej58HrEP3GI-o-yBdUDOg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb87c48aceso286585e87.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 22:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688016361; x=1690608361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kfIL9kqKZCduqltBfC2WmjL3xUpvvamz1WKjIdtTAg=;
 b=XMmXMfsjO5tsoskd9hP7wwuqAqt+HkzKLOf81JptFnrs5KjstZKverynMMFDXskmV9
 mkiXxUpouYnwdm327tcGRilQ2PLotnTMUP32tooEu+bxGEs/CeVbyPMdmGil+95UNWoT
 Em16IyEyTn9GFVOQqKbe1RPZ8weai9P7eNURhxnqbK/8fDOu6hyAjbrNSI6q2R40f/d3
 fBWNRN7Q4eTNDO1G51zyhpFBPE37SPFXHGoK54I18/g7ceyjnKPXXG/ZhL9HEyYoNgE2
 bbiB4wN67ALzIKqRV1rzn0Eqxi81CaYvGy5p5naRaxeWOfIKv7x2ddq/wrFtizqEJpdh
 YzTg==
X-Gm-Message-State: AC+VfDzligXSvp5CNIBCG626pxERR/JEtcg27Q4MovB+c/a2hCfI6RXD
 MM+8vqbaeP8FZl1wKyfB1OG8CEJOkD6uzA9uFrgY1f7jkeRC7E6j6W1oyrgkL8noTrTDmyB7VLe
 9RGR86hktoVGiHsxFqnzlLfpfsagBKoE=
X-Received: by 2002:a05:6512:3f24:b0:4fa:d522:a38e with SMTP id
 y36-20020a0565123f2400b004fad522a38emr9717628lfa.35.1688016361444; 
 Wed, 28 Jun 2023 22:26:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UXqSC+/nBRBDkGFsVcRG7oZhtQ2xil+dHMsOTscozHwihkfKPJbWejof+cQlsCzFoDlvdKIoBLSXIR9v1Vig=
X-Received: by 2002:a05:6512:3f24:b0:4fa:d522:a38e with SMTP id
 y36-20020a0565123f2400b004fad522a38emr9717615lfa.35.1688016361136; Wed, 28
 Jun 2023 22:26:01 -0700 (PDT)
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
In-Reply-To: <CAJSP0QW22f18V0pXTO-w4BXONJ3wLCbczMjKSKCRnxiF+7W=eg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 13:25:49 +0800
Message-ID: <CACGkMEvCV6JcQ3LOQvCx=9KXKqE_SAQwzxFXe1c+PdSMH_KbDg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > > >
> > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maxime=
ts@ovn.org> wrote:
> > > > > > >
> > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.ma=
ximets@ovn.org> wrote:
> > > > > > > >>
> > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > >>>>
> > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i=
.maximets@ovn.org> wrote:
> > > > > > > >> It is noticeably more performant than a tap with vhost=3Do=
n in terms of PPS.
> > > > > > > >> So, that might be one case.  Taking into account that just=
 rcu lock and
> > > > > > > >> unlock in virtio-net code takes more time than a packet co=
py, some batching
> > > > > > > >> on QEMU side should improve performance significantly.  An=
d it shouldn't be
> > > > > > > >> too hard to implement.
> > > > > > > >>
> > > > > > > >> Performance over virtual interfaces may potentially be imp=
roved by creating
> > > > > > > >> a kernel thread for async Tx.  Similarly to what io_uring =
allows.  Currently
> > > > > > > >> Tx on non-zero-copy interfaces is synchronous, and that do=
esn't allow to
> > > > > > > >> scale well.
> > > > > > > >
> > > > > > > > Interestingly, actually, there are a lot of "duplication" b=
etween
> > > > > > > > io_uring and AF_XDP:
> > > > > > > >
> > > > > > > > 1) both have similar memory model (user register)
> > > > > > > > 2) both use ring for communication
> > > > > > > >
> > > > > > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > > > > > >
> > > > > > > Well, if we submit poll() in QEMU main loop via io_uring, the=
n we can
> > > > > > > avoid cost of the synchronous Tx for non-zero-copy modes, i.e=
. for
> > > > > > > virtual interfaces.  io_uring thread in the kernel will be ab=
le to
> > > > > > > perform transmission for us.
> > > > > >
> > > > > > It would be nice if we can use iothread/vhost other than the ma=
in loop
> > > > > > even if io_uring can use kthreads. We can avoid the memory tran=
slation
> > > > > > cost.
> > > > >
> > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm wor=
king
> > > > > on patches to re-enable it and will probably send them in July. T=
he
> > > > > patches also add an API to submit arbitrary io_uring operations s=
o
> > > > > that you can do stuff besides file descriptor monitoring. Both th=
e
> > > > > main loop and IOThreads will be able to use io_uring on Linux hos=
ts.
> > > >
> > > > Just to make sure I understand. If we still need a copy from guest =
to
> > > > io_uring buffer, we still need to go via memory API for GPA which
> > > > seems expensive.
> > > >
> > > > Vhost seems to be a shortcut for this.
> > >
> > > I'm not sure how exactly you're thinking of using io_uring.
> > >
> > > Simply using io_uring for the event loop (file descriptor monitoring)
> > > doesn't involve an extra buffer, but the packet payload still needs t=
o
> > > reside in AF_XDP umem, so there is a copy between guest memory and
> > > umem.
> >
> > So there would be a translation from GPA to HVA (unless io_uring
> > support 2 stages) which needs to go via qemu memory core. And this
> > part seems to be very expensive according to my test in the past.
>
> Yes, but in the current approach where AF_XDP is implemented as a QEMU
> netdev, there is already QEMU device emulation (e.g. virtio-net)
> happening. So the GPA to HVA translation will happen anyway in device
> emulation.

Just to make sure we're on the same page.

I meant, AF_XDP can do more than e.g 10Mpps. So if we still use the
QEMU netdev, it would be very hard to achieve that if we stick to
using the Qemu memory core translations which need to take care about
too much extra stuff. That's why I suggest using vhost in io threads
which only cares about ram so the translation could be very fast.

>
> Are you thinking about AF_XDP passthrough where the guest directly
> interacts with AF_XDP?

This could be another way to solve, since it won't use Qemu's memory
core to do the translation.

>
> > > If umem encompasses guest memory,
> >
> > It requires you to pin the whole guest memory and a GPA to HVA
> > translation is still required.
>
> Ilya mentioned that umem uses relative offsets instead of absolute
> memory addresses. In the AF_XDP passthrough case this means no address
> translation needs to be added to AF_XDP.

I don't see how it can avoid the translations as it works at the level
of HVA. But what guests submit is PA or even IOVA.

What's more, guest memory could be backed by different memory
backends, this means a single umem may not even work.

>
> Regarding pinning - I wonder if that's something that can be refined
> in the kernel by adding an AF_XDP flag that enables on-demand pinning
> of umem. That way only rx and tx buffers that are currently in use
> will be pinned. The disadvantage is the runtime overhead to pin/unpin
> pages. I'm not sure whether it's possible to implement this, I haven't
> checked the kernel code.

It requires the device to do page faults which is not commonly
supported nowadays.

Thanks

>
> Stefan
>


