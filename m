Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C729751117
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfQO-0000GM-HZ; Wed, 12 Jul 2023 15:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1qJfQN-0000GA-C5; Wed, 12 Jul 2023 15:22:55 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1qJfQL-0005uz-Ro; Wed, 12 Jul 2023 15:22:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0AB618D9;
 Wed, 12 Jul 2023 19:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5BEC433C8;
 Wed, 12 Jul 2023 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689189762;
 bh=+HaO3J1LQWoLd8P0Xm0PiJeskp3VP8VLRhuQhm2BVL0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XBiRkZIMjbwaEnRU8xl3p52qo0DEbERpB4v/Vj/VqDtk/O7KQl7osVWhzCK0DbNOU
 4Mp0pGMBEpx/jtb8HFaRAuyRSMDqS32N0TXVGADntDjti+7wCi36c+NvFFX5XsIw8s
 xm7gSmXJgNLV9Vil6rQYJODN7VAe2W6J6K35WjRTaTi8lG9gekBCmNaTLT0ZYxZVtO
 WsAIha9XvjD0EPrC9vD1epgg6clfmLSHrBokgQN8FgPuPhUhWnVzZKpTSnojLex8FD
 K8abXvV3XQ1vtt4GM/rKcvw8UQ1JMVFZ4k5J8/znjOdLq42nWDw4oTUijBAqzqNV8W
 ChRUB0oTbT++w==
Date: Wed, 12 Jul 2023 20:22:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Subject: Re: [PATCH for-8.2 6/7] target/riscv: add 'max' CPU type
Message-ID: <20230712-stench-happiness-40c2ea831257@spud>
References: <20230712190149.424675-1-dbarboza@ventanamicro.com>
 <20230712190149.424675-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wrnHX3yXnPnAqpT4"
Content-Disposition: inline
In-Reply-To: <20230712190149.424675-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--wrnHX3yXnPnAqpT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 04:01:48PM -0300, Daniel Henrique Barboza wrote:
> The 'max' CPU type is used by tooling to determine what's the most
> capable CPU a current QEMU version implements. Other archs such as ARM
> implements this type. Let's add it to RISC-V.
>=20
> What we consider "most capable CPU" in this context are related to
> ratified, non-vendor extensions. This means that we want the 'max' CPU
> to enable all (possible) ratified extensions by default. The reasoning
> behind this design is (1) vendor extensions can conflict with each other
> and we won't play favorities deciding which one is default or not and
> (2) non-ratified extensions are always prone to changes, not being
> stable enough to be enabled by default.
>=20
> All this said, we're still not able to enable all ratified extensions
> due to conflicts between them. Zfinx and all its dependencies aren't
> enabled because of a conflict with RVF. zce, zcmp and zcmt are also
> disabled due to RVD conflicts. When running with 64 bits we're also
> disabling zcf.
>=20
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This seems like it will be super helpful for CI stuff etc, thanks for
doing it.

--wrnHX3yXnPnAqpT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK79fgAKCRB4tDGHoIJi
0i2eAQDRWaOxyj6I83sUeQuL3P+nrivVPbpbjpXcO5w8T6JxkwEAqcjjb+luUYrZ
Ax5JzRJiDk12Un6zlbsdSlGpKedTTwI=
=EpYL
-----END PGP SIGNATURE-----

--wrnHX3yXnPnAqpT4--

