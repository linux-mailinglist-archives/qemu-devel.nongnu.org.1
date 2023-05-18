Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4370842A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:46:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzetA-0003w8-UY; Thu, 18 May 2023 10:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1pzet7-0003tX-7w
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:45:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1pzet4-0003AX-BE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 10:45:52 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QMXj72YYXz6J6xq;
 Thu, 18 May 2023 22:41:15 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 18 May
 2023 15:45:31 +0100
Date: Thu, 18 May 2023 17:45:26 +0300
To: Juan Quintela <quintela@redhat.com>
CC: <gudkov.andrei@huawei.com>, <qemu-devel@nongnu.org>, <eblake@redhat.com>, 
 <armbru@redhat.com>, <berrange@redhat.com>, <zhengchuan@huawei.com>,
 <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 2/4] migration/calc-dirty-rate: detailed stats in
 sampling mode
Message-ID: <ZGY5ttHypAtAhFSi@DESKTOP-0LHM7NF.china.huawei.com>
References: <cover.1682598010.git.gudkov.andrei@huawei.com>
 <22436421241c49c9b6d9b9120d166392c40fb991.1682598010.git.gudkov.andrei@huawei.com>
 <875y906qce.fsf@secure.mitica>
 <ZF47+rkmPdTKIaH8@DESKTOP-0LHM7NF.china.huawei.com>
 <87h6se2ecs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6se2ecs.fsf@secure.mitica>
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
Reply-to:  <gudkov.andrei@huawei.com>
From: gudkov.andrei--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 15, 2023 at 10:22:43AM +0200, Juan Quintela wrote:
> <gudkov.andrei@huawei.com> wrote:
> > On Wed, May 10, 2023 at 07:36:33PM +0200, Juan Quintela wrote:
> >> Andrei Gudkov <gudkov.andrei@huawei.com> wrote:
> >> > Collect number of dirty pages for progresseively increasing time
> >> > periods starting with 125ms up to number of seconds specified with
> >> > calc-dirty-rate. Report through qmp and hmp: 1) vector of dirty page
> >> > measurements, 2) page size, 3) total number of VM pages, 4) number
> >> > of sampled pages.
> >> >
> >> >  3 files changed, 160 insertions(+), 54 deletions(-)
> >> >
> >> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> > index acba3213a3..4491bbe91a 100644
> >> > --- a/migration/dirtyrate.c
> >> > +++ b/migration/dirtyrate.c
> >> > @@ -224,6 +224,7 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
> >> >      info->calc_time = DirtyStat.calc_time;
> >> >      info->sample_pages = DirtyStat.sample_pages;
> >> >      info->mode = dirtyrate_mode;
> >> > +    info->page_size = TARGET_PAGE_SIZE;
> >> 
> >> I thought we exported this trough ""info migrate"
> >> but we do it only if we are in the middle of a migration.  Perhaps we
> >> should print it always.
> >
> > So, which one do you prefer? To keep it here or to make "info migrate" print it always (or both)?
> 
> info migrate to print it allways.  Thanks.

I looked into "info migrate". To print page size irregarding migration status,
all other 17 fields of MigrationInfo.ram will have to be made optional.
Atop of that, it feels like that page size doesn't belong to "info migrate"
since it is the only one "static" value, while all others are "dynamic" counters.

I think I found a better place where page size can be reported --
query-memory-size-summary. After the change it would be as following:
  {"execute": "query-memory-size-summary"}
  {"return": {"page-size": 4096, "base-memory": 34359738368, "plugged-memory": 0}}

What do you think about it?


