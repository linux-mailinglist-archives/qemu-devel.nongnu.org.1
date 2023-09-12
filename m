Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B579D13B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2eb-0007yY-El; Tue, 12 Sep 2023 08:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2eY-0007y6-Sn
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:38:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2eV-0006zK-Qe
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:38:02 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlNQB09FWz6K6Mc;
 Tue, 12 Sep 2023 20:37:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 13:37:51 +0100
Date: Tue, 12 Sep 2023 13:37:50 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, <kwangjin.ko@sk.com>
Subject: Re: [PATCH 5/5] cxl/vendor: SK hynix Niagara Multi-Headed SLD Device
Message-ID: <20230912133750.000036bb@Huawei.com>
In-Reply-To: <ZPdRjVjbbe9DkHW5@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-6-gregory.price@memverge.com>
 <20230906140445.00002acd@Huawei.com>
 <ZPdRjVjbbe9DkHW5@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Tue, 5 Sep 2023 12:04:29 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, Sep 06, 2023 at 02:04:45PM +0100, Jonathan Cameron wrote:
> > On Thu, 31 Aug 2023 21:29:14 -0400
> > Gregory Price <gourry.memverge@gmail.com> wrote:
> > 
> > Hi Gregory,
> > 
> > Some comments inline, but I'm happy to add this to my staging tree in the meantime
> > as it stands (might be a few days until I push a new branch though).
> >   
> 
> I'm going to do one a quick v3 today with the feedback and some cleanup
> in spots i noticed.
> 
> > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > Signed-off-by: Junhee Ryu <junhee.ryu@sk.com>
> > > Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>  
> > 
> > The SoB chain needs cleaning up.  Is this a co-developed situation?
> > If it is use the rules in the kernel documentation as I don't think those
> > are yet clearly stated in QEMU docs (and they are confusing so I won't try
> > to restate them here).
> >   
> 
> TL;DR: They gave me the command list, I wrote the model.  We got
> approval to release the model, but I wasn't sure how to capture the
> copyright/SoB list.  I suppose the copyright covers SKh, but since I
> authored the model, it only requires my SoB?

Yes - I think only your SoB is fine.  Maybe some text to explain the other
parts.

> 
> After reading, I'm still not sure how to capture this lol.
> 
> Should I just switch the skh folks to Co-developed-by?
> 
> >   
> > > diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> > > new file mode 100644
> > > index 0000000000..4e57db65f1
> > > --- /dev/null
> > > +++ b/hw/cxl/vendor/skhynix/meson.build
> > > @@ -0,0 +1 @@
> > > +system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> > > diff --git a/hw/cxl/vendor/skhynix/skhynix_niagara.c b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > > new file mode 100644
> > > index 0000000000..88e53cc6cc
> > > --- /dev/null
> > > +++ b/hw/cxl/vendor/skhynix/skhynix_niagara.c
> > > @@ -0,0 +1,516 @@
> > > +/*
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright (c) 2023 MemVerge Inc.
> > > + * Copyright (c) 2023 SK hynix Inc.
> > > + */
> > > +
> > > +#include <sys/shm.h>  
> > 
> > This will need some osdep.h magic.  There is some there
> > already but it will need relaxing (unless you want to run only on sparc ;)
> > and we may need to make this device linux host only.
> > 
> >   
> 
> Good point, I had not considered osdep issues.  Do you know of any
> examples of linux-only devices I can use to do a quick patch-up? I 
> can come back around on this issue later.

No idea.

> 
> >   
> > > +
> > > +enum {
> > > +    NIAGARA_MHD = 0x55,
> > > +        #define GET_MHD_INFO 0x0  
> > 
> > Is this standard as it's in the normal space?
> > If it is then I'd like the implementation pushed down to the
> > type3 implementation (with some callbacks or similar.)
> >   
> 
> :thinking_face:
> 
> maybe a similar pattern to the callback from before? I suppose I could
> push this down into type3 and add an mhd callback in the class and have
> niagara fill that in with the callback.
> 
> That *feels* right, so i'll go ahead with it.
> 
> 
> 
> If I misunderstood anything, let me know
> 
> ~Gregory


