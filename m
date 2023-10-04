Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCB7B9D15
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:54:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNqh-00026r-SJ; Thu, 05 Oct 2023 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqg-00026M-0g
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoNqe-0005gJ-O7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSSrvAYH/zfJwY6ei7Wxm6wxUiNpFa4D7oW7yGJ73sc=;
 b=Yc89fQcGSgmwrfw6VQa4V+745BwwfADRd7sCeaEaxrGjWHUDm1orSEYoovfYiSyfN3fx3L
 3LiFgKTa38ZYFMjfA9JBm5VjCvjcHth5mOy1dyuntEsU1RGN50xnqG7aFsL5LaqNUw8QXw
 0mBj1kX8CT6AOrq+MZvK9Kt5MJpeEvI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-EdgnZtL2Me-cIQ3x-RoijA-1; Thu, 05 Oct 2023 08:52:55 -0400
X-MC-Unique: EdgnZtL2Me-cIQ3x-RoijA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DAA33822552;
 Thu,  5 Oct 2023 12:52:54 +0000 (UTC)
Received: from localhost (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29AA840E0420;
 Thu,  5 Oct 2023 12:52:53 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:41:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v3 16/16] trace/control: Clean up global variable shadowing
Message-ID: <20231004184122.GB1287385@fedora>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-17-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xguIvp+/gTR2+78y"
Content-Disposition: inline
In-Reply-To: <20231004120019.93101-17-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--xguIvp+/gTR2+78y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:00:19PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Fix:
>=20
>   trace/control.c:288:34: error: declaration shadows a variable in the gl=
obal scope [-Werror,-Wshadow]
>   void trace_opt_parse(const char *optarg)
>                                    ^
>   /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.=
h:77:14: note: previous declaration is here
>   extern char *optarg;                    /* getopt(3) external variables=
 */
>                ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  trace/control.h | 4 ++--
>  trace/control.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xguIvp+/gTR2+78y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUdsdIACgkQnKSrs4Gr
c8hcZQgAjYcjS4zpWPFxCkPS986Jo5mJ4t99JlbF2Gq8o9NY6+30EYDOstqU/8F/
e0v751ZJWfd08USE1ezbJIdbjdyb4mrEgwHoZmlP7brrrRdlhAmSNVnutW5BTL7/
Y+fWy2Bh7eDSamlDd/2/9WaMDuOI9DzDzNY99e7gi2xKy/j0UNUmkc1EFz/TSGj5
mynQW+lDH6siQcjfPRhSPpylDAQha4MqYkmRgIgYoHb9ZLbchb6A6cKTm634JEMn
fpjyc66xJpLQkf6Yj6eIV4Owtp3xXknicoMmdlfHa1bTpqdcQvuytDR6gnwakkJo
x/UuZSM3pmWsKX9HpplnphGjlgotxQ==
=f0bZ
-----END PGP SIGNATURE-----

--xguIvp+/gTR2+78y--


