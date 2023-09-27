Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112B7B0C75
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 21:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlZyx-0002Aq-Ky; Wed, 27 Sep 2023 15:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qlZyp-0002AM-6n
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:13:51 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qlZyk-0000Q7-F9
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 15:13:50 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230927191336usoutp021b4f02735b0c99b1a3a9b6efc62d491e~I11RBUtJb2104021040usoutp02N;
 Wed, 27 Sep 2023 19:13:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230927191336usoutp021b4f02735b0c99b1a3a9b6efc62d491e~I11RBUtJb2104021040usoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695842016;
 bh=ArgOylOrDceiKe/mjaHMRWtSCuGnuMHi3vdmLrceHW0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=cbu32ohfkyVJDXUU24YPG0tnsWuWUW5YzqptSr0GiMoI2uCnXizXoxxRpEg5qkjbp
 n2PFx/HOUDzNNvNJ3cWsLLAcP6Yvl5I82MxkSjHxD3xLO9z3Auo+DUg75iHdc5k1VO
 bRX4yJ0NpxEJd2S0ycPfye7+LXfwp0WXiRW0oJ7I=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230927191336uscas1p2741291ebafe3069dc6b9df1f6ff53b1c~I11Q3wolm1029810298uscas1p2B;
 Wed, 27 Sep 2023 19:13:36 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id C4.33.40279.0EE74156; Wed,
 27 Sep 2023 15:13:36 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230927191336uscas1p26bf4962817c86baf7b75fd7eb7f795fe~I11QrRgst0172901729uscas1p2r;
 Wed, 27 Sep 2023 19:13:36 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-36-65147ee028c1
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 41.08.31410.FDE74156; Wed,
 27 Sep 2023 15:13:36 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Wed, 27 Sep 2023 12:13:35 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
 27 Sep 2023 12:13:35 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Topic: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Thread-Index: AQHZ78Qy/F/p4vlW30uxS8vavRLTh7AvgzWA
Date: Wed, 27 Sep 2023 19:13:35 +0000
Message-ID: <20230927191327.GA4138120@sjcvldevvm72>
In-Reply-To: <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F91F9AD4B929948BEF84AA2CF1C252C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/fV9aJwm0t/lj02CnKVaQ8blBaVIvWH9gDLoFp6UvMx2dVm
 QZK9GajRSzZrask0aZM0ytIydZmlZS+tzNDVqMyelpnWrLZbsP8+53w/5/y+HA5LSk7QE9ik
 tAysSVOlyBmOutQ82D67N1uKg3JqxyuLzD2UsqKkk1E2XWgjlL9H3tHKW7k11FI6cr/1Ax1p
 76wmIj9d72CiyVhucTxOSdqBNXPCtnCJD/r66fTXnlkV76k9yMrpEMsCPx8OGWN0iGMl/DkE
 n5tzGHFxgADTmzdIhzxckrVllBIDM4LCPBPtDCT8AAJ7gVoMTAgsdv1YZ8DwMriuu8w4WcrP
 hY9PjyKnRDolva2Scc725sNh0BYiOhFwt9NA/Pe76ztIJ1P8dGjJKaec7MXPA8cRvYs9+KWg
 yx9w+Yj3gaE7511M8r7QZS8ixNbj4ExhHSmyD4xetTEiy6BnqG+s6M+C4toBRuQwqHpcTYo8
 E0wl/aQ4dxzc1tsp8awfNJQ/db0E8DUsmL81MOI7roCGDpnoTISC848ocTsOKr5w4nYKFJVe
 /HfNIij5VUkcQdMMbq0Nbo0Mbo0Mbo0Mbo2KEV2BfDMFITUBC3PTsDZQUKUKmWkJgXHq1Cr0
 9+e0jjapa9CTri+BjYhgUSMClpRLvWzPJVjiFa/auQtr1Js1mSlYaEQTWUru6xUcejtOwieo
 MnAyxulY8z8lWI8Je4io4aOF70e6ik63xzpibI707Gv0anjZHlHPrWy7IQ9IehtJ/9i6fW1E
 q3mb/pe5P9Hf6Jn7dejeGp995ti3oWUnDmPP+w/vR82cJ7UEfN85ec7ZBa9kUxeVEZXSDO91
 YxSOY9Kb/LaFikntNvzgycfU0hALsoWF2UOPyRTlMyYb/FqO1015tVvtl3mwbmMQ9z3ZUXbu
 cLf/DCGvJ9oamji8zFPbO7KpOT+5qcBC1GZ9bTj1M7vYf0lf96q8pCuW8PArQYsH9/YWXs0w
 7ig7dM2YjzmlNpcIVp1MX6+mFfV3ngVGaDe8MMaMMUbZmL5hzop/bgo4u7xSZ2amxZu0WSFy
 SkhUBStIjaD6A49hkfuoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWS2cA0SfdBnUiqwfEeVov5a++zWKxaeI3N
 4vDGM0wW/3+9YrU43ruDxYHVo+XIW1aPJ9c2M3m833eVLYA5issmJTUnsyy1SN8ugSvj4svX
 rAXPeCpWvWFpYDzC1cXIySEhYCJx5MQ/li5GLg4hgdWMEle+7GcGSQgJfGKU2H6uCCKxjFGi
 a+0RsASbgKLEvq7tbCC2iICRxLsbkxhBiphBih70nwRyODiEBVwlvj40g6hxkzh7bRYTTP2d
 /VfB5rAIqEqcaFzBAmLzChhL/J0wE+qKyYwS9/8sZQdJcAo4SHT1fwJrZhQQk/h+ag2YzSwg
 LnHryXwmiBcEJJbsOc8MYYtKvHz8jxXCVpS4//0lO0S9jsSC3Z/YIGw7iU1XNjND2NoSyxa+
 ZoY4QlDi5MwnLBC9khIHV9xgmcAoMQvJullIRs1CMmoWklGzkIxawMi6ilG8tLg4N72i2Dgv
 tVyvODG3uDQvXS85P3cTIzBqT/87HLOD8d6tj3qHGJk4GA8xSnAwK4nwPrwtlCrEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmcd8eUiylCAumJJanZqakFqUUwWSYOTqkGplUb1rUcf5a1bNFDqe8t
 W+NVlvuETtwYwaPaL6PZ68WxNWa38zULV71HVnrXF77bEyZo1D7Rxjfp+19Bx7XTDnBq+l5l
 lFW3PWH666rU/9t7Hk1bXZUeH3RhTt023/nlwV7XDVktZwk2atvuXKt645TZnLpbITOvG0ws
 KHF8dsXnfEX4zdkFPKcWyvlU9rH/Vft1025pzJJzPrZZ/i8tNGIF1i+IejuNY9KWLIkELd6+
 8F2Z51PCtYN8nXgUPDXPn5oRWZi/4sRNZudaKVEB53sHV95QMd6ZkpIcxfJQwf3K0x9Kb28w
 1qTs2SBw4ePEGc9/qd6QM9jqe357Ls+7rLX6RZEzVN1Cl2Xq77uQqMRSnJFoqMVcVJwIAKkw
 w/pJAwAA
X-CMS-MailID: 20230927191336uscas1p26bf4962817c86baf7b75fd7eb7f795fe
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
The change looks good to me. Just one minor thing. why "version" get
involved here?

Fan
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
> =

