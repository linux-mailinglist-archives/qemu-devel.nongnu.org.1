Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DF73E0E6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmUV-00077K-Px; Mon, 26 Jun 2023 09:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qDmUS-00076Z-QU; Mon, 26 Jun 2023 09:42:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qDmUP-0003XK-MG; Mon, 26 Jun 2023 09:42:48 -0400
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QqTV23PlNz67qq2;
 Mon, 26 Jun 2023 21:39:38 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 14:42:34 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.027; 
 Mon, 26 Jun 2023 14:42:34 +0100
To: Shaoqin Huang <shahuang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "james.morse@arm.com"
 <james.morse@arm.com>, "gshan@redhat.com" <gshan@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Salil Mehta <salil.mehta@opnsrc.net>
Subject: RE: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
Thread-Topic: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
Thread-Index: AQHZp/pp444fl0T5A0KjPRKELV/ZGK+dFe3A
Date: Mon, 26 Jun 2023 13:42:34 +0000
Message-ID: <9df973ede74e4757b510f26cd5786036@huawei.com>
References: <20230626064910.1787255-1-shahuang@redhat.com>
In-Reply-To: <20230626064910.1787255-1-shahuang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.157.164]
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> From: Shaoqin Huang <shahuang@redhat.com>
> Sent: Monday, June 26, 2023 7:49 AM
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: oliver.upton@linux.dev; Salil Mehta <salil.mehta@huawei.com>;
> james.morse@arm.com; gshan@redhat.com; Shaoqin Huang <shahuang@redhat.com=
>;
> Cornelia Huck <cohuck@redhat.com>; kvm@vger.kernel.org; Michael S. Tsirki=
n
> <mst@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>
> Subject: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
>=20
> The userspace SMCCC call filtering[1] provides the ability to forward the=
 SMCCC
> calls to the userspace. The vCPU hotplug[2] would be the first legitimate=
 use
> case to handle the psci calls in userspace, thus the vCPU hotplug can den=
y the
> PSCI_ON call if the vCPU is not present now.
>=20
> This series try to enable the userspace SMCCC call filtering, thus can ha=
ndle
> the SMCCC call in userspace. The first enabled SMCCC call is psci call, b=
y using
> the new added option 'user-smccc', we can enable handle psci calls in use=
rspace.
>=20
> qemu-system-aarch64 -machine virt,user-smccc=3Don
>=20
> This series reuse the qemu implementation of the psci handling, thus the
> handling process is very simple. But when handling psci in userspace when=
 using
> kvm, the reset vcpu process need to be taking care, the detail is include=
d in
> the patch05.

This change in intended for VCPU Hotplug and we are duplicating the code
we are working on. Unless this change is also intended for any other
feature I would request you to defer this.


Thanks
Salil


