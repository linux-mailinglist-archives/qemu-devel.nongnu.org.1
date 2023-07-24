Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECAE75F67B
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 14:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNupc-0003fO-Og; Mon, 24 Jul 2023 08:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qNupX-0003f7-Lu
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 08:38:27 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qNupE-0002jK-KZ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 08:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1690202284; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=K6zRgf9v5twC+KIc0BGtyZHkdyZWwzfW3QwDcZ8JVOOMHbtg8/VY7w33HXo/d+VJrk
 0ZgSf4eRkxDTObwMnhvxJyGnAQvLkUxNUqIQ7nCx8jz3erHrwlIIuGhPbjPwpfUQ/PaE
 LHLQr6YMBFh0+hpVvdNa1fRDCn9wK9K7yNL0c/3te9VrDVNs0uY2eFxiLCLLrQQQI0aX
 sSV36M9lRJqLZfi54bYehoDLIrIfRuul4X+sJnUviisDTlkKahrZ7gMonNPzBVLD7wfQ
 MwTVYamNRuVHyFYSDTt0M7KXHTsmzzD551wTAQIBlYyxoBX3t2+eT7O7fAncPsKldMW/
 ed/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690202284;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=OFBb/lrajuSsWPwiFj2QQpCQGCcOdAkolI85dERVWv8=;
 b=nilN9FLHBONvYRYWu7PqKf9LCngzdyQX2ScRV3X6z0dRdH8fL/vv0J+jGpAq+QQnP1
 n+XtJsUHIVw+kN47tGcHlX//+33Ws2MF0kiuCRQN0Xaw+NH4HkHB5IQW2foaYJ4wBvsb
 Fc3gGGDQr/2aYblW1Gk0Vcxk+ChCT2rLmN1uS1XlfvQnSHbaHtxAyb40H2WRnMxXaKGL
 Qb6C5ydrR7khgpiADV+Tavc1+oQ8Nldtt/k/ABmLe4tN/S+hICPw5Srg8D4poT7JNHhF
 snMidgPAZenGWMpEXmev08ABEMk+qd9IpP3xDzX7otvKEgNGZrI1Wb5RCgKXwqks49tj
 kSsg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690202284;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=OFBb/lrajuSsWPwiFj2QQpCQGCcOdAkolI85dERVWv8=;
 b=oBKHY93JjrTIebRy4Ipq7pgj50IuoZ4eXEYNtdem2sfv4+mS3XidP4U8Cd4mHU7P86
 DcoR5OIkLQszKNIjF4n2dMA95RzASQxAf0Ls/3aP2CFp/qZjfXbUVWG/SQfEXPBke3zq
 Nxph8y27/6XBs9HkPadSRXbY4WG4DdvltgD/zCo1Pwi6Fqt4U6pl/zTMpLOxU20v4pI1
 rRJ8MuRa/Tn+n1eHCC60PM3ANB7R1zfeCg4DQlAS9nLsGUISZSXGW5brzLxgc9eBADPN
 OZ67QJg8lt5O/4m9xFYG3tO7f7B9xR/f4hy3Y9zY9G6cLZ+V1TssnnXoZLW2XCINc5A2
 rP9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690202284;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=OFBb/lrajuSsWPwiFj2QQpCQGCcOdAkolI85dERVWv8=;
 b=IfrZpKf+ayKqyYD5cXNRWcvqp80flJx15uEdWD8raFsUSGy+kOILXKoi8KzaqeQcpS
 xBa4D/4zW++ErJqMRcDg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.4 AUTH)
 with ESMTPSA id m4dd28z6OCc3MCK
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 24 Jul 2023 14:38:03 +0200 (CEST)
Date: Mon, 24 Jul 2023 14:37:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: 8.1-rc0 testfloat fails to compile
Message-ID: <20230724143753.494cd3e8.olaf@aepfle.de>
In-Reply-To: <f2beeb1e-fc2d-9fdd-303f-d1722aeaf63d@linaro.org>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
 <f2beeb1e-fc2d-9fdd-303f-d1722aeaf63d@linaro.org>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l/LtV=WxNsyKmu13t9rA4h9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.216; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

--Sig_/l/LtV=WxNsyKmu13t9rA4h9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sat, 22 Jul 2023 13:49:40 +0100 Richard Henderson <richard.henderson@linaro=
.org>:

> If this is with optimization enabled, the bug should be reported to gcc b=
ugzilla.
> The compiler should easily prove the default case is unreachable.

This happens also with -O0 or without any -On, or without -Wall.

https://bugzilla.suse.com/show_bug.cgi?id=3D1213600

https://gitlab.com/qemu-project/berkeley-testfloat-3/-/merge_requests/2


Olaf

--Sig_/l/LtV=WxNsyKmu13t9rA4h9
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS+cKEACgkQ86SN7mm1
DoCXUw/9GqE3i5uGpKRQZXB5N1CbarO/et7r4zO484Pf/41kGCyoDd73ysPWDaXx
pm0C4GOR9n3Bk0t6z/1Wd9tTrcws4tHa97o+sTAcN0geGtWOEWz8uzvdFCpWRntq
tykbI0CgT2HitOIZK6/Uh7bIvqLGaQnhvnQLpugNGYXycw4odHhUPb3933BCG9Wm
VLpn7acjQJ6kT11hTwh/SuYxgdN+sHWq3zhnJTnccH/hkb8DvtCJX9k9T/TTlI61
YoJZifaQlazc0CjCoVz/v8CsoEM0rVTqrbyOKWs0JPaRlW7x3vhLQcTUtDYdbzga
bWNl6i4MZkGwr1HIAZ56M0cR4+zFIcrcOHQo6+sMU+MVan8yTVip1EGCjGuE2QdI
cPPFv9sUsw277P21x1ZtqVXjM6CQ3vXTbJ2ASGWy8iJsRhnI1ziBnGWtITGVLcqJ
3RM1dylb1XDA5y4TMTbYR7IAJA3jFUSkdxwn/k3cR+sV2mHpYVsHRfp7elyQfZuv
LmpfPsIk/+7TsqsTB5HKzN9bBUENESWqXCJ35FJ/gVPQUEZIV0DbFtsN99mUSuqH
DQ4tRR1lDD4NGCKfnhPRb226GWXzxfICXDDcRiwK1kj48Khvw+1BWWOCbRDH4Z26
5343xk2ZfR0HK/Ti/bHHxOVbSmAXHDHFADDrlGAZz981HXpfMn4=
=yl86
-----END PGP SIGNATURE-----

--Sig_/l/LtV=WxNsyKmu13t9rA4h9--

