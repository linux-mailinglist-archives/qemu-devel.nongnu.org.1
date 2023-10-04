Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A0B7B7AF0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxhf-0000Mh-B3; Wed, 04 Oct 2023 04:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qnxhY-0000GR-2D; Wed, 04 Oct 2023 04:57:52 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qnxhW-0002E5-6J; Wed, 04 Oct 2023 04:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1696409866; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=qop8yYXcdj00oQllVJIQ2TBVsAxihiZwlA3v/Gp0zf3yNEQisTjFeUmuKRz1LSKrez
 rwQPGTc1HASYe+DUkzfk9ZpgdBqE2UPNaySR0WR4oI1bkCZnaZNjWNOqKmArGFgIXlu4
 V8CIOS2j9tyXM1aR9Ra23HeQ++DGrQPh+zUFDyKSJ2zxKqdcnsDQDGsgd2L9w7TOFpKU
 hBo4O8lc0K7+8QiT9eqDYM4fn6Hs/oWxbxtlxygNtP69GR8rZiJHkABdVvkc8s7OnOPj
 rN5StLsdDoUVEnr7zZRZs8kndK9GWjX8DW2nd2dDYDgEi/tkvZQryZrm9CiUv9LNuF/D
 TkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696409866;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=bihXzSz6sZK/ZxDSrqb9liUXEDUD/Xz2izGntBAAkO8=;
 b=FXpTYtE5yprEGZQYbzkdAbxxSaFBXdpUUpjr0QvvecZh2/Scu6rWfOuvi0jvj0NDQf
 YRqWmFBXmWFYSN2whUfqqoCuEX9Dqy78r29tkS2/pX8Y7nRnwKkXzm4G1MNWy+JiiwEl
 oDJfWS0m43nljRFw5p6pZt0gIWweQx4o0ujUzGC2Hwdo1Qm/oZtPKHy9icCfFwRnHk6G
 d2qoShGougpmBEapPl9LiBQTIc/wjql/+VYmsvkW2bEaIHbpy7l28PvpOF3ZqAJR/pCz
 UxAw0DqrnBx/n0VJKMlDhH4oSSzXQG2Sic+N+ZoliKoZdFaT/I/TC6wRUXPXAUwi/Aee
 RWwQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696409866;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=bihXzSz6sZK/ZxDSrqb9liUXEDUD/Xz2izGntBAAkO8=;
 b=P2xtF0IqIOuBQDs0Tg8IEAxEihBE5KSd0F8RXQ3bXxLmUb3ZPY7wnrbU4rQvmEJ/tg
 4ELx2kW1obBqYGmsorXVIRQae/3ucUtoObLR6k/rqDbl0b9knSiF9Grok1OfF/ty6VvA
 b+sT7BaI9evkrKVFxXHtoPM/MkJF3lviLAlCMTHO2oZb9/7rtlHFw+tlZwZ7s/7iQbu+
 gfaNAo0F+O2J2sKmEjZwdxCn4+cC6KGShN08BqlDTcOYRiKr8LzaTlvLwmhcHi2z+nzw
 YUt754E5fuBev2Pk3VUJ+dn8RjkotSHpmUD7/UP4QqvtP2OdbEgummfHXpQz2oWucevc
 zptg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696409866;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=bihXzSz6sZK/ZxDSrqb9liUXEDUD/Xz2izGntBAAkO8=;
 b=E0mI4+KenRUR1CO04OHcfr9j+8FmfD+x9mceCuTb7pFy7OQ48UFZF0PER7q2BcyldZ
 JnLnv5w4MYKnCp/qxfCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4WhOIYxjs6IbxwdWV2aAyqkbNw03IRPl3Vg6+Rg=="
Received: from sender by smtp.strato.de (RZmta 49.8.2 AUTH)
 with ESMTPSA id C041b2z948vkuyh
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 4 Oct 2023 10:57:46 +0200 (CEST)
Date: Wed, 4 Oct 2023 10:57:35 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-8.1.2 00/45] Patch Round-up for stable 8.1.2, freeze on
 2023-10-14
Message-ID: <20231004105735.7d6452f5.olaf@aepfle.de>
In-Reply-To: <e314d38a-4223-e72b-3729-615da41b8025@tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
 <20231004101921.03d0260e.olaf@aepfle.de>
 <e314d38a-4223-e72b-3729-615da41b8025@tls.msk.ru>
X-Mailer: Claws Mail 20230817T113819.a897c59c hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aCSw6ptaG=CCemO_k.L.Qm/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.24; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--Sig_/aCSw6ptaG=CCemO_k.L.Qm/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 4 Oct 2023 11:44:53 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> Second, this is not even the production code, it is testing code.

I need to double check if there is indeed a way to omit this code.
A quick search indicates that disabling TCG may be required.

> And the most important, third: even with the warning being emitted, 8.1 i=
s still
> usable on openSUSE Tumbleweed: all qemu released tarballs are built WITHO=
UT
> -Werror option, so when building a release there, these warnings wont fai=
l the
> build.  Currently, this is controlled by presence of .git in the top-level
> source dir, -Werror is only enabled if .git is present.

The failure comes from outside, Werror=3Dreturn-type in CFLAGS, not from
QEMU's built-in Werror.


Olaf

--Sig_/aCSw6ptaG=CCemO_k.L.Qm/
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmUdKQAACgkQ86SN7mm1
DoCTmw//TQiI44DPnJ5yXfMmm44PpbWOrIPQdNlszEsHFrqiGXayoIzEl8kzRl9j
5dERG6Rh8BVOxJzZNEvd3Zf06rTtXLYkO+lskb+wbpKN+KJ9XsOQH8P29bdYFbwZ
7F76pY9+kUBwAZWPv6RHhBkuUbTvyJ4TufHNoWXKPoQ8IzRwxYMZe7chLjczpnbo
fhDjFwxbqUsmv6BgsPJh+bM02Ac8H2bMIJk4I9WrsO4Wk37zbY6o5eUcewk1RMu6
8pUlcKnL3KY2yMWa984LHvRvy/hjsmDEgsmseQq5/xJhJx16v/qggaWxUXrUybLp
BPfYDUCWsee8zUTg140PAA++7s8dJQYBatfdLf9s6mtfL08OBsgP8RaGdT2aHFsk
SR2bU3B4YVb5tctSvetrUYn21LBlvrJCPQKyb5eCaCrgwLceOer2OE7VCsgn6Vn/
s5yLbNR4ynQhK5VwNqostIrIPe0jRXPXq9Zh1nPc03pgLKgLi3triFoPxxrnmUJA
yjO5zAsIf8bKwaDXlpihgadAaZ0GdpdtN8ujAAnTohJpOaOb7KwO2ZAm9m39Y5Hw
QW9/x6MAoKcMekAXMfC1OArUt9LMara3lRNuVDtjHAj1YzFFxSsQqTOk5hXPqXsI
2fACNu96iAL+zEKr0fMnAN+Ian3Kv/qT9b55cbCjcYLtk9k0TN4=
=WNQg
-----END PGP SIGNATURE-----

--Sig_/aCSw6ptaG=CCemO_k.L.Qm/--

