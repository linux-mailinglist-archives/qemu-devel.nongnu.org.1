Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4862570DAB9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1PQr-0005Zi-SX; Tue, 23 May 2023 06:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q1PQp-0005ZC-FD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:39:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q1PQn-0000vh-Dh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:39:55 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQW114f1Fz6J7Bm;
 Tue, 23 May 2023 18:35:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 11:39:49 +0100
Date: Tue, 23 May 2023 11:39:48 +0100
To: Fan Ni <nifan@outlook.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira
 Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P .
 =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>
Subject: Re: [PATCH v7 3/7] hw/cxl/events: Wire up get/clear event mailbox
 commands
Message-ID: <20230523113948.000009f3@Huawei.com>
In-Reply-To: <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <CGME20230522151125uscas1p1ac7cc62cf284544e2b827d7cacaba8cd@uscas1p1.samsung.com>
 <20230522150947.11546-4-Jonathan.Cameron@huawei.com>
 <SG2PR06MB3397AB10C301F4F596EBD688B2439@SG2PR06MB3397.apcprd06.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon, 22 May 2023 12:50:34 -0700
Fan Ni <nifan@outlook.com> wrote:

> The 05/22/2023 16:09, Jonathan Cameron wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL testing is benefited from an artificial event log injection
> > mechanism.
> > 
> > Add an event log infrastructure to insert, get, and clear events from
> > the various logs available on a device.
> > 
> > Replace the stubbed out CXL Get/Clear Event mailbox commands with
> > commands that operate on the new infrastructure.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> See comments below in cxl_event_insert.

...

> > +    memcpy(&entry->data, event, sizeof(*event));
> > +
> > +    entry->data.hdr.handle = cpu_to_le16(log->next_handle);
> > +    log->next_handle++;
> > +    /* 0 handle is never valid */
> > +    if (log->next_handle == 0) {  
> 
> next_handle is uint16_t, how can it be 0 after next_handle++?

Intent was to deal with wrap around.
We are fine with reusing handles after sufficiently long time that
there can't be a confusion, just not 0 as that has special
meaning when used to 'point' to a related event
(see definition of Related Event Record Handle)

> 
> > +        log->next_handle++;
> > +    }
> > +    entry->data.hdr.timestamp = cpu_to_le64(time);
> > +
> > +    QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> > +    cxl_event_set_status(cxlds, log_type, true);
> > +
> > +    /* Count went from 0 to 1 */
> > +    return cxl_event_count(log) == 1;
> > +}

