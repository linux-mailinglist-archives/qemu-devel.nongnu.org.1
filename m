Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7207282E7
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gna-0000nV-I7; Thu, 08 Jun 2023 10:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7GnZ-0000nH-Bl
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7GnX-0007Dp-FC
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686235174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0WBd6ndkHcvMOCBGtWSCyAefdNjRpTrztY8fBi7rJY=;
 b=az9QSMrjqE0FYrv9ex1a6Me3ABLuOvugPQjnr6Db9oGwDD9Fizw8ddxvSWmOpU3Rn0iLvo
 mUCnZ+k5ZIWFlMf1OjzdZeW2uqbSA2/tTh95BggjCRsFpmU1aLsQHMc7jswYmUoQZm10Zo
 gJNhAUZoeu1wEYJ0w8GQI6BT/mbrmdY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-feofHE7QMwitObVb7tsfTA-1; Thu, 08 Jun 2023 10:39:33 -0400
X-MC-Unique: feofHE7QMwitObVb7tsfTA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-565ef5a707dso9527757b3.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235172; x=1688827172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0WBd6ndkHcvMOCBGtWSCyAefdNjRpTrztY8fBi7rJY=;
 b=EJ78FldzdbHbXnkN4dGTJPPWp6eqwTcRzu+qbg0R1789AA4yHHIk3KioMeWk8AOYVd
 DW/K2UfApIG3DKRZn+ZyOb2Szhwomq7dfT25XNpn3+P9YQYPqDjCdPfxBivEKL/8mflG
 xrW6lG5II/lNGPneqm9xEub5zMwMGj6/zv/U+UOvNo+Pbp4otR8UEapzwuaRlyAvnptD
 hTWNxy1+z1/+1SfTGo4s/WTVz4OWXFEvnOik8hJ++7BxD7vJeWn3The4D/gZNJ1BqrFD
 ZOrlDkvLUQtNw+qHu6b2zYE6Le3yDc911l1uh3bX1QMPi2+P1w648c3YyzDaS6A0abl1
 BpTw==
X-Gm-Message-State: AC+VfDxduc4mkjSpOOg6nPXvySjSlJmEtj+E6z22xHU57BCB2+OaW9OB
 K5QuC1Ff1/Tg8RPeCHjMK1Db3h2bCAApuHtiUjvr1ygkvZ1zagrZccqjAj+F4j5Y9Ift9njtoTM
 t4nN/mh5qu3mN+WpJSqnLM0WsG0/ey7k=
X-Received: by 2002:a0d:d48f:0:b0:561:81b:7319 with SMTP id
 w137-20020a0dd48f000000b00561081b7319mr8805630ywd.32.1686235172595; 
 Thu, 08 Jun 2023 07:39:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51QKvcsC148AmhjioA3PNfrPcx3JAnCKoFdmRV4LKFwEoQZusWF7jdfo/5twVjE0IEGfbc9pON6iujIiOBhy4=
X-Received: by 2002:a0d:d48f:0:b0:561:81b:7319 with SMTP id
 w137-20020a0dd48f000000b00561081b7319mr8805605ywd.32.1686235172222; Thu, 08
 Jun 2023 07:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
 <65fd10d6-2ede-3e91-4356-36623b53db5a@intel.com>
 <CAJaqyWfgeN1u97z5W0Z6cCrJYrZBRV1p9je3_DoOv2XghY9XTw@mail.gmail.com>
 <b3b911b8-3064-21cf-7fa5-adfb597d8cf7@intel.com>
 <CAJaqyWetO0gcZ+yjT5PURrzFZceq5RApW9Vf6mypLnXn=fpXmQ@mail.gmail.com>
 <f0470ef6-9882-22a5-c7a9-d9b8d0cd1c8a@intel.com>
