Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B17A4E5E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGqS-0000Ot-Nv; Mon, 18 Sep 2023 12:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGqO-0000CO-2S
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:11:28 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGqJ-0005v4-BQ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:11:27 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918161114usoutp022cc5a2fa6c1efa80d62f2c5547a9025f~GCidvq2B10406104061usoutp02m;
 Mon, 18 Sep 2023 16:11:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20230918161114usoutp022cc5a2fa6c1efa80d62f2c5547a9025f~GCidvq2B10406104061usoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695053474;
 bh=fGAVMLvSEISIkd0lis0RnvqbgstGsh7NOhKzyqrldHA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=T2W5Xuvc+Dnvm1ZXJMCbr2FKin7IrCdgHoqCOAQYtGUfvZYCI1I1eJM71jpNVM9wZ
 6DKEL+WvKdnRu+L+ysBlfuH7MBI16uABouaffdNDStXIgZp5uXqJ0CJjZRoeOpPJEE
 xN9J7fmK61FOpF2/wqOP3PxTGcb1XOPHDGrlaHgw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
 [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918161114uscas1p2f917159da0e400f39741c93206f17a63~GCido-npt1784017840uscas1p2b;
 Mon, 18 Sep 2023 16:11:14 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges3new.samsung.com (USCPEMTA) with SMTP id 97.B3.62237.1A678056; Mon,
 18 Sep 2023 12:11:13 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918161113uscas1p2d9b57ea4fbac5426eb9886a137c1ed7a~GCidT-Arx0168801688uscas1p2M;
 Mon, 18 Sep 2023 16:11:13 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-7b-650876a1563b
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id A6.D1.31200.1A678056; Mon,
 18 Sep 2023 12:11:13 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:11:12 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:11:12 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH 1/3] hw/cxl: Fix out of bound array access
Thread-Topic: [PATCH 1/3] hw/cxl: Fix out of bound array access
Thread-Index: AQHZ6kFSABTQz62uV06hxsMAab/QKLAhNk0A
Date: Mon, 18 Sep 2023 16:11:12 +0000
Message-ID: <20230918161104.GA3330304@sjcvldevvm72>
In-Reply-To: <20230918150259.11165-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <129F4E95755A3246B37FADA94AA26D85@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmOzs7HlfW2Qp9c11oJV0snRVxsFoJEYcorCCLgnLoyYnb1J2m
 XYiMVZRR2sWoo+BWti3zQnbRwhRXVF5GP8o1b6i1Iu1iGjIMm7WdBfv3vM+F73lfPlIkeyyO
 JjP1h1mDXq1VEBL88cvxNysteSSrnBpfR1daXAT9/H4HRnt8XkRP/R4W02UdAzhdZZ9Fv7rY
 gNPXr3uITSRz+sV3MdPraiQYj+sBxtTzJYgZaeokmOKSO/gOYp9kfTqrzcxjDfGqVInG3jWE
 55imH2lxtqMCNBVeiMJJoNZA6afTqBBJSBl1FwF/ziYWhjMYlF/qwv+7fOcbMUGoRmB+NhmM
 jCEo6esMEwYrAl9NFfJHCGohNBXWE348m1oFP9xXAgkR5cCAf/IL8wuzKBW0ubqCpo1Q/rr6
 H08GArafyX4ap2Kgrnk8YI+gVoPpc3+gUjiVBD99Y4EooiLB21YV8IioKOj2lGNCbSncKm0U
 CTgSfE8HCQEvhH7vUJjgjwN3yTVCwCowjbiDfCxYLV9FwrtSaL3pCZ5iDrTY3bh/F6C+kPDt
 0sswQdgMZa3DQZMc/vRZA7sAlQaVoxKB1kJ5xcOgZR1YJmuxYrSYD6nNh1TiQyrxIZX4kEpm
 JK5EUUaO02Ww3Go9mx/HqXWcUZ8Rl5atq0P/vla773lOA+ruHo1zIIxEDgSkSDE74mYCwcoi
 0tVHj7GG7IMGo5blHEhO4oqoiIQNrWkyKkN9mM1i2RzW8F/FyPDoAkyZeXLA/C2FHX5wT1ot
 2k1H18RUVMiaj/fEz89IVBf0M6NtK0wNJ/YOGuvmdnp6rtjHN7mvJtYX1Y811dhcD3O3nZqR
 +F5zO2Xru8EDShelP5eevDlX02u6F3M0DJdnY3tyaKOz9kl+wcSMpR/llpGxXc3KtVb201vZ
 W5W+yL73hnQmPzc+c+f5BbKrXO/tvsv7F5MfLp61Ke+AbE1+7JYLiReMG3AvY97+4UCk7dGe
 JZJUa37HictWyUxVY/ch3Y4J+1qfNTKN7Cl1Frv5pKG8N16duciRkoobQGOOxVq+/J63ShFT
 NmceU6s5Uy1dNC1Lm7LM6Zyf91U+2Z6kwDmNOmG5yMCp/wLA9zNWyQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWS2cA0UXdhGUeqwf8H6harFl5jszi88QyT
 xZN/3xkt/v96xWox58wDFos1K4QtjvfuYLGYNu0JmwOHR8uRt6wed67tYfN4cm0zk8f2WVMZ
 Pd7vu8rmMWHqUpYAtigum5TUnMyy1CJ9uwSujBU3X7IUNPNUHDx7mrGB8T9nFyMnh4SAicS/
 zj1MXYxcHEICqxkl1h3phHI+MUocbvrCCuEsY5SYt2YuG0gLm4CixL6u7WC2iICRxLsbkxhB
 ipgFDjFJzNr5mQkkISxgJ3Hq2k2oInuJ+SfWAsU5wBqWf/AHCbMIqEps2v8VrJxXwFii+dl9
 FhBbSOA0o0T3azMQm1PAUeLDv09gYxgFxCS+n1oDVs8sIC5x68l8JogXBCSW7DnPDGGLSrx8
 /I8VwlaUuP/9JTtEvZ7EjalT2CBsO4nm9zeg4toSyxa+Zoa4QVDi5MwnLBC9khIHV9xgmcAo
 MQvJullIRs1CMmoWklGzkIxawMi6ilG8tLg4N72i2CgvtVyvODG3uDQvXS85P3cTIzDiT/87
 HL2D8fatj3qHGJk4GA8xSnAwK4nwzjRkSxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2PKxRQh
 gfTEktTs1NSC1CKYLBMHp1QDU0Zrr+FrXz8PzXI5TZnaMj++jcEqfOIMVdHn3oS6WV+0yN2x
 neO72Jwofoul4Rorp7Cva7pSs8ns9DeTCI/V79t8N1alcBzYt+6E/KOQ14xHq39+yeNaw7JR
 csrxql8ZIlw/WkVuvr79gcHj33pX51snXnypXF8at5x9q8Xz0CUHe75rb3/Z8PqA8ixNh0Px
 ljpaGZPmvdFLOKsp+G/ew/wnT0UtZjbP5xL/seuHeqnA1hi7/W25t69PY/TKnP5hq8maRwfT
 X+5IdJuTab+8bOIkU94jwS0X5qUtDb6wb+HBhQwc5t3h017lOxzk+dc4y+nhjfsMS3m+ffGU
 XLT1oMLac8cNLmrs3GX+W7tK77QSS3FGoqEWc1FxIgB+ekk+ZwMAAA==
