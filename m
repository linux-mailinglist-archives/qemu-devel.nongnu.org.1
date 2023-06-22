Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D219C739FF7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIkP-0003Jr-S8; Thu, 22 Jun 2023 07:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIkM-0003JR-5B
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:06 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIkK-0004Ab-Fo
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434299; x=1688039099; i=lukasstraub2@web.de;
 bh=rpJ9wOUt/3Sra1X9De0tnfNY+rh6ZD4OC8IV/FDErdU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IjGpNcOUfu6md5Dyv1aEOmqEFgKpRylo0e7SOJ1PECm5t7Ss7IAbrH1C7jRq8wrf9vsJ/Xh
 osQV1y53RovjgP3w9qKveMQaw1mvMEW//0TWMetwcA+Xpvocq5CxQzemq444xp1WjQgDCqXVi
 epgYQoR/WwApeT7Pon/a/L/vNSo77AjUXCtpgTVJDUxWy0BH2ltIzhXefxfZzGtZm7xuPqjTt
 0e/N0qydxExhDPX1qOPvqOEqvmrqe/cng+b3eDQg/HyROTiadc4rYO6im6T0Od6bOI+zoSKHo
 kv0+FgSBWSsAAnrDdj9rstWH01ksHGuhxlnae69W2+1g9IAIG1nA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1q0MUB2tTg-017cvZ; Thu, 22
 Jun 2023 13:44:59 +0200
Date: Thu, 22 Jun 2023 13:44:56 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 05/18] migration: Move compression_counters cleanup
 ram-compress.c
Message-ID: <20230622134456.03ddc78c@mobian>
In-Reply-To: <20230613145757.10131-6-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_Yad9hTMEuV_nZv/=iTKFF4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TClYR61fr+GgAApKeJiEVN/3sO3l6pj+QmqaM+mEBNWvPKvTnAN
 sPqUl0CgIR5GdX71xUj562ApfWJ0gQz0BxyZcKaktLvyEzP8rEQjmEaNdYP2TW4uRtUHS0O
 uA95lzV3P8q4OutVxvv+BroD8F8EMo6JHRPZ7e1MfSLArLphGulJxh0ylJx57oMtBCcVV7B
 h8Qn8iqUMqdQJ2EE2tqag==
UI-OutboundReport: notjunk:1;M01:P0:h9r7N5hxZuo=;WY3/+7fNqPBdYd+ftmudOSFv48O
 JazljHGcFBYU/3fA8gBY/yRZa46JBqqCS/nnbCFhwRMXCQBBr4It6aFL8dulujWK6I0QwiUY0
 QQg6El0ngva1aRTf73cI1/ysrbpOFvXhXjYN1Gl1zvLDqRq27nu+DO9FjywkPOmgmvdDSRzWC
 P8evMvUw2uPlu+t69rJ7NZf1JW6i+THdAVzlK4Bt/9TBUxuCMjswlR7Dr7lNKRMo+vcvyKDxC
 Se+v/el31HDerUSA7CVv4DvtenrtqXkB2XIU6FXci/SszK+LIxpKWXAswVvNdX6sDRW4Zy7gy
 iFDZ8jhLn6/vL+A8pFPNGyUBN6Ya9PXOmlpD33SbbCih2qNkS2RGUqmrZS/kGtR3YacQJCrQk
 rubvv+nLEr3L8oCG4EPRzOo7hk46NY+z6CNb4eoeWgkXFOVWMC7QGJYEoYiVdAxmJpW9mtdCv
 mhqIQ7yk6vmPVr87JG5P9UJ/tOEu95WAb7X5Q6H1TVfi1Ve+tVwuv7zkddX+7gtqv4a6uHu8r
 XbU5HneRoMhLlIi8T/lMPMzPQnnUVbJhaMmXz5xpNyO5QCbEY1LDVlPLxJngs9kT1xV3oO0/g
 jcLn9MAc/b/W3m4SQLue743qrJofRZSzE29psWhw0tbqumxeWFmeN00rsff6uTKvw5J3jLAdx
 BM1HjXHKQ+1rnLGraI0ZeNLJkuIp+yXcPJsLOQlPb8YRuuSVWEFrEL8YtqeDkNvbkanPF7wh3
 1HwmhsF9UQfVW5OK+XELfn8iP2nVgN7wzCv3VdeMjsh15IAXHJjbyjOLVZfYCjawzz9XqL1dF
 +4CZxeGAB4jj1VgWV6vqnTE2by29tmNV65xhWsdCLhyHYkIsxUbAzVtg4OOAkxnpc3/gHl5ks
 u/VHHAVnCwFCxKmtbCpvp0CPZ5TGocq/CUqcHfkSX4iuBVeLGuDdXY+iIRSxWlEDesjdaX5k7
 92Fv6oBPb09xtVxMr/MOBKTcX4U=
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

