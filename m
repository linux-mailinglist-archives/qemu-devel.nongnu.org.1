Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395F74E7F3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:27:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7kY-0004qe-J3; Tue, 11 Jul 2023 03:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qJ7kU-0004qQ-Sh
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:25:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qJ7kT-0000d0-7Z
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689060323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSs51oEsjUPFfUP1Z3HVhzYZ0w5XMvAKUS8wMAgeQt4=;
 b=E13yVeISu0Oh53+cTNMLDkw2kkJEG9uaIWwEAFByK335mUcZmTktyzeRP8v4s5M3kHJnqg
 btaRkBn8OeXLtVos1d3lG8F06n21olXivemfynDA1ybuo8lf2a9MvqQC+L+LCV8ek13uqP
 Fm4H0sW94p776cqnxfH65SrlJB5uMac=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-9ntepVSiPaG50r6B9EgNQg-1; Tue, 11 Jul 2023 03:25:22 -0400
X-MC-Unique: 9ntepVSiPaG50r6B9EgNQg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-403b4983a24so12324861cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689060322; x=1691652322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSs51oEsjUPFfUP1Z3HVhzYZ0w5XMvAKUS8wMAgeQt4=;
 b=a2ms1f53wSdrlrmdd9SV4dkhn7NqZYG0Ir8Em9JWidfImVB8AxwOBQYZm+CMo5OznS
 otXAQNNTO5vDE6VwGX0zzXu54oPDpKMUVWEhXG/4TXWkPr3i1Phys7fUyh9CNLG0VauZ
 igCSV68ruq1S86NkWE9rGyyz5xMYo5/GcYZDoc+FXNlnF2eFTkTwwn4e1auF4HUTomcd
 0euYnDXXsPCEVj0jRcWPVGOsW7ulLuzjS9hns66zxAEkMi7qDeV5WeMp2Z80BUDHyY0l
 oiCVdjcmVCr2vJ7B7FmQ15DN5TPY4e1qzpBtvqtlhQDxBTQAw86y4ECrTpDcLEj5Z9QD
 OUUg==
X-Gm-Message-State: ABy/qLYHAa13/x8WrQKfIWv/2reY6BflXkKuBn1F6YGg6yMWBXI+OjXM
 9+JcOIKxTfbC3ZtrK1BSAga4WJMW8dsvGv7aZtFMBSQQ91gc4FRDxAl7A2fH46BmBM+mQCVj8FY
 Iw23JqolqSKjybQ1UVu2+9nDkgdnEQnU=
X-Received: by 2002:a05:622a:88:b0:403:b1d3:2d9d with SMTP id
 o8-20020a05622a008800b00403b1d32d9dmr4055565qtw.48.1689060321819; 
 Tue, 11 Jul 2023 00:25:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEO65GOW3r52Jw7TJcMRJs1vEcSsLBIKY3hJDTWqLplWiseqkvCvaYtlNFCXxRPsSE95XSQBR3C2/ZR2PU1RlI=
X-Received: by 2002:a05:622a:88:b0:403:b1d3:2d9d with SMTP id
 o8-20020a05622a008800b00403b1d32d9dmr4055548qtw.48.1689060321491; Tue, 11 Jul
 2023 00:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
 <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
 <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
 <CACGkMEu6JQp-KHgoiz=3o=mNb1hkivGUb9WMHSATC_aLo58HnA@mail.gmail.com>
