Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E51E17435C6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8Zh-00070U-Gy; Fri, 30 Jun 2023 03:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qF8Zd-0006zu-IV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:29:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qF8Zb-0000X5-EB
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688110164; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Gu8Bi3ERzgErl5CIxwZj9d+pFxVMRa5swwyCIoniKJ/yaLfJy/Ao27iDKRE0Qvb6cK
 hGfLakMGWgySPEVEV7LlInl3NiJlSFZj3vMWk1cSPmc642baxMZ9DCEsmuUBGpQpJNF/
 4psrzxdE9jNGgKkN9LKC3HvPOGPntlr+6jlnD/QGOaulrVrMWe7LnXiazbo7y015ok2I
 3wcoo2Ry6hJ4NYMQo/8uNFefqob+CtkSelNrxsKkv/xFpgdNhA2LNoVR6vXqnhwgideg
 amX9nMPxl2jMuazy2jPhpjdK/8gfP1WlJRoCUT3FR8YyjzC5VTrD14QZGdTmn+x0tHaq
 XuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688110164;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=SbrWWD8/bSxrp1AiIlQ8m9gLXWJfqf48i1MGfG4Pems=;
 b=WWoZxFlgXeI2qVE0i4jTGEa35VJ37LB9M0euaNabdwLLeR5lUB9D1rJdOq0Z6i9Mja
 3N5FNqP9IOPZYwQByc2d6DS+qMSa+ZLgT6Ce34OTkSW61wptEZ4XK9AFIj4bKTjjxj4o
 N9ZX9+fR7+VD4isUlaIMFMeUFGdBPpkWV0u5QW8Dgz6k/2gtJhFa5x+13gqEvF+ugLcj
 mdxihfmoO17d2C268jr1Ph0AWQsR6EGfWS3EK8ccNy0Ggna/PQQuLvqPFVGygxJsQ3oR
 R6GWFcpRNJ6dIYBbopZDCLoinbEHaCFDsei+z/GQgPOocKfQP9rOQdrbEjT24xaPTgiy
 IvWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688110164;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=SbrWWD8/bSxrp1AiIlQ8m9gLXWJfqf48i1MGfG4Pems=;
 b=JCbb3yVKpkntRc6Rxtb20t3e2+oX00vK//Lx4s27CTuXm+fPo7KGeWN+A8/8UxD0+t
 UkLa7i73Y5Buw5tb9rmhOkP845X2gyzrPKEaq9Jz+MUR/a4P8PYWTm3Z5rS9Jh18fybp
 lXmel6TGrcxGRLQ6nITdJtkJf8nQ0HHmXzBo5961RxVApGfQN445mN7tBK5rzExo121j
 0Qpg5GgZWoqewrU6q+VLACXzBeTyU3JQ6YM7tVse/gZnqapAES6Yp8m1gs/22sIpleS6
 5WwSdkOuCY5ghCMhOaEuT/3Vbn3BHRLgYUNbyau2UcbVJvk+zEgss3i8MijVONDFfGEe
 xhZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688110164;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=SbrWWD8/bSxrp1AiIlQ8m9gLXWJfqf48i1MGfG4Pems=;
 b=oP9xFqEZ7LmsltzPogNWnsdJ7Ll5YyTRl9m6DYBBgwohFe6R3RotJK//dBcnwbE/op
 rVkAOAdmYPov8wrg+KCw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXWiuRyeUQh3GC6w0BTiV2X9kN/WAr0rdTE7oY1qJzPNA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az5U7TNwzD
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 30 Jun 2023 09:29:23 +0200 (CEST)
Date: Fri, 30 Jun 2023 09:29:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>, xen-devel@lists.xenproject.org, Stefano Stabellini
 <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Message-ID: <20230630092921.392b302d.olaf@aepfle.de>
In-Reply-To: <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de>
 <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lmjCe4VHwkOw+v56guoEpxw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.167; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
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

--Sig_/lmjCe4VHwkOw+v56guoEpxw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed, 28 Jun 2023 09:27:16 +0000 Bernhard Beschow <shentey@gmail.com>:

> Would you mind sending a patch fixing the BMIBA register to be reset as 3=
2 bit?

Will do so next week.

Are the specs for this chipset available, does this address really need
to be accessed in quantities of u32, or is perhaps u16 required? I guess
for this specific bug pci_set_word may work as well.

Either way, commit e6a71ae327a388723182a504bb253777ec36869b was wrong.
Does the comment added in this commit mean, the quantity is really u32?


Olaf

--Sig_/lmjCe4VHwkOw+v56guoEpxw
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSehFEACgkQ86SN7mm1
DoCf0Q/+PAzoc0MsFKTaoPSLnN5nLei3muaIWh8tFlvsvcEIuAr0TK35+NMCwRKg
carcbr5ImHOTemPQg7hFEqdujUOVKO6GbqBN3B4awq7nCCKJKbWg5qU4u3Zw45KQ
NO16omwctt7p5FLhJIIX1Um8QNUPiZqjrbOgIo+ZLgxrdT8r5mMitBY2E4jpSdp7
wyzbXN3h3CiEf8D9jVx/dHorAadvRMI5hEPpRGErIkptwezUohF8h5rg4LGL1/HS
EtMa7Tj0PFkSHYMy6UkOok5IeMH5lP1fw+1M/0ZsKK/z4WtTvNz2/03vL9WG20E7
H/2LrX2CTDRUCotUABR+GyaYoTnqYlgkLhql4JfOah1ASkOwXNyaZLrQXKhqxVUc
TFa79mFelfB3fo5npaD9DaIR6y1v73PaSXJ6yEb1GL+prZfRVSnBeo7rh5Q/KPh+
VGncAwj1flxKLpgj+LmQjsjU7C3rENbvA0qVxIspWqKnRcAHwWndDnimrj2H7Jwq
/bksP3Xehmdhe7w385496aD794c9zZTIqWHwyGfzNkGefExXfFuuZt6hHQs61AIv
YdUwCm6Q2m2FpnuZnNhmXZoDd/274ucoN5TAMB57WeQr+MR0ATtXOMifhhRbYuvK
N0yGPQC5i7MrOTUsuc0CIw7k6oSaePRMWFdVQ45iyJw8u4cqp4U=
=teFy
-----END PGP SIGNATURE-----

--Sig_/lmjCe4VHwkOw+v56guoEpxw--

