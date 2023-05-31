Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7C718548
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:48:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4N6Y-0004cL-RR; Wed, 31 May 2023 10:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q4N6R-0004ai-1D
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:47:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q4N6J-0007IX-Gd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:47:03 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWX926mqGz67bZK;
 Wed, 31 May 2023 22:44:38 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 15:46:46 +0100
Date: Wed, 31 May 2023 17:46:40 +0300
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, <quintela@redhat.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <zhengchuan@huawei.com>
Subject: Re: [PATCH v2 0/4] Migration time prediction using calc-dirty-rate
Message-ID: <ZHdd0BDefsv02SWX@DESKTOP-0LHM7NF.china.huawei.com>
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <ZHYaajucX3WbO5oW@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHYaajucX3WbO5oW@x1n>
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On Tue, May 30, 2023 at 11:46:50AM -0400, Peter Xu wrote:
> Hi, Andrei,
> 
> On Thu, Apr 27, 2023 at 03:42:56PM +0300, Andrei Gudkov via wrote:
> > Afterwards we tried to migrate VM after randomly selecting max downtime
> > and bandwidth limit. Typical prediction error is 6-7%, with only 180 out
> > of 5779 experiments failing badly: prediction error >=25% or incorrectly
> > predicting migration success when in fact it didn't converge.
> 
> What's the normal size of the VMs when you did the measurements?

VM size in all experiments was 32GiB. However, since some of the pages
are zero, the effective VM size was smaller. I checked the value of
precopy-bytes counter after the first migration iteration. Median value
among all experiments is 24.3GiB.

> 
> A major challenge of convergence issues come from huge VMs and I'm
> wondering whether those are covered in the prediction verifications.

Hmmm... My understanding is that convergence primarily depends on how
agressive VM dirties pages and not on VM size. Small VM with agressive
writes would be impossible to migrate without throttling. On the contrary,
migration of the huge dormant VM will converge in just single iteration
(although a long one). The only reason I can imagine why large VM size can
negatively affect convergence is due to the following reasoning: larger VM
size => bigger number of vCPUs => more memory writes per second.
Or do you probably mean that during each iteration we perform
KVM_CLEAR_DIRTY_LOG, which is (I suspect) linear in time and can become
bottleneck for large VMs? Anyway, I will conduct experiments with
large VMs.


I think that the easiest way to predict whether VM migration will converge
or not is the following. Run calc-dirty-rate with calc-time equal to
desired downtime. If it reports that the volume of dirtied memory over
calc-time period is larger than you can copy over network in the same time,
then you are out of luck. Alas, at the current moment calc-time accepts
values in units of seconds, while reasonable downtime lies in range 50-300ms.
I am preparing a separate patch that will allow to specify calc-time in
milliseconds. I hope that this approach will be cleaner than an array of
hardcoded values I introduced in my original patch.

> 
> Thanks,
> 
> -- 
> Peter Xu

