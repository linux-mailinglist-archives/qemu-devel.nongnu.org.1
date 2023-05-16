Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FBA705844
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0qf-0007EH-V8; Tue, 16 May 2023 16:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1pz0qQ-0006oV-Dg; Tue, 16 May 2023 16:00:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1pz0qN-00071X-RF; Tue, 16 May 2023 16:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1684267214; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=oYjAOuo5XrCuEQR1W6/l+gMe8iW0/pRObAz3AXMdbMBAntXrf7eR3xWdGCEDgd5ejv
 8luHseiXq2JYMjo6BbNsglvWUioUorZ/XaMfsQWvp5ICJUPL2RO1xodEJyHR129K1yD1
 zoGe9NRN391Q+qXpMprXqEmK4n2iqaG8BwlX9sWTi8uznAD0DPksWP8RTa2oq0s2v9gn
 696rv2N8tmh/nGqGWobPJv1XoS+8nkf8oVPii2wp7FUwgZxBF2BwgIoFAgBPMJMzzE1S
 Tz5YwRhIqw4rOjEhAkABqrzraxm2i6xPuM5addxLuDimkwMqwEq6TidN4X+2vzld2qQs
 JbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684267214;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=pS0Z4id9fKm2g4HFIaP4cyA8REoB+fljOJamATQiIKg=;
 b=NkTEOOvUULIQHeKXD/qBlLdSUlymDYKgU2w3ld2/D95sks4e1qYP8VPVq4UBrIIr63
 vE94G3LG07MnxIJ/1EZa8W1bMsfltVELjyAsi6wU/bLdppBbaBoehgvJr0TQhINESyg4
 weWFPYUkel/Cw8E2IbUZrZKxiTr8wVBL2fpTIjg2Hku6Wf3OOygon1Ih0DmmghrE3eWJ
 ejW8rajtT4YH1pCyqELfXSDu0NhnoGhSMnwZE/ubU4BAf1lgHE6QuUWLfqjdFTaF6In7
 BJdIRm7xJLdx3lxDudGbo/VoCHVNNdY+Bw0wSVaqcqETpiR6xDKU/WXOlJ67haX4HZWP
 rI1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684267214;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=pS0Z4id9fKm2g4HFIaP4cyA8REoB+fljOJamATQiIKg=;
 b=LyXWqaWgSuG1JKysX34wy0K6ONnQlBaVJHC97d9voPDy8UJpk3QvOx27tV+Mqm1Yyj
 pbW8qfbpUrVRwBNM5lkL6gTPTPBOY9Y0tOlPE6ShOOCbJnDL8y5CmRqZ2bqHlbCMTpRX
 uqVwj9HHcBiFNxkKAEAkxI/iZke1GHRgkyH9qkj32ikXmLyNG9ARFIIFy07rAvwWN0bC
 axXKdHjZXxHS9nRh8WWJHeogvVJmkH619asQFMMFNnP5XG3WzXAOfMbSA1fltMCfzGMh
 MfMzrDRrLtGJx5nSTGpBr3dQ9IYFlllkx1EKYfJopQozQXA5dUoEQnE2QJXiY/atxVRI
 eqfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684267214;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=pS0Z4id9fKm2g4HFIaP4cyA8REoB+fljOJamATQiIKg=;
 b=iVQJE14B1+56+wIw3G/ijmiRqUwL5q4Qd8Ue4aef6lOkHfwWhc2Z3y3afylkQkcFT0
 MtU+ri5Yn6x8XxH0KZBg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX/0jCNVp4ivfSTHw=="
Received: from sender by smtp.strato.de (RZmta 49.4.0 AUTH)
 with ESMTPSA id x6987cz4GK0DYiy
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 16 May 2023 22:00:13 +0200 (CEST)
Date: Tue, 16 May 2023 20:00:07 +0000
From: Olaf Hering <olaf@aepfle.de>
To: John Snow <jsnow@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Message-ID: <20230516200007.4fa87c6a@sender>
In-Reply-To: <CAFn=p-aFa_jFYuaYLMumkX=5zpn228ctBcV=Gch=BhmQs6i2dA@mail.gmail.com>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de>
 <20230510094719.26fb79e5.olaf@aepfle.de>
 <alpine.DEB.2.22.394.2305121411310.3748626@ubuntu-linux-20-04-desktop>
 <CAFn=p-aFa_jFYuaYLMumkX=5zpn228ctBcV=Gch=BhmQs6i2dA@mail.gmail.com>
X-Mailer: Claws Mail 2023.04.19 (GTK 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/11aB=ufI14REGukuAgcfB1H";
 protocol="application/pgp-signature"; micalg=pgp-sha1
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

--Sig_/11aB=ufI14REGukuAgcfB1H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 16 May 2023 13:38:42 -0400
schrieb John Snow <jsnow@redhat.com>:

> I haven't touched IDE or block code in quite a long while now -- I
> don't think I can help land this fix, but I won't get in anyone's way,
> either. Maybe just re-submit the patches with an improved commit
> message / cover letter that helps collect the info from the previous
> thread, the core issue, etc.

I poked at it some more in the past days. Paolo was right in 2019, this
issue needs to be debugged more to really understand why fiddling
with one PCI devices breaks another, apparently unrelated PCI device.

Once I know more, I will suggest a new change. The old one is
stale, and needs to be rebased anyway.


Olaf

--Sig_/11aB=ufI14REGukuAgcfB1H
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCZGPgxwAKCRBdQqD6ppg2
fqLiAJ46FKHEwF2tggdoStt1IxPQ76JRyQCfZMuVO4l+1/a61bf/j2kZyfqYQlk=
=aXMf
-----END PGP SIGNATURE-----

--Sig_/11aB=ufI14REGukuAgcfB1H--

