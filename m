Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF27A241F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:02:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCCM-0002yP-50; Fri, 15 Sep 2023 13:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCCK-0002yE-Ff
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:01:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qhCCI-0000Ic-1g
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:01:40 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnL6r2WnZz6K6Cv;
 Sat, 16 Sep 2023 01:00:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 18:01:32 +0100
Date: Fri, 15 Sep 2023 18:01:30 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH 4/4] hw/cxl: Line length reductions
Message-ID: <20230915180130.00001205@Huawei.com>
In-Reply-To: <27faaaee-9fb0-3e11-0545-35945ec68e74@tls.msk.ru>
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
 <20230913150521.30035-5-Jonathan.Cameron@huawei.com>
 <27faaaee-9fb0-3e11-0545-35945ec68e74@tls.msk.ru>
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

On Thu, 14 Sep 2023 15:57:55 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 13.09.2023 18:05, Jonathan Cameron via wrote:
> > Michael Tsirkin observed that there were some unnecessarily
> > long lines in the CXL code in a recent review.
> > This patch is intended to rectify that where it does not
> > hurt readability.  
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> This whole series can be picked up into trivial-patches tree
> (whcih is getting ready to be pushed to master).

I've reworked patch 2 as you made some good points about the
changes making unclear code even more unclear.

Also, I have this on top of a series that touches the same bit
of code.  For me landing that is more important than this, hence
the ordering of the series.

Hopefully Michael Tsirkin will pick up v2 along with the
other series, or whcih can take this in the future once the
dependency is in place.

Jonathan


> 
> /mjt
> 
> 


