Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C673ECC7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 23:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDtcR-0006JW-JK; Mon, 26 Jun 2023 17:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qDtcI-0006Hn-Bg
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:19:27 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qDtcE-0003fy-DP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1687814354; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=hTJCBdkND0+z0biJCn1S1yamaOFFq9MwBPlM457hYZqSQqnS0+4df9GxCMaWRBIyIo
 9aEuCVRPM745wXq87+gt90itzWvc031C0/aDJPo2bGqK0sI+lNlM470/WcDlQn8o2X2n
 /Su/yr6F7QUZVttk5kgJBg52kEv4MRHRIVfg0BhbtVxP5+J7P3+iyIbh4uXJRXnRNNT7
 SnLGnY8eqqzbedmO2cgHKCiERkxZpngIabllGwlzRU3d6636cZXEDLTni+dfc1HSAvNU
 BoGbgx4EcsNeh20Gd6noj7XRBqzZ8F50ZF3LI1TyWxdgZpGoziHD1DpXS2YHal4yT0R9
 RQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687814354;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ZVP9K9M74+FeliftJ4CR3Y0x5CVjLjTW3Jxl9061L0o=;
 b=Beb4QRo7tQE0pF/u697OkrNMIPbjm0FDYqmJ7GeLUWA1cjHgkjkKA50ovg3hOKSMzE
 P941MnEi2B1XjwFMELMn3XMGRek5VKj9/Q6ZG+/c12cg2k874+/tJYaoscPG0OSuEYB0
 yZBRPVsRs8s2Semw1cE8UMDD2ZyyS6C4GVwOzWqKbjAkX2Htq/10ZANkczERB1MRBTZH
 YgJRiRKjFJCdQLzzZGHtS0tKWI779WdEDhp2EYYnMwlOI8OL6HXiGtxzlbNxSsDSqTbE
 3zBKeG9FTyvrvqcgnGOJYidsznZGbvpBPb8E5/Xdye4FZerQ4HB6RKdEcI6jqfek8dbu
 FQFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687814354;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ZVP9K9M74+FeliftJ4CR3Y0x5CVjLjTW3Jxl9061L0o=;
 b=rWjQfRiZYN0Q4gbSfbGfKiEy/KVuUvPCe2gI1lxDuwU/BriBp0vnzR0mDwTw/yERu7
 Ke7qC7yujA7uB0j6iYtSuZBD1sL4PkbgGSWn5QnYe8Vp6ti3twUyEJsoGEZdPIK4iF3k
 BVlTpXHkTuBApILGZM5yaLGxEBHe+E7S7J80lAf9tw+HEhS1IQZNdf4b2wUq39h7w6PS
 7Sm0KUnuKRybfs/IlXLa0YOtpp3xvRH9W8qGxPm5x9esFiZ2OO/cb0q86ondQ+CLaNgZ
 iz62G+ZmgLKtfbVby8uZVaPRHyo0xRzvW/xWt+5+KyReOOwHPnOSVj5qbbimEWfft6fU
 ITog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687814354;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=ZVP9K9M74+FeliftJ4CR3Y0x5CVjLjTW3Jxl9061L0o=;
 b=3JwhWAhuMMQsBdLBhJY81reAq3TQL0ubmzW3pxfvABuzIcnhTRW9rYhDhg1uqW4DCr
 tG0OGFJmTX7bCgrp+1Bg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXWiuRyeUQh3GC6w0BTiV2X9kN/WAr0rdTE7oY1qJzPNA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az5QLJDifg
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 26 Jun 2023 23:19:13 +0200 (CEST)
Date: Mon, 26 Jun 2023 23:19:01 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini
 <sstabellini@kernel.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Message-ID: <20230626231901.5b5d11c1.olaf@aepfle.de>
In-Reply-To: <20230509225818.GA16290@aepfle.de>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fVb/B18uuY.hGWIv7Lfyb.S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.219; envelope-from=olaf@aepfle.de;
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

--Sig_/fVb/B18uuY.hGWIv7Lfyb.S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I need advice on how to debug this.

