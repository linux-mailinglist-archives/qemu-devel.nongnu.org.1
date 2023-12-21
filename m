Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4581B964
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 15:16:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJot-0000kH-9A; Thu, 21 Dec 2023 09:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGJor-0000jp-JS
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGJoe-0002JC-IT
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 09:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703168062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vkRWFHNUyMKxrVqmgrfTvNvgdusQ8GRKrAhMxz/YS5Q=;
 b=TuID9Uy9mZiEW3Ee/OgOmdxZkitDwfFpQmPJ+/IRpzMEjgLfwxYz4V6szCLDRw8XxiCGMk
 U56dB1CeJ0YZvyFqbVzifyEWAuL4HMctXz4o+8lgICdBmrX1iOV8K50mEy4dpdEZL5PtPH
 hwD1KsI1DUTfDC6djlb5ZXB+lvmhjoM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Ylnn2d3ZN5-ww800868CDQ-1; Thu,
 21 Dec 2023 09:14:18 -0500
X-MC-Unique: Ylnn2d3ZN5-ww800868CDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FE823811F49;
 Thu, 21 Dec 2023 14:14:18 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 972DF3C25;
 Thu, 21 Dec 2023 14:14:16 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:14:14 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 6/6] nbd/server: introduce NBDClient->lock to protect
 fields
Message-ID: <20231221141414.GB1578764@fedora>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-7-stefanha@redhat.com>
 <ZYQXUEqTVs8dEdbS@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6xsMLA5vzHkGg9sP"
