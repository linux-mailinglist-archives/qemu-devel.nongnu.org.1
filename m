Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B5817385
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:28:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEbG-0003B9-Gm; Mon, 18 Dec 2023 09:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFEbD-0003A6-T1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFEbA-00005Q-3I
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702909679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66a1M++RKNaoEQGAa8Vq3LhJd3pDx0gWmuTJ7REpLN4=;
 b=TbqCF55tOL96Wln8PsUM8yV9ZV589zmlg+E8Eq0i741vF5AOnC68Kd40/qEkAg61ZGCmEj
 SBGIK2tRFHI6YausJVdnhV0fRyhZPIOTIXNHk7AaeS7m8gVmvJzbn7mA4u/tUJ+rRJjeVa
 apWc0i9xmRWaMSjI8yZZVIoMgB+ucto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-bY8igLkYPcOl20NVNd6MfQ-1; Mon, 18 Dec 2023 09:27:22 -0500
X-MC-Unique: bY8igLkYPcOl20NVNd6MfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA547185A782;
 Mon, 18 Dec 2023 14:27:21 +0000 (UTC)
Received: from localhost (unknown [10.39.195.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20F542166B31;
 Mon, 18 Dec 2023 14:27:20 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:27:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: [RFC 3/3] aio-posix: call ->poll_end() when removing AioHandler
Message-ID: <20231218142719.GB12768@fedora>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <20231213211544.1601971-4-stefanha@redhat.com>
 <CABgObfYWPVFcqa5bBhPMZuS-6hh=nAt=pHztL5YHSAQOwiarig@mail.gmail.com>
 <20231214201213.GC1645604@fedora>
 <CABgObfb06Z=2q0Yqa9x0VcDJdRPV_siE2VDHnQTyaKkG1AgFug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fUB4iPzYBPnHiJBC"
Content-Disposition: inline
In-Reply-To: <CABgObfb06Z=2q0Yqa9x0VcDJdRPV_siE2VDHnQTyaKkG1AgFug@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
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


--fUB4iPzYBPnHiJBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:39:02PM +0100, Paolo Bonzini wrote:
> Il gio 14 dic 2023, 21:12 Stefan Hajnoczi <stefanha@redhat.com> ha scritt=
o:
>=20
> > Since the fd may be bypassed until ->io_poll_end() returns, we must poll
> > one last time to check if an event snuck in right at the end without
> > making the fd readable. If polling detected an event, then we must do
> > something. We cannot drop the event
>=20
>=20
> I agree that in general we cannot. I wonder however if, in the (already
> racy) case of a concurrent aio_set_fd_handler(ctx, fd, NULL, ...), you
> really need to call poll_ready here.

It doesn't need to happen here but it needs to be recorded so that the
handler (either poll_ready or the fd read handler) runs later. In the
case of eventfds it's easy to write(fd, ...) so that activity will be
picked up again when file descriptor monitoring resumes.

> >
> > (An alternative is to poll once before monitoring the fd again. That way
> > pending events are detected even if the fd wasn't readable. That is
> > currently not the way aio-posix.c works though.)
> >
>=20
> Yes, that would be a change. If I understood correctly Hanna's suggestions
> in the issue, she also mentioned doing a manual virtqueue notification
> before monitoring restarts. So basically my idea boils down to implementi=
ng
> that, and then cleaning up everything on top.

Okay.

Stefan

--fUB4iPzYBPnHiJBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWAVscACgkQnKSrs4Gr
c8ilWggAk3fIhq9NZd7TWyswkujjV1UPyAwmWUYC8s7KEdB9IpFdSBbacgWaZLrp
j5otoS5OEooaQTlgtzIgUdg9BYyJMbq8nwl2dQvpaW9WrJ1B5ehHGI1uT2hqiKP9
qz6XbgCi33g66fzbgvF/XB8/aBx47jl6Tvn6JBR7llD3yQ7NUNGHXAtyjidumisl
dn75HsPiU3z57dsyZC7rHDy/3mkGq8KR1UclZFeeHlQrwvgVw5XLIepjgFTCeUqw
lPxIZBb8eylrccMkzXGBwgzQDtT1WX9I9Fy8GerszzK1wlsAP37tctxJVT9djKZG
SGeEft0hwZ4vhnpCpr01zhj77l04bg==
=5i7d
-----END PGP SIGNATURE-----

--fUB4iPzYBPnHiJBC--


