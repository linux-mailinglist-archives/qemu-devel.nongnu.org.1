Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C305F76DF2A
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 05:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRPOf-0003eP-EU; Wed, 02 Aug 2023 23:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qRPOd-0003eA-SO
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 23:53:07 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qRPOc-0001Nv-Dz
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 23:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1691034784; bh=aC5/J3gdTuJQSQqwqkgaoEj2nXh2C8gAXlmPHlBEoZs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=SWOMXFA51ZFjrEpo/8A/SsbR+MpUbMRXmDKOCuCRGcWGyEqGbrsgTdl3HcCIVzQQw
 T1C5Tn8Y/+YwDd+213tyBtsCuRk2/zsTwF0zSVJxeUM4uZIgw688HPU7A+0G617L0n
 RxFZWvjfkUZXjfpz3plGUKxBxQfkksrHE0cpgQWkHVTDcbPZCpnL1grwxcwP+E8ZBm
 PO8LrI9vqJ5/UoJUPNxZYL5U1S92ayLUstt1LsCNCOO13k7gTSEXL6NshP2xG5VNrf
 b5kipWoH7QL2dkPX+qX0aQu30ua4she1Wjq3gXQiIlW3QscCp8qLQUjgvv6tdNH/sM
 FxMhoANrm+EUQ==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 794893F20951;
 Wed,  2 Aug 2023 20:53:04 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id xfXiX3jGaO4g; Wed,  2 Aug 2023 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1691034783; bh=aC5/J3gdTuJQSQqwqkgaoEj2nXh2C8gAXlmPHlBEoZs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kiTPeOKjdO0ysYEiHgwlJOimqM+H1KrnCaS9toxXP/4wRyGblbux5aPeByUmvonbb
 YZBN8lcoeVpCbzYJAX+QN1zCCRt1Tnsebj8wD1hxzLWUoV6OdkF4vIDUHMDRnxrPNi
 y3GjxOA+AEVlfxO2Qpe95uVsy9XNzYjdNX4P6kctMOZZ4c+4bB9s8mTwBUTIz3EIj/
 N7ZHtP/CZw8Dnbvg5TzZfDDbTfRQMQXTE7Nfa4B+xH8pNKsOPbDVu4/GdRTiUI8boL
 mENY4ueeAOyA7NMV9Uh5iv+YA+ULMX8yhPRJRiPG2vxdv1TW/XZn++fFmkBV+c5KKC
 tF/vyMOeCk/bw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id BB9903F20206;
 Wed,  2 Aug 2023 20:53:03 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id AAF5A1E601E7; Wed,  2 Aug 2023 20:53:03 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] target/m68k: Map FPU exceptions to FPSR register
In-Reply-To: <13b823f2-ab77-3456-1c00-bc9b8880327a@linaro.org>
References: <20230803005534.421387-1-keithp@keithp.com>
 <13b823f2-ab77-3456-1c00-bc9b8880327a@linaro.org>
Date: Wed, 02 Aug 2023 20:53:03 -0700
Message-ID: <87jzucok80.fsf@keithp.com>
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


> Good catch.  Mostly ok.

Thanks much for looking at this.

> No need for inline markers.

Thanks.

> In general it is bad form to call HELPER(foo) directly.  In this case
> it doesn't hurt, but better form to reverse the implementations.

Good point. I had copied this from the arm vfp code which flipped the
order. I've flipped those around.

> What's missing is an update to vmstate, to make sure all the architectura=
l bits are=20
> properly saved. Add

Yup, thanks. I've sent another version of the patch along.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAmTLJJ8ACgkQ2yIaaQAA
ABFozw//Tms8EZBUe5TO8mWIQIbTFdEHogIlwq4FlZw0zVT1X2j07BX3WBlC9kHq
Uup00rVzERdcJTpYXCLz/0Mds8JDm6EfR2Eylw/QilpUFQblYNGFFBa5qhhHYxHR
h6XXvdwIbDq8na0dd8ev9l45jQCwlhzXlns/zp/bAM98IQj0wdOapm3ulwOAMjaD
/UQStPEU2LDFRVN4QWc9zhPT6MBV3ORI77HCP0rBedyYDJYyINOGX4KfrPFE2Hmf
CpPDxmLBDIiwz3cRacynoTyKErvFAgKgYurE5IidiRDAN3vaeiXhUUsSmFjUUxbT
eZm6HYTFdpvLXGatsHlzWiyFfFd1ZjAPZrCoBxpZI9riQG70V6Sp1jf2NkcHkFyt
LHdQWpc3AQZgpz3fmpTmI3VcWFJgA3RTxuSMOaDxS9OOBCRISoDyy7WALho6YxuJ
35mprZawa7da9KjKA5fnINRUWuSwf1pTz1610zCID9W1LqFidF6m4CJDUfMCYuTu
PoWv9svEC+ArDNWasrtrPFZv4nP9CSBQj9pGSgk2m7lA1EVjQmj23QTHwssShTrO
Zcpegjvivlsb3VGekJz1twDXyjMyR9q6GmNdxV/WaIM/ua8V4lOFFx6be58sujDS
NT6+VJ4hrGJvuk1jMgcY8XeLsVbHhLeW1uW9fZHKq3Y3o7GgfBs=
=aqI2
-----END PGP SIGNATURE-----
--=-=-=--

