Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E587EC32C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:01:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3FUV-0007mP-QM; Wed, 15 Nov 2023 07:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3FUS-0007lx-QD
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3FUK-00074E-90
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700053160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGsQus5M/lznIKU18II+lHdaMPFHPVIR4mPte/zsqEQ=;
 b=ZYyu7xUHze3yYMpiNU0DLI2wdx9kOfNtKJD1YQVgbQ1mNhj1M+A4dAQDrqr1ceI5TPmK3j
 OiJAxsIbUW9KdquWWutVk6ybv+QLEvQtVGnwgExdBck0TBbfknfZUUPvSlEHCgU06UVpN6
 seWGFKlI3hP5CaEnMxhhlSPaDgcukRs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-EBQnjiV8MnGOf-mWp0uyqQ-1; Wed,
 15 Nov 2023 07:59:15 -0500
X-MC-Unique: EBQnjiV8MnGOf-mWp0uyqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CFFB2808FD9;
 Wed, 15 Nov 2023 12:59:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5009E2166B27;
 Wed, 15 Nov 2023 12:59:14 +0000 (UTC)
Date: Wed, 15 Nov 2023 07:57:18 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, fam@euphon.net,
 jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Message-ID: <20231115125718.GA301867@fedora>
References: <20231114003644.7026-1-michael.christie@oracle.com>
 <20231114003644.7026-3-michael.christie@oracle.com>
 <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2MjSwn6YSfTFx6zR"
Content-Disposition: inline
In-Reply-To: <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--2MjSwn6YSfTFx6zR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:43:02PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 13, 2023 at 06:36:44PM -0600, Mike Christie wrote:
> > This adds support for vhost-scsi to be able to create a worker thread
> > per virtqueue. Right now for vhost-net we get a worker thread per
> > tx/rx virtqueue pair which scales nicely as we add more virtqueues and
> > CPUs, but for scsi we get the single worker thread that's shared by all
> > virtqueues. When trying to send IO to more than 2 virtqueues the single
> > thread becomes a bottlneck.
> >=20
> > This patch adds a new setting, virtqueue_workers, which can be set to:
> >=20
> > 1: Existing behavior whre we get the single thread.
> > -1: Create a worker per IO virtqueue.
>=20
> I find this setting a bit odd. What about a boolean instead?
>=20
> `per_virtqueue_workers`:
>     false: Existing behavior whre we get the single thread.
>     true: Create a worker per IO virtqueue.

Me too, I thought there would be round-robin assignment for 1 <
worker_cnt < (dev->nvqs - VHOST_SCSI_VQ_NUM_FIXED) but instead only 1
and -1 have any meaning.

Do you want to implement round-robin assignment?

