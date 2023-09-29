Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4BE7B344D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEAg-0007B1-A1; Fri, 29 Sep 2023 10:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmEAc-0007AA-Mz
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmEAa-00049Q-Sg
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695996519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14xwSLoA3IK6FMaV/gfG4VOBR5ReouAscSMEojP7K50=;
 b=h9oChunbr4+tquFQoL18O84kgPDSbaYKKdLdliH0TKRd6303wbNEpAnR80AhZQkJcjUc/4
 FwyV2/wM0xXOaQ2Dnf/lYI6jkAvtA8m79YE+Z/wsgXEujTcAT0zkVyzheBxl7bKksNrqhI
 0O1hL6OeOUduWbEPp2OxVq8sI0OgyIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-URkRF5HxOEGTh6ApxYjVjg-1; Fri, 29 Sep 2023 10:08:37 -0400
X-MC-Unique: URkRF5HxOEGTh6ApxYjVjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B03E802D38
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:08:37 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B45C40C2064;
 Fri, 29 Sep 2023 14:08:37 +0000 (UTC)
Date: Fri, 29 Sep 2023 16:08:36 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/9] qapi-go: add generator for Golang interface
Message-ID: <d2s3airtompd2qnaov4cw5idaz7xsp74zvokpy3edqxdh5cfs4@bkywrfln24om>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <ZRWCSzrqDojlPOO4@redhat.com> <ZRWFgo/fik+mXQXw@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r4lmkymefobx65tu"
Content-Disposition: inline
In-Reply-To: <ZRWFgo/fik+mXQXw@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--r4lmkymefobx65tu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 02:54:10PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Sep 28, 2023 at 02:40:27PM +0100, Daniel P. Berrang=E9 wrote:
> > On Wed, Sep 27, 2023 at 01:25:35PM +0200, Victor Toso wrote:
> > IOW, it would push towards
> >=20
> >    go-qemu.git
> >    go-qga.git
> >    go-qsd.git
> >=20
> > and at time of each QEMU release, we would need to invoke the code
> > generator, and store its output in the respective git modules.
> >=20
> > This would also need the generator application to be a standalone
> > tool, separate from the C QAPI generator.
>=20
> Oh, and we need to assume that all CONFIG conditionals in the QAPI
> files are true, as we want the Go API to be feature complete such
> that it can be used with any QEMU build, regardless of which CONFIG
> conditions are turned on/off. We also don't want applications to
> suddenly fail to compile because some API was stopped being generated
> by a disabled CONFIG condition - it needs to be a runtime error
> that apps can catch and handle as they desire.

I haven't tested if what is provided to scripts/qapi/golang.py
relies on enabled CONFIG only, I think not. But yes, the
generated module should have it all.

Cheers,
Victor

--r4lmkymefobx65tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW2mQACgkQl9kSPeN6
SE+LfhAAmXDdV907ffRRT3kuXMNOY6FaD3n4XhiQ2JyZFgaLuZqe+UIaUaqPvR5w
KW54BuOV02eCwIiNdenSY4l204rZlSPN/gSFEXN8Gtz4mzyo1HQ51ztINQ6EncG+
vJ00y8Ci5zzP+c8MR8E3NMz53TCtTBKNroR9b1S7+O4awJAfCoOeyXzllp6xYxoe
Q+ztplHulc+tRia8ARVbT1i1H+7woN3yq34JjGL01aIrBl6E1hP65y4pSb6plY/f
qolI+62eYwGuqna2xoSCDRiaO8J0XQPk7+o51SYIzL6jKxnEwnHyrTVI2NZ9HBvL
E4quzSdhRHEdPQc2x9uZzciqr+u0YH6KZapIEk3gkI0QriXHNxloR1nmF+UIbeJp
iNK76SgzPAaFRAhIVQvlvwya1EFsPQ74ZY7MnBCFpGE0HMm2kmrE7SORERGIcrY4
i7jHjroF9jxOdjJzjImM5lf0il1ppDAj0IDnW6eUj+Psq+IVX7jXWeY4TKHp1jah
Mb9JJaGfm1k01dKHBQ7RkbT36NhoYtJvO8T3ZzLReU73xyOSrLqEXYdhWyEoff+m
w89oUyKiXOV+62T3aRvVYde+VBbouwPVHKaeD6h9QQJJiCs5LhFDOe/k8qQUmmgG
pClTj7SG3kQH3rCANFu7m/6KUKwmSqFBPA3/K5OUrc5c7jdlHhw=
=JAMO
-----END PGP SIGNATURE-----

--r4lmkymefobx65tu--


