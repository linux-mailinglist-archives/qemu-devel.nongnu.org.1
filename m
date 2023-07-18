Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067A7584FC
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpej-00064J-7p; Tue, 18 Jul 2023 14:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLpef-00063q-2l
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLped-00011p-1J
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689705752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ano50epseY1uUsnw93600sXxPzd+MsoCZ24JUapkJq0=;
 b=M/2Nm2rcpXOGArwWRhIsxawBmQd1xzkVTv6TRHHCt4UGJZz5VJoMq730MYTguncdl9Jv9X
 FHJVw/67I7iFqcxnWUNlCBYKlKjELPrHw6f1JnWDkDdqnV1mTp4/ox+F1gmo01Rh7/hYrB
 IbyzmmYhny+9AvmWAcBpWCzDJJ6zNok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-05R4rG70NmWQ8CKHdCrEcw-1; Tue, 18 Jul 2023 14:42:30 -0400
X-MC-Unique: 05R4rG70NmWQ8CKHdCrEcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 573FF936D24
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:42:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9CDFF66D0;
 Tue, 18 Jul 2023 18:42:14 +0000 (UTC)
Date: Tue, 18 Jul 2023 14:42:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 3/4] vhost: Add high-level state save/load functions
Message-ID: <20230718184212.GM44841@fedora>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-4-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qc9UE6ORFiaWeN5N"
Content-Disposition: inline
In-Reply-To: <20230712111703.28031-4-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--qc9UE6ORFiaWeN5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:17:01PM +0200, Hanna Czenczek wrote:
> vhost_save_backend_state() and vhost_load_backend_state() can be used by
> vhost front-ends to easily save and load the back-end's state to/from
> the migration stream.
>=20
> Because we do not know the full state size ahead of time,
> vhost_save_backend_state() simply reads the data in 1 MB chunks, and
> writes each chunk consecutively into the migration stream, prefixed by
> its length.  EOF is indicated by a 0-length chunk.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/hw/virtio/vhost.h |  35 +++++++
>  hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)
>=20
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index d8877496e5..0c282abd4e 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -425,4 +425,39 @@ int vhost_set_device_state_fd(struct vhost_dev *dev,
>   */
>  int vhost_check_device_state(struct vhost_dev *dev, Error **errp);
> =20
> +/**
> + * vhost_save_backend_state(): High-level function to receive a vhost
> + * back-end's state, and save it in `f`.  Uses

I think the GtkDoc syntax is @f instead of `f`.

> + * `vhost_set_device_state_fd()` to get the data from the back-end, and
> + * stores it in consecutive chunks that are each prefixed by their
> + * respective length (be32).  The end is marked by a 0-length chunk.
> + *
> + * Must only be called while the device and all its vrings are stopped
> + * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
> + *
> + * @dev: The vhost device from which to save the state
> + * @f: Migration stream in which to save the state
> + * @errp: Potential error message
> + *
> + * Returns 0 on success, and -errno otherwise.
> + */
> +int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error *=
*errp);
> +
> +/**
> + * vhost_load_backend_state(): High-level function to load a vhost
> + * back-end's state from `f`, and send it over to the back-end.  Reads
> + * the data from `f` in the format used by `vhost_save_state()`, and
> + * uses `vhost_set_device_state_fd()` to transfer it to the back-end.
> + *
> + * Must only be called while the device and all its vrings are stopped
> + * (`VHOST_TRANSFER_STATE_PHASE_STOPPED`).
> + *
> + * @dev: The vhost device to which to send the sate
> + * @f: Migration stream from which to load the state
> + * @errp: Potential error message
> + *
> + * Returns 0 on success, and -errno otherwise.
> + */
> +int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error *=
*errp);
> +
>  #endif
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 756b6d55a8..332d49a310 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2128,3 +2128,207 @@ int vhost_check_device_state(struct vhost_dev *de=
v, Error **errp)
>                 "vhost transport does not support migration state transfe=
r");
>      return -ENOSYS;
>  }
> +
> +int vhost_save_backend_state(struct vhost_dev *dev, QEMUFile *f, Error *=
*errp)
> +{
> +    /* Maximum chunk size in which to transfer the state */
> +    const size_t chunk_size =3D 1 * 1024 * 1024;
> +    void *transfer_buf =3D NULL;
> +    g_autoptr(GError) g_err =3D NULL;
> +    int pipe_fds[2], read_fd =3D -1, write_fd =3D -1, reply_fd =3D -1;
> +    int ret;
> +
> +    /* [0] for reading (our end), [1] for writing (back-end's end) */
> +    if (!g_unix_open_pipe(pipe_fds, FD_CLOEXEC, &g_err)) {
> +        error_setg(errp, "Failed to set up state transfer pipe: %s",
> +                   g_err->message);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    read_fd =3D pipe_fds[0];
> +    write_fd =3D pipe_fds[1];
> +
> +    /*
> +     * VHOST_TRANSFER_STATE_PHASE_STOPPED means the device must be stopp=
ed.
> +     * We cannot check dev->suspended, because the back-end may not supp=
ort
> +     * suspending.
> +     */
> +    assert(!dev->started);
> +
> +    /* Transfer ownership of write_fd to the back-end */
> +    ret =3D vhost_set_device_state_fd(dev,
> +                                    VHOST_TRANSFER_STATE_DIRECTION_SAVE,
> +                                    VHOST_TRANSFER_STATE_PHASE_STOPPED,
> +                                    write_fd,
> +                                    &reply_fd,
> +                                    errp);
> +    if (ret < 0) {
> +        error_prepend(errp, "Failed to initiate state transfer: ");
> +        goto fail;
> +    }
> +
> +    /* If the back-end wishes to use a different pipe, switch over */
> +    if (reply_fd >=3D 0) {
> +        close(read_fd);
> +        read_fd =3D reply_fd;
> +    }
> +
> +    transfer_buf =3D g_malloc(chunk_size);
> +
> +    while (true) {
> +        ssize_t read_ret;
> +
> +        read_ret =3D read(read_fd, transfer_buf, chunk_size);
> +        if (read_ret < 0) {

Is it necessary to handle -EINTR?

> +            ret =3D -errno;
> +            error_setg_errno(errp, -ret, "Failed to receive state");
> +            goto fail;
> +        }
> +
> +        assert(read_ret <=3D chunk_size);
> +        qemu_put_be32(f, read_ret);
> +
> +        if (read_ret =3D=3D 0) {
> +            /* EOF */
> +            break;
> +        }
> +
> +        qemu_put_buffer(f, transfer_buf, read_ret);
> +    }
> +
> +    /*
> +     * Back-end will not really care, but be clean and close our end of =
the pipe
> +     * before inquiring the back-end about whether transfer was successf=
ul
> +     */
> +    close(read_fd);
> +    read_fd =3D -1;
> +
> +    /* Also, verify that the device is still stopped */
> +    assert(!dev->started);
> +
> +    ret =3D vhost_check_device_state(dev, errp);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret =3D 0;
> +fail:
> +    g_free(transfer_buf);
> +    if (read_fd >=3D 0) {
> +        close(read_fd);
> +    }
> +
> +    return ret;
> +}
> +
> +int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error *=
*errp)
> +{
> +    size_t transfer_buf_size =3D 0;
> +    void *transfer_buf =3D NULL;
> +    g_autoptr(GError) g_err =3D NULL;
> +    int pipe_fds[2], read_fd =3D -1, write_fd =3D -1, reply_fd =3D -1;
> +    int ret;
> +
> +    /* [0] for reading (back-end's end), [1] for writing (our end) */
> +    if (!g_unix_open_pipe(pipe_fds, FD_CLOEXEC, &g_err)) {
> +        error_setg(errp, "Failed to set up state transfer pipe: %s",
> +                   g_err->message);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
> +    read_fd =3D pipe_fds[0];
> +    write_fd =3D pipe_fds[1];
> +
> +    /*
> +     * VHOST_TRANSFER_STATE_PHASE_STOPPED means the device must be stopp=
ed.
> +     * We cannot check dev->suspended, because the back-end may not supp=
ort
> +     * suspending.
> +     */
> +    assert(!dev->started);
> +
> +    /* Transfer ownership of read_fd to the back-end */
> +    ret =3D vhost_set_device_state_fd(dev,
> +                                    VHOST_TRANSFER_STATE_DIRECTION_LOAD,
> +                                    VHOST_TRANSFER_STATE_PHASE_STOPPED,
> +                                    read_fd,
> +                                    &reply_fd,
> +                                    errp);
> +    if (ret < 0) {
> +        error_prepend(errp, "Failed to initiate state transfer: ");
> +        goto fail;
> +    }
> +
> +    /* If the back-end wishes to use a different pipe, switch over */
> +    if (reply_fd >=3D 0) {
> +        close(write_fd);
> +        write_fd =3D reply_fd;
> +    }
> +
> +    while (true) {
> +        size_t this_chunk_size =3D qemu_get_be32(f);
> +        ssize_t write_ret;
> +        const uint8_t *transfer_pointer;
> +
> +        if (this_chunk_size =3D=3D 0) {
> +            /* End of state */
> +            break;
> +        }
> +
> +        if (transfer_buf_size < this_chunk_size) {
> +            transfer_buf =3D g_realloc(transfer_buf, this_chunk_size);
> +            transfer_buf_size =3D this_chunk_size;
> +        }
> +
> +        if (qemu_get_buffer(f, transfer_buf, this_chunk_size) <
> +                this_chunk_size)
> +        {
> +            error_setg(errp, "Failed to read state");
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> +
> +        transfer_pointer =3D transfer_buf;
> +        while (this_chunk_size > 0) {
> +            write_ret =3D write(write_fd, transfer_pointer, this_chunk_s=
ize);
> +            if (write_ret < 0) {

Is it necessary to handle -EINTR?

> +                ret =3D -errno;
> +                error_setg_errno(errp, -ret, "Failed to send state");
> +                goto fail;
> +            } else if (write_ret =3D=3D 0) {
> +                error_setg(errp, "Failed to send state: Connection is cl=
osed");
> +                ret =3D -ECONNRESET;
> +                goto fail;
> +            }
> +
> +            assert(write_ret <=3D this_chunk_size);
> +            this_chunk_size -=3D write_ret;
> +            transfer_pointer +=3D write_ret;
> +        }
> +    }
> +
> +    /*
> +     * Close our end, thus ending transfer, before inquiring the back-en=
d about
> +     * whether transfer was successful
> +     */
> +    close(write_fd);
> +    write_fd =3D -1;
> +
> +    /* Also, verify that the device is still stopped */
> +    assert(!dev->started);
> +
> +    ret =3D vhost_check_device_state(dev, errp);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret =3D 0;
> +fail:
> +    g_free(transfer_buf);
> +    if (write_fd >=3D 0) {
> +        close(write_fd);
> +    }
> +
> +    return ret;
> +}
> --=20
> 2.41.0
>=20

--qc9UE6ORFiaWeN5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS23QQACgkQnKSrs4Gr
c8gK9gf/UH9/r8OAcHwelbVVwwlqkj4FCw/Y5S9Eg0OdQf3Tzfqsx8DZazdQTIqU
2x45Ej8rzrLkQP82UGTkKISAWA0IatZYqhiRjmYnQt0Rdjc7vkq6InRwrGzfRXKc
VI8NJIe2N9qnjdD7NyRkdtY5wLNOolpO4XjHKHTjxYToT4JkL1y4ohMInT2pgODG
ELdukjFIuhUSRyzXwQ8ultsiwHLTG8OoprdzQsbGv3QfZ4kIGWnkt09pnQP6iWX9
PNtaTOK7hZKXp4aPCpho0k3Ui5EGm+A2OO2tMVKNVp7TmEqGAoOoh2i5dZr0ElF1
/mXpW7Jc0FLTnGCSEFX6GI/iL9Lwaw==
=+z9I
-----END PGP SIGNATURE-----

--qc9UE6ORFiaWeN5N--


