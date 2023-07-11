Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF63274E821
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:36:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7u1-0006Mw-FZ; Tue, 11 Jul 2023 03:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ7tu-0006MS-Tu
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ7ts-0003kx-QE
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689060908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IufxAZKAIjmYi6bpPb45461CcHnTbksoHZOVfc1kFX0=;
 b=QE8D8qsL1hrxCfsaQKGOryN4rUgoWfmtJgt2/HXrCaKNfNqQtsO6XbGQ7jSY4ccGTvZMfW
 RTIAJVkVY8dgXDV8pFohzPFb7vA4ealbVgeTcp44SMhYYwgJvFxTB715UE0SsfoEhh+oWp
 piAnufa9FOz00rw79ov/2HGV1hutlmg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-i2VELMdIOnWzaVkVtOO5tg-1; Tue, 11 Jul 2023 03:35:04 -0400
X-MC-Unique: i2VELMdIOnWzaVkVtOO5tg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6fbee0642so32200321fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689060903; x=1691652903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IufxAZKAIjmYi6bpPb45461CcHnTbksoHZOVfc1kFX0=;
 b=Mk0GkIithEaTiHy6gdhR9mkkRhUb9wWGdvc/r6PlqotkelbAzoBA6uEu0pFVWJ0XAa
 1Hj5K4wmUMyazyr3igZWUnNNSmr66vH5jlJc1pwibyNJtftia8gnAg8N5Z5csLpYEjV8
 nDfccXz4byP2pDUWmccmoZqFoj4c3DD8QdRoN0JQPRFJ7a1yA+MXD7oPYuPXLxTgiUUr
 3jkeGSv+8hOmMNETUdfbTu/SYQpH2BaRaEe8CSdFDzivzHRaFyl+/A8V2MJLGqmUfGnv
 0npn/R+14AJarTBn4+svpkxgnQsxQiBaOQdkNIEeE+BENBZWMKjwYTRlIbTiH95xwte1
 /PeA==
X-Gm-Message-State: ABy/qLbjtMvzxbInalzSx+8FXKJefGmYed5flEycMrB/7B4KnykHFA7E
 9EOAivASNGZSJ4Pno9EenYSDr9Opuk4g1coenphTsQcf+sKora4D4xVsgvJFcH01/SEaszGzeEs
 zfMFeu8NLCPVeB1OByOhRKwVIglkikY4=
X-Received: by 2002:a05:651c:155:b0:2b6:b7c3:bb89 with SMTP id
 c21-20020a05651c015500b002b6b7c3bb89mr5753211ljd.18.1689060903382; 
 Tue, 11 Jul 2023 00:35:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbDLvh1XsOj98ocUYzsw1QNqCvAipxaLIkVBjWEGVUkIb0143elGhoDhdC/U/dApE2Tx5V1Yrs9i4T5otT5N8=
X-Received: by 2002:a05:651c:155:b0:2b6:b7c3:bb89 with SMTP id
 c21-20020a05651c015500b002b6b7c3bb89mr5753204ljd.18.1689060903068; Tue, 11
 Jul 2023 00:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
 <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
 <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
 <CACGkMEu6JQp-KHgoiz=3o=mNb1hkivGUb9WMHSATC_aLo58HnA@mail.gmail.com>
 <CAJaqyWdM2FR1kT6DWtVxcmc=_bNA9k9A-qZXb_kJFkcpHRW2Kg@mail.gmail.com>
