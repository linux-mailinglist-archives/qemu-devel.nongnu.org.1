Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747277F2BC
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 11:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYxf-0007Mw-KN; Thu, 17 Aug 2023 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qWYxb-0007Mg-Ia
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:06:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qWYxZ-0006x3-E1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 05:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1692263186; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=A6vr/2hUb2tNxOO11Gku2r06WWwBOQTkCpQxITnTA0zqww4sL5/GYdeUF+QF5anOVQ
 ahAE9d9SKCN/h0o7CV2ftiuCfTEWfPu1ZhBz4ydnJD8rz8ziWEbT4M/8iDuDRfsXpETg
 zjq/SmIclBAgx9+DaDdyE5CP0waazS0ijmDnR5QdkDVzaYqxyL2v9RHWuyvbup+NLlFG
 CEALoiKZlX3UZReYYb3LCLdSVB7fKsvLsyvTHqzB91bb4QlHT2s9n7JLKKZXQr38MTUk
 BvjqcwJBGGOCvff5EX141eyC9t7nLVISxk92SJ/1/qCBeHy8UhfXab77buERmwFKSRjC
 1ZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692263186;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ntai6U8n3/SVOx2RaJde0i3vH0MtpUCjHokMMZPfcn0=;
 b=pxuqwhTm+AlUaweeE5+DL84rlgm2vb5Ja9akZk1d3SrKDMlIIX44IgtFReozZw2PNa
 iA0GW0MzepDZ4XurHevD3hQQbmlbEihtOiPKGgD4oocC4ZLpOkBb2RIGTOjogdYNG6gk
 fqDsCqsg4FK1H106LWOrtC+56vBvXeVkBxnpIjBK1tZmbc4AcyxmCPDTXSXi2vEziVju
 4WsLsb2dBMJwnm16KyHDv55Pie+jKsXNxqhDsyKM/KVcBxPrw8slNsG0RWLsIpfs7eJ/
 B7aMPemBHPCTyAzo4iFKsIAibrK5bZywLMYsrUV8GnBcCxQMRPxpMYqa9Z8e7RpkgmaC
 31eQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692263186;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ntai6U8n3/SVOx2RaJde0i3vH0MtpUCjHokMMZPfcn0=;
 b=p3NOpLIFNFRkfG9sVDyPATtMm5n4vYWBqbPQIa533IjuNagTWT6JiDnhj72wWwFKvB
 Oy3WM38c5EXDTDUaHOf68lnYxKD8OvOWWgu0sNtLA81PDNaqQTaORfzgCmwVrhD1Ih8n
 jU0zVnfZIQcI1wYLVtI+XhEDt3z9MLqi6pG8zGDI+g8kz/wDbVBCsDcO+ZjG7O3TwZJv
 GMXUu8xYlmnIHojX7GFJFbYml5rh/PgBr+59skBOzSJabaxzdo/OcMSbBg0i55vluKGP
 SsgeuGIgV+80esHtQBSrnyO1/WCbue27S/XzK9Z/z7N+JfhgipINX4r5ghnQa97leS32
 888w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692263186;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ntai6U8n3/SVOx2RaJde0i3vH0MtpUCjHokMMZPfcn0=;
 b=gzLcvrhTAkR9WrnsxyaDtWBquFMcIfCUkXusWpXGFUHToGk4zTSRzicPbJTixsouXD
 Wls+Jk1wdy1v7UHlZ9Cg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5W0GIOBLsFlYBLP6a70ck8itmkUBIgogr7HPCVw=="
Received: from sender by smtp.strato.de (RZmta 49.6.6 AUTH)
 with ESMTPSA id tf602fz7H96Q3AN
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 17 Aug 2023 11:06:26 +0200 (CEST)
Date: Thu, 17 Aug 2023 11:06:25 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a
 problem with compiler warnings
Message-ID: <20230817110625.455fa48d.olaf@aepfle.de>
In-Reply-To: <1a33ef6c-a3ff-ca92-5288-de66bc2818aa@linaro.org>
References: <20230816091522.1292029-1-thuth@redhat.com>
 <1a33ef6c-a3ff-ca92-5288-de66bc2818aa@linaro.org>
X-Mailer: Claws Mail 20230724T063118.58ae3d58 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6GtXv8UvbiN3wFcYG5O1iKT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.166; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/6GtXv8UvbiN3wFcYG5O1iKT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wed, 16 Aug 2023 14:49:07 +0200 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org>:

> Why the default is with 7 and not 3 or 5?
> Shouldn't we abort() or mark with __builtin_unreachable()?

In the referenced bug it was suggested to add a trailing "unreachable".
But suggestion arrived after my MR, and I'm also not sure if there is a way
to implement it for all supported compilers.


Olaf

--Sig_/6GtXv8UvbiN3wFcYG5O1iKT
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmTd4xEACgkQ86SN7mm1
DoBwGw/9HzBLpXA5e6TSmCMfFqaoCJsYQDp2GXjS6pkjQY39qnA3qD8WWvAoUQXJ
5/16cHz67NedOVsX1FYjMuq/p4fRadTiQkPSBg6nbUIpFDarpb+TqhxZzojNbhP0
27+JV1yLIONbQBl4Jtw+eu6DnDqz6Jv7myVUmM/UL8Tk7CZhl7ZzFm/JMsPKyf0j
6h2y2MyPZYoC7jfMuM1yFmNRKWFT/txSDk37gVepNQE1TcFI/SjYRKdF39yB8XXe
xqyaiQ0CJPT7WPKHCSVTX6Bz5A3mJ6YhoDlT6phcze7iCxUpOAPnbatvOq4HrDX4
fvVEWnqsM/9zyV4nva6RS8+hjosqWOZUwoN30UnW3+l0CENBa/vWqPIsVpJ0tDsY
aTZPG9nPgz0MnC/I0HYm7GHmtC/pu/32gGsS8xeckbYrv5y/LY2J4ZH41YX+n6IQ
qWLLdVja8gIr2/3SCcgs4Z3SAp3e1s+iPDsihQE19oPZ4cF6IeLfGvL/+0bu81K1
kTapUVbnozmhyefVsj3IUdhUj6Xn4cJnAIxEKMtoCKXL45Z5fGIF49hGIXN+h2dQ
LIz3E7UYOUm7POzd5zUxCKVhbkfGq0bRiPH7btDmb3No8X3vaptwMbNKTNl7qizN
5B/uX3R1MCvnvz0Fs1n8IXeFR612mu2pJsRU1XOo/vAIl/niX6E=
=QmDX
-----END PGP SIGNATURE-----

--Sig_/6GtXv8UvbiN3wFcYG5O1iKT--

