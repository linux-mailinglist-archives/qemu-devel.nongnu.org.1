Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C677DB39
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 09:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWB5z-00055p-AX; Wed, 16 Aug 2023 03:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qWB5v-00054y-Ra; Wed, 16 Aug 2023 03:37:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1qWB5s-0002M0-BJ; Wed, 16 Aug 2023 03:37:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7FC685C004B;
 Wed, 16 Aug 2023 03:37:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Wed, 16 Aug 2023 03:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm3; t=1692171445; x=
 1692257845; bh=PVCg4HvH9C7qdKiIV0qqSEgiPgDXiQvW8GB+quhciuY=; b=T
 YPHToZwZx+Y0KNt5cZp9euSv4/fLG0dd2SwdMwi4akmAKb+R1kIy5NTJwA5coCVR
 dP/voOE/4/o7xudUi4rZBRtrSv8iLNsRQdvetpFUGFd9iuLeTW+Yx+IfxauI3kiy
 3WLDdME7cbQbra2S0kvKYegF+5w3PJ2LzQOwpf+nS9Cm7/n3oCdg1y6O0Ere0BUA
 E3dCOzS94f2Kd96wPvg8sV8/npp0xnhQ34XJl1C3adyw8PiObn8TRjpr0I+CNXq/
 DqtJpDBcAQeEq+pS7Kw/a0y2SJfhhugcKMsLLXPw1eYC+ESLqUHG51DDt2/NYa4i
 CBVYD/jVSncHGnrq19HMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1692171445; x=1692257845; bh=PVCg4HvH9C7qd
 KiIV0qqSEgiPgDXiQvW8GB+quhciuY=; b=wOTtjJs1o9E20VJkcuyaophSouIPI
 ijGOEMle/cakz5Zt8mPFuHzxOuJ8STs5TQVM7uMcrxmwdnGjpH1i4mNoh6hHxb3x
 ujj/vqIFAdWZA7Lkr3BClk9XWVPktCKmG3yGdAoPzi2F5dW5mqvZqFYae3E9ivpu
 OEM9L7Ld0zQDaR7T9PGXkXNdCki2Bn5NYfhwLK1g1mrnzGgUDvzg+5nI1Q+QDZ1U
 wQRO5h476a5ue0BqKYRgFH9hUgxcYznq5upSiVQanmU6PuSo8lhTsHFUYjZZjB4P
 EGHKbH5O3GBV0HuKMpyJxPlrAcVZ1Dib7OHRfhqsiYQ52slefl1KRXwGA==
X-ME-Sender: <xms:tHzcZEskYKIpUSkcbG-KOOVfSKJbh5a5YDiu1EllCpZdQuzLlxXrlg>
 <xme:tHzcZBfypEpkrVDAjYJGe2h7-F43dz8Hl8Rqcm_xARcIRKhnQcudr38FmP6wABvtI
 7vPSz6WjAP-eGtBc6w>
X-ME-Received: <xmr:tHzcZPwVUBCpu2KE-TM5ajcoZpdKPWI325V_X3lknU8rjf1amEKyh2d2vTmnol_SMqrG8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtkedguddvvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeeiueffheejgfeileegtdffkedvhfevhffgleetvefgfffhhffhlefgkeef
 teeiheenucffohhmrghinheprhhsthdrihhntgenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:tHzcZHMwDfdlFRPvGlMfZMiKmn_dsU2E10PcGR4tBBpujHfDuesINg>
 <xmx:tHzcZE-3bKq31cudWyNmsYj9gJEZL3uzQDs_jbzUqABZY6ozhbq9oQ>
 <xmx:tHzcZPWitTzwk59gne3HfX1V7BEFdBNYtMwC3NzAh-xFwUq_mqqpLg>
 <xmx:tXzcZF27O19tjExPj8hcDiNSF4BFZyztv9Ach3HB6A540J4WL8LODA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 03:37:23 -0400 (EDT)
