Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010A73A005
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCInG-0000zH-3V; Thu, 22 Jun 2023 07:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInB-0000pI-Qb
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:03 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInA-0005B6-64
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434476; x=1688039276; i=lukasstraub2@web.de;
 bh=jZvCt/B+uJI2bof7NHcB6JGNLkDdfn7er5rKBhKGJIQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UIrLvvMX6sxv+K0OIeAbHV5YSraqTOzhK02jO721ohQe7mrFWfiKIMsT7V/n0p0KybrXbBa
 1n/LZxTQz6Tr6gZfiDtiZwyMScXQdZGYNJpQ47NGMQgLTCtIc6cT89OtB9sUUPSQMqi4hRwb4
 EuPB84OuAdZCQXsoEQE2plxe8H9xU9Vpj1HIEQ9noHRxBhHv4EkUz/t/BWNZqIWWVh7Kf1RTH
 ocAc0NKVosPrwqi1OzPi/AB/YqBCuI8i7UO99RIQ3Oc9yWECluHx2cvYz37npwaJM1eSRhP1q
 JBTc59KNkMZry8SWT8DuWZOHauYGBovvaeDcjw6ld2GaA7Di+7NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1pnf8c1E22-00mESI; Thu, 22
 Jun 2023 13:47:56 +0200
Date: Thu, 22 Jun 2023 13:47:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 15/18] migration: save_compress_page() can take block
 through pss
Message-ID: <20230622134752.49c9c351@mobian>
In-Reply-To: <20230613145757.10131-16-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-16-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x=LNc2B0.f7ef49r7pMmceH";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:sYV6KOLLdaQ/cUhV5iuZggFGU0KQLWMpt4sb+o3jkcrVbvK/M/b
 bY5S68OfDJQqdiZ0qoGjxyrO5mdxj3Raa6YS8ntsqJf1qBrH3CkNH51cv6gu4H9hbfltFig
 fywTgmC3F18/M+pnT9ejdB5f3hugFfm3mHMgTpqI060pXfY+NMiMigAlSnzR2qsMEb8bCWx
 95rvpDWl4KVDmM5+K3iOw==
UI-OutboundReport: notjunk:1;M01:P0:LODPAqSv9y8=;eQ1kUJ/tj/sKRR5BH3Sk8b1VqHg
 th10rKyO7DvExjEfpRkrSYaymAaLeUrAb6k92EJMTDDGBITTuKABny1tIm6gQ8hNujBOYBfkk
 8Rs5Pb8AtEkAJ4U/cT1Ujxf5USP7760UgJGyeT05YG/P22CC+RW5pGebfqqVySUern1uRf//a
 54sBsIkII5Btdgfqn3fi9kD105FHHOQoKy/AItdWDqWpnV1Vpe6NSH9TzoGZ7xStV2mEGfxgF
 Fc8AqG8kzOxntDsxqn+2qERvtHI9h/gafMv+0sT3uBlmapAXbhDLRSbM55oNjtSpXo6o7uKif
 IEaMbhl8nHJq4AZ0GVHuwUjvQvP89Ev8PBrJLc3+GhqoLUMKew9zdhzgiT/T3xUHnbLuipQzy
 EdH9m5Kp//zEuF6nqp/+VVoMyDDhVzdQlzFxuBdDLrasXeyVKzPRucKl8oQiO0jAPaZ+cI/f0
 Ow+/QBNNcQUWn0lLlKBO3WO7pKwcQFrxswIQQ5Voh+rM37aRln1iplcJRCValXtn/ieDBRib3
 TFrTtfAAcXoe3gOQQI9s6H4QCrgC6vJWeLN8L8PNdpTd5vG+t5vTI+6A9pgn+Jsk2FNQVnyB+
 oLLCjMoQ3ek8rxZb7+Hm4CAohHuKRPcCd4pl/pkaTxg764ObCij4pnpyX2ICEuia33qhfTEX9
 Phh/tkMXs8oYV+CSAu4iNwsO7TWAtNlkF3a/j4gKyptHN8WHCbrIc59snASMONqE/vKWTdgG3
 B5iM1o2PjDqdAJvYU4qz7CCHwSkVU948DfuJrYO0Eay249zk0zLV56w7EVJkhJEKB78AORfPi
 x0Ria3limaaEyr+gNFpEDcQHRFt8LAi/SvskMNyH6zXozeN0PbofVVv6O3ytkDD/A7bLTjAsy
 KlGQfusd6DZQa34LZ1c1qZhX0sQCo9dEQAz+Zs96b9AxUQ8mZBVoqJpUR4Yj/R6HMZf13rIsG
 iitRQNcoKD3YzjBAfamw0lSZ6FQ=
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

