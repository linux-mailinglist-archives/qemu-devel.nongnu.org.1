Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC4755ECD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 10:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLJyK-00040D-0E; Mon, 17 Jul 2023 04:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qLJyH-0003zs-PP; Mon, 17 Jul 2023 04:52:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qLJyG-00043X-C9; Mon, 17 Jul 2023 04:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689583952; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=nW+Y6uklomLiANj+8AOiNOQntNjTDLmApGHYRDrK6DiwTQ37XDYtZ9bsiUlfz8CLDT
 oc9B8DQmMt9NLn3App2KEdy3ydkv9+fglLbXegJnyAk4dKJfwmZI3vfx0j6DrZalbw3z
 ZjWoUDgiJJWJLPCDq3jqg80GSjfqitkNNL+eXzBASdAqOatKk0SBhf+jsSeaalHgch+3
 oUsL5vM3BKyXhCPGuyHjRNsx7QcE53auENV+8DYsvO3SNBxIvdi1Ji+p2T66uimCZIup
 NMfIqyz5vpcDY3DkF8LAIPEVFFBHSOZecmZp+Rjs2hYtWNoFBV6Ye1CRB+qt0GnRinMh
 zgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689583952;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Ykcmm96PPc3LX3dylXhpnFrK3fzIBfTeHXlWg4McuXY=;
 b=sCNc0j5B5T25uMngGm7FU6+jAHRLwa6q5Wkd5AhE7WsnUqDdCtdpcOp9UiAnjtQHAn
 EemnV281CGkZESpsH1V+d0vxfY6aJXh/0uX1yk4uFwq/Df5c4OCcUEXtbNlNWRd7csaf
 4Cwc5GCUcLD7YbKFPK0OzgK2ou5zli84Yq2Kp2BRoci87f6xKlqdw3I0rwBZgP1kVEwE
 vLAUqraQ/ZQ4ZIs8qlMAKscpIUXRA1+GOIIxGpD+hlfNUtcv7K5H3mwzPzah+enTFQEW
 Frx0TzOiTQe7W8dssbeS5oewrQiyAf5EybFH7+z9AGmhVxTpgptQDiH0YUuQxU7vb1Mw
 CKuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689583952;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Ykcmm96PPc3LX3dylXhpnFrK3fzIBfTeHXlWg4McuXY=;
 b=CNSg6PAG0Ko9eDc4UEcHc93pZykJfoaN6Du06lS55arxVED7OhzkHbwRPv6RVJdVod
 KiV+z7XU9VJ0EK4k90lxzGuSti3AajtOkGGwM3wQxmXHbG6KDWkLFVZXz4d2HfAe6boP
 BytXKjl2m07Yjrj5yOirKN7cpZxZD0q1gFx5OyCt/oMTL23C4ZUbz3tpAcGF8CifEgXw
 5pmsv6+MeDMyrTLTrKm1U4kO58rNIqyeaZo4W2tx6R+wLVrs+2j/Jtg15P/SUKxBcLN8
 CH0dsbSjPHMNOxy6tmyoWVmSbuc87bCbQnnuwj0BF8AANkodY4G0Czkk1ROzbzCDXa6Z
 cWdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689583952;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=Ykcmm96PPc3LX3dylXhpnFrK3fzIBfTeHXlWg4McuXY=;
 b=mjxYIa8CUPeGkvnz97pyqfQ8koyl8DZZkVGW1E23yMi3nx3QYjpvxuIsJfGO+5FHz9
 QwmsLdyP42Oxxv4D86Cw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az6H8qWx0L
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 17 Jul 2023 10:52:32 +0200 (CEST)
Date: Mon, 17 Jul 2023 10:52:19 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Lev Kujawski
 <lkujaw@member.fsf.org>, qemu-block@nongnu.org, John Snow
 <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Message-ID: <20230717105027.131c8e8b.olaf@aepfle.de>
In-Reply-To: <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
 <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
X-Mailer: Claws Mail 20230714T084508.e5e1185f hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/euQcglBZXS6ijt=So5r/.Ic";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.166; envelope-from=olaf@aepfle.de;
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

--Sig_/euQcglBZXS6ijt=So5r/.Ic
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 17 Jul 2023 08:46:16 +0000 Bernhard Beschow <shentey@gmail.com>:

> Would you mind sending this patch as well?=20

Sure, I was waiting for the other change to appear in the master branch,
so I can reference it in the new commit message.


Olaf

--Sig_/euQcglBZXS6ijt=So5r/.Ic
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS1AUMACgkQ86SN7mm1
DoAsFw/+MF3mSzQjsT0Ia11qaygRamBbAW27Pz2ENfHvZq/41k9hOBMrFhvL1hdo
h+SR3LciS20xkx+uCckItwyIpZ7jNAbIOb8sdChhEflLxZli6SFO3UyIY4O9DgsL
do52WJngwVV3CSzvhy65LVpa/jikTCiMvMltOrn+hmiQNeu/uK+CBBCqwTVWGNAG
YAsTM7rZAW6vkfKcu55F/NcHJJrS2uJp5S6bgNy6C0EUqvyFQsmD1geNrdi3q9WF
POpANFnENLkRK/0NICiqB9Q02yBMlk5I+8eFTJcwJi8ntY0moWvYSwCCMTjfJZDp
Rx/nl9a0oynftkTp7t85KbrxR7tDbHQcrBbEgN8q0YNRakhXTNxfjf7dxVhY2Z/B
GrdgsJUc6MylutVVO6Y9Xx+EZ54sRb+seJYwbt2+YOlnTYZQ9oHdacJYKTQHhcSo
09O2WzLt+m+8aTb2VmzCamNn2FNTgu56FHjrGAihZlTPqAiFOZFz/wzKa5foKMsv
ttTj2/rMivCjxBxxrm0UzjFYO7NrJT8GdDw3fldeiOSsW17VSQ+++HLNubYMCJne
QVz8Nqp6xEqAfkdPbMOe+yaeb6oA35F/mRBBch2k2lwFd9wlBNiXez77Q8WmDyVl
/Dv++EANBemkyfcKz9NbEcMJ8bz8XNlahublQ7ii/ufxZZ2lbz0=
=/80K
-----END PGP SIGNATURE-----

--Sig_/euQcglBZXS6ijt=So5r/.Ic--

