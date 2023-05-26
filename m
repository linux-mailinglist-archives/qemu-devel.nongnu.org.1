Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277F712B70
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:10:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2axM-0007wS-IQ; Fri, 26 May 2023 13:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2axE-0007w0-Gu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:10:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2axC-0005eV-5S
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:10:16 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWZr24NPz67Q3T;
 Sat, 27 May 2023 01:08:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 18:10:05 +0100
Date: Fri, 26 May 2023 18:10:04 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira
 Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, "Daniel P . =?ISO-8859-1?Q?Berrang=E9?="
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Mike Maslenkin
 <mike.maslenkin@gmail.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <20230526181004.0000512d@Huawei.com>
In-Reply-To: <87h6rz8bnj.fsf@pond.sub.org>
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
 <87h6rz8bnj.fsf@pond.sub.org>
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


> > +# @temperature: Device temperature in degrees Celsius.
> > +#
> > +# @dirty-shutdown-count: Number of time the device has been unable to  
> 
> Number of times
> 
> > +#                        determine whether data loss may have occurred.
> > +#
> > +# @corrected-volatile-error-count: Total number of correctable errors in
> > +#                                  volatile memory.
> > +#
> > +# @corrected-persistent-error-count: Total number correctable errors in
> > +#                                    persistent memory  
> 
> Please format like
> 
>    # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>    #     Record Format, Event Record Flags for subfield definitions.
>    #
>    # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>    #     Event Record for bit definitions for bit definiions.
>    #
>    # @health-status: Overall health summary bitmap.  See CXL r3.0 Table
>    #     8-100 Get Health Info Output Payload, Health Status for bit
>    #     definitions.
>    #
>    # @media-status: Overall media health summary.  See CXL r3.0 Table
>    #     8-100 Get Health Info Output Payload, Media Status for bit
>    #     definitions.
>    #
>    # @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
>    #     Payload, Additional Status for subfield definitions.
>    #
>    # @life-used: Percentage (0-100) of factory expected life span.
>    #
>    # @temperature: Device temperature in degrees Celsius.
>    #
>    # @dirty-shutdown-count: Number of time the device has been unable to
>    #     determine whether data loss may have occurred.

With "Number of times" this runs to 71 chars. reflowed appropriately for v8

>    #
>    # @corrected-volatile-error-count: Total number of correctable errors
>    #     in volatile memory.
>    #
>    # @corrected-persistent-error-count: Total number correctable errors
>    #     in persistent memory
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).
> 
> 
> > +#

