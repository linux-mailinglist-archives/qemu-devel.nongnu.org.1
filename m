Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBED75EE90
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrOI-00008j-28; Mon, 24 Jul 2023 04:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qNrOF-00008b-VJ
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:58:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qNrOD-0001mN-B3
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:58:03 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R8Yr01xHPz688p7;
 Mon, 24 Jul 2023 16:54:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 09:57:48 +0100
Date: Mon, 24 Jul 2023 09:57:48 +0100
To: Ira Weiny <ira.weiny@intel.com>
CC: <nifan@outlook.com>, <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, 
 <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
 <cbrowy@avery-design.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Message-ID: <20230724095748.00007e46@Huawei.com>
In-Reply-To: <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
References: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
 <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
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
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Sat, 22 Jul 2023 21:52:06 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> nifan@ wrote:
> > From: Fan Ni <nifan@outlook.com>
> > 
> > The patch series provides dynamic capacity device (DCD) emulation in Qemu.  
> 
> I don't the patches on the list.
> 
> https://lore.kernel.org/all/SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/
> 
> Did they get sent?
Something odd going on...
They are in https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg04105.html
though threading is broken.
Also seems to have made it to qemu-devel on lore
https://lore.kernel.org/all/SG2PR06MB3397F3E74A083607F7492FA4B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/

Might be a backlog somewhere that will take a while to drain...

Fan, perhaps just resend the lot and make sure the threading works so we can find them more easily.

Jonathan


> 
> Ira
> 
> > More specifically, it provides the following functionalities:
> > 1. Extended type3 memory device to support DC regions and extents.
> > 2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
> > 3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
> > functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
> > 4. Add new ct3d properties for DCD devices (host backend, number of dc
> > regions, etc.)
> > 5. Add read/write support from/to DC regions of the device.
> > 6. Add mechanism to validate accessed to DC region address space.
> > 
> > A more detailed description can be found from the previously posted RFC[1].
> > 
> > Compared to the previously posted RFC[1], following changes have been made:
> > 1. Rebased the code on top of Jonathan's branch
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
> > 2. Extracted the rename of mem_size to a separated patch.(Jonathan)
> > 3. Reordered the patch series to improve its readability.(Jonathan)
> > 4. Split the validation of accesses to DC region address space as a separate
> > patch.
> > 5. Redesigned the QMP interfaces for adding and releasing DC extents to make
> > them easier to understand and act like existing QMP interfaces (like the
> > interface for cxl-inject-uncorrectable-errors). (Jonathan)
> > 6. Updated dvsec range register setting to support DCD devices without static
> > capacity.
> > 7. Fixed other issues mentioned in the comments (Jonathan&Nathan Fontenot).
> > 8. Fixed the format issues and checked with checkpatch.pl under qemu code dir.
> > 
> > 
> > The code is tested with the DCD patch series at the kernel side[2]. The test
> > is similar to those mentioned in the cover letter of [1].
> > 
> > 
> > [1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> > [2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl.notmuch/T/#t
> > 
> > Fan Ni (9):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |   6 +
> >  include/hw/cxl/cxl_device.h |  49 +++-
> >  include/hw/cxl/cxl_events.h |  16 ++
> >  qapi/cxl.json               |  49 ++++
> >  6 files changed, 1034 insertions(+), 46 deletions(-)
> > 
> > -- 
> > 2.39.2
> >   
> 
> 
> 


