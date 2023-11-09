Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1477E6442
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:24:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zND-0007T3-PD; Thu, 09 Nov 2023 02:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0zNB-0007SP-QJ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0zNA-00058d-Bo
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699514559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBng7E+SYcWRVKdT5yOtDU7tjt06SD/Zx9zSwjMFx/I=;
 b=Egu/2rQsS8Q/xCL4vqvev+Gh/NamUuVLAPoD6ZT6/HXwQ7XsZ6hrqBM/Ekxf/hm6r09w2C
 EKnFb7vgwIv1+tU9YM/b5UA5OXLIIV8TChDt9fjbnWSm40giQyzTmtRVD3BOkn6HuBMoLM
 dCBz9dBNGcrbsU2RXVcWfZrfFJf8xA0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-n0Ok2F9wMvudkC0IhaIaDA-1; Thu,
 09 Nov 2023 02:22:35 -0500
X-MC-Unique: n0Ok2F9wMvudkC0IhaIaDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F333C025B6;
 Thu,  9 Nov 2023 07:22:35 +0000 (UTC)
Received: from localhost (unknown [10.39.192.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94E731121306;
 Thu,  9 Nov 2023 07:22:34 +0000 (UTC)
Date: Thu, 9 Nov 2023 15:22:30 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH] tracetool: avoid invalid escape in Python string
Message-ID: <20231109072230.GA48165@fedora>
References: <20231108105649.60453-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9xxcVajOg8G0IPuN"
Content-Disposition: inline
In-Reply-To: <20231108105649.60453-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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


--9xxcVajOg8G0IPuN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 02:56:49PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> This is an error in Python 3.12; fix it by using a raw string literal.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://gitlab.com/stefanha/qemu/commits/tracing

Stefan

--9xxcVajOg8G0IPuN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVMiLYACgkQnKSrs4Gr
c8gTbgf/SHsFm+oDPmRAIuqVDIGG6MF2Byg518gpkpBRNnCMMiPKlCQwQfcpnrQr
OHZxAc9VW55IdSxHQIgMVSkfVIgly/xNbcauRqk+TqWlkGNapPYoc6qNJwYl2mNj
zBPkJEBmzMnQ7cplGfJVMOWXs4TopbBbXWwYisbIGswYabXLmZDLD8RGqtvIt/St
vWiu+ccj3FfLsUl5DYrmDY/H0VbDe7RzSk/SFfzLVVOj2wUG7B2Ve2XySxDdkU7Q
Ennu3tNhDNnAu/Dmy8QBL+Z1+Cg5UqjhkujZeWN9INEyPMnMLBUkqNdDoTzkwn4g
C7Wm2Bmsx5kqRRxugkAdh3xKStic5g==
=jwIz
-----END PGP SIGNATURE-----

--9xxcVajOg8G0IPuN--


