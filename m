Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC47B79E9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:20:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnx6Z-0001hu-TM; Wed, 04 Oct 2023 04:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qnx6W-0001hd-K6; Wed, 04 Oct 2023 04:19:36 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qnx6U-0007bQ-Tb; Wed, 04 Oct 2023 04:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1696407569; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=tvz83TXIEx0hFQOoAZRE+7287uJufZ6/n0k25K9ZS7KLXeolUMh1OiaoFa8SSOv6ZK
 eAHjSZvNX9Hx+ibCfcc0C8lSwZHPORS0i7XN7nGvSM0MmSWDeNtHxP7EQs+GokUz7boA
 vUAYGibUOVHioNIwPw4RULfuXmQB5bc2g31xzPukK8uQ/VAam34GdGB/W8CpB0iajIAK
 GFxKzcMoWbjJnDHwRfaSxlY2qAb0rnNI7zXzCdY+UfoDke3VaRJ+CerDrDwDFTAqHlLt
 AWmYnk0nE1qK0AJuZQn7fd5sKFUFPACUB7gJ4F0qNlz44EO3OIMXSY43o0VzWZDYDG92
 T/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696407569;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aQuidPncmYrRO8veqOkluDv72olOAQAJhohHFSyIcCs=;
 b=M1+uZqGaQzwuwH4nVVkVpKT7988jrFPmMt7MrfpUs01kGFr9U1NagTq3faalnPMsh+
 Aj3j2S1XPZbgit0vhAlWyuoXk9mQjQo8WwlfpJ39KURRv8HB52PX3k57jSC8bn8XDogr
 0QITL1yRZTKnLdaasYfLXMl1dXWRNQSc2ZI+KkSk9Qe7nbLp8iqjqok++Ka0ekNRUVCH
 D8Npi8VeoNCQgcTaNI01TCfu9+fj0BHRxkCv27ANLYmDCWD5Y/z3MHR2gyG3l5HUQTzg
 3pGxJX3rmzLkX3cWVA5+x25ZKK+Fn9jCdmwiWC3lqMY8sQ6Cyh55KBCfJyWOF6LL5gYi
 JgJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696407569;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aQuidPncmYrRO8veqOkluDv72olOAQAJhohHFSyIcCs=;
 b=YfH8K9gs9dGEeGCGCKfJkWv84lhSxi9uLKkfwwZnTUF3o7JO3pSc2E2ejPgoLBIGvV
 /aJFWEcAjoPcFVXgEKhcX7Ztxama4CKMwpq1uBbJs6kYNSR4Z1MKrnBlO0BpSGN+vH1h
 ImIF8bP38eMLEgw5NmJlobJpZGs5kc7FqTG+V3wB4Yb6jbRcJGC74FevkxVNsuUUc57P
 kT/fQGmKe4Edp+p36f4zPTDAWdjEXlkPlBCLLMEDs/qO+iUrCp8ZbfTe3fU9ij/descO
 m/iTzjN7PxXvYxWYaA3gndeiiRDd+g6QMoEAcNIiffxcfnYi8DjgXkOI3zd4tvkKQCYT
 lwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696407569;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=aQuidPncmYrRO8veqOkluDv72olOAQAJhohHFSyIcCs=;
 b=6C/TW5uWTvCp9Blx121WKOqtfnhhTE/UKF68v9is3ili0EkzOXPSGss6C6tKMr6yfM
 TDMInUpw9oFLjhLTmNBw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4WhOIYxjs6IbxwdWV2aAyqkbNw03IRPl3Vg6+Rg=="
Received: from sender by smtp.strato.de (RZmta 49.8.2 AUTH)
 with ESMTPSA id C041b2z948JTuh1
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 4 Oct 2023 10:19:29 +0200 (CEST)
Date: Wed, 4 Oct 2023 10:19:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-8.1.2 00/45] Patch Round-up for stable 8.1.2, freeze on
 2023-10-14
Message-ID: <20231004101921.03d0260e.olaf@aepfle.de>
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
X-Mailer: Claws Mail 20230817T113819.a897c59c hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.XJEj21Q0fz4=3Ixy0wkxDn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.21; envelope-from=olaf@aepfle.de;
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

--Sig_/.XJEj21Q0fz4=3Ixy0wkxDn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Wed,  4 Oct 2023 11:01:21 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

How about this change for 8.1.x? This will allow usage in openSUSE Tumblewe=
ed.

c01196bddd subprojects/berkeley-testfloat-3: Update to fix a problem with c=
ompiler warnings


Olaf

--Sig_/.XJEj21Q0fz4=3Ixy0wkxDn
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmUdIAoACgkQ86SN7mm1
DoB5Hg//akUmOELMOTXv6eQAB6mukZZl3wSTzbBQ4Oe4wjd+6KNlxUH5yMyiFa4u
7nUH4zQGPivtIYdkoeMLXwvhgxdzXIfHjbtH3TttblrL6z3+iU9tKXmkorWIOHch
N+H/lCsQyMZsERMxomJN80J/ZgNPoAM8CzpRjGGd9ZMeZeCFqm2HOytpqcGPbjNR
W/xzUYumjXnj5gTXiWzCV5qugTODd5ctKySzUsdwPAgCIrwuRN7MOYLP7aDTCBU8
A46S5jfZpsdO8Kb/ibGiDHNOt+/WHn78x8w6BcX0SaEXLZLV1iV2b3HArbm9TBMG
I3fftcVJsxXWRYiIkS43ddUgA+yLE3e3seyw0BYyi3QkhGcPeFCPe6WGz7irdRPl
qGC8c34ehL3w1V2n0FgFPpQ6WMlw58VApN3L6I/yPDwtjM1bTvpwy1vAzAGz3+rq
IopYI/EwRlNFWTvfhOHWCsCXRWO5Gt5EKtcJNOaLxR7U4oQeC5EDftjPGK6c+s5r
QMEWZBcs/nnKHWL175ALak0wqxyGZOaUZJazj/3S5Ns0Ao/c/VTaYUJlhLz3Cjwb
9pr4d3qiiauD3uIkGCdUoXe1mGAvLARVx9VvUn0HjuGOIvwucuDAEp2EuZnxEQkB
jWPB2kF3IllkLTqeG4SpjnyczafDZ2OiPEhNXUp/SC0jQxxBTzI=
=GsvY
-----END PGP SIGNATURE-----

--Sig_/.XJEj21Q0fz4=3Ixy0wkxDn--