Date: Wed, 16 Aug 2023 09:37:21 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, stefanha@redhat.com, dlemoal@kernel.org
Subject: Re: [PATCH v2 0/4] Add full zoned storage emulation to qcow2 driver
Message-ID: <ZNx8sVd5YL6UAFkT@cormorant.local>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E73iVjM4CepdrSPt"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-1-faithilikerun@gmail.com>
Received-SPF: pass client-ip=66.111.4.25; envelope-from=its@irrelevant.dk;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--E73iVjM4CepdrSPt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 14 16:57, Sam Li wrote:
> This patch series add a new extension - zoned format - to the
> qcow2 driver thereby allowing full zoned storage emulation on
> the qcow2 img file. Users can attach such a qcow2 file to the
> guest as a zoned device.
>=20
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> -o zoned_profile=3Dzbc
>=20
> Then add it to the QEMU command line:
>     -blockdev node-name=3Ddrive1,driver=3Dqcow2,file.driver=3Dfile,file.f=
ilename=3D../qemu/test.qcow2 \
>     -device virtio-blk-pci,drive=3Ddrive1 \
>=20
> v1->v2:
> - add more tests to qemu-io zoned commands
> - make zone append change state to full when wp reaches end
> - add documentation to qcow2 zoned extension header
> - address review comments (Stefan):
>   * fix zoned_mata allocation size
>   * use bitwise or than addition
>   * fix wp index overflow and locking
>   * cleanups: comments, naming
>=20
> Sam Li (4):
>   docs/qcow2: add the zoned format feature
>   qcow2: add configurations for zoned format extension
>   qcow2: add zoned emulation capability
>   iotests: test the zoned format feature for qcow2 file
>=20
>  block/qcow2.c                            | 799 ++++++++++++++++++++++-
>  block/qcow2.h                            |  23 +
>  docs/interop/qcow2.txt                   |  26 +
>  docs/system/qemu-block-drivers.rst.inc   |  39 ++
>  include/block/block-common.h             |   5 +
>  include/block/block_int-common.h         |  16 +
>  qapi/block-core.json                     |  46 +-
>  tests/qemu-iotests/tests/zoned-qcow2     | 135 ++++
>  tests/qemu-iotests/tests/zoned-qcow2.out | 140 ++++
>  9 files changed, 1214 insertions(+), 15 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
>  create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out
>=20

Hi Sam,

Thanks for this and for the RFC for hw/nvme - this is an awesome
improvement.

Can you explain the need for the zoned_profile? I understand that only
ZNS requires potentially setting zone_capacity and configuring extended
descriptors. When an image is hooked up to a block emulation device that
doesnt understand cap < size or extended descriptors, it could just
would fail on the cap < size and just ignore the extended descriptor
space. Do we really need to add the complexity of the user explicitly
having to set the profile? I also think it is fair for the QEMU zoned
block api to accomodate both variations - if a particular configuration
is supported or not is up to the emulating device.

Checking the profile from hw/nvme or hw/block/virtio is the same as
checking if cap < size or possibly the presence of extended descriptors.


Thanks,
Klaus

--E73iVjM4CepdrSPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmTcfLAACgkQTeGvMW1P
DenthAf/btU8AUWm0zNUzE91I5ua7Zdu8sWmS+6bVJBYdA3xV6XFolgD2ZbvYMFP
IAas38W+M2qrvmIcDHHAukk5gBM13l+kOEmu21YDHH6waV1cIo97LMCXrA3j/vGt
AyT6Cp8B+NoCMonOiqJ11BDDqvYtVjgaQh6dyzhQCL184d69koPKG4/4ylUXC9+c
zY4G3yCv4hKSdKOqltLRQ1soKLiPjVW3qecF+N/Pt21kEygBel+KsEJEMeja3iJm
COplIZmBynA5WXEkt431Efw6JBqfg9zfQnR3PdpWv9LCC0VvnIYXaX5wGCby/V5T
t6ujj6I1hXKRXL7jzMy6V76nPQQuVQ==
=5k8b
-----END PGP SIGNATURE-----

--E73iVjM4CepdrSPt--

