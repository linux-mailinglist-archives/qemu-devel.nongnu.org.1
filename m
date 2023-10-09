Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DAB7BD8A1
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnXY-0006gC-MC; Mon, 09 Oct 2023 06:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qpnXB-0006ft-Tx
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1qpnX9-0005oU-Ps
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696847442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lDI8Jo/kupUGzNTTolBjU8N+C2uym69+pwyQejshEaU=;
 b=EbR4IRrQdOaCcUZFJCbL5EfD8mENzQKjfJYjr6L7O0ppbHrlaoiIejOzqwpDiqsLQMtypM
 TELq99V7FPBrzYXZEVpVOnC2iovVR0Yt8zMBxgtvPeCkogXdZFkcz7fv/Mf8vmf5Pm/OwJ
 oSDNLPAPcl2FrCi9cpaaPQtMs2zSYDk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-n9an4y10OjSBNeR9TCVMfg-1; Mon, 09 Oct 2023 06:29:35 -0400
X-MC-Unique: n9an4y10OjSBNeR9TCVMfg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b2d2d8f9e0so84154466b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696847374; x=1697452174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDI8Jo/kupUGzNTTolBjU8N+C2uym69+pwyQejshEaU=;
 b=d6ewF/jbPbZiMEcwSC0Cy5v+QVReq4rL3iaPpvdlyEK7Qw9s2OBJiWyG09dmdLR+6t
 Kmb16ssyEQeG0ikxtCmE0AgeRehl/l2J5jHOOtxFkd3gWLRUd7J+BGe7+yiMd3R/t7w5
 uce7S886HF/vzyvfCSEkYsDOAcxKj9hTlEi01iw6fFC1xL0flaqQeuBTn3NaRQ/6+BND
 9pphuHKytrWDlItaFnQW3ESq+kbOwn/2xOMJUVk3Pdb5/FTowp+G8VKNgCWOY+2Ul9Zr
 IxnqrtDdx11n+9j/vc50hL70F7DHs8ZphUcBhm7A5e+3bikFvZ60+LRjrc8eVmyfPqh5
 TxCw==
X-Gm-Message-State: AOJu0YzRrmDTN+dpWC730yl2mtS1KWauT9HvWiSGKBrt1eMDFoxSiHM3
 PU/S25JF0Cj1fBq5dXM1elhYkIHv12ysW+YOX8KvJlSavJpcCioSWXMsq93m7RuXWN3L8jgbZqP
 vpq3YQIdTKtEh1nM/TLS1YH++dRg+HqI=
X-Received: by 2002:a17:906:73cc:b0:9ae:5868:c8c9 with SMTP id
 n12-20020a17090673cc00b009ae5868c8c9mr12808046ejl.0.1696847374211; 
 Mon, 09 Oct 2023 03:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsY0Xwq7PU2ddjUW0d8Vhxgg7C7Io17KpwzUgNvL8Jbdv2ZWRd1Ux49ixYRpbp//ZpcVJo+IPvBKx8/EXnGWc=
X-Received: by 2002:a17:906:73cc:b0:9ae:5868:c8c9 with SMTP id
 n12-20020a17090673cc00b009ae5868c8c9mr12808029ejl.0.1696847373842; Mon, 09
 Oct 2023 03:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com>
 <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
In-Reply-To: <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
From: German Maglione <gmaglione@redhat.com>
Date: Mon, 9 Oct 2023 12:28:56 +0200
Message-ID: <CAJh=p+5OFrx4nP5rYKrgZ_y02n358wy70c4L0L4fHKQUo9fU5Q@mail.gmail.com>
Subject: Re: [Virtio-fs] (no subject)
To: Yajun Wu <yajunw@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org, 
 virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 maxime.coquelin@redhat.com, parav@nvidia.com, 
 Anton Kuchin <antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Oct 7, 2023 at 4:23=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
>
> On 10/6/2023 6:34 PM, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
> >> On 06.10.23 11:26, Michael S. Tsirkin wrote:
> >>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
> >>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
> >>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
> >>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
> >>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
> >>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
> >>>>>>>>> There is no clearly defined purpose for the virtio status byte =
in
> >>>>>>>>> vhost-user: For resetting, we already have RESET_DEVICE; and fo=
r virtio
> >>>>>>>>> feature negotiation, we have [GS]ET_FEATURES.  With the REPLY_A=
CK
> >>>>>>>>> protocol extension, it is possible for SET_FEATURES to return e=
rrors
> >>>>>>>>> (SET_PROTOCOL_FEATURES may be called before SET_FEATURES).
> >>>>>>>>>
> >>>>>>>>> As for implementations, SET_STATUS is not widely implemented.  =
dpdk does
> >>>>>>>>> implement it, but only uses it to signal feature negotiation fa=
ilure.
> >>>>>>>>> While it does log reset requests (SET_STATUS 0) as such, it eff=
ectively
> >>>>>>>>> ignores them, in contrast to RESET_OWNER (which is deprecated, =
and today
> >>>>>>>>> means the same thing as RESET_DEVICE).
> >>>>>>>>>
> >>>>>>>>> While qemu superficially has support for [GS]ET_STATUS, it does=
 not
