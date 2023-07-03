Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72674569D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGETW-00043u-Al; Mon, 03 Jul 2023 03:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qGETT-00042m-US; Mon, 03 Jul 2023 03:59:56 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qGETS-0001hg-Eb; Mon, 03 Jul 2023 03:59:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688371179; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=jLq8hwxtE/uQJSJ02xy1kMX53eCT1i/WpYYKfPaW/v3JkHls9hUqNAlpSsV+qixb/3
 eK8E6m/WluHr+MK24hQCUV82iVgRSfyjYuMtwMGdrkLDA5w1F/iLxQ8iPk1q4YnOpSO5
 fwXPC3mw/P5vvnV0ePurcVNpxvlt7aIMesRULYmsOZfh8qN0+eEob1Q8phwtk3OMrzWq
 kNQb+3srgJW0uX8UjmAa8PqK791ZSheE2SFFM+SRT+bkyz0wmWztvzHsEU9DR0CwnVjp
 OOMo9sJ2C9vd9Kqk1B9WH1f2S2Kf4fgTXXVRpcf5OgGK1XuCGOce9m0Tapa0FHsuiB+d
 OCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688371179;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/NWoffw9Rs9pvmxjPwZ99uvrxtV/tIj/5sJuKdfPIHY=;
 b=IG7UxjAYH+y8Az8P/HDIxB/nseoukbp9Q2qwJD61fMDWZQgp8ND1JEdt4oG1GIww9d
 3ODwNq5K5qAk5S5BG0Dmx7Fyzwc0qT9V/dc4BY+m2HGbsFTuTiO+NVpHQSQisfBpNey6
 gvCDhh52k/edl9o+Rn7FdJDTIZUHnbU2thizq8Edrq9ph8CFSo9Fiftp4nlvAgO7FkzT
 8DKYWECCd3aZ3pt1lQ5IgMR4z2Ei7PVQDtal/N7CXks/kS+JYy4JOfxMie+P9Uq2ONtf
 5lncXK6L10C7N0s2/CWz+NGfdTcrNG2xv3tT/Ni4TQZlvw4KZ+aaUT588QGSL4Ns1Ckf
 bxGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688371179;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/NWoffw9Rs9pvmxjPwZ99uvrxtV/tIj/5sJuKdfPIHY=;
 b=BzqpuPshXul0wfVqQEdugc4rqsUU+Tt8nSHNkVUT2f3y3fSJX30szumMdzOvdEOBq4
 3K3axXRs3eJ0hW45a/+Y5zCxTTKaILbcOmnOtvFamZaXwg8714VUrwZkKDXhl0mU2NBk
 lczF1IUOHqe2rWw++Rpge1NpIThETgyMFg/3DgEDEUkm8zqINY/PjjFBivgnS9F03AWz
 whu8mPvUED9J5skch8P5xwXXxTkBuiIMU6mArHJa3IiFJUDvnKSFZTFOdkbXBNo3s1jc
 4EK2qjQBe020SvvrVBpVKasjKABuuKfaUhtDoeuKFQ6MhdCytpohjR5rRlEIo3x7I2fj
 gKlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688371179;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/NWoffw9Rs9pvmxjPwZ99uvrxtV/tIj/5sJuKdfPIHY=;
 b=MmDOFqZFLEJlGWsw1l4Xbo6boecqEOsyX7ZsiE7m5A1ZrZBQN66riL7iynsaQdy8O5
 8iBVwwqbiszknhkCiBDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4VReIOE3s+xIC8HZ8TOtjelmE6SkKgUS6xMby0Q=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az637xc54O
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 3 Jul 2023 09:59:38 +0200 (CEST)
Date: Mon, 3 Jul 2023 09:59:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230703095929.6e793dcf.olaf@aepfle.de>
In-Reply-To: <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zDMhTexE11UwM7U8s7NBJUL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.164; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--Sig_/zDMhTexE11UwM7U8s7NBJUL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Sun, 02 Jul 2023 22:18:50 +0000 Bernhard Beschow <shentey@gmail.com>:

> Do you know if that command calls pci_device_reset() (which would eventua=
lly call piix_ide_reset())?

The function is pci_xen_ide_unplug, which calls device_cold_reset.


Olaf

--Sig_/zDMhTexE11UwM7U8s7NBJUL
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSif+EACgkQ86SN7mm1
DoD+fw/9G8ODfV8OdgtxploWokoShmLGD3QEdv25Nc9rAQLmZjKGDLziqt8roVq2
S2VxmTGpe1nB+aTopnsYc7sUoZHeETIn0h1ANv8UKaP3jQtWYYdceUxhd+Pupc33
wUuGCwBCJz49vAiIWvqRr57C6fqRMSRCFkqXQg8NCTvZerQoAPMWB4+ZIZQoMb0/
1N5/1MyMe0OI7dcjliH0jM8NOsE47zViMQ4hwrNcPH+Jdv0wE2n0ZADn7CGglC+m
NPmfdNwCaJTESq0ZVE7Db5w2/HgFZQWOY4CPIcEvzl7/UPluvYOSV3xtkeR5sTzQ
zUhpJKZ+cvNyNpAA20TvMhC6QzFhKjwiwPF+x7CJIG4FAcMw+oFWYo8Dt9aRbOo7
JwYj/qc2qGsVegotfTy2ehGvILJGyY7hh6GTyF7/BWdmANM544MknNuhMecIExyD
+QY0rId3V146TsRGA1Mj2Lsva8ZZ7FiWxZHyAjPTRqISZRkOPlZU1F9PK7Y4dpi2
W5HB6oLl1PZhYwqiZga4IlaVn6F7JfVeoS1ioYsaEMJzXNE8L4yfW/LKdPUer64E
Gvysk96nvgbsf7zvGrjdGUDNX4NlRxBtVy4a87lTk4XWj8ztj/UF55uQJ567tYwo
FjjK7sbcvZ9mn2Mfq9SOQDA//uoTGFMhRdf4vW/OAnw8sX7Bt7Y=
=UNR+
-----END PGP SIGNATURE-----

--Sig_/zDMhTexE11UwM7U8s7NBJUL--

