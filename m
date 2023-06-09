Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB39729F86
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7dZd-0002Vo-Ki; Fri, 09 Jun 2023 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.devantier@samsung.com>)
 id 1q7XeV-0000fC-6G
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:39:23 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.devantier@samsung.com>)
 id 1q7XeR-0002i2-AF
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:39:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20230609083912euoutp0259049498fc05be78ac6fffef9907ea95~m8N9X27fE3237532375euoutp02v
 for <qemu-devel@nongnu.org>; Fri,  9 Jun 2023 08:39:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20230609083912euoutp0259049498fc05be78ac6fffef9907ea95~m8N9X27fE3237532375euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1686299952;
 bh=tLQ/Cxo8hQuR66R+l3m86Wl2Of0R26lw2EJ1z7rYtyY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=BrEBMELPm2FigY9X0Y1U+8QDncTKJodS/BMpHYT2rr4xlAtFQ9bNRyhyMhct2u4Dn
 lWg1icLfSq4DWvvC3Gf6UtLzuyEoPxyAsHouNa8mYfiMrso9qwKaIpvrahnHFZLXOV
 IZNsvrTDnRU62tGMp+Oik6LQwGKRg+pcWzeV8XSU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230609083912eucas1p1f165334c7e4af3bea9c3eefcc49e2485~m8N9Jb5Q-2683826838eucas1p1h;
 Fri,  9 Jun 2023 08:39:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.A7.42423.035E2846; Fri,  9
 Jun 2023 09:39:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20230609083911eucas1p19c8484fdbfc404bdab8bec9ffe903153~m8N8t6Tbj2628126281eucas1p1h;
 Fri,  9 Jun 2023 08:39:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230609083911eusmtrp173ea4a0fe8cf6acaa1daec691f226bc4~m8N8svPvc0632906329eusmtrp1c;
 Fri,  9 Jun 2023 08:39:11 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-80-6482e5300963
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 4F.50.14344.F25E2846; Fri,  9
 Jun 2023 09:39:11 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230609083911eusmtip1085094f3ceb9c5baec7bb9b57aeeaf15~m8N8i8iHR1673416734eusmtip1w;
 Fri,  9 Jun 2023 08:39:11 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 9 Jun 2023 09:39:10 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
 ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Jun
 2023 09:39:10 +0100
From: Jesper Devantier <j.devantier@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Keith Busch <kbusch@kernel.org>, "Klaus B. Jensen"
 <k.jensen@samsung.com>
