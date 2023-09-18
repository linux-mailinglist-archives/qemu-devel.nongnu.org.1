Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DAA7A4F07
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHAb-0007ge-7Q; Mon, 18 Sep 2023 12:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHAY-0007g2-Hh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:32:18 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiHAT-0001oy-7r
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:32:18 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918163208usoutp0254f45a150de470a301e2066743ed63af~GC0t9b8j52440324403usoutp02I;
 Mon, 18 Sep 2023 16:32:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230918163208usoutp0254f45a150de470a301e2066743ed63af~GC0t9b8j52440324403usoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695054728;
 bh=UUmZJwAqPu2h5kk/ZM1IfxdCsWzt2WqaKEibhDzrpvo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=twm4QUU4JhqVw8DmtjUJfM2/AiL3yHkpoXZ7cyoU3/QZww9DrNp0kEl04eCt4rwnV
 6snZ3wn1a/sUGJ690QAdaKpLG1Gw3j5RZXBNHaYRUT7k5QrBlSSqYYZ/x/nb7BJm3D
 C1XHp8pzNL1RnPG4tQrVRII3hrn0ez48eEHvQKEU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918163208uscas1p1911dbc88539659d4e550ceb7fd4a5d19~GC0tschFS0086900869uscas1p1v;
 Mon, 18 Sep 2023 16:32:08 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 66.6C.50148.88B78056; Mon,
 18 Sep 2023 12:32:08 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918163208uscas1p2300cf1c3d8e84ecf6aa376861abec03b~GC0taf0wO0391503915uscas1p2-;
 Mon, 18 Sep 2023 16:32:08 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-6e-65087b8853d8
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 8B.43.28590.78B78056; Mon,
 18 Sep 2023 12:32:07 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:32:07 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:32:07 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Thread-Topic: [PATCH v2 2/4] hw/cxl: Use switch statements for read and
 write of cachemem registers
Thread-Index: AQHZ5/bTUEaJx99u4E2nO/Y74WbsurAhQLkA
Date: Mon, 18 Sep 2023 16:32:07 +0000
Message-ID: <20230918163201.GA3330830@sjcvldevvm72>
In-Reply-To: <20230915170418.21337-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8B9CBABA9A39054C9F328F471C4CAB5F@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djXc7od1RypBtM6BCxWLbzGZnF44xkm
 iyf/vjNa/P/1itVizQphi+O9O1gc2Dxajrxl9bhzbQ+bx5Nrm5k83u+7yuYxYepSlgDWKC6b
 lNSczLLUIn27BK6Mnvfr2ArWqlZcX7mGvYFxu3QXIyeHhICJxNfpX1m7GLk4hARWMko0Te5j
 hHBamSSefN7NAlP1/N9VJojEWkaJzp3XWCCcT4wSr/umMUM4yxglzq38wg7SwiagKLGvazsb
 iC0iYCTx7sYksLnMAi8ZJb7evguU4OAQFkiReDGfGaImVeLyxt2sMPX/Lx4Ci7MIqEpsenKC
 HaScV8BYovVnCkiYU8BRYsq3Q2DjGQXEJL6fWsMEYjMLiEvcejKfCeJqQYlFs/cwQ9hiEv92
 PWSDsBUl7n9/yQ5RrydxY+oUNgjbTuLXzDmMELa2xLKFr8F6eYHmnJz5BBoSkhIHV9wAe15C
 4AKHRMflQ6wQCReJU4duQNnSElevT2UGuVlCIFli1UcuiHCOxPwlW6DmWEss/LOeaQKjyiwk
 Z89CctIsJCfNQnLSLCQnLWBkXcUoXlpcnJueWmyYl1quV5yYW1yal66XnJ+7iRGYlE7/O5y7
 g3HHrY96hxiZOBgPMUpwMCuJ8M40ZEsV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZSCA9
 sSQ1OzW1ILUIJsvEwSnVwCQz6+ycVKvrhWcvPTCIez3Dx0Aj62Hv6f+RpS/Vbguvju6vtNTf
 kWOppRX6mG1zuDJHp9qhbPc5X9aFWfJFBzYIFBw41/Fvz+pFshIH8wOL9MUMjyzfpZcZwGwb
 e+yj9cq02Ib3a55e/rH5UYCDFvMNf82pHWlTtbtDXFhsVoZn8F9Zsz760Q6L6phNpXb6T3z9
 xCULFaMOlIsFeS6VPZd2fH+Mq8+2v6eqtv9+sLeq3sV26vsJVmX3TvecPOl73nWi7XQtnmie
 OhX2TJ/AvX62JattLENfyVic8LtdrGZx2nKTh/LN8AOVPx50fQ7/GXxl1fO/M5cpvbkyZ/Lh
 XZlz5rs7W4Z6nf+lcGDNQiWW4oxEQy3mouJEAJ6YXS25AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWS2cA0Ube9miPVoO2CucWqhdfYLA5vPMNk
 8eTfd0aL/79esVqsWSFscbx3B4sDm0fLkbesHneu7WHzeHJtM5PH+31X2TwmTF3KEsAaxWWT
 kpqTWZZapG+XwJXR834dW8Fa1YrrK9ewNzBul+5i5OSQEDCReP7vKlMXIxeHkMBqRon+22vZ
 IJxPjBKzWq6wQzjLGCX2PVnGAtLCJqAosa9rOxuILSJgJPHuxiRGkCJmgZeMEl9v3wVKcHAI
 C6RIvJjPDFGTKrHhwGImmPr/Fw+BxVkEVCU2PTnBDlLOK2As0fozBWLXaUaJTRu+g9VwCjhK
 TPl2CGwXo4CYxPdTa8DmMAuIS9x6Mp8J4gUBiSV7zjND2KISLx//Y4WwFSXuf3/JDlGvJ3Fj
 6hQ2CNtO4tfMOYwQtrbEsoWvwXp5BQQlTs58wgLRKylxcMUNlgnAMECybhaSUbOQjJqFZNQs
 JKMWMLKuYhQvLS7OTa8oNsxLLdcrTswtLs1L10vOz93ECIzp0/8OR+5gPHrro94hRiYOxkOM
 EhzMSiK8Mw3ZUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz7phyMUVIID2xJDU7NbUgtQgmy8TB
 KdXAtGie2ESHS1EHv27kbVz0JMZGOO31pMWiWw6GV264yeBgdeaJv655Z+qriCvrxJt3r372
 4urG3wd7JC7tZNmpclBPjVVjh0XE3bLTVe2CtueLbvbIXBfUvH1l0d19ZdXcek1c1ap1Ar0m
 E5uZJa113b+ePjqvZUF26WUhhYDNU3qdV/z+cO5s5L5pL8UL8y2NPm2LVlrBkcb3UXXetC25
 uQEX40xurk4SCNVg6vBiWleoXbnXRjPxHnstd5PowRxNy2ifwk6mzP7lB54quMZdn/1O4+Yd
 nZdnhE5u359pVRB+/sAh1mtatbE8E1aot+b8MOCc+i+hVli+58KRgyue6nPVctxt4lfsifGq
 aPVWYinOSDTUYi4qTgQAdMPpZ1gDAAA=
