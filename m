Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEE7B6F9D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnj4Q-0003ZX-IH; Tue, 03 Oct 2023 13:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qnj4N-0003Z8-RX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:20:27 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qnj4L-0005DO-8W
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:20:27 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20231003172015usoutp01866b8a936033f57c3077f77e587105c4~KqKAkexfw2623526235usoutp01U;
 Tue,  3 Oct 2023 17:20:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20231003172015usoutp01866b8a936033f57c3077f77e587105c4~KqKAkexfw2623526235usoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1696353615;
 bh=mrFadn30Q3g66fU5GYMzu91hRqBx9oxYMQyHylmZN78=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=TVZ0KWhmlonrsLVisBjAI5sMu+VAHZQsAsMQch4rqdGsOxlON0sx45Lnh+FW6Qogi
 4FEQEHiwk0jpH2ci8ZGBuui/ybE2u6PRGZrknsp0VjySFVUTA+ofGoTHWUQOGmEbfT
 EKh3XLvgs0H8QJTU+qhcA+9XxYzP0zXgYRsNzhjg=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231003172015uscas1p10b564aad36bebd86020d801434785655~KqKAaohkh0413804138uscas1p1j;
 Tue,  3 Oct 2023 17:20:15 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 59.55.50148.F4D4C156; Tue, 
 3 Oct 2023 13:20:15 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231003172014uscas1p21d07b353671b24534e5eaffcdd11cc3e~KqKAHs-181083510835uscas1p2P;
 Tue,  3 Oct 2023 17:20:14 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-d6-651c4d4f7faf
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 5C.9A.31200.E4D4C156; Tue, 
 3 Oct 2023 13:20:14 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 3 Oct 2023 10:20:14 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 3 Oct 2023 10:20:14 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, qemu-devel
 <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Topic: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Index: AQHZ78Qy/F/p4vlW30uxS8vavRLTh7AvgzWAgAEfoYCAANDeJIAHXdmA
