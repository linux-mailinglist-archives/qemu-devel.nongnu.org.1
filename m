Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F367739F5A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIMn-0004IE-P9; Thu, 22 Jun 2023 07:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIMm-0004I0-3H; Thu, 22 Jun 2023 07:20:44 -0400
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIMk-0005Di-8M; Thu, 22 Jun 2023 07:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687432840; x=1688037640; i=lukasstraub2@web.de;
 bh=kOqgGPtLZSggHdyOH0344NP/No9yRkURQWWFPRLmaHI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=syZ9wegBZNHBp++vWomf0PImbYgbCSHA3wLupz1GJHSP6iuvOcGUdvl7W8wuiwokL/VP2yp
 iy51W0hcp1BA9KTHYMoNGFvJwbyCsbmJ3zhFEviOmEtu5wPZZ9pw+drd2DTb0YCrXKwU+MZd9
 WC4SN/X36yejND4gIAPuwAviERJyPYBG4mdm32GuJrGPoGJBFPauj5+u3WFSZmPyLrdMkxyr9
 WjhKs14SqW28WBwFVkv65rsOuNRFKu66qe2C5MOs17MR/ktvaACXOmx0iYi5HZDJOOxbm2/n/
 jRtGTpT6g75MC9K5KdY/Ex0Ps+K1sKL9cYrrlJgJ0+3byZiDaeXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1LsV-1q6gNv0pfn-012i90; Thu, 22
 Jun 2023 13:20:40 +0200
Date: Thu, 22 Jun 2023 13:20:36 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] ide: Explicitly poll for BHs on cancel
Message-ID: <209e5ce8e8bfb99f5f2c5b8844e17de76f20786c.1687430874.git.lukasstraub2@web.de>
In-Reply-To: <d69ad42912db00f9520a7205c4d2bae6efca5279.1687430874.git.lukasstraub2@web.de>
References: <d69ad42912db00f9520a7205c4d2bae6efca5279.1687430874.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q=68LfgmOfTOsO03kxUmZ0l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Kaw0TpcZl7TAoIxxlTOHBln5BqBcQFIWsmEjszkh+HOM8VycIp/
 KxlqIxZ/81Pks0TNdnc05g2iigxrnppMLkbG82qXZn0hS3IN672EgWuPhTbNDkH8pi7ML8m
 5Sq9AhcseyxHwu7pGzjoh0HPnPEXfE+ID07p+t/kOgipBIL817SU1GU0H6Io6a42qZJAtZo
 Q2LBuxkoVOwHrPafKNL8A==
UI-OutboundReport: notjunk:1;M01:P0:LnxVqIxllQ4=;LmBpPVcAcb/WOl2M4dJAN09nY0r
 JI6UKmsQF3pt01Yb80hs4fEX1dMquhi/eD2cCMaVKTZXs/NaKczSz983XEtPUlDDExe+39Akg
 5IssbDRn32ATJKv4TizA4MQDrvwfihSpbWObE2eHOhwCGP4uODAl7jcnX7RscPF44PH8EHoSo
 A1C4z6CiBkajZ6YwFECZuWFZywCV64szetxTkgrrBbAWCUxVv66y4EjLCcK/3hk7njYWRtjap
 pc94RWuAfkDqaI819Bs+kiNWdzZD/g/H7mgrzSBn130Xs/qLbhzyhf6PCWQpXfjNxZY/bk4cp
 yQFS/hGfS6ltnpBVvlI89w/oe0AYL+HdR5zFy7q8RT9v8cUlqrnpevFpZ1dMuG3otfJ+V/cea
 OyZ/fzmOGRHXcJCxAiLKa4J/JGHlsJMI7Inwz6nort721TJgmb1Hzsq2hm5HJeN7x/JVdQnNi
 gz1CT9zd3WUn9Kj2tR0w73EapxaftTVdbC20B5LfgNyU+Jl0UELqcr2u9qJ5+BwBWumvvidAJ
 YSP2WM0/Vp63C3W/nHudrt7QlC9noRxVl5O9pAnfjfY2IifyTbJTr+8AzK3dt3hVmCrlJwak8
 qTPOnVxL3KjHU2oLLhNAIVsS/9TREhBWyTZdc1nXV9Dxs7urbvn7Afnr4LBQuZQg5Adyt6hLW
 VQCxooJ768GqrxeMM7PdkvWDHHtzuh5pQm8aSR7QLXMk/tpmEPrSNHIj+WtwDIQmhJu2f2Bqs
 jAiCqdOgKMi0cM7U0gnIqc3bMO95fBEdcAx026MppVCmxeSGH8engYUZjToaUQM+HPI2U80lm
 m33iFPMNiVxJat1ozwrqkiGxqQdIMKn/IV+VuVBldkbiRDbRVhwxCMf3LdywGzZNzRaSLPucz
 DODB+cx8VXA4TmlL5DvZyWSOCTeukaTa+hj5FH7ha+XeupFASD4mAMgzEFyLiBMTfmq2a94a3
 N3vHpJoGNAmfREDpbaQSuIkgzF4=
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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

