Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EA7A4E63
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGt6-00043W-G5; Mon, 18 Sep 2023 12:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGsp-00041l-1y
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:13:59 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGsn-0006SB-4c
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:13:58 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918161355usoutp01812ba973d93228dc76b175cff87141c9~GCkzy7LW12192921929usoutp01T;
 Mon, 18 Sep 2023 16:13:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230918161355usoutp01812ba973d93228dc76b175cff87141c9~GCkzy7LW12192921929usoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695053635;
 bh=QfWdrjLIOv2uWSieE8D3ECnt5nHRytkAZXN8JJ0084c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=UsDi45FsKaHcfNjEOxC5T7p1lbAF2Wj4oLKdl5NGLPnY8pn8AdHBdm8A0stlQHUTL
 7BpxGTrORb+3RD8bqGFBtfgW9glCYu+VKFoQFJ2T0YS9q0BT4tzS/WCZLSgFUHSdTh
 1D3orqmtlhzhaC0HwA/QCn2wlGewF3VMT9+qXnFE=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918161355uscas1p26c0b57789b56508b20693f12448dab84~GCkztOSTz0732507325uscas1p2W;
 Mon, 18 Sep 2023 16:13:55 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 82.FB.40279.34778056; Mon,
 18 Sep 2023 12:13:55 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918161355uscas1p2a018fcba3ec4185347890b2f4d882d09~GCkzgYNmh0499204992uscas1p2i;
 Mon, 18 Sep 2023 16:13:55 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-8c-65087743d520
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 55.F1.31410.24778056; Mon,
 18 Sep 2023 12:13:54 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:13:54 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:13:54 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH 3/3] docs/cxl: Cleanout some more aarch64 examples.
Thread-Topic: [PATCH 3/3] docs/cxl: Cleanout some more aarch64 examples.
Thread-Index: AQHZ6kF4a/ZUbKd4SkqUZIx7fxdqL7AhNxIA
Date: Mon, 18 Sep 2023 16:13:54 +0000
Message-ID: <20230918161354.GC3330304@sjcvldevvm72>
In-Reply-To: <20230918150259.11165-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1AD4307BEA1DEC45B2C70DD30A4A2D6E@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djXc7rO5RypBm/X8VqsWniNzeLwxjNM
 Fk/+fWe0+P/rFavFnDMPWCzWrBC2ON67g8Vi2rQnbA4cHi1H3rJ63Lm2h83jybXNTB7bZ01l
 9Hi/7yqbx4SpS1kC2KK4bFJSczLLUov07RK4MlbvfctWsJq3YvXu4ywNjE3cXYycHBICJhJX
 PvxiBLGFBFYyShx76wFhtzJJzN3rCVMzfeFroBouoPhaRom2N3uhnE+MEvsWtjNDOMsYJVbP
 O8UM0sImoCixr2s7G4gtImAk8e7GJLAOZoFDTBKzdn5mAkkIC7hLtM+fxAxR5CGxt28iC0zD
 kkUbwOIsAqoS1+e/AbN5BYwlVv5+DmZzCjhKzD95gRXEZhQQk/h+ag3YTGYBcYlbT+YzQdwt
 KLFo9h5mCFtM4t+uh2wQtqLE/e8v2SHq9SRuTJ3CBmHbSVxddgzK1pZYtvA11F5BiZMzn7BA
 9EpKHFxxgwXkGQmBJxwSF/suQi1zkbj0/CMjhC0tMX3NZaAiDiA7WWLVRy6IcI7E/CVboOZY
 Syz8s55pAqPKLCRnz0Jy0iwkJ81CctIsJCctYGRdxSheWlycm55abJSXWq5XnJhbXJqXrpec
 n7uJEZiyTv87nL+D8fqtj3qHGJk4GA8xSnAwK4nwzjRkSxXiTUmsrEotyo8vKs1JLT7EKM3B
 oiTOa2h7MllIID2xJDU7NbUgtQgmy8TBKdXAtKuK2//frvAfcqsU7tjav0oqev/Sf/GhEqX5
 L6UutfCrzHrRd335wqlpy/hqDz1+LPGyn8PYLDBzXRL770+ep17931nGEjvj5eES7T/8Zc8r
 be673X/TXjMxwTD6zcujDx9Gpt1XuCcaliq2x2TSvLBZcx9Gz3n4bsXOqXVps7/F8gYta7Tg
 S6hp2MrNlR3h/Dlv6ur+4/XXzTyM+m7Nq13V3aDcu/ivVSUvy1O26rb5U4pFt75wWcEw10hB
 9YpEgd2N8qxzzA9ezdjKWy7rvSUw6PODaz6/Jnv2fV+awh50lnd21f+ORasXLq1wu2r1q7JP
 vrXX4v+iOb2Fv5SYDRNEj8TV7C7M8ui3NKnRUGIpzkg01GIuKk4EAIQXMYHIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWS2cA0UdepnCPV4MAqS4tVC6+xWRzeeIbJ
 4sm/74wW/3+9YrWYc+YBi8WaFcIWx3t3sFhMm/aEzYHDo+XIW1aPO9f2sHk8ubaZyWP7rKmM
 Hu/3XWXzmDB1KUsAWxSXTUpqTmZZapG+XQJXxuq9b9kKVvNWrN59nKWBsYm7i5GTQ0LARGL6
 wteMXYxcHEICqxklnixYwQ7hfGKUePjxOhOEs4xR4vLWRSwgLWwCihL7urazgdgiAkYS725M
 AmtnFjjEJDFr52cmkISwgLtE+/xJzBBFHhJ7+yaywDQsWbQBLM4ioCpxff4bMJtXwFhi5e/n
 zBDbTjNKTNp4DayBU8BRYv7JC6wgNqOAmMT3U2vAFjALiEvcejKfCeIJAYkle84zQ9iiEi8f
 /2OFsBUl7n9/yQ5RrydxY+oUNgjbTuLqsmNQtrbEsoWvoY4QlDg58wkLRK+kxMEVN1gmMErM
 QrJuFpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zkst1ytOzC0uzUvXS87P3cQIjPrT/w7H
 7GC8d+uj3iFGJg7GQ4wSHMxKIrwzDdlShXhTEiurUovy44tKc1KLDzFKc7AoifPumHIxRUgg
 PbEkNTs1tSC1CCbLxMEp1cB0Tjtq+uNF1jVr6h1vN9s957Wu3fLp2xmeqYe3fiiNSVTwXz39
 5VsroYR1XFvqmNld50xzeq5uYf1+Qqnpe4X0e0GSe645/y2/zf9gpcJhvgNbInsO3H04l43f
 ZrbJnKC86ok1Vyyn8rs+PGf6gf8BI6vtEuvpfVc2OT5rm31VVKLJIu/95It5m9pSc1hLbpyb
 3HlkcT6XschJa8n4aQZ2Vr8CXq62UFrzOGnZd1eTutYQ1caTOw8fvv7G+tStt96Bh9pu/Khh
 shJufKV8a0mHS6ng9GvCF+Wc3e+6u6XXLjecuKnD+sLHrOnNfx9Ynm1YsG/ylLw78dGnN6h8
 ZVG+udWyqUetSIn50jf1afu1lViKMxINtZiLihMBZtX/t2kDAAA=
