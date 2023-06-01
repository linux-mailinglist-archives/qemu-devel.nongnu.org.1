Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F14719D2D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:18:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iC1-0006iU-9G; Thu, 01 Jun 2023 09:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4iBt-0006hf-TI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4iBr-0002pf-IO
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685625486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1oHRD2FrvYDtBzunw8ehneh7jdPHUY38x6ImHPiTfs=;
 b=SBRZ6ON60JF1EMBGCQW/X1C3/HJ1Dnj7qXIzpwl5FXbxtKd8npBsaR/R2ECExfidFZO5ww
 J1WcI/Be++ul2sdud0L64WZ94p52dzSnBKnolvo8rdQ+ZGFszca21zvnGbSZSZXuBbnTuS
 wpR+96N3iRzR6dp1YXteBqpnn15KYK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-3mDHGk81PguLD52fVfEqQQ-1; Thu, 01 Jun 2023 09:17:59 -0400
X-MC-Unique: 3mDHGk81PguLD52fVfEqQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30072862F5E;
 Thu,  1 Jun 2023 13:17:39 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEF68111F3B0;
 Thu,  1 Jun 2023 13:17:38 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:17:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Performance improvement and regression with
 6d740fb01b9f0f5ea7a82f4d5e458d91940a19ee
Message-ID: <20230601131737.GD1538357@fedora>
References: <ed0f3a6a-75f3-c6d5-8eb9-3f1575fc0766@redhat.com>
 <CAJSP0QWRLsFyzfP_Hn-frAgh6Xrz_5_JJCoxBQPnY6M60vfLag@mail.gmail.com>
 <34c16474-2022-455a-a506-58a8d2b6c3a6@redhat.com>
 <CAJSP0QUw3YAQoWNutnjoPWoVg4Cp-Cug7RR1MnVWFnes-fC-nQ@mail.gmail.com>
 <3584ed8c-e60c-54bd-1abe-8294e985119a@redhat.com>
 <CAJSP0QUc504kE_zM7fb0NQLG49eK2prWJZm9o=S6SosYqntEZA@mail.gmail.com>
 <36fd7ce5-38d2-59db-d182-3ded498319ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qh/wfGWfio0BDnIx"
Content-Disposition: inline
In-Reply-To: <36fd7ce5-38d2-59db-d182-3ded498319ee@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--Qh/wfGWfio0BDnIx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 06:23:21AM +0200, Luk=C3=A1=C5=A1 Doktor wrote:
> Dne 31. 05. 23 v 19:14 Stefan Hajnoczi napsal(a):
> > On Wed, 31 May 2023 at 12:50, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.co=
m> wrote:
> >>
> >> Dne 26. 05. 23 v 12:56 Stefan Hajnoczi napsal(a):
> >>> On Fri, 26 May 2023 at 04:07, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.=
com> wrote:
> >>>>
> >>>> Dne 25. 05. 23 v 17:21 Stefan Hajnoczi napsal(a):
> >>>>> On Thu, 25 May 2023 at 06:18, Luk=C3=A1=C5=A1 Doktor <ldoktor@redha=
t.com> wrote:
> >>>>>> the perf-ci detected and bisected the 6d740fb - aio-posix: do not =
nest poll handlers - as a performance improvement when using multiple concu=
rrent jobs and 4k (22%) as well as 1024k (63%) blocks on aarch64 (on a slow=
 rotational disk).
> >>>>>>
> >>>>>>     https://ldoktor.github.io/tmp/RedHat-virtlab-arm09/v8.0.0/150-=
improvement.html
> >>>>>>
> >>>>>> Based on the commit message I guess it's expected so take this jus=
t as a record of an improvement.
> >>>>>
> >>>>> The commit was not intended to change performance and I'm not sure =
why
> >>>>> it happens!
> >>>>>
> >>>>
> >>>> It had and today the x86_64 pipeline finished which shows similar im=
provement just not in read but rather in write instead and only for 4k bloc=
ks (~40%). For 1024k blocks I can see it scoring a bit better (~1.5%). Read=
s are too jittery to really tell anything on that machine. Anyway I have no=
t done any thorough testing, just a bisection with the most significant set=
ting.
> >>>>
> >>>> From around the same time I can see a NVMe regression in 4k writes, =
but first bisection job showed nothing. I'll increase the range and try aga=
in as each job since that day shows similar drop.
> >>>
> >>
> >> Hello Stefan, folks,
> >>
> >> the regression proved to be there and stably reproducible. With NVMe 4=
k writes with jobs=3D10 and iodepth=3D4 I can see a 50% regression on my ma=
chine:
> >>
> >>     https://ldoktor.github.io/tmp/RedHat-virtlab722/v8.0.0/150-regress=
ion.html
> >>
> >> The rest of the cases doesn't show any change at all. I can provide mo=
re data if someone is interested.
> >=20
> > Which commit caused the regression?
>=20
> Hello Stefan,
>=20
> the same one that caused the improvement on rotational disks: 6d740fb01b9=
f0f5ea7a82f4d5e458d91940a19ee

Thanks. This commit definitely needs more investigation. I didn't expect
it to have a noticeable effect.

I will take a look in July.

Stefan

--Qh/wfGWfio0BDnIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR4mnEACgkQnKSrs4Gr
c8hmqQf+MpC48qQJrrm1sL5kO9EB33p14qrDIYpq+aQ3ihwHrHJ8hEU8x2j+DQU9
WGvAceBgpdOx2px6GDO+At0K1sKtMzECVh3bfT1VrBDjcKEIKfddfLF24CaSQT5V
thOXz+aA+tatbGXp40caydqN44PC4z2r/hx1Ykhl/uPbkzjAY2g76dPj0Ix/qsO7
WOrTowLYPV507aO2PY4lJQPeUVNTU92m9rtMYEgQr+BCVNCfRCXBKYXlO+R1Xr5J
asQcTSXH6k8bD4JbXYktesIJi86ZRDt2e67Q1LhtTty+tGJNmYdI2+IWhqd8vMcp
GX46UZ7Wx1xpv/Z7tKb/dQ83x2yq3A==
=lmba
-----END PGP SIGNATURE-----

--Qh/wfGWfio0BDnIx--