One thing that stands out is uhci_irq().
It reads a u16 from the USBSTS register.=20

On the qemu side, this read is served from bmdma_read. Since the read
size is 2, the result is ~0, and uhci_irq() turns the controller off.
In other words, memory_region_ops_read from addr=3D0xc102 is served from "p=
iix-bmdma"

If the pci_set_word calls in piix_ide_reset are skipped, the read is
served from uhci_port_write. This is the expected behavior.
In other words, memory_region_ops_read from addr=3D0xc102 is served from "u=
hci".

So far I was unable to decipher how the pci_set_word calls can
possibly affect the outcome and the owner of memory_region_ops_read.


Thanks,
Olaf

Wed, 10 May 2023 00:58:27 +0200 Olaf Hering <olaf@aepfle.de>:

> Resuming this old thread about an unfixed bug, which was introduced in qe=
mu-4.2:
>=20
> qemu ends up in piix_ide_reset from pci_unplug_disks.
> This was not the case prior 4.2, the removed call to
> qemu_register_reset(piix3_reset, d) in
> ee358e919e385fdc79d59d0d47b4a81e349cd5c9 did apparently nothing.
>=20
> In my debugging (with v8.0.0) it turned out the three pci_set_word
> causes the domU to hang. In fact, it is just the last one:
>=20
>    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
>=20
> It changes the value from 0xc121 to 0x1.
>=20
> The question is: what does this do in practice?
>=20
> Starting with recent qemu (like 7.2), the domU sometimes proceeds with
> these messages:
>=20
>     [    1.631161] uhci_hcd 0000:00:01.2: host system error, PCI problems?
>     [    1.634965] uhci_hcd 0000:00:01.2: host controller process error, =
something bad happened!
>     [    1.634965] uhci_hcd 0000:00:01.2: host controller halted, very ba=
d!
>     [    1.634965] uhci_hcd 0000:00:01.2: HC died; cleaning up
>     Loading basic drivers...[    2.398048] Disabling IRQ #23

--Sig_/fVb/B18uuY.hGWIv7Lfyb.S
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSaAMUACgkQ86SN7mm1
DoBgzQ//QQAr3EXzx2IZheH59Coe/CRrgqw7mEhc68l/67kzRTFXXFq2hTwyeNz/
HQMsl8DwIycsUUgYOWfXsXBJAeH7ixW7Y4bUz4Dnt/cuR6ywCwo1TDbVrJ/8Rx3J
Zd4LGpCMsg6vdYIEv83V0+abYRO8X0k9S4ZLoesj42bCjHH6oCinQxI633s6hGXN
o101pN9PB0Zp5OWeLaqkd0fnJMZYuIf7BEciOqQHeg7YrKB55VQi/yXXxwogrGsc
NtwzTI0PvjeqQFMUxHpQuFaEEnEuxFSRjrGO1wZ3l4Mrx6ZSs2Q5OHqDQ2PGB7hk
U8W8FX8IMcuU2fYQkF8JW+f3583RCWNz4JcteWxqD5TJaneBxK7THuCXeFdx8yhp
oSE3qUUFkeFzSz7goy69bv9iv5nMfsICP+TP7+SQf3tJyoVYJ4Afaez50GeBazBE
fMJ6LJfwpM8Uba2UN/8qaXcq8Oi5r95OIVdFQcqp5/ExLeXkKyltRz+ESJ01rdSC
6sIfdL5dzfvjrxxAlmAwIwyi2r1326ZUewh/HLV2dpXDHtXNYaogbmPFXMMTbFlh
9kHBh7hmfhFVbpsLKR4wOB6qU1kfqVJF9VQ0XHyB8nmTYFfqOb24yR+NWC6yDu2f
xHbZEVFovDRZaRprRwKEKxsvp1IZhcV4Z6lzoCnCU1iITT0Iu1s=
=XXoH
-----END PGP SIGNATURE-----

--Sig_/fVb/B18uuY.hGWIv7Lfyb.S--

