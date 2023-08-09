Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A327761E8
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTjj1-0002J2-9p; Wed, 09 Aug 2023 09:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qTjiv-0002GH-11
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:59:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1qTjis-0000l8-Ll
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:59:40 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RLWrH5pJdz688JH;
 Wed,  9 Aug 2023 21:59:11 +0800 (CST)
Received: from localhost (10.199.58.101) by lhrpeml500004.china.huawei.com
 (7.191.163.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:59:13 +0100
Date: Wed, 9 Aug 2023 16:59:07 +0300
To: Yong Huang <yong.huang@smartx.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
 <quintela@redhat.com>, <peterx@redhat.com>, <leobras@redhat.com>,
 <eblake@redhat.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
Message-ID: <ZNObqxnNAB40MR7e@DESKTOP-0LHM7NF.china.huawei.com>
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 <87fs4y3cqx.fsf@pond.sub.org>
 <CAK9dgmaW1qu3mTa50noH+v_kTSWvsgH1zCBZU-u4KHJmoVn4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmaW1qu3mTa50noH+v_kTSWvsgH1zCBZU-u4KHJmoVn4tA@mail.gmail.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Sun, Aug 06, 2023 at 02:31:43PM +0800, Yong Huang wrote:
> On Sat, Aug 5, 2023 at 2:05 AM Markus Armbruster <armbru@redhat.com> wrote:
> 
> > Andrei Gudkov <gudkov.andrei@huawei.com> writes:
> >
> > > Introduces alternative argument calc-time-ms, which is the
> > > the same as calc-time but accepts millisecond value.
> > > Millisecond granularity allows to make predictions whether
> > > migration will succeed or not. To do this, calculate dirty
> > > rate with calc-time-ms set to max allowed downtime, convert
> > > measured rate into volume of dirtied memory, and divide by
> > > network throughput. If the value is lower than max allowed
> > > downtime, then migration will converge.
> > >
> > > Measurement results for single thread randomly writing to
> > > a 1/4/24GiB memory region:
> > >
> > > +--------------+-----------------------------------------------+
> > > | calc-time-ms |                dirty rate MiB/s               |
> > > |              +----------------+---------------+--------------+
> > > |              | theoretical    | page-sampling | dirty-bitmap |
> > > |              | (at 3M wr/sec) |               |              |
> > > +--------------+----------------+---------------+--------------+
> > > |                             1GiB                             |
> > > +--------------+----------------+---------------+--------------+
> > > |          100 |           6996 |          7100 |         3192 |
> > > |          200 |           4606 |          4660 |         2655 |
> > > |          300 |           3305 |          3280 |         2371 |
> > > |          400 |           2534 |          2525 |         2154 |
> > > |          500 |           2041 |          2044 |         1871 |
> > > |          750 |           1365 |          1341 |         1358 |
> > > |         1000 |           1024 |          1052 |         1025 |
> > > |         1500 |            683 |           678 |          684 |
> > > |         2000 |            512 |           507 |          513 |
> > > +--------------+----------------+---------------+--------------+
> > > |                             4GiB                             |
> > > +--------------+----------------+---------------+--------------+
> > > |          100 |          10232 |          8880 |         4070 |
> > > |          200 |           8954 |          8049 |         3195 |
> > > |          300 |           7889 |          7193 |         2881 |
> > > |          400 |           6996 |          6530 |         2700 |
> > > |          500 |           6245 |          5772 |         2312 |
> > > |          750 |           4829 |          4586 |         2465 |
> > > |         1000 |           3865 |          3780 |         2178 |
> > > |         1500 |           2694 |          2633 |         2004 |
> > > |         2000 |           2041 |          2031 |         1789 |
> > > +--------------+----------------+---------------+--------------+
> > > |                             24GiB                            |
> > > +--------------+----------------+---------------+--------------+
> > > |          100 |          11495 |          8640 |         5597 |
> > > |          200 |          11226 |          8616 |         3527 |
> > > |          300 |          10965 |          8386 |         2355 |
> > > |          400 |          10713 |          8370 |         2179 |
> > > |          500 |          10469 |          8196 |         2098 |
> > > |          750 |           9890 |          7885 |         2556 |
> > > |         1000 |           9354 |          7506 |         2084 |
> > > |         1500 |           8397 |          6944 |         2075 |
> > > |         2000 |           7574 |          6402 |         2062 |
> > > +--------------+----------------+---------------+--------------+
> > >
> > > Theoretical values are computed according to the following formula:
> > > size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> > > where size is in bytes, time is in seconds, and wps is number of
> > > writes per second.
> > >
> > > Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> > > ---
> > >  qapi/migration.json   | 14 ++++++--
> > >  migration/dirtyrate.h | 12 ++++---
> > >  migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
> > >  3 files changed, 67 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 8843e74b59..82493d6a57 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -1849,7 +1849,11 @@
> > >  # @start-time: start time in units of second for calculation
> > >  #
> > >  # @calc-time: time period for which dirty page rate was measured
> > > -#     (in seconds)
> > > +#     (rounded down to seconds).
> > > +#
> > > +# @calc-time-ms: actual time period for which dirty page rate was
> > > +#     measured (in milliseconds).  Value may be larger than requested
> > > +#     time period due to measurement overhead.
> > >  #
> > >  # @sample-pages: number of sampled pages per GiB of guest memory.
> > >  #     Valid only in page-sampling mode (Since 6.1)
> > > @@ -1866,6 +1870,7 @@
> > >             'status': 'DirtyRateStatus',
> > >             'start-time': 'int64',
> > >             'calc-time': 'int64',
> > > +           'calc-time-ms': 'int64',
> > >             'sample-pages': 'uint64',
> > >             'mode': 'DirtyRateMeasureMode',
> > >             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> > > @@ -1908,6 +1913,10 @@
> > >  #     dirty during @calc-time period, further writes to this page will
> > >  #     not increase dirty page rate anymore.
> > >  #
> > > +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> > > +#    two arguments are mutually exclusive.  Exactly one of them must
> > > +#    be specified. (Since 8.1)
> > > +#
> > >  # @sample-pages: number of sampled pages per each GiB of guest memory.
> > >  #     Default value is 512.  For 4KiB guest pages this corresponds to
> > >  #     sampling ratio of 0.2%.  This argument is used only in page
> > > @@ -1925,7 +1934,8 @@
> > >  #                                                 'sample-pages': 512} }
> > >  # <- { "return": {} }
> > >  ##
> > > -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> > > +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> > > +                                         '*calc-time-ms': 'int64',
> > >                                           '*sample-pages': 'int',
> > >                                           '*mode':
> > 'DirtyRateMeasureMode'} }
> > >
> >
> > Having both @calc-time and @calc-time-ms is ugly.
> >
> > Can we deprecate @calc-time?
> >
> Since the upper app Libvirt has used this field to implement
> the virDomainStartDirtyRateCalc API unfortunately.
> Deprecating this requires the extra patch on Libvirt but no
> functional improvement, IMHO, the field could remain untouched.
> 
> >
> > I don't like the name @calc-time-ms.  We don't put units in names
> > elsewhere.
> >
> > Differently ugly: new member containing the fractional part, i.e. time
> > in seconds = calc-time + fractional-part / 1000.  With a better name, of
> > course.
> >
> > [...]
> >
> >

As another alternative I can propose to add an optional field that
specifies time unit.

Initiate dirty page rate measurements for 300ms period:
{"execute": "calc-dirty-rate",
 "arguments":{"calc-time": 300, "time-unit": "millis"}}

Query dirty rate. Report calc-time in milliseconds:
{"execute": "query-dirty-rate",
 "arguments":{"time-unit": "millis"}}

> Thanks,
> 
> Yong
> -- 
> Best regards

