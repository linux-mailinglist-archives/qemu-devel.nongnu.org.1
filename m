Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD47716210
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zUH-00047k-DU; Tue, 30 May 2023 09:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q3zTh-0003Yt-P8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:33:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q3zTe-00045b-L2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:33:33 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVtbJ584Nz689rj;
 Tue, 30 May 2023 21:31:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 14:33:19 +0100
Date: Tue, 30 May 2023 14:33:18 +0100
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ira
 Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, "Daniel P . =?ISO-8859-1?Q?Berrang=E9?="
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Mike Maslenkin
 <mike.maslenkin@gmail.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 7/7] hw/cxl/events: Add injection of Memory Module
 Events
Message-ID: <20230530143318.00005430@Huawei.com>
In-Reply-To: <87wn0u4953.fsf@pond.sub.org>
References: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
 <20230526171304.1613-8-Jonathan.Cameron@huawei.com>
 <87wn0u4953.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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


...

> > +#
> > +# @corrected-persistent-error-count: Total number correctable errors  
> 
> Total number of correctable errors

Gah. I've now seen these too often so read that a good 5 times before
working out what was wrong!

> 
> > +#     in persistent memory
> > +#
> > +# Since: 8.1
> > +##
> > +{ 'command': 'cxl-inject-memory-module-event',
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> > +            'type': 'uint8', 'health-status': 'uint8',
> > +            'media-status': 'uint8', 'additional-status': 'uint8',
> > +            'life-used': 'uint8', 'temperature' : 'int16',
> > +            'dirty-shutdown-count': 'uint32',
> > +            'corrected-volatile-error-count': 'uint32',
> > +            'corrected-persistent-error-count': 'uint32'
> > +            }}
> > +
> >  ##
> >  # @cxl-inject-poison:
> >  #  
> 
> Neither these nitpicks nor the one on PATCH 5 calls for a respin.
> Simply fix them in the PR.  Thanks!

Thanks but for now Michael Tsirkin is still picking up the CXL focused
series based on patch sets so I'll spin a v9 with this stuff tidied up.

While, not true of this particular set, a lot of the CXL series are still
impacting the generic PCI code and so far Michael has been happy with that
approach.

Jonathan

