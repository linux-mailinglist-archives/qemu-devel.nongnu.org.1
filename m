Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FFF73A008
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCInn-0001ki-3C; Thu, 22 Jun 2023 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIng-0001fJ-7m
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:32 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIne-0005NA-CP
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434506; x=1688039306; i=lukasstraub2@web.de;
 bh=hlGHJKATVwQxfbowzxdbCuMyC7ltkmXILx9Iznw0EcE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Nh8SbfJ3y7DJZEzLwnPPIE1qJXXPlfdjvMoqcBvsT1mFQcaTLCKOVyytSBlwGjF1ryx9ycI
 ChA/4zwBNGgGKWFgsZGKLLkfXBXV6w3Iat/IzZ2f3Lh8kyF8i2J8eUuKjJOr1U5YTcPOCEmu8
 kj/dlUnH69tCQCiQ2i0xJxeZ55j11qjNlPpHiZAo0DKxzfgMwE6OgVU7TILn9Is+VvJ5OrGoa
 l5JCCpjukC+oVYRCPJmP9WOi8Yq2oPr105M1j/w+2TVtA/Z7Nd74WEdPp6nBJZUwCBfcwRnJA
 otlWQKEK+SE3ZT6WVDctybqbn0fzSc6YEOiYuzu88jTWud0cFmqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi4z5-1pZ6Ed1MY5-00dhHj; Thu, 22
 Jun 2023 13:48:26 +0200
Date: Thu, 22 Jun 2023 13:48:22 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 17/18] migration: Remove not needed block parameter for
 save_zero_page*
Message-ID: <20230622134822.50031f5a@mobian>
In-Reply-To: <20230613145757.10131-18-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-18-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UcmOS8TcRdsF=ykguf28zyL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:SRbGbk0ah8RlglGALQQhLa/Op1c7XpYg50x5e7C1/sjYJCv4Z+F
 bb/SAvvf28qPI7Rjwwy+mH2hlctvJp+goutrEQjju6srXHl8Kd7MkjMDH06Ar4jX3VUJLsQ
 blzYUJmX2DKVLPT1p0HSCX2HhQwkEVeKzihcSLvOgDRe8ozH/V8LtSbi1ZoMoY6JSBmc33l
 wQT9Z8LdHgMd1IukYs4xg==
UI-OutboundReport: notjunk:1;M01:P0:miMHbIHvEZg=;Bzuf5+Lm4rDdHmAfIjCYYnLz3Pg
 TYBC9oB5j0fpIh63L6iv5fqHNNEGRYcsZ6XO8m5ayb7SWNY8SHh/vJUl1328l2F0shcCUoR/8
 3UjFHZjw4wCc0YvGtSxo1eYSHTbkaTF7gILNyDgElMdJ7nFhcChNmt+YSmCZqpbLxXoUuxzEw
 LYVQyRIvj1kRXbLjW+1VZIY9ea2JUmYjD4seVgXsr/m5bozPGAs25ktRafjrf4Ga0ojNDe8+u
 4SPeCjn0Xp6I+mz/AOGhnF6jdHGq93hgO6RP9hV5uvR8cn8DQdOl4kde85U1aNxTvac/Z6dJj
 trWz7zJiknCyF1Q0LtzLvU4pmfUvImphaQ/PmYNn9/lnDuL4FrmvHimd2F+QD2RCZHKeyrBLl
 e2i0ZfoCAbvXbwfBmCdrCy5aJDjkOROoHkmGIDkdEqgztRqW7txlmVBFyhhUsuxIy9gRd97Iz
 sa0dMmoupm0E16o6Ent6TJup+3kbd5L+hVUcF74ULBiRqVaO0Y5awjty5MlKt++0uKr+IvBwj
 cJKibiOMFADsj0AiM2MR/KvAUrgwMhLVHUdhTAU6vI4sSEh/HGqS3xR3vLPI3ycbziYIPdzrt
 f6cVHHhde1syjfCsEjZ/LkPJMkF1EfKmaNQ+baDqhkaRcAnM1CksKNo8fZOmuEvd1YtNAZZlu
 BYp1S5evT7Zj8Z9frG4a2CscGuRWqpvo5Clem1PpGuyJyhgLsKiA3NPJRoYu8UFen/9h2qDCr
 UxFkNJ4VuBguaGCQfPNWdFcLgDKxurB2+fyPTT1dLJ1VLVn+jDUoqhxT0XH8O1HG2Q23W7Q8w
 2w5KOqMEJVwB//Ctgz631hi3Ihj45FtA3cJaSgb45uWDcvbKTE81qwB6+O+z3i+y5ZHzohqpx
 uayfN3R+ylNzdZ4Ax/NoHWrm2+M/xWokOc4/oBK2lzqOhdqKAalKfrgCFzj3uHn4qZcnE8i4p
 o4/m2g==
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

