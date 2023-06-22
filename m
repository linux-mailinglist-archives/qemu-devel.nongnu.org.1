Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE5173A004
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIn3-0000Ln-JW; Thu, 22 Jun 2023 07:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIms-00008v-Q9
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:44 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCImr-00056w-2K
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434455; x=1688039255; i=lukasstraub2@web.de;
 bh=UnmU83KzmAc5GalNaEJWSfj/01Cvx4rqaYIpJVjV+n0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UU6B8FxoVBicSz1VwE1fn87NDFtrOqmJDPZmjQMp9jz1h3GZkPIUswpdz2B5tXNoTKvSwPj
 E64CtTsxWN/q/EDefhkTw6eFjMJvZqzpDOGvz58NyRLWyTGyG6aU1arh9kMuGH4WYP2aN0xtt
 PWo1PzWTlj2rMoJkFomYPj+8a1AMCItMO4VOjvyhARhF0Wu+1FFnjeBKFkHWJ4FkuB6Be8EB8
 Crux8B3It14aUHSpxBrHfDsZit4XwJjw0I4GkWxDoaFSfKex7FD32fPZTcFKFx4cjuAf/FWlH
 Qi4gbw06s8y8gj6peAzkG9GVIpr9/nTU+WjiUxz3uhgkU2r/Hcvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1pktzn2AMu-00jR2O; Thu, 22
 Jun 2023 13:47:35 +0200
Date: Thu, 22 Jun 2023 13:47:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 14/18] migration: Use "i" as an for index in ram-compress.c
Message-ID: <20230622134731.149f76e3@mobian>
In-Reply-To: <20230613145757.10131-15-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aj_NOGLHwivYscp62wRh+R7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:AfSh1xOi5amURLqPkfnhPo1E7AxqDRo+HzhBNuBBInie6JrP9U7
 rBTm6sbg045W2uO1+SeqDQsXF/SI4ZZ/VSEWzjiuo6b8CiCmLdaYxXLXcWoeVl6RcnR5V4W
 9vEPm4rWF2c+wVRb5wBoZFyPP82PqGeAoXWjBHx42gBV+gDdFoe10X2pkFeymRhZXd/H70L
 f8T3CBMcMaPgHDE4uCIEA==
UI-OutboundReport: notjunk:1;M01:P0:rAa7QNMIYkc=;GvQspM7lgzPdOU7v7iMtO/a+h9i
 zgYgQ/7njXl0MoxGF0dt7gU1CV31rz3y9BGGd3YB2IqXcMYOEOhkPU+SPaJP1ns96iFeGBZQa
 VrUYgH3l9bGDqkD8jsixI2J/QFE7qCcKoSIVKd4TbZrBOj8TSlzdiN9hfjBpkTH88cvezOArb
 LdWcyB4HThVUbA/6BKMMCXLJPP2veoaANkKuc22+VjPd8CHYQvFRz7s9LxsBMZ5QcUVcxZnK+
 z/+MJ3yJ8X0NpmvddG1tL6tT+RepqGJJ6DeF8mvRkA2yhoT0wFvgoir4oM2wT3TntGxSi8bK/
 sbw6jCnOGxbxd7SBlsrkzbQ/TsnWSoPINogfkXrEyGRGGG5IxtAPtFty4F9PKtE+BqZeyaUy5
 +qbMGaG3cI3iyQoYdSjMkEoe1JfAdpJnETkmDaiqT7gWATSQ51pMEFUb8408k3sCnOXGA1aN4
 m+pf/PvR5VpR6hXyT+XJUm1H1YrkkzFmXoI/6G7HCAvwdBtloGfxRR7ufCsoDwANtb25ndnrt
 EMcAUS3f8bkxNGRdOs13Cl5HzjjATP8fyz9ZNlbv3IV8e2mHjqO8exuYoDUsokUsp/VR9kMqM
 vbGViXOoEGUzPQyMlSEWMqoEpp8qrMhQiNShQTQDPS0mjci00Db4TFyVHFHcrR5efh+zuhubZ
 D7lnob3daBkk7WjIJoJP35wY7Fa4lgyDE22H/UKsNKPUrUp0OWtO83n1em3MhI6lRy+GQITfZ
 WcfG1LiytDCGTTQ7yFUlMrA4Kl3WUWuYnxo2zDxfAp6fZQwUsK/RzZlx5i+zcy0lM0LZLeUN7
 Id+REaluvMkLynxdweZyIgdnf9PL3m/duES7bUY585BFL5n7pE+E7ErtaDLBDvrtvQXLFJjPK
 uuwLYzoHk8/kmU/yJ9qoskDIAZrUr5kO4kyLbJKZspYdeu77EJPVVcNlBZszNgtBC3G5auj4+
 pNB0pw==
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