X-CMS-MailID: 20230918163208uscas1p2300cf1c3d8e84ecf6aa376861abec03b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230915170525uscas1p1fd96c779b4b8da05479110c5b7fb6cc8
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
 <CGME20230915170525uscas1p1fd96c779b4b8da05479110c5b7fb6cc8@uscas1p1.samsung.com>
 <20230915170418.21337-3-Jonathan.Cameron@huawei.com>
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

On Fri, Sep 15, 2023 at 06:04:16PM +0100, Jonathan Cameron wrote:

> Establishing that only register accesses of size 4 and 8 can occur
> using these functions requires looking at their callers. Make it
> easier to see that by using switch statements.
> Assertions are used to enforce that the register storage is of the
> matching size, allowing fixed values to be used for divisors of
> the array indices.
>=20
> Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> v2: Use switch statements. Note we coudl have renamed registers to make
>     the sizes visible as is true of some other cases, but that felt odd
>     as this is the only size these registers can be, so why call it out.
>     The asserts do the same job.
>  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd13..7ef3ef2bd6 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, =
hwaddr offset,
>      CXLComponentState *cxl_cstate =3D opaque;
>      ComponentRegisters *cregs =3D &cxl_cstate->crb;
> =20
> -    if (size =3D=3D 8) {
> +    switch (size) {
> +    case 4:
> +        if (cregs->special_ops && cregs->special_ops->read) {
> +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> +        } else {
> +            static_assert(sizeof(*cregs->cache_mem_registers) =3D=3D 4);
> +            return cregs->cache_mem_registers[offset / 4];
> +        }
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n"=
);
>          return 0;
> -    }
> -
> -    if (cregs->special_ops && cregs->special_ops->read) {
> -        return cregs->special_ops->read(cxl_cstate, offset, size);
> -    } else {
> -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_=
mem_registers)];
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
> =20
> @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, h=
waddr offset, uint64_t value,
>      ComponentRegisters *cregs =3D &cxl_cstate->crb;
>      uint32_t mask;
> =20
> -    if (size =3D=3D 8) {
> +    switch (size) {
> +    case 4:
> +        static_assert(sizeof(*cregs->cache_mem_regs_write_mask) =3D=3D 4=
);
> +        static_assert(sizeof(*cregs->cache_mem_registers) =3D=3D 4);
> +        mask =3D cregs->cache_mem_regs_write_mask[offset / 4];
> +        value &=3D mask;
> +        /* RO bits should remain constant. Done by reading existing valu=
e */
> +        value |=3D ~mask & cregs->cache_mem_registers[offset / 4];
> +        if (cregs->special_ops && cregs->special_ops->write) {
> +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> +            return;
> +        }
> +
> +        if (offset >=3D A_CXL_HDM_DECODER_CAPABILITY &&
> +            offset <=3D A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> +            dumb_hdm_handler(cxl_cstate, offset, value);
> +        } else {
> +            cregs->cache_mem_registers[offset / 4] =3D value;
> +        }
> +        return;
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n"=
);
>          return;
> -    }
> -    mask =3D cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->ca=
che_mem_regs_write_mask)];
> -    value &=3D mask;
> -    /* RO bits should remain constant. Done by reading existing value */
> -    value |=3D ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs=
->cache_mem_registers)];
> -    if (cregs->special_ops && cregs->special_ops->write) {
> -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> -        return;
> -    }
> -
> -    if (offset >=3D A_CXL_HDM_DECODER_CAPABILITY &&
> -        offset <=3D A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> -        dumb_hdm_handler(cxl_cstate, offset, value);
> -    } else {
> -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_reg=
isters)] =3D value;
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
> =20
> --=20
> 2.39.2
> =

