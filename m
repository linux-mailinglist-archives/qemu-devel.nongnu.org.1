Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6E81D405
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Dec 2023 13:42:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rH1J8-0005W2-Si; Sat, 23 Dec 2023 07:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rH1J4-0005Vl-8H
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 07:40:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rH1J0-00054a-KC
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 07:40:42 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20231223124027euoutp01ac644701160097fb1374dc121a208713~jdl1FTglF0545305453euoutp01h;
 Sat, 23 Dec 2023 12:40:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20231223124027euoutp01ac644701160097fb1374dc121a208713~jdl1FTglF0545305453euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1703335227;
 bh=iFolOpv5pXwKn8cZ5PVjnkEqEsKZ6PdKYAftGee2zU4=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=gFutZAblKphPsPIAVgmxE7S95QbElZuTmqSYay/pOFXkEOxM2ZqtWpQBzXH1Iou2c
 M6rO3kLyLcv6PjJO8pSX4zSHRC/pkCU9bvCFQ+26BkCZMZbGnJ33+67nIHHjCspkOB
 U+cncQWSQFNkvv2U/1W/8PtChh4A7y9Wpqm0NLhs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231223124026eucas1p29aef4ec586afb90dbf4ee649989d4ee4~jdl09gSDl1955819558eucas1p2_;
 Sat, 23 Dec 2023 12:40:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.BA.09814.A35D6856; Sat, 23
 Dec 2023 12:40:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231223124026eucas1p2d23e728f0e03ef9bc0600370562dd641~jdl0lP07m1954619546eucas1p2u;
 Sat, 23 Dec 2023 12:40:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231223124026eusmtrp2ab29df26884c979c5178ea3f56f36d7d~jdl0kI6-Q0268002680eusmtrp2A;
 Sat, 23 Dec 2023 12:40:26 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-8d-6586d53af26e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 30.00.09274.A35D6856; Sat, 23
 Dec 2023 12:40:26 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231223124026eusmtip172e3074d257318770ccaca1df220c0f9~jdl0UWPDN1902919029eusmtip1F;
 Sat, 23 Dec 2023 12:40:26 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 23 Dec 2023 12:40:24 +0000
Date: Sat, 23 Dec 2023 13:40:19 +0100
From: Joel Granados <j.granados@samsung.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, Nicolin
 Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Questions regarding the still unpublished qemu series
 https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1
Message-ID: <20231223124019.ze6tnp7ajpyl3r3k@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="mpfldsa5llmtzhrq"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB67446F6273D60FADEFB6F2AA9295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-Originating-IP: [106.210.248.246]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87pWV9tSDc4/1rf49r+HzeLOJUWL
 mTNOMFosfbuV3WLv08dsFsd7d7BYzP15jcVi8a3zjA4cHov3vGTyeHJtM5NHb/M7No/3+66y
 eWz9fJslgDWKyyYlNSezLLVI3y6BK+PrSvGCfaIVp2ZvYG1gXCvUxcjJISFgIvFmySu2LkYu
 DiGBFYwSJ6e/ZIdwvjBK/P5/jAnC+cwoMW/ZJpYuRg6wlvUL4iDiyxklpv35xQhXdP1VNyuE
 s5VRYtPOXawgS1gEVCW+7vjOAmKzCehInH9zhxlkkoiAgcSZF+Ig9cwCXUwSz6YtBZskLNDP
 KDHrVR8jSAOvgLnE60sTWSBsQYmTM5+A2cwCFRIHDi5hBxnELCAtsfwfB0iYUyBWYunueawQ
 zylL3Pz1jhnCrpU4teUW2DsSAss5JR4eXswIkXCR2LP6HlSRsMSr41vYIWwZif8750M1TGaU
 2P/vAzuEs5pRYlnjVyaIKmuJlitP2CEB4yixY2IWhMknceOtIMSdfBKTtk1nhgjzSnS0QQNe
 TWL1vTcsExiVZyH5bBaSz2YhfAYR1pFYsPsTG4awtsSyha+ZIWxbiXXr3rMsYGRfxSieWlqc
 m55abJSXWq5XnJhbXJqXrpecn7uJEZjUTv87/mUH4/JXH/UOMTJxMB5iVAFqfrRh9QVGKZa8
 /LxUJRHefJ2WVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5O
 qQam4u0Ptzmen6aoFr//0V2L+LAqvTZN54aLrukT2K7NDi3Pubowe3dMcpp4plha0vYz2ef9
 T+16sGXLjHu7Pt62dPq4i9vE6HDkhImTVN+tbHKJ7fqTzHHyYUmzmlOvw4eTCjF2bnIhlbsm
 ZTcfOpDiumvB1zitptKTa1/KC1eIyqte41r06N9Fx18+Io+XVDbOMZ+fqZV4KfHkk6k5TM2t
 xZyTd8fvfXIotNKRr8+H6YDktc/ZydUqV7oeGdZv27f7YZPs+xM60pKf381Ly/mlbHVSKN1z
 0YHXavvdX2/8Vx75buf8vlAZzVXWgo/6FVJsp864r5az6LR42eFPBglf2esvWb0Qvvz9vlPQ
 8Sp3JZbijERDLeai4kQAE3LeyOUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7pWV9tSDe4uFbH49r+HzeLOJUWL
 mTNOMFosfbuV3WLv08dsFsd7d7BYzP15jcVi8a3zjA4cHov3vGTyeHJtM5NHb/M7No/3+66y
 eWz9fJslgDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI
 3y5BL+PbwttsBXtEK67OOs3YwLhaqIuRg0NCwERi/YK4LkYuDiGBpYwS105dZupi5ASKy0hs
 /HKVFcIWlvhzrYsNougjo8T1ib+ZIJytjBKbH3axg1SxCKhKfN3xnQXEZhPQkTj/5g4zyAYR
 AQOJMy/EQeqZBbqYJDbOuMkI4ggL9DNKzHrVxwjSwCtgLvH60kQWiKn3GCX2zJrKDpEQlDg5
 8wnYVGaBMomPJ1cygkxlFpCWWP6PAyTMKRArsXT3PKhTlSVu/nrHDGHXSnz++4xxAqPwLCST
 ZiGZNAthEkRYS+LGv5dMGMLaEssWvmaGsG0l1q17z7KAkX0Vo0hqaXFuem6xkV5xYm5xaV66
 XnJ+7iZGYHRvO/Zzyw7Gla8+6h1iZOJgPMSoAtT5aMPqC4xSLHn5ealKIrz5Oi2pQrwpiZVV
 qUX58UWlOanFhxhNgcE4kVlKNDkfmHbySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNT
 UwtSi2D6mDg4pRqYAq6sPqzydfH++VYP+OyX7syKlC1Z9a4pb+dyj1bd413353l+7Jjh/H1h
 iNfnvNDt7k99QtiDitlDZ1jvXd6WaPAy8NE25dlXg6Q/TjbeYTjXMfRKg5vYCumZ9dErIu06
 Hx9enR1hnbixU62ULytL4cId8SP3HN5qHJrLujymt6J29tOTmw/YC33h3jPLW+vTrqaVd7a7
 FFjXGB0R2q636G3bflbb2/LXxP+FZuaJ3LkQX7T/z1yrC8Iym1pPrHoYqGb5+cpjr2K5nom+
 q7jXRbtZVqQWtP2ITvol8v7WkT1heuEV60JPan83nDDNZlb3b6v9k694dBmL/y7dJyGaERtT
 xHtONHbziRtFIYa1SizFGYmGWsxFxYkAmOqAToMDAAA=
