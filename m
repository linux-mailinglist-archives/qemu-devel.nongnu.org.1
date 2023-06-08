Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4966727D6B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 13:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7DMn-00055j-Po; Thu, 08 Jun 2023 06:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7DMl-00055K-3j
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7DMj-0001ar-Fm
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686221980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOWvzjUiRTuVDExOV+88QaHrEI45YjcBKCpHi+RGS08=;
 b=bAymnoEIfBk/P0g2rf+lh3V+PntwFo/IHdD7g0e2Jewzw9inCMyF7L/IZIkE7tO+ntQDK3
 moHAQmLAniXOldRIF2XFLeKrql0UZNQRAg9sYDozKYdusJw0K278nt4klVTV3rG/BsEukU
 w5wk7XOKFvZNG59hYKohWrCzj2cmNsw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-dxOB2ve4MIa5VudN1wZ-uQ-1; Thu, 08 Jun 2023 06:59:39 -0400
X-MC-Unique: dxOB2ve4MIa5VudN1wZ-uQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-565a33c35b1so7347637b3.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686221978; x=1688813978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOWvzjUiRTuVDExOV+88QaHrEI45YjcBKCpHi+RGS08=;
 b=PViG70r7UOl2YzFRM/FgZEtd6Njb3XE78Q08OCbbgB8kKjMO9SPvoPfak5H61hdM/v
 nS5mCvn1I81GH6dltPI8wH32S1L+7YV90tc6tgaj8+vn4Q+j85jZWyCqgskzT1z/G7lA
 xbyzN2j5xd7J/1bCsPjBMnf7fwaF/+rGB6p1UNwXGqIvSC40kenHmNTI0474yddOwWQ5
 Kn6kcebn6cwabbiqaDN3oPlM9o02MxtS/cS4lTiEa0/5BDQjHJ8T/5tiCZ5EL1/uHePq
 bV/ia43TxIemJJaMv9dy57jvP2XFjm9EAoOgF28D+/6lOQ3BwrIDh16TQOTqBOdNUPXN
 jS8Q==
X-Gm-Message-State: AC+VfDzGDUQK+ZTmDWTAoFlG9EcUlwcCNUiVPGgkq3bFMfV5PKu21moG
 2WsWOvYfs/SNOsr9I+WvnmzGzOSHjNj72YRQ+R7AtvE29jDaMSf++SAMgkiIMq/IhZIpGQ1XIX5
 ByFs0r9R3KMGocSQvP4ieBDpnEiz2JvSLym845DYIaQ==
X-Received: by 2002:a81:4996:0:b0:569:75bb:5124 with SMTP id
 w144-20020a814996000000b0056975bb5124mr10112574ywa.35.1686221978543; 
 Thu, 08 Jun 2023 03:59:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ynQFFnVBBmo98wjjAbiNxcGLWRCIOIq573VCyO0Jgw4BJeqmZ9bRJVDo8hg2Fv1iB0Y8BgSeP6zaRhUWOgLw=
X-Received: by 2002:a81:4996:0:b0:569:75bb:5124 with SMTP id
 w144-20020a814996000000b0056975bb5124mr10112559ywa.35.1686221978164; Thu, 08
 Jun 2023 03:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
 <65fd10d6-2ede-3e91-4356-36623b53db5a@intel.com>
 <CAJaqyWfgeN1u97z5W0Z6cCrJYrZBRV1p9je3_DoOv2XghY9XTw@mail.gmail.com>
 <b3b911b8-3064-21cf-7fa5-adfb597d8cf7@intel.com>
