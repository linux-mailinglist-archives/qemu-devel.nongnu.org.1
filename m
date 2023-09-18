Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4BB7A4E60
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGrX-0002YK-RH; Mon, 18 Sep 2023 12:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGrV-0002XJ-Ir
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:12:38 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qiGrT-0006Gh-Ig
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:12:37 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230918161231usoutp01bf083161b5686d9328e024366f622424~GCjmGiNx32154221542usoutp01o;
 Mon, 18 Sep 2023 16:12:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230918161231usoutp01bf083161b5686d9328e024366f622424~GCjmGiNx32154221542usoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1695053551;
 bh=68mS6gLWXNF7wtbWOvHwfOK+A4Zp+v/XeJX//J3Gu2Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=YYnoFkxiQUHY7R5DDwLaTdyYMbllSeJm1mpmsoGHth/aI5aMojm1ODMmGV0hZMOpr
 ieGha2ZIbiYlQc2M+vrxI7hJUL9lykR3rWyAStwSKqWJ+bwcJqTuJQ2nQ8gdZI/LO6
 1xkEKg/4JpIFosanDPYTjrobLTMUTnNmVsqz2eXo=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230918161231uscas1p173f4e7051121d9079d6d742c2fd6f87e~GCjl6v3UG0527305273uscas1p1o;
 Mon, 18 Sep 2023 16:12:31 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 65.89.50148.FE678056; Mon,
 18 Sep 2023 12:12:31 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
 [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230918161231uscas1p22f3221e1a59f0380ba773764efb0a9b5~GCjlpbSP00122901229uscas1p2B;
 Mon, 18 Sep 2023 16:12:31 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-03-650876efec3e
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
 ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 52.E1.31410.FE678056; Mon,
 18 Sep 2023 12:12:31 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Mon, 18 Sep 2023 09:12:30 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
 18 Sep 2023 09:12:30 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
Thread-Topic: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and
 license notice
Thread-Index: AQHZ6kFnJLcD1/JbJkCC9AZ50/8Ut7AhNq4A
Date: Mon, 18 Sep 2023 16:12:30 +0000
Message-ID: <20230918161230.GB3330304@sjcvldevvm72>
In-Reply-To: <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2702CA9468AE8B40B726C9FD3E9E1CF3@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djX87rvyzhSDU7dVLdYtfAam8XhjWeY
 LJ78+85o8f/XK1aLOWcesFisWSFscbx3B4vFtGlP2Bw4PFqOvGX1uHNtD5vHk2ubmTy2z5rK
 6PF+31U2jwlTl7IEsEVx2aSk5mSWpRbp2yVwZSzo6mUv+M1e0d7xnqmBcRNbFyMnh4SAicSC
 x5tZQGwhgZWMEh8ajLoYuYDsViaJGz+es8IUzZzdzw6RWMsosfPoFWYI5xOjxLabf1gh2pcx
 SjybLQ5iswkoSuzr2g62QkTASOLdjUmMIA3MAoeYJGbt/MwEkhAWCJV48mw6I0RRmMT7r62M
 MA2PN88CuomDg0VAVeLw9nqQMK+AsUTf7A3sIGFOAUeJLRsUQcKMAmIS30+tAZvILCAucevJ
 fCaIowUlFs3ewwxhi0n82/UQ6mNFifvfX7JD1OtJ3Jg6hQ3CtpM4vXMnK4StLbFs4WtmiLWC
 EidnPmGB6JWUOLjiBgvIKxICTzgkHqy7A5VwkZi48R3UMmmJ6Wsug50vIZAsseojF0Q4R2L+
 ki1Q5dYSC/+sZ5rAqDILydmzkJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb5qWW6xUn5haX
 5qXrJefnbmIEpqvT/w7n7mDcceuj3iFGJg7GQ4wSHMxKIrwzDdlShXhTEiurUovy44tKc1KL
 DzFKc7AoifMa2p5MFhJITyxJzU5NLUgtgskycXBKNTCZTuadnKNW2mA99+uPJTslK91L63Zb
 SLQkF37q6OZL82HRumjuesX6rGWdGVP88kWPqjI7b7e3+E7lnn9ANWnpV2Wf9NsXVHa1RswP
 ad+SvvyHX8naf7ypKmf9HuV4Opx+0bM6aIPDD4aL8eobE4XZdS0jZn1eYjw9dEPys6Udr2+u
 bzx8jvvsB9/TP3Wdj8f+23U5OPvDindcLVN7ivx3brTP1dZKeSa+WUezwlo+9wDnkp8pmqut
 7oTtZZPQvHzex2nGQ/eDiYGffhrFVJne0Kn4pXDHZ9L83Vf4TrwOXdHZcer0h9AHfa/yHv78
 umhawGp11anWAa+PqhqEr3/N/n7eNcnpzhlz/qbdPiSrxFKckWioxVxUnAgAP7FWZMYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWS2cA0Ufd9GUeqwYXzwharFl5jszi88QyT
 xZN/3xkt/v96xWox58wDFos1K4QtjvfuYLGYNu0JmwOHR8uRt6wed67tYfN4cm0zk8f2WVMZ
 Pd7vu8rmMWHqUpYAtigum5TUnMyy1CJ9uwSujAVdvewFv9kr2jveMzUwbmLrYuTkkBAwkZg5
 u5+9i5GLQ0hgNaNEw7/3jBDOJ0aJ/fuPMIFUCQksY5TY9CIWxGYTUJTY17UdrFtEwEji3Y1J
 YA3MAoeYJGbt/AzWICwQKvHk2XSgBAdQUZhE829XmPrHm2exgIRZBFQlDm+vBwnzChhL9M3e
 AHXEaUaJb7N3sYPUcAo4SmzZoAhSwyggJvH91Bqw6cwC4hK3nsxngnhAQGLJnvPMELaoxMvH
 /1ghbEWJ+99fskPU60ncmDqFDcK2kzi9cycrhK0tsWzha2aIGwQlTs58wgLRKylxcMUNlgmM
 ErOQrJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrio3zUsv1ihNzi0vz0vWS83M3MQKj/fS/
 wzE7GO/d+qh3iJGJg/EQowQHs5II70xDtlQh3pTEyqrUovz4otKc1OJDjNIcLErivDumXEwR
 EkhPLEnNTk0tSC2CyTJxcEo1MHXGbctVYPbpKYv4HixeFNB0rzypXDF9sbbfU9EMrwlRjXwZ
 TAcLLtsG/7ysUZDBZqZ0hXHGwqscfaqfA22jbK7+P+J+6sIFUePftqwtt6IvVi3t2NWcUCA4
 40nOrJTebz3LDiiqyqp9t+aw0skLrvl0SptfYuKDKr69XfMWdqfe1WQL1LrOqOixMfbNm7dy
 6wQK+VgOtXsIGSjI8sq3HGh5sqzzd4/SejaVlTzMn6ecY+dQCFy90LktVUiIXWXB7w3aDZZi
 nA//f2gxubRRzu3LzbR+70c3GHuT3j9MuXMvxsGx0vzxItMqx2NH7YLnmUkHMon55OzLeNUq
 4WoeeGh5c/bkB/c9me+s8FBiKc5INNRiLipOBABq185JZQMAAA==
X-CMS-MailID: 20230918161231uscas1p22f3221e1a59f0380ba773764efb0a9b5
CMS-TYPE: 301P
X-CMS-RootMailID: 20230918150405uscas1p148f487247402c71604f30a6b227965a8
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <CGME20230918150405uscas1p148f487247402c71604f30a6b227965a8@uscas1p1.samsung.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 18, 2023 at 04:02:58PM +0100, Jonathan Cameron wrote:

> This has been missing from the start. Assume it should match
> with cxl/cxl-component-utils.c as both were part of early
> postings from Ben.
>=20
> Suggested-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c5855d4e7d..ad3f0f6a9d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,3 +1,12 @@
> +/*
> + * CXL Type 3 (memory expander) device
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See =
the
> + * COPYING file in the top-level directory.
> + */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> --=20
> 2.39.2
> =