X-CMS-MailID: 20231223124026eucas1p2d23e728f0e03ef9bc0600370562dd641
X-Msg-Generator: CA
X-RootMTR: 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe
References: <CGME20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe@eucas1p2.samsung.com>
 <20231220121116.hjfl7zkcm2q74aco@localhost>
 <SJ0PR11MB67446F6273D60FADEFB6F2AA9295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=210.118.77.11;
 envelope-from=j.granados@samsung.com; helo=mailout1.w1.samsung.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--mpfldsa5llmtzhrq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 03:33:47AM +0000, Duan, Zhenzhong wrote:
> Hi Joel,
>=20
> >-----Original Message-----
> >From: Joel Granados <j.granados@samsung.com>
> >Subject: Questions regarding the still unpublished qemu series
> >https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting
> >_rfcv1
> >
> >Hello Everyone
> >
> >While running
> >https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting
> >_rfcv1
> >I have come across particular code path that seems odd:
> >
> >I'm hitting an assert in softmmu/memory.c:1994 after calling a
> >notification from vtd_flt_page_walk_level. The code in memory.c:1994
> >makes sure that when type=3D=3DIOMMU_NOTIFIER_UNMAP, the permissions
> >are
> >IOMMU_NONE. But the code in vtd_flt_page_walk_level sets the
> >permissions to read|write. This is part of the "intel_iommu: piotlb
> >invalidation should notify unmap" commit in the iommufd_nesting_rfcv1
> >series.
> >
> >Question is: Why assert on the permissions being NONE if they might be
> >read|write?
> >
> >Hope this makes sense. Don't hesitate to get back to me if you see that
> >there is something missing in my explanation.
>=20
> Thanks for your report, you are right. We had seen the same issue with
> vhost device and have it fixed internally. Did you also use a vhost device
> or not?
>=20
> The link you used is a bit old, could you try with https//:github.com/yil=
iu1765/qemu/commits/zhenzhong/iommufd_nesting_rfcv1/
I thought it was the same branch, but I see that it does not have the
"wip" in the path.

Great!. I'll try this as soon as I get some free cycles (they are
difficult to find in holiday season:) and get back to you if I run into
anything else.

Thx for the link.

Best

>=20
> Thanks
> Zhenzhong

--=20

Joel Granados

--mpfldsa5llmtzhrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWG1SQACgkQupfNUreW
QU8Biwv/adWM55GMn57+3Cq3bt07CelxbHNCME9aH7MYIAYKg3gqS545J52jFjkm
kZICCAJbzIzEy5QFVQxPULw/GBxw3eW9jpgzWofEQfnW/R/z37B41na3o2awj3qU
bYFXEU7r1ZwRypxRNB+Y6kWWcynejHMi7c+Jm/iqRu9ic7ojC/KQnNBwiIhpjUJc
boLBfXkic+XzNc2PvGIv+BrwF3EYd4rG4Zsd53hR8aJxrMcVHod1e+LZC2iaH0qw
c2/eHxcXUpVYnBrIIBYF27iQHq4VzFffloBcD2x8zvHS++NdtEa08WGh4vJjC/zL
Nc1ZYTNMMuKKBTyKd6QwWSQdIr9brOXrayQ44i1zRKB/x5caDItzgpP0ZQJvsi+F
1Ug1SQmqBPFU/o2YAbvrnM/3v7e6yr5jyGHAWWBuv2Md+/BINKWvtjcULY4kAXAK
7wVBTJUnnHd64SYb+W9XMtpA2aw4hSaaL6T6WIyRyer7aa3ZH6n+cNcr2dX5noKY
KBHZ+EZC
=LgSm
-----END PGP SIGNATURE-----

--mpfldsa5llmtzhrq--

