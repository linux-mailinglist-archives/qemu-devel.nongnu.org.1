Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C097A4EB5
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiH1w-0003I5-GC; Mon, 18 Sep 2023 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiH1u-0003HM-Fr
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:23:22 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiH1o-0007so-Dc
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:23:22 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918162311usoutp026f5eeedf6fe18da045064679e6f15596~GCs5cVsVp1196511965usoutp02M;
 Mon, 18 Sep 2023 16:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230918162311usoutp026f5eeedf6fe18da045064679e6f15596~GCs5cVsVp1196511965usoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695054191;
 bh=HBoioh+3hphXZCVXmpCyitBe0p6eXJbltdl0WyymoRM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Btfq+a/DqZwwm20jcCvpDpK+6dSFnypbBtwTwVbxapRHz28xFApjRKfxJT3wnsKv7
 NPzELAjBeahqVGcI34lhk+vR40BrP8TqQOyHGAqcndTHRx1KpClIzxrvNW1Ca+vsmN
 Qvf08M5jci+jVc1ZobKHxZiwmK7xfXeesPU+nHUI=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918162311uscas1p1f643db4266816c8510b312d297378bb3~GCs5SVqd32708927089uscas1p1r;
 Mon, 18 Sep 2023 16:23:11 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 7D.B5.62237.E6978056; Mon,
 18 Sep 2023 12:23:10 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918162310uscas1p1ef42f98eb0735cc39287b07d13ed5469~GCs5CQ6RG0083100831uscas1p1_;
 Mon, 18 Sep 2023 16:23:10 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-c2-6508796ef1dc
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id E7.62.31410.E6978056; Mon,
 18 Sep 2023 12:23:10 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:23:09 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:23:09 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/4] hw/cxl: Use a switch to explicitly check size in
 caps_reg_read()
Thread-Topic: [PATCH v2 1/4] hw/cxl: Use a switch to explicitly check size
 in caps_reg_read()
