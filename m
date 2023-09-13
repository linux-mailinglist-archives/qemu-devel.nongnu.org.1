Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B621B79E2E7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLn2-0007bJ-HD; Wed, 13 Sep 2023 05:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLmu-0007Zh-3a
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:03:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgLmi-0001X2-BC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:03:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rlvb93q9Cz6HJbM;
 Wed, 13 Sep 2023 17:01:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 10:03:39 +0100
Date: Wed, 13 Sep 2023 10:03:38 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
 "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Message-ID: <20230913100338.000006c2@Huawei.com>
In-Reply-To: <20230912180844.GD319114@bgt-140510-bm03>
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
 <20230911114313.6144-5-Jonathan.Cameron@huawei.com>
 <CGME20230912180845uscas1p28e989eaff6b92939cfdb85886137354b@uscas1p2.samsung.com>
 <20230912180844.GD319114@bgt-140510-bm03>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 12 Sep 2023 18:08:44 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Sep 11, 2023 at 12:43:13PM +0100, Jonathan Cameron wrote:
> 
> > Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> > and CXL Type 3 end points.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---  
> 
> One comment inline, other than that, looks good to me.

I think we are fine, but also possible I'm missing something :)

> >  
> >  /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
> >  #define EXTSEC_ENTRY_MAX        256
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index aa011a8f34..3ecdad4a5e 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -90,6 +90,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> >  
> >      switch (offset) {
> >      case A_CXL_HDM_DECODER0_CTRL:
> > +    case A_CXL_HDM_DECODER1_CTRL:
> > +    case A_CXL_HDM_DECODER2_CTRL:
> > +    case A_CXL_HDM_DECODER3_CTRL:
> >          should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> >          should_uncommit = !should_commit;  
> 
> So for the commit/uncommit flag, we always check decoder 0 control
> register? Or i read it wrong? I thought the commit bit is per control register
> thing?

This is in the write handler and the value passed in that we are looking at is
for whichever of the _CTRL registers is being written.

I could have coded this as separate entries for each register as
FIELD_EX32(value, CXL_HDM_DECODER[X]_CTRL, COMMIT)
but as this only figures out the field offset and mask, it is the same for X=0,1,2,3

Jonathan




