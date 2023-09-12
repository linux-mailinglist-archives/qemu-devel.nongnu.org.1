Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83A79DA86
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAXh-0003KC-ND; Tue, 12 Sep 2023 17:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAXd-0003I0-E5
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:03:25 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAXZ-0006dE-8k
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:03:25 -0400
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230912210316usoutp016e8a0d294b7fad66d9d1e0b9b93cd50b~EQpvV9rwA1837218372usoutp01Q;
 Tue, 12 Sep 2023 21:03:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230912210316usoutp016e8a0d294b7fad66d9d1e0b9b93cd50b~EQpvV9rwA1837218372usoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1694552596;
 bh=ZvLMB+y30ccT76VU0PrNOmSqEgDaEOXdFIgruoQyPro=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=DAP8/ysNHOml7DncuT71UdvhBA7E4MbYoavsjJdZjsuEA9mM7oi44n5vMgXNG4FsW
 gYIAqkTGSey649QcwBQJj1xh45/eJuLI+boHZJrwxq1Vi0ABTb+mOyqBnDB6T3WSuQ
 nFt+mJUvwr9FTKNlVYtT96PNyVnpJMH4QYlVdjqY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230912210316uscas1p14b80871d9d5a33f776f410aeea931b06~EQpvPPmHs0916709167uscas1p1z;
 Tue, 12 Sep 2023 21:03:16 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id D4.F9.40279.412D0056; Tue,
 12 Sep 2023 17:03:16 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230912210316uscas1p24582c8c7b99778897fc1feb8276e6abb~EQpvB_gYn1163111631uscas1p2i;
 Tue, 12 Sep 2023 21:03:16 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-4b-6500d214b3fb
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 15.60.31410.412D0056; Tue,
 12 Sep 2023 17:03:16 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 12 Sep 2023 14:03:15 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 12 Sep 2023 14:03:15 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/3] tests/acpi: Allow update of DSDT.cxl
