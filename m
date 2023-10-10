Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3077BFF03
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:21:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDZr-0006Ev-FR; Tue, 10 Oct 2023 10:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqDZo-0006EZ-Az
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqDZm-0007EC-M9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCyv2eSk+eQaFmvDeOdT+5+cc+3nqJtd03wiD0WHySk=;
 b=DfbM1pBydxNzlc6C4VToyd0ec2976hhla2nRWp3wLMY+5B0oMafXyYs8xW6BAD9p70b65Q
 t2tSsTZ9vIx+SA+iywlv0i3qU5UxM15eBE/iKWaGsRnuOlwNDD7euU8y0sMxz0U08McnbC
 KX+5hW3fs1XjJjFelLcXmavlaCcJQYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-2RTtn2gXPLmRUEat1pi-2g-1; Tue, 10 Oct 2023 10:19:06 -0400
X-MC-Unique: 2RTtn2gXPLmRUEat1pi-2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E26FA85C1A5;
 Tue, 10 Oct 2023 14:19:05 +0000 (UTC)
Received: from localhost (unknown [10.39.195.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E03640C6CA0;
 Tue, 10 Oct 2023 14:19:04 +0000 (UTC)
Date: Tue, 10 Oct 2023 10:19:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 bmeng.cn@gmail.com
Subject: Re: [PATCH] hw/ufs: Fix incorrect register fields
Message-ID: <20231010141903.GD1731363@fedora>
References: <99bfcf6de904357e6b07084b99193bb16309d46a.1696914208.git.jeuk20.kim@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8S0oJ/oxuWE4LFeJ"
Content-Disposition: inline
In-Reply-To: <99bfcf6de904357e6b07084b99193bb16309d46a.1696914208.git.jeuk20.kim@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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


--8S0oJ/oxuWE4LFeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 02:11:13PM +0900, Jeuk Kim wrote:
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>=20
> This patch fixes invalid ufs register fields.
> This fixes an issue reported by Bin Meng that
> caused ufs to fail over riscv.
>=20
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>  include/block/ufs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi,
Please feel free to send a pull request with your unreviewed Coverity fixes=
 and
this reviewed fix.

Enough time has passed for the community to review the Coverity fixes
and since no one did, you can submit them.

I am confident in your work and will not review future UFS patches due
to time constraints.

Thanks,
Stefan

>=20
> diff --git a/include/block/ufs.h b/include/block/ufs.h
> index fd884eb8ce..7631a5af10 100644
> --- a/include/block/ufs.h
> +++ b/include/block/ufs.h
> @@ -111,14 +111,14 @@ REG32(UECT, offsetof(UfsReg, uect))
>  REG32(UECDME, offsetof(UfsReg, uecdme))
>  REG32(UTRIACR, offsetof(UfsReg, utriacr))
>  REG32(UTRLBA, offsetof(UfsReg, utrlba))
> -    FIELD(UTRLBA, UTRLBA, 9, 22)
> +    FIELD(UTRLBA, UTRLBA, 10, 22)
>  REG32(UTRLBAU, offsetof(UfsReg, utrlbau))
>  REG32(UTRLDBR, offsetof(UfsReg, utrldbr))
>  REG32(UTRLCLR, offsetof(UfsReg, utrlclr))
>  REG32(UTRLRSR, offsetof(UfsReg, utrlrsr))
>  REG32(UTRLCNR, offsetof(UfsReg, utrlcnr))
>  REG32(UTMRLBA, offsetof(UfsReg, utmrlba))
> -    FIELD(UTMRLBA, UTMRLBA, 9, 22)
> +    FIELD(UTMRLBA, UTMRLBA, 10, 22)
>  REG32(UTMRLBAU, offsetof(UfsReg, utmrlbau))
>  REG32(UTMRLDBR, offsetof(UfsReg, utmrldbr))
>  REG32(UTMRLCLR, offsetof(UfsReg, utmrlclr))
> --=20
> 2.34.1
>=20

--8S0oJ/oxuWE4LFeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUlXVcACgkQnKSrs4Gr
c8jZdgf8D2PEO5nwwBLNUvYqalLxg0rDlQsK3g0QFUuWHjwKcgo0x3UNT6iMYewM
3BzMaBTqFM8+42FcGF0BFRIEF7oyjHC7GoiEMtzslo7KoFW9DywFYkyAVWkhnyI6
fZ1CH8n9766dbCVUiS6iYGKVQH0QIGMAolSD/YkiL3I658sHzxqUrPzMGWYGdMES
Fb187nqCF1dbbeHlTy1gXiYQEQp0H+cMuU0YmXj3vbwYFYn/sSENxxdBmhvDtCKD
Wjud2PsvHY8ioYTN0sWZnBFQA80rPkz1wqtKXj41sH/3nFpIr9LMKuMheLda6TvX
11THw5AULQJ3pVceCYxcKRng6eitCA==
=1dHs
-----END PGP SIGNATURE-----

--8S0oJ/oxuWE4LFeJ--


