Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DD73A014
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCInx-0002qR-5j; Thu, 22 Jun 2023 07:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInv-0002jY-AT
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:47 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInt-0005T9-FD
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434522; x=1688039322; i=lukasstraub2@web.de;
 bh=yJqeySHwht8/Js2vewklFlV+xg6xFqV8Qu7KBuq+muk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=HMsyou0Z/E3ypLl4LtKI003SfFWDngwsogu73xUMFYNNHEZsivR+GMu5yFgkoK3ecb9azhr
 qaL1I/ZXN03rsssO+ZCaJ1Id/ugNl7NO1yYGehfSOcbXD9wtAlXGtNTnOb1aaJrbwjBneNNKX
 Uu/fbQ21IKfRs8Btp/tpw66GF6I+x/rMAEVOxpFARBWGkLHhPclDTrth9fBJSQvFUP3IALRhC
 +bXh0kcWKejoH52GHsW8FVz6ATkKzVChU2LZdXimrZiytqIM8SfPWtuwE1yFYAg+hGhzg42FW
 Zv6SFNDjRdo6mVgXGxVck5YJPh08zCR2o44fQxe6VOG30q9vMwTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1q2ZUT3LAy-0116Gk; Thu, 22
 Jun 2023 13:48:41 +0200
Date: Thu, 22 Jun 2023 13:48:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 18/18] migration: Remove not needed file parameter for
 save_zero_page*
Message-ID: <20230622134838.08f2eec4@mobian>
In-Reply-To: <20230613145757.10131-19-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aqOxfa13sMJWDhaNzuQSx.G";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pS2e+uHyLeQMwlVSy6Df/IDDfwaQ8mfRum1yHA4yQpab7WIWFxv
 WEcMoWlY+05HAHtLZ+nZRYw7S0EbCwYXSHAQE+5Rsvx6d6gSgJjXwfjfq57dsYsDSHvVMqt
 oCstLHyAMGFwh/YMo+AeISbgJBSCBytKMaJ8VStKIbR3jdn8aGIAZF3YJHRnDWjrIT+Q90O
 0Gau81WgodIcXfTT7+8HQ==
