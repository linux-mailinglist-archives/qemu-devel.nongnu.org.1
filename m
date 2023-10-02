Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 107AD7B4C74
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 09:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnDAC-0008GR-0h; Mon, 02 Oct 2023 03:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qnDA8-0008Ff-5m; Mon, 02 Oct 2023 03:16:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qnDA1-00005N-R5; Mon, 02 Oct 2023 03:16:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 5F54E5C02E6;
 Mon,  2 Oct 2023 03:16:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 02 Oct 2023 03:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1696230965; x=
 1696317365; bh=jvA8EupdegwAj2vYpIMaX3DuNcPdba6D0GQ458j8ypw=; b=N
 S+rggrWq4zOqxoAJl0Yo4fzreN0SVBa8+c4EAO6dvzl6KiVZi+btLQ61/JipPC5G
 QlD01tYRDg5RF35vVGHcWkf/lnn0glyTq109jMRENeCbUrRO/nnz2xgUfe+wdSp7
 owlr7s/WCbrHAsVSJfBMssFryA4tvclHw+x6jhYzYnNWwR+RohNnCGfyeCGt9z0B
 T9XqMXTv7y8HUMbF8pdmjZ3rSYKEiGbRwK7RN//e20ZxZvSnf032vumNTt4i3Hmh
 RaOgyLX1RxDEoH1/B+cuqT5Hlikj95V22MEs+j1EfQ6RgV9C+cTOl7+Dy7xpLIbA
 JqlZeNiX6JfitZCZxx49g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1696230965; x=1696317365; bh=jvA8EupdegwAj
 2vYpIMaX3DuNcPdba6D0GQ458j8ypw=; b=RYmZgzCsZ6igJ4tID7q9Wivax91bO
 jRTh6aCNENnBE8I4uzcTIrQMHkQ+VsXiQ7wWZ3o2T0rVKDeyATjSqXHvw26jKqFz
 IssmRlsQf+Rm+YCndQi+gQhJgNM4sfznulNiya8PaaZGjoEoP0Di8kd5dcT4Ukyp
 LpdQFbeWy2/P7hmXQjbi/nsgSGR5XVGAZWTwA8zjXAwpPLTNpGfXe+MHHz6osZUb
 Q98JpMytNI72FpeU7QsnRv/9nc1WPFHsq7g8RjF1qEpGtYtk+k27S61lxbDwdzdm
 2f7wo2LPCUVfLcqR3safwysFdXu7WK4fZcJieHC+oadoUsqy7bTp9MTMQ==
X-ME-Sender: <xms:M24aZabip0It_cnwSjVTsWCgR4ERohLUOM9J2v1DvX39swdl7fCqXA>
 <xme:M24aZdbAGmQJ5WDmqJvimXAcVaAYZGul1gYyS3zBQtM7xM5XdiUh8w0Rl7cFjNveh
 6l2KEnZJ5YBNh1oB7g>
X-ME-Received: <xmr:M24aZU-3TPmV-2zbFTZqM-z6Yltgz15LOQdOsY6M1eDqpbKGfqaFpcti7IYi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
 veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:M24aZcpyEtYmh5w8OXIh0VIhMfO5-g9UaWC5fNqL-PzYPKXcLvt-cQ>
 <xmx:M24aZVogePNh7q4jzB-q3Io6NCUffueLpjsAFGtuchiy6LNIk6H6Vw>
 <xmx:M24aZaQ-Ffe-vhfWX3tk0m1WmXo9sk2yHEOYsQOvO2A2ZvqatApanw>
 <xmx:NW4aZTig5BCSDKFnXj69XhD4o9ZtEFwpb9b0vJK6fTNB5R55MfMw8g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Oct 2023 03:16:03 -0400 (EDT)
Date: Mon, 2 Oct 2023 09:15:58 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alistair Francis <alistair23@gmail.com>
Cc: lukas@wunner.de, wilfred.mallawa@wdc.com, Jonathan.Cameron@huawei.com,
 jiewen.yao@intel.com, qemu-devel@nongnu.org, kbusch@kernel.org,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <ZRpuLrJjTYlHV1OZ@cormorant.local>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G4eJU7CVLF5QrKal"
Content-Disposition: inline
In-Reply-To: <20230915112723.2033330-3-alistair.francis@wdc.com>
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--G4eJU7CVLF5QrKal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 15 21:27, Alistair Francis wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
>=20
> Setup Data Object Exchance (DOE) as an extended capability for the NVME
> controller and connect SPDM to it (CMA) to it.
>=20
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  docs/specs/index.rst        |  1 +
>  docs/specs/spdm.rst         | 56 +++++++++++++++++++++++++++++++++++++
>  include/hw/pci/pci_device.h |  5 ++++
>  include/hw/pci/pcie_doe.h   |  3 ++
>  hw/nvme/ctrl.c              | 52 ++++++++++++++++++++++++++++++++++
>  hw/nvme/trace-events        |  1 +
>  6 files changed, 118 insertions(+)
>  create mode 100644 docs/specs/spdm.rst
>=20

This looks reasonable enough, but could this not be implemented at the
PCI layer? I do not see anything that is tied specifically to the nvme
device, why can the spdm parameter not be a PCIDevice parameter such
that all PCIDevice-derived devices gains this functionality?

--G4eJU7CVLF5QrKal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmUabi0ACgkQTeGvMW1P
DekwzggApQGpCiLaYZ3STj30EyoAvnLRhdtN9sJl3GTQ6DlaMBSl4KkWoyx4/E15
2zUe6BghP+w6JYzyi009QtuhZWsoMy6KLOOfiIadL6Uko+6OjqV4vZfRDgpG7C+c
vM5/j42OiSSoWEzlFvreZ/CwskQxa2gAwJ3KoRq7QfIhS0cbocu5ajG+dTeahyWd
dMlMqxYK7b+zdmkFqtxxdqkCkbmW44jtGM4cu8HcrIVZ+8SSaMCGRlUDpqebUHFU
Y8/+MSS15J/sPISYiVNtUGh4KNevo0pvkkqiDHyp/yo9kb1qDezytNviNY9lxfPk
OR0FHYwIA9mcf2e9OYctN+wM9Xl/9Q==
=/B9I
-----END PGP SIGNATURE-----

--G4eJU7CVLF5QrKal--