In-Reply-To: <CACGkMEu6JQp-KHgoiz=3o=mNb1hkivGUb9WMHSATC_aLo58HnA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Jul 2023 09:24:45 +0200
Message-ID: <CAJaqyWdM2FR1kT6DWtVxcmc=_bNA9k9A-qZXb_kJFkcpHRW2Kg@mail.gmail.com>
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: Jason Wang <jasowang@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Tue, Jul 11, 2023 at 9:05=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Jul 11, 2023 at 12:09=E2=80=AFPM Zhu, Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >
> >
> >
> > On 7/11/2023 10:50 AM, Jason Wang wrote:
> > > On Mon, Jul 10, 2023 at 4:53=E2=80=AFPM Zhu Lingshan <lingshan.zhu@in=
tel.com> wrote:
> > >> In the poweroff routine, no need to fetch last available index.
> > >>
> > > This is because there's no concept of shutdown in the vhost layer, it
> > > only knows start and stop.
> > >
> > >> This commit also provides a better debug message in the vhost
> > >> caller vhost_virtqueue_stop,
> > > A separate patch is better.
> > OK
> > >
> > >> because if vhost does not fetch
> > >> the last avail idx successfully, maybe the device does not
> > >> suspend, vhost will sync last avail idx to vring used idx as a
> > >> work around, not a failure.
> > > This only happens if we return a negative value?
> > Yes
> > >
> > >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > >> ---
> > >>   hw/virtio/vhost-vdpa.c | 10 ++++++++++
> > >>   hw/virtio/vhost.c      |  2 +-
> > >>   2 files changed, 11 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > >> index 3c575a9a6e..10b445f64e 100644
> > >> --- a/hw/virtio/vhost-vdpa.c
> > >> +++ b/hw/virtio/vhost-vdpa.c
> > >> @@ -26,6 +26,7 @@
> > >>   #include "cpu.h"
> > >>   #include "trace.h"
> > >>   #include "qapi/error.h"
> > >> +#include "sysemu/runstate.h"
> > >>
> > >>   /*
> > >>    * Return one past the end of the end of section. Be careful with =
uint64_t
> > >> @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct v=
host_dev *dev,
> > >>       struct vhost_vdpa *v =3D dev->opaque;
> > >>       int ret;
> > >>
> > >> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
> > >> +        /*
> > >> +         * Some devices do not support this call properly,
> > >> +         * and we don't need to retrieve the indexes
> > >> +         * if it is shutting down
> > >> +         */
> > >> +        return 0;
> > > Checking runstate in the vhost code seems like a layer violation.
> > >
> > > What happens without this patch?
> > vhost tries to fetch vring base,
> > vhost_vdpa needs suspend the device before retrieving last_avail_idx.
> > However not all devices can support .suspend properly so this call
> > may fail.
>
> I think this is where I'm lost. If the device doesn't support
> suspending, any reason we only try to fix the case of shutdown?
>
> Btw, the fail is intended:
>
>     if (!v->suspended) {
>         /*
>          * Cannot trust in value returned by device, let vhost recover us=
ed
>          * idx from guest.
>          */
>         return -1;
>     }
>

The fail is intended, but to recover the last used idx, either from
device or from the guest, is only useful in the case of migration.

I think the main problem is the error message, actually. But I think
it has no use either to recover last_avail_idx or print a debug
message if we're not migrating. Another solution would be to recover
it from the guest at vhost_vdpa_get_vring_base, but I don't like the
duplication.

> And if we return to success here, will we go to set an uninitialized
> last avail idx?
>

It will be either the default value (is set to 0 at
__virtio_queue_reset) or the one received from a migration (at
virtio_load).

Thanks!

>     r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
>     if (r < 0) {
>     ...
>     }.else {
>         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
>     }
>
> Thanks
>
> > Then vhost will print an error shows something failed.
> >
> > The error msg is confused, as stated in the commit log, restoring
> > last_avail_idx with guest used idx
> > is a workaround rather than a failure. And no needs to fetch last_avail=
_idx
> > when power off.
> >
> > Thanks
> > >
> > > Thanks
> > >
> > >> +    }
> > >> +
> > >>       if (v->shadow_vqs_enabled) {
> > >>           ring->num =3D virtio_queue_get_last_avail_idx(dev->vdev, r=
ing->index);
> > >>           return 0;
> > >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > >> index 82394331bf..7dd90cff3a 100644
> > >> --- a/hw/virtio/vhost.c
> > >> +++ b/hw/virtio/vhost.c
> > >> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *de=
v,
> > >>
> > >>       r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
> > >>       if (r < 0) {
> > >> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", i=
dx, r);
> > >> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used i=
dx for vhost VQ %u", idx);
> > >>           /* Connection to the backend is broken, so let's sync inte=
rnal
> > >>            * last avail idx to the device used idx.
> > >>            */
> > >> --
> > >> 2.39.3
> > >>
> >
>