Thread-Topic: [PATCH v2 1/3] tests/acpi: Allow update of DSDT.cxl
Thread-Index: AQHZ30uS7TzarmmB10ePZbZrHpBrCrAYL9MA
Date: Tue, 12 Sep 2023 21:03:15 +0000
Message-ID: <20230912210305.GA2828853@sjcvldevvm72>
In-Reply-To: <20230904161847.18468-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9805C316ECEC7144A755D2F4801557B1@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djXc7oilxhSDeZN0rY4cbORzWLVwmts
 FudnnWKxOLzxDJPF/1+vWC3WrBC2ON67g8WB3aPlyFtWj8V7XjJ53Lm2h83jybXNTB7v911l
 8/i8SS6ALYrLJiU1J7MstUjfLoEr4+uDY8wFf1krPl79w9zA2MzaxcjBISFgItH7QryLkYtD
 SGAlo8T/OXdZIJxWJokrX+4ydTFyghUt2DiRDSKxllHi5Z4t7BDOJ0aJXYc+skI4y4Cc3stg
 LWwCihL7urazgdgiAkYS725MYgSxmQUWM0m0/60CsYUFHCQOHZ7ACFHjKPF11UEWmPqGe8fB
 bBYBVYlLTfvZQWxeAWOJjd+eM4PYnED1125+AYszCohJfD+1hglivrjErSfzoc4WlFg0ew8z
 hC0m8W/XQzYIW1Hi/veX7BD1ehI3pk5hg7DtJF7vm8YCYWtLLFv4mhlir6DEyZlPWCB6JSUO
 rrgBDiMJgTscEn8m/2CESLhI3Lm6CGqBtMT0NZdZIAGcLLHqIxdEOEdi/pItUHOsJRb+Wc80
 gVFlFpKzZyE5aRaSk2YhOWkWkpMWMLKuYhQvLS7OTU8tNspLLdcrTswtLs1L10vOz93ECExT
 p/8dzt/BeP3WR71DjEwcjIcYJTiYlUR4Sw79TRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7
 MllIID2xJDU7NbUgtQgmy8TBKdXAFCHeNF9cJ9nw/T2vFez7wzL9GB1mx7yQ9vkUrP8otP2d
 9U6lCTkfn+m4LGhb2iVsfOj2pEX7VpfeP2H61u/pHBH3F7enTVrbaGI9ceY6ddXEWy/+yF27
 9il/wUyr6qg+zaAVBue+1B4SNIjd8bv9xulLSfZdMj2LTjOtTJOz1NM963/n9bOcX9cKHn5+
 feex5uUm3cVPpl/KEvf8LTFrO9/qH0y37vx4qGJQ7nz0lWyGRlRdp8HEtSrLXCbNlLFWzHgV
 9EFFc+pt53CmjX9LA3csX2hxgnvekmXaa9ZaJjgvu6ClcT1w3gqe77Kd3stj/3a80UhPWVqq
 LaPSIvAtflOmQu+WEzH8pySDF3GbT1ZiKc5INNRiLipOBAD6pxJMwgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0UVfkEkOqwdr90hYnbjayWaxaeI3N
 4vysUywWhzeeYbL4/+sVq8WaFcIWx3t3sDiwe7QcecvqsXjPSyaPO9f2sHk8ubaZyeP9vqts
 Hp83yQWwRXHZpKTmZJalFunbJXBlfH1wjLngL2vFx6t/mBsYm1m7GDk5JARMJBZsnMjWxcjF
 ISSwmlHiz5H9TBDOJ0aJF/O+MUM4yxglPs/YBdbCJqAosa9rOxuILSJgJPHuxiRGEJtZYDGT
 RPvfKhBbWMBB4tDhCYwQNY4SX1cdZIGpb7h3HMxmEVCVuNS0nx3E5hUwltj47TkziC0kUC7x
 ccthJhCbE6j32s0vYDWMAmIS30+tYYLYJS5x68l8JogXBCSW7DnPDGGLSrx8/A/qNUWJ+99f
 skPU60ncmDqFDcK2k3i9bxoLhK0tsWzha2aIGwQlTs58wgLRKylxcMUNlgmMErOQrJuFZNQs
 JKNmIRk1C8moBYysqxjFS4uLc9Mrio3zUsv1ihNzi0vz0vWS83M3MQKj/PS/wzE7GO/d+qh3
 iJGJg/EQowQHs5IIb8mhvylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXdMuZgiJJCeWJKanZpa
 kFoEk2Xi4JRqYDKv/iNU9WiaWC1XZffxSOOrrZy39+2u6cmfMvWq/TTpu4+zFKKZO5b/lwmZ
 phmSHPPtFjtfeO7LpY6ZJol9Z9nueNicjyosm73A8J/oHLv3CavPVkzyOPzOzDYqUObVhvUi
 iy488rtj9jHR+7fUlRMHbFeWbrur5Hr3CPO955zBm4L3aS/t/ZuUHb5s3dcf8xY3pWpM3DX7
 16INNvd23U5LanT9EXWU4Zj/44Np279uq3VfU+2jUP7MMYFrfYoFn9ABT+/4uf/1ozZVbnga
 vF980/91D95/DWjT3pM36/yJu78/5DN5ioalbVSqUVv/enl9hMOJiB7rmVE/0/3DljF7O5af
 lkzicZz04jMP20olluKMREMt5qLiRAApg04NYQMAAA==
X-CMS-MailID: 20230912210316uscas1p24582c8c7b99778897fc1feb8276e6abb
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912210316uscas1p24582c8c7b99778897fc1feb8276e6abb
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-2-Jonathan.Cameron@huawei.com>
 <CGME20230912210316uscas1p24582c8c7b99778897fc1feb8276e6abb@uscas1p2.samsung.com>
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

On Mon, Sep 04, 2023 at 05:18:45PM +0100, Jonathan Cameron wrote:

> Addition of QTG in following patch requires an update to the test
> data.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..9ce0f596cc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.cxl",
> --=20
> 2.39.2
>=20
> =

