Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9F97AE04C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qksAN-0002xH-F6; Mon, 25 Sep 2023 16:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qksAL-0002x9-6O
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qksAJ-0004eT-Jh
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695673606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJ/MKCNU048gVbUOsQ25u5SLku4+W/IXk9vdMzCNLMw=;
 b=fG+5SIcq6yEdKrIITb6pk3RoEPQeBuXI5U7RbBCm76s39l0bDHPFFRzuuT1pB5QqJpVYng
 l21ePYn/xqPoeCE9Uu3QeThEZAzAm6L7tT+XTiMAcZcOAdRW7rAjYwwLmT+yrClFWCVVay
 zu0KmfOFs4gYAPjnGgJwkfT/xZgZ0Ck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-mkC1R8A5MoqSO0iOup2bPA-1; Mon, 25 Sep 2023 16:26:44 -0400
X-MC-Unique: mkC1R8A5MoqSO0iOup2bPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90E6585A5BA;
 Mon, 25 Sep 2023 20:26:44 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E32CC40C2070;
 Mon, 25 Sep 2023 20:26:43 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:26:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v3 5/5] vhost-user-fs: Implement internal migration
Message-ID: <20230925202642.GF323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d5khHiGNigsVFP+D"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--d5khHiGNigsVFP+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:30PM +0200, Hanna Czenczek wrote:
> A virtio-fs device's VM state consists of:
> - the virtio device (vring) state (VMSTATE_VIRTIO_DEVICE)
> - the back-end's (virtiofsd's) internal state
>=20
> We get/set the latter via the new vhost operations to transfer migratory
> state.  It is its own dedicated subsection, so that for external
> migration, it can be disabled.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user-fs.c | 101 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)

CCing Anton so he is aware that internal migration is being added.

>=20
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index 49d699ffc2..eb91723855 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -298,9 +298,108 @@ static struct vhost_dev *vuf_get_vhost(VirtIODevice=
 *vdev)
>      return &fs->vhost_dev;
>  }
> =20
> +/**
> + * Fetch the internal state from virtiofsd and save it to `f`.
> + */
> +static int vuf_save_state(QEMUFile *f, void *pv, size_t size,
> +                          const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    VirtIODevice *vdev =3D pv;
> +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> +    Error *local_error =3D NULL;
> +    int ret;
> +
> +    ret =3D vhost_save_backend_state(&fs->vhost_dev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error saving back-end state of %s device %s "
> +                          "(tag: \"%s\"): ",
> +                          vdev->name, vdev->parent_obj.canonical_path,
> +                          fs->conf.tag ?: "<none>");
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/**
> + * Load virtiofsd's internal state from `f` and send it over to virtiofs=
d.
> + */
> +static int vuf_load_state(QEMUFile *f, void *pv, size_t size,
> +                          const VMStateField *field)
> +{
> +    VirtIODevice *vdev =3D pv;
> +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> +    Error *local_error =3D NULL;
> +    int ret;
> +
> +    ret =3D vhost_load_backend_state(&fs->vhost_dev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error loading back-end state of %s device %s "
> +                          "(tag: \"%s\"): ",
> +                          vdev->name, vdev->parent_obj.canonical_path,
> +                          fs->conf.tag ?: "<none>");
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vuf_is_internal_migration(void *opaque)
> +{
> +    /* TODO: Return false when an external migration is requested */
> +    return true;
> +}
> +
> +static int vuf_check_migration_support(void *opaque)
> +{
> +    VirtIODevice *vdev =3D opaque;
> +    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
> +
> +    if (!vhost_supports_device_state(&fs->vhost_dev)) {
> +        error_report("Back-end of %s device %s (tag: \"%s\") does not su=
pport "
> +                     "migration through qemu",
> +                     vdev->name, vdev->parent_obj.canonical_path,
> +                     fs->conf.tag ?: "<none>");
> +        return -ENOTSUP;
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vuf_backend_vmstate;
> +
>  static const VMStateDescription vuf_vmstate =3D {
>      .name =3D "vhost-user-fs",
> -    .unmigratable =3D 1,
> +    .version_id =3D 0,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vuf_backend_vmstate,
> +        NULL,
> +    }
> +};
> +
> +static const VMStateDescription vuf_backend_vmstate =3D {
> +    .name =3D "vhost-user-fs-backend",
> +    .version_id =3D 0,
> +    .needed =3D vuf_is_internal_migration,
> +    .pre_load =3D vuf_check_migration_support,
> +    .pre_save =3D vuf_check_migration_support,
> +    .fields =3D (VMStateField[]) {
> +        {
> +            .name =3D "back-end",
> +            .info =3D &(const VMStateInfo) {
> +                .name =3D "virtio-fs back-end state",
> +                .get =3D vuf_load_state,
> +                .put =3D vuf_save_state,
> +            },
> +        },
> +        VMSTATE_END_OF_LIST()
> +    },
>  };
> =20
>  static Property vuf_properties[] =3D {
> --=20
> 2.41.0
>=20

--d5khHiGNigsVFP+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR7QIACgkQnKSrs4Gr
c8hWOQf4lTXUOU2gOOGvvnfaMIpciHn+yEYaANnHB9OYIGqW2lIrhEJhX79nL0/H
dRU+oduy+zya4lZd1Dt/Hmr/hecYo4IYRIIIp01RU7x9/QEk35BJalOcPlXTxx1K
xEWQt6zLjip7XP8w3uenYqBS3aAQnzkcHCF78HVtYvrDR458Xq0d+slTfhgUTxch
kqdH9Lzllle5tYzVWmnUB2df5J91NtbN6Kq7APpdY3VD0wRNAF7j8G9RJEyAZVDh
Q68Cy1vIH+qdTo+wWaJYjSD5qYMAjJx1OpBif4iGMhzgjUgI+dTlZPG3xrK6jq4U
pWW/+YfS/E+03GeWofilxJ2leBfH
=D7XB
-----END PGP SIGNATURE-----

--d5khHiGNigsVFP+D--