Date: Tue, 3 Oct 2023 17:20:14 +0000
Message-ID: <20231003172013.GB456865@sjcvldevvm72>
In-Reply-To: <878r8ph0zr.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <963AEFDA57E3D2479C7A2391DDB550B4@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djXc7r+vjKpBu9vc1vMX3ufxWLVwmts
 Foc3nmGy+P/rFavF8d4dLA6sHi1H3rJ6PLm2mcnj/b6rbAHMUVw2Kak5mWWpRfp2CVwZ/Vem
 MxccYquYem4BewNjJ2sXIyeHhICJxMmlfexdjFwcQgIrGSW2nN7CDOG0MkmsPb2BDabq0aou
 qMRaRon22wcZIZyPjBIrz/1jg3CWMkoc+TSVHaSFTUBRYl/XdrB2EQFNiRkv3rKCFDELrGeU
 +DHtJ5DDwSEs4Crx9aEZRI2bxNlrs5hg7IvP7oHZLAIqEn9+bmcEsXkFjCTWbVoGZnMKaEk8
 /vuNBcRmFBCT+H5qDVg9s4C4xK0n85kgzhaUWDR7DzOELSbxb9dDqHcUJe5/f8kOUa8jsWD3
 JzYI207i05EZrBC2tsSyha+ZIfYKSpyc+YQFoldS4uCKGywgv0gI7OGQOD3rMjQkXSQadrdA
 FUlL/L27jAnkRwmBZIlVH7kgwjkS85dsgSqxllj4Zz3TBEaVWUjOnoXkpFlITpqF5KRZSE5a
 wMi6ilG8tLg4Nz212DAvtVyvODG3uDQvXS85P3cTIzD1nP53OHcH445bH/UOMTJxMB5ilOBg
 VhLhDTsqlSrEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpiSWp2ampBahFMlomDU6qB
 aTpv4pJYfuPz+1n5bn+s1/0+jaPZJP7884lL4hevzJy9mPfPM9vJBdvXqZ3Uql7C6Xzic2WJ
 BXfM09jEI/qR9V+NOwzjzhRb65Sxxgs9PHJeeB3fd3ZmzU0rC7+rhIolZ3numr3n2Ho73eb+
 9o02oixC+2a453XKndWvzBcPz17j8JzDcfXT72pMHTfWFC2Yv+aZTbJaZ/CJrPYrbW9EtLST
 mbMbN3CcvL9eVUL4Pk/zHdFTFc/smI6/nBvxYMUt9s9zn25PmydrW79t2YZfExUl15ZHsF44
 2SPHucDu9GP37Te+W4VONE5UFtzLcMz6BWPoWd/U+zlMbEv+Va5Xa1okfvZSqO/fJKGSGayf
 lFiKMxINtZiLihMB5J5jAawDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWS2cA0SdfPVybVYOYxQ4v5a++zWKxaeI3N
 4vDGM0wW/3+9YrU43ruDxYHVo+XIW1aPJ9c2M3m833eVLYA5issmJTUnsyy1SN8ugSuj/8p0
 5oJDbBVTzy1gb2DsZO1i5OSQEDCReLSqi7mLkYtDSGA1o8TSV4egnI+MEt+XfWCCcJYySjxd
 /gGshU1AUWJf13Y2EFtEQFNixou3rCBFzALrGSV+TPsJ5HBwCAu4Snx9aAZR4yZx9tosJhj7
 4rN7YDaLgIrEn5/bGUFsXgEjiXWbljFCLGtiktjwopEZJMEpoCXx+O83FhCbUUBM4vupNWDN
 zALiEreezGeC+EFAYsme88wQtqjEy8f/oH5TlLj//SU7RL2OxILdn9ggbDuJT0dmsELY2hLL
 Fr5mhjhCUOLkzCcsEL2SEgdX3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLY
 KC+1XK84Mbe4NC9dLzk/dxMjMHJP/zscvYPx9q2PeocYmTgYDzFKcDArifCGHZVKFeJNSays
 Si3Kjy8qzUktPsQozcGiJM67Y8rFFCGB9MSS1OzU1ILUIpgsEwenVANTzoG1mpsYN3lcr6ry
 1TD73Be30y/kxF/WQ2ta2+t/mLQ5yXxvedD/+Nz8hvLXH+fwz8ta/fTlxaLOnt0hsx1jPh5V
 3nVsX9gaJv149UfLTxyVTAxZ65m0c23UXtdz017vfPXo1g3/m1Wr1Wr5boSd6nAQZJi45rTH
 k19B0lYsC5rbN15ifJ1xo3L9PI+dCQvWWc6/oiKZVJsko2YhnKMRsXVBLfO3VXtuWH/OT1GK
 kF3T3CnmKzZ3WXO279lH9+Ve9U7fGsq5/tWxoj3Pwnarc8ic9N+Qcujyn7RIBs5b930dfkmt
 qDJZx9Mkbn/S89p/pnmz7W86rm90CMg/u/LRg4R1LfvtfPc8iv5ztux6sxJLcUaioRZzUXEi
 AFZRBTxLAwAA
X-CMS-MailID: 20231003172014uscas1p21d07b353671b24534e5eaffcdd11cc3e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf
References: <CGME20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf@uscas1p1.samsung.com>
 <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
 <20230927191327.GA4138120@sjcvldevvm72> <20230928132257.000039ce@Huawei.com>
 <878r8ph0zr.fsf@pond.sub.org>
Received-SPF: pass client-ip=211.189.100.11; envelope-from=fan.ni@samsung.com;
 helo=mailout1.w2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 29, 2023 at 09:50:16AM +0200, Markus Armbruster wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>=20
> > On Wed, 27 Sep 2023 19:13:35 +0000
> > Fan Ni <fan.ni@samsung.com> wrote:
> >
> >> On Mon, Sep 25, 2023 at 04:22:58PM +0100, Jonathan Cameron wrote:
> >>=20
> >> > Rename the version not burried in the macro to cap_h. =20
> >> The change looks good to me. Just one minor thing. why "version" get
> >> involved here?
> >>
> >
> > Used in the sense of two copies of something with slightly differences
> > given if it were straight code without a macro, we'd have just
> > have used the copy being changed here for all of the calls.=20
> > With hindsight, not the best word to choose given the many other meanin=
gs!
>=20
> Fan, good enough to get your R-by?
>=20

Yes.

Fan=

