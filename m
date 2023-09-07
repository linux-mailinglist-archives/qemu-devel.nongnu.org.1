Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049007972F0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:01:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFYZ-0005B1-1y; Thu, 07 Sep 2023 10:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeFYV-00053o-1D
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeFYM-0005uH-Qp
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694095213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdX9m9ClspaMyni0xKcwKM5+1RqINUKJ0EJg84FJylg=;
 b=gajEIvdIUuQI6ikIG/ptnuVw0KJOgWGJ2H/asD8HDXgrhKwrG7XLxS3yuyMjoGFaJYT5R3
 bX8mBf66TzeQGInzqngP3TtvMhjV3DyZYRcjO3dwx5m5vUeVCm//m8sNCj6ZMkdOGDHUNE
 NVFG7fwENVt4nitAoJR6aH+rfAJ6q7k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-clxZNNdDMaykreeSxtrB3A-1; Thu, 07 Sep 2023 10:00:10 -0400
X-MC-Unique: clxZNNdDMaykreeSxtrB3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FA69101CA8D;
 Thu,  7 Sep 2023 14:00:08 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03E9440C84A6;
 Thu,  7 Sep 2023 14:00:07 +0000 (UTC)
Date: Thu, 7 Sep 2023 10:00:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
Message-ID: <20230907140006.GA1363873@fedora>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IA5HAkDBlFunFGqC"
Content-Disposition: inline
In-Reply-To: <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--IA5HAkDBlFunFGqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 01:28:55PM +0200, Paolo Bonzini wrote:
> On 9/6/23 21:01, Stefan Hajnoczi wrote:
> > It is not safe to call drain_call_rcu() from qmp_device_add() because
> > some call stacks are not prepared for drain_call_rcu() to drop the Big
> > QEMU Lock (BQL).
> >=20
> > For example, device emulation code is protected by the BQL but when it
> > calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
> > BQL is dropped. See https://bugzilla.redhat.com/show_bug.cgi?id=3D22151=
92 for a
> > concrete bug of this type.
> >=20
> > Another limitation of drain_call_rcu() is that it cannot be invoked wit=
hin an
> > RCU read-side critical section since the reclamation phase cannot compl=
ete
> > until the end of the critical section. Unfortunately, call stacks have =
been
> > seen where this happens (see
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2214985).
>=20
> I think the root cause here is that do_qmp_dispatch_bh is called on the
> wrong context, namely qemu_get_aio_context() instead of
> iohandler_get_aio_context().  This is what causes it to move to the vCPU
> thread.
>=20
> Auditing all subsystems that use iohandler_get_aio_context(), for example
> via qemu_set_fd_handler(), together with bottom halves, would be a bit
> daunting.
>=20
> I don't have any objection to this patch series actually, but I would like
> to see if using the right AioContext also fixes the bug---and then treat
> these changes as more of a cleanup.  Coroutines are pretty pervasive in Q=
EMU
> and are not going away which, as you say in the updated docs, makes
> drain_call_rcu_co() preferrable to drain_call_rcu().

While I agree that the issue would not happen if monitor commands only
ran in the iohandler AioContext, I don't think we can change that.

When Kevin implemented coroutine commands in commit 9ce44e2ce267 ("qmp:
Move dispatcher to a coroutine"), he used qemu_get_aio_context()
deliberately so that AIO_WAIT_WHILE() can make progress.

I'm not clear on the exact scenario though, because coroutines shouldn't
call AIO_WAIT_WHILE().

Kevin?

There is only one coroutine monitor command that calls the QEMU block
layer: qmp_block_resize(). If we're going to change how the AioContext
works then now is the time to do it before there are more commands that
need to be audited/refactored.

Stefan

>=20
> Paolo
>=20
>=20
> > This patch series introduces drain_call_rcu_co(), which does the same t=
hing as
> > drain_call_rcu() but asynchronously. By yielding back to the event loop=
 we can
> > wait until the caller drops the BQL and leaves its RCU read-side critic=
al
> > section.
> >=20
> > Patch 1 changes HMP so that coroutine monitor commands yield back to th=
e event
> > loop instead of running inside a nested event loop.
> >=20
> > Patch 2 introduces the new drain_call_rcu_co() API.
> >=20
> > Patch 3 converts qmp_device_add() into a coroutine monitor command and =
uses
> > drain_call_rcu_co().
> >=20
> > I'm sending this as an RFC because I don't have confirmation yet that t=
he bugs
> > mentioned above are fixed by this patch series.
> >=20
> > Stefan Hajnoczi (3):
> >    hmp: avoid the nested event loop in handle_hmp_command()
> >    rcu: add drain_call_rcu_co() API
> >    qmp: make qmp_device_add() a coroutine
> >=20
> >   MAINTAINERS            |  2 ++
> >   docs/devel/rcu.txt     | 21 ++++++++++++++++
> >   qapi/qdev.json         |  1 +
> >   include/monitor/qdev.h |  3 ++-
> >   include/qemu/rcu.h     |  1 +
> >   util/rcu-internal.h    |  8 ++++++
> >   monitor/hmp.c          | 28 +++++++++++----------
> >   monitor/qmp-cmds.c     |  2 +-
> >   softmmu/qdev-monitor.c | 34 +++++++++++++++++++++++---
> >   util/rcu-co.c          | 55 ++++++++++++++++++++++++++++++++++++++++++
> >   util/rcu.c             |  3 ++-
> >   hmp-commands.hx        |  1 +
> >   util/meson.build       |  2 +-
> >   13 files changed, 140 insertions(+), 21 deletions(-)
> >   create mode 100644 util/rcu-internal.h
> >   create mode 100644 util/rcu-co.c
> >=20
>=20

--IA5HAkDBlFunFGqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT512YACgkQnKSrs4Gr
c8i9CQf/RrUb/1BKUku+ilzoX5SxzUA9gpDQ/ZkXu0Zcrspq4iY5NOnJXFIedEC7
XwS6c/SiXsz0mnhq7GHOmc3adI1meUpQCxsw5wU3NkqPrFKC8kZMzRPP69NBRJWI
xtAazxeqKexE66gLxfZWwKteFQu2cKJZ/xNQLn7PYh1FAAtSOesLKRNnanDk/8Lu
q+Heo7rlh102x1QnFxs9umNlSZjQBy3dZrQBn8xe0hFc3eNpOG25hYMA2eGcea+H
dPSfhmlrkHmYhZZRw9vepoqnxtKfQX8YfZ+1yuxVI3V9SWgpc+QPC+7C4rGwdodP
vgHsHeZ+Vd/g8TD6sNgbOqa8OUTYzQ==
=05Rd
-----END PGP SIGNATURE-----

--IA5HAkDBlFunFGqC--


