Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A569679DA85
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAXx-000404-Jk; Tue, 12 Sep 2023 17:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAXu-0003w7-VO
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:03:42 -0400
Received: from mailout1.w2.samsung.com ([211.189.100.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fan.ni@samsung.com>)
 id 1qgAXs-0006fA-Qe
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:03:42 -0400
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id
 20230912210339usoutp017b1cc88fc5ff9a4daebd629cb4c0a949~EQqEwAKUh2039920399usoutp01h;
 Tue, 12 Sep 2023 21:03:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com
 20230912210339usoutp017b1cc88fc5ff9a4daebd629cb4c0a949~EQqEwAKUh2039920399usoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1694552619;
 bh=DOqSvw7Y44WAzGsRb4cGWazhML1uEC8j+aqoXhqjuRQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=NjLoYQZWdgxDYGOUU3EOKJtgm9WAwaDuhLae5yopAy6h+uQ4PTwB2nst3wTQUnMlz
 cmxaVY6BLzBrmdw8l4pQohjdTaWvE53fMSoXl6HhxTU6+L55MpDETzSHhlucHHmKNc
 lrDbe0NdN2jMXmRQUR55xSZMqw3b8PFDGajgRz5A=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20230912210339uscas1p265b39a907f9e5b280888e72965a518c7~EQqEjCmNe2330423304uscas1p2D;
 Tue, 12 Sep 2023 21:03:39 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id AA.0A.40279.B22D0056; Tue,
 12 Sep 2023 17:03:39 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20230912210339uscas1p1accbfcd78c5bab1a97ccc56b6fb33307~EQqETdXtG1590215902uscas1p1B;
 Tue, 12 Sep 2023 21:03:39 +0000 (GMT)
X-AuditID: cbfec36f-241ff70000009d57-a5-6500d22b53a3
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 63.E2.28590.B22D0056; Tue,
 12 Sep 2023 17:03:39 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
 SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2375.24; Tue, 12 Sep 2023 14:03:38 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
 SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
 12 Sep 2023 14:03:38 -0700
From: Fan Ni <fan.ni@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/3] tests/acpi: Update DSDT.cxl with QTG DSM
Thread-Topic: [PATCH v2 3/3] tests/acpi: Update DSDT.cxl with QTG DSM
Thread-Index: AQHZ30u3Ix1ifTO1ok+37+StG6K3KLAYL/QA
Date: Tue, 12 Sep 2023 21:03:38 +0000
Message-ID: <20230912210338.GB2828853@sjcvldevvm72>
In-Reply-To: <20230904161847.18468-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <313B2E40F0E6A640AD273F14FA79A03F@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djXc7ralxhSDX7dVLE4cbORzWLVwmts
 FudnnWKxOLzxDJPF/1+vWC3WrBC2ON67g8WB3aPlyFtWj8V7XjJ53Lm2h83jybXNTB7v911l
 8/i8SS6ALYrLJiU1J7MstUjfLoErY/KxPWwFW7kqTrZdZ21g/MPRxcjJISFgItHZ8Iu1i5GL
 Q0hgJaPE7nOrGSGcViaJvRd+MsJUXdy3gAkisZZR4teV01Atnxgljt/fwgzhLGOUuLdwNxNI
 C5uAosS+ru1sILaIgJHEuxuTwEYxCyxmkmj/WwViCwu4SDxY2cgIUeMq8Xj1RmaY+sWvrwLN
 4eBgEVCVWN0JdiuvgLFE95kprCA2p4CjRPO31WA2o4CYxPdTa5ggxotL3HoynwniakGJRbP3
 MEPYYhL/dj1kg7AVJe5/f8kOUa8ncWPqFDYI207i/M9rUHO0JZYtfM0MsVdQ4uTMJywQvZIS
 B1fcYAH5V0LgBofEs1W9UAtcJFYuamOHsKUlrl6fygxyv4RAssSqj1wQ4RyJ+Uu2QM2xllj4
 Zz3TBEaVWUjOnoXkpFlITpqF5KRZSE5awMi6ilG8tLg4Nz212CgvtVyvODG3uDQvXS85P3cT
 IzBNnf53OH8H4/VbH/UOMTJxMB5ilOBgVhLhLTn0N0WINyWxsiq1KD++qDQntfgQozQHi5I4
 r6HtyWQhgfTEktTs1NSC1CKYLBMHp1QDk3TJyZl7JgcWHL1e6/6g/OLb/VPjXxu2OxhzLD9X
 d8GY91tPz5Qupf9Xb8z0XtZWqqPx702MX93xpZejHu7bsqx1Wp17/H4h4cddAg9WZcvKRum+
 fzHxd96atcyycncDZqt2BkRdZbC0aHb1Vtlz/2XY0Tnvtmo9iHVeb9DXdPhH2afK61sjrSw1
 d4mZy+9vkvbJ2JuysuWZ7MyU4rLGmU1/Vf2qeH1tXf/YPf3HdldeWGXp194eccNTMfe5i/Vr
 pzKqmbae5PGTXHKW4dmp3TF3t0l85ekKUnh/2+n07DPFV/eqCJWsK+f1Sc9mnm/zfLrbE/ZN
 s04rmoT0zeX812XNIvH246ZD151cb6dzKrEUZyQaajEXFScCAAbzM6XCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWS2cA0SVf7EkOqwZbnAhYnbjayWaxaeI3N
 4vysUywWhzeeYbL4/+sVq8WaFcIWx3t3sDiwe7QcecvqsXjPSyaPO9f2sHk8ubaZyeP9vqts
 Hp83yQWwRXHZpKTmZJalFunbJXBlTD62h61gK1fFybbrrA2Mfzi6GDk5JARMJC7uW8DUxcjF
 ISSwmlGi69pdNgjnE6NEz+RbzBDOMkaJE++OM4K0sAkoSuzr2s4GYosIGEm8uzEJLM4ssJhJ
 ov1vFYgtLOAi8WBlIyNEjavE49UbmWHqF7++CrSOg4NFQFVidSfYFbwCxhLdZ6awgthCAuUS
 zS9Pg9mcAo4Szd9Wg9mMAmIS30+tYYJYJS5x68l8JogPBCSW7DnPDGGLSrx8/I8VwlaUuP/9
 JTtEvZ7EjalT2CBsO4nzP69BzdGWWLbwNTPEDYISJ2c+YYHolZQ4uOIGywRGiVlI1s1CMmoW
 klGzkIyahWTUAkbWVYzipcXFuekVxYZ5qeV6xYm5xaV56XrJ+bmbGIExfvrf4cgdjEdvfdQ7
 xMjEwXiIUYKDWUmEt+TQ3xQh3pTEyqrUovz4otKc1OJDjNIcLErivDumXEwREkhPLEnNTk0t
 SC2CyTJxcEo1MPWuff1OoL1udaI4V1Fzn7RPnfbVN/7tPTPzJZr+xx0oE13TUmTWfPlJ3mrz
 BZNnq5m9SIiaIHkyOE/c9KpW8axDEyZfclWwqnr25mCU9eb12RP77hZLicg9zCpUPByjZLXv
 ZewSg96rDZyTH2VMufh059r1py3yUy5VP0xm9DE4e+TP1pVt1wSr7rJGeOXVvObJ5TD211Jr
 PxH24t6mW7/ObPkey5V2tvcZi3JkwOfO+IeVE6ckaTu8DX4x+eppXuFrEy/w5dtMlPQ+yL2/
 axrzCr+fz3O224gKlWrLOXnPfd7uznjmt2qBzJLao10fD3s7ROyaX8B2ZOvu1QtfTC5/q/88
 +25pQ3Pe/l3AAGIpzkg01GIuKk4EACaxU5NgAwAA