> >>>>>>>>> forward the guest-set status byte, but instead just makes it up
> >>>>>>>>> internally, and actually completely ignores what the back-end r=
eturns,
> >>>>>>>>> only using it as the template for a subsequent SET_STATUS to ad=
d single
> >>>>>>>>> bits to it.  Notably, after setting FEATURES_OK, it never reads=
 it back
> >>>>>>>>> to see whether the flag is still set, which is the only way in =
which
> >>>>>>>>> dpdk uses the status byte.
> >>>>>>>>>
> >>>>>>>>> As-is, no front-end or back-end can rely on the other side hand=
ling this
> >>>>>>>>> field in a useful manner, and it also provides no practical use=
 over
> >>>>>>>>> other mechanisms the vhost-user protocol has, which are more cl=
early
> >>>>>>>>> defined.  Deprecate it.
> >>>>>>>>>
> >>>>>>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>      docs/interop/vhost-user.rst | 28 +++++++++++++++++++++----=
---
> >>>>>>>>>      1 file changed, 21 insertions(+), 7 deletions(-)
> >>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>> SET_STATUS is the only way to signal failure to acknowledge FEATU=
RES_OK.
> >>>>>>> The fact current backends never check errors does not mean they n=
ever
> >>>>>>> will. So no, not applying this.
> >>>>>> Can this not be done with REPLY_ACK?  I.e., with the following mes=
sage
> >>>>>> order:
> >>>>>>
> >>>>>> 1. GET_FEATURES to find out whether VHOST_USER_F_PROTOCOL_FEATURES=
 is
> >>>>>> present
> >>>>>> 2. GET_PROTOCOL_FEATURES to hopefully get VHOST_USER_PROTOCOL_F_RE=
PLY_ACK
> >>>>>> 3. SET_PROTOCOL_FEATURES to set VHOST_USER_PROTOCOL_F_REPLY_ACK
> >>>>>> 4. SET_FEATURES with need_reply
> >>>>>>
> >>>>>> If not, the problem is that qemu has sent SET_STATUS 0 for a while=
 when the
> >>>>>> vCPUs are stopped, which generally seems to request a device reset=
.  If we
> >>>>>> don=E2=80=99t state at least that SET_STATUS 0 is to be ignored, b=
ack-ends that will
> >>>>>> implement SET_STATUS later may break with at least these qemu vers=
ions.  But
> >>>>>> documenting that a particular use of the status byte is to be igno=
red would
> >>>>>> be really strange.
> >>>>>>
> >>>>>> Hanna
> >>>>> Hmm I guess. Though just following virtio spec seems cleaner to me.=
..
> >>>>> vhost-user reconfigures the state fully on start.
> >>>> Not the internal device state, though.  virtiofsd has internal state=
, and
> >>>> other devices like vhost-gpu back-ends would probably, too.
> >>>>
> >>>> Stefan has recently sent a series
> >>>> (https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg00709.h=
tml) to
> >>>> put the reset (RESET_DEVICE) into virtio_reset() (when we really nee=
d a
> >>>> reset).
> >>>>
> >>>> I really don=E2=80=99t like our current approach with the status byt=
e. Following the
> >>>> virtio specification to me would mean that the guest directly contro=
ls this
> >>>> byte, which it does not.  qemu makes up values as it deems appropria=
te, and
> >>>> this includes sending a SET_STATUS 0 when the guest is just paused, =
i.e.
> >>>> when the guest really doesn=E2=80=99t want a device reset.
> >>>>
> >>>> That means that qemu does not treat this as a virtio device field (b=
ecause
> >>>> that would mean exposing it to the guest driver), but instead treats=
 it as
> >>>> part of the vhost(-user) protocol.  It doesn=E2=80=99t feel right to=
 me that we use
