Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1D7B6F9E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:21:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnj5J-0003oK-3Y; Tue, 03 Oct 2023 13:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qnj5C-0003o6-Rm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:21:18 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qnj5B-0005Rb-72
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:21:18 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20231003172115usoutp0295ed1fd9acfa28d676cc6ceff98fc4b3~KqK4HIaUj1443414434usoutp02G;
 Tue,  3 Oct 2023 17:21:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20231003172115usoutp0295ed1fd9acfa28d676cc6ceff98fc4b3~KqK4HIaUj1443414434usoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1696353675;
 bh=L/oXPBiyOKfWvl++IPrI12GS8F3SmGUNJTqkJD6qjZ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=DnIbiEir5nwkE1co0IIELPbAEua8wKr3H/sTMtLfot0Ev2ccp4TG+8R24SgDsKYU8
 Wpq+PiImcthZ2UfVrf0GvkI634CB5rIBu4W58altdvZk1lZRY3qd4O38XrxwGeZDbj
 V17bTKVEzf100ghm3pzYG7az3BzHfyNUxEVqc5s4=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231003172114uscas1p118b19e09e5f1195c309f07c99dabd281~KqK3-6Afr2538625386uscas1p1U;
 Tue,  3 Oct 2023 17:21:14 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 6D.DF.62237.A8D4C156; Tue, 
 3 Oct 2023 13:21:14 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20231003172114uscas1p139e0daedd9f7aaef6283371b7714a681~KqK3s4dvH2333023330uscas1p1V;
 Tue,  3 Oct 2023 17:21:14 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-4d-651c4d8aa4b9
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 63.CB.31410.A8D4C156; Tue, 
 3 Oct 2023 13:21:14 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 3 Oct 2023 10:21:13 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 3 Oct 2023 10:21:13 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Topic: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Index: AQHZ78Qy/F/p4vlW30uxS8vavRLTh7A40dSA