Content-Disposition: inline
In-Reply-To: <ZYQXUEqTVs8dEdbS@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--6xsMLA5vzHkGg9sP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:45:36AM +0100, Kevin Wolf wrote:
> Am 21.12.2023 um 02:49 hat Stefan Hajnoczi geschrieben:
> > NBDClient has a number of fields that are accessed by both the export
> > AioContext and the main loop thread. When the AioContext lock is removed
> > these fields will need another form of protection.
> >=20
> > Add NBDClient->lock and protect fields that are accessed by both
> > threads. Also add assertions where possible and otherwise add doc
> > comments stating assumptions about which thread and lock holding.
> >=20
> > Note this patch moves the client->recv_coroutine assertion from
> > nbd_co_receive_request() to nbd_trip() where client->lock is held.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  nbd/server.c | 128 +++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 94 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/nbd/server.c b/nbd/server.c
> > index 527fbdab4a..4008ec7df9 100644
> > --- a/nbd/server.c
> > +++ b/nbd/server.c
> > @@ -125,23 +125,25 @@ struct NBDClient {
> >      int refcount; /* atomic */
> >      void (*close_fn)(NBDClient *client, bool negotiated);
> > =20
> > +    QemuMutex lock;
> > +
> >      NBDExport *exp;
> >      QCryptoTLSCreds *tlscreds;
> >      char *tlsauthz;
> >      QIOChannelSocket *sioc; /* The underlying data channel */
> >      QIOChannel *ioc; /* The current I/O channel which may differ (eg T=
LS) */
> > =20
> > -    Coroutine *recv_coroutine;
> > +    Coroutine *recv_coroutine; /* protected by lock */
> > =20
> >      CoMutex send_lock;
> >      Coroutine *send_coroutine;
> > =20
> > -    bool read_yielding;
> > -    bool quiescing;
> > +    bool read_yielding; /* protected by lock */
> > +    bool quiescing; /* protected by lock */
> > =20
> >      QTAILQ_ENTRY(NBDClient) next;
> > -    int nb_requests;
> > -    bool closing;
> > +    int nb_requests; /* protected by lock */
> > +    bool closing; /* protected by lock */
> > =20
> >      uint32_t check_align; /* If non-zero, check for aligned client req=
uests */
> > =20
> > @@ -1415,11 +1417,18 @@ nbd_read_eof(NBDClient *client, void *buffer, s=
ize_t size, Error **errp)
> > =20
> >          len =3D qio_channel_readv(client->ioc, &iov, 1, errp);
> >          if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> > -            client->read_yielding =3D true;
> > +            WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +                if (client->quiescing) {
> > +                    return -EAGAIN;
> > +                }
>=20
> Why did you add another client->quiescing check here?
>=20
> If it is to address a race, I think you only made the window a bit
> smaller, but between releasing the lock and yielding the field could
> still change, so drain needs to handle this case anyway.

I added it for consistency/symmetry where nbd_trip() checks
client->quiescing after acquiring client->lock but didn't have any
specific scenario in mind. I'll drop this.

I agree that it does not prevent races. .drained_begin() +
=2Edrained_poll() can run after client->lock is released and before
qio_channel_yield() takes effect. In that case we miss client->quiescing
and still have the race where no wake occurs because
qio_channel_wake_read() sees ioc->read_coroutine =3D=3D NULL.

> > +                client->read_yielding =3D true;
> > +            }
> >              qio_channel_yield(client->ioc, G_IO_IN);
> > -            client->read_yielding =3D false;
> > -            if (client->quiescing) {
> > -                return -EAGAIN;
> > +            WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +                client->read_yielding =3D false;
> > +                if (client->quiescing) {
> > +                    return -EAGAIN;
> > +                }
> >              }
> >              continue;
> >          } else if (len < 0) {
> > @@ -1528,6 +1537,7 @@ void nbd_client_put(NBDClient *client)
> >              blk_exp_unref(&client->exp->common);
> >          }
> >          g_free(client->contexts.bitmaps);
> > +        qemu_mutex_destroy(&client->lock);
> >          g_free(client);
> >      }
> >  }
> > @@ -1536,11 +1546,13 @@ static void client_close(NBDClient *client, boo=
l negotiated)
> >  {
> >      assert(qemu_in_main_thread());
> > =20
> > -    if (client->closing) {
> > -        return;
> > -    }
> > +    WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +        if (client->closing) {
> > +            return;
> > +        }
> > =20
> > -    client->closing =3D true;
> > +        client->closing =3D true;
> > +    }
> > =20
> >      /* Force requests to finish.  They will drop their own references,
> >       * then we'll close the socket and free the NBDClient.
> > @@ -1554,6 +1566,7 @@ static void client_close(NBDClient *client, bool =
negotiated)
> >      }
> >  }
> > =20
> > +/* Runs in export AioContext with client->lock held */
> >  static NBDRequestData *nbd_request_get(NBDClient *client)
> >  {
> >      NBDRequestData *req;
> > @@ -1566,6 +1579,7 @@ static NBDRequestData *nbd_request_get(NBDClient =
*client)
> >      return req;
> >  }
> > =20
> > +/* Runs in export AioContext with client->lock held */
> >  static void nbd_request_put(NBDRequestData *req)
> >  {
> >      NBDClient *client =3D req->client;
> > @@ -1589,14 +1603,18 @@ static void blk_aio_attached(AioContext *ctx, v=
oid *opaque)
> >      NBDExport *exp =3D opaque;
> >      NBDClient *client;
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      trace_nbd_blk_aio_attached(exp->name, ctx);
> > =20
> >      exp->common.ctx =3D ctx;
> > =20
> >      QTAILQ_FOREACH(client, &exp->clients, next) {
> > -        assert(client->nb_requests =3D=3D 0);
> > -        assert(client->recv_coroutine =3D=3D NULL);
> > -        assert(client->send_coroutine =3D=3D NULL);
> > +        WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +            assert(client->nb_requests =3D=3D 0);
> > +            assert(client->recv_coroutine =3D=3D NULL);
> > +            assert(client->send_coroutine =3D=3D NULL);
> > +        }
> >      }
> >  }
> > =20
> > @@ -1604,6 +1622,8 @@ static void blk_aio_detach(void *opaque)
> >  {
> >      NBDExport *exp =3D opaque;
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
> > =20
> >      exp->common.ctx =3D NULL;
> > @@ -1614,8 +1634,12 @@ static void nbd_drained_begin(void *opaque)
> >      NBDExport *exp =3D opaque;
> >      NBDClient *client;
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      QTAILQ_FOREACH(client, &exp->clients, next) {
> > -        client->quiescing =3D true;
> > +        WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +            client->quiescing =3D true;
> > +        }
> >      }
> >  }
> > =20
> > @@ -1624,9 +1648,13 @@ static void nbd_drained_end(void *opaque)
> >      NBDExport *exp =3D opaque;
> >      NBDClient *client;
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      QTAILQ_FOREACH(client, &exp->clients, next) {
> > -        client->quiescing =3D false;
> > -        nbd_client_receive_next_request(client);
> > +        WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +            client->quiescing =3D false;
> > +            nbd_client_receive_next_request(client);
> > +        }
> >      }
> >  }
> > =20
> > @@ -1635,17 +1663,21 @@ static bool nbd_drained_poll(void *opaque)
> >      NBDExport *exp =3D opaque;
> >      NBDClient *client;
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      QTAILQ_FOREACH(client, &exp->clients, next) {
> > -        if (client->nb_requests !=3D 0) {
> > -            /*
> > -             * If there's a coroutine waiting for a request on nbd_rea=
d_eof()
> > -             * enter it here so we don't depend on the client to wake =
it up.
> > -             */
> > -            if (client->recv_coroutine !=3D NULL && client->read_yield=
ing) {
> > -                qio_channel_wake_read(client->ioc);
> > +        WITH_QEMU_LOCK_GUARD(&client->lock) {
> > +            if (client->nb_requests !=3D 0) {
> > +                /*
> > +                 * If there's a coroutine waiting for a request on nbd=
_read_eof()
> > +                 * enter it here so we don't depend on the client to w=
ake it up.
> > +                 */
> > +                if (client->recv_coroutine !=3D NULL && client->read_y=
ielding) {
> > +                    qio_channel_wake_read(client->ioc);
> > +                }
>=20
> This is where the race from above becomes relevant.
>=20
> Let's first look at calling qio_channel_wake_read() a tiny bit too
> early: Without any locking in qio_channel_yield(), we could catch the
> read coroutine between setting ioc->read_coroutine and before actually
> yielding. In this case we would call aio_co_wake() on a coroutine that
> is still running in a different thread. Since it's in a different
> thread, we only schedule it instead entering it directly, and that just
> works. The coroutine will immediately be reentered, which is exactly
> what we want.
>=20
> Even earlier calls of qio_channel_wake_read() (i.e. between setting
> client->read_yielding and setting ioc->read_coroutine) don't actively
> hurt, they just don't do anything if no read is in flight. (This is the
> same case as if the nbd_trip() coroutine didn't even set
> client->read_yielding yet, just that the check you added above can't
> catch it.)
>=20
> So if nbd_read_eof() didn't yield yet, we don't wake it here, but we
> still return true, so the next drained_poll call will try again.
>=20
> This is good in principle, but it depends on waking up the main thread
> when we made progress. So we have to call aio_wait_kick() between
> setting ioc->read_coroutine and yielding to make this work. What we
> actually may get indirectly is an aio_notify() through setting FD
> handlers if all implementations of qio_channel_set_aio_fd_handler()
> actually do that. I suppose this could be enough?

qio_channel_set_aio_fd_handler() calls aio_notify() on the export's
AioContext. It does not wake the main loop AioContext when an IOThread
is being used so I don't think it helps here.

The state where qio_channel_wake_read() misses that nbd_trip() is
yielding looks like this:

client->nb_requests > 0
client->recv_coroutine =3D nbd_trip() coroutine
client->quiescing =3D true
client->read_yielding =3D true
ioc->read_coroutine =3D NULL

The main loop thread is waiting for activity and nbd_trip() enters
qemu_coroutine_yield(). There is no progress until the main loop thread
resumes (which can be triggered by the export AioContext completing NBD
I/O too).

I guess the race isn't immediately apparent because there is usually
some event loop activity that hides the problem.

> Anyway, if my result after thinking really hard about this is "I can't
> rule out that it's correct", maybe it would be better to just run this
> code in the export AioContext instead so that we don't have to think
> about all the subtleties and know that the nbd_co_trip() coroutine is at
> a yield point?

Agreed.

> > +
> > +                return true;
> >              }
> > -
> > -            return true;
> >          }
> >      }
> > =20
> > @@ -1656,6 +1688,8 @@ static void nbd_eject_notifier(Notifier *n, void =
*data)
> >  {
> >      NBDExport *exp =3D container_of(n, NBDExport, eject_notifier);
> > =20
> > +    assert(qemu_in_main_thread());
> > +
> >      blk_exp_request_shutdown(&exp->common);
> >  }
> > =20
> > @@ -2541,7 +2575,6 @@ static int coroutine_fn nbd_co_receive_request(NB=
DRequestData *req,
> >      int ret;
> > =20
> >      g_assert(qemu_in_coroutine());
> > -    assert(client->recv_coroutine =3D=3D qemu_coroutine_self());
> >      ret =3D nbd_receive_request(client, request, errp);
> >      if (ret < 0) {
> >          return ret;
> > @@ -2950,7 +2983,11 @@ static coroutine_fn void nbd_trip(void *opaque)
> >       */
> > =20
> >      trace_nbd_trip();
> > +
> > +    qemu_mutex_lock(&client->lock);
> > +
> >      if (client->closing) {
> > +        qemu_mutex_unlock(&client->lock);
> >          aio_co_reschedule_self(qemu_get_aio_context());
> >          nbd_client_put(client);
> >          return;
> > @@ -2961,15 +2998,24 @@ static coroutine_fn void nbd_trip(void *opaque)
> >           * We're switching between AIO contexts. Don't attempt to rece=
ive a new
> >           * request and kick the main context which may be waiting for =
us.
> >           */
> > -        aio_co_reschedule_self(qemu_get_aio_context());
> > -        nbd_client_put(client);
> >          client->recv_coroutine =3D NULL;
> > +        qemu_mutex_unlock(&client->lock);
> >          aio_wait_kick();
> > +
> > +        aio_co_reschedule_self(qemu_get_aio_context());
> > +        nbd_client_put(client);
> >          return;
> >      }
> > =20
> >      req =3D nbd_request_get(client);
> > -    ret =3D nbd_co_receive_request(req, &request, &local_err);
> > +
> > +    do {
> > +        assert(client->recv_coroutine =3D=3D qemu_coroutine_self());
> > +        qemu_mutex_unlock(&client->lock);
> > +        ret =3D nbd_co_receive_request(req, &request, &local_err);
> > +        qemu_mutex_lock(&client->lock);
> > +    } while (ret =3D=3D -EAGAIN && !client->quiescing);
>=20
> I think this deserves a comment to say that the loop is only about the
> drain case without polling where drained_end has already happened before
> we reach this point, so we may not terminate the coroutine any more
> because nothing would restart it.

Sounds good, I'll add a comment in the next revision.

> >      client->recv_coroutine =3D NULL;
>=20
> As soon as we're past this, the nbd_client_receive_next_request() called
> by drained_end will create a new coroutine, so we don't have to be
> careful about the same case after this.
>=20
> Kevin
>=20

--6xsMLA5vzHkGg9sP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWESDYACgkQnKSrs4Gr
c8g3+AgAwjXmhjM65KipF0nWCvcG1wv8YKWY0+0qouK5G8n2T2/+IdRUB+6RMfpZ
8fSqzjCLR76M6W8YmT0ACezvOKWovz0mWZkDTq/BFo4lrcsjiuWlzVNSe/BxQYpJ
0pD0P9niC4zzVuDpp7/9Y0zSRzjjn/JtLEwLcG9amJhDgzfsVlk7ZqFziyf95yX0
lu10zyKQMmudqrjecceC3jcOD6fBk3NNewdPA9oOYd6Y8/zOzT3UawFL8hvYb0Cu
Vnm/DIVQw15tl3aG4e9uLZigdRvNOtyiWWrXtiMBkvZclQeo3I9JMXflu/qFv9N/
p3GROKEofb7FtsykWlBWzvU8LDj9fA==
=hnft
-----END PGP SIGNATURE-----

--6xsMLA5vzHkGg9sP--


