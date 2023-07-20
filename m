Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388C75B8E3
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMaYx-0000Xe-2K; Thu, 20 Jul 2023 16:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMaYu-0000XG-QI
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:47:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qMaYs-0000mq-Ns
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 16:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689886064; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=SNtqMi9f9xEUg/1twffsIHBiK787aBED9XybHBybrRCWHcFUKTKaOxHXXKotLVQHh/
 YoztPViV3fULGrQL4++r/eGfERtSIyfh4gCs3jTOwvfaqdwKBqbXQKXOaeINlKPMv4IP
 LNX+HDCZlvqDlHA+95riBtfKQrZbIBQ2Ie7yuA3unnLa3EcyIwJI6POA0aB1z5Nk66s4
 46RRaMsM/nfR3aFieo07uIo/OCkwWg9Cq/STIhN5oXDcyWn4BWSYrXQXHz69y6sohG7C
 QUl4td28Lxm3H21StghovLrwxI++lAZS9o+3Mr9agoVNGhN6FQDH5P6PWusS/w5Y/q0e
 yrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689886064;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=fDxGq/zTpIHEsnKf3ZwL5uuK6qEBg2yWkWt/CrvBXxE=;
 b=Gw9tKL4HIQsqKiQsW080ZtZUg+hWR4OemPxRyn8/gt5lr139goGfFDJa6C9kVz7CYx
 l3pUkcKnDhdRaj9PtSAwLGJwT0y17oWWWjilW981iu8av9Cb1hEClwGkE/0Ab1OTDJIR
 uiQ7JvuD3jic/4quQstXHiAVDvoAAoAhbN/govXBHQ1MuJsRWer55KphqDSJEiAQndIT
 xTHKqvD88lXDaHqLFxDEJmudSPRa8MB1W3VHIT2DtbvVy3GIz1tubaBMpj32FNWy6JQ3
 F8remHpog9x8EecH1PIJK0O7vjP0F6nu+NTN2Y9PXN2v1/WQfvhbpKDWOEAZd4e4KJap
 v4cA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689886064;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=fDxGq/zTpIHEsnKf3ZwL5uuK6qEBg2yWkWt/CrvBXxE=;
 b=pFaoqmVh/j1EuZ76XN9EitvtMWZlzlpMxSrBRg0Il3LPzl6mp4Mpwu3VghbiSRebqV
 dbz9IQYAUPQ3YYBiSufUM0ZuiQYemIRll6Ck3jhDh1RdH9VNPCals2jKqffaZKlQCWC7
 a0wsP751ouYdyBHy+6+mO4p1FluRkbX1YBlJ5ASOK3RbQXUJ8vSuKV5QRfEJ/8IkunqK
 1GdKaii101Yd1KJ1D/G5O+bD44xvE0oAfUY3fO4piuzVUXG7rj74/DBlk+MbN8umMl7e
 wc/v2GiEuD1pdm9k2xhBNfuoPJua+peL/equ+aVR5DOtgXSSs9xO/dfgSN38K+L/m+H7
 VzWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689886064;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=fDxGq/zTpIHEsnKf3ZwL5uuK6qEBg2yWkWt/CrvBXxE=;
 b=PArftSyPrjUXRjV2T1QHeBrfcA88uufzR3ks0ZMy5g7Hffyj0546GBUErHr2DFVFbs
 U+Y5cby6Nj5BpWfoHpCQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.4 AUTH)
 with ESMTPSA id m4dd28z6KKliBFJ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate) for <qemu-devel@nongnu.org>;
 Thu, 20 Jul 2023 22:47:44 +0200 (CEST)
Date: Thu, 20 Jul 2023 22:47:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: qemu-devel@nongnu.org
Subject: 8.1-rc0 testfloat fails to compile
Message-ID: <20230720224656.2841ff5f.olaf@aepfle.de>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vx5_7=Ms4My0ZqracPJKnlV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.161; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/Vx5_7=Ms4My0ZqracPJKnlV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This is going on since a few weeks. I guess there is no check in CI to see =
if qemu.git#master compiles in Tumbleweed.

Since the switch to meson submodules, berkeley-testfloat-3 became mandatory=
. I think in the past I was able to ignore this submodule and not export it=
, so the following error did not show up:

[  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c: In func=
tion 'f64Random':
[  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c:559:1: e=
rror: control reaches end of non-void function [-Werror=3Dreturn-type]
[  141s]   559 | }
[  141s]       | ^
[  141s] cc1: some warnings being treated as errors

Apparently this is a known issue, 3ac1f81329f attempted to ignore such erro=
rs.
Do I need to tweak the global, system-provided CFLAGS myself, or can the so=
urce be fixed to address this? Disabling this error globally will hide erro=
rs elsewhere.

Maybe there is a way to append something to tests/fp/meson.build:libtestflo=
at.c_args? Right now it is apparently set to tfcflags+fpcflags+CFLAGS.


Olaf

--Sig_/Vx5_7=Ms4My0ZqracPJKnlV
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmS5nVMACgkQ86SN7mm1
DoAGSA/+LNfbeR3DA7rEiyGOMgzGigl5oI1R+VYS4w0fz/NAuYlL8OYd8IjDGQwM
GlYsqwmZmlKo6fZOzCT/Z4OyCk2xza97zlkpA8S8O/m1QL+qTsqM4I52bCnKqOmR
2yuWPKDMXLjuOyg6+3KtSf/Ut9beAEnK7qQ+kgb0N/E5fHeYAaWdRUPAFIzfPyN9
IgH0e/DGFS7jZs4R5HxMgKmAXkyDBMQ3ShH455VBf4DFOsMzhMqnmDaZ2yQvUmG0
9dxWZLa3xq7YUtja788jfYH/lP37BSIWDacU9T7MQaGpmRmux3JXVccRAJhJj87o
Ni/gbHMb2JcndHGf015x/dsRRiddYfy1IvX+96bwSROb2ix690D0qbxu9X0nFTbX
qegAB0e455oCZvYwLQ3BHeaB6dchEP5Z8FaZbLYXgy7FB+yoDuCoJusOukTDr7vV
L3OqOxbOK2OhEZAD2Q1mLfzbry2zUYAO+2KQ/LCzah6yW8S5GdgfkH/WQfLttx7S
wkG55b6llsgCtZ67ItjbeIHZ5BUFlayy07WYoJcb6+G35vDWwOi3vU3HsyP2UsiO
MUAaI5edbbVndjtHL3W2DKxQrepeUswrhUrctTwnkUvtfp+9U34JZHn+7GySJnSo
dG9rG/3eS0l+UYcK0sY8REJC3eL9IGQoQPRqIWuSHMvZH4BlX1s=
=VZtv
-----END PGP SIGNATURE-----

--Sig_/Vx5_7=Ms4My0ZqracPJKnlV--