--Sig_/aj_NOGLHwivYscp62wRh+R7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:53 +0200
Juan Quintela <quintela@redhat.com> wrote:

> It is used everywhere else in C.  Once there, make sure that we don't
> use the index outside of the for declaring the variable there.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.c | 57 ++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)
>=20
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index cf3a6c238d..a23531606e 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -243,27 +243,25 @@ static inline void compress_reset_result(CompressPa=
ram *param)
> =20
>  void flush_compressed_data(int (send_queued_data(CompressParam *)))
>  {
> -    int idx, thread_count;
> -
> -    thread_count =3D migrate_compress_threads();
> +    int thread_count =3D migrate_compress_threads();
> =20
>      qemu_mutex_lock(&comp_done_lock);
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        while (!comp_param[idx].done) {
> +    for (int i =3D 0; i < thread_count; i++) {
> +        while (!comp_param[i].done) {
>              qemu_cond_wait(&comp_done_cond, &comp_done_lock);
>          }
>      }
>      qemu_mutex_unlock(&comp_done_lock);
> =20
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        qemu_mutex_lock(&comp_param[idx].mutex);
> -        if (!comp_param[idx].quit) {
> -            CompressParam *param =3D &comp_param[idx];
> +    for (int i =3D 0; i < thread_count; i++) {
> +        qemu_mutex_lock(&comp_param[i].mutex);
> +        if (!comp_param[i].quit) {
> +            CompressParam *param =3D &comp_param[i];
>              send_queued_data(param);
>              assert(qemu_file_buffer_empty(param->file));
>              compress_reset_result(param);
>          }
> -        qemu_mutex_unlock(&comp_param[idx].mutex);
> +        qemu_mutex_unlock(&comp_param[i].mutex);
>      }
>  }
> =20
> @@ -281,16 +279,15 @@ static inline void set_compress_params(CompressPara=
m *param, RAMBlock *block,
>  bool compress_page_with_multi_thread(RAMBlock *block, ram_addr_t offset,
>                                       int (send_queued_data(CompressParam=
 *)))
>  {
> -    int idx, thread_count;
>      bool wait =3D migrate_compress_wait_thread();
> =20
> -    thread_count =3D migrate_compress_threads();
> +    int thread_count =3D migrate_compress_threads();
>      qemu_mutex_lock(&comp_done_lock);
> =20
>      while (true) {
> -        for (idx =3D 0; idx < thread_count; idx++) {
> -            if (comp_param[idx].done) {
> -                CompressParam *param =3D &comp_param[idx];
> +        for (int i =3D 0; i < thread_count; i++) {
> +            if (comp_param[i].done) {
> +                CompressParam *param =3D &comp_param[i];
>                  qemu_mutex_lock(&param->mutex);
>                  param->done =3D false;
>                  send_queued_data(param);
> @@ -384,16 +381,14 @@ static void *do_data_decompress(void *opaque)
> =20
>  int wait_for_decompress_done(void)
>  {
> -    int idx, thread_count;
> -
>      if (!migrate_compress()) {
>          return 0;
>      }
> =20
> -    thread_count =3D migrate_decompress_threads();
> +    int thread_count =3D migrate_decompress_threads();
>      qemu_mutex_lock(&decomp_done_lock);
> -    for (idx =3D 0; idx < thread_count; idx++) {
> -        while (!decomp_param[idx].done) {
> +    for (int i =3D 0; i < thread_count; i++) {
> +        while (!decomp_param[i].done) {
>              qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
>          }
>      }
> @@ -484,20 +479,18 @@ exit:
> =20
>  void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
>  {
> -    int idx, thread_count;
> -
> -    thread_count =3D migrate_decompress_threads();
> +    int thread_count =3D migrate_decompress_threads();
>      QEMU_LOCK_GUARD(&decomp_done_lock);
>      while (true) {
> -        for (idx =3D 0; idx < thread_count; idx++) {
> -            if (decomp_param[idx].done) {
> -                decomp_param[idx].done =3D false;
> -                qemu_mutex_lock(&decomp_param[idx].mutex);
> -                qemu_get_buffer(f, decomp_param[idx].compbuf, len);
> -                decomp_param[idx].des =3D host;
> -                decomp_param[idx].len =3D len;
> -                qemu_cond_signal(&decomp_param[idx].cond);
> -                qemu_mutex_unlock(&decomp_param[idx].mutex);
> +        for (int i =3D 0; i < thread_count; i++) {
> +            if (decomp_param[i].done) {
> +                decomp_param[i].done =3D false;
> +                qemu_mutex_lock(&decomp_param[i].mutex);
> +                qemu_get_buffer(f, decomp_param[i].compbuf, len);
> +                decomp_param[i].des =3D host;
> +                decomp_param[i].len =3D len;
> +                qemu_cond_signal(&decomp_param[i].cond);
> +                qemu_mutex_unlock(&decomp_param[i].mutex);
>                  return;
>              }
>          }


--Sig_/aj_NOGLHwivYscp62wRh+R7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNNMACgkQNasLKJxd
slihoA//Qh2PGmUmbq66EJtj9uqMB7QiU4iJzJ4N2x0BVdp8r82k23EoCL5e+mPH
SgxCs8cTCfVqVWtHvEKj9U1aJlMwbNHQRMvyy5bkiNZBlfi3nhJpPgu/D1kTmigo
+ydo08zvLabYvw1z+TncGV0eMlA3fJj8xZMEouoO0JPuPcB0lAb8H5P4dEx3U68t
f1vCqZ4I7LLvMT58cH5bDRHXSGrXN2C9Pclv6ShrvhkHOiVPYWfvv+oqg2ji3aAG
kUaK2UIf/6eJOzQ4xid1bL4uQf/ycIH8PIYf6zpuxK500t+0+IG/XunyMPuMJh1o
++Y/26i/4b1475pND6vhpP1Z4oxblfLKHCyPL9KJPHVDGgF0q8djeicDAVi2uc7i
HCUB3KpRqgAZU9xBQUWewcKp+gtS2VkGt1EynbjNk2to0KjH5pZGqD9tDhJxGM13
1rJtqYPVZuQZUAbhIM03WvqgHB+8n3TgydNqc+y1Mt+nYrjviGh1//jnIp+aaUXG
0yLwPLhQ+VS635E7xjXTFbDyOz1zYi377Qs+h4javzHgmDjDf/q6S1iL4Q4Ga6qV
yK3Z4g+ix/Hazfux30H7WseyztOfl2oUJKdlyvKPKatoe3xKM0VsSzQc7neGfshw
2MgFSZjGjBDNJTnkXgm1kZ20oPbEtWDTD1lKrS8iHUnSTXZrC8Q=
=Ss3H
-----END PGP SIGNATURE-----

--Sig_/aj_NOGLHwivYscp62wRh+R7--

