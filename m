Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6088293D8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 07:54:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSRp-0000XV-K2; Wed, 10 Jan 2024 01:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rNSRm-0000Wf-Cv; Wed, 10 Jan 2024 01:52:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rNSRj-00059K-Sd; Wed, 10 Jan 2024 01:52:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 88CD55C0134;
 Wed, 10 Jan 2024 01:52:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 10 Jan 2024 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1704869532; x=
 1704955932; bh=jlpdSqNIwnHKbnPVjiMm2XqeeuV9/lvrzgXY/df370I=; b=A
 1XL6JS18r29Xh5YtubaAp+C2znPoX4CnTepCXBnqOBB6Os/iMvRebxCsVu1SiXZS
 gcmGSNxeRbvP2GRhecYiANeuaf18MN4S94LJG89wyv5bUcZki5YvKsbMLrBC4KDh
 h48Ekv8HgaFOhh75Vnb3FhhfSoWZpKrqgnbSTOXSBPQOZoBnf0DT/JMYk1bfQ4L1
 U2gOuZOrG3h77+x2sMvIB9D1Wedmpi9HlAWgudEoIx5ZpgCfmVRoyVQWWYONS3vS
 ZGfXz14XBzGaagyjshNvzzMiAPzSM+Q3oxMfVhdvDojgpM2cKBcNbmXIWq1uVZig
 +2igdE5ZBGUlJe8PEva+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1704869532; x=1704955932; bh=jlpdSqNIwnHKbnPVjiMm2XqeeuV9
 /lvrzgXY/df370I=; b=Cr1SB8+01KJY561zmbav0FTiSu+FltWGrsNGi7wnBVSb
 qD4sHLFmJt3062kgV0iG8cZsNtR6dNWKKiYM3d4qPcuaMfqMr6outEXGWFNCQ+ek
 ZuKAa9JQ+9JBHPOxbn2jmDs78dmcRrOCq7WmaYh9axOckah2A6oEigANai5S4l+u
 pBPg4qKuP1J0f82SG5YN/AZXpZU+DdHv+8tfBPYL80D0u+a7icixEGdv64jDHNTJ
 9vUms1+BE+j+ScIqNlCWnlpzToSSlXeLTilEfyHWo6eM/idoYw4b9XDuoUY4NfOh
 VHLrJnpGeeYRLR9Ah/SrfO17IgWdfWrF2n+RTo6yew==
X-ME-Sender: <xms:mz6eZbyX0FtZ-Mn0leU5pweypD43ucCLYHeEl-k_P7_o9ker2KPgMQ>
 <xme:mz6eZTSfabHkC5b6WLGYrWbdF71-YB3Ru7mGqKeQDNR9hpU7orBtVgxVinJUu8kVl
 7V_RWPruxVpGWSTxDU>
X-ME-Received: <xmr:mz6eZVXZUUJGQbDkPAXWf566gtdeS8gV2QSQVQJfh0x0iBHHusDbkaig6sru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddttdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeffuddvhfehjedugfeijeeuieelgeevuddvlefhkefhgfettefftddvkeev
 ieelfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgu
 kh
X-ME-Proxy: <xmx:mz6eZVhTWxvOylGVyBsRuFQh7wa9VkFPQyjJ9fTW_t5sc5fNAy09fA>
 <xmx:mz6eZdBQJxTxkOjPBSGVK3BGS8asLNor03-yEohrRtbxTqS0EbLIiA>
 <xmx:mz6eZeLk_kfWZNuUrhTsnWJ0lh8dwIzSq5aOoWIVRaP2aYQX3_hG_g>
 <xmx:nD6eZXTI6iXeTM2Elab9JCBYyxQ51n8fuDdsvGkBTn3t6F8rDSKx1Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 01:52:11 -0500 (EST)
Date: Wed, 10 Jan 2024 07:52:06 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org,
 hare@suse.de, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dlemoal@kernel.org
Subject: Re: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
Message-ID: <ZZ4-lo64mGubad5t@cormorant.local>
References: <20231127085641.3729-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mvyc+4wEFE/kwUpr"
Content-Disposition: inline
In-Reply-To: <20231127085641.3729-1-faithilikerun@gmail.com>
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


