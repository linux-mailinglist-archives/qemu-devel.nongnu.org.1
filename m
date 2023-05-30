Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE6715885
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uiS-0008Sl-I6; Tue, 30 May 2023 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1q3uiJ-0008SE-NY; Tue, 30 May 2023 04:28:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1q3uiH-0004Gr-Py; Tue, 30 May 2023 04:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1685435288; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=E56fY2+AFYx0Upi+wZYlf5XeaBOXiySBscaLvU3GbAW0bcejpF/YICbSAU1T2UNeyo
 ldTXNTDtAZFA2o00cum0sUVcwi49kR+FUj69bhhBB1OVlGePEnZ4rrEpn67O92d/Mrmt
 JZyGThCtebloRdDhofyGLTbzKTYeNnWXBXX+bDUj3pucNYZSmcqfGBLWm+nAPqxsEDrg
 gbf76XvxxR3cxPnOdoTMB2IZjQFlJQueKlrt1g2I4DjvP8NxL35NMKhbEnNiuaS3rV4F
 cbApsOKvamuDgPRK8qCI9tmu9jbEpUgowbwKQ/UA4MyBtPkYtrGWCNnIEaN0eAFowlCM
 Y7dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685435288;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=RWHZ3/oO8Cq7wEbT4NjxIPDBwvI8D+xDhqpiDnOHjFM=;
 b=VvZ2xppYHAvI8VVC1+ivMrJfhu79EcI7YchtQ+vRXnKXEuXOI9vNYa3v1/88IVbxAy
 gO569Lb8wkXBADoI8AOzUc3gO5G3+ajFCkXayasY/0MaJHGEwwyQZELusdpuMf9VRfF+
 mkDdBBXzhTa6nkbB500vpK0E3Q7mYz6SS7VVOJHGTya7tEb6T4r9PkrVdW0DJ9eaVp1e
 94k0ibdf3Jc12XSlvO91pdo+tAM0sKMTmheh2c/Zgfgz1e/pfS2ZIPGpOFLlBhMOuQQg
 TE93DjjfHedq0YIhC/yQ62TSvN5LVBz8BLpdDAYPN5PFHCcYYjXNO+0uYKfv2pBmwkek
 M43g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685435288;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=RWHZ3/oO8Cq7wEbT4NjxIPDBwvI8D+xDhqpiDnOHjFM=;
 b=Ah3fD3JNAqjPMBHnSuWLEL5nMK88LyXNX/EZJtY04pZ9yzHlpWT7SjI/gSEeHnOFiD
 8De3LskDi4ARdibG009gKgTzBXskFnPtzLRz9Tg+4NkPMhxcnH6Bpf2JaY1GELReOnfw
 EkRCIXCulBQvqEGbhLdUP2vRFE902B+1PDU1hq9sNz90nd3Ks/xFrSXbimMeyfIyEPts
 uYBW6DIXLoIhs7F2/whuZwU3kbjqrBuxozIhQM1OZ+yaOUgo5Cp+b0LfFk1OdwM1hOxM
 Gq2i9ylFQSSANjJ0POXpciRQgcetGYOsBrk8Kg4IHo9wO/3qF/tM8ZYGXckLxg2Xppyj
 3qyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685435288;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=RWHZ3/oO8Cq7wEbT4NjxIPDBwvI8D+xDhqpiDnOHjFM=;
 b=WA3DuQtUOEiUeeHWRYAbyQIwEavxVH7t7qIGvZfqUsueXZ6j/My3ClIuOZghurQqeR
 hlOvWwh4ZP6ngm0VXkBA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4BhOIaRvsld/sN75OpaIeOWAiVTRkMz6wPlUdSg=="
Received: from sender by smtp.strato.de (RZmta 49.4.0 AUTH)
 with ESMTPSA id x6987cz4U8S7Gh2
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 30 May 2023 10:28:07 +0200 (CEST)
Date: Tue, 30 May 2023 10:28:00 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable
 <qemu-stable@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>, Richard
 Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: stable-8.0.1 re-tagging?
Message-ID: <20230530102800.4e71a968.olaf@aepfle.de>
In-Reply-To: <4aa77e25-c224-c2aa-d17d-54d3d04f763e@tls.msk.ru>
References: <4aa77e25-c224-c2aa-d17d-54d3d04f763e@tls.msk.ru>
X-Mailer: Claws Mail 20230504T161344.b05adb60 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iRc+ilI.hDXEhB+6470wSTz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=85.215.255.53; envelope-from=olaf@aepfle.de;
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

--Sig_/iRc+ilI.hDXEhB+6470wSTz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 30 May 2023 11:15:31 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> I'm for creating new v8.0.1 tag for the new commit.  But I'd like to
> hear opinions of others on this matter, since this is an important
> process which definitely should be public.

The man page of git-tag is very clear on this topic IMO. Go for v8.0.2.

Olaf

--Sig_/iRc+ilI.hDXEhB+6470wSTz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmR1s5AACgkQ86SN7mm1
DoBsphAAkY5mJR5ilo/rHvY5oLZsUV9cPZ80js64gj/gnZOWIiwTr//baUy+Clrx
loA3JUHf6g8ynQw3BYKTNXVfTV5mblg+D80Du/0yrhJ4fjTBHjgkkCYzYUvxzMDf
Un8qSTweVqqlOYRSlJanqIJdWrpNXITMsCOytsl24LoT9cdKmdzSaHtnX9UwCBxr
wUV/bvkqwf11Qa7huXB6R4OoZmwsCxtl/3GNjUpBDHVL6WFURc5GNa+DT53+SVtB
bjQMDO6uWi5eDDrpkxFBZyC/nSyTIP/87pyzfck3Tvcl7GT+RxFAH0wXtcPMWko2
YjZ9Agt1qND4mLpQt1TlMjpTC+RNVHo54uxdqFpWnIz+4z7qlbZMuZ5fy9gxKfI7
130v/PzKxbvZ0O9zQbrRrNJq2T7T9qqTJLAOcrgKNfc/x/D13FxrlYjydGI3oFXy
E8rHdwVVidUIRK9F6z9oodGYPH6ylI69SvIfv6ivYqlWsVS//lKKCEmEVORymsEc
nlfTA54BudlLvDcSzqXXOgKqpteQQpG/8HI8HrwVvvf8f1Vsb8LjGfQ5u+kvqjrE
iH0VgsLXF53lJHSeBL0+6ONGgtxfc1aCbQ0/qBGA/YRVdftJdHmC59KlnWCoV70b
gmaAfDgmoXhw98DOkzGHs9hHWfRZ4qJIS5PXpC6oQ5Er7l5obpM=
=HILH
-----END PGP SIGNATURE-----

--Sig_/iRc+ilI.hDXEhB+6470wSTz--

