Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4606A8293EB
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:59:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSYX-0001dm-EP; Wed, 10 Jan 2024 01:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rNSYV-0001dT-3V; Wed, 10 Jan 2024 01:59:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rNSYR-0000MD-8H; Wed, 10 Jan 2024 01:59:14 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id ECFA95C00C5;
 Wed, 10 Jan 2024 01:59:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 10 Jan 2024 01:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1704869949; x=
 1704956349; bh=xc2DFbirMJREdDlgq8WKUKorg2TVgzHfkcm2CQKGA/M=; b=m
 SP8YFuJEIY6CnAUI6/JoLVpw7KFUA8R91E+jFL0R49vXB03vr4stIkqJAfJEH2Ma
 eTQcsp0Hsr2mXcHAJGAt5ouwUhcKl+iXGwAxDQYNplPxr+BFUJwnNeAE5LPaGIRW
 Gp9jr1uyKZKvNqjPR99xjtAJ+H7S5K7WGqhkJhV+QCH3uHisgoAxNtY/1BevCx8q
 Ip9/El7vxZ4QPL82OihHTsDas8tZhJO+UU18nGLj/TQJsFmF/89DCH/ICD4QBcfg
 7NjZ0SARBodCgQCNmHKmZSr4edPxRuH1QFP+7cBeVpRJZKHFCbuZIlou+NRrvr07
 gm6vK1we7xeESAmKbvbvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1704869949; x=1704956349; bh=xc2DFbirMJREdDlgq8WKUKorg2TV
 gzHfkcm2CQKGA/M=; b=Xc4/nXFxXtNrEZIh/E8nAOVvhMupSisy/Y1JVThFVxVb
 DK+DnuRJI//pv4DRVSzZefDQ3JZubNXZzORoP1cowExzF8WYc/0LJ22Gshk3oOI6
 mNvJkc/XE8+DmGVHwu7UZ0hffdVbbB34KLgNatR3zu+rX71fKqG1Uwa3JNlrVaH3
 W+A7Ci/i1Al4Bc94V6H6fUKTolhvKuhzD/R+JQ2hojSSWboq4Zt6of+OO3zknPjN
 Bx6SRVTAiLVIMl2FIBAuFr2csgxYAQQMJfMLCK47uq1TUvwCtM3dzavdeOybpzQs
 UgxUBLZmF58l1xTEYw31mLeHcMtc/SU8lmKVqGPJbg==
X-ME-Sender: <xms:PUCeZakN1lvvJj3UQy1ojsyeQ_f2ntWQquDhu1yBK0CrpnDangzaRQ>
 <xme:PUCeZR3DK9iP4CtXOeQBLWnE_KbacL0lGyF-gPPC2XNYN0XZ76VL3XH02ZV7ejD8z
 TJ7TqZGsZ5tEhAxrKw>
X-ME-Received: <xmr:PUCeZYp5ClgrYpV92zsEQ91mNMiCgI4Pad7FIJWphbxvAQ_NvcoYS9hoYiNp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:PUCeZeknw-EYb0G316jdyQ0ZKVQlH5ygL76sY55z07LWbxIxaiuHmg>
 <xmx:PUCeZY0YA4u0mcPIwhS7JABsoufWPZhc-ZiWSSFwrN3zBNY3HnNPvA>
 <xmx:PUCeZVu-QmGK7CgqRquNaYgwmB3uEaB8puWhMmvFhudHAOlYvCpfxw>
 <xmx:PUCeZVx0pOvRdqX7tA84U_JkIFVdbDt7Q9VmrnEpT0EIIdlelbBKnQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 01:59:09 -0500 (EST)
Date: Wed, 10 Jan 2024 07:59:04 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
Subject: Re: hw: nvme: Separate 'serial' property for VFs
Message-ID: <ZZ5AOHe-rhK0lZSC@cormorant.local>
References: <CGME20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5>
 <20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JqEpRg7xMQmQ++Yz"
Content-Disposition: inline
In-Reply-To: <20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5>
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--JqEpRg7xMQmQ++Yz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan  9 11:29, Minwoo Im wrote:
> Currently, when a VF is created, it uses the 'params' object of the PF
> as it is. In other words, the 'params.serial' string memory area is
> also shared. In this situation, if the VF is removed from the system,
> the PF's 'params.serial' object is released with object_finalize()
> followed by object_property_del_all() which release the memory for
> 'serial' property. If that happens, the next VF created will inherit
> a serial from a corrupted memory area.
>=20
> If this happens, an error will occur when comparing subsys->serial and
> n->params.serial in the nvme_subsys_register_ctrl() function.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>

Thanks Minwoo! Queued on nvme-next.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--JqEpRg7xMQmQ++Yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmWeQDgACgkQTeGvMW1P
DemKsgf6AgdIcdpRUyhBRucQU8imHyg8oLRgaKyh+gEvdfZroHO2ch8/ndwPyKj4
HUfOpuGTZn5vfnpv91fRMwYNpAIir7a9ieFQ2fQHi3bMFyaqvYmpypRYKknYUqw/
CdU7QeLtRH37S9TVJR4sjPgaf1a4LBRg4iFcmWYR3Na37gstUX7Dwf70hVl6ZAJc
zHjl24TMouoQtS/1weNwWswunqzXpEVrtSWO9Ca7FOlYX5TK6GDVQ8cgcg2iCOHg
9snTRyAfCxsErv7FVV8PiSAhSw5BW1GqHJFlBawqXuZIEEkBeK6TPmIZGvrWJ5Re
ZNlyDNTB4ba4vDjSPhuWLZB4Jr2bVw==
=cF8D
-----END PGP SIGNATURE-----

--JqEpRg7xMQmQ++Yz--

