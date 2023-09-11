Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB179A7A8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffHX-0004sZ-6l; Mon, 11 Sep 2023 07:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qffHU-0004sM-5N
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:40:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qffHP-0001XK-Gv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:40:39 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rkl9B1yRbz6HJq5;
 Mon, 11 Sep 2023 19:38:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 11 Sep
 2023 12:40:30 +0100
Date: Mon, 11 Sep 2023 12:40:29 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 3/3] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230911124029.00000c37@Huawei.com>
In-Reply-To: <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-4-Jonathan.Cameron@huawei.com>
 <b7b7ca18-ec98-d402-9ebd-6ebaf49f7243@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 7 Sep 2023 14:41:16 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 7/9/23 13:35, Jonathan Cameron wrote:
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   include/hw/cxl/cxl_component.h |  10 ++++
> >   hw/cxl/cxl-component-utils.c   |  27 +++++----
> >   hw/cxl/cxl-host.c              |  65 ++++++++++++++-------
> >   hw/mem/cxl_type3.c             | 100 +++++++++++++++++++++++----------
> >   4 files changed, 140 insertions(+), 62 deletions(-) =20
>=20
> If you ever have to respin, please split the 'hdm_inc' introduction
> in a preliminary patch, to reduce the number of changes and the
> probability of missing a bug.
>=20

I didn't do this originally because it's a bit interleaved with the
other changes.  I can make this separable by adding the register definitions
for HDM decoder 1 and a note that it's only used for offset calcs.

I've also pushed it into various other functions that before the
other changes in here don't attempt to deal with multiple hdm decoders
at all.

Didn't end up looking too bad.

Whilst changing this, I noticed a bug where in one place the encoded version
of the hdm count was being used undecoded. So all good in the end :)

Jonathan

