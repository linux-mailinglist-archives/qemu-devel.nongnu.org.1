Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA457A5E70
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:45:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXHh-0004rv-KF; Tue, 19 Sep 2023 05:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qiXHN-0004rZ-Np
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:44:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qiXHM-0007LO-7N
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:44:25 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqcD82LYBz6K6GV;
 Tue, 19 Sep 2023 17:43:20 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 10:44:10 +0100
Date: Tue, 19 Sep 2023 12:44:05 +0300
To: Markus Armbruster <armbru@redhat.com>
CC: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <yong.huang@smartx.com>, <quintela@redhat.com>,
 <peterx@redhat.com>, <leobras@redhat.com>, <eblake@redhat.com>
Subject: Re: [PATCH] migration/dirtyrate: use QEMU_CLOCK_HOST to report
 start-time
Message-ID: <ZQltZU8U7A2wztSw@DESKTOP-0LHM7NF.china.huawei.com>
References: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
 <62489e2b-5d03-1650-6337-a4159e88e439@linaro.org>
 <87il86zfqr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il86zfqr.fsf@pond.sub.org>
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  <gudkov.andrei@huawei.com>
From: gudkov.andrei--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 11:14:52AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > Hi Andrei,
> >
> > On 5/9/23 11:18, Andrei Gudkov via wrote:
> >> Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as
> >> the source for start-time field. This translates to
> >> clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds
> >> since host boot. This is not very useful. The only
> >> reasonable use case of start-time I can imagine is to
> >> check whether previously completed measurements are
> >> too old or not. But this makes sense only if start-time
> >> is reported as host wall-clock time.
> >> This patch replaces source of start-time from
> >> QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.
> >> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> >> ---
> >>   qapi/migration.json   |  4 ++--
> >>   migration/dirtyrate.c | 15 ++++++---------
> >>   2 files changed, 8 insertions(+), 11 deletions(-)
> >
> >
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index bccb3515e3..0510d68765 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -259,11 +259,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
> >>       return info;
> >>   }
> >>   -static void init_dirtyrate_stat(int64_t start_time,
> >> -                                struct DirtyRateConfig config)
> >> +static void init_dirtyrate_stat(struct DirtyRateConfig config)
> >>   {
> >>       DirtyStat.dirty_rate = -1;
> >> -    DirtyStat.start_time = start_time;
> >> +    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
> >>       DirtyStat.calc_time = config.sample_period_seconds;
> >>       DirtyStat.sample_pages = config.sample_pages_per_gigabytes;
> >>   @@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
> >>       record_dirtypages_bitmap(&dirty_pages, true);
> >>         start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >> -    DirtyStat.start_time = start_time / 1000;
> >> +    DirtyStat.start_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
> >
> > You can directly use qemu_clock_get_us().
> 
> Andrei, care to respin?

But why? Here we need seconds, not microseconds. If there were a function
called qemu_clock_get_seconds(QEMUClockType) then we could use it here directly.
But there is no such function.

If you wish, we can do one of the following:
1) introduce qemu_clock_get_seconds(QEMUClockType) and use it directly
   without scaling
2) change the unit of DirtyStat.start_time from seconds to milliseconds
   and use qemu_clock_get_ms(QEMUClockType) directly without scaling