In-Reply-To: <CAJaqyWdM2FR1kT6DWtVxcmc=_bNA9k9A-qZXb_kJFkcpHRW2Kg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 15:34:52 +0800
Message-ID: <CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com>
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000021bfba06003123a2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000021bfba06003123a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 3:25=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Tue, Jul 11, 2023 at 9:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Jul 11, 2023 at 12:09=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@in=
tel.com>
> wrote:
> > >
> > >
> > >
> > > On 7/11/2023 10:50 AM, Jason Wang wrote:
> > > > On Mon, Jul 10, 2023 at 4:53=E2=80=AFPM Zhu Lingshan <lingshan.zhu@=
intel.com>
> wrote:
> > > >> In the poweroff routine, no need to fetch last available index.
> > > >>
> > > > This is because there's no concept of shutdown in the vhost layer, =
it
> > > > only knows start and stop.
> > > >
> > > >> This commit also provides a better debug message in the vhost
> > > >> caller vhost_virtqueue_stop,
> > > > A separate patch is better.
> > > OK
> > > >
> > > >> because if vhost does not fetch
> > > >> the last avail idx successfully, maybe the device does not
> > > >> suspend, vhost will sync last avail idx to vring used idx as a
> > > >> work around, not a failure.
> > > > This only happens if we return a negative value?
> > > Yes
> > > >
> > > >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > >> ---
> > > >>   hw/virtio/vhost-vdpa.c | 10 ++++++++++
> > > >>   hw/virtio/vhost.c      |  2 +-
> > > >>   2 files changed, 11 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > > >> index 3c575a9a6e..10b445f64e 100644
> > > >> --- a/hw/virtio/vhost-vdpa.c
> > > >> +++ b/hw/virtio/vhost-vdpa.c
> > > >> @@ -26,6 +26,7 @@
> > > >>   #include "cpu.h"
> > > >>   #include "trace.h"
> > > >>   #include "qapi/error.h"
> > > >> +#include "sysemu/runstate.h"
> > > >>
> > > >>   /*
> > > >>    * Return one past the end of the end of section. Be careful wit=
h
> uint64_t
> > > >> @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct
> vhost_dev *dev,
> > > >>       struct vhost_vdpa *v =3D dev->opaque;
> > > >>       int ret;
> > > >>
> > > >> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
> > > >> +        /*
> > > >> +         * Some devices do not support this call properly,
> > > >> +         * and we don't need to retrieve the indexes
> > > >> +         * if it is shutting down
> > > >> +         */
> > > >> +        return 0;
> > > > Checking runstate in the vhost code seems like a layer violation.
> > > >
> > > > What happens without this patch?
> > > vhost tries to fetch vring base,
> > > vhost_vdpa needs suspend the device before retrieving last_avail_idx.
> > > However not all devices can support .suspend properly so this call
> > > may fail.
> >
> > I think this is where I'm lost. If the device doesn't support
> > suspending, any reason we only try to fix the case of shutdown?
> >
> > Btw, the fail is intended:
> >
> >     if (!v->suspended) {
> >         /*
> >          * Cannot trust in value returned by device, let vhost recover
> used
> >          * idx from guest.
> >          */
> >         return -1;
> >     }
> >
>
> The fail is intended, but to recover the last used idx, either from
> device or from the guest, is only useful in the case of migration.
>

Note that we had userspace devices like VDUSE now, so it could be useful in
the case of a VDUSE daemon crash or reconnect.


> I think the main problem is the error message, actually. But I think
> it has no use either to recover last_avail_idx or print a debug
> message if we're not migrating. Another solution would be to recover
> it from the guest at vhost_vdpa_get_vring_base, but I don't like the
> duplication.
>
> > And if we return to success here, will we go to set an uninitialized
> > last avail idx?
> >
>
> It will be either the default value (is set to 0 at
> __virtio_queue_reset) or the one received from a migration (at
> virtio_load).
>

0 is even sub-optimal than the index used. Anyhow, VHOST_DEBUG should not
be enabled for production environments.

Thanks


