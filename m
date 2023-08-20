Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BED782007
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 22:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXpSQ-0000lK-41; Sun, 20 Aug 2023 16:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXpSO-0000lC-KL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:55:32 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXpSL-0001Uy-TI
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 16:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692564924; bh=vyeKvbhdqvNswqiakBT/p7kzRar2+XJHlJtS+rHOV8E=;
 h=From:To:Subject:cc:Date:From;
 b=XFfis1KLYz7RRq75DMWtC1h0LLOdisXGX3ejA+C2+zEfVrM6f3wyFhxPGr7ln/a80
 ocv/8G/kjkAZvFi2Xr0sktcKPr5H0OM1bpq/0hTIV4lW0KbrWC3rgkfpU8RyfYF6b1
 oPU9iivx33RdZeEuxL8m1h6pWshjkC2OLyUGIY2f/IPhNTySrYj45CFgu2W+tf0kiD
 /9LtwoZTqYzHAKMPJOljCjISiLx5sqhTtE1sd4lGnxHEk/rlBFMh6kLfr7dKcObaKA
 0UmgYNfB27sIkuEvrGgYm+SLO0mRgSVEv3J8YSPHeY/ElhiJkTOLds93kB/IfGAZ25
 Wr9goW1Y1K9Wg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id ED7DB3F20D83;
 Sun, 20 Aug 2023 13:55:24 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id Xqta2Ek163F1; Sun, 20 Aug 2023 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692564924; bh=vyeKvbhdqvNswqiakBT/p7kzRar2+XJHlJtS+rHOV8E=;
 h=From:To:Subject:cc:Date:From;
 b=XFfis1KLYz7RRq75DMWtC1h0LLOdisXGX3ejA+C2+zEfVrM6f3wyFhxPGr7ln/a80
 ocv/8G/kjkAZvFi2Xr0sktcKPr5H0OM1bpq/0hTIV4lW0KbrWC3rgkfpU8RyfYF6b1
 oPU9iivx33RdZeEuxL8m1h6pWshjkC2OLyUGIY2f/IPhNTySrYj45CFgu2W+tf0kiD
 /9LtwoZTqYzHAKMPJOljCjISiLx5sqhTtE1sd4lGnxHEk/rlBFMh6kLfr7dKcObaKA
 0UmgYNfB27sIkuEvrGgYm+SLO0mRgSVEv3J8YSPHeY/ElhiJkTOLds93kB/IfGAZ25
 Wr9goW1Y1K9Wg==
Received: from keithp.com (unknown [98.97.112.104])
 by elaine.keithp.com (Postfix) with ESMTPSA id 0F1D83F2069A;
 Sun, 20 Aug 2023 13:55:24 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 3EB021E601E7; Sun, 20 Aug 2023 13:55:25 -0700 (PDT)
To: qemu-devel@nongnu.org
Subject: Funny results with long double denorms on m68k
cc: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 20 Aug 2023 13:55:24 -0700
Message-ID: <87bkf1l9hf.fsf@keithp.com>
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


I'm doing some testing of an fmal implementation and discovered some
"odd" results on m68k where the emulated 80-bit FPU is generating
results that don't match how GCC computes things. Assuming gcc is
correct, this means there are some subtle bugs in how qemu is handling
denorms for this platform.

From=20what I can discern from examining gcc output, the 68881 80-bit
format handles denorms differently than the 8087. It allows normal
numbers to have an exponent field of zero -- with an explicit 1
bit. Furthermore, denorms don't have their exponent biased by 1, the
natural 0 value is correct.

As a simple example of this issue, I've attached a sample program which
multiplies the smallest denorm (__LDBL_DENORM_MIN__, or 0x1p-16446l) by
the largest value (__LDBL_MAX__, or 0x1p+16383l). This should be
0x1p-63, but qemu computes this as 0x1p-62. In raw form:

           x:  0x1p+16383                 0x7ffe 0x80000000 0x00000000
           y:  0x1p-16446                 0x0000 0x00000000 0x00000001
   build_mul:  0x1p-63                    0x3fc0 0x80000000 0x00000000
 runtime_mul:  0x1p-62                    0x3fc1 0x80000000 0x00000000

