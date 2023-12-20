Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C627819EBD
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 13:13:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFvQO-0004Sx-4x; Wed, 20 Dec 2023 07:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rFvQJ-0004RF-A1
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 07:11:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.granados@samsung.com>)
 id 1rFvQC-0005hU-UN
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 07:11:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20231220121122euoutp0255cdefe3ca7b74a749b4bdcd7adceb38~iiQlQwqX62062720627euoutp02S;
 Wed, 20 Dec 2023 12:11:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20231220121122euoutp0255cdefe3ca7b74a749b4bdcd7adceb38~iiQlQwqX62062720627euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1703074282;
 bh=jf1itoqnSCWQMxKRVYJ4rtcdQPWS4NrHF1qWX0SmDUo=;
 h=Date:From:To:CC:Subject:References:From;
 b=IYxi+r2hS4Hjm5mmrwkYGRpWqHgwKIjZHKWrV9W0NIroMPmdeRNopeVdcVxhozmR3
 HJWRNBpcdwtMSyUrjAVWTxugEQhaAAWsNT3oXFSAs4nifZAcCgoFSxP410VQAeuMfe
 twFXmIMgmMVaY4F/IhCwWgaPFUby/vHfFaxtD1W4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231220121122eucas1p12840e769a683eb008ad90af7d21e44aa~iiQlHfGzk2300623006eucas1p1M;
 Wed, 20 Dec 2023 12:11:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.C7.09539.9E9D2856; Wed, 20
 Dec 2023 12:11:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe~iiQkuXusW2418924189eucas1p2W;
 Wed, 20 Dec 2023 12:11:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231220121121eusmtrp2d5ef8e4b2750f071e43cf72a873436f5~iiQktwDj62112121121eusmtrp2i;
 Wed, 20 Dec 2023 12:11:21 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-d3-6582d9e9889d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.1D.09274.9E9D2856; Wed, 20
 Dec 2023 12:11:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231220121121eusmtip1fd0d5baae3a102c2baa0723573a39480~iiQkfpCll2683726837eusmtip1R;
 Wed, 20 Dec 2023 12:11:21 +0000 (GMT)
