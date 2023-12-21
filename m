Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FBD81B985
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:28:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGK1Z-0003yB-FH; Thu, 21 Dec 2023 09:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGK1Q-0003vN-M8
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGK1N-0006H4-Eu
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703168850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoBAHc2MX6LhjWobKvetwzcVzXLm5oAPnn+ZWU5ayYs=;
 b=KvQbzori/J0ViFiVpF+xgZqfEujIGVFKxilhmH+id+bIKfgqxNoMUmAacPBw1qe1pej/Q3
 yZwZqzeldXFN4W5nu4PdEi6MTJQ1kEUkAsr9jApnell/W9znnGnHal9Lr7l4FWg9b9Kptq
 KP6Y5Loi/ltA/JO+oJD5y1rUC3hZACQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-o3aOBeLUNcWFJmeQzdW5vQ-1; Thu, 21 Dec 2023 09:27:26 -0500
X-MC-Unique: o3aOBeLUNcWFJmeQzdW5vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66488370E1;
 Thu, 21 Dec 2023 14:27:25 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C60431C060AF;
 Thu, 21 Dec 2023 14:27:24 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:27:23 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 5/6] nbd/server: only traverse NBDExport->clients from
 main loop thread
Message-ID: <20231221142723.GA1594147@fedora>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-6-stefanha@redhat.com>
 <8ff9a950-4075-4c86-bf5d-df8b90eb450a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ltBJVkg+PGj9NUax"