--Sig_/_Yad9hTMEuV_nZv/=iTKFF4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:44 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/migration.c    | 4 +---
>  migration/ram-compress.c | 5 +++++
>  migration/savevm.c       | 1 -
>  3 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 84551f040c..5105ad6825 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1628,11 +1628,9 @@ static bool migrate_prepare(MigrationState *s, boo=
l blk, bool blk_inc,
> =20
>      migrate_init(s);
>      /*
> -     * set mig_stats compression_counters memory to zero for a
> -     * new migration
> +     * set mig_stats memory to zero for a new migration
>       */
>      memset(&mig_stats, 0, sizeof(mig_stats));
> -    memset(&compression_counters, 0, sizeof(compression_counters));
> =20
>      return true;
>  }
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 06254d8c69..a0f6a56470 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -430,6 +430,11 @@ int compress_threads_load_setup(QEMUFile *f)
>          return 0;
>      }
> =20
> +    /*
> +     * set compression_counters memory to zero for a new migration
> +     */
> +    memset(&compression_counters, 0, sizeof(compression_counters));
> +
>      thread_count =3D migrate_decompress_threads();
>      decompress_threads =3D g_new0(QemuThread, thread_count);
>      decomp_param =3D g_new0(DecompressParam, thread_count);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bc284087f9..aa31d29f23 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1621,7 +1621,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
> =20
>      migrate_init(ms);
>      memset(&mig_stats, 0, sizeof(mig_stats));
> -    memset(&compression_counters, 0, sizeof(compression_counters));
>      ms->to_dst_file =3D f;
> =20
>      qemu_mutex_unlock_iothread();


--Sig_/_Yad9hTMEuV_nZv/=iTKFF4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNDgACgkQNasLKJxd
slihsA/+KMZQiX1KGj80oXifWmaB35Dy5MUH8dNqv1gFdsDtpRtgfwA9wLiG40dS
b5c6LPbC+uhfDewiJS/WGMT81+F+V21hr4XFjzO5smbuVJ+su9WGRMoIh2fLvGOv
gCUMpZhB7QlUR1I7kH3OSD7jsAUZNDOU1VsHkiH/fZDIpyZ+MCz7dYqS1YS56BYz
GsccJ0NufP22Z2UCwhrEk3gPEKG4Kzc565z/awiDKzswtb4pMACbAunV3DDG7EAm
IHvKOUqUIsrtP8O9HoDmUd3+AmBFqJMvcfdCiU54CyQs6YfkOZp1rzwHvXnaa5NG
xoK+lMZOtrhgNZNC2Qrt6CzSVW/4JzmEYdusmYw6a+WUr/YPd+hJhkWcRscX8hAc
CP5wgZsjlrJ+MskammqCDAVUw5kktCjNmWPjWyKdtjkej/W2/FmV5lIlRTNjjdHZ
TJBoCRT0zMXgn7lTuwULUE4Nb3hL7EfH1sjhNyOdwW0FQpiywApOvVXnjq1LcUEa
XRC+3mRggV6kMpULH21w4rGE1Xxwd1lH+aL08IhqFbgbDo+OYj1/ztwrjH9AAgxS
+q/9ID2OOT89bv5xj2OTW8GtMtBMyfS/v9wrXjcw0ScD04eRhMrww97xXPb7FoJF
RKUaUPvhftMaMaAIzzDbdulofzXcQo+BNZH/foYxp5NtwibD5ko=
=l9Qm
-----END PGP SIGNATURE-----

--Sig_/_Yad9hTMEuV_nZv/=iTKFF4--

