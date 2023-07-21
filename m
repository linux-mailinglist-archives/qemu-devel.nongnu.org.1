Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98C75C0C0
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 10:05:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMl7u-00088W-2s; Fri, 21 Jul 2023 04:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMl7r-00088N-Lh
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:04:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMl7p-0000Mt-6B
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 04:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689926669; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=IWgfxTiV5/ACGxXxocmqJnhJMrvFK/H4erA8CJwqDF43qskoRjePpfJveBrGfKu8x/
 ut3Y5TtEnl99NwHUbIwe9w/QXYWe8enJNlNaldXBheGhC4Mu7PvZgmd5VIw72dXCaUbd
 D2Ecvw5yaOOYXZ/Y461fwb98iTNz9HetbkQir59f6u81Z9ae5zBWRTcwCLKvFWyAnkMX
 sOpFDo1MuPrZrd58pwtEOycViPUWRTjKSjDmYjxqFxJrUMbFj6nws9bLOVotPIVX2gdI
 UWhREZr0KY2paj7aEE5Ad8RGk9rLDH8XQdBquvD9FvyQXUfuV5QseMcjXIgQ166Q8feM
 dSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689926669;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Jw9fSAbkwan7OAS0uGX34iroOUcPGJBQsOsT51tiYKk=;
 b=bLHwE1aHOqJL0xGeZd3a5o18qUqXxx1hmViFJooB3ss+pK4xyU4a+Y0LwsKOKS0+oK
 4UBWV5oBEDPiKO+R63YsvVkohvkaEjFmlRs2Fn3D8AQ+D858ryqosPyNNU6uhC48cZq7
 L8BmcLt0eSblVN1aRLvmE4Yc2YNNKzjjPdEdgTLbN8c1En4XIqVvvaHKuO0EoqEzM5MQ
 JDKTcgt3EG9rhmnzcLGrOnWUnzTF2YvBYyLadaHoszYO8QF19J9iojqsEVsU1mRz24V5
 E37BXv7n4GG7uOBSX4H5evfrpUQ3OmmDVmk/56lydU2P1v2miL3/5Y9uAMw4ta3kvUp7
 QgKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689926669;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Jw9fSAbkwan7OAS0uGX34iroOUcPGJBQsOsT51tiYKk=;
 b=IXzS/h1335OstW/4yl0NLwNPKuHN3sM/dtiYXdBzw4gVoZGRKCOs/pbuHzUDWh6W1V
 H32vhVukvhewHTCJo4R6/IpWf6X/T8/4Pq7JYr/4GXRuRnlTBZD7qAYggRQE4MWpapFa
 Tz8A+q18C1PlSAORFVJEpK7YkRGpIqNkD9c1iV/8YJf4UT5LOqqpNjWr7RlXGWWHwJw9
 tbe5s8LcWz0B/CtRt2j/aQ+gQATjSpY6G8rdNEyujNzthaAl08FOnTY0/MzcmDqa312V
 e/wgo13SrTgbFCr8x2cWBT8oNy8Ese+31mYlUJJab4qjPX9P/SgYTWzd+RDCND9/8tGY
 zY3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689926669;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Jw9fSAbkwan7OAS0uGX34iroOUcPGJBQsOsT51tiYKk=;
 b=tTHCC8ltwqXcDmQ6/YKBw2WwmiiNcnxqet7Rj5FSTyib0eNmCZphM28WWisg5fzcIe
 sY39tBZFJZ9CRvTUcKBw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.4 AUTH)
 with ESMTPSA id m4dd28z6L84TCOe
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 21 Jul 2023 10:04:29 +0200 (CEST)
Date: Fri, 21 Jul 2023 10:04:19 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: 8.1-rc0 testfloat fails to compile
Message-ID: <20230721100419.20b253c7.olaf@aepfle.de>
In-Reply-To: <3e350fee-a54a-f7e6-4476-e31f1c3d0430@redhat.com>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
 <20230721090359.1b9797cd.olaf@aepfle.de>
 <10e95d52-109a-d683-a9ea-2ab9b52e795d@redhat.com>
 <20230721093513.515b2306.olaf@aepfle.de>
 <3e350fee-a54a-f7e6-4476-e31f1c3d0430@redhat.com>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rbSBBD+s.stZWPvCH7zs/kD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.54; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

--Sig_/rbSBBD+s.stZWPvCH7zs/kD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 21 Jul 2023 09:53:51 +0200 Thomas Huth <thuth@redhat.com>:

>  I thought that -Wreturn-type would be part of=20
> -Wall, but apparently it is only enabled by default for C++ in my version=
 of=20
> GCC :-(

Hopefully gcc14 will fix that, and others. Only two decades late ...


Olaf

--Sig_/rbSBBD+s.stZWPvCH7zs/kD
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS6PAMACgkQ86SN7mm1
DoA+PA//VnQ3XpIy5lFZO5VmaJbHx80WTD5dmSejQ65s1BvWhmwt5H6cuWUjouR6
hjaaA7QHsxC8n0304Lcvc32gDxFoamgEQj0RquWcX7543oibXT+LdzgjjZSZIXoM
v7aU88rixzSVr/ieHdpy8CRJAVS6JWnx9YZTsXGWTTZHr+rAISzoU06PwLI8L4W7
+KqDtVurI/gnxRFpswwhlGm/9uJVH1vGhO8sPHP66bFyheyqNLQudrpArv14mYtu
6AQ1XVhEZcHDGdBqMqAg4I+QSs8UAt0DH3u0ypIwv0QYaGutxLd0l57vI5GoCZ8p
WDGo9zHZNKJPLibkInC7novblVASgnEuukpIpTVCDIhK4tD0z4BlUOI3wwod0ENH
Kciv38zzISH/QGgVh1v295sZbHUm3jV2wpXVtmiAiT0KRSeVjz2OBZ113fs+8Nrk
+AxG3j+dro/kX8yOu9CPl/ARrz45iuQthDoi3pXsex6K5u9XxdfR2OYpOW6jfVlz
lY7wUI34yP6b2O1/hvtEYaWC71ea0nnL+Y9bUiXGzvWQ1riJaFpG7tGMS939iO0b
0fg8DG1jiXhlCLo9ekTjd3kRWEbBPYQmXykKLSGODcvdU1YGNojopecG3ZU0CEZL
jHr8qpAiaNhHLeybogzViUgVHWa8Pz/ZqsX/wmcMzeWXjuF8WWM=
=6TVk
-----END PGP SIGNATURE-----

--Sig_/rbSBBD+s.stZWPvCH7zs/kD--

