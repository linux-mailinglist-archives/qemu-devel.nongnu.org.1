Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123A475B81B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 21:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZRe-0003u5-Da; Thu, 20 Jul 2023 15:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZRb-0003rX-6w
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qMZRZ-0007Y1-LO
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689881769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBMnzG4MebFIf16BpkbQyP0Yw4tKPK9x1cMKc+CNT+k=;
 b=SOv/3Cgz26a4G9cq11pQzRv2Jrymh15zTRrQuMP9saA5bYAunC92ATezJOacOLT2PTUN0p
 T9O+aPZeU8fyhU+piz7QW1v7smNMpyro/MSI7e22lmE/9peGoK5lK10IXiE44/gcDhV1vi
 G7DQEXQvKgs4j9amLTQR7Sev+bz1vlU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-sTKFDoLzPx6EJnvZT2Gw4g-1; Thu, 20 Jul 2023 15:36:04 -0400
X-MC-Unique: sTKFDoLzPx6EJnvZT2Gw4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 093EB3C160E4;
 Thu, 20 Jul 2023 19:36:03 +0000 (UTC)
Received: from localhost (unknown [10.39.194.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61A3740C6F4C;
 Thu, 20 Jul 2023 19:36:02 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:36:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user
Message-ID: <20230720193601.GI210977@fedora>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
 <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PJgjM68U1AKlFxoJ"
Content-Disposition: inline
In-Reply-To: <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--PJgjM68U1AKlFxoJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 12:27:39PM +0200, Stefano Garzarella wrote:
> On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Benn=E9e wrote:
> >=20
> > Stefano Garzarella <sgarzare@redhat.com> writes:
> >=20
> > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=E9e wrote:
> > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.=
rst
> > > > index 5a070adbc1..85b1b1583a 100644
> > > > --- a/docs/interop/vhost-user.rst
> > > > +++ b/docs/interop/vhost-user.rst
> > > > @@ -275,6 +275,21 @@ Inflight description
> > > >=20
> > > > :queue size: a 16-bit size of virtqueues
> > > >=20
> > > > +Backend specifications
> > > > +^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > ++-----------+-------------+------------+------------+
> > > > +| device id | config size |   min_vqs  |   max_vqs  |
> > > > ++-----------+-------------+------------+------------+
> > > > +
> > > > +:device id: a 32-bit value holding the VirtIO device ID
> > > > +
> > > > +:config size: a 32-bit value holding the config size (see ``VHOST_=
USER_GET_CONFIG``)
> > > > +
> > > > +:min_vqs: a 32-bit value holding the minimum number of vqs support=
ed
> > >=20
> > > Why do we need the minimum?
> >=20
> > We need to know the minimum number because some devices have fixed VQs
> > that must be present.
>=20
> But does QEMU need to know this?
>=20
> Or is it okay that the driver will then fail in the guest if there
> are not the right number of queues?

I don't understand why min_vqs is needed either. It's not the
front-end's job to ensure that the device will be used properly. A
spec-compliant driver will work with a spec-compliant device, so it's
not clear why the front-end needs this information.

Stefan

--PJgjM68U1AKlFxoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS5jKAACgkQnKSrs4Gr
c8iL2QgAqCc6gx0y20MWAVkqX4M5cONVtaHUBQz26ZTaU20ipQ1qS4HYsgGW67hX
fthNJsVS3gGpAhkjOf3bWMB5s20sjAEdifjqZe8C2HL2AxRJsNYBZwH/btA3aWbC
0w7uxLUcXv1ccqsE4CMp+DPIHOnKwA5ewlbg7P04ya4kNjzx5WM2EMJhlJ9vbybx
+7UuPukQDV/TG3yBJOz61wCQQ/ABt0njwxXJakMVyRj0O6aHbZDPs09ibFmc9jDW
O+35GNYVSdvN3/cd8J6Vc2ikJ4q+jEK0/E8jbh6+jc7OOQ3BKnluKhwkGYvouSDK
Ia7ziZJnl7n7fzghOOdSpPu8/a63RQ==
=dGKO
-----END PGP SIGNATURE-----

--PJgjM68U1AKlFxoJ--


