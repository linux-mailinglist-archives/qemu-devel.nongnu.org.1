Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D869170BB23
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13Mv-00072P-FF; Mon, 22 May 2023 07:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q13Mo-00070i-UO
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:06:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q13Mm-0006EY-Fj
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:06:18 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPvdn3lBYz6J6Yb;
 Mon, 22 May 2023 19:01:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 12:06:02 +0100
Date: Mon, 22 May 2023 12:06:01 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 <linuxarm@huawei.com>, Zeng Hao <zenghao@kylinos.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] hw/cxl: CDAT file handling fixes.
Message-ID: <20230522120601.000029cc@Huawei.com>
In-Reply-To: <d53a8882-eb59-cf09-6ab7-b4a712f20668@tls.msk.ru>
References: <20230421132020.7408-1-Jonathan.Cameron@huawei.com>
 <d53a8882-eb59-cf09-6ab7-b4a712f20668@tls.msk.ru>
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

On Sat, 20 May 2023 07:46:16 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 21.04.2023 16:20, Jonathan Cameron via wrote:
> > I've picked up Hao Zeng's v5 and added a patch to deal with the
> > issues that Peter pointed out in this area.
> > 
> > On error, the CDAT file handling left resource dangling and didn't
> > cleanly exit from calling functions.  Hao Zeng dealt with closing
> > the file. The second patch deals with the buffer allocation and
> > ensuring a clean exit at the two callers.
> > 
> > Hao Zeng (1):
> >    hw/cxl: cdat: Fix open file not closed in ct3_load_cdat()
> > 
> > Jonathan Cameron (1):
> >    hw/cxl: cdat: Fix failure to free buffer in erorr paths
> > 
> >   hw/cxl/cxl-cdat.c            | 60 +++++++++++++++---------------------
> >   hw/mem/cxl_type3.c           |  4 +++
> >   hw/pci-bridge/cxl_upstream.c |  3 ++
> >   3 files changed, 32 insertions(+), 35 deletions(-)  
> 
> Hi!
> 
> Is it a stable (8.0 & 7.2) material?
> The issues does not seem to be very important, still smells like
> a good thing to have in -stable.

Issues are leaks only on an error path, so I'd say no for stable.
If others disagree these should be harmless.

Jonathan

> 
> Thanks,
> 
> /mjt
> 


