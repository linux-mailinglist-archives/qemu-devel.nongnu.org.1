Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A822D7877C8
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZF2m-0002Jg-M3; Thu, 24 Aug 2023 14:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZF2h-0002JE-JC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZF2f-0004mi-6H
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692901608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DFqBgX2wS6IL3hZnozsIkEhT25u6loo5luOVck76jXY=;
 b=ar+YyzADn4vkNwEmVr3tQVeY6lktX5e54vz0vLnetpaZawZXax9W7OEqhNTqGhZeweCu/5
 f8nUizKq8oYTZ8RLNwSb4+JksHWnAAHPQjHFPDZ/9KMEO53jbKn8b1FOR5A8/KZbuXZyo8
 96I7+E/TiH+20RtAQgrH1FWyUYuPzkE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-rZois7fLOF6ZjgpKnGXwaQ-1; Thu, 24 Aug 2023 14:26:45 -0400
X-MC-Unique: rZois7fLOF6ZjgpKnGXwaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96145280BC4B;
 Thu, 24 Aug 2023 18:26:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16402492C13;
 Thu, 24 Aug 2023 18:26:43 +0000 (UTC)
Date: Thu, 24 Aug 2023 14:26:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Message-ID: <20230824182642.GA1698358@fedora>
References: <20230823234504.1387239-1-stefanha@redhat.com>
 <20230823234504.1387239-3-stefanha@redhat.com>
 <ZOc+TXIwqs5PTiV/@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HKZ33PX6AUBd3GmZ"
Content-Disposition: inline
In-Reply-To: <ZOc+TXIwqs5PTiV/@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HKZ33PX6AUBd3GmZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 12:26:05PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Aug 23, 2023 at 07:45:04PM -0400, Stefan Hajnoczi wrote:
> > The ongoing QEMU multi-queue block layer effort makes it possible for m=
ultiple
> > threads to process I/O in parallel. The nbd block driver is not compati=
ble with
> > the multi-queue block layer yet because QIOChannel cannot be used easil=
y from
> > coroutines running in multiple threads. This series changes the QIOChan=
nel API
> > to make that possible.
> >=20
> > In the current API, calling qio_channel_attach_aio_context() sets the
> > AioContext where qio_channel_yield() installs an fd handler prior to yi=
elding:
> >=20
> >   qio_channel_attach_aio_context(ioc, my_ctx);
> >   ...
> >   qio_channel_yield(ioc); // my_ctx is used here
> >   ...
> >   qio_channel_detach_aio_context(ioc);
> >=20
> > This API design has limitations: reading and writing must be done in th=
e same
> > AioContext and moving between AioContexts involves a cumbersome sequenc=
e of API
> > calls that is not suitable for doing on a per-request basis.
> >=20
> > There is no fundamental reason why a QIOChannel needs to run within the
> > same AioContext every time qio_channel_yield() is called. QIOChannel
> > only uses the AioContext while inside qio_channel_yield(). The rest of
> > the time, QIOChannel is independent of any AioContext.
> >=20
> > In the new API, qio_channel_yield() queries the AioContext from the cur=
rent
> > coroutine using qemu_coroutine_get_aio_context(). There is no need to
> > explicitly attach/detach AioContexts anymore and
> > qio_channel_attach_aio_context() and qio_channel_detach_aio_context() a=
re gone.
> > One coroutine can read from the QIOChannel while another coroutine writ=
es from
> > a different AioContext.
> >=20
> > This API change allows the nbd block driver to use QIOChannel from any =
thread.
> > It's important to keep in mind that the block driver already synchroniz=
es
> > QIOChannel access and ensures that two coroutines never read simultaneo=
usly or
> > write simultaneously.
> >=20
> > This patch updates all users of qio_channel_attach_aio_context() to the
> > new API. Most conversions are simple, but vhost-user-server requires a
> > new qemu_coroutine_yield() call to quiesce the vu_client_trip()
> > coroutine when not attached to any AioContext.
> >=20
> > While the API is has become simpler, there is one wart: QIOChannel has a
> > special case for the iohandler AioContext (used for handlers that must =
not run
> > in nested event loops). I didn't find an elegant way preserve that beha=
vior, so
> > I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true=
|false)
> > for opting in to the new AioContext model. By default QIOChannel uses t=
he
> > iohandler AioHandler. Code that formerly called
> > qio_channel_attach_aio_context() now calls
> > qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChann=
el is
> > created.
>=20
> I wonder if it is better to just pass the AioContext object into
> qio_channel_yield explicitly eg have
>=20
>   qio_channel_yield(QIOChannel *ioc,
>                     AioContext *ctx,
>                     GIOCondition cond);
>=20
> With semantics that if 'ctx =3D=3D NULL', then we assume the default
> global iohandler context, and for non-default context it must
> be non-NULL ?
>=20
> That could nicely de-couple the API  from relying on global
> coroutine/thread state for querying an AioContext, which
> makes it easier to reason about IMHO.

