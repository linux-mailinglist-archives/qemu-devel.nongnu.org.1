Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB0774D548
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpvA-0006R4-2j; Mon, 10 Jul 2023 08:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qIpuu-0006QG-AV; Mon, 10 Jul 2023 08:23:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qIpus-0006Jf-7O; Mon, 10 Jul 2023 08:23:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 94F0E5C00B5;
 Mon, 10 Jul 2023 08:22:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 10 Jul 2023 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1688991774; x=
 1689078174; bh=zW95/UqH2Z13Vtnc4lFHKZx1YbUz3kVxrOCLJeJTnXA=; b=T
 yxtUjKUKx8yrw6Z4mB9VQQiaj+fl/qbKuk4NM+0Lofqs3j2O2wzoXUFpNKjpJ6Ep
 B92llp82fCoNh5DOQ5BBIoRGI7sU+JC+6ggjD3ewnDN3CV2Qrj28yQa2AO+x6gro
 PHAye0aAkxZXz0UrlAWB9s9DFhyOFPjlwEuOk+n/CK1uEvZTmtlhSRseXkH/HlCb
 QuHqpozcpYwGeAUo4eK9hHgxWmqp7jnBWdP3EWFPZHu8iQeY4bzTw8/pApX759Wj
 RYzaCFeFkNMj/c4VaeY/HjhTHX7SvPZCt3ouarS2z3rw8mbNzsg9pO/vweDFWGNX
 iOW7CH7pG12qCELm/vv3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1688991774; x=1689078174; bh=zW95/UqH2Z13V
 tnc4lFHKZx1YbUz3kVxrOCLJeJTnXA=; b=hF4xppa6WHkxDZtekxhN/7DzL7bz8
 W9rUiDBYAhS4x2jmUwzUZbDvR57bCsPVDq3SBRbc/9pDPaSLpSAm+P9ShrMVu+Qh
 Lx7QtgwTQc+KCSYl+xZY9IOGnl2SCOxrAOH30qthS86hMuvZrb2YWkkHH+9H5A7+
 xTNI1xlETVFFlAwGI3SOeIdKJ2IomNyzbtyn31/uk/hGS45ER+odHV68mBT29AiI
 tm9AdqObwtDqjI11BL1VB0wlL+Y32NgtH5+DuUCe6YtjQ4CO1Cehi5oSbxZExD1Y
 /qB13tcwLIxdYkU9ypHqKjvSoxZbJB87J3RxNGzXVXfcc61GNxW56yklA==
X-ME-Sender: <xms:HvirZB6T-Sv0z9_SJqdX8u-ecYnlDYUykwZPAMB_mBFcB52WEyBgOQ>
 <xme:HvirZO6zDt_rctTjOkLwJ3Yf5hxi32gaI0bSAWZxMMxCjXvrtQcOBZDWonknsSCAD
 OSiY4_qvpBid8lgbFM>
X-ME-Received: <xmr:HvirZIfIsmnGDAud6tD7iubWs9d4fCaPtIOTLMUKDtx_RpRvceoBNivJixO_cKR_ZT3rog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdegvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:HvirZKIXoNT_WeFHD9yoPvx4GPw1oCVHVyqLG9dSht4PVzQO-5LBMw>
 <xmx:HvirZFJgAd8V8a0N69YWRdYB3XNOEg8GzIJKTG7hN2wMUo2QAXM66w>
 <xmx:HvirZDxLnpj70mV13-z-A4A6EFmtTIaep_lttjMfJeJad6L7C3V5DA>
 <xmx:HvirZF1cdgZ1wDWUsadZIH0_6nR9Jhau1g0fSa6unHIQ1LdEzZjJjg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jul 2023 08:22:53 -0400 (EDT)
Date: Mon, 10 Jul 2023 14:22:51 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PULL 11/23] Revert "graph-lock: Disable locking for now"
Message-ID: <ZKv4G4A0l8EhMZoy@cormorant.local>
References: <20230628141526.293104-1-kwolf@redhat.com>
 <20230628141526.293104-12-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7fGUxPXFpGi5i+DT"
Content-Disposition: inline
In-Reply-To: <20230628141526.293104-12-kwolf@redhat.com>
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


--7fGUxPXFpGi5i+DT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 28 16:15, Kevin Wolf wrote:
> Now that bdrv_graph_wrlock() temporarily drops the AioContext lock that
> its caller holds, it can poll without causing deadlocks. We can now
> re-enable graph locking.
>=20
> This reverts commit ad128dff0bf4b6f971d05eb4335a627883a19c1d.
>=20

I'm seeing a pretty major performance regression on iothread-enabled
virtio-blk (and on some on-going iothread hw/nvme work) with this
applied. Something like ~300k iops prior to this vs ~200k after on my
set up. On master, virtio-blk is currently faster without an iothread
(~215k) than with (~200k).

I bisected the change in iops to this revert.

--7fGUxPXFpGi5i+DT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmSr+BoACgkQTeGvMW1P
DemAhQf/VHBTEwJa8cgxqU9Rb51fQBGTQuSARDBqqOU7ux/acxdFjIpjqlpgU1+5
9hDuJeP4RVGn0kY9DcVDtdY21CWvtvmwm7jnzoWuVLE0NsFBGkCk/jUFdTnsfwIf
0kHYysbElS9GLeOsOkttK5SaWR92cH8Fm5FMWA7mvtqV5y+14zmgL4WsmywCMfpc
phIprudU8DRlE1qHjDqc9s5E0PgQNx5F43jWsqMJNY0jat8vN5w4qGM7aGsWJAGU
x5d28kWi+e027jDdg2xF0MUegNnQkAg6PuEXQ6d+DTID/hKHVdab6Xi6Z/WTuadr
e8D1/OXTmsJIH1HzjXV22LFCGl7z8Q==
=378U
-----END PGP SIGNATURE-----

--7fGUxPXFpGi5i+DT--

