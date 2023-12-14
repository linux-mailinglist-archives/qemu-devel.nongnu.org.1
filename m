Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F497813B55
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 21:13:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDs4L-0001S3-L8; Thu, 14 Dec 2023 15:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDs4G-0001RI-Jo
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 15:12:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDs4F-0003Q5-5U
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 15:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702584742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkCAHKe0ABYLw6XXJWjaL/39CmSp8sgOB6Acn5ISO7U=;
 b=TLqgoiHyZlWdyXgY0/q8DXb1bbkh9Lxy0Saf52bODDtttYFw6470lhthZ02aiHXINJJxqu
 Hb5NHSBqrb/YUwAQNAj0tCX+9VF/2flsuS3hO9ClNHDkcCE7Bxx/x9i2lZf2+LIw3lyMza
 gcPhNTs5O26zPjGlBUiAdaYw5N6M2W0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-VlMMvTUqOBCziToO-67U_A-1; Thu, 14 Dec 2023 15:12:18 -0500
X-MC-Unique: VlMMvTUqOBCziToO-67U_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADF68848D60;
 Thu, 14 Dec 2023 20:12:17 +0000 (UTC)
Received: from localhost (unknown [10.39.195.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 124CB1C060B1;
 Thu, 14 Dec 2023 20:12:16 +0000 (UTC)
Date: Thu, 14 Dec 2023 15:12:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [RFC 3/3] aio-posix: call ->poll_end() when removing AioHandler
Message-ID: <20231214201213.GC1645604@fedora>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <20231213211544.1601971-4-stefanha@redhat.com>
 <CABgObfYWPVFcqa5bBhPMZuS-6hh=nAt=pHztL5YHSAQOwiarig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vEaeZh5ooG4PIl2u"
Content-Disposition: inline
In-Reply-To: <CABgObfYWPVFcqa5bBhPMZuS-6hh=nAt=pHztL5YHSAQOwiarig@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--vEaeZh5ooG4PIl2u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:52:58PM +0100, Paolo Bonzini wrote:
> On Wed, Dec 13, 2023 at 10:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> > -    /* If a read is in progress, just mark the node as deleted */
> > -    if (ctx->walking_handlers > 0) {
> > -        QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_d=
eleted);
> > -        return false;
> > +    /* If polling was started on the node then end it now */
> > +    if (ctx->poll_started && node->io_poll_end) {
> > +        node->io_poll_end(node->opaque);
> > +
> > +        /* Poll one last time in case ->io_poll_end() raced with the e=
vent */
> > +        if (node->io_poll(node->opaque)) {
> > +            poll_ready =3D true;
> > +        }
>=20
> Do you need this at all? If the caller is removing the handlers, they
> should have put themselves in a state where they don't care about the
> file descriptor becoming readable.

The caller no longer wishes to monitor the fd. This may be temporary
though. The fd must stay readable so that the caller can monitor it
again in the future and handle pending events.

->io_poll_begin() and ->io_poll_end() are used to bypass the fd while in
polling mode (e.g. disabling virtqueue kicks). This is a performance
optimization that avoids wasting cycles servicing fds when we're polling
anyway.

When the caller does:
1. aio_set_fd_handler(ctx, fd, NULL, ...)    // stop monitoring
2. aio_set_fd_handler(ctx, fd, read_fd, ...) // start monitoring

Then read_fd() should be called if the fd became readable between 1 and 2.

Since the fd may be bypassed until ->io_poll_end() returns, we must poll
one last time to check if an event snuck in right at the end without
making the fd readable. If polling detected an event, then we must do
something. We cannot drop the event.

(An alternative is to poll once before monitoring the fd again. That way
pending events are detected even if the fd wasn't readable. That is
currently not the way aio-posix.c works though.)

Stefan

--vEaeZh5ooG4PIl2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmV7YZ0ACgkQnKSrs4Gr
c8hnOgf9Hgq2bfIaSBdG6CK9a4sbdwHYI/hnz/tPHe+CE7IxjFVNiyYUDib0aUPC
QdvNuTxui1OcqbCpWbkJoJ5S4G4VmqnX1eYY235JH4kQX0CIGH9rEen8iNLk/cPx
YB8Irlj1Z0ezrct1Xr+/udkLUnsHDd/FOZj/DjKFBg/9vlOKEFW1ax/Y9ZHyhLVf
5l4rWsOSutyyWgpd/6dOfeb1UWWhKowK6epWtp/Cfns2WvPON9yn6f0qDi+nyR6O
7loC1x1U3cN7c2jenu/asEjx7wv2jaoDvNj7w3VLh2zpNSWjOmXVbQpGbZaYJlg5
jLlcU4VziuXiQUgvhpsoEklKP4boiA==
=RhM/
-----END PGP SIGNATURE-----

--vEaeZh5ooG4PIl2u--