>
> Thanks!
>
> >     r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> >     if (r < 0) {
> >     ...
> >     }.else {
> >         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
> >     }
> >
> > Thanks
> >
> > > Then vhost will print an error shows something failed.
> > >
> > > The error msg is confused, as stated in the commit log, restoring
> > > last_avail_idx with guest used idx
> > > is a workaround rather than a failure. And no needs to fetch
> last_avail_idx
> > > when power off.
> > >
> > > Thanks
> > > >
> > > > Thanks
> > > >
> > > >> +    }
> > > >> +
> > > >>       if (v->shadow_vqs_enabled) {
> > > >>           ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev,
> ring->index);
> > > >>           return 0;
> > > >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > >> index 82394331bf..7dd90cff3a 100644
> > > >> --- a/hw/virtio/vhost.c
> > > >> +++ b/hw/virtio/vhost.c
> > > >> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev
> *dev,
> > > >>
> > > >>       r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> > > >>       if (r < 0) {
> > > >> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d",
> idx, r);
> > > >> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used
> idx for vhost VQ %u", idx);
> > > >>           /* Connection to the backend is broken, so let's sync
> internal
> > > >>            * last avail idx to the device used idx.
> > > >>            */
> > > >> --
> > > >> 2.39.3
> > > >>
> > >
> >
>
>

--00000000000021bfba06003123a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 11, 2023 at 3:25=E2=80=AF=
PM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezma@redhat.com">eperezma=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Tue, Jul 11, 2023 at 9:05=E2=80=AFAM Jason Wang &lt;<a href=
=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; On Tue, Jul 11, 2023 at 12:09=E2=80=AFPM Zhu, Lingshan &lt;<a href=3D"=
mailto:lingshan.zhu@intel.com" target=3D"_blank">lingshan.zhu@intel.com</a>=
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 7/11/2023 10:50 AM, Jason Wang wrote:<br>
&gt; &gt; &gt; On Mon, Jul 10, 2023 at 4:53=E2=80=AFPM Zhu Lingshan &lt;<a =
href=3D"mailto:lingshan.zhu@intel.com" target=3D"_blank">lingshan.zhu@intel=
.com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt; In the poweroff routine, no need to fetch last available=
 index.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; This is because there&#39;s no concept of shutdown in the vh=
