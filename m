Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5383680DB2D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:59:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCmQi-0004XP-IU; Mon, 11 Dec 2023 14:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rCmQf-0004W7-Cw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rCmQd-0005IU-JF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702324738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGinPrkiYBUv1YpF3Bzj3P62FX5Z+i7ujIcxMu/rMPE=;
 b=Fo6P9K32lXgODBQkYzxMyzW7wOjFqXzrexMiTBzlRmgPqs8D/HAnR4J+zxQTJbtEdIhvvR
 72jXti5CUBAF2XsuxYXyctykbV0XlcoDsKNcRsl3ebNKZPEEK8+zOMjBs55IjbuUBN301b
 nMqFOssDZjHJDq+mBL4yZehOVIg3G6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-v1B8qgfrPhenSkL7wH5zEw-1; Mon, 11 Dec 2023 14:58:54 -0500
X-MC-Unique: v1B8qgfrPhenSkL7wH5zEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60313869EC0;
 Mon, 11 Dec 2023 19:58:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7344FC15E6A;
 Mon, 11 Dec 2023 19:58:53 +0000 (UTC)
Date: Thu, 7 Dec 2023 06:11:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Carlos Santos <casantos@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org,
 Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Subject: Re: [PULL 20/20] tracing: install trace events file only if necessary
Message-ID: <20231207111110.GA2132561@fedora>
References: <20230420120948.436661-1-stefanha@redhat.com>
 <20230420120948.436661-21-stefanha@redhat.com>
 <CAC1VKkMadcEV4+UwXQQEONTBnw=xfmFC2MeUoruMRNkOLK0+qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/JWOOMTQ9rSr2PPQ"
Content-Disposition: inline
In-Reply-To: <CAC1VKkMadcEV4+UwXQQEONTBnw=xfmFC2MeUoruMRNkOLK0+qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--/JWOOMTQ9rSr2PPQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 07:26:01AM -0300, Carlos Santos wrote:
> On Thu, Apr 20, 2023 at 9:10=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > From: Carlos Santos <casantos@redhat.com>
> >
> > It is not useful when configuring with --enable-trace-backends=3Dnop.
> >
> > Signed-off-by: Carlos Santos <casantos@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20230408010410.281263-1-casantos@redhat.com>
> > ---
> >  trace/meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/trace/meson.build b/trace/meson.build
> > index 8e80be895c..30b1d942eb 100644
> > --- a/trace/meson.build
> > +++ b/trace/meson.build
> > @@ -64,7 +64,7 @@ trace_events_all =3D custom_target('trace-events-all',
> >                                   input: trace_events_files,
> >                                   command: [ 'cat', '@INPUT@' ],
> >                                   capture: true,
> > -                                 install: true,
> > +                                 install: get_option('trace_backends')=
 !=3D [ 'nop' ],
> >                                   install_dir: qemu_datadir)
> >
> >  if 'ust' in get_option('trace_backends')
> > --
> > 2.39.2
> >
>=20
> Hello,
>=20
> I still don't see this in the master branch. Is there something
> preventing it from being applied?

Hi Carlos,
Apologies, I dropped this patch when respinning the pull request after
the CI test failures caused by the zoned patches.

Your patch has been merged on my tracing tree again and will make it
into qemu.git/master when the development window opens again after the
QEMU 8.2.0 release (hopefully next Tuesday).

Stefan

>=20
> --=20
> Carlos Santos
> Senior Software Maintenance Engineer
> Red Hat
> casantos@redhat.com    T: +55-11-3534-6186
>=20

--/JWOOMTQ9rSr2PPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVxqE4ACgkQnKSrs4Gr
c8itQwf8CoYzCIy0daz+4j0btXA9PoCbVlfHqCBOS+l8Pjr8FeyLkZg1wrWCMOWv
DuCpUgJX3U2f3WyCxWz9mJmgwp92fUmiE8Pw1zoynlR/241nC+vkv49DNiNpRbPg
OKG1sJq7tAKLFjUUnbd13xSKFhTGiSUWUWsPIKkqwgPpo2hx37BDMef8fQgKXvWg
MqabZjG+szwCYbOWM/EOLLFlkRC7hGYix1Zk1NrTDxKzvsjc10FKEtdM0eXsCXli
+mNIyImiXUJc06uBuvnosPyuW5NkRTKUtXVmB2FBvtXpZ7+zCjMUo8rew4zTaBKC
iEeiNvC7ywXAE9+2LTmWMh/acfIc5Q==
=98O6
-----END PGP SIGNATURE-----

--/JWOOMTQ9rSr2PPQ--