X-CMS-MailID: 20230918161355uscas1p2a018fcba3ec4185347890b2f4d882d09
CMS-TYPE: 301P
X-CMS-RootMailID: 20230918150435uscas1p2c68807bca660901a2211ee9745917fd5
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <CGME20230918150435uscas1p2c68807bca660901a2211ee9745917fd5@uscas1p2.samsung.com>
 <20230918150259.11165-4-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 18, 2023 at 04:02:59PM +0100, Jonathan Cameron wrote:

> These crossed with the previous fix to get rid of examples
> using aarch64 for which support is not yet upstream.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  docs/system/devices/cxl.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index b742120657..6ab5f72473 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -313,7 +313,7 @@ A very simple setup with just one directly attached C=
XL Type 3 Persistent Memory
> =20
>  A very simple setup with just one directly attached CXL Type 3 Volatile =
Memory device::
> =20
> -  qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don -m 4g,maxmem=3D8G=
,slots=3D8 -cpu max \
> +  qemu-system-x86_64 -M q35,cxl=3Don -m 4G,maxmem=3D8G,slots=3D8 -smp 4 =
\
>    ...
>    -object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D256M \
>    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> @@ -323,7 +323,7 @@ A very simple setup with just one directly attached C=
XL Type 3 Volatile Memory d
> =20
>  The same volatile setup may optionally include an LSA region::
> =20
> -  qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don -m 4g,maxmem=3D8G=
,slots=3D8 -cpu max \
> +  qemu-system-x86_64 -M q35,cxl=3Don -m 4G,maxmem=3D8G,slots=3D8 -smp 4 =
\
>    ...
>    -object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D256M \
>    -object memory-backend-file,id=3Dcxl-lsa0,share=3Don,mem-path=3D/tmp/l=
sa.raw,size=3D256M \
> --=20
> 2.39.2
> =

