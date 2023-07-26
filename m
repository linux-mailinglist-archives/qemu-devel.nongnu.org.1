Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CACE763326
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 12:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qObQt-0003dX-9m; Wed, 26 Jul 2023 06:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qObQn-0003d3-Iv; Wed, 26 Jul 2023 06:07:45 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qObQj-0001Tu-0I; Wed, 26 Jul 2023 06:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1690366054; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Io1EA9xzfjwoALASKAiDL3QuQcp+uuoQWecy+2OUsRrjZ8YoWlVxzh0qkYOa74aatm
 jXyT0bL7RMiuNT4y3SsUPMtm5P43xl/NtOIK74Fn30TnMGRa2p9dUPSbn/0uZxcTBWQy
 04GoqbZFUv0iivGlaoAnoe4aHgpcl86kFfPoHm+OXr/dI1KqzcIMVH2fbENlPK9jFTXx
 WQ2EgdHWRG0IuRaAFR/wQGzgi21aqXsgPVtsO947BS7pI9DEUdbADXbg45Foo/HICD7O
 GLPB8ox8NgaXezeN6VJUxl+vAPc6Nt8J5ruWQHoX7vnU5JNe9wkFZ7p7k4VdaSp8N4xy
 AR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690366054;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=InwoWiF4kVdCtFMnfAaRU+AWXSkK5ukGZbZqSqq0OqQ=;
 b=kOKCHuPOvN1eMNLALZLdtZKbLRwPXIFAtEhyBGShmIjgpcl82rXrVWWCoNt5VJ8ZyQ
 hox/WByS6hyZZT7DkEuZrWyu5x1zj0gdrtjRwP/6VtyXBpVAJP6IqDnMhzMUjS0m0ITs
 nUB3Aket/hINdHAiJBDBNNKjDI7YTw/npOKeWOnD84THx427RA/FEzWXqK+6lTN6kL2C
 3IXkUR0d9/YxqRyBAYnKPUoYIu5RT1PMGGykN2w3R3xqp46U9XBtBVzKXPQrYsijo22r
 Txy79gURGPLVjE0Kg/vqiLN2RqAApvXKcoL0amjCkjMLiEu9WOpG2bMglIsMye+ou4oS
 UWcA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690366054;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=InwoWiF4kVdCtFMnfAaRU+AWXSkK5ukGZbZqSqq0OqQ=;
 b=CUiVAiTGWr6OgCcaSQr+AzkMKIbXKirN+QUBTY+89v4+U0akDzWBS+7f4TOyt/J+b8
 hPx7gFW6pnapGZZccPg8A1tRvL2HmKKxsWcsa+Q5TdpjGOv4JDznrqTMWGT3sKEbzyKW
 C1JUsUol++6+66Jf8g55jEFwG5+g54B7bU8kdri/eN4z7FDVwYJOS2pUWJqMvPwCSMUp
 vmPBgnPtCtlsVYwNJTI808C14VNFMM+N5vuOkHjo91/8gD1pIUjkm1GZRZ4+jN3jWYSV
 2G2IXp7KB52efDboNoFt49fqh/cyOK4+NZydDGzWIbKpiGQkaHQfnE0/iF7I5tY5LrQQ
 65kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690366054;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=InwoWiF4kVdCtFMnfAaRU+AWXSkK5ukGZbZqSqq0OqQ=;
 b=XiUo6sz5kfoWnhp9jztTF4xqacdgYjfhu0XwTBlPSic3RuoZMuAfDlb26A8taABeFZ
 aL7jtrVMu5q5+zqhSsAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4U0aIaxvssIT1j+tCLlX5OhVr5AfLfzW6HQdmLA=="
Received: from sender by smtp.strato.de (RZmta 49.6.6 AUTH)
 with ESMTPSA id jd2f5az6QA7Y72g
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 26 Jul 2023 12:07:34 +0200 (CEST)
Date: Wed, 26 Jul 2023 12:07:27 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-8.0.4 00/31] Patch Round-up for stable 8.0.4, freeze on
 2023-08-05
Message-ID: <20230726120727.755b478e.olaf@aepfle.de>
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
 <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
X-Mailer: Claws Mail 20230717T091608.783b4195 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SV6sNMUNuYi2ej9yYSU6N5u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.220; envelope-from=olaf@aepfle.de;
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

--Sig_/SV6sNMUNuYi2ej9yYSU6N5u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 25 Jul 2023 16:45:17 +0300 Michael Tokarev <mjt@tls.msk.ru>:

> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

Consider 497fad38979c16b6412388927401e577eba43d26 ("pc-bios/keymaps: Use th=
e official xkb name for Arabic layout, not the legacy synonym").
Otherwise it will start to FTBFS in Tumbleweed from now on.


Olaf

--Sig_/SV6sNMUNuYi2ej9yYSU6N5u
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmTA8F8ACgkQ86SN7mm1
DoCjxBAAjZ+1GRU/GY5i2oMvWBgwSMi8zX38XdGhvTWu+z0u0yBHEeJeRCTnMA4m
v6MiJXpR2/jvyekQXYbA7h9jtlfX/9WAoMxuZhx39u0QL3XKVtH9/zVk7NkQ3MvR
roYqJVgrGRQSOgHFy8Ssz2dEgIcx8z5seRJU22x9uy1XmbXPYT0bRRGy0csHTHts
ei8EKx/5BYSzct3kKYnUpA9Ew+WmHLYVXLx7HmJrqtwY8Thguc0krCinHXDRCw/m
sxEe2wJB1XGnk/4IfScrArNKNpd7qlXcNs7UN5zwB8nyo3j3JX2ZokioLDze4SCR
MFl/LZLcSP321Tcb0GkhaGYwwxbEeVGEiF2HgvKWw00xGZWVS7CLLpqRD+fiDLyh
7YWhTeK7cesZ7M/sJoLlEbqDwib7H+eJnsoGi4Q8n8CfoNU2fNYFu6x8/5dy0HCm
ynkhklsM0CTYQOizDS5SCIr60pgAVm3uf/6lIkuB+2jKuzgxCJPam//wXSqbWvLT
f6wXy1UvNI8OrIGgmG+Eu9PhSzxqkGrt3BJTDR1M/hr0yn08wUAS1lYyZcaVOoUm
yH2rboGw7XrjOqes4mfI+ij3fQYA2gxx9S/3JhHrrr9mZf445REj6TVfcgTr/jiE
8H1xAvxXi7TfktAfjLvdmcdNFWsPdYNisWfyFYNAP+Ti0dAnuII=
=XOEx
-----END PGP SIGNATURE-----

--Sig_/SV6sNMUNuYi2ej9yYSU6N5u--