--Sig_/q=68LfgmOfTOsO03kxUmZ0l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

When we still have an AIOCB registered for DMA operations, we try to
settle the respective operation by draining the BlockBackend associated
with the IDE device.

However, this assumes that every DMA operation is associated with some
I/O operation on the BlockBackend, and so settling the latter will
settle the former.  That is not the case; for example, the guest is free
to issue a zero-length TRIM operation that will not result in any I/O
operation forwarded to the BlockBackend.  In such a case, blk_drain()
will be a no-op if no other operations are in flight.

It is clear that if blk_drain() is a no-op, the value of
s->bus->dma->aiocb will not change between checking it in the `if`
condition and asserting that it is NULL after blk_drain().

To settle the DMA operation, we will thus need to explicitly invoke
aio_poll() ourselves, which will run any outstanding BHs (like
ide_trim_bh_cb()), until s->bus->dma->aiocb is NULL.  To stop this from
being an infinite loop, assert that we made progress with every
aio_poll() call (i.e., invoked some BH).

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2029980
Signed-off-by: Hanna Reitz <hreitz@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 hw/ide/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index d172e70f1e..a5fd89ebdd 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -736,7 +736,17 @@ void ide_cancel_dma_sync(IDEState *s)
     if (s->bus->dma->aiocb) {
         trace_ide_cancel_dma_sync_remaining();
         blk_drain(s->blk);
-        assert(s->bus->dma->aiocb =3D=3D NULL);
+
+        /*
+         * Wait for potentially still-scheduled BHs, like ide_trim_bh_cb()
+         * (blk_drain() will only poll if there are in-flight requests on =
the
+         * BlockBackend, which there may not necessarily be, e.g. when the
+         * guest has issued a zero-length TRIM request)
+         */
+        while (s->bus->dma->aiocb) {
+            bool progress =3D aio_poll(qemu_get_aio_context(), true);
+            assert(progress);
+        }
     }
 }
=20
--=20
2.39.2

--Sig_/q=68LfgmOfTOsO03kxUmZ0l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSULoQACgkQNasLKJxd
slh2jg//eg0eizEBLEssbuka4ekBjdjAZ+ZiShqzUU57T8X41EgLN/HvV9wroFPf
oiSHtOIVv1gQyZjhfNqpZLvgGvAhTn+UrggXHCDAVlGiX5COcGQLKKVw8GBnXYPA
+ck0r8FSxmIX3UtTzi+3JA8zq7rQPHg6oAJ4fWDzBJA5mx9XElo874qvGFszpzen
31e4wBzI5xWwdVgJbghwRztRSwmXEmX9znYZfFWy3CN3YsNG21WS+ii9x0rYTQLe
/fWDOi2hCX8DEk3DvyqBvWfoaj58qW5yUHuQn4S3reb8n74UNF6ruV7W5Zz6NUw6
86TaFFSigqSzEgTyXKm60LsqntG/r7PRw8NtrzgjN66wGScBIB3yHIX2IVbVgHXJ
uWTGuBwv0BF15lmcCTRzdjPFfrTaP0urqZeH8fvFoUXfhC86FZwQy2+u0tokP7zx
bXn7Lwfx8Ue646bWkDVPTTd2jbmzwC7S/UVhmkL5XMv1xnDp5MEQFqzpHwIW4JWJ
OhmJ4eW7wiyPZNGWxjn4gGAqWq6GfsH6+rpEznuQH9S256ga119XVnr65fqPDRys
a/37e1RoqzQsOMTKHsmQoeTNwo6dMlS/g5RZaOxnaaoNnWiV8Njf8EdTCI838yNP
IB6k3DOv5Rhi7mnVYJ5CkgNS8bmeXXuvQLV8UNqNhw7Bh7uBeHU=
=GzdF
-----END PGP SIGNATURE-----

--Sig_/q=68LfgmOfTOsO03kxUmZ0l--

