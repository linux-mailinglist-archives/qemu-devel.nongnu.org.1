Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 222EB70E0AA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1U3j-0005ky-6U; Tue, 23 May 2023 11:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1U3h-0005kj-12
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1U3f-0003Qj-Gm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oq79YFwvCAaDl5Ap+7mQLSf6QuErpsTVMi2TgffUJH0=;
 b=QRuKi8anoBQUD+mmvJCBMHtD2E7OziXDNRLdm96yByr3Ue4IqtvtCwueTmRqx0tJuJ22UD
 7gZKD8QTiVSHWbViQVlxc6V0sLMNkDpP8wurtFQQMDIbOc5KC/kEDg4pB0G5n29aFWmJ28
 74rSlrvOT9yRZH7u7J58Rpa2GmnSvvw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-55FocREuOVSnKnEVNToBGQ-1; Tue, 23 May 2023 11:36:14 -0400
X-MC-Unique: 55FocREuOVSnKnEVNToBGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70A0C1C12F87;
 Tue, 23 May 2023 15:36:14 +0000 (UTC)
Received: from localhost (unknown [10.39.195.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0719140E95D;
 Tue, 23 May 2023 15:36:13 +0000 (UTC)
Date: Tue, 23 May 2023 11:36:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PULL 18/18] tested: add test for nested aio_poll() in poll
 handlers
Message-ID: <20230523153612.GA96478@fedora>
References: <20230517165116.475123-1-kwolf@redhat.com>
 <20230517165116.475123-19-kwolf@redhat.com>
 <1d53f391-7fa4-f60d-119c-0cacb14209d6@linaro.org>
 <ZGdAEpLlO8GmQHr4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O6LSje+zV1jwv+/H"
Content-Disposition: inline
In-Reply-To: <ZGdAEpLlO8GmQHr4@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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


--O6LSje+zV1jwv+/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 11:23:30AM +0200, Kevin Wolf wrote:
> Am 17.05.2023 um 21:10 hat Richard Henderson geschrieben:
> > On 5/17/23 09:51, Kevin Wolf wrote:
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Message-Id: <20230502184134.534703-3-stefanha@redhat.com>
> > > Tested-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >   tests/unit/test-nested-aio-poll.c | 130 +++++++++++++++++++++++++++=
+++
> > >   tests/unit/meson.build            |   1 +
> > >   2 files changed, 131 insertions(+)
> > >   create mode 100644 tests/unit/test-nested-aio-poll.c
> >=20
> > This new test fails on windows:
> >=20
> > https://gitlab.com/qemu-project/qemu/-/jobs/4304413315#L3375
> > https://gitlab.com/qemu-project/qemu/-/jobs/4304413313#L3357
>=20
> What the CI output doesn't show is that the problem seems to be that the
> test doesn't even make sense on Windows. When I run it manually:
>=20
> Unexpected error in aio_context_set_poll_params() at ../../home/kwolf/sou=
rce/qemu/util/aio-win32.c:443:
> Z:\tmp\build-win32\tests\unit\test-nested-aio-poll.exe: AioContext pollin=
g is not implemented on Windows
>=20
> Stefan, I'll squash in the following, so you don't have to resubmit the
> series.

Thank you, Kevin!

Stefan

> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index a314f82baa..8ed81786ee 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -67,7 +67,6 @@ if have_block
>      'test-coroutine': [testblock],
>      'test-aio': [testblock],
>      'test-aio-multithread': [testblock],
> -    'test-nested-aio-poll': [testblock],
>      'test-throttle': [testblock],
>      'test-thread-pool': [testblock],
>      'test-hbitmap': [testblock],
> @@ -115,7 +114,10 @@ if have_block
>      tests +=3D {'test-crypto-xts': [crypto, io]}
>    endif
>    if 'CONFIG_POSIX' in config_host
> -    tests +=3D {'test-image-locking': [testblock]}
> +    tests +=3D {
> +      'test-image-locking': [testblock],
> +      'test-nested-aio-poll': [testblock],
> +    }
>    endif
>    if config_host_data.get('CONFIG_REPLICATION')
>      tests +=3D {'test-replication': [testblock]}
>=20

--O6LSje+zV1jwv+/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRs3WwACgkQnKSrs4Gr
c8goVQgAgaKH7r2y8xEp9yr7Uo9GUBYBPgPuVqcbtKTBi5vodrEhK0gz6LqvZG/Y
RymhlNxn+y5vDcHKBEJL4NEPXQQ3t8aQCwOuorpufvHmhM7LFuGBeMlmKZQi5Gk+
ccHAZKHig9VBXRchqUlj4D4xFZNRbGGZo791RcDJ7jlQYrn7yN7IcsOFyiyl2rYy
QdK2bXX0O+tlhID0j+a4qxkTYMIahCmQaajFCz1zvCi2gqXH3uT7Ocl4qScwu+mK
thaqw4TfNiauSn2sTpu+MTzwbCRExQM+NICRGGlolcn+w64TwHEwVt7dmBGBOZHp
VXJl11z2vchy7Dxv08fW69E/yplnGA==
=3DsD
-----END PGP SIGNATURE-----

--O6LSje+zV1jwv+/H--


