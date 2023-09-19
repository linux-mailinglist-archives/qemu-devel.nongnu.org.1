Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBFA7A5D7F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWlW-0000JG-6D; Tue, 19 Sep 2023 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiWlP-0000GR-Ks
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:11:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiWlL-00063F-1b
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:11:23 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqbPZ2kDBz6DB69;
 Tue, 19 Sep 2023 17:06:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 10:11:06 +0100
Date: Tue, 19 Sep 2023 10:11:05 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>
Subject: Re: [PATCH v2 4/4] hw/cxl: Line length reductions
Message-ID: <20230919101105.00000ef6@Huawei.com>
In-Reply-To: <20230918164844.GB3331103@sjcvldevvm72>
References: <20230915170418.21337-1-Jonathan.Cameron@huawei.com>
 <CGME20230915170627uscas1p1fc329ca937e09b2953d2b243fb88e07e@uscas1p1.samsung.com>
 <20230915170418.21337-5-Jonathan.Cameron@huawei.com>
 <20230918164844.GB3331103@sjcvldevvm72>
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

On Mon, 18 Sep 2023 16:48:45 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> On Fri, Sep 15, 2023 at 06:04:18PM +0100, Jonathan Cameron wrote:
> > Michael Tsirkin observed that there were some unnecessarily
> > long lines in the CXL code in a recent review.
> > This patch is intended to rectify that where it does not
> > hurt readability.
> > 
> > Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> One minor comment inline. Other than that, looks good to me.

> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index c8d632d540..915c208209 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -240,7 +240,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 1);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
> > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > +                     POISON_ON_ERR_CAP, 0);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> >                       HDM_DECODER_ENABLE, 0);
> >      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> > @@ -263,13 +264,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >      }
> >  }
> >  
> > -void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk,
> > +void cxl_component_register_init_common(uint32_t *reg_state,
> > +                                        uint32_t *write_msk,
> >                                          enum reg_type type)
> >  {
> >      int caps = 0;
> >  
> >      /*
> > -     * In CXL 2.0 the capabilities required for each CXL component are such that,
> > +     * In CXL2.0 the capabilities required for each CXL component are such that,  
> 
> It seems we always leave a space between CXL and 2.0 in other
> places.

Indeed odd :) I'll put that space back in an rewrap that for v3.

Jonathan

