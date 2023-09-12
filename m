Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 828F679DAA2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAqO-0003rI-3B; Tue, 12 Sep 2023 17:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAqL-0003r0-Ao
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:22:46 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAqI-0006O0-1N
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:22:45 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230912212235usoutp01ed301f252e6d37126619df4476403aa4~EQ6m2bW9y0680606806usoutp013;
 Tue, 12 Sep 2023 21:22:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230912212235usoutp01ed301f252e6d37126619df4476403aa4~EQ6m2bW9y0680606806usoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1694553756;
 bh=SYvbnKo2sb9mKtI57XTS8IXRPs9ojxS/MTYYcxJ5hs0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=WZelynJ2Q8Hyvm/Unmkt+y4Im+BWnhOOyPe76JwRWj8EOMOoD1AiJyx1ADOwIl/fZ
 fuwOD9/jcQgGvS/iymOe4URALNiT4fVAB7ujdtNhNv3KhmTO5pauJ/Ah3mZq/Ncrkg
 CTsjAQL9/iw9qbHHp98EwOfaQHTk5BgtZT0TGEQE=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230912212235uscas1p2046a74fcbcdd28c1d0a11f83a5a3b8d1~EQ6mwJyAn0898208982uscas1p2P;
 Tue, 12 Sep 2023 21:22:35 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 44.2B.50148.B96D0056; Tue,
 12 Sep 2023 17:22:35 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230912212235uscas1p108e0b8173a84f73bee0b84ee602a88b0~EQ6mfPD4p2551725517uscas1p1f;
 Tue, 12 Sep 2023 21:22:35 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-8c-6500d69b9e9d
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F1.C3.28590.B96D0056; Tue,
 12 Sep 2023 17:22:35 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 12 Sep 2023 14:22:34 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 12 Sep 2023 14:22:34 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "Li Zhijian" <lizhijian@cn.fujitsu.com>, Dave Jiang <dave.jiang@intel.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH 1/4] hw/cxl: Fix CFMW config memory leak