Looking just at the exponents, we see that the runtime computed value
has an exponent of 0x3fc1. Subtracting the bias of 0x3fff, we get -62.

This particular fault comes from converting the denorm into canonical
form in fpu/softfloat-parts.c.inc:partsN(canonicalize):

        } else {
            int shift =3D frac_normalize(p);
            p->cls =3D float_class_normal;
            p->exp =3D fmt->frac_shift - fmt->exp_bias - shift + 1;
        }

the extra '1' added there is the exponent bias required for standard
denorm format values.

This is only one of a number of related faults; there are similar issues
when converting back from canonical form to 68881 form. As that involves
complicated rounding semantics, it's a lot more difficult to figure out
how to fix it. For instance:

           x:  0x1.1p-8223                0x1fe0 0x88000000 0x00000000
           y:  0x1.1p-8224                0x1fdf 0x88000000 0x00000000
   build_mul:  0x1p-16446                 0x0000 0x00000000 0x00000001
 runtime_mul:  0x0p+0                     0x0000 0x00000000 0x00000000

In this case, the multiplication results in a value just larger than 1/2
of the smallest denorm. That should round up to the smallest denorm, but
qemu generates zero instead.

=2D--------

#include <stdio.h>
#include <stdint.h>

#define X       0x1p+16383l
#define Y       0x1p-16446l

static long double build_mul =3D X * Y;
static volatile long double x =3D X;
static volatile long double y =3D Y;

static void
dump_ld(const char *label, long double ld)
{
    union {
        long double     d;
        struct {
            uint32_t    exp:16;
            uint32_t    space:16;
            uint32_t    h;
            uint32_t    l;
        };
    } u;

    u.d =3D ld;
    printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, =
u.l);
}

int main(void)
{
    long double runtime_mul =3D x * y;

    dump_ld("x", x);
    dump_ld("y", y);
    dump_ld("build_mul", build_mul);
    dump_ld("runtime_mul", runtime_mul);
    return 0;
}

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTifb0ACgkQ2yIaaQAA
ABE+6RAAsYu1UQHkPWQ7MQFe8RgnuhuaPaVO4nCeHVj408zY8qC49dPvNfAqPDi+
xy1m6EXQmGZrvPvHdcwUrr0SQ5OdD10T3WBdZEcGZ0AA0owvlL/9avWLEYmYYAAD
j51O2VyrKo3AOjqm9ycbu/AufczpMBgg2GW05g3VbfAbpwr3AtMemaN9P2Jk83pq
rMK0mQUx2IZjmz8dHcqdX4xVqoavL+ajB+iIsBEuCPL7VhwUemo/jTCZQYH4ZduR
jQbolAEkdrkuJ9HpW39C/PjxTmB1YtO2evmooX5TKG2bEAlxyTJgzJyd+gp9pCRP
PMrfNE0+b7Su98Q+QkNLUpnZJ0NDtP604bnzhogrgIhPdiiiUkfImLpfG6ViYrbC
YOEDA+KjhPylrDEC0jkMmKgU6x+NVkheHZ5vI3iMt8bmP+teQDWMTDz4bMxretFs
ho9tR/44J4tOkC9cTsLSndREUr65buWKv7t5mNnOSpr1mUpSsl7Zlh4MagFvc8jM
rE6nXB8l2Z1IGqtU1HkDRjonpBK0L5OfMTSusCskXDLwbKUAUSRXzgOJz3ZvOdE6
NYQBycq75e8zYw6iyEmGIUFj7HdWP4SwhW1jipcl/j5O1J9K+gQGgYA/bM+9pyqc
0zit1Jh77bAEJXhK8jejIuXuykEu6He3hHTiXc9426dxDET129g=
=Gcja
-----END PGP SIGNATURE-----
--=-=-=--

