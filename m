Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445AC739FFE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIlo-0005AQ-0D; Thu, 22 Jun 2023 07:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlX-0004sS-2d
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:20 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIlU-0004re-EN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434372; x=1688039172; i=lukasstraub2@web.de;
 bh=+bf24HCTd7ajjUz8LKc/TuPXrsAVigyVQtpW8nShY9o=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=t46uu+s49ktrrFyOAQoq6t1j4SXb+vkn98NGanNu6xmRnRUDXyzfLWPTpzgIkH1V6oLLUW1
 SGOE5VdFr25VCgRkO7rka4Ke0tIIYOrPKFn3udxugzjFpAfgD1XA7xSF6TVm1UM/3DsCdviFd
 YFST03Q+3jpEbiuDiczomgLIapz6Hnas7YL+pT8gKSaZoCQ0ArvdXUkGz0hjgquJRD+gdrCI8
 zdQ4+BZ9jL+YIkpLDOjb0YgFo7Dx36IMaiXXWNq3r2RUvlQTeEGuDQJiGNW2di4rT/e3FRG6m
 ZEL8bJ5esVd+qbU43j/2ToIo4nriNASHUlf3s6Nm/QACYYeO/ATQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1pYY2F0qNr-00fLRA; Thu, 22
 Jun 2023 13:46:12 +0200
Date: Thu, 22 Jun 2023 13:46:08 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 09/18] migration: Make compress_data_with_multithreads
 return bool
Message-ID: <20230622134608.5c5e1028@mobian>
In-Reply-To: <20230613145757.10131-10-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kuihRaDYG+peD6is43aAVbk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:HPLl5Ow2DzD0DEHMSkJo053+XN6Y4zP3jb5ZYnSMogec2pxre9f
 IAZm0Yhsh3ZevAR2FIBoKHtGguS4Ms9ttXPYfT1e171lnstWDUFCujW4sAqTKSjHKjV5nWg
 8cJ35krouxBVt4i70bleWdzAr8kC2KiogOqoC3oESY9NXY6v1f0/jfpzOm9FJ+sdW/XRREg
 NQ5ekeb1gAHdhYd2oNmkA==
UI-OutboundReport: notjunk:1;M01:P0:f1AcAgPc3q0=;MMR9h8VJ4Cl1uSoANhbJPg9Pn4V
 5U6xuCfmHI7/J1GHoR+WbMarCFDgkPG+b6e4lEFrDag9gsZNrDKeiri5tfPl69lkiKpqXPM0u
 vC4YFRhpXTi7dv2laKTIBa3iP8mAgtiuB9BKniOHxkY1DV10g1EYq+UqyAppSwInvqk6j7HOn
 gTkT/+oqxQ8x+vwaZNAtTU83XWhd/Vc5uk6UzpDOMFmg6gtL4UD3nlsSckyWLnlCKB0ScFUxv
 cou61bHSpTrd/DfL4Xpj/22qW31S/aIoNNYU/iJcnZtuIFqsaV3IHHxaCvL5t1B81A6f804s6
 sbyn6x14vKss6+xJHCBxpKxDa7XugiFFBGbiFM2Pvclvtrso9HbFRYrrxUpneae6t10agKegl
 HKJR3ik5ayjDrbE68+s017fbInwpWvGFJv2EihDeFEpXbqDEPxRrtoWWScd2tOn0BeMFVUoY3
 FsHTMNZni/HkjtsnlJKt542UBXi5EG7Y3jRqhY9Jh+oc48VsVed0vPGjaZlXArG8xVZeYigYY
 BGtIxPyyCP/eNXpXAwEMuAF9tJ6b1MjmNOi6twJh7XY01iprMhRE+7WDvQermgqs2jmF3zdrd
 LXbrIBLy/4drIHrF/AcpYmvAhuxsszPFwgmVu7HTx8fEkcnLvL/RPWmffsgHh0dXYvKYjhWcq
 sGMWrX2xliEBR6aDWuB473x2aDiiWRSfX4KiEIOfUO9YA/GfbUEWBd94RewIXOYih8wv+xUvJ
 qce3Bc6GrrJoVEwjHCSLwWPkwAN3gOS24iCFl35QiQxQSC58q9QJhUs4TrjmBVupVXWFN1o3r
 FRNWNYjlTuq8Cmg/8wd4LwWtLfBuLmSKQfcN/CQ12b6whq8H5IXEwEVBagbLGkqashGeSQifs
 l1SKC7nopCLSj+hcvkWFDMA4hrTckeEno1Uzoe+O727NPKKE+y000hqVxO0YBNLFbRfh5QnwQ
 Zb/TrZCyTF4enmMSZGYsw6EZi60=
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