Subject: Re: [PATCH 0/4] hw/nvme: tp4146 misc
Thread-Topic: [PATCH 0/4] hw/nvme: tp4146 misc
Thread-Index: AQHZjjGcZS6wcy/8/UyXDUNaon+D0q+CLo0A
Date: Fri, 9 Jun 2023 08:39:09 +0000
Message-ID: <20230609083906.sdotefyaqj54qinv@jwdssdr>
In-Reply-To: <20230524111904.91179-1-its@irrelevant.dk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.210.248.13]
Content-ID: <8CEDCD30F2891D4984F36091FCB7824A@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7oGT5tSDI5t57XYf/Abq8WkQ9cY
 LWa9a2ezON67g8WBxePcjvPsHptWdbJ5PLm2mSmAOYrLJiU1J7MstUjfLoEr48b3aawFl9gq
 VrfdZG5gnM/axcjJISFgIrF580ogm4tDSGAFo8TsqW1sEM4XRon5b9ewQDifGSXOTb3I3MXI
 AdbS9r4KpFtIYDmjxPOjYnA1r95dgeo+zSjxd8Y6Fri509duAVvIJmAgsefIKhYQW0RAReLp
 v71gRcwCmxkl5rUsYgNJCAvoSqzufMUIUaQnca1rGlSDkcTkXS/AbBag5oXfz4PV8AqYSkw8
 /h5sAaeAuUTj97lgcxgFZCUerfzFDmIzC4hL3Hoynwnia0GJRbP3MEPYYhL/dj1kg7B1JM5e
 f8IIYRtIbF26jwXCVgLadYgNYo6lxJEHs1khbG2JZQtfM0PcIChxcuYTsGckBFZzSkx5dZUV
 El4uElPavSDmCEu8Or6FHcKWkTg9uYdlAqPOLCTnzUKyYhaSFbOQrJgFNJVZQFNi/S79BYys
 qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzul/xz/tYJz76qPeIUYmDsZDjBIczEoi
 vFn29SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamFjj
 XBquvHQyTVl+ZtaE/TMenbPiXdWz4MTD7y/K5b28ZrT5t2wNWXRYb+bV3P+tO6Y8LhU4nXXZ
 WpD/cRM3G2/Q8gZv/1NKt4Iea08qtpgr2llV7aD5qHtCWJeC3iaxGw07xVXS0vaX7NJtO71l
 Jtv85SkL+jhjXG/5Hj3R8chXru3hh19P3IReynxw/ay3qIqx/sIVEdn6lXIGfCLxXKZ2ursW
 LDm/9tPSH+I2io0b1sSsbViV7/S4TulwUeyTijye43UF5kyeonZ/BbzqDn6Y/uKS3tbE6bMu
 fb6bMPWSyLV7ouc+btm6dmnDwfnyAjevZM9p4vY1yf3WMPdLoHHNtIN6r5oP92Tksq/nWqTE
 UpyRaKjFXFScCADWU+DXpwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xu7r6T5tSDBZd0LPYf/Abq8WkQ9cY
 LWa9a2ezON67g8WBxePcjvPsHptWdbJ5PLm2mSmAOUrPpii/tCRVISO/uMRWKdrQwkjP0NJC
 z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+y6BsaCI2wV19pKGxgnsnYxcnBICJhItL2v
 6mLk4hASWMoo8W3TPaA4J1BcRmLjl6tQtrDEn2tdbBBFHxklHnxsY4dwTjNK/Hi5mwXCWcEo
 0fF5JQtIC5uAgcSeI6vAbBEBFYmn//aCFTELbGaUmNeyiA0kISygK7G68xUjRJGexLWuaVAN
 RhKTd70As1mAmhd+Pw9WwytgKjHx+Huwu4UEzCSm94SChDkFzCUav88FG8koICvxaOUvdhCb
 WUBc4taT+UwQLwhILNlznhnCFpV4+fgf1Gs6EmevP2GEsA0kti7dxwJhKwGtPcQGMUdHYsHu
 T1C2pcSRB7NZIWxtiWULXzNDnCYocXLmE5YJjDKzkKyehaR9FpL2WUjaZyFpX8DIuopRJLW0
 ODc9t9hIrzgxt7g0L10vOT93EyMwmWw79nPLDsaVrz7qHWJk4mA8xCjBwawkwptlX58ixJuS
 WFmVWpQfX1Sak1p8iNEUGHQTmaVEk/OB6SyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEk
 NTs1tSC1CKaPiYNTqoEp/gZ/52IOydTwNctPmb5V3rEnnlknRHXudunG2+YfhOKEJ989zdzc
 ray/sbt8Rpxac1yFycFiqas/z18NbklfPO1uwqzNqi2nuCQ4pjEX2DEc5FjIrsnjVL1az0lN
 +NINManNz8UXyu45sK7H+uETUebihLPvZv2SWng85EhY7oOJTQqt57PiBRnUv1e/dQ+fdO/r
 svnB1zPuiy+638uw64NAgQnnw7MblvOJ7bqjfn+NZKjyxsaHF39PuzfNKdxX3dTji9h/nnq+
 DyVxjqEMTLzfmvf9rF+VsuCDz5HpdcqPX1r4qG3Kds57W2g1vSTE42tkz/vJ5ey5zipJL15x
 SPFdDJ19KdBv1tGXKj1KLMUZiYZazEXFiQBKEsF9rwMAAA==
X-CMS-MailID: 20230609083911eucas1p19c8484fdbfc404bdab8bec9ffe903153
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230609083911eucas1p19c8484fdbfc404bdab8bec9ffe903153
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230609083911eucas1p19c8484fdbfc404bdab8bec9ffe903153
References: <20230524111904.91179-1-its@irrelevant.dk>
 <CGME20230609083911eucas1p19c8484fdbfc404bdab8bec9ffe903153@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=j.devantier@samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 Jun 2023 10:58:41 -0400
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

On Wed, May 24, 2023 at 01:19:00PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen=40samsung.com>
>=20
> A set of fixes and small quality-of-life improvements for the TP4146
> (=22Flexible Data Placement=22) support.
>=20
> Klaus Jensen (4):
>   hw/nvme: fix verification of number of ruhis
>   hw/nvme: verify uniqueness of reclaim unit handle identifiers
>   hw/nvme: add placement handle list ranges
>   docs: update hw/nvme documentation for TP4146
>=20
>  docs/system/devices/nvme.rst =7C 37 +++++++++++++++++++++++-
>  hw/nvme/ns.c                 =7C 55 ++++++++++++++++++++++++++++--------
>  hw/nvme/subsys.c             =7C  6 ++--
>  3 files changed, 84 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.40.0
>=20
>=20

Looks good to me :)

Reviewed-by: Jesper Wendel Devantier <j.devantier=40samsung.com>