ost layer, it<br>
&gt; &gt; &gt; only knows start and stop.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; This commit also provides a better debug message in the =
vhost<br>
&gt; &gt; &gt;&gt; caller vhost_virtqueue_stop,<br>
&gt; &gt; &gt; A separate patch is better.<br>
&gt; &gt; OK<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; because if vhost does not fetch<br>
&gt; &gt; &gt;&gt; the last avail idx successfully, maybe the device does n=
ot<br>
&gt; &gt; &gt;&gt; suspend, vhost will sync last avail idx to vring used id=
x as a<br>
&gt; &gt; &gt;&gt; work around, not a failure.<br>
&gt; &gt; &gt; This only happens if we return a negative value?<br>
&gt; &gt; Yes<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; Signed-off-by: Zhu Lingshan &lt;<a href=3D"mailto:lingsh=
an.zhu@intel.com" target=3D"_blank">lingshan.zhu@intel.com</a>&gt;<br>
&gt; &gt; &gt;&gt; ---<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0hw/virtio/vhost-vdpa.c | 10 ++++++++++<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A02 files changed, 11 insertions(+), 1 deletio=
n(-)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vd=
pa.c<br>
&gt; &gt; &gt;&gt; index 3c575a9a6e..10b445f64e 100644<br>
&gt; &gt; &gt;&gt; --- a/hw/virtio/vhost-vdpa.c<br>
&gt; &gt; &gt;&gt; +++ b/hw/virtio/vhost-vdpa.c<br>
&gt; &gt; &gt;&gt; @@ -26,6 +26,7 @@<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0#include &quot;cpu.h&quot;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0#include &quot;trace.h&quot;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt; &gt; &gt;&gt; +#include &quot;sysemu/runstate.h&quot;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0/*<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 * Return one past the end of the end of sec=
tion. Be careful with uint64_t<br>
&gt; &gt; &gt;&gt; @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_b=
ase(struct vhost_dev *dev,<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_vdpa *v =3D dev-&=
gt;opaque;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 if (runstate_check(RUN_STATE_SHUTDOWN)) {=
<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Some devices do not=
 support this call properly,<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and we don&#39;t ne=
ed to retrieve the indexes<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if it is shutting d=
own<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt; Checking runstate in the vhost code seems like a layer viola=
tion.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; What happens without this patch?<br>
&gt; &gt; vhost tries to fetch vring base,<br>
&gt; &gt; vhost_vdpa needs suspend the device before retrieving last_avail_=
idx.<br>
&gt; &gt; However not all devices can support .suspend properly so this cal=
l<br>
&gt; &gt; may fail.<br>
&gt;<br>
&gt; I think this is where I&#39;m lost. If the device doesn&#39;t support<=
br>
&gt; suspending, any reason we only try to fix the case of shutdown?<br>
&gt;<br>
&gt; Btw, the fail is intended:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!v-&gt;suspended) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Cannot trust in value returned by =
device, let vhost recover used<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * idx from guest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
<br>
The fail is intended, but to recover the last used idx, either from<br>
device or from the guest, is only useful in the case of migration.<br></blo=
ckquote><div><br></div><div>Note that we had userspace devices like VDUSE n=
ow, so it could be useful in the case of a VDUSE daemon crash or reconnect.=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I think the main problem is the error message, actually. But I think<br>
it has no use either to recover last_avail_idx or print a debug<br>
message if we&#39;re not migrating. Another solution would be to recover<br=
>
it from the guest at vhost_vdpa_get_vring_base, but I don&#39;t like the<br=
>
duplication.<br>
<br>
&gt; And if we return to success here, will we go to set an uninitialized<b=
r>
&gt; last avail idx?<br>
&gt;<br>
<br>
It will be either the default value (is set to 0 at<br>
__virtio_queue_reset) or the one received from a migration (at<br>
virtio_load).<br></blockquote><div><br></div><div>0 is even sub-optimal tha=
n the index used. Anyhow, VHOST_DEBUG should not be enabled for production =
environments.</div><div><br></div><div>Thanks</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks!<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0r =3D dev-&gt;vhost_ops-&gt;vhost_get_vring_base(de=
v, &amp;state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0}.else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_queue_set_last_avail_idx(vdev,=
 idx, state.num);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; &gt; Then vhost will print an error shows something failed.<br>
&gt; &gt;<br>
&gt; &gt; The error msg is confused, as stated in the commit log, restoring=
<br>
&gt; &gt; last_avail_idx with guest used idx<br>
&gt; &gt; is a workaround rather than a failure. And no needs to fetch last=
_avail_idx<br>
&gt; &gt; when power off.<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;&gt; +<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (v-&gt;shadow_vqs_enabled) =
{<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring-&gt;num =3D=
 virtio_queue_get_last_avail_idx(dev-&gt;vdev, ring-&gt;index);<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; &gt;&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; &gt; &gt;&gt; index 82394331bf..7dd90cff3a 100644<br>
&gt; &gt; &gt;&gt; --- a/hw/virtio/vhost.c<br>
&gt; &gt; &gt;&gt; +++ b/hw/virtio/vhost.c<br>
&gt; &gt; &gt;&gt; @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct v=
host_dev *dev,<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D dev-&gt;vhost_ops-&gt;vh=
ost_get_vring_base(dev, &amp;state);<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt; &gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_OPS_DEBUG(r, &quot;vh=
ost VQ %u ring restore failed: %d&quot;, idx, r);<br>
&gt; &gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_OPS_DEBUG(r, &quot;sy=
nc last avail idx to the guest used idx for vhost VQ %u&quot;, idx);<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Connection to=
 the backend is broken, so let&#39;s sync internal<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * last avail id=
x to the device used idx.<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt;&gt; 2.39.3<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--00000000000021bfba06003123a2--


