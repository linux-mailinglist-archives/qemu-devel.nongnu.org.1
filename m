Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFFA74D85A
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIrUF-0000kL-LX; Mon, 10 Jul 2023 10:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qIrU5-0000iz-2t; Mon, 10 Jul 2023 10:03:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qIrU2-0003K8-Jb; Mon, 10 Jul 2023 10:03:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id BAD145C00A2;
 Mon, 10 Jul 2023 10:03:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 10 Jul 2023 10:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1688997800; x=
 1689084200; bh=C1Q1VU734pAu6OaovfdBpP4uPgPFBkU0ciCrGq3xi6o=; b=S
 8QuUfNaOBdcv21wK0u2O0Fb2SOnwBd9pyjTaqgWiaO54hLzodhgdfJd0K0wqRVD1
 DlI+PVq0Uift5x8wDsOMFkhTbtqyEjAwhgR1XrR2VHt7f9FDuUmAPRH+nqXcsMFh
 b0hFbMf8jJqp9H7VSBI0MRQ93w8MTm7F/xfprHxU97Fi+kpnuTc80k8gWMbELMtc
 IaZCtZ+5H7zplC/AvxCI427uvYoSUES19vjTkHzk4PRP8xwBga4UgMLhOUiN+cR4
 xox6qpEQ5B/kYJ6uaaT/RDEeHpaSBzeZvCQVimblrs3rmMBgnnQQhlp6wuEyKp+d
 er6vaL3yKeaM1PKwNI6SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1688997800; x=1689084200; bh=C1Q1VU734pAu6
 OaovfdBpP4uPgPFBkU0ciCrGq3xi6o=; b=M+Gj+Wz1yiMOO0NRwu4DXKLuCjvLy
 mmERbVrxHMcAv97JR1pwL5BPqorPgARptQkb5GVyX7Dt4HrEM1P5LxpcvepUViHw
 206bYsmLsOm3Gf/QD0XEf7nxeCc6zKLFL+AJuEwJH0lEhk17Z0d9StZMXstKNQ9u
 nJJac5TKo+F1baqoBnwxGcpWvd1Bnrj/5FTvsSBrtvMleFiB/Dn9UcxwnQg+JwZ1
 aTIhlo7lBJQkVn/y1abVCZ7ck+PDVyTkUm67fhEIuwSLaDnVjMDDTHOM6usoTXv1
 PBqZqeeCOY/l/+TnnDaJ09ZfTXlcukdAY82yXjv9UMmqjjNaRK1yd2CdQ==
X-ME-Sender: <xms:pw-sZHFl91ZcMx1wEP14iZSkImpsxfavHCsz0nw5OzcnRbTDq0r32A>
 <xme:pw-sZEXTmxaWyDb6KQXfVYJ1WVEwPkXzNoQKC2f1-VYQI-Z6V2MPSFB5Ud1cZxeq1
 Vc0UHeGqBvQRgTkvPg>
X-ME-Received: <xmr:pw-sZJJKJTEIh_lLOC-rI16sxRimnrKBRSWgDIqU0bQFDviFcCmetZ1STmI9GzAkQ_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:pw-sZFFYWw0T20VW_b2rYIa8s1rBxTlYnz3HM6Cz3Ch4GKG1ub9vNQ>
 <xmx:pw-sZNUkLaYpTHZ5yMNunuiNQXOIUpf9ACc6O2eq9jGhMepeaFTl3A>
 <xmx:pw-sZAOpknv6F03AlR1bJdXn-_qEr40c1Uu87Cmt1a5TokioKbXUlw>
 <xmx:qA-sZDxVrMzYU61qmzvLYohChROyJsRZ4O5tr21UrvMtO5k3BDG1-A>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jul 2023 10:03:18 -0400 (EDT)
Date: Mon, 10 Jul 2023 16:03:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PULL 11/23] Revert "graph-lock: Disable locking for now"
Message-ID: <ZKwPpO0Eu3tMA6AO@cormorant.local>
References: <20230628141526.293104-1-kwolf@redhat.com>
 <20230628141526.293104-12-kwolf@redhat.com>
 <ZKv4G4A0l8EhMZoy@cormorant.local> <ZKv8UvKOHo6VX5g/@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lgxVDyQ2kN1AFUJc"
Content-Disposition: inline
In-Reply-To: <ZKv8UvKOHo6VX5g/@redhat.com>
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


--lgxVDyQ2kN1AFUJc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 10 14:40, Kevin Wolf wrote:
> Am 10.07.2023 um 14:22 hat Klaus Jensen geschrieben:
> > On Jun 28 16:15, Kevin Wolf wrote:
> > > Now that bdrv_graph_wrlock() temporarily drops the AioContext lock th=
at
> > > its caller holds, it can poll without causing deadlocks. We can now
> > > re-enable graph locking.
> > >=20
> > > This reverts commit ad128dff0bf4b6f971d05eb4335a627883a19c1d.
> > >=20
> >=20
> > I'm seeing a pretty major performance regression on iothread-enabled
> > virtio-blk (and on some on-going iothread hw/nvme work) with this
> > applied. Something like ~300k iops prior to this vs ~200k after on my
> > set up. On master, virtio-blk is currently faster without an iothread
> > (~215k) than with (~200k).
> >=20
> > I bisected the change in iops to this revert.
>=20
> Is CONFIG_DEBUG_GRAPH_LOCK enabled in your build? If so, this is
> expected to cost some performance. If not, we need to take a look at
> what else is causing the regression.
>=20
> Kevin

Argh. Doh. Yes, was enabled and made QUITE the difference.

Sorry for the noise. Thanks!

--lgxVDyQ2kN1AFUJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmSsD6MACgkQTeGvMW1P
Del0+ggAgFH/bIEbqGL3e+2wAtjtB97GtRHuAToaWVD8yv/uyGRsDRsLOjkP1TxF
hvyFqlqxVU/EC1BEFSXk18BLF/hwh9YENLBMKlm6HfFH/FPgYvNVSWH7v3whPQ/8
0pIiL0qiJ9ueqbhTQ7ne+O6w3aIXSm4xymPBYPCsffVU7y9QbST334djvpa74sCA
uMRJeke5d9Y/or3mFAjQZVMKGUp8jJjPLFHipvz8UM4My6a1j0FojXmZ2pcwUIk4
8KtTkz+HIiO/YmOnW543d3EezzdOKpREUfDWNV58izIJpWEXLSYZu8TtfZ1G0/lr
XJcryV5vHJl78Yik0NgyERDdI27BOA==
=uXSl
-----END PGP SIGNATURE-----

--lgxVDyQ2kN1AFUJc--