In-Reply-To: <b3b911b8-3064-21cf-7fa5-adfb597d8cf7@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 8 Jun 2023 12:59:01 +0200
Message-ID: <CAJaqyWetO0gcZ+yjT5PURrzFZceq5RApW9Vf6mypLnXn=fpXmQ@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 11:34=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.c=
om> wrote:
>
>
>
> On 6/8/2023 4:49 PM, Eugenio Perez Martin wrote:
> > On Thu, Jun 8, 2023 at 9:07=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >>
> >>
> >> On 6/7/2023 9:51 PM, Eugenio Perez Martin wrote:
> >>> On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Zhu Lingshan <lingshan.zhu@in=
tel.com> wrote:
> >>>> When read the state of a virtqueue, vhost_vdpa need
> >>>> to check whether the device is suspended.
> >>>>
> >>>> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
> >>>> negotiated when checking vhost_vdpa->suspended.
> >>>>
> >>> I'll add: Otherwise, qemu prints XXX error message.
> >>>
> >>> On second thought, not returning an error prevents the caller
> >>> (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
> >>> guest.
> >>>
> >>> I'm not sure about the right fix for this, should we call
> >>> virtio_queue_restore_last_avail_idx here? Communicate that the backen=
d
> >>> cannot suspend so vhost.c can print a better error message?
> >> I agree it is better not to return an error.
> >>
> >> Instead if neither the device does not support _F_SUSPEND nor failed t=
o
> >> suspend,
> >> I think vhost_vdpa should try to read the last_avail_idx from
> >> the device anyway. We can print an error message here,
> >> like: failed to suspend, the value may not reliable.
> >>
> > We need to drop that value if it is not reliable. If the device keeps
> > using descriptors, used_idx may increase beyond avail_idx, so the
> > usual is to just restore whatever used_idx value the guest had at
> > stop.
> This interface is used to read the last_avail_idx, the ideal case
> is to fetch it after device has been suspended.
>
> If the device is not suspended, the value may be unreliable
> because the device may keep consuming descriptors.
> However at that moment, the guest may be freezed as well,
> so the guest wouldn't supply more available descriptors to the device.
>

Actually, if we cannot suspend the device we reset it, as we cannot
afford to modify used_idx.

I'm thinking now that your original idea was way better to be honest.
To not call vhost_get_vring_base in case the VM is shutting down and
we're not migrating seems to fit the situation way better. We save an
ioctl / potential device call for nothing.

> I think that means the last_avail_idx may not be reliable but still safe,
> better than read nothing. Because the last_avail_idx always lags behind
> the in-guest avail_idx.
>

Assuming we're migrating and we don't either reset or suspend the device
* guest set avail_idx=3D3
* device fetch last_avail_idx=3D3
* guest set avail_idx=3D6
* VM_SUSPEND
* we call unreliable get_vring_base, and obtain device state 3.
* device is not reset, so it reads guest's avail_idx =3D 6. It can
process the descriptors in avail_idx position 3, 4 and 5, and write
that used_idx.
* virtio_load detects that inconsistency, as (uint)last_avail_idx -
(uint)used_idx > vring size.

So I think we need to keep printing an error and recovery from the
guest as a fallback.

> I am not sure we can restore last_avail_idx with last_used_idx, there is
> always
> a delta between them.
>

Yes, we assume it is safe to process these descriptors again or that
they'll be migrated when that is supported.

In any case, if a device does not work with this, we should be more
restrictive, not less.

Does it make sense to you?

Thanks!

> Thanks
>
> > Thanks!
> >
> >> Thanks
> >>> Thanks!
> >>>
> >>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >>>> ---
> >>>>    hw/virtio/vhost-vdpa.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >>>> index b3094e8a8b..ae176c06dd 100644
> >>>> --- a/hw/virtio/vhost-vdpa.c
> >>>> +++ b/hw/virtio/vhost-vdpa.c
> >>>> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vh=
ost_dev *dev,
> >>>>            return 0;
> >>>>        }
> >>>>
> >>>> -    if (!v->suspended) {
> >>>> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!=
v->suspended)) {
> >>>>            /*
> >>>>             * Cannot trust in value returned by device, let vhost re=
cover used
> >>>>             * idx from guest.
> >>>> --
> >>>> 2.39.1
> >>>>
>


