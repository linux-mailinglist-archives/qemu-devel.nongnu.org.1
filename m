Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171C739FFC
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIlP-0004To-Q2; Thu, 22 Jun 2023 07:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIl1-0004Gf-QS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:51 -0400
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIkz-0004oj-Gg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434341; x=1688039141; i=lukasstraub2@web.de;
 bh=42w8/Ws9HBdzcv51nTv16duYacTtRxYYG4xI4b7utYI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YVOamDPr5OiXHFlXqJgHrIMkNaoBnP8jWMDDDlT1oBpBvyyJZ7e7MC6YwFfdfaevKpS2hlE
 BVOSTClQ6bWWm7LsECTA3pe6GtcFcvZro159sok4rrtBqBLdHW981IIBnMMSzVVEYEfGKrYBF
 S8jBaDvCdUDmPBsnYjLt0Wmwu55xEZaDnsuuV+CcPGgNyLAU8xWE0pePdoiUF2/nANFX+MrzB
 +dWQT+0MKMsgi89G9GiH0QugqO39IcwotflbNM6tLomoGbRJrmQDfcM1wr3G/DXoGF8OswHhY
 eUq0OIWWB/Fd1W244e0BKveUqK351Nie4GVMFIsWOZtNRL22PCvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaRt-1pxwhb3nXX-00tXyU; Thu, 22
 Jun 2023 13:45:41 +0200
Date: Thu, 22 Jun 2023 13:45:36 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 07/18] migration: Create ram_compressed_pages()
Message-ID: <20230622134536.35461096@mobian>
In-Reply-To: <20230613145757.10131-8-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+IyMve3ydSkrCJeTchnZS2Y";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ZZVAG5tj3PcR9hHV3DrKmyBMd8YMXcpet7Qp6UXLl6yPJocQ/pt
 9GZA3U8rZGkendufG0nVkTA2HIMHhpd+uZuLtXAdaeUvf1wN6Xg/MzBqq847+zZCnnCl7tP
 t6u3gKCy9Q7uAe5gDRnccRDWP0ZG8KY0wx7v701QDARfIIPEgXqytDfCzVfMF9kJ5yMEaA0
 W7RjrHfbz36/2qfGKthUw==
UI-OutboundReport: notjunk:1;M01:P0:YBe+UwGuOP4=;3IDDOnWB+qGWv05HF+r43Q2dJ8P
 mOfa+drx3qUSKvNsIfPFfkpiJ4qgaVfeCraq0sMKDFHMmUlX+6SKJdOe2oyHoZdSzZtWUpuDb
 a1PMmnz2qIhl3o0C6lDxngMd78d+oTrnaV9c8Ou/kbAO5PUiW43SCf53wFSsrTNXnBQ4ARNaU
 UDMhs9UvlbNBUM5N5Uou4mZodPPqquyMOBQUplYLD6U6JYkOdPBgoPQTAEYRKqJaEyewrB6Us
 PmEIOmPrV1Y7OKBLZCgt5Zo95xCnyjznP9v9Vafy8ZXnaoACKyhRwNQ9+2yHDGUcbvxE2SaVq
 Gc/jHjUALR1Yzhmx1TyGe+L3s/THaSz7Z+AJ9zDmnEuTyqfM1IFaDKIHj6A3umjDpKZecvabg
 DuMlYhqtUw3XFUHZnkgb+WTyph7dX/hOmhxr4XVP3XTrB6CkvKEwfHsDY4higRk1+zeXottop
 qVM3PhfRhkaGoRkMT/sBa8ttXPSIKv4z0I4HXEm88Q2eOdrSKSwVjlnGHJ+Jq+4Qgcc+fOTZO
 eMTNZ+aJz/G3cTff75jeC26ORT6E9X+eKkBfKXZIKAjLwIdc7DYC19E0dB7ndXKIs2z8nvNTX
 AIRJZlXHHAkNCgmKwDtpb/t+1/qbTtMczm+fDF4cjWvScZWxfPU0Av9UisVVH6Ly2skZELl5m
 Wc9V0f/TY340bAtaJXdjDJaVRbT4P0d3RfDiAEiGz/cxGxnJ6jGg6eefQAeAthSiecOdGEiBT
 ESEQTujTVwew3iw3h7L3dzu38fGc7fA42twUpCIboi7QlCLRqICjoX/WHbWd2ngralJ2YwHk3
 pR45acfALXxpbnwr9S2qI3UUgWxVyfVobsk4Hw5IEjQaU/g/Y9NLphg3czAFaLLMrJ8WiyKMI
 lax94Z44pZOUm6KfhCsaOy7w23oWg1CURphsHsbIum/luYOuM8z2a94zTu5m6rrMIuUpv4MID
 os41zg==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

