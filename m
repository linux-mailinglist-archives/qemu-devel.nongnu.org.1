Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24873A000
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIlq-0005az-Vv; Thu, 22 Jun 2023 07:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlk-00051p-QW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:34 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlj-0004tV-6Z
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434387; x=1688039187; i=lukasstraub2@web.de;
 bh=gRuIjHThs8c4R4l3DWmDH6gN2HtTljB1ICb/8Zv2aT4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Q/Le9m53rhgUemoBgCcE5iA0gWQFBKQ7A4OdKTj/pr0k3moOAYkNICMrAO07Tego0RqUb/H
 8PIJgJb6aFAxOksuXMcMjnU8rPHPeS/6mA4gvfzu15Z9L6dxlJQH2ymMw1e6vCfmaS/VnnRR0
 Ig9j5nPK+RUQQsxmpvkuLxJMOxKU/zmiMbiDTs9LNeDBFRqn90FUW1nnjEKPiHyjntGF/LC5I
 Sc3pqtGzwgqerUdQjWaEJIH1FMPEykTJ/pR/sphxZVGSf3+kKaaILGOaCMCHLPDbpyQjC4M8r
 GA7e/T1z5TSyGxf1R8HebENhW3LRWTnLwzmuxR30HM5o593rCDHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1pljKH2jvr-00jhvD; Thu, 22
 Jun 2023 13:46:26 +0200
Date: Thu, 22 Jun 2023 13:46:22 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 10/18] migration: Simplify compress_page_with_multithread()
Message-ID: <20230622134622.672ea9b7@mobian>
In-Reply-To: <20230613145757.10131-11-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_dMwvyqQdvi8jSZ2igKX3Sz";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:udhhZyY99+2ED179DvPTMbWhuOZeVDDBvL/uppKDu50Gz9Q3/Uh
 jxZnmfs7qpaSNxKxeSSD2Nt03HX/CeZ+FTyeXMXWNPTsKONjl9w/SsOnrcFn3T3XeFTfdu0
 XrsfyZ3NbGReXuIr7JHXwFfokL+l03CUEcIFrYhGZz3d/E62E0w/Nlp4cu5OmOeXPat4dbc
 NfpvflGFhF9fvBf2yBECw==