Date: Tue, 3 Oct 2023 17:21:13 +0000
Message-ID: <20231003172113.GC456865@sjcvldevvm72>
In-Reply-To: <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFF224568978A14A963D033CDEF7F056@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djX87pdvjKpBu8eGFvMX3ufxWLVwmts
 Foc3nmGy+P/rFavF8d4dLA6sHi1H3rJ6PLm2mcnj/b6rbAHMUVw2Kak5mWWpRfp2CVwZx56c
 YC/YxlPxZ9N35gbGxVxdjJwcEgImEps2nmLrYuTiEBJYySjxu6mTBcJpZZI4sPQbE0zVqYtX
 WSESaxklzt/fBtXykVHiyZ7DTBDOUkaJhZfOsYC0sAkoSuzr2s4GYosIGEm8uzGJEaSIWWAZ
 o8TMh+uBEhwcwgKuEl8fmkHUuEmcvTaLCaZ+waebrCA2i4CKxL32RnYQmxco/nDrB7AaTgEH
 ia7+T2A2o4CYxPdTa8BsZgFxiVtP5kOdLSixaPYeZghbTOLfrodsELaixP3vL9kh6nUkFuz+
 BHYOs4CdxPfJBhBhbYllC18zQ6wVlDg58wkLRKukxMEVN8BBJCGwh0PiZc8TdoiEi8TH++cZ
 IWxpielrLrOAzJQQSJZY9REa1jkS85dsgZpjLbHwz3qmCYwqs5BcPQvJRbMQLpqF5KJZSC5a
 wMi6ilG8tLg4Nz212DgvtVyvODG3uDQvXS85P3cTIzDtnP53uGAH461bH/UOMTJxMB5ilOBg
 VhLhDTsqlSrEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpiSWp2ampBahFMlomDU6qB
 yffo2sf3L/25KnDzFC+n4g+b+C6dlUtsrJJyxdjWrNLZ3qruey3swr/zTIpTdqVt+PpuYYvh
 skZDmQcXFF+LbZxp9+7wdp/r89Ys6zqz6nsTk8jSJae52bduYpmZ+kXobsxRF4033xiuVuSv
 4XxxoaQj6KjHgwjLCUx/z4vvk+ALsXzK9+lCzb2PUxmeOrX+nHRad9GRT9xTbF8qZen7nTlV
 tr03Nn/jtHO/9WOjW42jdafmdNmLpQsqre+2UC8qjutak6Gp9pzT0r+KV/5k7XJ2Z6vfU4ra
 3jioXRboPTF1y341/5ubzPOmX/xxSonVSFO2qGRG6+UO7/sBPsWXD5z5czr11QuNwA9bwp/6
 v1NiKc5INNRiLipOBAAx68L0qgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWS2cA0UbfLVybV4OdXWYv5a++zWKxaeI3N
 4vDGM0wW/3+9YrU43ruDxYHVo+XIW1aPJ9c2M3m833eVLYA5issmJTUnsyy1SN8ugSvj2JMT
 7AXbeCr+bPrO3MC4mKuLkZNDQsBE4tTFq6xdjFwcQgKrGSWm/5/HBOF8ZJS4On8GC4SzlFHi
 3sJGdpAWNgFFiX1d29lAbBEBI4l3NyYxghQxCyxjlHjQfxLI4eAQFnCV+PrQDKLGTeLstVlM
 MPULPt1kBbFZBFQk7rVDzOQFij/c+gFq82RGift/loIlOAUcJLr6P4E1MwqISXw/tQbMZhYQ
 l7j1ZD4TxA8CEkv2nGeGsEUlXj7+xwphK0rc//6SHaJeR2LB7k9sILcxC9hJfJ9sABHWlli2
 8DUzxA2CEidnPmGBaJWUOLjiBssERolZSLbNQjJpFsKkWUgmzUIyaQEj6ypG8dLi4tz0imLj
 vNRyveLE3OLSvHS95PzcTYzAqD3973DMDsZ7tz7qHWJk4mA8xCjBwawkwht2VCpViDclsbIq
 tSg/vqg0J7X4EKM0B4uSOO+OKRdThATSE0tSs1NTC1KLYLJMHJxSDUwrpye94LxZ4P9diSdg
 p+Fi0VrzaZ8c5R/b7glceidz38ypQi3+/Cuz79fbTTy5OexEP0+n9pxzMV9PmrEGFU9OPBtr
 7WRjUfHx0/QHHL6OeSbpdWftvTUOb4h32N6+7967j/vFl/HHf7y60rDNP+S5oHvsrvAE4YQt
 uk075mk/uWj+Zs61BhW/NrPYq9vzV7hqvZsxz8TGsc1n8tO5vCE/RF2n3nPacPSuyh47b5nD
 U9LSii/a3gg8r9dmHXMnqL6/bZOJr2BSm1PN9eNhDjOFFv49yKrbeE9xzsKVBgYszSUZn/We
 xmtZSbN+rrUJr1m30CH0ce4+zfKgK6/Wiv56POOfXd3ayzPy/xxccViJpTgj0VCLuag4EQDS
 Gv1ASQMAAA==
X-CMS-MailID: 20231003172114uscas1p139e0daedd9f7aaef6283371b7714a681
CMS-TYPE: 301P
X-CMS-RootMailID: 20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf
References: <CGME20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf@uscas1p1.samsung.com>
 <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 25, 2023 at 04:22:58PM +0100, Jonathan Cameron wrote:

> Rename the version not burried in the macro to cap_h.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>=20
> I had another instance of this in a series I'll post later today.
> Cleaned that up the same way.
>=20
>  hw/cxl/cxl-device-utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 517f06d869..bd68328032 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -283,13 +283,13 @@ static void memdev_reg_init_common(CXLDeviceState *=
cxl_dstate) { }
> =20
>  void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    uint64_t *cap_hdrs =3D cxl_dstate->caps_reg_state64;
> +    uint64_t *cap_h =3D cxl_dstate->caps_reg_state64;
>      const int cap_count =3D 3;
> =20
>      /* CXL Device Capabilities Array Register */
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
> =20
>      cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
>      device_reg_init_common(cxl_dstate);
> --=20
> 2.39.2
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

