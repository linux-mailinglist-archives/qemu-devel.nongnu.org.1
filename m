Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BD718852
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:20:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PUh-0000EZ-CR; Wed, 31 May 2023 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4PUd-0000Dm-LK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4PUb-0007Il-KZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685553611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Da+xrLUci78d/ORr9Op6aR57X/Ol8SxoWfYz9URD31E=;
 b=AXpyU3KDKiMitPBWWiCTzAc90LNzCnfMEmFPCPvlgyrkbaBHT+MBERY6b+RZe1KPXyzawS
 YMX6ln9UAU0DF6nXqEM/ZWMB9MFXP1NrJtSobYCoxIRtK9dk0OWO0SV5mywg+zdMzgraxE
 6CuQYuCOn7s41NlDn79us2iUGeT5EJA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-0kF5Ggz3M_SIaq9dTk7tYw-1; Wed, 31 May 2023 13:20:08 -0400
X-MC-Unique: 0kF5Ggz3M_SIaq9dTk7tYw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654201C068ED;
 Wed, 31 May 2023 17:20:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7657E492B0A;
 Wed, 31 May 2023 17:20:04 +0000 (UTC)
Date: Wed, 31 May 2023 13:20:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v6 05/11] docs/deprecated: move QMP events bellow QMP
 command section
Message-ID: <20230531172002.GJ1248296@fedora>
References: <20230526165401.574474-1-alex.bennee@linaro.org>
 <20230526165401.574474-6-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8P/M8Rfy4TRbInXD"
Content-Disposition: inline
In-Reply-To: <20230526165401.574474-6-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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


--8P/M8Rfy4TRbInXD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 05:53:55PM +0100, Alex Benn=E9e wrote:
> Also rename the section to make the fact this is part of the
> management protocol even clearer.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  docs/about/deprecated.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8P/M8Rfy4TRbInXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR3gcIACgkQnKSrs4Gr
c8hflAf/VbfUG65BQ29q38V+rIlQbqCSk/k75EjhDGLUQpVEie0huxmpRNLm790e
zkyIGJW1uz/ZFclOARGD7Y6mKbjE1aOunEt6ss8tMyXzFYWIcZEqx2pIAveMYkxo
yID8oWXUKKtMKP2mRHixqUrkr66s03UKB9B4QzsVTSS73FEAWMMkYxAbN2uXy/Pp
g+3K14+QA5+V91ToiJUobiIDLdhe9PQLb2lsT/Vt2XA3LxE0m1Q+p4P0G9keIM97
/Z6ArkbeXdNKAdgKlMnAIY56NsOXqPWY3dVtSxf6qB7KjmUXyxfiUjTQEUKUfsso
AbV88UoFcwB4Q5DEOxZy5TMPQNTs9A==
=WvtQ
-----END PGP SIGNATURE-----

--8P/M8Rfy4TRbInXD--