> >>>> a virtio-defined feature for communication on the vhost level, i.e. =
between
> >>>> front-end and back-end, and not between guest driver and device.  I =
think
> >>>> all vhost-level protocol features should be fully defined in the vho=
st-user
> >>>> specification, which REPLY_ACK is.
> >>> Hmm that makes sense. Maybe we should have done what stefan's patch
> >>> is doing.
> >>>
> >>> Do look at the original commit that introduced it to understand why
> >>> it was added.
> >> I don=E2=80=99t understand why this was added to the stop/cont code, t=
hough.  If it
> >> is time consuming to make these changes, why are they done every time =
the VM
> >> is paused
> >> and resumed?  It makes sense that this would be done for the initial
> >> configuration (where a reset also wouldn=E2=80=99t hurt), but here it =
seems wrong.
> >>
> >> (To be clear, a reset in the stop/cont code is wrong, because it break=
s
> >> stateful devices.)
> >>
> >> Also, note the newer commits 6f8be29ec17 and c3716f260bf.  The reset a=
s
> >> originally introduced was wrong even for non-stateful devices, because=
 it
> >> occurred before we fetched the state (vring indices) so we could resto=
re it
> >> later.  I don=E2=80=99t know how 923b8921d21 was tested, but if the ba=
ck-end used
> >> for testing implemented SET_STATUS 0 as a reset, it could not have sur=
vived
> >> either migration or a stop/cont in general, because the vring indices =
would
> >> have been reset to 0.
> >>
> >> What I=E2=80=99m saying is, 923b8921d21 introduced SET_STATUS calls th=
at broke all
> >> devices that would implement them as per virtio spec, and even today i=
t=E2=80=99s
> >> broken for stateful devices.  The mentioned performance issue is likel=
y
> >> real, but we can=E2=80=99t address it by making up SET_STATUS calls th=
at are wrong.
> >>
> >> I concede that I didn=E2=80=99t think about DRIVER_OK.  Personally, I =
would do all
> >> final configuration that would happen upon a DRIVER_OK once the first =
vring
> >> is started (i.e. receives a kick).  That has the added benefit of bein=
g
> >> asynchronous because it doesn=E2=80=99t block any vhost-user messages =
(which are
> >> synchronous, and thus block downtime).
> >>
> >> Hanna
> >
> > For better or worse kick is per ring. It's out of spec to start rings
> > that were not kicked but I guess you could do configuration ...
> > Seems somewhat asymmetrical though.
> >
> > Let's wait until next week, hopefully Yajun Wu will answer.
> The main motivation of adding VHOST_USER_SET_STATUS is to let backend
> DPDK know
> when DRIVER_OK bit is valid. It's an indication of all VQ configuration
> has sent,
> otherwise DPDK has to rely on first queue pair is ready, then
> receiving/applying
> VQ configuration one by one.
>
> During live migration, configuring VQ one by one is very time consuming.
> For VIRTIO
> net vDPA, HW needs to know how many VQs are enabled to set
> RSS(Receive-Side Scaling).
>
> If you don=E2=80=99t want SET_STATUS message, backend can remove protocol
> feature bit
> VHOST_USER_PROTOCOL_F_STATUS.
> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device
> close/reset.

This is incorrect, resetting the device on GET_VRING_BASE breaks
the stop/cont. Since you don't want to reset the VQs on stop/cont.

>
> I'm not involved in discussion about adding SET_STATUS in Vhost
> protocol. This feature
> is essential for vDPA(same as vhost-vdpa implements VHOST_VDPA_SET_STATUS=
).
>
> Thanks,
> Yajun
> >
> >>>> Now, we could hand full control of the status byte to the guest, and=
 that
> >>>> would make me content.  But I feel like that doesn=E2=80=99t really =
work, because
> >>>> qemu needs to intercept the status byte anyway (it needs to know whe=
n there
> >>>> is a reset, probably wants to know when the device is configured, et=
c.), so
> >>>> I don=E2=80=99t think having the status byte in vhost-user really ga=
ins us much when
> >>>> qemu could translate status byte changes to/from other vhost-user co=
mmands.
> >>>>
> >>>> Hanna
> >>> well it intercepts it but I think it could pass it on unchanged.
> >>>
> >>>
> >>>>> I guess symmetry was the
> >>>>> point. So I don't see why SET_STATUS 0 has to be ignored.
> >>>>>
> >>>>>
> >>>>> SET_STATUS was introduced by:
> >>>>>
> >>>>> commit 923b8921d210763359e96246a58658ac0db6c645
> >>>>> Author: Yajun Wu <yajunw@nvidia.com>
> >>>>> Date:   Mon Oct 17 14:44:52 2022 +0800
> >>>>>
> >>>>>        vhost-user: Support vhost_dev_start
> >>>>>
> >>>>> CC the author.
> >>>>>
>
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://listman.redhat.com/mailman/listinfo/virtio-fs



--=20
German


