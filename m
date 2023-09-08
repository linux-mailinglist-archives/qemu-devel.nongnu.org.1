Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E472C798620
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZ0G-0001JR-TD; Fri, 08 Sep 2023 06:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ08-0001I1-CT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeZ04-0004Bk-Mt
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694169967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKWkZ2mg4fWzQS8Vnd6rLphnHNc7+O3C5Efy8HMutw0=;
 b=MIqUzaQT/CCSzTIHhE3J/P3AXmHrjHOF+stYJaLAMQlMFktGW15seilDW9Ndq69FoK0Ply
 r0/P6NFRKMfUDAhSv3C18hSC4t0N4LPsksKPavfAJD5Ftktnx9tLXL45uvVxp9cLuKo0AS
 rS2axYpRW/m3TRmGCGbJVlSDUeOMjus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Tf0999twN-mjlLwjFk9DVQ-1; Fri, 08 Sep 2023 06:46:04 -0400
X-MC-Unique: Tf0999twN-mjlLwjFk9DVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3AF69115E0;
 Fri,  8 Sep 2023 10:46:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D75A40C2070;
 Fri,  8 Sep 2023 10:46:02 +0000 (UTC)
Date: Fri, 8 Sep 2023 06:46:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <20230908104601.GB3552950@fedora>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230905145002.46391-3-kwolf@redhat.com>
 <20230907184031.GA1560640@fedora> <ZPrihIbmMJMRlP2W@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPdE0F5nClV7eDAK"
Content-Disposition: inline
In-Reply-To: <ZPrihIbmMJMRlP2W@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--PPdE0F5nClV7eDAK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 10:59:48AM +0200, Kevin Wolf wrote:
> Am 07.09.2023 um 20:40 hat Stefan Hajnoczi geschrieben:
> > On Tue, Sep 05, 2023 at 04:50:02PM +0200, Kevin Wolf wrote:
> > > virtio_load() as a whole should run in coroutine context because it
> > > reads from the migration stream and we don't want this to block.
> >=20
> > Is that "should" a "must" or a "can"?
> >=20
> > If it's a "must" then virtio_load() needs assert(qemu_in_coroutine()).
> >=20
> > But the previous patch mentioned that loadvm for snapshots calls it
> > outside coroutine context. So maybe it's a "can"?
>=20
> Where this makes a difference is when the function indirectly calls into
> QIOChannel. When called from a coroutine, it yields while waiting for
> I/O, and outside of a coroutine it blocks. Yielding is always
> preferable, but in cases like HMP savevm/loadvm we also don't really
> care because it's synchronous anyway.
>=20
> Whether that makes it a MAY or a SHOULD in the RFC sense, you decide.
> If you wanted to make it a MUST, you'd need to check all callers first
> and change some of them.

Thanks for clarifying. It is "can".

Stefan

--PPdE0F5nClV7eDAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6+2kACgkQnKSrs4Gr
c8jd6ggAgZKLB5sQOoDOXsAlEWHSUwUmUt3dLYeVVRpD4MOcgZG2ikWD8griybuf
mZ+OF4X/A2PfEna3pZ+xL2I4s0qIRLLE+Yjdf+wp0FsR+xQO7tWOYez5fF9KkB1Q
l6iKqMYh1U1kBwdxHgdL4/OkEE7YTbeLiHmjcpTqeHuaslWpA8R1lou63dU2o4q2
mvc3ziEd0px66og6TK5PiA82nod+RP4Nch6Z3W/1Tq9UAKNA9YjytpoymwI9WkmB
bjJfpa/UYnCKYeETGu28R47ZLZBKWyZRDGI8DPS/VxfCAFng0Jzk/whyKdtt1jLC
/AicbI9LUqMqrumedjVsZmN1tOyZTg==
=ZoFz
-----END PGP SIGNATURE-----

--PPdE0F5nClV7eDAK--


