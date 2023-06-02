Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A87202A2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 15:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q54Ul-0006B7-MG; Fri, 02 Jun 2023 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q54Uc-0006Aj-Dg
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:06:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q54Ua-00033e-Q9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:06:58 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjtw4Rk3z6J76K;
 Fri,  2 Jun 2023 21:06:32 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 14:06:36 +0100
Date: Fri, 2 Jun 2023 16:06:30 +0300
To: "Wang, Lei" <lei4.wang@intel.com>
CC: <qemu-devel@nongnu.org>, <quintela@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <zhengchuan@huawei.com>
Subject: Re: [PATCH v2 4/4] migration/calc-dirty-rate: tool to predict
 migration time
Message-ID: <ZHnpVr3/2Ygjhk+y@DESKTOP-0LHM7NF.china.huawei.com>
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <644a9e7f2bff9d36716a3722c729dc88ea40a35a.1682598010.git.gudkov.andrei@huawei.com>
 <35e564bc-7fe0-e6e2-b674-062fe952cbcf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <35e564bc-7fe0-e6e2-b674-062fe952cbcf@intel.com>
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  <gudkov.andrei@huawei.com>
From: gudkov.andrei--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 30, 2023 at 11:21:38AM +0800, Wang, Lei wrote:
> On 4/27/2023 20:43, Andrei Gudkov via wrote:
> > +    deadline constraint.
> > +
> > +    :param model: `MemoryModel` object for a given VM
> > +    :param bandwidth: Bandwidth available for migration [bytes/s]
> > +    :param downtime: Max allowed downtime [milliseconds]
> > +    :param deadline: Max total time to migrate VM before timeout [milliseconds]
> > +    :return: Predicted migration time [milliseconds] or `None`
> > +             if migration process doesn't converge before given deadline
> > +    """
> > +
> > +    left_zero_pages = model.num_zero_pages()
> > +    left_normal_pages = model.num_total_pages() - model.num_zero_pages()
> > +    header_size = 8
> 
> In the cover letter: "Typical prediction error is 6-7%". I'm wondering if the
> 6-7% is less or more than the real migration time. I think 2 potential factors
> will lead to less estimation time:
> 
>   1. Network protocol stack's headers are not counted in, e.g., TCP's header can
>      be 20 ~ 60 bytes.
> 
>   2. The bandwidth may not be saturated all the time.

Yes, I totally missed network headers in my model!

I do not see any noticeable assymetry in prediction error. Sometimes
prediction overestimates actual migration time, sometimes -- underestimates.
I think that prediction error is caused mainly by VM workload not being
perfectly stable over time.


