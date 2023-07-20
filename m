Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4575AE2C
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMScW-0006Bx-GE; Thu, 20 Jul 2023 08:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qMScS-00067T-9C
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:18:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qMScP-0001Bx-Pn
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:18:56 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R6BTb3dvVz6J7pH;
 Thu, 20 Jul 2023 20:15:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 20 Jul
 2023 13:18:34 +0100
Date: Thu, 20 Jul 2023 13:18:33 +0100
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
Message-ID: <20230720131833.0000575c@Huawei.com>
In-Reply-To: <ZLgwI5N/4RV2kpq1@memverge.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
 <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
 <ZLcEkSLAj5yXVOVc@memverge.com>
 <20230719091947.000043ac@Huawei.com>
 <ZLgwI5N/4RV2kpq1@memverge.com>
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

On Wed, 19 Jul 2023 14:49:07 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Jul 19, 2023 at 09:19:47AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Jul 2023 17:30:57 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> >   
> > > On Mon, Jul 17, 2023 at 06:16:39PM +0100, Jonathan Cameron wrote:  
> > > > @@ -397,8 +401,9 @@ struct CXLType3Dev {
> > > >      AddressSpace hostpmem_as;
> > > >      CXLComponentState cxl_cstate;
> > > >      CXLDeviceState cxl_dstate;
> > > > -    CXLCCI cci;
> > > > -    
> > > > +    CXLCCI cci; /* Primary PCI mailbox CCI */
> > > > +    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
> > > > +    
> > > 
> > > I've been humming and hawing over this on the MHD stuff because I wanted
> > > to figure out how to "add a CCI command" to a type-3 device without
> > > either having a billion definitions for CCI command sets - or doing
> > > something like this.
> > > 
> > > I don't hate this design pattern, I just want to ask whether your
> > > intent is to end up with CXLType3Dev hosting many CXLCCI's based on what
> > > wrapper types you have. 
> > > 
> > > Example: a type-3 device with mctp pass through and the MHD command set
> > > 
> > > CXLType3Dev {
> > >     ...
> > >     CXLCCI cci;
> > >     CXLCCI oob_mctp_cci;
> > >     CXLCCI mhd_cci;
> > >     ...
> > > }  
> > 
> > Yes - that's what I was thinking.  In some cases a CCI may be accessed by
> > tunneling on a different CCI on the same device as well as the option
> > of tunneling to different devices.
> > 
> > So far the set that we'll end up with isn't too large. And if some aren't
> > used for a given instantiation that's fine if it keeps the code simple.
> > We may end up with other MCTP buses and to keep things consistent each one
> > will need it's own target CXLCCI. If we need to rethink and make it dynamic
> > to some degree we can look at it later.
> >   
> 
> Maybe a dangerous suggestion.  Right now the CCI's are static:
> 
> static const struct cxl_cmd cxl_cmd_set[256][256]

That's defined by the ID space for the commands.  There can't be more than
that many currently..

> 
> how difficult might it be to allow these tables to be dynamic instead?
> Then we could add an interface like this:
> 
> void cxl_add_cmd_set(CXLCCI *cci, CXLCCI *cmd_set, payload_max) {
> 	copy(cci, cmd_set);
> }
> 
> This would enable not just adding sub-components piece-meal, but also if
> someone wants to model a real device with custom CCI commands, they can
> simply define a CCI set and pass it in via
> 
> cxl_add_cmd_set(&ct3d->cci, my_cmd_set, payload_max);

Ok.  I'm potentially fine with people adding an interface for this, but
only if they plan to also upstream the QEMU emulation of their actual
device.

> 
> Which lets the existing /dev/cxl/memN device dispatch those commands,
> and makes modeling real devices an easier endeavor.
> 
> Only downside is that this may require changing the command structure to
> include a callback type and pointer per cci function. The upside is this
> would also allow commands to be written somewhat agnostic to the device
> they're being inherited by and allow for device nesting like...
> 
> -device cxl-type3, id=ct3d
> -device cxl-mhd, target=ct3d
> -device my_vendor_cxl_type3, target=ct3d
> etc etc
> 
> otherwise we're probably going to end up with a cxl-type3 -device line
> 300 characters long.
> 
> Maybe that's over-generalizing a bit much n.n;

I'd look to just inherit from a cxl type 3, like Ira did in the PoC for
type 2 support.   We can then easily add a path to replace the commands
set with whatever anyone wants.  I'm not sure we want the command line
to be used to configure such a device as it'll both get very complex and
prove increasingly hard to test more than a small subset of options.

https://lore.kernel.org/all/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/


Jonathan

> 
> ~Gregory