X-CMS-MailID: 20230918161113uscas1p2d9b57ea4fbac5426eb9886a137c1ed7a
CMS-TYPE: 301P
X-CMS-RootMailID: 20230918150335uscas1p1d50d43e7aa4888bb82a5c501fa6ce874
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <CGME20230918150335uscas1p1d50d43e7aa4888bb82a5c501fa6ce874@uscas1p1.samsung.com>
 <20230918150259.11165-2-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 18, 2023 at 04:02:57PM +0100, Jonathan Cameron wrote:

> From: Dmitry Frolov <frolov@swemel.ru>
>=20
> According to cxl_interleave_ways_enc(), fw->num_targets is allowed to be =
up
> to 16. This also corresponds to CXL r3.0 spec. So, the fw->target_hbs[]
> array is iterated from 0 to 15. But it is staticaly declared of length 8.

s/staticaly/statically/

Fan
> Thus, out of bound array access may occur.
>=20
> Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit =
from TYPE_PXB_DEV")
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Link: https://urldefense.com/v3/__https://lore.kernel.org/r/2023091310105=
5.754709-1-frolov@swemel.ru__;!!EwVzqGoTKBqv-0DWAJBm!RYOYJeMCX_mlzCETIKjHDY=
un2TZCQxC7wF1SxIdUwJ3BYbDOtmDpTaVXXiQgiFwLYI_4JAnU6Asem4T0aHKzwzPJWer7$=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 56c9e7676e..4944725849 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -29,7 +29,7 @@ typedef struct PXBCXLDev PXBCXLDev;
>  typedef struct CXLFixedWindow {
>      uint64_t size;
>      char **targets;
> -    PXBCXLDev *target_hbs[8];
> +    PXBCXLDev *target_hbs[16];
>      uint8_t num_targets;
>      uint8_t enc_int_ways;
>      uint8_t enc_int_gran;
> --=20
> 2.39.2
> =