Received: from localhost (106.210.248.220) by CAMSVWEXC02.scsc.local
 (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 20 Dec 2023 12:11:20 +0000
Date: Wed, 20 Dec 2023 13:11:16 +0100
From: Joel Granados <j.granados@samsung.com>
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, qemu-devel
 <qemu-devel@nongnu.org>
Subject: Questions regarding the still unpublished qemu series
 https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1
Message-ID: <20231220121116.hjfl7zkcm2q74aco@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="qinsnkny4rlrrm76"
Content-Disposition: inline
X-Originating-IP: [106.210.248.220]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87ovbzalGkz8ZWXx7X8Pm8WdS4oW
 M2ecYLRY+nYru8Xep4/ZLI737mCxmPvzGovF4lvnGR04PBbvecnk8eTaZiaP3uZ3bB7v911l
 89j6+TZLAGsUl01Kak5mWWqRvl0CV8b569+ZC+7xVvxuy25gnM7TxcjJISFgIrH3wTWWLkYu
 DiGBFYwSt1+8Z4JwvjBKNLddZgepEhL4zCjR2uYP0/H52iRmiKLljBIrZx1ghHCAim5N3Q+V
 2cooMfvYATaQFhYBVYkPl16DjWIT0JE4/+YOM4gtIuAl8fdPJytIA7PAU0aJdc8ugC0XFuhm
 lLhx8iAjSBWvgLnEk73trBC2oMTJmU9YQGxmgQqJx++nAm3gALKlJZb/44C4T1li/sRj7BB2
 rcSpLbfAZkoIdHNKXOl4wAiRcJH4+vc7E4QtLPHq+BaoBhmJ/zvnQzVMZpTY/+8DO4SzmlFi
 WeNXqA5riZYrT9hBNksIOErsmJgFYfJJ3HgrCHEbn8SkbdOZIcK8Eh1tQhCNahKr771hgQjL
 SJz7xDeBUWkWksdmIXlsFsJjEGEdiQW7P2EKa0ssW/iaGcK2lVi37j3LAkb2VYziqaXFuemp
 xYZ5qeV6xYm5xaV56XrJ+bmbGIFJ7fS/4592MM599VHvECMTB+MhRhWg5kcbVl9glGLJy89L
 VRLh3dvZlCrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA
 5HDYtbHWw+1sS9Zdm33CDqc1pIUmyi+tmXjkkvpMmz1z7kac/n10yUyVfU1xCadXi1q8VufK
 Trx4YLbdBefWixPZfX5OXOirfWDNB/+LB//VeKmtP7pRam9lzeIH/+uDG+o///nvsa8+o2km
 8+bL9014HT6aRzO16kSvFg3OYQ2cV/+VKZK/2KM1PVWHzbNk2dJ/XsWLj0kwZi5Ucvsz4+AK
 T88pCoE/p5sclu5Zus/zzHvBnO97v3/bNX3l1/w7e3+e0kwKqT1hJGkcUyuifqU4pL4xJvrC
 gma/nN6uJ7+PFClOKN4cI37Nf76Z9KFSb76Zx3XiTFXWzFPM6J69K9f3ZqC8/b4K24yfB2a+
 VGIpzkg01GIuKk4EAGicb3rlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7ovbzalGmxYKWfx7X8Pm8WdS4oW
 M2ecYLRY+nYru8Xep4/ZLI737mCxmPvzGovF4lvnGR04PBbvecnk8eTaZiaP3uZ3bB7v911l
 89j6+TZLAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
 vl2CXsaczQfYC+7wVuzr+cHSwDiVp4uRk0NCwETi87VJzF2MXBxCAksZJZa93MMOkZCR2Pjl
 KiuELSzx51oXG0TRR0aJDadXMoMkhAS2Mkp8WVYIYrMIqEp8uPQarJlNQEfi/Js7YDUiAl4S
 f/90soI0Mws8ZZRY9+wCE4gjLNDNKHHj5EFGkCpeAXOJJ3vbWSFsQYmTM5+wgNjMAmUSl/Z1
 AU3lALKlJZb/44C4SFli/sRjUJfWSnz++4xxAqPgLCTds5B0z0LohghrSdz495IJQ1hbYtnC
 18wQtq3EunXvWRYwsq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNZtx35u2cG48tVHvUOM
 TByMhxhVgDofbVh9gVGKJS8/L1VJhHdvZ1OqEG9KYmVValF+fFFpTmrxIUZTYHBNZJYSTc4H
 ppG8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamwq/p790NrvN7
 m8zbX3NXreKY9+dlXbP/eTbwTJ61+MCxN50VXo2hF9Puvl5U+ffw/NTy7Ts092j4cDu9fba9
 dn/5KRP5k35tNfc/LynavHTr/bfK9X5JJd+9peZ9PflSf929OMU3068c3p6bcrdG8fEM9zcy
 ldE1lVGFapURvmoMt+TdzPO82hdFGhnrSfBfF3auVw0XOMa1W9Z7+wmfX66VrVv9tScyLNOp
 kdF6ceNfy/f3q2+EOB974LbSqWW6rUkN1+W3a957qnCenfEz/eRlD6H1XQWSEw9zqB6t7OfN
 fXaZ5xzv2tLjaTFLlyn7Zqy71Ta9oT2tLXHxt7zZesyeMrFb5l6ZGaHrvjxOiaU4I9FQi7mo
 OBEAD40PIGsDAAA=
X-CMS-MailID: 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe
X-Msg-Generator: CA
X-RootMTR: 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe
References: <CGME20231220121121eucas1p23ee600a82137ce935bf182e0e8ce76fe@eucas1p2.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=j.granados@samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

--qinsnkny4rlrrm76
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Everyone

While running https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_=
nesting_rfcv1
I have come across particular code path that seems odd:

I'm hitting an assert in softmmu/memory.c:1994 after calling a
notification from vtd_flt_page_walk_level. The code in memory.c:1994
makes sure that when type=3D=3DIOMMU_NOTIFIER_UNMAP, the permissions are
IOMMU_NONE. But the code in vtd_flt_page_walk_level sets the
permissions to read|write. This is part of the "intel_iommu: piotlb
invalidation should notify unmap" commit in the iommufd_nesting_rfcv1
series.

Question is: Why assert on the permissions being NONE if they might be
read|write?

Hope this makes sense. Don't hesitate to get back to me if you see that
there is something missing in my explanation.

Best

--=20

Joel Granados

--qinsnkny4rlrrm76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWC2dIACgkQupfNUreW
QU+5fAwAgXb3egb+27OTfORRnfXqfr5ZRvlhBUaybTB6z4uciKyeUdO4Zxqhcz7N
8vTqHvOYcs03iMDe+jakgJqlMAZYFJdtO63qBcDkpRCzgpCwM2iDVCuy7E+Na0eE
raN7QSnh09AQDg8EesuJoBXfRnNjTPCh2Prjy/9EZv2Vp7gHwfXHAMKwc4KBC9of
/zkvVymUe5xi4gNNmJlpkbvivq0BgNlZkDYuE1440eRg8iEDvjeHrffqvWwtpLBZ
k7YfouwC3VveygMhdC/E1wURxbwWXclOR62eU8/2tq5lDH9pmcfTk4A+y8yDEnx4
9sxFUWY/2+834VRhByk9BBUjkVkqXNDaYwSMF5hjb3oAmVXIhH/NKndaZrBZ/VKd
7cq4l2mHdJKkhwfbIt42jO084a6z6X7deeap9nznGVp4LLz+LqKyJyubJPMdh1S+
WdND/ArB+GWqLv56PVH35nNFdMqgJTpTD1OeC0dK4tsTUFvMHH5hmo6VZMengqa7
Av9lk8Y1
=cata
-----END PGP SIGNATURE-----

--qinsnkny4rlrrm76--

