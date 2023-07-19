Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC7759023
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2Py-0007GK-AN; Wed, 19 Jul 2023 04:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qM2Ps-0007G6-JG
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:20:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qM2Po-0000tw-0K
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:20:12 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R5TFR5VQPz6H6lp;
 Wed, 19 Jul 2023 16:17:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 19 Jul
 2023 09:19:48 +0100
Date: Wed, 19 Jul 2023 09:19:47 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, Alison Schofield
 <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Viacheslav
 Dubeyko" <slava@dubeyko.com>, Shesha Bhushan Sreenivasamurthy
 <sheshas@marvell.com>, Fan Ni <fan.ni@samsung.com>, Michael Tsirkin
 <mst@redhat.com>, Jonathan Zhang <jonzhang@meta.com>, Klaus Jensen
 <k.jensen@samsung.com>
Subject: Re: [RFC PATCH 10/17] misc/i2c_mctp_cxl: Initial device emulation
Message-ID: <20230719091947.000043ac@Huawei.com>
In-Reply-To: <ZLcEkSLAj5yXVOVc@memverge.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
 <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
 <ZLcEkSLAj5yXVOVc@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 18 Jul 2023 17:30:57 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Mon, Jul 17, 2023 at 06:16:39PM +0100, Jonathan Cameron wrote:
> > @@ -397,8 +401,9 @@ struct CXLType3Dev {
> >      AddressSpace hostpmem_as;
> >      CXLComponentState cxl_cstate;
> >      CXLDeviceState cxl_dstate;
> > -    CXLCCI cci;
> > -    
> > +    CXLCCI cci; /* Primary PCI mailbox CCI */
> > +    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
> > +  
> 
> I've been humming and hawing over this on the MHD stuff because I wanted
> to figure out how to "add a CCI command" to a type-3 device without
> either having a billion definitions for CCI command sets - or doing
> something like this.
> 
> I don't hate this design pattern, I just want to ask whether your
> intent is to end up with CXLType3Dev hosting many CXLCCI's based on what
> wrapper types you have. 
> 
> Example: a type-3 device with mctp pass through and the MHD command set
> 
> CXLType3Dev {
>     ...
>     CXLCCI cci;
>     CXLCCI oob_mctp_cci;
>     CXLCCI mhd_cci;
>     ...
> }

Yes - that's what I was thinking.  In some cases a CCI may be accessed by
tunneling on a different CCI on the same device as well as the option
of tunneling to different devices.

So far the set that we'll end up with isn't too large. And if some aren't
used for a given instantiation that's fine if it keeps the code simple.
We may end up with other MCTP buses and to keep things consistent each one
will need it's own target CXLCCI. If we need to rethink and make it dynamic
to some degree we can look at it later.

> 
> Instantiate:
> -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 
> -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1
> -device cxl-mhd,target=cxl-pmem1,...whatever else...

Not sure on this - it may be implicit in creating an MHD rather than requiring
a command line to target through.  Depends on what the MHD creation code
looks like - but this is definitely a possibility.

> 
> where the MHD code is contained within its own type/file, and the type3
> device hosts the CCI for it.  Similar to how you've implemented the MTCP
> stuff here.
> 
> The reason I ask is because certain CCI's don't necessarily get
> associated with "a bus" so much as "a device".  the MHD example - it's
> still part of "the device", but it's optional.   

For emulation I don't think we care if it's optional. I think we implement
it whatever and if it is not accessed that is fine.

> So does it make sense
> to create this wrapper without a bus association, or to just pile it on
> top CXLType3Dev and have to duplicate the code across any other
> multi-headed devices that folks may conjur up?

Piling it on top of CXLType3Dev was what I was thinking. We can rethink if
there other multi-headed devices using similar interfaces.

Jonathan


> 
> ~Gregory


