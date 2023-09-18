Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C954A7A4F2D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHD5-0001Mk-KU; Mon, 18 Sep 2023 12:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHD4-0001MF-4R
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:34:54 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHD2-0002FY-D9
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:34:53 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918163450usoutp02787b3d1de508bc1988e242900d177d68~GC3E7k0W72554325543usoutp02a;
 Mon, 18 Sep 2023 16:34:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230918163450usoutp02787b3d1de508bc1988e242900d177d68~GC3E7k0W72554325543usoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695054890;
 bh=njDZU/bcH9olrTlYwyIXU/OaQs/BUDTHxYQqYA+tk0c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Y2RvrQf1I3sAvKR0ahCqukFvst8m9vaz6dYUoI5GdFyA9hikaENuwNRZVkclX1p76
 V/bp/WU4GZUSO97n12k7WztETMcD0auldb59dqAzaTZzp1cYTWXMy2SJuKBWfLgU1h
 rOVxSWyOq57sF0n+4W39Dys6+HQB5+VnxdtxF79I=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918163450uscas1p179548c48dabe9a90ec2167ecfd4ef460~GC3Ew9PIr2415124151uscas1p1j;
 Mon, 18 Sep 2023 16:34:50 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 8C.1D.50148.A2C78056; Mon,
 18 Sep 2023 12:34:50 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918163450uscas1p130158f706c1406380846be01b8654cae~GC3EagFfU2415124151uscas1p1i;
 Mon, 18 Sep 2023 16:34:50 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-e5-65087c2a7fa8
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 64.B3.28590.92C78056; Mon,
 18 Sep 2023 12:34:50 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:34:49 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:34:49 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/4] hw/cxl: CXLDVSECPortExtensions renamed to
 CXLDVSECPortExt
Thread-Topic: [PATCH v2 3/4] hw/cxl: CXLDVSECPortExtensions renamed to
 CXLDVSECPortExt