UI-OutboundReport: notjunk:1;M01:P0:AduOS2gzLrc=;XrQRaLTzIVWAopH89fiej1mysop
 1EN8wmhEhW0PQwuvd900TFaA0WO9XaZK0Majfl0CbpMZVG7w4iReRma+dESz2kEIz/d7iuebC
 5Ahh6yxL2HpZVBcAIFFHMZdqqOnm1rDTQTBFTwZG94bUVYzi5im0HVRrC6fwv9jXCV9tWLTxT
 +1MeSsngkW20VTmZcrNk/kg+GY8N6HSu9FLB1Kwp7rpjIXkFqd/M4PqvPe2m+2mDWwc84JJkq
 ctNDfFIxpZGJd4keKLUnXvZvzfqVDZngQwUy5PaKGESnsw54j1pO9830pj27Dw3qcKyX7naKg
 dwfETLP2uCVKtkMIXNcOhPEmO11kEbw29rcpQldqxbnGKwucf8G8TaqTi3TD8SqZ65Q5ZeWjj
 iX/XtbhV9tMkhPlhbm81ZfHsXiNcKad28VoJ1fzsm1HgpeF9F64Tcvg2Pbq4mIcBNzU2S34GY
 2ZHoI43elPAYNcHKTs97aQpo/czM4jbdNjUOEiz3zN6o/3kVMP1wAnxlFKeDSKCb3f71My4hf
 MBCoao2Ya5GCuRTI+7JEzedrpdgGzcpn6kLCXi+xG3DRmjwoYmDRLngCnLC4f0dMUtnGLRQZ7
 k4RytScYheJF4MVLL4dRAH46QFLlWqLGLyxDeKl2F7C7fAyVwqNbrhdn6E4PVJNuRhlIw6Sjl
 s09BrDoZCGsMJRPbK6AkEVvz+Uk3BPvsDu04W+vuZX7xJO63R6yTJ0djFbDG77AfiU1QFcaJ/
 cyj+9vD4Lpnq/sYyrJiWP73V1PKf93IDjzdjVyO+MLYObaph11sT+nIouVvWoQbW8G30bw/mc
 /Pilo81IpYV5RTkwukB1OZb4bV13vMNe9k+89eUbe25BZLt0+vCnCCYbsHAavyG+xFrn2e+E4
 a3HkX6HCi5UqFeeBJjQexuEXPzyvn4TfF9hxbYMEkiWVcVa+0yByqr66OOkRV2BQNlOn+Itc5
 sd599MMgSB49HwUCzqqSDh9M7fw=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--Sig_/aqOxfa13sMJWDhaNzuQSx.G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:57 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 0259c33da7..ae11d0e992 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1069,16 +1069,15 @@ void ram_release_page(const char *rbname, uint64_=
t offset)
>   * @pss: current PSS channel
>   * @offset: offset inside the block for the page
>   */
> -static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
> -                                  ram_addr_t offset)
> +static int save_zero_page_to_file(PageSearchStatus *pss, ram_addr_t offs=
et)
>  {
>      uint8_t *p =3D pss->block->host + offset;
>      int len =3D 0;
> =20
>      if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> -        len +=3D save_page_header(pss, file, pss->block,
> +        len +=3D save_page_header(pss, pss->pss_channel, pss->block,
>                                  offset | RAM_SAVE_FLAG_ZERO);
> -        qemu_put_byte(file, 0);
> +        qemu_put_byte(pss->pss_channel, 0);
>          len +=3D 1;
>          ram_release_page(pss->block->idstr, offset);
>      }
> @@ -1093,9 +1092,9 @@ static int save_zero_page_to_file(PageSearchStatus =
*pss, QEMUFile *file,
>   * @pss: current PSS channel
>   * @offset: offset inside the block for the page
>   */
> -static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, ram_addr_t=
 offset)
> +static int save_zero_page(PageSearchStatus *pss, ram_addr_t offset)
>  {
> -    int len =3D save_zero_page_to_file(pss, f, offset);
> +    int len =3D save_zero_page_to_file(pss, offset);
> =20
>      if (len) {
>          stat64_add(&mig_stats.zero_pages, 1);
> @@ -2031,7 +2030,7 @@ static int ram_save_target_page_legacy(RAMState *rs=
, PageSearchStatus *pss)
>          return 1;
>      }
> =20
> -    res =3D save_zero_page(pss, pss->pss_channel, offset);
> +    res =3D save_zero_page(pss, offset);
>      if (res > 0) {
>          /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>           * page would be stale


--Sig_/aqOxfa13sMJWDhaNzuQSx.G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNRYACgkQNasLKJxd
slheDRAAsGA3EVFyD6dkXvDXfzf77HtRUeLkVKt2jz+kh3uXunHJuG+Jc+SzElZo
Y2kqVFUtXKU9i4ylq+6MFFq0X+o+NmG9mYAztWrK7U4rkJcVq0HhxUUqmk50ld0u
QOSO8/vd+4L2ourvX/GZaQ9Q+QTasdUiNnzB2chSr7qEkcnU3vWqhHZknc48jR3O
AIFwhTc9xrTBH3fKUbcaTWH6ftM97UarheZmSoiDuOkUNQi/k7PIx1m30EOLaVgq
4ZL4KK3mRLp80Hj3VKsRmaXllbQUCtndJFTpCYd4XIV2VODmfazvkfMSpV5wieYw
97OnSnoZPca2njDSj/5G8xVos+afmqTQSNVUM1B7yFhxrKpmhlyG7iT9j2EHeXrk
ycspL36Ka2BmyHZq7kUoMsN5dXPSPRgsNeXW8iQQnqJc4c9k8RJe+3JhhW+sRa5e
hidAreK9ddjh16iLtjl94bnH45GhXOTOgQI2vCqUISacA6UjWKQi4MPrN4gRSJdv
Cc8RnuLv7bXjou5lwWfC18u5hZWZQoZuNh9jGoyO+L2Kt1mPd8W0+0jp01/IJmXf
Ay9jdmMWcTXhEPk9xuLQIQ+Y4o2XIeh+1TlWRn+Z+AkKqKdplfvG7+NNWjPqY4YI
7RwewxWQjpF3nBxW9IbA0fHiXWWTAXVcBzXDomHcyIsXditda78=
=yu0l
-----END PGP SIGNATURE-----

--Sig_/aqOxfa13sMJWDhaNzuQSx.G--

