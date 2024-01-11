Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BADE82AEC6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:34:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuFJ-0003wl-Sb; Thu, 11 Jan 2024 07:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNuF8-0003jt-II
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:33:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNuF5-0005dz-1J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:33:05 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9kXP2q6fz6D8g6;
 Thu, 11 Jan 2024 20:30:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E9C05140B33;
 Thu, 11 Jan 2024 20:32:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Jan
 2024 12:32:51 +0000
Date: Thu, 11 Jan 2024 12:32:50 +0000
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/4] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20240111123250.00007748@Huawei.com>
In-Reply-To: <20240109174550.00000f6c@Huawei.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-3-42.hyeyoo@gmail.com>
 <20240109174550.00000f6c@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 9 Jan 2024 17:45:50 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 22 Dec 2023 18:00:49 +0900
> Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> 
> > In the current mdev_reg_read() implementation, it consistently returns
> > that the Media Status is Ready (01b). This was fine until commit
> > 25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> > media was presumed to be ready.
> > 
> > However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> > during sanitation, the Media State should be set to Disabled (11b). The
> > mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> > still returns Media Status as Ready.
> > 
> > To address this, update mdev_reg_read() to read register values instead
> > of returning dummy values.
> > 
> > Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>  
> 
> I've applied this one to my tree.  (I'll push that out in a day or two after
> tidying up some other outstanding stuff). 
> 
> Sometime in next week or so I'll send out a set bundling together various
> fixes and cleanup with the intent for getting it applied.

I've changed how this works because what this is doing as presented is
overwriting the mailbox capability register.  mbox_reg_state64 is as the
name should have made obvious to reviewers such as me, the mailbox registers!

Anyhow, I'll put an alternative fix in place.

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
> >  include/hw/cxl/cxl_device.h |  4 +++-
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > index 29de298117..ba3f80e6e7 100644
> > --- a/hw/cxl/cxl-device-utils.c
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >  
> >  static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
> >  {
> > -    uint64_t retval = 0;
> > -
> > -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> > -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
> > +    CXLDeviceState *cxl_dstate = opaque;
> >  
> > -    return retval;
> > +    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
> >  }
> >  
> >  static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
> > @@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
> >      cxl_dstate->mbox_msi_n = msi_n;
> >  }
> >  
> > -static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> > +static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> > +{
> > +    uint64_t memdev_status_reg;
> > +
> > +    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> > +    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
> > +                                   MBOX_READY, 1);
> > +    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = memdev_status_reg;
> > +}
> >  
> >  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
> >  {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index b2cb280e16..b318d94b36 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -408,7 +408,9 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
> >  {
> >      uint64_t dev_status_reg;
> >  
> > -    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> > +    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
> > +    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
> > +                                val);
> >      cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
> >  }
> >  #define cxl_dev_disable_media(cxlds)                    \  
> 
> 


