Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9275576B845
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQr1P-0002K9-25; Tue, 01 Aug 2023 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQr1M-0002Ju-PH
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:10:48 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qQr1J-0007Nq-OB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690902642; bh=JzC9v5zfsL1rkPTRuJH+P/opMuZEh39j0oiyNFjZ2sg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NTs/8256KEreJZSz9RqJU7IGTMmrP6BxINRB/l7cimT8LKUXcTjZ9NQVRwcsu1Juw
 3cTVGVD132RM28pY12ee/wx+YHlZDF/AzGOaWwn9i4YDdxc4HwIlnlvWzYpv2fkl3D
 YJuCDeDx//S9fWxCwrAlsvOAodVhUe2aes8mPMdHBkj9bcGyED2dQye0nhggVUz22y
 tNWzJD+xCwkLbk5dcgXF9ixehvgd5ym6SWMD6V7+8JAGFEhaBjYqVrq0FdQKV/Ow+i
 6vMRp8gueqgpyDvKbVNgq4MzP7QPa8ATYQ7k/P/M+RSK0AU36jgzpp7AzE0uRWKP6I
 7mTJeIEfFbdaQ==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 1BC693F206C6;
 Tue,  1 Aug 2023 08:10:42 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id TIA060zTyJZx; Tue,  1 Aug 2023 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1690902641; bh=JzC9v5zfsL1rkPTRuJH+P/opMuZEh39j0oiyNFjZ2sg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=q/K5gbLHNLSHjFAEhXAiLa9zuSdGBYgK7ONhQVIynElWNr6LrWZ6JHPOIiWZUvuUS
 9WX4wTXOxV1L8w69DNJbrF37o+wNmR13C5txeWzZkmaClyE10qEIKGY8BQ0hTvpuab
 ponxXQtHrrBQXwwVuPKRSoCjjSS4OzppvMmE/5t/OF7ghkgiSSjWvLqY6rnuvItRZg
 ObB5zQQI31GcF4mXBEK7cOszcsB2muS0aBhORSQwRPQfc8e7cBluY8Z1j/TJrWng4S
 rn7ugbrzSFJt0bjESwYZ5+wOUdxugAthk4JnsIHuqpUMm98vRanDeMUpC5vte1wc1I
 PDC/6FQ+k7xiA==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 7C2DE3F20587;
 Tue,  1 Aug 2023 08:10:41 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 457621E601E7; Tue,  1 Aug 2023 08:10:41 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut
 <marex@denx.de>
Subject: Re: [PATCH] target/nios2: Pass semihosting arg to exit
In-Reply-To: <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
References: <20230731224106.292845-1-keithp@keithp.com>
 <CAFEAcA9xAeSpn6g66di95RihCyUxfo4hys4LRD-uJrYXd9RVuA@mail.gmail.com>
Date: Tue, 01 Aug 2023 08:10:40 -0700
Message-ID: <87r0omol1r.fsf@keithp.com>
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> says that for HOSTED_EXIT the exit code is in r5,
> not in a parameter block pointed to by r5. That
> would imply that the correct change is to use
> R_ARG1 rather than R_ARG0 here.

Ah, thanks -- I hadn't managed to find the actual standard yet. I'll
resubmit with that fixed.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTJIHEACgkQ2yIaaQAA
ABGWMQ/9Fqqsbc+DC1RiSnbyjMyJ8u4HWcx/QCxiIG4HgdgoulGkJiet34OBV3aE
mrH6l8pEDiIpmyefBddu1m9nK6WcrXQd0dF5jzYPuGGfQbmDnvhspi+sx7CKAEd3
tyV3VM3p6yrYpv0CiPcokngxr+lQ6HqfDSylHn4Cuh7d0y8vq7R/SrvB+ud7Lydj
4cW3P6dMIm28teQQ3uigiek8vBTqZIbgIKDg769/8+Qgz0TCz9maZ2qbGLcUDx0H
2Eu/j5HW18hNBWbvr2GQKWXX96U4okegklRTstgJI/D/gCVBClXb8yyWvn9WfIVE
bSRQ3gC+wGTXpNclzLVH8TzHGpdrpm/nnlFd8+G/E7N/Um9HAf1faBJsvq7/qZmQ
fEJkb3U6gnyX+ZOkS6csB2QVTDPjPxCsSkfAfY8R0Trm2ImEQwOcV3WbsIc7KMTS
TbCln9bIUAeKfEDONEPKgYS/NV3Whxh8h2mx5U3d0J207u1eq/lrEpEZ8aMLEy6i
8yP6C5zdoeNeykRsGsR1uqRxGV/osWuMPJx9gXbxqp5Tz0AqaHWvrVlZJ7n7LrQq
wQQ9/sf7c2mPH7Fj3AEz+IUydTn0XqxIKvVks5j1ZgWbSLP6OQ0yWg/PNvm/ZOcd
6Gqr8AzRZ2odaDqGpHP2Sjot9nE0bl2V4ID8nCK+IUT1+mmz9uI=
=szRU
-----END PGP SIGNATURE-----
--=-=-=--