In-Reply-To: <f0470ef6-9882-22a5-c7a9-d9b8d0cd1c8a@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 8 Jun 2023 16:38:56 +0200
Message-ID: <CAJaqyWfQFgevbx5gTK7r3=5RV3_mFt8qrkC4r0ZkdN3Lvbj81Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jun 8, 2023 at 3:38=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
>
>
> On 6/8/2023 6:59 PM, Eugenio Perez Martin wrote:
> > On Thu, Jun 8, 2023 at 11:34=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@int=
el.com> wrote:
> >>
> >>
> >> On 6/8/2023 4:49 PM, Eugenio Perez Martin wrote:
> >>> On Thu, Jun 8, 2023 at 9:07=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@in=
tel.com> wrote:
> >>>>
> >>>> On 6/7/2023 9:51 PM, Eugenio Perez Martin wrote:
> >>>>> On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Zhu Lingshan <lingshan.zhu@=
intel.com> wrote:
> >>>>>> When read the state of a virtqueue, vhost_vdpa need
> >>>>>> to check whether the device is suspended.
> >>>>>>
> >>>>>> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
> >>>>>> negotiated when checking vhost_vdpa->suspended.
> >>>>>>
> >>>>> I'll add: Otherwise, qemu prints XXX error message.
> >>>>>
> >>>>> On second thought, not returning an error prevents the caller
> >>>>> (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
> >>>>> guest.
> >>>>>
> >>>>> I'm not sure about the right fix for this, should we call
> >>>>> virtio_queue_restore_last_avail_idx here? Communicate that the back=
end
> >>>>> cannot suspend so vhost.c can print a better error message?
> >>>> I agree it is better not to return an error.
> >>>>
> >>>> Instead if neither the device does not support _F_SUSPEND nor failed=
 to
> >>>> suspend,
> >>>> I think vhost_vdpa should try to read the last_avail_idx from
> >>>> the device anyway. We can print an error message here,
> >>>> like: failed to suspend, the value may not reliable.
> >>>>
> >>> We need to drop that value if it is not reliable. If the device keeps
> >>> using descriptors, used_idx may increase beyond avail_idx, so the
> >>> usual is to just restore whatever used_idx value the guest had at
> >>> stop.
> >> This interface is used to read the last_avail_idx, the ideal case
> >> is to fetch it after device has been suspended.
> >>
> >> If the device is not suspended, the value may be unreliable
> >> because the device may keep consuming descriptors.
> >> However at that moment, the guest may be freezed as well,
> >> so the guest wouldn't supply more available descriptors to the device.
> >>
> > Actually, if we cannot suspend the device we reset it, as we cannot
> > afford to modify used_idx.
> >
> > I'm thinking now that your original idea was way better to be honest.
> > To not call vhost_get_vring_base in case the VM is shutting down and
> > we're not migrating seems to fit the situation way better. We save an
> > ioctl / potential device call for nothing.
> agree, but I failed to find a code patch indicting the VM is in
> "shutting down" status, and it may be overkill to add
> a new status field which only used here.
>

Since vhost is stopped before migration of the net device state, I
think runstate_check returns differently depending on the case. If
migrating, runstate_check(RUN_STATE_SHUTDOWN) would return false. If
shutdown without migration, it would return true.

I didn't test it though.

Thanks!

> So maybe a fix like this:
> 1) if the device does not support _F_SUSPEND:
> call virtio_queue_restore_last_avail_idx(dev, state->index)
> 2) if the device support _F_SUSPEND but failed to suspend:
> return -1 and vhost_virtqueue_stop() will call
> virtio_queue_restore_last_avail_idx()
> in the original code path.
>
> Does this look good to you?
> >
> >> I think that means the last_avail_idx may not be reliable but still sa=
fe,
> >> better than read nothing. Because the last_avail_idx always lags behin=
d
> >> the in-guest avail_idx.
> >>
> > Assuming we're migrating and we don't either reset or suspend the devic=
e
> > * guest set avail_idx=3D3
> > * device fetch last_avail_idx=3D3
> > * guest set avail_idx=3D6
> > * VM_SUSPEND
> > * we call unreliable get_vring_base, and obtain device state 3.
> > * device is not reset, so it reads guest's avail_idx =3D 6. It can
> > process the descriptors in avail_idx position 3, 4 and 5, and write
> > that used_idx.
> > * virtio_load detects that inconsistency, as (uint)last_avail_idx -
> > (uint)used_idx > vring size.
> >
> > So I think we need to keep printing an error and recovery from the
> > guest as a fallback.
> so true, I think that is virtio_queue_restore_last_avail_idx()
> >
> >> I am not sure we can restore last_avail_idx with last_used_idx, there =
is
> >> always
> >> a delta between them.
> >>
> > Yes, we assume it is safe to process these descriptors again or that
> > they'll be migrated when that is supported.
> >
> > In any case, if a device does not work with this, we should be more
> > restrictive, not less.
> >
> > Does it make sense to you?
> Yes, so if the device doesn't support _F_SUSPEND, we call
> virtio_queue_restore_last_avail_idx()
> in vhost_vdpa_get_vring_base(), look good?
>
> Thanks
> >
> > Thanks!
> >
> >> Thanks
> >>
> >>> Thanks!
> >>>
> >>>> Thanks
> >>>>> Thanks!
> >>>>>
> >>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>>>> ---
> >>>>>>     hw/virtio/vhost-vdpa.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>>>> index b3094e8a8b..ae176c06dd 100644
> >>>>>> --- a/hw/virtio/vhost-vdpa.c
> >>>>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>>>> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct =
vhost_dev *dev,
> >>>>>>             return 0;
> >>>>>>         }
> >>>>>>
> >>>>>> -    if (!v->suspended) {
> >>>>>> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && =
(!v->suspended)) {
> >>>>>>             /*
> >>>>>>              * Cannot trust in value returned by device, let vhost=
 recover used
> >>>>>>              * idx from guest.
> >>>>>> --
> >>>>>> 2.39.1
> >>>>>>
>


