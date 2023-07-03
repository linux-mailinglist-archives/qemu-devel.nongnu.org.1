Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F367E74539C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 03:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG8SB-00082m-5Z; Sun, 02 Jul 2023 21:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qG8S5-00082a-DC
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 21:34:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qG8S2-0006Mt-FR
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 21:34:04 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QvSzw3S8yz688Z4;
 Mon,  3 Jul 2023 09:30:52 +0800 (CST)
Received: from localhost (10.34.206.101) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 02:33:43 +0100
Date: Mon, 3 Jul 2023 09:33:39 +0800
To: "nifan@outlook.com" <nifan@outlook.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Adam Manzanares
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [RFC 7/7] hw/mem/cxl_type3: add read/write support to dynamic
 capacity
Message-ID: <20230703093339.00002fb2@Huawei.com>
In-Reply-To: <SG2PR06MB33973100A036493C2A644C6BB224A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
 <CGME20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d@uscas1p2.samsung.com>
 <20230511175609.2091136-8-fan.ni@samsung.com>
 <20230515162212.0000275c@Huawei.com>
 <SG2PR06MB33973100A036493C2A644C6BB224A@SG2PR06MB3397.apcprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.206.101]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 28 Jun 2023 10:09:47 -0700
"nifan@outlook.com" <nifan@outlook.com> wrote:

> The 05/15/2023 16:22, Jonathan Cameron wrote:
> > On Thu, 11 May 2023 17:56:40 +0000
> > Fan Ni <fan.ni@samsung.com> wrote:
> >   
> > > From: Fan Ni <nifan@outlook.com>
> > > 
> > > Before the change, read from or write to dynamic capacity of the memory
> > > device is not support as 1) no host backed file/memory is provided for
> > > it; 2) no address space is created for the dynamic capacity.  
> > 
> > Ah nice. I should have read ahead.  Probably makes sense to reorder things
> > so that when we present DCD region it will work.  
> 
> We can back dynamic capacity with host memory/file and create address
> space for dc regions, but until extents can be added we should not expect
> any read/write can happen to the dynamic capacity, right?

True.  Seems logically 'unusual' though to set up the routing etc, but
not plumb the actual memory access i until later.  I guess it all comes
together in the end and doing it this way lets you handle the extent mapping
later.  So fine to leave it as you have it.

Jonathan