Hi Dan,
I've done most of the audit necessary to understand which AioContext is
used where. The call graph is large because qio_channel_yield() is used
internally by qio_channel_readv_full_all_eof(),
qio_channel_writev_full_all(), and their variants. They would all need
a new AioContext argument.

I think it's not worth passing AioContext explicitly everywhere since
this involves a lot of code changes and more verbosity to achieve what
we already have.

However, If you think the QIOChannel API should pass AioContext
explicitly then I'll go ahead and make the changes.

Here is what I've explored so far:

qio_channel_readv_full_all_eof
  mpqemu_read - should be doable
  qio_channel_readv_all_eof
    qio_channel_read_all_eof
      multifd_recv_thread - NULL non-coroutine
    vu_message_read - coroutine AioContext
  qio_channel_readv_full_all
    hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
    qio_channel_readv_all
      nbd_co_receive_offset_data_payload - coroutine AioContext
      nbd_co_do_receive_one_chunk - coroutine AioContext
      qio_channel_read_all
        hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
        tpm_emulator_unix_tx_bufs - NULL non-coroutine
        nbd_read - ?
        zlib_recv_pages - NULL non-coroutine
        zstd_recv_pages - NULL non-coroutine
        multifd_initial_recv_packet - NULL non-coroutine
        nbd_opt_read - iohandler
        pr_manager_helper_read - NULL non-coroutine
        prh_read_request - coroutine AioContext
        prh_co_entry - coroutine AioContext
        char_socket_ping_pong - NULL non-coroutine
      nocomp_recv_pages - NULL non-coroutine
      test_io_thread_reader - NULL non-coroutine
qio_channel_writev_full_all
  mpqemu_msg_send - should be doable
  qio_channel_writev_all
    nbd_co_send_request - coroutine AioContext
    hw/virtio/vhost-user.c:backend_read() - NULL non-coroutine
    qio_channel_write_all
      tpm_emulator_unix_tx_bufs - NULL non-coroutine
      multifd_send_initial_packet - NULL non-coroutine
      multifd_send_thread - NULL non-coroutine
      nbd_write - ?
      prh_write_response - coroutine AioContext
      prh_co_entry - coroutine AioContext
      char_socket_ping_pong - NULL non-coroutine
      ppm_save - iohandler
    qemu_fflush - ?
    nbd_negotiate_send_meta_context - iohandler
    nbd/server.c:nbd_co_send_iov - cooroutine AioContext
    test_io_thread_writer - NULL non-coroutine
  multifd_send_thread - NULL non-coroutine
qemu_fill_buffer - ?

What do you think?

Stefan

--HKZ33PX6AUBd3GmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnoOIACgkQnKSrs4Gr
c8hH9AgAoceDEdG7jMFdPHa11z+5qwZHC+7PUrrDdgSp8SrhEjipYfUwrY0CKAZb
2WwFj0R9fKKDI+9L+1BFWhU0htTiuVD52CLqdN47lp5u+MipAaf5IWxWv4bSmidD
FDaKvB/5+NO4Xr37LK+vmdpdLXbobmQf+RVK2Y0mN1JsbpgoJfgwC7ORSrzOkJRD
7z7rFx4o0cvuuGf5WlgnICSN6jkBT+4uvc8qazWBnFjYXUC61aodFkOT+D6RgoMD
NRdAH1Ce74oA/7g1qHlwNU3onKD1MXvQFaKGHbDxh7YeMszZp6O+cbH80mNWpSWd
JsprN8oQ0rX6+TLtza4cpM8W4CgtdA==
=oPqy
-----END PGP SIGNATURE-----

--HKZ33PX6AUBd3GmZ--


