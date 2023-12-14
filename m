Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B763813B13
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 20:53:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDrl7-0003YX-CW; Thu, 14 Dec 2023 14:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDrl5-0003XD-1U
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDrl2-0006M7-Vg
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 14:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702583551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZzAg+k49kXwBjpIiDoDzMNl+j7/tM7DyV3OiTGRaOU=;
 b=T/rBqucUv/EQkEFaCHD85ATJRpguUNTGFWx/vnilmsOYe7L126jYJbyTAveCq5CC/2eIg1
 5A7f/7X628aGCwpy/3aIFLDhSvqNhm0+xDxQpyKiYNuSpRrUzyh8Rm+0iZ8vLVlSoIYCdb
 uw5oBLNhXDxndhdvykG4gcCLInq9ZPY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-X41-Zf1xOl6x0q8eaSM8ag-1; Thu,
 14 Dec 2023 14:52:28 -0500
X-MC-Unique: X41-Zf1xOl6x0q8eaSM8ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C95123C0256A;
 Thu, 14 Dec 2023 19:52:27 +0000 (UTC)
Received: from localhost (unknown [10.39.195.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89BA12026D66;
 Thu, 14 Dec 2023 19:52:26 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:52:25 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Message-ID: <20231214195225.GA1645604@fedora>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <CABgObfaTb8n66wqNxObnvgWdzu2=mgLHjX0fCPH99=-P918Apg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0dYIbuZO5ZdhuUmd"
Content-Disposition: inline
In-Reply-To: <CABgObfaTb8n66wqNxObnvgWdzu2=mgLHjX0fCPH99=-P918Apg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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


--0dYIbuZO5ZdhuUmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:10:32AM +0100, Paolo Bonzini wrote:
> On Wed, Dec 13, 2023 at 10:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> > Alternatives welcome! (A cleaner version of this approach might be to f=
orbid
> > cross-thread aio_set_fd_handler() calls and to refactor all
> > aio_set_fd_handler() callers so they come from the AioContext's home th=
read.
> > I'm starting to think that only the aio_notify() and aio_schedule_bh() =
APIs
> > should be thread-safe.)
>=20
> I think that's pretty hard because aio_set_fd_handler() is a pretty
> important part of the handoff from one AioContext to another and also
> of drained_begin()/end(), and both of these things run in the main
> thread.
>=20
> Regarding how to solve this issue, there is a lot of
> "underdocumenting" of the locking policy in aio-posix.c, and indeed it
> makes running aio_set_fd_handler() in the target AioContext tempting;
> but it is also scary to rely on the iothread being able to react
> quickly. I'm also worried that we're changing the logic just because
> we don't understand the old one, but then we add technical debt.
>=20
> So, as a first step, I would take inspiration from the block layer
> locking work, and add assertions to functions like poll_set_started()
> or find_aio_handler(). Is the list_lock elevated (nonzero)? Or locked?
> Are we in the iothread? And likewise, for each list, does insertion
> happen from the iothread or with the list_lock taken (and possibly
> elevated)? Does removal happen from the iothread or with list_lock
> zero+taken?
>=20
> After this step,  we should have a clearer idea of the possible states
> of the node (based on the lists, the state is a subset of
> {poll_started, deleted, ready}) and draw a nice graph of the
> transitions. We should also understand if any calls to
> QLIST_IS_INSERTED() have correctness issues.
>=20
> Good news, I don't think any memory barriers are needed here. One
> thing that we already do correctly is that, once a node is deleted, we
> try to skip work; see for example poll_set_started(). This also
> provides a good place to do cleanup work for deleted nodes, including
> calling poll_end(): aio_free_deleted_handlers(), because it runs with
> list_lock zero and taken, just like the tail of
> aio_remove_fd_handler(). It's the safest possible place to do cleanup
> and to take a lock. Therefore we have:
>=20
> - a fast path in the iothread that runs without any concurrence with
> stuff happening in the main thread
>=20
> - a slow path in the iothread that runs with list_lock zero and taken.
> The slow path shares logic with the main thread, meaning that
> aio_free_deleted_handlers() and aio_remove_fd_handler() should share
> some functions called by both.
>=20
> If the code is organized this way, any wrong bits should jump out more
> easily. For example, these two lines in aio_remove_fd_handler() are
> clearly misplaced
>=20
>     node->pfd.revents =3D 0;
>     node->poll_ready =3D false;
>=20
> because they run in the main thread but they touch iothread data! They
> should be after qemu_lockcnt_count() is checked to be zero.
>=20
> Regarding the call to io_poll_ready(), I would hope that it is
> unnecessary; in other words, that after drained_end() the virtqueue
> notification would be raised. Yes, virtio_queue_set_notification is
> edge triggered rather than level triggered, so it would be necessary
> to add a check with virtio_queue_host_notifier_aio_poll() and
> virtio_queue_host_notifier_aio_poll_ready() in
> virtio_queue_aio_attach_host_notifier, but that does not seem too bad
> because virtio is the only user of the io_poll_begin and io_poll_end
> callbacks. It would have to be documented though.

I think Hanna had the same idea: document that ->io_poll_end() isn't
called by aio_set_fd_handler() and shift the responsibility onto the
caller to get back into a state where notifications are enabled before
they add the fd with aio_set_fd_handler() again.

In a little more detail, the caller needs to do the following before
adding the fd back with aio_set_fd_handler() again:
1. Call ->io_poll_end().
2. Poll one more time in case an event slipped in and write to the
   eventfd so the fd is immediately readable or call ->io_poll_ready().

I think this is more or less what you described above.

I don't like pushing this responsibility onto the caller, but adding a
synchronization point in aio_set_fd_handler() is problematic, so let's
give it a try. I'll try that approach and send a v2.

Stefan

>=20
> Paolo
>=20
>=20
> Paolo
>=20
> >
> > Stefan Hajnoczi (3):
> >   aio-posix: run aio_set_fd_handler() in target AioContext
> >   aio: use counter instead of ctx->list_lock
> >   aio-posix: call ->poll_end() when removing AioHandler
> >
> >  include/block/aio.h |  22 ++---
> >  util/aio-posix.c    | 197 ++++++++++++++++++++++++++++++++------------
> >  util/async.c        |   2 -
> >  util/fdmon-epoll.c  |   6 +-
> >  4 files changed, 152 insertions(+), 75 deletions(-)
> >
> > --
> > 2.43.0
> >
>=20

--0dYIbuZO5ZdhuUmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV7XPkACgkQnKSrs4Gr
c8h6vQgAhVKAwy5g5DOeOgFUt7uXY86Yw+WaIUK6nfew8C3F9DlgFm6cmxBrVlc0
LwY+eHnWt87heiS1bw6U0SokcRRta0SYuirmnIMKPMaadCvDMupKChIjX8njLAzG
vnJqmSvF1yDB3JyKxC2BX3n4fRc2BlYZkH+elEntikws6SlmMd5mb5vkXHYMIyqw
++CSIYeW4GQT5EqR7CA8HVA1PiHDdhdqz5TH604Dv8OkRGCPAvGgjfhQeOj0AN6V
3GY+Ne2vCJreRojXtZagmmhkjyX3JkkrjqcCirf1U+ivyB/YlJ5j1FYk4fC/RPvS
0a3WBx4F83oshKdhlyLVed4irFUKzg==
=AYHM
-----END PGP SIGNATURE-----

--0dYIbuZO5ZdhuUmd--