Thread-Index: AQHZ5/bqu65XfXRkRkynpeU1UhKRb7AhQXuA
Date: Mon, 18 Sep 2023 16:34:49 +0000
Message-ID: <20230918163441.GA3331103@sjcvldevvm72>
In-Reply-To: <20230915170418.21337-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0900BDC74687B64FB07FE669EDE3BD17@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/c7N42JwnDbflDAtQZLNLKl1E5OiVXSxILvQZayDac5sJ7sK
 GyMj1gU1rVxJWWY2NNO8rDLLWUtXRlZOMZdZKyqbsW5SiavtJOy/3/u8z/u9z/fx0biojAyl
 0zJ3s+pMRUYkJSAaLD+eSKbm0Oy0vEMTZcZSGyVrrXmMyRyjw0jm/v2JlFVWBMkeHjcRiZT8
 0H0nKe+zNVFyh+0GJv/S3EXJ84ouE6vIDYJ529iMtD2sOjZhq2B7i64Ey7o7b1+eXodpUXGs
 HtE0MPHgsCTpkYAWMVcR9Lt7cb7IxcDhriXGTC/apLxehcB+zYT44iuCT59zST0K+FeUIyir
 yPEwxURAs76R8nAwMx2Gegq8AzjzEcGPl3ZvI4hJgastZ3DetA6cHYfJsYGbp64jDxNMFLR1
 DnlZyMyAC0ffej0BzAJ409Xs1REjhmFrJeZhnAmBXsd5LwMTCBfPNuE8i2H01gDFcwT0D3/0
 5/1S6CkqpHhOAP37DoLnGCgvHcT5vYHQXuwg+NkJ0FLRQ3guA8xTGjoab/5/ooXwfWAd7wmD
 ru4inJeVYHQJeDkDzpfV/T9mLpSOVGN5aIrBJ7XBJ5HBJ5HBJ5HBJ9EFRBpRSDbHqVJZLi6T
 3SvlFCouOzNVqtypqkX/PtKj0VaVCZl6XVIzwmhkRkDjkcHC4jiKFQm3KfYfYNU7t6izM1jO
 jMJoIjJEGDe/XSliUhW72R0sm8Wqx7oYHRCqxaS4qLsxYcnvR4vNmgOD+brTZZMiJInf5uS8
 E02bLFF+KJiwa+iYM00brf9jjz6ZnqQrGnG1LYwKtZ/d2Ba42qjvfPbNmbx+4vOlm5afeR6s
 K3CxyYalr2wp4Q/c4js9SS6tU5NtXQ2/SupmSXJXnhB+dfgPWOcu026Z7bJC6RpRYWq78Kff
 w/6YzfVc8psgzSkyvfZgTaJlhd9r7vZgk2bj2y8JVVNKyIFOZatFEv8u9pKfrTixsXpzfl1U
 df7PFU9Mhivi8CN2415Nw+MRt/hapTS88L6wIDqt3nJuZr05fVG3UjWyzD1/7Yb93X3496p4
 TUPY+HEpWw82vLYq7yVFEtx2RdxUXM0p/gK2hR7etwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWS2cA0SVerhiPVYN9qJotVC6+xWRzeeIbJ
 4sm/74wW/3+9YrVYs0LY4njvDhYHNo+WI29ZPe5c28Pm8eTaZiaP9/uusnlMmLqUJYA1issm
 JTUnsyy1SN8ugSvjYNNcpoL9NhUTupqYGhhn6ncxcnBICJhIXDmh18XIySEksJpRYss9wy5G
 LiD7E6NE64JWFghnGaPE/4MzmECq2AQUJfZ1bWcDsUUEjCTe3ZjECFLELPCSUeLr7btgCWGB
 cImVB2cwQxRFSGz8Np8JpmHntA2MIDaLgKrEiYvvwGxeAWOJBd2PWSG2nWaU2DzxKFiCU8BR
 4tHVfWA2o4CYxPdTa8AGMQuIS9x6AjFUQkBAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSdyY
 OoUNwraT6Hp2lgXC1pZYtvA1M8QRghInZz5hgeiVlDi44gbLBEaJWUjWzUIyahaSUbOQjJqF
 ZNQCRtZVjOKlxcW56RXFhnmp5XrFibnFpXnpesn5uZsYgTF9+t/hyB2MR2991DvEyMTBeIhR
 goNZSYR3piFbqhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeHVMupggJpCeWpGanphakFsFkmTg4
 pRqYjh7J4hMNLTIQ2nz4SmSA18KyxM45rqKMMvNsX3BkXjpkMUNrluOU/wtMq6/eXpnBeSTs
 dumvwBVmN5azrFXMKeps3n58gryd4fpi5ZyfzS2t/oHhT1b6Lor8+vHetC/Gad+Mq29Er75c
 0mBtfv1egP7HJZsXPsuxsxQNjDot8vPnnFU/ORWe+BpeTvqt+9XS9dN6zwL3O64qpm+nFz1T
 +L5SJnmznPaJJvUvMoGnP9hVL1V2+Mbn8+W51JKiIyUtrmsKbjrk9l0JKPYOXXuC/5FoscOJ
 +661/qf2PvTR3+1xLDJYTPvo3q+b+8Xjgk+pNJ49e3RhskOjtbt266bXhyfNPeqisP95lmTG
 uQZWJZbijERDLeai4kQAVfhLYVgDAAA=
X-CMS-MailID: 20230918163450uscas1p130158f706c1406380846be01b8654cae
CMS-TYPE: 301P
X-CMS-RootMailID: 20230915170556uscas1p21dc4738cb31cb867135ea6d165b0e11d
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
 <CGME20230915170556uscas1p21dc4738cb31cb867135ea6d165b0e11d@uscas1p2.samsung.com>
 <20230915170418.21337-4-Jonathan.Cameron@huawei.com>
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

On Fri, Sep 15, 2023 at 06:04:17PM +0100, Jonathan Cameron wrote:

