Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8B773825
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTG0e-0000hI-8o; Tue, 08 Aug 2023 02:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTG0K-0000ZY-Ce; Tue, 08 Aug 2023 02:15:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qTG0H-00042p-W4; Tue, 08 Aug 2023 02:15:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 67E7F5C019F;
 Tue,  8 Aug 2023 02:15:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 08 Aug 2023 02:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1691475334; x=
 1691561734; bh=Qm8yEf772Dq3Y/4H3GLmFygLIFjvGiNk4cUXusPirh4=; b=N
 J5XjN+YzkXzb3dI6k6zqx7a6HRNQ7dyo+A5HaPYt2Qb0Kc06h8RAMVh8gW9pFV8T
 OnOPdXMWkKzhm0BKp1/7vPFyJVIwSdV/LYuoALQdkitY3I6yYiEordU+lWVheF99
 uCyQASq7PxNrS2qE7/WjUBrV44tpnAvR3kxdXA4e6oCUXD6FHJCwlr8a8DUWtE4u
 CfjplFDGw0lHdYmSaqA7W8KjLoiH+avHPszXkMyEADV3wUooHJr0oG1gkTPE/PzJ
 rKw1sjhaHQL3CFHugv19ZIT2F1I0Kd3DSt7PKqp2osx9huZB1eIaOpJikoIiWjHR
 A2vdUh+hQVgJQeBq7sNyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1691475334; x=1691561734; bh=Qm8yEf772Dq3Y
 /4H3GLmFygLIFjvGiNk4cUXusPirh4=; b=XPMW/Xesuvi4RcwIU05egacdKNHi/
 5WfC+RGgluvF+4weOgio4rUw2X/P+ppbLQ8yz7N98DE7258wZ3rR704eBLlwkvAp
 Oy2dv8pxNNWbBdj5Dowbkkuevjyo09z7pZXScKFqAzAc9r4rHPKoK/0faCAP8NRv
 ZD+26KxQ/dhRlj3f1bvPExAkS8Kb461BLz1t8rT6fBuHeML4ENYATn/J/gxOdBR7
 cti0DimpPlMf9tADyTHcM1eBCmoA+MmfRfSBkat9iXE1Yk6zcDEpzZGFOqoloog/
 GDyhoKvIV/bv1hCp+b832TNUCaHCg96Y989JD2ZivI/IT2h+jabQUviRw==
X-ME-Sender: <xms:hd3RZMs-r6mK7GhbX_nI9xCnnE3H8CdhkIl-mJ3zpHXHTS_rYNE3iQ>
 <xme:hd3RZJc6IudK8JDxhS_H7eKf4oio4tim8AGYYRdU2SLu6ddS7xXu6HJAEzkDnPQ6x
 M8bBSML7_8dzJpSVPM>
X-ME-Received: <xmr:hd3RZHz0yhbYhvWuR3x-iQBAKqUxbnv_ggTUo6JoPrQRUHF_mFg3TD7xb0XtqIMCVfkpnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugddutdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
 jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hd3RZPPsRDtyRiTBlMuCCWxByn9F-Rr2UB0OCSOkgG6LVoLBiu8UeA>
 <xmx:hd3RZM_5go9HwX2AyLQOX5iayeOQAAKmtOd_WONVO_pFt6supGXR-Q>
 <xmx:hd3RZHXz7hSsLJnBqrjKIqDLQtE0pKPvrkthSMOvP5q9462jJtYVmw>
 <xmx:ht3RZJOY-xL7olngX1a-dm9Waa6-TggaK22AMBZvNGphGuhwIEfVlw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 02:15:32 -0400 (EDT)
Date: Tue, 8 Aug 2023 08:15:31 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-security@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 zdi-disclosures@trendmicro.com, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix oob memory read in fdp events log
Message-ID: <ZNHdgwUSQuhLSG-w@cormorant.local>
References: <20230803184422.27521-2-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LX7bu9V/fS1+RYcA"
Content-Disposition: inline
In-Reply-To: <20230803184422.27521-2-its@irrelevant.dk>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--LX7bu9V/fS1+RYcA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC qemu-stable

On Aug  3 20:44, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> As reported by Trend Micro's Zero Day Initiative, an oob memory read
> vulnerability exists in nvme_fdp_events(). The host-provided offset is
> not verified.
>=20
> Fix this.
>=20
> This is only exploitable when Flexible Data Placement mode (fdp=3Don) is
> enabled.
>=20
> Fixes: CVE-2023-4135
> Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
> Reported-by: Trend Micro's Zero Day Initiative
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f2e5a2fa737b..e9b5a55811b8 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -5120,6 +5120,11 @@ static uint16_t nvme_fdp_events(NvmeCtrl *n, uint3=
2_t endgrpid,
>      }
> =20
>      log_size =3D sizeof(NvmeFdpEventsLog) + ebuf->nelems * sizeof(NvmeFd=
pEvent);
> +
> +    if (off >=3D log_size) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
>      trans_len =3D MIN(log_size - off, buf_len);
>      elog =3D g_malloc0(log_size);
>      elog->num_events =3D cpu_to_le32(ebuf->nelems);
> --=20
> 2.41.0
>=20

--=20
One of us - No more doubt, silence or taboo about mental illness.

--LX7bu9V/fS1+RYcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTR3YIACgkQTeGvMW1P
DelJsAf/XHV7qMq+OuSPVRrTTRvBJo8adGDXdy23CGp0D1fYIGSH6m1w9lSR+P0D
nxI0+7xoB28yzQoyc0jdx+JAf3RSg5Lq1pMBZEWcSX9OyDt1nBRJhV/5mE+N3TNs
vYekEIJfJxtLqtyGGHVHHqh0ODr9A2jyfmQaJlA4do70+sR1fHKStFjJ1dUQ0jse
4HGgvh5bw5pGyk+b5tMSJjU8kMbL6iPvJ/MYW5IY2zr4HvRdfbv9bPWVUGTFeCBc
jmFtwRF7KSrTJreb1JgMHOjoBZ6SxgZW82peRjutfFlKLQawbujCSmraxlTgWu5k
LwBb3a0aebXNZsJPZPSWZ0UPyJ0tMw==
=JrOz
-----END PGP SIGNATURE-----

--LX7bu9V/fS1+RYcA--