--Sig_/UcmOS8TcRdsF=ykguf28zyL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:56 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 293ea87a70..0259c33da7 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1067,20 +1067,20 @@ void ram_release_page(const char *rbname, uint64_=
t offset)
>   * a zero page
>   *
>   * @pss: current PSS channel
> - * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   */
>  static int save_zero_page_to_file(PageSearchStatus *pss, QEMUFile *file,
> -                                  RAMBlock *block, ram_addr_t offset)
> +                                  ram_addr_t offset)
>  {
> -    uint8_t *p =3D block->host + offset;
> +    uint8_t *p =3D pss->block->host + offset;
>      int len =3D 0;
> =20
>      if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
> -        len +=3D save_page_header(pss, file, block, offset | RAM_SAVE_FL=
AG_ZERO);
> +        len +=3D save_page_header(pss, file, pss->block,
> +                                offset | RAM_SAVE_FLAG_ZERO);
>          qemu_put_byte(file, 0);
>          len +=3D 1;
> -        ram_release_page(block->idstr, offset);
> +        ram_release_page(pss->block->idstr, offset);
>      }
>      return len;
>  }
> @@ -1091,13 +1091,11 @@ static int save_zero_page_to_file(PageSearchStatu=
s *pss, QEMUFile *file,
>   * Returns the number of pages written.
>   *
>   * @pss: current PSS channel
> - * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   */
> -static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *=
block,
> -                          ram_addr_t offset)
> +static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, ram_addr_t=
 offset)
>  {
> -    int len =3D save_zero_page_to_file(pss, f, block, offset);
> +    int len =3D save_zero_page_to_file(pss, f, offset);
> =20
>      if (len) {
>          stat64_add(&mig_stats.zero_pages, 1);
> @@ -2033,7 +2031,7 @@ static int ram_save_target_page_legacy(RAMState *rs=
, PageSearchStatus *pss)
>          return 1;
>      }
> =20
> -    res =3D save_zero_page(pss, pss->pss_channel, block, offset);
> +    res =3D save_zero_page(pss, pss->pss_channel, offset);
>      if (res > 0) {
>          /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>           * page would be stale


--Sig_/UcmOS8TcRdsF=ykguf28zyL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNQYACgkQNasLKJxd
slhttBAAhpsxieIWg+Vk/7gAosifhYb/vy+adt0kMD2I/OI7pGUEyG7SzkFhIX0T
W6+mHW7vpsKkhJuv0JM7vIdzvk8HhL8wYuuzWStqlkQRnw5jkHq0+Mp5xeg5C0qw
wD/lrwKakIcaK+xkEYBLlSbD9qY0dbIyaAlEp7lMRZFEF6qIa2aukti0egpI7AE4
2Juqsy/iGcS6NIp2uxyX8k0o69U9CwaF4tsEDlbK+73xb5LLIja+mMpsxZn8jniM
+sE1eOnBXU2xxc9DVSaMfo/srGOJCgR8x/sOhna4Y/Kx69GUovXIopvY3z1k3cLu
gMJeSSBrV9rt7xMqgH0dnFU5fKndqtC0JcC3O7tGuAGrGJrRC7OxPP6+rA0nHc7q
7cVbF4J44xsl0U2pwaAvzDTO7n7IiPHaqAeUxPGnCeXq2v2tj7GG04bCaM9CddTd
YdjWRP1CQXZuV2SCGFAq2WehCtAyuh3rDJG5V8B99WL01pEpudWjzBWpiEhgDa7F
2G+WlGi13gKfRqd8RPi9TOK8FAxrQSp2w7RyvZcpOsbDyaxmjnJKCN6LJSZTzn/S
BdBrUxH1hOyDQkWvMuZUNUvaXrho+gtLNogqQ8v8iup9CaPPSXuxs/jGC3c/u2nb
RMipnVWomHtNPdffx1RhyRgVZd7glmKzaC44T9y3x7DMrrz7YiY=
=W/m/
-----END PGP SIGNATURE-----

--Sig_/UcmOS8TcRdsF=ykguf28zyL--

