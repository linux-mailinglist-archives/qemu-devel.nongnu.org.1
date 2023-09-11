Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C412E79A6A6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfd40-0001hF-8X; Mon, 11 Sep 2023 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qfd3x-0001h2-8P; Mon, 11 Sep 2023 05:18:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qfd3t-000805-N8; Mon, 11 Sep 2023 05:18:32 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rkh126VHXz6HJpq;
 Mon, 11 Sep 2023 17:16:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 11 Sep
 2023 10:18:15 +0100
Date: Mon, 11 Sep 2023 10:18:14 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Li
 Zhijian" <lizhijian@cn.fujitsu.com>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "Michael
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Message-ID: <20230911101814.00006bda@Huawei.com>
In-Reply-To: <aa6e37b6-3bd9-5551-daf5-d040b926518e@tls.msk.ru>
References: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
 <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
 <20230531120823.00001a6c@Huawei.com>
 <0adbfa43-719c-6d8e-9ec9-5d4a402be384@tls.msk.ru>
 <20230808154430.0000291e@Huawei.com>
 <aa6e37b6-3bd9-5551-daf5-d040b926518e@tls.msk.ru>
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

On Fri, 8 Sep 2023 20:02:41 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 08.08.2023 17:44, Jonathan Cameron:
> 
> > Sorry, I'm running a bit behind.  Have this one a few other fixes
> > still queued up - I didn't consider any of them particularly critical
> > for the release so wasn't rushing.
> > 
> > I'll aim to get them out as a series soon though so they are
> > available for start of next cycle if not for slipping in before
> > the release.  
> 
> A month later, friendly ping? :)
> (this is sent to -stable too, fwiw).

https://lore.kernel.org/qemu-devel/20230904132806.6094-2-Jonathan.Cameron@huawei.com/

Posted a series with this in last week.  Hopefully Michael will queue this
in his next pull.

Jonathan
> 
> /mjt
> 
> 