--Sig_/+IyMve3ydSkrCJeTchnZS2Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:46 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> fix ram_compress
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Commit message is off. Other than that:

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.h | 1 +
>  migration/ram-compress.c | 6 ++++++
>  migration/ram.c          | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
> index 43ff44c0ba..77465dad4b 100644
> --- a/migration/ram-compress.h
> +++ b/migration/ram-compress.h
> @@ -69,5 +69,6 @@ int compress_threads_load_setup(QEMUFile *f);
>  void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len=
);
> =20
>  void populate_compress(MigrationInfo *info);
> +uint64_t ram_compressed_pages(void);
> =20
>  #endif
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index a91c32588e..c48d5c53f6 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -502,3 +502,9 @@ void populate_compress(MigrationInfo *info)
>              compression_counters.compression_rate;
>      }
>  }
> +
> +uint64_t ram_compressed_pages(void)
> +{
> +    return compression_counters.pages;
> +}
> +
> diff --git a/migration/ram.c b/migration/ram.c
> index d4943b982f..13c518f81a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -927,7 +927,7 @@ uint64_t ram_get_total_transferred_pages(void)
>  {
>      return stat64_get(&mig_stats.normal_pages) +
>          stat64_get(&mig_stats.zero_pages) +
> -        compression_counters.pages + xbzrle_counters.pages;
> +        ram_compressed_pages() + xbzrle_counters.pages;
>  }
> =20
>  static void migration_update_rates(RAMState *rs, int64_t end_time)


--Sig_/+IyMve3ydSkrCJeTchnZS2Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNGAACgkQNasLKJxd
sli4bg/+JPYTLMF5jykUo2vnYjGQGhxaMduQSDZ3Q1oHhsArRPt0oM8JIDKspiHB
m1XdSRILcLpz/51O7Zg+v1wEOaDYW1I7P27VVz7FYFsPJEChfhfA/yElcGN7QY11
8MHa/soJrYFkXSChV9brkOsWLdNOG0OIbAJ2xY6XZhY4sXWzD9snSDk3spcV6P1c
kzbXqGEnc2did1n2PMWtYvKR6UpMWQb+9FEOGwwgS8kK/3esF4uOPfzmicQP4Af4
ktYwxgMUvDkxLb+ASlfHTiwolTpImTTT+wIj3e2Juk9t2W1GDCJrHceYK5KFHrcu
sSKWPXMvrAOoO+qPgyBJGkRnf82A5ceH5L2vkvhH2ih80GzHF3csquBeUOdoJZ9R
7mnRsXpCD7ybFCLNOQum9UoYt0AVG63Xr1AWJi7rynuFCm7fGFsLtue0kD6399H1
O7h6SQvtujOvcglgQKxe71MK3bXsv9B9Ycs/CdhRkO0TkN71a6jSthSdbE3eX1op
LrqfrtBnmvbrXnvIj0/nFqrkW12WwaF5F+rWJpLu8OCB6WlPL+jOuSQUDenEwcIJ
oCe2xLfhnmn+DxH/S52bYRhWNX3byDnwDpZNXDoD5y8MQCT3Y8yULEiLMuriFIZM
xHfL7vjfn4cWq2VZmY7Bvmd3/Za2TwebMK8GVrndCCL+xvBQwNs=
=glWY
-----END PGP SIGNATURE-----

--Sig_/+IyMve3ydSkrCJeTchnZS2Y--

