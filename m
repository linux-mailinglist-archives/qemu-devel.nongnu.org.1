Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21D782204
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 05:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXvoj-0006wV-P7; Sun, 20 Aug 2023 23:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXvoh-0006w8-2g
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:42:59 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qXvoe-0000YM-2l
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 23:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692589373; bh=0GNawiVWwtkaxabFIF47FaOCTMJLp1JkCAvK/oNe2io=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=LY/Ke0iwFMx3hFZdJYGhl7Id/NF7ITR02hAppo0a2ybfoqkb7MVoWv9bI4WW2qMnE
 +YAYXkjBFprokX41FTI1T5Sj8yEi7PBT2s7/WWYMZGEN0ScyWTiu3FaURQr3Ne6eD8
 iu4jcMtYkgMdAtVBM40DRTWQmLPPjf+LnokzovYYNxPMwD35sKYEAZR28Nh8INMkGa
 SDgBUdPE3DbtF7INXMbAsRUNR5dpXu/kCW4IyNpfd7kUF8oEJrHNJJtRfak120JUhX
 PvMBB74MuUPt+YPce9iyCo8DYUYDT+cdz5CQEAzmkOs/+zWUvq0xu3xxHhr1sIsyJt
 CBGAR+YuamDvg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 7F8D93F20FF0;
 Sun, 20 Aug 2023 20:42:53 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id kS4kd5P4wNRb; Sun, 20 Aug 2023 20:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1692589372; bh=0GNawiVWwtkaxabFIF47FaOCTMJLp1JkCAvK/oNe2io=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=GLrLUPXxQFeccwaBCSaHA/jqIUxeWYZoj7lEir1XNjh/kC0Fx04uzQCHKlspih73r
 fi7Rp/DlWiOOQc4XxH+lljZbgPtI8gwOXQcNtioT5H0pbELRB1YGR5dCSjuQS5QTgh
 GjYmdldg0mhl85Tu5Bx2KOTNz5+ZfNEflbVdAnzza+v4nOrUORrN3xC3yBIN8KNb9U
 nTqMQJByDOE750HGY8usKK0W5srIeyI+d7aRW2HnWr5qY494T+gv0QMqnSyI/QVS/k
 nddGbfwEVjoabqnEI5jtcMq24hBdLFjeF4cQlYLkZNM/F/Z2sZKOWLoVBB+AnfYpup
 9DWcwzhDYdcyg==
Received: from keithp.com (unknown [98.97.112.104])
 by elaine.keithp.com (Postfix) with ESMTPSA id 82A213F20D83;
 Sun, 20 Aug 2023 20:42:52 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id A52D91E601E7; Sun, 20 Aug 2023 20:42:52 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] softfloat: Handle m68k extended precision denormals
 properly
In-Reply-To: <420b8a0d-4a36-ff07-e95c-fff3b980d1c2@linaro.org>
References: <20230821003237.376935-1-richard.henderson@linaro.org>
 <877cppkx0r.fsf@keithp.com>
 <420b8a0d-4a36-ff07-e95c-fff3b980d1c2@linaro.org>
Date: Sun, 20 Aug 2023 20:42:52 -0700
Message-ID: <874jktkqmb.fsf@keithp.com>
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


> That does look like a correct change.  I'll fold it in.
> Please let us know if you encounter anything else.

Thanks so much. With these fixes, all of my long double math library
tests in picolibc are passing now (once I fixed a bunch of additional
m68k-denorm related math library bugs). That includes the fmal tests I
mentioned, which check all four rounding modes across a fairly extensive
set of inputs.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTi3TwACgkQ2yIaaQAA
ABH6eBAAqBvz/D0jjjTkBq2Ntjq9XawF1W4yNvj1vF4d3CAEXNTsttXyjVem7hUu
ZvCCe7oG34m18EVsidY5Z0ZasC1IcnskvtRUHYtHY9Rpmv1we0x61UZpzcg4jm2R
my3zaWsn4vSEhQeN1E0CSN606p1K36pj+7YZ4kjxwADY2lHZqUV0ftqj7UIIO4pC
JOx3rH4Q0j4niVS5ljMxo7yrjfHzCECGT8UlGzB5eJbBMnVOnAI1YFm+zYuQMOpU
O4XJVqmSk+E1XGzuY3rkuaHT0+KFT7vmIt+bOTIZHKwkongf8jVxKauS6mMDSJRr
h1RD0Gd9nL6hnBFOREcICHA7TKI6MZWqNBX7E1EOwudX4+U48yEFjvkJc3VpXb++
b/gj83eZglF22N72F27PCkj3vIyvXLKCc+dgZ/m8Rct2sUNI/9mlK3MhLefN/02V
mPY3UDrw/uO0W0cjvLDol0Ky7QjB5VX2O+Fr373hvMEDSz9vc5T6sYLtnr2eIUxc
3OVWS5pLXdu3af03NwNMfUm6ZoJAg0VFbD8UJisM09Otx1hEuyH+AMu6cHt+W2sB
Kfwrjc4JTW5aFDYae72KMSCJA+u6DbtuqBZwAZvJdA8ro7Yb3sNxuAVYYyZrc4QO
CNOwR5FAz+d1bWBP373T5utFq2NKFiUWxzmCt0RziEnbzBK5Rdw=
=wXbL
-----END PGP SIGNATURE-----
--=-=-=--