> Done to reduce line lengths where this is used.
> Ext seems sufficiently obvious that it need not be spelt out
> fully.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_pci.h       |  6 ++---
>  hw/cxl/cxl-component-utils.c   | 49 ++++++++++++++++++++--------------
>  hw/pci-bridge/cxl_downstream.c |  2 +-
>  hw/pci-bridge/cxl_root_port.c  |  2 +-
>  hw/pci-bridge/cxl_upstream.c   |  2 +-
>  5 files changed, 35 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index 407be95b9e..ddf01a543b 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -86,7 +86,7 @@ typedef struct CXLDVSECDevice {
>  QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) !=3D 0x38);
> =20
>  /* CXL 2.0 - 8.1.5 (ID 0003) */
> -typedef struct CXLDVSECPortExtensions {
> +typedef struct CXLDVSECPortExt {
>      DVSECHeader hdr;
>      uint16_t status;
>      uint16_t control;
> @@ -100,8 +100,8 @@ typedef struct CXLDVSECPortExtensions {
>      uint32_t alt_prefetch_limit_high;
>      uint32_t rcrb_base;
>      uint32_t rcrb_base_high;
> -} CXLDVSECPortExtensions;
> -QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExtensions) !=3D 0x28);
> +} CXLDVSECPortExt;
> +QEMU_BUILD_BUG_ON(sizeof(CXLDVSECPortExt) !=3D 0x28);
> =20
>  #define PORT_CONTROL_OFFSET          0xc
>  #define PORT_CONTROL_UNMASK_SBR      1
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 7ef3ef2bd6..c8d632d540 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -392,26 +392,35 @@ void cxl_component_create_dvsec(CXLComponentState *=
cxl,
>      case NON_CXL_FUNCTION_MAP_DVSEC:
>          break; /* Not yet implemented */
>      case EXTENSIONS_PORT_DVSEC:
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, control)] =3D 0x=
0F;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, control) + 1] =
=3D 0x40;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_base)] =
=3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_bus_limit)] =
=3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base)=
] =3D 0xF0;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_base)=
 + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit=
)] =3D 0xF0;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_memory_limit=
) + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e)] =3D 0xF0;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e) + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it)] =3D 0xF0;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it) + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e_high)] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e_high) + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e_high) + 2] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_bas=
e_high) + 3] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it_high)] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it_high) + 1] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it_high) + 2] =3D 0xFF;
> -        wmask[offset + offsetof(CXLDVSECPortExtensions, alt_prefetch_lim=
it_high) + 3] =3D 0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, control)] =3D 0x0F;
> +        wmask[offset + offsetof(CXLDVSECPortExt, control) + 1] =3D 0x40;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_base)] =3D 0xFF=
;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_bus_limit)] =3D 0xF=
F;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base)] =3D 0=
xF0;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_base) + 1] =
=3D 0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit)] =3D =
0xF0;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_memory_limit) + 1] =
=3D 0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base)] =3D=
 0xF0;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base) + 1]=
 =3D 0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit)] =
=3D 0xF0;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit) + 1=
] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)=
] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)=
 + 1] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)=
 + 2] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_base_high)=
 + 3] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high=
)] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high=
) + 1] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high=
) + 2] =3D
> +            0xFF;
> +        wmask[offset + offsetof(CXLDVSECPortExt, alt_prefetch_limit_high=
) + 3] =3D
> +            0xFF;
>          break;
>      case GPF_PORT_DVSEC:
>          wmask[offset + offsetof(CXLDVSECPortGPF, phase1_ctrl)] =3D 0x0F;
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstrea=
m.c
> index 54f507318f..cdd79ea1c0 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -98,7 +98,7 @@ static void build_dvsecs(CXLComponentState *cxl)
>  {
>      uint8_t *dvsec;
> =20
> -    dvsec =3D (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
> +    dvsec =3D (uint8_t *)&(CXLDVSECPortExt){ 0 };
>      cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
>                                 EXTENSIONS_PORT_DVSEC_LENGTH,
>                                 EXTENSIONS_PORT_DVSEC,
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.=
c
> index 7dfd20aa67..8f97697631 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -107,7 +107,7 @@ static void build_dvsecs(CXLComponentState *cxl)
>  {
>      uint8_t *dvsec;
> =20
> -    dvsec =3D (uint8_t *)&(CXLDVSECPortExtensions){ 0 };
> +    dvsec =3D (uint8_t *)&(CXLDVSECPortExt){ 0 };
>      cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
>                                 EXTENSIONS_PORT_DVSEC_LENGTH,
>                                 EXTENSIONS_PORT_DVSEC,
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index a57806fb31..b81bb5fec9 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -116,7 +116,7 @@ static void build_dvsecs(CXLComponentState *cxl)
>  {
>      uint8_t *dvsec;
> =20
> -    dvsec =3D (uint8_t *)&(CXLDVSECPortExtensions){
> +    dvsec =3D (uint8_t *)&(CXLDVSECPortExt){
>          .status =3D 0x1, /* Port Power Management Init Complete */
>      };
>      cxl_component_create_dvsec(cxl, CXL2_UPSTREAM_PORT,
> --=20
> 2.39.2
> =

