Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F52769A20
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:52:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQUFt-0001DG-TY; Mon, 31 Jul 2023 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qQUFq-0001Ca-Tp
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:52:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qQUFo-0006aw-HF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:52:14 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RF1L00HL7z6GD9J;
 Mon, 31 Jul 2023 22:47:20 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 15:51:55 +0100
Date: Mon, 31 Jul 2023 17:51:49 +0300
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, <quintela@redhat.com>, <leobras@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>
Subject: Re: [PATCH] migration/calc-dirty-rate: millisecond precision period
Message-ID: <ZMfKhYPyeO74BJoP@DESKTOP-0LHM7NF.china.huawei.com>
References: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
 <ZKcUv1Ge/RVBHJKT@x1n>
 <ZK1NOmUVc/eUivhV@DESKTOP-0LHM7NF.china.huawei.com>
 <ZLWRtU3sXDreCFxO@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZLWRtU3sXDreCFxO@x1n>
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, Jul 17, 2023 at 03:08:37PM -0400, Peter Xu wrote:
> On Tue, Jul 11, 2023 at 03:38:18PM +0300, gudkov.andrei@huawei.com wrote:
> > On Thu, Jul 06, 2023 at 03:23:43PM -0400, Peter Xu wrote:
> > > On Thu, Jun 29, 2023 at 11:59:03AM +0300, Andrei Gudkov wrote:
> > > > Introduces alternative argument calc-time-ms, which is the
> > > > the same as calc-time but accepts millisecond value.
> > > > Millisecond precision allows to make predictions whether
> > > > migration will succeed or not. To do this, calculate dirty
> > > > rate with calc-time-ms set to max allowed downtime, convert
> > > > measured rate into volume of dirtied memory, and divide by
> > > > network throughput. If the value is lower than max allowed
> > > > downtime, then migration will converge.
> > > > 
> > > > Measurement results for single thread randomly writing to
> > > > a 24GiB region:
> > > > +--------------+--------------------+
> > > > | calc-time-ms | dirty-rate (MiB/s) |
> > > > +--------------+--------------------+
> > > > |          100 |               1880 |
> > > > |          200 |               1340 |
> > > > |          300 |               1120 |
> > > > |          400 |               1030 |
> > > > |          500 |                868 |
> > > > |          750 |                720 |
> > > > |         1000 |                636 |
> > > > |         1500 |                498 |
> > > > |         2000 |                423 |
> > > > +--------------+--------------------+
> > > 
> > > Do you mean the dirty workload is constant?  Why it differs so much with
> > > different calc-time-ms?
> > 
> > Workload is as constant as it could be. But the naming is misleading.
> > What is named "dirty-rate" in fact is not "rate" at all.
> > calc-dirty-rate measures number of *uniquely* dirtied pages, i.e. each
> > page can contribute to the counter only once during measurement period.
> > That's why the values are decreasing. Consider also ad infinitum argument:
> > since VM has fixed number of pages and each page can be dirtied only once,
> > dirty-rate=number-of-dirtied-pages/calc-time -> 0 as calc-time -> inf.
> > It would make more sense to report number as "dirty-volume" --
> > without dividing it by calc-time.
> > 
> > Note that number of *uniquely* dirtied pages in given amount of time is
> > exactly what we need for doing migration-related predictions. There is
> > no error here.
> 
> Is calc-time-ms the duration of the measurement?
> 
> Taking the 1st line as example, 1880MB/s * 0.1s = 188MB.
> For the 2nd line, 1340MB/s * 0.2s = 268MB.
> Even for the longest duration of 2s, that's 846MB in total.
> 
> The range is 24GB.  In this case, most of the pages should only be written
> once even if random for all these test durations, right?
> 

Yes, I messed with load generator.
The effective memory region was much smaller than 24GiB.
I performed more testing (after fixing load generator),
now with different memory sizes and different modes.

+--------------+-----------------------------------------------+
| calc-time-ms |                dirty rate MiB/s               |
|              +----------------+---------------+--------------+
|              | theoretical    | page-sampling | dirty-bitmap |
|              | (at 3M wr/sec) |               |              |
+--------------+----------------+---------------+--------------+
|                             1GiB                             |
+--------------+----------------+---------------+--------------+
|          100 |           6996 |          7100 |         3192 |
|          200 |           4606 |          4660 |         2655 |
|          300 |           3305 |          3280 |         2371 |
|          400 |           2534 |          2525 |         2154 |
|          500 |           2041 |          2044 |         1871 |
|          750 |           1365 |          1341 |         1358 |
|         1000 |           1024 |          1052 |         1025 |
|         1500 |            683 |           678 |          684 |
|         2000 |            512 |           507 |          513 |
+--------------+----------------+---------------+--------------+
|                             4GiB                             |
+--------------+----------------+---------------+--------------+
|          100 |          10232 |          8880 |         4070 |
|          200 |           8954 |          8049 |         3195 |
|          300 |           7889 |          7193 |         2881 |
|          400 |           6996 |          6530 |         2700 |
|          500 |           6245 |          5772 |         2312 |
|          750 |           4829 |          4586 |         2465 |
|         1000 |           3865 |          3780 |         2178 |
|         1500 |           2694 |          2633 |         2004 |
|         2000 |           2041 |          2031 |         1789 |
+--------------+----------------+---------------+--------------+
|                             24GiB                            |
+--------------+----------------+---------------+--------------+
|          100 |          11495 |          8640 |         5597 |
|          200 |          11226 |          8616 |         3527 |
|          300 |          10965 |          8386 |         2355 |
|          400 |          10713 |          8370 |         2179 |
|          500 |          10469 |          8196 |         2098 |
|          750 |           9890 |          7885 |         2556 |
|         1000 |           9354 |          7506 |         2084 |
|         1500 |           8397 |          6944 |         2075 |
|         2000 |           7574 |          6402 |         2062 |
+--------------+----------------+---------------+--------------+

Theoretical values are computed according to the following formula:
size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
where size is in bytes, time is in seconds, and wps is number of
writes per second (I measured approximately 3000000 on my system).

Theoretical values and values obtained with page-sampling are
approximately close (<=25%). Dirty-bitmap values are much lower,
likely because the majority of writes cause page faults. Even though
dirty-bitmap logic is closer to what is happening during live
migration, I still favor page sampling because the latter doesn't
impact the performance of VM too much.

Whether calc-time < 1sec is meaningful or not depends on the size
of memory region with active writes.
1. If we have big VM and writes are evenly spread over the whole
   address space, then almost all writes will go into unique pages.
   In this case number of dirty pages will grow approximately
   linearly with time for small calc-time values.
2. But if memory region with active writes is small enough, then many
   writes will go to the same page, and the number of dirty pages
   will grow sublinearly even for small calc-time values. Note that
   the second scenario can happen even VM RAM is big. For example,
   imagine 128GiB VM with in-memory database that is used for reading.
   Although VM size is big, the memory region with active writes is
   just the application stack.


