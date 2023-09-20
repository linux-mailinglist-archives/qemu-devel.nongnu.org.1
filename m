Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A27A8DBF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj3i4-0002jm-1j; Wed, 20 Sep 2023 16:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3i1-0002j6-4z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qj3hz-0007Ha-G3
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695241321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XnS5fbpKqtBA2ToJlKUa/TVOgoujrTd1ezQW7ZZKxK4=;
 b=dHjay5Q0E5bRaYE1Jss4lBqo/iQf29ZCpJ5xS2Mupu3mY1Vr/P1C72tBvO32vNdmug9MFP
 N5yieeoJDGKfLaw59t+PGPZ4wIi9ZZHbeG9BOL9YdMXAcyAmDfvmZv+7vPMoA4PXhwdyTF
 hWeRhQCFPPH657Owv+C4wHHuQkd9DBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-WuWQlomgP6SWiy7IgLenZw-1; Wed, 20 Sep 2023 16:21:58 -0400
X-MC-Unique: WuWQlomgP6SWiy7IgLenZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B186D101A53B;
 Wed, 20 Sep 2023 20:21:57 +0000 (UTC)
Received: from localhost (unknown [10.39.193.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BF64C15BB8;
 Wed, 20 Sep 2023 20:21:57 +0000 (UTC)
Date: Wed, 20 Sep 2023 16:21:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v4 12/14] simpletrace: added simplified Analyzer2 class
Message-ID: <20230920202155.GK1094271@fedora>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-13-mads@ynddal.dk>
 <ZPciRnEvDK0IPNEA@redhat.com>
 <7DC8DA17-6848-4981-B576-A13025E1BB21@ynddal.dk>
 <ZPg+/DwZQOVeYVgz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZrdxNMPCBk8+QCxD"
Content-Disposition: inline
In-Reply-To: <ZPg+/DwZQOVeYVgz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZrdxNMPCBk8+QCxD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 09:57:32AM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 06, 2023 at 10:32:14AM +0200, Mads Ynddal wrote:
> >=20
> > > AFAIK, we don't consider simpletrace.py python code to be a
> > > supported public API, just a command line tool.
> > >=20
> > > IOW, we can change the python code at will, as long as the
> > > command line doesn't alter its behaviour. Thus I don't see
> > > a need to add new classes, just change the existing ones.
> > >=20
> > >=20
> > > With regards,
> > > Daniel
> > > --=20
> > > |: https://berrange.com      -o-    https://www.flickr.com/photos/dbe=
rrange :|
> > > |: https://libvirt.org         -o-            https://fstop138.berran=
ge.com :|
> > > |: https://entangle-photo.org    -o-    https://www.instagram.com/dbe=
rrange :|
> > >=20
> >=20
> > This was based on feedback from Stefan in v2. I don't have strong opini=
ons
> > about the one or the other. But now that the work has already been done,
> > I'd think the easiest would be to follow-through on the two versions.
> >=20
> > https://lore.kernel.org/qemu-devel/20230504180326.GB581920@fedora/
>=20
> I don't really agree with that feedback. We never document simpletrace.py
> as being a public facing Python API, only its usage as a CLI tool. It is
> also never installed into any Python library path, nor packaged as a PyPI
> module AFAIK.
>=20
> If someone is none the less importing simpletrace.py from their app
> then they should copy the file wholesale into that code and take the
> responsibility for their usage.
>=20
> I don't think QEMU should take on the burden of maintaining API
> compatibility for something we have never presented as a public API.

I wrote about the simpletrace API here in 2011:
http://blog.vmsplice.net/2011/03/how-to-write-trace-analysis-scripts-for.ht=
ml

It was intended as an API and I don't think we should break people's
scripts unless there is a strong reason.

I don't know how many users there are, but it feels wrong to break
existing scripts without a strong reason to do so.

Stefan

>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20

--ZrdxNMPCBk8+QCxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmULVGMACgkQnKSrs4Gr
c8hAWQf/Sd4szbd9A+0rSRDaFmepRG8cGQ80YUJ+amhLBtsnDuA/mNK6W/1S98vO
QKjYTJXZvBJSZDA07qwkBJ03VI+MCxyE2q7AtvxzRrosqrknWPilmS8rIeFdLSC6
ahdvYJtGQAZ4vE+qFsMoboYGBneEv5CN9pnyk8uijM5/BdglBg9a4RdDvJAEfl6j
45XYMHXmCdxR4joEcW9Qp3XE1MNfCXaOcwV/7g30FhEiluJ7tkMu2xc3Pl3ltbvW
BOLo7gsj57FgXY8OamuJtgeqbFMNEt/E4DpjZIfRC4cY1hrV0BmAqptrIsFSEDkE
Mb/kXuvlHv5pt5A0cTQVzvz99F4PUA==
=mgZN
-----END PGP SIGNATURE-----

--ZrdxNMPCBk8+QCxD--


