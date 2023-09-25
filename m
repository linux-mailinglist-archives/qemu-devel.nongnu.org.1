Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6C7AE040
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qks5a-0008BK-PH; Mon, 25 Sep 2023 16:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qks5X-0008AX-Sr; Mon, 25 Sep 2023 16:21:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qks5U-0003ju-KF; Mon, 25 Sep 2023 16:21:51 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvZ4c3xQpz6KBS7;
 Tue, 26 Sep 2023 04:20:32 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 21:21:43 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Mon, 25 Sep 2023 21:21:43 +0100
To: Russell King <linux@armlinux.org.uk>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "james.morse@arm.com" <james.morse@arm.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lorenzo.pieralisi@linaro.com" <lorenzo.pieralisi@linaro.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "ardb@kernel.org" <ardb@kernel.org>, "justin.he@arm.com" <justin.he@arm.com>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: RE: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8
 Arch
Thread-Index: AQHZ7+i7tN7TN6a6DkKo79sQc15MlrAr9QQQ///zwoCAABEDYA==
Date: Mon, 25 Sep 2023 20:21:43 +0000
Message-ID: <a4f5b9370c2c45c7a09fe55f4a7b1a62@huawei.com>
References: <20230925194333.18244-1-salil.mehta@huawei.com>
 <1ba2e69bf0a94c1498ab5863b365559b@huawei.com>
 <ZRHpyxCe8ybsxKck@shell.armlinux.org.uk>
In-Reply-To: <ZRHpyxCe8ybsxKck@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.153.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Russell,

> From: Russell King <linux@armlinux.org.uk>
> Sent: Monday, September 25, 2023 9:13 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org;
> james.morse@arm.com; jean-philippe@linaro.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; lorenzo.pieralisi@linaro.com;
> lpieralisi@kernel.org; peter.maydell@linaro.org;
> richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev=
;
> david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
> will@kernel.org; catalin.marinas@arm.com; ardb@kernel.org;
> justin.he@arm.com; oliver.upton@linux.dev; pbonzini@redhat.com;
> mst@redhat.com; gshan@redhat.com; rafael@kernel.org;
> borntraeger@linux.ibm.com; alex.bennee@linaro.org;
> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
> miguel.luis@oracle.com; sudeep.holla@arm.com; salil.mehta@opnsrc.net;
> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn
> Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv=
8
> Arch
>=20
> On Mon, Sep 25, 2023 at 08:03:56PM +0000, Salil Mehta wrote:
> > Looks like some problem with Huawei's mail server server. No patches
> > except the cover letter are reaching the qemu-devel mailing-list.
>=20
> I haven't seen any of the actual patches - just the cover letters.
> Was that intentional?

No. all the patches are either getting held either by the server or
Some other problem. This has happened for both the instances of the
patch-set I had pushed to the mailing list within 2 hours.=20

I am not sure how to sort it out without the help of IT. China is
asleep now.

Any suggestions welcome to debug this. Or Should I wait till tomorrow?

Many thanks
Salil.


