Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 570AC828B93
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:57:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGKp-0004om-NJ; Tue, 09 Jan 2024 12:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNGKh-0004jS-Fw
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:56:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNGKT-0006C4-8u
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:56:11 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8dpm0tfSz6K5pf;
 Wed, 10 Jan 2024 01:54:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 17D4F140736;
 Wed, 10 Jan 2024 01:55:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 17:55:54 +0000
Date: Tue, 9 Jan 2024 17:55:54 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 4/4] hw/cxl/events: discard all event records during
 sanitation
Message-ID: <20240109175554.0000467f@Huawei.com>
In-Reply-To: <20240101213828.nxayq6ps3azk2eic@offworld>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-5-42.hyeyoo@gmail.com>
 <20240101213828.nxayq6ps3azk2eic@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 1 Jan 2024 13:38:28 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 22 Dec 2023, Hyeonggon Yoo wrote:
> 
> >Per spec 8.2.9.9.5.1 Sanitize (Opcode 4400h), sanitize command should
> >delete all event logs. Introduce cxl_discard_all_event_logs() and call
> >this in __do_sanitization().  
> 
> lgtm
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

I'll carry this on my tree on top of where I put the previous patch.
Seems to apply there at least :)

If it makes sense to remix these patches a bit to provide cleaner
history I'll do so once these are ready to send for Michael to look
at.

Jonathan

> 
> >Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >---
> > hw/cxl/cxl-events.c         | 13 +++++++++++++
> > hw/cxl/cxl-mailbox-utils.c  |  1 +
> > include/hw/cxl/cxl_device.h |  1 +
> > 3 files changed, 15 insertions(+)
> >
> >diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> >index bee6dfaf14..837b18ab47 100644
> >--- a/hw/cxl/cxl-events.c
> >+++ b/hw/cxl/cxl-events.c
> >@@ -141,6 +141,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> >     return cxl_event_count(log) == 1;
> > }
> >
> >+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
> >+{
> >+    CXLEventLogType log_type;
> >+    CXLEventLog *log;
> >+
> >+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
> >+        log = &cxlds->event_logs[log_type];
> >+        while (!cxl_event_empty(log)) {
> >+            cxl_event_delete_head(cxlds, log_type, log);
> >+        }
> >+    }
> >+}
> >+
> > CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
> >                                  uint8_t log_type, int max_recs,
> >                                  size_t *len)
> >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >index efeb5f8174..2ade351d82 100644
> >--- a/hw/cxl/cxl-mailbox-utils.c
> >+++ b/hw/cxl/cxl-mailbox-utils.c
> >@@ -1150,6 +1150,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
> >             memset(lsa, 0, memory_region_size(mr));
> >         }
> >     }
> >+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
> > }
> >
> > /*
> >diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> >index 5618061ebe..8f05dd9beb 100644
> >--- a/include/hw/cxl/cxl_device.h
> >+++ b/include/hw/cxl/cxl_device.h
> >@@ -604,6 +604,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
> >                                  size_t *len);
> > CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
> >                                    CXLClearEventPayload *pl);
> >+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
> >
> > void cxl_event_irq_assert(CXLType3Dev *ct3d);
> >
> >-- 
> >2.39.3
> >  


