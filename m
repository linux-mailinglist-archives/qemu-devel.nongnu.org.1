Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC37AED6D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7cp-0004t5-19; Tue, 26 Sep 2023 08:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7cZ-0004sd-QP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:56:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7cW-0003xs-KS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:56:58 -0400
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rvzhy4Km1zNnpp;
 Tue, 26 Sep 2023 20:34:58 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 20:38:47 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 13:38:45 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>, lixianglai <lixianglai@loongson.cn>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Salil Mehta
 <salil.mehta@opnsrc.net>, Bernhard Beschow <shentey@gmail.com>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v3 1/7] Update ACPI GED framework to support vcpu
 hot-(un)plug
Thread-Topic: [PATCH v3 1/7] Update ACPI GED framework to support vcpu
 hot-(un)plug
Thread-Index: AQHZ8F994Y7ua3lglUS84h/PG+ftMbAs4HKAgAAGrgCAAAuuAIAAGDHQ
Date: Tue, 26 Sep 2023 12:38:44 +0000
Message-ID: <e8fbec0306d24cdab3398772a8301fc7@huawei.com>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <14ee117df13b08403032eb07843b91e1861228d9.1695697701.git.lixianglai@loongson.cn>
 <20230926070229-mutt-send-email-mst@kernel.org>
 <bc29c4fe-7180-6e00-2e91-a6a89c37b85a@loongson.cn>
 <20230926080738-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926080738-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=szxga02-in.huawei.com
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

Hi Michael,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, September 26, 2023 1:08 PM
>=20
> On Tue, Sep 26, 2023 at 07:26:40PM +0800, lixianglai wrote:
> >
> > Hi, Michael S. Tsirkin :
> > > On Tue, Sep 26, 2023 at 05:54:26PM +0800, xianglai li wrote:
> > > > ACPI GED shall be used to convey to the guest kernel about any cpu
> hot-(un)plug
> > > > events. Therefore, existing ACPI GED framework inside QEMU needs to
> be enhanced
> > > > to support CPU hot-(un)plug state and events.
> > > >
> > > > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > > This is not the way to handle multiple emails.
> >
> > Oh, sorry, I'll delete the first one.
> >
> > Thanks,
> >
> > Xianglai.
>=20
> Can you guys figure out together with Salil Mehta what's the
> correct order to merge this? I can't figure out with dueling patches.

We already have an agreed approach and Loongson folks will
rebase from the common patch-set. There is no contention.=20

Thanks
Salil.




