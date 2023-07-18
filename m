Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8D758187
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLn4a-0005H3-9s; Tue, 18 Jul 2023 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLn4Y-0005FE-2X
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLn4W-0000pu-4x
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689695826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J4Sgs9xaMeCpmsKulbbL3wSd7O+xSt6sahCmw+SSb1Q=;
 b=AAjH9v3vWr6C/lqwXT22Ml3jZzro6gMP7ALuPWvekhJ/+7a3uL81PatcFueZKUeteSZPY/
 spTYn2PBRQ8VeB7mOdr8oNso89rt0vXAJgbFU9pzt2BOzNzaS+pLLzYdyYnZ/V+fH074JQ
 uf5FYzv1/OHKrw6+/eGHGFcfgjW4eFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-i5eINpp7NsC6E8Ge56pnWA-1; Tue, 18 Jul 2023 11:57:03 -0400
X-MC-Unique: i5eINpp7NsC6E8Ge56pnWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31BB85A58A
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:57:02 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 573014087C62;
 Tue, 18 Jul 2023 15:57:02 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:57:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 1/4] vhost-user.rst: Migrating back-end-internal state
Message-ID: <20230718155700.GJ44841@fedora>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AXsKZLXtib5CKy2E"
Content-Disposition: inline
In-Reply-To: <20230712111703.28031-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--AXsKZLXtib5CKy2E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 01:16:59PM +0200, Hanna Czenczek wrote:
> For vhost-user devices, qemu can migrate the virtio state, but not the
> back-end's internal state.  To do so, we need to be able to transfer
> this internal state between front-end (qemu) and back-end.
>=20
> At this point, this new feature is added for the purpose of virtio-fs
> migration.  Because virtiofsd's internal state will not be too large, we
> believe it is best to transfer it as a single binary blob after the
> streaming phase.
>=20
> These are the additions to the protocol:
> - New vhost-user protocol feature VHOST_USER_PROTOCOL_F_MIGRATORY_STATE

It's not 100% clear whether "migratory" is related to live migration or
something else. I don't like the name :P.

The name "VHOST_USER_PROTOCOL_F_DEVICE_STATE" would be more obviously
associated with SET_DEVICE_STATE_FD and CHECK_DEVICE_STATE than
"MIGRATORY_STATE".

> - SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a pipe
>   over which to transfer the state.

Does it need to be a pipe or can it be another type of file (e.g. UNIX
domain socket)?

In the future the fd may become bi-directional. Pipes are
uni-directional on Linux.

I suggest calling it a "file descriptor" and not mentioning "pipes"
explicitly.

> - CHECK_DEVICE_STATE: After the state has been transferred through the
>   pipe, the front-end invokes this function to verify success.  There is
>   no in-band way (through the pipe) to indicate failure, so we need to
>   check explicitly.
>=20
> Once the transfer pipe has been established via SET_DEVICE_STATE_FD
> (which includes establishing the direction of transfer and migration
> phase), the sending side writes its data into the pipe, and the reading
> side reads it until it sees an EOF.  Then, the front-end will check for
> success via CHECK_DEVICE_STATE, which on the destination side includes
> checking for integrity (i.e. errors during deserialization).
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 87 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index ac6be34c4c..c98dfeca25 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -334,6 +334,7 @@ in the ancillary data:
>  * ``VHOST_USER_SET_VRING_ERR``
>  * ``VHOST_USER_SET_BACKEND_REQ_FD`` (previous name ``VHOST_USER_SET_SLAV=
E_REQ_FD``)
>  * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
> +* ``VHOST_USER_SET_DEVICE_STATE_FD``
> =20
>  If *front-end* is unable to send the full message or receives a wrong
>  reply it will close the connection. An optional reconnection mechanism
> @@ -497,6 +498,44 @@ it performs WAKE ioctl's on the userfaultfd to wake =
the stalled
>  back-end.  The front-end indicates support for this via the
>  ``VHOST_USER_PROTOCOL_F_PAGEFAULT`` feature.
> =20
> +.. _migrating_backend_state:
> +
> +Migrating back-end state
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +If the back-end has internal state that is to be sent from source to
> +destination,

Migration and the terms "source" and "destination" have not been
defined. Here is a suggestion for an introductory paragraph:

  Migrating device state involves transferring the state from one
  back-end, called the source, to another back-end, called the
  destination. After migration, the destination transparently resumes
  operation without requiring the driver to re-initialize the device at
  the VIRTIO level. If the migration fails, then the source can
  transparently resume operation until another migration attempt is
  made.

