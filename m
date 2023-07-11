Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FF74E7A9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7RM-000212-JT; Tue, 11 Jul 2023 03:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ7RH-0001xY-Ij
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ7RF-0003RM-My
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689059131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aNpXOG9lJMLrAtbbMmaYZsVaxBct6PBmpVjnkbchHo=;
 b=VRSKdf736qKg24xQbCweRFWrKgGDFkOi466U/1bni+/IPGSZIXkktyY5XPcp4jNoqt8C51
 z86jQB1n0Gf2N4ez/secnaEkun32rKmkmlEO2cSk3tr42XrAeOCe6NBXcSAXqXj5a0SY8Z
 3V8ncBFBxU5Dp4sVn1SDgP4O619gU4Q=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-5kv_Z3ceOLOGpfNkX0w8Ow-1; Tue, 11 Jul 2023 03:05:30 -0400
X-MC-Unique: 5kv_Z3ceOLOGpfNkX0w8Ow-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b708e49042so44802241fa.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689059128; x=1691651128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aNpXOG9lJMLrAtbbMmaYZsVaxBct6PBmpVjnkbchHo=;
 b=dLCJI/zmY9I+ToiDVmVLi8tdgpUUhDJzssKXlQsq+FoolUcWPZ3CQVDT0+OP9uY/ZJ
 J9KbFHIg5aa+jBxK98Q/aQ/mYs49+VmG5VddMCnh56YcWVRFfgeTSObWDkg+jEdQ0N3b
 VglqsqfLfbkt9yB/vssqaisxg9RIH3sD36tum8/jw+7KNDHyeTFzTUgsFJz7bqdoM5kF
 lN0cr0Z5HDlrGG4MxIF96GM9V9u414pZwi2lyotAVCD6/LOopUYPxuYESir5nTu82/xs
 PMrE5XleypD61OwKJJoP+QrDYhs5nQftDASyhkKcGbxkq1IY+gFg6eX+Racc8qBOzWaP
 egsA==
X-Gm-Message-State: ABy/qLbPMhXWeBuDaY3kswyzAqXM0lWtRq5adFIjIoqzzrjtfXpwXHwM
 ME4njqPcLZCIrZgjzZ5AzV+cHqBcKbkMeqivVoyGqMJbq8TzWOpw7v/8xWuPAZYof9M0vpEqX+c
 B644IYrhaCQG99qMBmuWSMinQfcjD3kY=
X-Received: by 2002:a2e:8742:0:b0:2a7:adf7:1781 with SMTP id
 q2-20020a2e8742000000b002a7adf71781mr11611829ljj.2.1689059128650; 
 Tue, 11 Jul 2023 00:05:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF6a4CY3N2xNSKzJTsoLh1g3jKo0FrPTCEGsyPrTYPymSSy02f1jjXmBofMXt1GiwPJXgVztf23XEk06QKhX4w=
X-Received: by 2002:a2e:8742:0:b0:2a7:adf7:1781 with SMTP id
 q2-20020a2e8742000000b002a7adf71781mr11611812ljj.2.1689059128288; Tue, 11 Jul
 2023 00:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
 <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
 <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
In-Reply-To: <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 15:05:17 +0800
Message-ID: <CACGkMEu6JQp-KHgoiz=3o=mNb1hkivGUb9WMHSATC_aLo58HnA@mail.gmail.com>
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 11, 2023 at 12:09=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@intel.=
com> wrote:
>
>
>
> On 7/11/2023 10:50 AM, Jason Wang wrote:
> > On Mon, Jul 10, 2023 at 4:53=E2=80=AFPM Zhu Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >> In the poweroff routine, no need to fetch last available index.
> >>
> > This is because there's no concept of shutdown in the vhost layer, it
> > only knows start and stop.
> >
> >> This commit also provides a better debug message in the vhost
> >> caller vhost_virtqueue_stop,
> > A separate patch is better.
> OK
> >
> >> because if vhost does not fetch
> >> the last avail idx successfully, maybe the device does not
> >> suspend, vhost will sync last avail idx to vring used idx as a
> >> work around, not a failure.
> > This only happens if we return a negative value?
> Yes
> >
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   hw/virtio/vhost-vdpa.c | 10 ++++++++++
> >>   hw/virtio/vhost.c      |  2 +-
> >>   2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index 3c575a9a6e..10b445f64e 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -26,6 +26,7 @@
> >>   #include "cpu.h"
> >>   #include "trace.h"
> >>   #include "qapi/error.h"
> >> +#include "sysemu/runstate.h"
> >>
> >>   /*
> >>    * Return one past the end of the end of section. Be careful with ui=
nt64_t
> >> @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct vho=
st_dev *dev,
> >>       struct vhost_vdpa *v =3D dev->opaque;
> >>       int ret;
> >>
> >> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
> >> +        /*
> >> +         * Some devices do not support this call properly,
> >> +         * and we don't need to retrieve the indexes
> >> +         * if it is shutting down
> >> +         */
> >> +        return 0;
> > Checking runstate in the vhost code seems like a layer violation.
> >
> > What happens without this patch?
> vhost tries to fetch vring base,
> vhost_vdpa needs suspend the device before retrieving last_avail_idx.
> However not all devices can support .suspend properly so this call
> may fail.

I think this is where I'm lost. If the device doesn't support
suspending, any reason we only try to fix the case of shutdown?

Btw, the fail is intended:

    if (!v->suspended) {
        /*
         * Cannot trust in value returned by device, let vhost recover used
         * idx from guest.
         */
        return -1;
    }

And if we return to success here, will we go to set an uninitialized
last avail idx?

    r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
    if (r < 0) {
    ...
    }.else {
        virtio_queue_set_last_avail_idx(vdev, idx, state.num);
    }

Thanks

> Then vhost will print an error shows something failed.
>
> The error msg is confused, as stated in the commit log, restoring
> last_avail_idx with guest used idx
> is a workaround rather than a failure. And no needs to fetch last_avail_i=
dx
> when power off.
>
> Thanks
> >
> > Thanks
> >
> >> +    }
> >> +
> >>       if (v->shadow_vqs_enabled) {
> >>           ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev, rin=
g->index);
> >>           return 0;
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index 82394331bf..7dd90cff3a 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
> >>
> >>       r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> >>       if (r < 0) {
> >> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx=
, r);
> >> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used idx=
 for vhost VQ %u", idx);
> >>           /* Connection to the backend is broken, so let's sync intern=
al
> >>            * last avail idx to the device used idx.
> >>            */
> >> --
> >> 2.39.3
> >>
>