>=20
> >=20
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > ---
> > hw/scsi/vhost-scsi.c            | 68 +++++++++++++++++++++++++++++++++
> > include/hw/virtio/virtio-scsi.h |  1 +
> > 2 files changed, 69 insertions(+)
> >=20
> > diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> > index 3126df9e1d9d..5cf669b6563b 100644
> > --- a/hw/scsi/vhost-scsi.c
> > +++ b/hw/scsi/vhost-scsi.c
> > @@ -31,6 +31,9 @@
> > #include "qemu/cutils.h"
> > #include "sysemu/sysemu.h"
> >=20
> > +#define VHOST_SCSI_WORKER_PER_VQ    -1
> > +#define VHOST_SCSI_WORKER_DEF        1
> > +
> > /* Features supported by host kernel. */
> > static const int kernel_feature_bits[] =3D {
> >     VIRTIO_F_NOTIFY_ON_EMPTY,
> > @@ -165,6 +168,62 @@ static const VMStateDescription vmstate_virtio_vho=
st_scsi =3D {
> >     .pre_save =3D vhost_scsi_pre_save,
> > };
> >=20
> > +static int vhost_scsi_set_workers(VHostSCSICommon *vsc, int workers_cn=
t)
> > +{
> > +    struct vhost_dev *dev =3D &vsc->dev;
> > +    struct vhost_vring_worker vq_worker;
> > +    struct vhost_worker_state worker;
> > +    int i, ret;
> > +
> > +    /* Use default worker */
> > +    if (workers_cnt =3D=3D VHOST_SCSI_WORKER_DEF ||
> > +        dev->nvqs =3D=3D VHOST_SCSI_VQ_NUM_FIXED + 1) {
> > +        return 0;
> > +    }
> > +
> > +    if (workers_cnt !=3D VHOST_SCSI_WORKER_PER_VQ) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    /*
> > +     * ctl/evt share the first worker since it will be rare for them
> > +     * to send cmds while IO is running.
> > +     */
> > +    for (i =3D VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
> > +        memset(&worker, 0, sizeof(worker));
> > +
> > +        ret =3D dev->vhost_ops->vhost_new_worker(dev, &worker);
>=20
> Should we call vhost_free_worker() in the vhost_scsi_unrealize() or are
> workers automatically freed when `vhostfd` is closed?
>=20
> The rest LGTM.
>=20
> Thanks,
> Stefano
>=20
> > +        if (ret =3D=3D -ENOTTY) {
> > +            /*
> > +             * worker ioctls are not implemented so just ignore and
> > +             * and continue device setup.
> > +             */
> > +            ret =3D 0;
> > +            break;
> > +        } else if (ret) {
> > +            break;
> > +        }
> > +
> > +        memset(&vq_worker, 0, sizeof(vq_worker));
> > +        vq_worker.worker_id =3D worker.worker_id;
> > +        vq_worker.index =3D i;
> > +
> > +        ret =3D dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_wor=
ker);
> > +        if (ret =3D=3D -ENOTTY) {
> > +            /*
> > +             * It's a bug for the kernel to have supported the worker =
creation
> > +             * ioctl but not attach.
> > +             */
> > +            dev->vhost_ops->vhost_free_worker(dev, &worker);
> > +            break;
> > +        } else if (ret) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > static void vhost_scsi_realize(DeviceState *dev, Error **errp)
> > {
> >     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
> > @@ -232,6 +291,13 @@ static void vhost_scsi_realize(DeviceState *dev, E=
rror **errp)
> >         goto free_vqs;
> >     }
> >=20
> > +    ret =3D vhost_scsi_set_workers(vsc, vs->conf.virtqueue_workers);
> > +    if (ret < 0) {
> > +        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
> > +                   strerror(-ret));
> > +        goto free_vqs;
> > +    }
> > +
> >     /* At present, channel and lun both are 0 for bootable vhost-scsi d=
isk */
> >     vsc->channel =3D 0;
> >     vsc->lun =3D 0;
> > @@ -297,6 +363,8 @@ static Property vhost_scsi_properties[] =3D {
> >                                                  VIRTIO_SCSI_F_T10_PI,
> >                                                  false),
> >     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
> > +    DEFINE_PROP_INT32("virtqueue_workers", VirtIOSCSICommon,
> > +                      conf.virtqueue_workers, VHOST_SCSI_WORKER_DEF),
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >=20
> > diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio=
-scsi.h
> > index 779568ab5d28..f70624ece564 100644
> > --- a/include/hw/virtio/virtio-scsi.h
> > +++ b/include/hw/virtio/virtio-scsi.h
> > @@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
> > struct VirtIOSCSIConf {
> >     uint32_t num_queues;
> >     uint32_t virtqueue_size;
> > +    int virtqueue_workers;
> >     bool seg_max_adjust;
> >     uint32_t max_sectors;
> >     uint32_t cmd_per_lun;
> > --=20
> > 2.34.1
> >=20
>=20

--2MjSwn6YSfTFx6zR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVUwC4ACgkQnKSrs4Gr
c8ivoggAxgBP3tgsekhLDxp3QepZU7jAh0hIulGCjnXRyFuzzznYe5Ar6Lq+VhXb
bmF6Is5a57FOHSrmcZyQkf1xEGETDbHIWIrunLKA2xAUj6DWEFT3/EyhVp1qrJQ7
PFu2WwZsIeu4n/tT/z1MwDO3cbWspZTljUTJp0B7sGWZJn6xhxigsayUFbcmvXLK
dgaNxGCD+veWkmAbP+vOh4mdBHqn2JFvhTtiu8JkpTJCJp7cLWTnReWlwa9lnOL3
MazdxHUxkVzBe/P4A3+WxYPAVQPBYI5/5tM5w50/Rv96w/nHkXeVhS+apWu4FBUc
5h5J1gaHlY6OkGKj/GaILgelgbFIRA==
=fTWY
-----END PGP SIGNATURE-----

--2MjSwn6YSfTFx6zR--