> the front-end may be able to store and transfer it via an
> +internal migration stream.  Support for this is negotiated with the
> +``VHOST_USER_PROTOCOL_F_MIGRATORY_STATE`` feature.
> +
> +First, a channel over which the state is transferred is established on
> +the source side using the ``VHOST_USER_SET_DEVICE_STATE_FD`` message.
> +This message has two parameters:
> +
> +* Direction of transfer: On the source, the data is saved, transferring
> +  it from the back-end to the front-end.  On the destination, the data
> +  is loaded, transferring it from the front-end to the back-end.
> +
> +* Migration phase: Currently, only the period after memory transfer

"memory transfer" is vague. This sentence is referring to VM live
migration and guest RAM but it may be better to focus on just the device
perspective and not the VM:

  Migration is currently only supported while the device is suspended
  and all of its rings are stopped. In the future, additional phases
  might be support to allow iterative migration while the device is
  running.

> +  before switch-over is supported, in which the device is suspended and
> +  all of its rings are stopped.
> +
> +Then, the writing end will write all the data it has, signalling the end
> +of data by closing its end of the pipe.  The reading end must read all
> +of this data and process it:
> +
> +* If saving, the front-end will transfer this data to the destination,

To be extra clear:

  ...transfer this data to the destination through some
  implementation-specific means.

> +  where it is loaded into the destination back-end.
> +
> +* If loading, the back-end must deserialize its internal state from the
> +  transferred data and be set up to resume operation.

"and be set up to resume operation" is a little unclear to me. I guess
it means "in preparation for VHOST_USER_RESUME".

> +
> +After the front-end has seen all data transferred (saving: seen an EOF
> +on the pipe; loading: closed its end of the pipe), it sends the
> +``VHOST_USER_CHECK_DEVICE_STATE`` message to verify that data transfer
> +was successful in the back-end, too.  The back-end responds once it
> +knows whether the tranfer and processing was successful or not.
> +
>  Memory access
>  -------------
> =20
> @@ -891,6 +930,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SUSPEND              18
> +  #define VHOST_USER_PROTOCOL_F_MIGRATORY_STATE      19
> =20
>  Front-end message types
>  -----------------------
> @@ -1471,6 +1511,53 @@ Front-end message types
>    before.  The back-end must again begin processing rings that are not
>    stopped, and it may resume background operations.
> =20
> +``VHOST_USER_SET_DEVICE_STATE_FD``
> +  :id: 43
> +  :equivalent ioctl: N/A
> +  :request payload: device state transfer parameters
> +  :reply payload: ``u64``
> +
> +  The front-end negotiates a pipe over which to transfer the back-end=E2=
=80=99s
> +  internal state during migration.  For this purpose, this message is
> +  accompanied by a file descriptor that is to be the back-end=E2=80=99s =
end of
> +  the pipe.  If the back-end can provide a more efficient pipe (i.e.
> +  because it internally already has a pipe into/from which to
> +  put/receive state), it can ignore this and reply with a different file
> +  descriptor to serve as the front-end=E2=80=99s end.
> +
> +  The request payload contains parameters for the subsequent data
> +  transfer, as described in the :ref:`Migrating back-end state
> +  <migrating_backend_state>` section.  That section also explains the
> +  data transfer itself.
> +
> +  The value returned is both an indication for success, and whether a
> +  new pipe file descriptor is returned: Bits 0=E2=80=937 are 0 on succes=
s, and
> +  non-zero on error.  Bit 8 is the invalid FD flag; this flag is set
> +  when there is no file descriptor returned.  When this flag is not set,
> +  the front-end must use the returned file descriptor as its end of the
> +  pipe.  The back-end must not both indicate an error and return a file
> +  descriptor.

Is the invalid FD flag necessary? The front-end can check whether or not
an fd was passed along with the result, so I'm not sure why the result
also needs to communicate this.

--AXsKZLXtib5CKy2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2tkwACgkQnKSrs4Gr
c8gEiAgAtaMTnqd8Y4gJuYTsWqFbvvqwnexPOt8r1UoRJasG9WmezMM0QN8Tk71O
fFzDbn5w8ZdiecmWL4tNqHZvd3jBhtY1y9ryguG3tqZpRA4+50kzDr4z7vPTeZm3
DtJg8wWM+0kW9AZrz6kG/8PLlPPBTTiVXILZVz5ON4TnUluBQiPw+R4oaMruqNxD
BorHJfdPeyMKfp8lluIqGVoRFRJ9wSUFGonT/bQX/ZHs7/OTm104Hvn5WF1GOnLU
FpP2bCuEYDYG4kvRlHvLad1WgNABgISWV6O69OOrEFMFBZ/Vt4RPISYybgeg7Cp3
m3e8kGiSSahwTSWg4MlllvjoSPCHNQ==
=5I1o
-----END PGP SIGNATURE-----

--AXsKZLXtib5CKy2E--