--Sig_/kuihRaDYG+peD6is43aAVbk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:48 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Nit:
Probably makes sense to rename it to try_compress_page or similar.

And probably for zero_page and xbzrle (when factored out in it's own
function) too.

> ---
>  migration/ram-compress.h |  4 ++--
>  migration/ram-compress.c | 17 ++++++++++-------
>  migration/ram.c          |  2 +-
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index e55d3b50bd..b228640092 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -60,8 +60,8 @@ void compress_threads_save_cleanup(void);
>  int compress_threads_save_setup(void);
> =20
>  void flush_compressed_data(int (send_queued_data(CompressParam *)));
> -int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
> -                                int (send_queued_data(CompressParam *)));
> +bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
> +                                      int (send_queued_data(CompressPara=
m *)));
> =20
>  int wait_for_decompress_done(void);
>  void compress_threads_load_cleanup(void);
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 47b600d62b..8ce9519f3d 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -262,10 +262,13 @@ static inline void set_compress_params(CompressPara=
m *param, RAMBlock *block,
>      param->trigger =3D true;
>  }
> =20
> -int compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
> -                                int (send_queued_data(CompressParam *)))
> +/*
> + * Return true when it compress a page
> + */
> +bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
> +                                     int (send_queued_data(CompressParam=
 *)))
>  {
> -    int idx, thread_count, pages =3D -1;
> +    int idx, thread_count;
>      bool wait =3D migrate_compress_wait_thread();
> =20
>      thread_count =3D migrate_compress_threads();
> @@ -283,8 +286,8 @@ retry:
> =20
>              qemu_cond_signal(&param->cond);
>              qemu_mutex_unlock(&param->mutex);
> -            pages =3D 1;
> -            break;
> +            qemu_mutex_unlock(&comp_done_lock);
> +            return true;
>          }
>      }
> =20
> @@ -292,13 +295,13 @@ retry:
>       * wait for the free thread if the user specifies 'compress-wait-thr=
ead',
>       * otherwise we will post the page out in the main thread as normal =
page.
>       */
> -    if (pages < 0 && wait) {
> +    if (wait) {
>          qemu_cond_wait(&comp_done_cond, &comp_done_lock);
>          goto retry;
>      }
>      qemu_mutex_unlock(&comp_done_lock);
> =20
> -    return pages;
> +    return false;
>  }
> =20
>  /* return the size after decompression, or negative value on error */
> diff --git a/migration/ram.c b/migration/ram.c
> index 53dec4d305..2a3ff2c36e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2034,7 +2034,7 @@ static bool save_compress_page(RAMState *rs, PageSe=
archStatus *pss,
>          return false;
>      }
> =20
> -    if (compress_page_with_multi_thread(block, offset, send_queued_data)=
 > 0) {
> +    if (compress_page_with_multi_thread(block, offset, send_queued_data)=
) {
>          return true;
>      }
> =20


--Sig_/kuihRaDYG+peD6is43aAVbk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNIAACgkQNasLKJxd
sliuww//QqAhjQGgsA4eIohIKIsypSxjMHtomSkLb0t91J1OPr3WwIOCIoGk9WWW
rfrRlubROMdYfJ+Zr9msDaZhWpcKN83fUcKUZ4ndylrPzHHeiYcn2FrVdoXyt3T9
5z+JjmlufvaccEpaJZLdMW6y13R2o99C0ZHR9+1FyCG838Cq3iC+sP/+w+kspU9R
klP3GYxfbEIsLaZqjKcOmM++6ju7FOGldWTI80jsT+rdLgFneqY66XpNPhhmZ5BE
U7HR6vhbe8cLDw2scfcZGFG9fRXw0Qd0Ipt6Al5Pj0UVtj52KqeSR5iTTD6u35ar
OY7cOrhlcQZDwTbBx8YHvUYpSysXIrE3/QRtMTLqSu8m8cuhL8Uk+98cuuZlN4dF
RyVEEgdJ0jm1FYTSZQBg2IungH65pQbGcptn8OVOxtHXGEEsdCokxsH4LlY1xBIc
dP8ZH58kyYmavGVvtbtJQvuEoG7rl+22BBR8ggt2UM8JdWsuyEj/toliDcboY1N3
J626B6M45kunejSraTlqylGjO6mEC3MVUUjwe7F5wLHg2sQClkQM3BGFntNNipS/
pxqnGTbugnKc9pMan0GDsINN9sda/moMe5ibns/bpFJuswyLTjePBlthW0I/vqmS
utP9Am9MN7FC93XsML1jYuQm8SagMxvraiimsFLFucrXIYeQBpo=
=Gwhc
-----END PGP SIGNATURE-----

--Sig_/kuihRaDYG+peD6is43aAVbk--