Content-Disposition: inline
In-Reply-To: <8ff9a950-4075-4c86-bf5d-df8b90eb450a@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ltBJVkg+PGj9NUax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 08:23:15AM +0100, Paolo Bonzini wrote:
> On 12/21/23 02:49, Stefan Hajnoczi wrote:
> > The NBD clients list is currently accessed from both the export
> > AioContext and the main loop thread. When the AioContext lock is removed
> > there will be nothing protecting the clients list.
> >=20
> > Adding a lock around the clients list is tricky because NBDClient
> > structs are refcounted and may be freed from the export AioContext or
> > the main loop thread. nbd_export_request_shutdown() -> client_close() ->
> > nbd_client_put() is also tricky because the list lock would be held
> > while indirectly dropping references to NDBClients.
> >=20
> > A simpler approach is to only allow nbd_client_put() and client_close()
> > calls from the main loop thread. Then the NBD clients list is only
> > accessed from the main loop thread and no fancy locking is needed.
> >=20
> > nbd_trip() just needs to reschedule itself in the main loop AioContext
> > before calling nbd_client_put() and client_close(). This costs more CPU
> > cycles per NBD request but is needed for thread-safety when the
> > AioContext lock is removed.
> >=20
> > Note that nbd_client_get() can still be called from either thread, so
> > make NBDClient->refcount atomic.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   nbd/server.c | 23 ++++++++++++++++++++---
> >   1 file changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 0b09ccc8dc..527fbdab4a 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -122,7 +122,7 @@ struct NBDMetaContexts {
> >   };
> >   struct NBDClient {
> > -    int refcount;
> > +    int refcount; /* atomic */
> >       void (*close_fn)(NBDClient *client, bool negotiated);
> >       NBDExport *exp;
> > @@ -1501,14 +1501,17 @@ static int coroutine_fn nbd_receive_request(NBD=
Client *client, NBDRequest *reque
> >   #define MAX_NBD_REQUESTS 16
> > +/* Runs in export AioContext and main loop thread */
> >   void nbd_client_get(NBDClient *client)
> >   {
> > -    client->refcount++;
> > +    qatomic_inc(&client->refcount);
> >   }
> >   void nbd_client_put(NBDClient *client)
> >   {
> > -    if (--client->refcount =3D=3D 0) {
> > +    assert(qemu_in_main_thread());
> > +
> > +    if (qatomic_fetch_dec(&client->refcount) =3D=3D 1) {
> >           /* The last reference should be dropped by client->close,
> >            * which is called by client_close.
> >            */
> > @@ -1531,6 +1534,8 @@ void nbd_client_put(NBDClient *client)
> >   static void client_close(NBDClient *client, bool negotiated)
> >   {
> > +    assert(qemu_in_main_thread());
> > +
> >       if (client->closing) {
> >           return;
> >       }
> > @@ -2938,8 +2943,15 @@ static coroutine_fn void nbd_trip(void *opaque)
> >       int ret;
> >       Error *local_err =3D NULL;
> > +    /*
> > +     * Note that nbd_client_put() and client_close() must be called fr=
om the
> > +     * main loop thread. Use aio_co_reschedule_self() to switch AioCon=
text
> > +     * before calling these functions.
> > +     */
> > +
> >       trace_nbd_trip();
> >       if (client->closing) {
> > +        aio_co_reschedule_self(qemu_get_aio_context());
> >           nbd_client_put(client);
> >           return;
> >       }
> > @@ -2949,6 +2961,7 @@ static coroutine_fn void nbd_trip(void *opaque)
> >            * We're switching between AIO contexts. Don't attempt to rec=
eive a new
> >            * request and kick the main context which may be waiting for=
 us.
> >            */
> > +        aio_co_reschedule_self(qemu_get_aio_context());
> >           nbd_client_put(client);
> >           client->recv_coroutine =3D NULL;
> >           aio_wait_kick();
> > @@ -3013,6 +3026,8 @@ static coroutine_fn void nbd_trip(void *opaque)
> >       qio_channel_set_cork(client->ioc, false);
> >   done:
> >       nbd_request_put(req);
> > +
> > +    aio_co_reschedule_self(qemu_get_aio_context());
> >       nbd_client_put(client);
> >       return;
>=20
> This is very expensive to do on every NBD receive, considering that it re=
ally
> can happen only when closing (see the assertion in nbd_client_put).
>=20
> In Linux there is a common pattern of "if refcount could go to zero, take
> a lock before doing the decrement".  We can do something similar with "if
> refcount could go to zero, move to main iothread before doing the decreme=
nt":

Nice suggestion, thanks!

>=20
> diff --git a/nbd/server.c b/nbd/server.c
> index 895cf0a7525..aec306923d8 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1529,6 +1529,21 @@ void nbd_client_put(NBDClient *client)
>      }
>  }
> +static bool nbd_client_put_nonzero(NBDClient *client)
> +{
> +    int old =3D qatomic_read(&client->refcount);
> +    do {
> +        if (old =3D=3D 1) {
> +            return false;
> +        }
> +
> +        int expected =3D old;
> +        old =3D qatomic_cmpxchg(&client->refcount, expected, expected - =
1);
> +    } while (old !=3D expected);
> +
> +    return true;
> +}
> +
>  static void client_close(NBDClient *client, bool negotiated)
>  {
>      if (client->closing) {
> @@ -2936,15 +2951,14 @@ static coroutine_fn int nbd_handle_request(NBDCli=
ent *client,
>  static coroutine_fn void nbd_trip(void *opaque)
>  {
>      NBDClient *client =3D opaque;
> -    NBDRequestData *req;
> +    NBDRequestData *req =3D NULL;
>      NBDRequest request =3D { 0 };    /* GCC thinks it can be used uninit=
ialized */
>      int ret;
>      Error *local_err =3D NULL;
>      trace_nbd_trip();
>      if (client->closing) {
> -        nbd_client_put(client);
> -        return;
> +        goto done;
>      }
>      if (client->quiescing) {
> @@ -2952,10 +2966,9 @@ static coroutine_fn void nbd_trip(void *opaque)
>           * We're switching between AIO contexts. Don't attempt to receiv=
e a new
>           * request and kick the main context which may be waiting for us.
>           */
> -        nbd_client_put(client);
>          client->recv_coroutine =3D NULL;
>          aio_wait_kick();
> -        return;
> +        goto done;
>      }
>      req =3D nbd_request_get(client);
> @@ -3015,8 +3028,13 @@ static coroutine_fn void nbd_trip(void *opaque)
>      qio_channel_set_cork(client->ioc, false);
>  done:
> -    nbd_request_put(req);
> -    nbd_client_put(client);
> +    if (req) {
> +        nbd_request_put(req);
> +    }
> +    if (!nbd_client_put_nonzero(client)) {
> +        aio_co_reschedule_self(qemu_get_aio_context());
> +        nbd_client_put(client);
> +    }
>      return;
>  disconnect:
>=20
> I think adding the "if (req)" should also simplify a little bit the addit=
ion of the lock.
>=20
> Paolo
>=20

--ltBJVkg+PGj9NUax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWES0sACgkQnKSrs4Gr
c8h6MQf+I89CX+fRXh0XDMrobZC1FInRpAOz+JqUjoLEc9KeMi8PvWu8Qan0NXm2
J6eJsN3B+qR9NLo504tkI1g/L3l3wfbx962+eyPbUvcsCtQwrgaz0l38VI8XixaU
ujSjDzoduCsPEFWGRA8ombZO+hfbrrBm0y9aW15Xl2oLpOQbZ3Lyz1/hbYpjKcT8
+SFhQ9l4mzXuaZiD8r8yJG+LWF1bXVrhLcLjT8AF7gcAqOzPGDPtlq3hBivjFz0m
1B/d20ou4VNXIdBRCSI8bsmkESt18ld3mdvBBZK0WKGHEwE+skm+emtpPYnmgr8v
pIrcKOhcW/JtQlq6V41ekOgVcRV35Q==
=Q+ht
-----END PGP SIGNATURE-----

--ltBJVkg+PGj9NUax--


