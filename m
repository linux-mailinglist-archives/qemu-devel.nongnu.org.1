Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43A7092E3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwIx-0006Bm-4P; Fri, 19 May 2023 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzwIu-0006AV-AV
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:21:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pzwIr-0004Dc-1Y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:21:40 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN1XT63zzz67nWm;
 Fri, 19 May 2023 17:20:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 10:21:32 +0100
Date: Fri, 19 May 2023 10:21:32 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira Weiny
 <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Michael
 Roth <michael.roth@amd.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud?=
 =?ISO-8859-1?Q?=E9?= <philmd@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <20230519102132.00007a15@Huawei.com>
In-Reply-To: <20230519030515-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
 <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
 <20230519030515-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ab600735eb..a247f506b7 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >       */
> >  }
> >  
> > +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> > +{
> > +    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    AddressSpace *as;
> > +
> > +    if (ct3d->hostvmem) {
> > +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +    }
> > +
> > +    if (!vmr && !pmr) {
> > +        return false;
> > +    }
> > +
> > +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> > +        return false;
> > +    }  
> 
> Fails build:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/4313193004

Fix is just dropping the int128_get64 and accessing directly.

Looks like a wrong 'fix' for the wrong type of size variable (the others
are all replaced now with the mem_region access functions).

I'll send a v6 shortly.

Thanks,

Jonathan