Thread-Index: AQHZ5/bBuqh8uTzqMEOYM6Jz6t1xI7AhPj2A
Date: Mon, 18 Sep 2023 16:23:09 +0000
Message-ID: <20230918162309.GD3330304@sjcvldevvm72>
In-Reply-To: <20230915170418.21337-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7075BC693BD41F438D3273EC349A143A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djXc7p5lRypBjvuWFisWniNzeLwxjNM
 Fk/+fWe0+P/rFavFmhXCFsd7d7A4sHm0HHnL6nHn2h42jyfXNjN5vN93lc1jwtSlLAGsUVw2
 Kak5mWWpRfp2CVwZZ98sYy94wFXx5NlmtgbGfRxdjJwcEgImEksu72DtYuTiEBJYySixf85J
 KKeVSeLejJesMFWTLzxjgkisZZQ4/usUVNUnRokz1x6wQzjLGCWmrFjPAtLCJqAosa9rOxuI
 LSJgJPHuxiRGkCJmgZeMEl9v3wVLCAvESXS/ewJVFC9xfuM3RpiG/cc3MoPYLAKqEs+u3wOK
 c3DwChhL9E8oBAlzCjhKXOi8xARiMwqISXw/tQbMZhYQl7j1ZD4TxNmCEotm72GGsMUk/u16
 yAZhK0rc//6SHaJeT+LG1ClsELadxNEph1khbG2JZQtfg/XyAs05OfMJC0SvpMTBFTdYQH6R
 ELjCIXHz8w1oGLlIbFuzB2qxtMT0NZdZQG6WEEiWWPWRCyKcIzF/yRaoOdYSC/+sZ5rAqDIL
 ydmzkJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb56WW6xUn5haX5qXrJefnbmIEpqXT/w4X
 7GC8deuj3iFGJg7GQ4wSHMxKIrwzDdlShXhTEiurUovy44tKc1KLDzFKc7AoifMa2p5MFhJI
 TyxJzU5NLUgtgskycXBKNTAdZpLuyjZwaWWMXsxu+kT1+VfmdMY0MYGlZhIFWTZxN84JsrEV
 6G3SOfTGavYvwWuX3z34esix9Nn+0z2ZEssabk1s3RM6b1aZhUDX8fAuRcnKTX7Kj6r/Z+/j
 DxCJe+gisag/rHH6zb5jmznevdl33MZug/H2Pe9eqbj/P/1owaw/rLFyIsHf/j5Ji5Iyyslh
 YeINyD+pNC3xavyKv6bcRix1m+LVLoWo1Z1/r/tYYJ5Zc/2NCQEfJgiKvmBarxo1v+fk7cc3
 fvKvVPXqVGTnCFR8zbfFScvzypyM9xc4M0Tdb71/NVHqzHq121Pzz220uMpyRjh7ReCydC5m
 Tvv49tBrFl8+tsRxJa86/lCJpTgj0VCLuag4EQAp86GeugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWS2cA0STevkiPV4P46DYtVC6+xWRzeeIbJ
 4sm/74wW/3+9YrVYs0LY4njvDhYHNo+WI29ZPe5c28Pm8eTaZiaP9/uusnlMmLqUJYA1issm
 JTUnsyy1SN8ugSvj7Jtl7AUPuCqePNvM1sC4j6OLkZNDQsBEYvKFZ0xdjFwcQgKrGSVmrVvO
 DOF8YpTo+dPNCuEsY5SYvWgKC0gLm4CixL6u7WwgtoiAkcS7G5MYQYqYBV4ySny9fRcsISwQ
 J9H97gmQzQ5UFC+xKB6mfP/xjcwgNouAqsSz6/eAWjk4eAWMJfonFEKsOs0o8az5KyNIDaeA
 o8SFzktMIDajgJjE91NrwGxmAXGJW0/mM0F8ICCxZM95ZghbVOLl43+sELaixP3vL9kh6vUk
 bkydwgZh20kcnXKYFcLWlli28DVYL6+AoMTJmU9YIHolJQ6uuMEyARgeSNbNQjJqFpJRs5CM
 moVk1AJG1lWM4qXFxbnpFcXGeanlesWJucWleel6yfm5mxiBEX363+GYHYz3bn3UO8TIxMF4
 iFGCg1lJhHemIVuqEG9KYmVValF+fFFpTmrxIUZpDhYlcd4dUy6mCAmkJ5akZqemFqQWwWSZ
 ODilGpgU1z3e/4J5UcPGOYbVrq/N5Z56ZWeXsq780S0uP0/ppvrSd+9fM189Ou/qugfKxVNX
 tO9NuriEcfvNgrCM7WckprL4/gjMutM35+tlKxfDeQox3vs19/r94M/bk305z+CelcpP4Tk7
 /q2z0Y7TerDsX4VccWGx3aqD/+bdU52TObF48y9hnf+7v66Yfn6F1dJNrAcyHOax5Bwynpgo
 /vnc+VdzFP793lsua/tz0vFnjtJXZJ9NcLlkHiVmvq9ORidgU7N8sVGPxnXNzvSa4O8HYh7M
 4jnMtrKVS3TTDbs1b2UeLvi5XVN6Z5WI8Ub5XRUpuhOOruh76TNZziklbv3JtzMmSxswGppW
 ahrort4Zq8RSnJFoqMVcVJwIAIjhs8hXAwAA
X-CMS-MailID: 20230918162310uscas1p1ef42f98eb0735cc39287b07d13ed5469
CMS-TYPE: 301P
X-CMS-RootMailID: 20230915170454uscas1p28b8dffaaed5c78a383d8ef35ce3d9685
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
 <CGME20230915170454uscas1p28b8dffaaed5c78a383d8ef35ce3d9685@uscas1p2.samsung.com>
 <20230915170418.21337-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=211.189.100.12; envelope-from=fan.ni@samsung.com;
 helo=mailout2.w2.samsung.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 15, 2023 at 06:04:15PM +0100, Jonathan Cameron wrote:

> Bring this read function inline with the others that do
> check for unexpected size values.
>=20
> Also reduces line lengths to sub 80 chars.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-device-utils.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 517f06d869..cd0c45a2ed 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -32,10 +32,13 @@ static uint64_t caps_reg_read(void *opaque, hwaddr of=
fset, unsigned size)
>  {
>      CXLDeviceState *cxl_dstate =3D opaque;
> =20
> -    if (size =3D=3D 4) {
> -        return cxl_dstate->caps_reg_state32[offset / sizeof(*cxl_dstate-=
>caps_reg_state32)];
> -    } else {
> -        return cxl_dstate->caps_reg_state64[offset / sizeof(*cxl_dstate-=
>caps_reg_state64)];
> +    switch (size) {
> +    case 4:
> +        return cxl_dstate->caps_reg_state32[offset / size];
> +    case 8:
> +        return cxl_dstate->caps_reg_state64[offset / size];
> +    default:
> +        g_assert_not_reached();
>      }
>  }
> =20
> --=20
> 2.39.2
> =