X-CMS-MailID: 20230912210339uscas1p1accbfcd78c5bab1a97ccc56b6fb33307
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912210339uscas1p1accbfcd78c5bab1a97ccc56b6fb33307
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
 <20230904161847.18468-4-Jonathan.Cameron@huawei.com>
 <CGME20230912210339uscas1p1accbfcd78c5bab1a97ccc56b6fb33307@uscas1p1.samsung.com>
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

On Mon, Sep 04, 2023 at 05:18:47PM +0100, Jonathan Cameron wrote:

> Description of change in previous patch.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/q35/DSDT.cxl                | Bin 9655 -> 9723 bytes
>  2 files changed, 1 deletion(-)
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 9ce0f596cc..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.cxl",
> diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
> index ee16a861c2de7b7caaf11d91c50fcdf308815233..d4272e87c00e010a6805b6a27=
6fcc87d9b6ead17 100644
> GIT binary patch
> delta 129
> zcmdn){o9+%CD<k8w<-ezW5-6WiHaE>Z1KTP@zG5VY|arrz8vu$o-VwO&H<hV28QMg
> zA{_C-A&v}77)2ae;$4D$c@|hs&JYyl5?J;#_4B>ug$~QIw(xNK_XREBoSen5M39-0
> gae?^cEXE~5f=3Dq&}Tuh7%LL7`B1_Q(9{fa-B0lXk1>i_@%
>=20
> delta 61
> zcmezEz1^G3CD<ioyD9?%qu)lZiHa&J@xe~<(M__>5k9^g@gANoypGNRo(2Yn<_sbn
> R@xdXE3`-a{Gb{aI1^_O_5bOW|
>=20
> --=20
> 2.39.2
>=20
> =