Thread-Topic: [PATCH 1/4] hw/cxl: Fix CFMW config memory leak
Thread-Index: AQHZ3zO5qoDvJPDU50aXD0Diw5uLobAYNWoA
Date: Tue, 12 Sep 2023 21:22:34 +0000
Message-ID: <20230912212225.GA2859961@sjcvldevvm72>
In-Reply-To: <20230904132806.6094-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4647D00079BE664CBF2CD4716AA34E4A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTURCHfbvbslSJS4syaoKKeEFEUdQ1SiNRSY3G4BE1HtEWlkKkQLrU
 +yje1iheoBSNXFbEqnhwaBqP1iAtKIJQKCEesR6ASNRAA0IrZSHy3/dmfm/eN8kjcWERbywZ
 l5DMKBOk8f58AVFc1lE1I9M6jJml+ziTLrel8OmCbCufrtJaCNp0vxKj7za6eLSru4VH6/NF
 9KszpcRiUuJ6cQGXHH3ZxpPkGpoxSZPVwJfYrQ8xSfvTOr7kzwO/SI9NgkXRTHzcTkY5U7xd
 ENtqWp/UNnK33n7FQ400IzTIkwQqFLJ6c3ANEpBC6haCGmsNjzscw+Da2d/8wVTv1Q+Em4XU
 HQQtp9Zyod8IuvJf4lxDh6DdnORmPjURnmpK+i/7ULPhZ8MF5GaceoOBWj/PzSJqEdjL2hGX
 CYO3qRpsMF/sMPYzQU0Gizmjf44XNQdqy9/x3OxJLQZ9U2q/EKJGg8Oix7j5vtBov45x0t6Q
 k2nAOR4NziefBpaZCB8czR5cPhga0i711ck+FkOhLpErB4EuuxXnnvUGc4ad4K6OgRf5DYR7
 d6B+kGDLsCOusRSclo6B0Dioq0/D3TOBioKCXwKuHA/X8x4NRBZCds897BwK0A6x1g4x0v43
 0g4x0g4xykK8AuSrYlmFnGFDEphdwaxUwaoS5MFRiYoHqO9nVThNilJU2vgr2IgwEhkRkLi/
 j1eysTda6BUt3bOXUSZuU6riGdaIxpGEv69XSJg5SkjJpcnMDoZJYpSDXYz0HKvGNjz+dux4
 vUOuFk+SZW5dvSZk85T041veVoeGHyoUbTeHV6+0Feh7sg6fUBMHO3VXZZ3TSy7fXLlA+yzI
 mPb84v6unuzhfvkbbLWWYtO32oh9cebo96+kor0u9jlh/pwq6namTLiN3U7XVNTRX3JvKIuc
 8z13Bx35WOnMGLX8bKReRnYEFJvqY0bkruhNryzJWz8sYm7g95MBnVFg+3n6XtGjL/KYlsCw
 ZQdScqtkqtfzvnbU/O0qMaCuCbsi/17MYQrrxBsrdNMIb4efqxsvQuNHTb2mKvM539yoRlu7
 Vy0RG8K1ibHl1VMotUGibpN9viVON8Vcac1TlLfOMK1LFfoTbKw0JBBXstJ/WM2q08gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWS2cA0UXf2NYZUg4mHZS1O3Gxks1i18Bqb
 xflZp1gsDm88w2Sx7tZ/Vov/v16xWqxZIWxxvHcHiwOHx/+Dk5g9Wo68ZfVYvOclk8eda3vY
 PJ5c28zk8X7fVTaPz5vkAtijuGxSUnMyy1KL9O0SuDJeHw4reMtfsebJDPYGxi6eLkZODgkB
 E4m/c+6zdDFycQgJrGaUONP5jBnC+cQosX/3WnYIZxmjxMtfz5hAWtgEFCX2dW1nA7FFBIwk
 3t2YxAhiMwucY5JoWGMGYgsL2Eg8OfaeEaLGVuJCfxcTTP2274fAbBYBVYlTJ2eCzeEVMJa4
 cuIyK8Syk4wS2//9ZwVJcAo4SKy5088CYjMKiEl8P7WGCWKZuMStJ/OZIH4QkFiy5zwzhC0q
 8fLxP1YIW1Hi/veX7BD1ehI3pk4BWsYBZNtJbFiWDxHWlli28DUzxA2CEidnPmGBaJWUOLji
 BssERolZSLbNQjJpFsKkWUgmzUIyaQEj6ypG8dLi4tz0imLDvNRyveLE3OLSvHS95PzcTYzA
 qD/973DkDsajtz7qHWJk4mA8xCjBwawkwlty6G+KEG9KYmVValF+fFFpTmrxIUZpDhYlcd4d
 Uy6mCAmkJ5akZqemFqQWwWSZODilGpikl/+23b2p7m2os8GmxVPmbNXrMpurf8RWn1NgzjmP
 0yeYs5fEZh5cFTXtQPP2CV0TJt3SvfjiX3NP6zLV5lny8o/KrhT/Mli9a3P7JyfJBUtNmJMT
 vDy8lxkGHHt/RtbguUurp8W7tO1bZk2abX7hsfPa1OtzuiezHeGum385+smTJ5ufxVUc7m87
 yf4mflXSgcLfBQ1MT/bq34/MXmK71dj48+xr2ocUslXebp0p3DVJdYq/roJTp9OeBPbaNod/
 SRZLTX82ilgbb3BpF9oQaSM+I0CqbHuMuULs/Ihoiw9VMyNM3sz9xfBkRtnkbcfnlHtVJZi6
 MoamCflMqxSb4Sb9l19Oyev7vYPJ7CpKLMUZiYZazEXFiQBqQ3HKaQMAAA==
X-CMS-MailID: 20230912212235uscas1p108e0b8173a84f73bee0b84ee602a88b0
CMS-TYPE: 301P
X-CMS-RootMailID: 20230904132842uscas1p128006ff43c37f1be89b516626c7d3d17
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <CGME20230904132842uscas1p128006ff43c37f1be89b516626c7d3d17@uscas1p1.samsung.com>
 <20230904132806.6094-2-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 04, 2023 at 02:28:03PM +0100, Jonathan Cameron wrote:

> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>=20
> Allocate targets and targets[n] resources when all sanity checks are
> passed to avoid memory leaks.
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-host.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 034c7805b3..f0920da956 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -39,12 +39,6 @@ static void cxl_fixed_memory_window_config(CXLState *c=
xl_state,
>          return;
>      }
> =20
> -    fw->targets =3D g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> -    for (i =3D 0, target =3D object->targets; target; i++, target =3D ta=
rget->next) {
> -        /* This link cannot be resolved yet, so stash the name for now *=
/
> -        fw->targets[i] =3D g_strdup(target->value);
> -    }
> -
>      if (object->size % (256 * MiB)) {
>          error_setg(errp,
>                     "Size of a CXL fixed memory window must be a multiple=
 of 256MiB");
> @@ -64,6 +58,12 @@ static void cxl_fixed_memory_window_config(CXLState *c=
xl_state,
>          fw->enc_int_gran =3D 0;
>      }
> =20
> +    fw->targets =3D g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> +    for (i =3D 0, target =3D object->targets; target; i++, target =3D ta=
rget->next) {
> +        /* This link cannot be resolved yet, so stash the name for now *=
/
> +        fw->targets[i] =3D g_strdup(target->value);
> +    }
> +
>      cxl_state->fixed_windows =3D g_list_append(cxl_state->fixed_windows,
>                                               g_steal_pointer(&fw));
> =20
> --=20
> 2.39.2
> =

