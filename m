Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1917B1C2F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 14:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlq3P-00068T-3W; Thu, 28 Sep 2023 08:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlq3M-00068J-6u
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:23:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlq3A-00076D-MV
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 08:23:34 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RxCL735mFz6K9FP;
 Thu, 28 Sep 2023 20:22:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 13:22:57 +0100
Date: Thu, 28 Sep 2023 13:22:57 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Message-ID: <20230928132257.000039ce@Huawei.com>
In-Reply-To: <20230927191327.GA4138120@sjcvldevvm72>
References: <CGME20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf@uscas1p1.samsung.com>
 <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
 <20230927191327.GA4138120@sjcvldevvm72>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 27 Sep 2023 19:13:35 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Mon, Sep 25, 2023 at 04:22:58PM +0100, Jonathan Cameron wrote:
> 
> > Rename the version not burried in the macro to cap_h.  
> The change looks good to me. Just one minor thing. why "version" get
> involved here?
>

Used in the sense of two copies of something with slightly differences
given if it were straight code without a macro, we'd have just
have used the copy being changed here for all of the calls. 
With hindsight, not the best word to choose given the many other meanings!

Jonathan


> Fan
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > I had another instance of this in a series I'll post later today.
> > Cleaned that up the same way.
> > 
> >  hw/cxl/cxl-device-utils.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > index 517f06d869..bd68328032 100644
> > --- a/hw/cxl/cxl-device-utils.c
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -283,13 +283,13 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> >  
> >  void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
> >  {
> > -    uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
> > +    uint64_t *cap_h = cxl_dstate->caps_reg_state64;
> >      const int cap_count = 3;
> >  
> >      /* CXL Device Capabilities Array Register */
> > -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> > -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> > -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
> > +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> > +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> > +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
> >  
> >      cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
> >      device_reg_init_common(cxl_dstate);
> > -- 
> > 2.39.2
> >  


