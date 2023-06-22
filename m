Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29A1739F5C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:23:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIOr-0005FF-V1; Thu, 22 Jun 2023 07:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIOm-0005AB-Ed
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:22:48 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIOk-0006J6-RL
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687432962; x=1688037762; i=lukasstraub2@web.de;
 bh=tk8ma7v3hC61F8xrAUpSv6dthTlZBmxKf3VkzxTLhp4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WKa0SpEUqmUywMetO4HlaxCsMkgVZ1ABChPaaAREWyULs9kjOUyl3XxoWxs77ZQHoRaKU23
 GvhQRJ+X56ox7dCTlp82GyvXDmsbPRWXOa+LSLaB5J0PM6r2eYYiNL2/tonvijyJy7f4fGoOs
 wXV+PPnqHTVa1uIdklH2FuWrMrCZyBkrtnyrC+1xB49CYBWTf7IM/20NlPMvGK+fjDhZlJ1eG
 kJW0hZFFwubaixVGiHFWUYMz5Zp8hDaWD1sOFoVEgwqi///7dzzKTPXQOJWTDsjVvPJe1OXj+
 tXqqI656kG9S0DUchmlnL1WRskNjxY2hasXZfJxjLxEffrP/q5/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KNZ-1qCZNY3rLl-000P41; Thu, 22
 Jun 2023 13:22:42 +0200
Date: Thu, 22 Jun 2023 13:22:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le Goater"
 <clg@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 2/2] savevm: Disallow devices being legacy and iterable at
 the same time
Message-ID: <e6994f3d2d7f78ddf46bf22c9483fe718aae217b.1687430098.git.lukasstraub2@web.de>
In-Reply-To: <3c45b84bf970d20bfc72865c4de5c33563c2b62d.1687430098.git.lukasstraub2@web.de>
References: <3c45b84bf970d20bfc72865c4de5c33563c2b62d.1687430098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vR5Y.N3pzCj19WYOy/2VMv2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:hcdoR5mPasvgGWzs2TUzneFrxRhaVsrYMPJCtoN6xoHKtmvJQiv
 ++xzbxVgPmh296LPFShafkf3XcIPir5o0xGBcGZvnJv/a87E30yloy1xqNPeGPM6/4N9Hz2
 0otMChUktP0087sis4+sHD7AjDppBRJWMwh23+mPx++56jpF0DrbT62TefACabwQnfkDBs5
 HFYuK1gFDgX5CUKVhwvew==
UI-OutboundReport: notjunk:1;M01:P0:EKmtBgFf2RU=;HNF3LuuETJ4C8Z0SBydsF8kP8rM
 VXgXZLbyi2lk612ESMlR5gg9kCUibD6gLhuFQJrbBvg4FEuv6d8sXfejHQOdPHLsy2juaQjzh
 bgFwre3iIn691U6EI2wONOycNne8UyYK4pNk+ITEpc+gp2d+vwgUmC4u+U13w6yCpRzGQ6p6n
 fNQOiyLZ7FRdHVKuJJHI0KIY7wLeeIIsztwAy623kDizOXkp16VuAopknBx+BAI8NT6lpLHDs
 89JToOHX3oNQ+ofJY/BuUmmWNgWp+UBMqE0mzwJ+Bnnr/ptXSb+sNiI/F0R+VvWb/8Yult9Sx
 ZW0eSfEQYLXM0Uz3IAz3L1Okw0fZLw9VKlGcAv8zLcKlff5iar123FscLqHk0Oij7KeKV7WKz
 +cq9HOut31yijP63rvwfUqzb7wqL5WhsW6YojE7UaAhoXcy2waDpzFyhaa3zLQoDO3N2fS01m
 pkr2O6O7xingNiBDRhYG+AbhWBQ9dOOorIN1dHBLWlr3g20nXoHpfAIHU3+sfDeRJeiQ6mntQ
 Kkboatf0yvV+RcuHk3rBMvjewrU1SAtpq4myPPH906MXC9Z+PseDySYIinQAdzu6sk+XcQCqS
 zOV/ST+e7/SSnt/s94yjSN+MGjULsPaP+fGKvReSF4LV2chKOe5RfzJ6g52D5J3ityDOlVZ5U
 w+6i3NxCbLvFeX+7Jeao37/Oejx7MAKxkwI12j/1vmZ4ppRYfgph41z77f6gmkpws7sQFrhF/
 vSQFfXqPzDsHqi0t9cDAgDWj3UEiRYQejBATS3oSUEY5NK2e554rR+CVz8TX9tTb9s3zXbMCZ
 0UzHweKDNaQFlpscjaecvFil27vlX4NVgQPjZ8VTQTI0u4Z98bJLz1ic/MUomh4EifJs60Uaj
 ynQkwBeOGtcWdOvo9bRXdGHqErwxfggWkUu8b8bRiYAYNgwEQcZDHeKz0HeX0LSECln/c+eaE
 xUitJuQQr4ADZikeJoWhVYF8EQg=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/vR5Y.N3pzCj19WYOy/2VMv2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5986f852b2..8d3cf7d675 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -774,6 +774,8 @@ int register_savevm_live(const char *idstr,
         se->is_ram =3D 1;
     }
=20
+    assert(!(se->ops->save_setup && se->ops->save_state));
+
     pstrcat(se->idstr, sizeof(se->idstr), idstr);
=20
     if (instance_id =3D=3D VMSTATE_INSTANCE_ID_ANY) {
--=20
2.39.2

--Sig_/vR5Y.N3pzCj19WYOy/2VMv2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSULv4ACgkQNasLKJxd
sliC+RAApCaWiKaToubXFdKQCQSEcvLcLXwZuXmAG/hwAelEI2rKeIx3l/wuy8O2
6icsYPpjZH+144Z9onT60MGcZXHKRaYCdvMFESALXrDB8ugynJlEP/JdCB+TEHxb
yyCvj6x8QY3wF4oCir+W08C8O0Jw+JZOyRkAz8FK8nRkGPtNhBplujwxjxK0NT1b
nWI/kvSHYQ5eB0u5Iw+mvvz6m+8bFGz/RYoh8idlhG8sdeal+sQYMdWgeVy9Dupx
bp2jodIJ9GYCM7xSLobE+Xskno5m2bYnWvoYZovUwbSAlay2HMovbRFjnJ1iBZ8c
A3BlzzDLKWRBL6sUBnD7zEeM3u6PJw7ZBWB0Gow/GLYmbDeIOiUwKcMy+KVZs3hg
CvXA6xAVHSOim3klkex8Kj9/93q5IhrglLpRYbX4CA+C82bTNgaAXJpMZjgxhGeo
aT79s6Dch1xQGNQ4w1fvuvZNw1AUx2MURVHPic3vv9XWboxv7RD6dyCNWGxPcNcz
T4QXAJZgM5k59lqqjHf3mMjmuw+0OEcMo9+Q24YJPE2ndXzUiM1sOVXhTfvhr+vy
z99FopueLrKHeo0xPwIrN7PHOld5yu1ebf4GuFESc3bvaWvlzBFnQoEsEr71vjpl
h5oHpwfjA70J2LDFOxgaCz4Kiew/C16l41uvWOjCVlBy3oCzrPI=
=USCo
-----END PGP SIGNATURE-----

--Sig_/vR5Y.N3pzCj19WYOy/2VMv2--

