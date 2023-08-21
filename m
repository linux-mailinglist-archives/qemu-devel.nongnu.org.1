Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66278212D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 03:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXtes-0002VG-Uj; Sun, 20 Aug 2023 21:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXteq-0002Ur-QA
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:24:40 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXten-0000wM-Rf
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692581075; bh=d+shdVQeeQ4OE3BXVJMbavRxKvsD8dfup4LM/xVSt6E=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=U7byCxF6VHVyaQyZ0wUxLDlJ6ustDiCu21aFtPV0D3Ve0lkIPLr8a6ZoSN4cpVLM7
 c8yxpvuvGQaANwtGu2nzh/yyO11mK2MYFpkIGkD7AB8Pijktl/0HcOIjvSAWS4SAkz
 XRCorI915eaBlKn7gJHxnIXziMl63WIO4d6Wp7d5eaS9e8DJJ8JxZcLyQUVPl8T3RF
 cXFkxWsTV93vP5dCxxpMwC3LcIOMlrI+hNuPrmcetS7Eib3vRA4+2eL34hSvwrBESd
 JALDeWQqttdcAJlHIf4+gICnHzQuuoT1DRWuZtmRF/DBNC0hO11OgA8YK09SThfKn0
 TKyLc77kTiqzA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id F3BBB3F21123;
 Sun, 20 Aug 2023 18:24:34 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id cOnwNlBiS59k; Sun, 20 Aug 2023 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692581074; bh=d+shdVQeeQ4OE3BXVJMbavRxKvsD8dfup4LM/xVSt6E=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=MVuZUeSN6XeClnCbAlCBcoEWnKJd+u4qHqI9iIrjza/BokO8oPsvSGszk8/RJUXjU
 +PTFiY/w9wge4ZDt9glrw98O72OhtvL0/VzyuRtEwbacGtY+KKJJo0l3ur03nfSiZ8
 Y2NXZBl2lM4HYv5C4nxocRJBrnxUKLDw6Hwzbl6b5hgkC1bI5cmzVgL+yfrh1A2iUX
 Qzm6zZRzc2AmdC4S/Xfj73JVmXhUxMvAtDsqnq66/wfu28Fsx8Gxnu8jXFKLvruhED
 U9ZozRAVfa1NthVNRjDCHV2UUY8PRYXhUF9AYLAIthl+G/URt9jU02ZZ77krZaa3Pn
 ziblUXZfybm1g==
Received: from keithp.com (unknown [98.97.112.104])
 by elaine.keithp.com (Postfix) with ESMTPSA id 156073F20FF0;
 Sun, 20 Aug 2023 18:24:34 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id C277F1E601E7; Sun, 20 Aug 2023 18:24:36 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] softfloat: Handle m68k extended precision denormals
 properly
In-Reply-To: <20230821003237.376935-1-richard.henderson@linaro.org>
References: <20230821003237.376935-1-richard.henderson@linaro.org>
Date: Sun, 20 Aug 2023 18:24:36 -0700
Message-ID: <877cppkx0r.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Motorola treats denormals with explicit integer bit set as
> having unbiased exponent 0, unlike Intel which treats it as
> having unbiased exponent 1 (like all other IEEE formats).

Thanks for having a look at this. Your patch fixes a couple of cases,
but there are further adventures that await if you're interested.

           x:  0x1p0                      0x3fff 0x80000000 0x00000000
           y:  0x1p-16383                 0x0000 0x80000000 0x00000000
   build_mul:  0x1p-16382                 0x0000 0x80000000 0x00000000
 runtime_mul:  0x1p-16383                 0x0001 0x80000000 0x00000000

I think the enclosed additional patch fixes this. I've still got 75 fmal
failures on this target, but the obvious 'multiply is broken' problem
appears fixed.

From=20b722c92f8329f56f5243496eca3779f1156aff4f Mon Sep 17 00:00:00 2001
From: Keith Packard <keithp@keithp.com>
Date: Sun, 20 Aug 2023 18:20:13 -0700
Subject: [PATCH] softfloat: Handle m68k LDBL_MIN_EXP normal values

Unlike Intel 80-bit floats, Motorola allows for normal values with a
zero exponent. Handle that by not setting exponent to 1 when the value
is normal for this format.

Signed-off-by: Keith Packard <keithp@keithp.com>
=2D--
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index d0c43c28fb..cea854cdf1 100644
=2D-- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -288,7 +288,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, floa=
t_status *s,
             p->frac_lo &=3D ~round_mask;
         }
=20
=2D        exp =3D (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) !=3D 0;
+        exp =3D (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) !=3D 0 && !fmt->m68=
k_denormal;
         frac_shr(p, frac_shift);
=20
         if (is_tiny && (flags & float_flag_inexact)) {
=2D-=20
2.40.1

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTivNQACgkQ2yIaaQAA
ABEP7Q//Vpu3XULzWBw3jU/2jltEgwbn98PhtZC7TiaS6z9zz7R/2ixsg2RdfS77
tZ9V3t/Ra4KwFVsAdKKlxJM97TrP1tWhrY7yXAdWsbGjyzbs9wQVWILOwHj1Y2Ex
HupMQfDSHJxT3BLjV4ZjSTpGqofyfK3fxre9hnnXDrlHNUYM39tf5TJODdKMPheT
4LLxCE0vS4jH1DDZTjIITwpMWimtdGCmA3YF4e6RxrkylP843fURH3T5z6mXomGN
Tcgn9XzqYvMrOWe1z7J6H7JHlhUyb/Tj9y81i/QkufifrEuyflAkRb2FBSFXX+ZA
IdwL/jzB0uHZAjLXGhEacGcScHHmH10pGvqh8f6qheRwWY9Uj8xlwFtpfRBj5iID
+s2TjzOfabTJsq2LRB9DfUyhmRi30DiEQKkWO61Uh/58KWOeoA3zipaiQAMFvMpk
eN+Xr0KIdapAvk6BFxaLQArRh5iZCCJmPfYnZUVl5TVrAX9vrxcbmerj9AGmrn64
vmPFW5KgX5Zpt3JaVmkFHhZEvVXjVqjixaIS6c5zJcTPRCrfcJCHkhBgJQG6H+/m
DBWW0JyPHC3U/Ww3soOGok2Z7yG1rjZbDV/GO7Xdrb30TISzCtbQzq4uR6z6FkFm
+DWp0bPyJh5746M4Ed3KuEQySxgW/+OPw8fvl0/2bzu0JXaBJCQ=
=ec9u
-----END PGP SIGNATURE-----
--=-=-=--