UI-OutboundReport: notjunk:1;M01:P0:E80mg43IxQ0=;6N8JOi87qdo+XLqaEBTLC1imOSN
 2xjZsTHai4pkqj47qTNsH8EsViDo5M9ocv8a9Ec7m7rFwnsSmvTOXXhpV/fPXHcmElnpGIWKO
 beqy0ntitQKcBoWycjk5ItPd/G3MnEQo0SC8mUkkR5QEvs8x7tsvKRdW7IWAwdfqKurgR3sTj
 OHJFsURrOuncvFRoyvYoIz/l2nO6GSFVOKeu7ekf/nbkVoMc+LZvAzKmxPLZr07eYzVXEUPWS
 Z6AT0yWm40vz2zKnuRDGwUC7U6uJXkVZOdmq5iRnx/qey/rij5yejpIAhurrQ3c7li4AP4oct
 ChO5KfpzV9bNppcJ8eXuBRTWjPqTmUlMdkznOg1FOlKm9dF7szz0tzNOpuPBWTsQN50Uo8DaA
 kou9cvCNAEjh91J9q4OwO4kUx7qUTvfRKNblAEOG/WntLuwiLnxZHnaf3YFhc/R86pJ09mJ2K
 axImPUeK8f9zJDhMV1JjWeq/gJZ4KiLwt3uvIfcixexnvDlQTwak8yuqur78PlPOn5V3Ayqcu
 RFZhlrY90QVB6xCUPz+SL+B3hF+8eiUaX/fWvRyyGpCdG8Fg2g6kPr9otdo20eccqG/SC9Sp1
 w06bv0XRl4v/MYoGFOdIpUX9RyHXF+NtV0r6koBPcyp5B0BTCd3X2GOTrW6Y7KIGJRbYkKUkb
 Snx56ew6Lo3FwbUq9ZCqLjBHCV5qfM+0O+pSYrwgSKRWcaChFIzb8o8+Um67yrMBxJzkjHY/P
 50OkfkVvuYtGxWsiydvYr/5yIB8L4XzU7krE9ogF3lEIxRj8jAlA7IQ0I0I5YOcmEgBbpRBox
 AD1d000IHcxtaqkF/xYhBwk6lOEDJKlfNt3TzRtj4nCd2NU2cvp4rXq3SyWPw6Dn88VJGu+3f
 BF/JZ7ecZUdh1C8yVuU5ugPbzH4QwrtqgtHE5QyOKUC8SaUdwPwW74BbNAa2shYnyQpkz2y63
 OMws2sOmK0pmZlHZo7hQrPJGzkM=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--Sig_/_dMwvyqQdvi8jSZ2igKX3Sz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:49 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Move the goto to a while true.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.c | 48 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 8ce9519f3d..3c44803132 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -273,35 +273,35 @@ bool compress_page_with_multi_thread(RAMBlock *bloc=
k, ram_addr_t offset,
> =20
>      thread_count =3D migrate_compress_threads();
>      qemu_mutex_lock(&comp_done_lock);
> -retry:
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        if (comp_param[idx].done) {
> -            CompressParam *param =3D &comp_param[idx];
> -            qemu_mutex_lock(&param->mutex);
> -            param->done =3D false;
> -            send_queued_data(param);
> -            assert(qemu_file_buffer_empty(param->file));
> -            compress_reset_result(param);
> -            set_compress_params(param, block, offset);
> =20
> -            qemu_cond_signal(&param->cond);
> -            qemu_mutex_unlock(&param->mutex);
> +    while (true) {
> +        for (idx =3D 0; idx < thread_count; idx++) {
> +            if (comp_param[idx].done) {
> +                CompressParam *param =3D &comp_param[idx];
> +                qemu_mutex_lock(&param->mutex);
> +                param->done =3D false;
> +                send_queued_data(param);
> +                assert(qemu_file_buffer_empty(param->file));
> +                compress_reset_result(param);
> +                set_compress_params(param, block, offset);
> +
> +                qemu_cond_signal(&param->cond);
> +                qemu_mutex_unlock(&param->mutex);
> +                qemu_mutex_unlock(&comp_done_lock);
> +                return true;
> +            }
> +        }
> +        if (!wait) {
>              qemu_mutex_unlock(&comp_done_lock);
> -            return true;
> +            return false;
>          }
> -    }
> -
> -    /*
> -     * wait for the free thread if the user specifies 'compress-wait-thr=
ead',
> -     * otherwise we will post the page out in the main thread as normal =
page.
> -     */
> -    if (wait) {
> +        /*
> +         * wait for a free thread if the user specifies
> +         * 'compress-wait-thread', otherwise we will post the page out
> +         * in the main thread as normal page.
> +         */
>          qemu_cond_wait(&comp_done_cond, &comp_done_lock);
> -        goto retry;
>      }
> -    qemu_mutex_unlock(&comp_done_lock);
> -
> -    return false;
>  }
> =20
>  /* return the size after decompression, or negative value on error */


--Sig_/_dMwvyqQdvi8jSZ2igKX3Sz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNI4ACgkQNasLKJxd
sli5+BAAuxX7QYJqnO6EyzSISkGRxZUEyrI/oDVCJGQ5uVV2Eomib3yElgCvy2lC
kpYuX2ZGsbGOPKxC+n0rLXue/WL4MaBNrBSfeLjco3WpXHMo4OUURcZv2gNAQ1Hc
lHU8u2axUtHp8Aj2PM/n1BkOO8JCO88TFrGOU1U3ji9lxXQFTOgAgSLQI/Brra8G
vOYCRV5p3qOsJB1paCIEfSSBodF65GFSmArrlPSYkgHynxECGT8a0YlNi25ydaQE
ZaHDUS57FSl2hOhKpzFJcsJfru3dPqZsdxhZeU1Badztf/MQzIUz+xEsTTPNp09F
iyOyZh3kMfn+DZ0SDrCdDX12OBDsmoAm10Zkg6imkbEorJ9GOLHmYrZg5zx0OOuK
K0TsabmgFnHl8Q+AnfWU5rwgH/JcP4M5Sdp2NWjgPJhwRAmanPq74tP/E12rsDJ9
weS3Ollle2PSuZw5nnfolw2h7tCa18kWw7TlskTni9rnPcRnQtoIblBcJSf5MKyx
klLsrD5naECSfygdq2EeA/3iD6bZNpUnbw3hZZ/CIDSmV2ExH/D5sJ8Zv7xthVRa
SKTm2mPnk7+HYe5ipEGB2sPRGov/xjwDjRbW4DiG/1rMEpl5hZpqvdOtUca6MrGB
S1XHmbT2HIiJ3X4nLWr91QmlhtIhOabUBb4fT8owzzj4XacleEQ=
=CqiQ
-----END PGP SIGNATURE-----

--Sig_/_dMwvyqQdvi8jSZ2igKX3Sz--

