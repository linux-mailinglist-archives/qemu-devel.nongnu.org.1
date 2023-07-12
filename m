Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB64750143
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:21:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV5m-00042E-R3; Wed, 12 Jul 2023 04:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qJV5e-0003sc-Ly
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:20:53 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qJV5c-0003Vu-S1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689150044; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=IYdAjgbdg/uhZAPzi6Ae1ahI0DgsVc9o1VrphoF7zSeMTK04+YfN+06fKblqYnvWms
 klwYdJE+h+K5DAFr16ZfbkEVZofB5OS6vedJgtYQJjoy8IPon3vk4IJwjQ1llme7DoX8
 HD6TEDXaHStoPz/oyldVhL22GnJ/8qZLHzpfIbBqTwjfKBu+NyphstnJ+5cySP3asT59
 tM6NGbXcJ3sxTnvGNMxeLmKU+FoVt6y4NA+mRXRMVBYKCO5dB/hceQLM8p5f0CvqRpmv
 7o2xzS4rd7Gt9gs0snaVsv6KciQTgD+BoeP6+l8UWVBaDR50RsI6oEg0hQoPMeWOYj34
 oh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689150044;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=6Kk79mCDPtijU6pwihqcMvyA9gLfe1ha1lKS1grzta8=;
 b=VRWoQFo2KZcH14PAvfnwx8WU3pA49fdTjf0dva15g9bO6xYLGOe2IUiL/7g6mxZ+6/
 vn9dU8TqshpmyfTfI5m80vv7/LMYTmhKRqRS+AVogQAzjraVprJV+JWn3VzfkqYWqze6
 9nLXVKbxdP7YfRlyeJoSgWqirhQpQPF25AiNKgkvppxV44efaF25vDUZWF1O1JdcKsoc
 /GoMYxnabJKJ1CSUJ0ee3RRlhJQE1ItC9SCqXJsQrRc1vvIaYQfwBRS77+/y1whUkBnT
 O4MSNxHKmtin2PKoN7VtygvMRaKIRzn58gs0ky1jIYjcpyUC2yuXho4tyVfB2jgYrZ7I
 keqA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689150044;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=6Kk79mCDPtijU6pwihqcMvyA9gLfe1ha1lKS1grzta8=;
 b=hVQg7u5pvidIwiPPXbQkF7OrU84ywZOT6M8ohPfh2i4UkhV7Qo9+w+zJ6ik0S/c3WC
 L5SqY4Bsg6NMIvXWQWsV1YTtHzUvM7RY21INjGiEtAG4sQzQ/8cReFopcfse0Ne0fPqU
 aooyzLX3qvwr+z7YFMukqBtBdIegTpF9T1/N5alc2Vc9vBPXEXFx9/OS6wXtVTtrjI6n
 EDAyQhrNe1QFQC29HRBivTIj6lneCLlgLqIRbzFvoBOy+4vx952xjliAXSXm3BM+7HKS
 gqP/fyxWuMkvwnE1tBlC4tU4KGsJLsp9NcWM5xDmCVrr/1tirNrdsEb9nM5hY882Z/ky
 PK4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689150044;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=6Kk79mCDPtijU6pwihqcMvyA9gLfe1ha1lKS1grzta8=;
 b=V3Iy7SJzHlgb8VCwVhluGqq/QUBgHildyJore+2wQIgrYhWcDH2zR3qqnSpskRUrE4
 GPcwwotHW9/Es559WQDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az6C8Kifk4
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 12 Jul 2023 10:20:44 +0200 (CEST)
Date: Wed, 12 Jul 2023 10:20:33 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] roms: add back edk2-basetools target
Message-ID: <20230712102033.771e2092.olaf@aepfle.de>
In-Reply-To: <20230411101709.445259-1-kraxel@redhat.com>
References: <20230411101709.445259-1-kraxel@redhat.com>
X-Mailer: Claws Mail 20230706T114334.0dc50f72 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lNeE4kK0oH0Pqq=A=NvLyzS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.22; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/lNeE4kK0oH0Pqq=A=NvLyzS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 11 Apr 2023 12:17:09 +0200 Gerd Hoffmann <kraxel@redhat.com>:

> +++ b/roms/Makefile
> +edk2-basetools:
> +	python3 edk2-build.py --config edk2-build.config -m none

I think that needs to be $(PYTHON), because plain 'python3' may not be the =
required python version.

In addition, a global EDK2_OPTIONS may allow to pass arbitrary options to t=
heir build wrapper, like -j1.


Olaf

--Sig_/lNeE4kK0oH0Pqq=A=NvLyzS
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSuYlEACgkQ86SN7mm1
DoBQWBAAgV7YiDGPMjBETWla1sUf4vXW49t37dDDzX14+ZNYdnF6SRDE1Y94OOqo
6EF+866EbLqnqRAjqFbfKRh5LTLtOF7XqvV9bFTQtlfPRRkmrgzv7KFROnSJlLb9
WYZ9TodApGPMFmhSHw/GLapb5HFKQbAcpsFXafLh9CTyRQJvVeSKPz6pbjtneAvB
+qhvXN2M1Yl+DWzzMn1qXpgyBulay08oq0uDGCzdCv1XM1tLMSvj/iF9POrBFVjp
sehamiLT0tS9kBrGQAgl8AmrXgJXNPU5GuLiI0E/QugGoxYxZTGmMftloRaFhtFP
e4LvW2IS4BOFAJCQWtxRB+SglVCz/DAm0DaC6yF/HeznV1re34dqnKbDgES9aike
BQM+SY88KZuxflstcDH8op+k+or7MqaHMCB3g2YQn2oYaXxGpIeXe53PTOvgLvIM
npf83SuCjwnHuq1a7xV13dlrU0HEPPDNchX+WB1k5azjUPsFYlgFYJ7fkXRh4QX8
3OmPpIrSIjqI4HqzeRwql/0eoq9ehwm8q0QIHzg+sIOLiKoU2E2puKr5Hu5DAjRb
iHJsT9iYxwUSlCppDJ4BW9AziUl/Ci7llwbS3xdqQn/hXFWXV1csYxNCPEsl2LG8
zo4aewBYugLYO3GNSRSGeuMyijZN104TOyc+N+Nq0ZRh4tD0eEw=
=NpjJ
-----END PGP SIGNATURE-----

--Sig_/lNeE4kK0oH0Pqq=A=NvLyzS--