--Mvyc+4wEFE/kwUpr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 27 16:56, Sam Li wrote:
> ZNS emulation follows NVMe ZNS spec but the state of namespace
> zones does not persist accross restarts of QEMU. This patch makes the
> metadata of ZNS emulation persistent by using new block layer APIs and
> the qcow2 img as backing file. It is the second part after the patches
> - adding full zoned storage emulation to qcow2 driver.
> https://patchwork.kernel.org/project/qemu-devel/cover/20231127043703.4948=
9-1-faithilikerun@gmail.com/
>=20
> The metadata of ZNS emulation divides into two parts, zone metadata and
> zone descriptor extension data. The zone metadata is composed of zone
> states, zone type, wp and zone attributes. The zone information can be
> stored at an uint64_t wp to save space and easy access. The structure of
> wp of each zone is as follows:
> |0000(4)| zone type (1)| zone attr (8)| wp (51) ||
>=20
> The zone descriptor extension data is relatively small comparing to the
> overall size therefore we adopt the option that store zded of all zones
> in an array regardless of the valid bit set.
>=20
> Creating a zns format qcow2 image file adds one more option zd_extension_=
size
> to zoned device configurations.
>=20
> To attach this file as emulated zns drive in the command line of QEMU, us=
e:
>   -drive file=3D${znsimg},id=3Dnvmezns0,format=3Dqcow2,if=3Dnone \
>   -device nvme-ns,drive=3Dnvmezns0,bus=3Dnvme0,nsid=3D1,uuid=3Dxxx \
>=20
> Sorry, send this one more time due to network problems.
>=20
> v1->v2:
> - split [v1 2/5] patch to three (doc, config, block layer API)
> - adapt qcow2 v6
>=20
> Sam Li (7):
>   docs/qcow2: add zd_extension_size option to the zoned format feature
>   qcow2: add zd_extension configurations to zoned metadata
>   hw/nvme: use blk_get_*() to access zone info in the block layer
>   hw/nvme: add blk_get_zone_extension to access zd_extensions
>   hw/nvme: make the metadata of ZNS emulation persistent
>   hw/nvme: refactor zone append write using block layer APIs
>   hw/nvme: make ZDED persistent
>=20
>  block/block-backend.c             |   88 ++
>  block/qcow2.c                     |  119 ++-
>  block/qcow2.h                     |    2 +
>  docs/interop/qcow2.txt            |    3 +
>  hw/nvme/ctrl.c                    | 1247 ++++++++---------------------
>  hw/nvme/ns.c                      |  162 +---
>  hw/nvme/nvme.h                    |   95 +--
>  include/block/block-common.h      |    9 +
>  include/block/block_int-common.h  |    8 +
>  include/sysemu/block-backend-io.h |   11 +
>  include/sysemu/dma.h              |    3 +
>  qapi/block-core.json              |    4 +
>  system/dma-helpers.c              |   17 +
>  13 files changed, 647 insertions(+), 1121 deletions(-)
>=20
> --=20
> 2.40.1
>=20

Hi Sam,

This is awesome. For the hw/nvme parts,

Acked-by: Klaus Jensen <k.jensen@samsung.com>

I'll give it a proper R-b when you drop the RFC status.

--Mvyc+4wEFE/kwUpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmWePpUACgkQTeGvMW1P
DemQfAgAnLHKHp2F098Vu0Ah/NuC0eTR9gmqXZ/6ALLT53tbntdgqEEIsPGqN78r
jNseCZBd/7vzZIT0WfyUy4bq9944sFqyjnH6XoyyLf4EpXpNfosvSAskx4iuOSqw
HqE6KA3lNAY67GmHgDIubo2dH2WtA71TXd2J8EhUjRqbYWk3SuBEqBwhKNJKT3Ie
tNCv5Qo65rtcCqWK/nv3Ge5Vs0Uc6FozW+pR6pI7ydftcpwKACfhWRMzx2Q6a20s
6amOo5bkk8vsChAOaA/p3ADgtHO6ITHBIqRizIBCKtHCdYiWfs94hKhee3LdheQ5
AuCcYgh5vrSoZIONz2u5GCI83NQpEw==
=0zj4
-----END PGP SIGNATURE-----

--Mvyc+4wEFE/kwUpr--

