Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C67053F1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyxb3-0007VG-9g; Tue, 16 May 2023 12:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyxay-0007Uy-Lc
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:32:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1pyxav-0003qD-Fz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:32:16 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLMDg0Czsz67QqC;
 Wed, 17 May 2023 00:30:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 17:31:58 +0100
Date: Tue, 16 May 2023 17:31:56 +0100
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Michael Roth <michael.roth@amd.com>, 
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 0/7] QEMU CXL Provide mock CXL events and irq support
Message-ID: <20230516173116.00007c8d@huawei.com>
In-Reply-To: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
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

On Sun, 23 Apr 2023 17:51:33 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> v5: Rebase including version number updates to 8.1

Hi Michael,

I asked a few people to look at the remaining couple of patches where
there were only my tags so now I think all the following have
had some review and I'm not aware of any outstanding issues with them

I did postpone one piece of general feedback from Philippe for future
work as it wasn't specific to the patch but more general feedback on
older code. For reference, the question concerned why we have
cxl_dstate as a structure in the CXLType3Dev rather than using the 
QEMU device model and inheriting from it.

Majority of what we have in these 6 sets (including this one)
came from other contributors so I've reviewed and tested all those
as part of adding my SOB when gathering them up.

Anything you'd like to see in the way of additional review on these?

We have a number of other series, that will hopefully be in a position
to post for possible merge soon, but I'm guessing you'd rather we didn't
stack more than this in one go.

Other than fixes, this is all stuff left over from previous cycle.

Thanks,

Jonathan

> 
> Depends on 
> [PATCH 0/2] hw/cxl: CDAT file handling fixes.
> [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
> [PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.
> [PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
> [PATCH v5 0/6] hw/cxl: Poison get, inject, clear
> 
> Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230421160827.2227-1-Jonathan.Cameron@huawei.com
> Based on: Message-ID: 20230423162013.4535-1-Jonathan.Cameron@huawei.com
> 
> Cover letter from earlier version
> 
> One challenge here is striking the right balance between lots of constraints
> in the injection code to enforce particular reserved bits etc by breaking
> out all the flags as individual parameters vs having a reasonably concise
> API.  I think this set strikes the right balance but others may well
> disagree :)   Note that Ira raised the question of whether we should be
> automatically establishing the volatile flag based on the Device Physical
> Address of the injected error. My proposal is to not do so for now, but
> to possibly revisit tightening the checking of injected errors in future.
> Whilst the volatile flag is straight forwards, some of the other flags that
> could be automatically set (or perhaps checked for validiaty) are much more
> complex. Adding verification at this stage would greatly increase the
> complexity of the patch + we are missing other elements that would interact
> with this.  I'm not concerned about potential breaking of backwards compatibility
> if it only related to the injection of errors that make no sense for a real
> device.
> 
> CXL Event records inform the OS of various CXL device events.  Thus far CXL
> memory devices are emulated and therefore don't naturally generate events.
> 
> Add an event infrastructure and mock event injection.  Previous versions
> included a bulk insertion of lots of events.  However, this series focuses on
> providing the ability to inject individual events through QMP.  Only the
> General Media Event is included in this series as an example.  Other events can
> be added pretty easily once the infrastructure is acceptable.
> 
> In addition, this version updates the code to be in line with the
> specification based on discussions around the kernel patches.
> 
> Injection examples;
> 
> { "execute": "cxl-inject-gen-media-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "physaddr": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "device": 5,
>         "component-id": "iras mem"
>     }}
> 
> 
> { "execute": "cxl-inject-dram-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "physaddr": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "rank": 17,
>         "nibble-mask": 37421234,
>         "bank-group": 7,
>         "bank": 11,
>         "row": 2,
>         "column": 77,
>         "correction-mask": [33, 44, 55, 66]
>     }}
> 
> { "execute": "cxl-inject-memory-module-event",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-mem0",
>     "log": "informational",
>     "flags": 1,
>     "type": 3,
>     "health-status": 3,
>     "media-status": 7,
>     "additional-status": 33,
>     "life-used": 30,
>     "temperature": -15,
>     "dirty-shutdown-count": 4,
>     "corrected-volatile-error-count": 3233,
>     "corrected-persistent-error-count": 1300
>   }}
> 
> Ira Weiny (4):
>   hw/cxl/events: Add event status register
>   hw/cxl/events: Wire up get/clear event mailbox commands
>   hw/cxl/events: Add event interrupt support
>   hw/cxl/events: Add injection of General Media Events
> 
> Jonathan Cameron (3):
>   hw/cxl: Move CXLRetCode definition to cxl_device.h
>   hw/cxl/events: Add injection of DRAM events
>   hw/cxl/events: Add injection of Memory Module Events
> 
>  hw/cxl/cxl-device-utils.c   |  43 +++++-
>  hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++------
>  hw/cxl/meson.build          |   1 +
>  hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3_stubs.c    |  35 +++++
>  include/hw/cxl/cxl_device.h |  80 +++++++++-
>  include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
>  qapi/cxl.json               | 120 +++++++++++++++
>  9 files changed, 1097 insertions(+), 56 deletions(-)
>  create mode 100644 hw/cxl/cxl-events.c
>  create mode 100644 include/hw/cxl/cxl_events.h
> 