--Sig_/x=LNc2B0.f7ef49r7pMmceH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:54 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 1bd586c23a..e3ff98a6ce 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1986,7 +1986,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>   * paths to handle it
>   */
>  static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
> -                               RAMBlock *block, ram_addr_t offset)
> +                               ram_addr_t offset)
>  {
>      if (!migrate_compress()) {
>          return false;
> @@ -2002,12 +2002,13 @@ static bool save_compress_page(RAMState *rs, Page=
SearchStatus *pss,
>       * We post the fist page as normal page as compression will take
>       * much CPU resource.
>       */
> -    if (block !=3D pss->last_sent_block) {
> +    if (pss->block !=3D pss->last_sent_block) {
>          ram_flush_compressed_data();
>          return false;
>      }
> =20
> -    return compress_page_with_multi_thread(block, offset, send_queued_da=
ta);
> +    return compress_page_with_multi_thread(pss->block, offset,
> +                                           send_queued_data);
>  }
> =20
>  /**
> @@ -2028,7 +2029,7 @@ static int ram_save_target_page_legacy(RAMState *rs=
, PageSearchStatus *pss)
>          return res;
>      }
> =20
> -    if (save_compress_page(rs, pss, block, offset)) {
> +    if (save_compress_page(rs, pss, offset)) {
>          return 1;
>      }
> =20


--Sig_/x=LNc2B0.f7ef49r7pMmceH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNOgACgkQNasLKJxd
slgG+A//Uu6PvMC3p++0qQiBp7TnJd7QLToEEN9XKSEXpk21vn2fBhMV/WhZD+qD
ILXQGSdzLkk4Ga9EXTlVAneTc3CgzyeU+iQlMX2RLeQh7NYrmR8vvRh6cvWv/hBR
mvAk/Yg68E8ClrGEbCNn5/OmYUMoE4BafLFUvXxvYXFu3z1ZTFghT8Rj8ava9hfJ
NkcB1p8jyfAU24aU9R3M1NzYHyJLmMxc2J//2MpsyxBdbyJPS86hUKqeLsP/v+w1
qCM/5RESgn64iOZpn+mouP0UXEAQR3/G4yMlhvKwdNVR+kZPrgEx7wTziPz7saWV
HXXyA/JPR/05rXNDkGWGGTQvtsHR62hfcPL1Il5UmcuOa2lKRjoj1DKmd3kUpPRW
FIR1xQlcvG4n+QUQf8fe3wI9c/kENZaXr8Ypd/IoLADPEA3kQTjTsra9yj6awSd6
wZNGr7TPnDqbdr1JM76mhgFLfZAxHuI5aNhO5rlhT/iPp6sBNM+9AqdjWgFJvUum
SG7IEaaGJAFSiLvRrxoMlsWB8PQmHL61+v3q8P+7DhdQkjJNzTyVslFjtKcKTKJu
jssv9PNwkSDz64g+L+0VW8bVdbTxDESMBQdOOWD2YREC8MwJ1cJuBE1/E3gJ/Hfe
jj0Pa41okxIgfFyTN/Be2QLUCu7HU4uggq9d6gmPvvAv77wyGCs=
=pqll
-----END PGP SIGNATURE-----

--Sig_/x=LNc2B0.f7ef49r7pMmceH--

