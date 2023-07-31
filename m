Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83176A1B5
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 22:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQZA3-0007GF-PN; Mon, 31 Jul 2023 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQZA2-0007G6-Ec
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQZA0-0008PT-Ez
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 16:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690833990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=etPneCMP7X6/dsm7BKq3vvdE4vFMHOBHPr9lMpMqlVU=;
 b=RewejM8SmmD9scCccJzr7yljkRjYTdpG2jU6UhcamNTMaYawJ1uoTyHXZRhhCTtrDsYwKp
 uuDK4kUl66DqDNPYhsr71WsmmG6LO4ZQuodQhY8Uw6u6gCN0wm+WllfTDItMPj9BDsFfX5
 JDWJbKQ5A6BrVHTPnG9jzuQHXQuYngY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-VRQ-_AtPNDy0IUvssDpwfA-1; Mon, 31 Jul 2023 16:06:27 -0400
X-MC-Unique: VRQ-_AtPNDy0IUvssDpwfA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-63c9463c116so10215106d6.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 13:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690833987; x=1691438787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etPneCMP7X6/dsm7BKq3vvdE4vFMHOBHPr9lMpMqlVU=;
 b=WZZuoeVhjXV2sfGGJ72tLCqlRULBSlp1AUd61lhK0KXXWvKpPOP2QwIVULYfYTg37q
 DEnw+KClpRoMZO6WyOXV8Y+kep+2Xtew8q1c6ZhY2zQ608I4a4yJ5Fmm1PFQVY5ZYt0+
 kbCH5yqYF7FdTsrTQfv+efthokHZBNiV5l1K+Br9lx3BMtbAOxYdbVgQsO5c0hryt8+o
 5KMF1XL76ix43PSDkW/kVeXPhBAVWYts5jwBHRXUmlNGsa8U10zxiTwAXg5RvhUKYJVG
 6Ct3gEoEXM1nPgPAc1ok3JdcyLKQlzJji7ba91dyYOw1gjcqrR+bhK6GZCTAcU73FLSS
 8vEg==
X-Gm-Message-State: ABy/qLa9t3+HSnANHFUW34ZK+DhJQ4YCHBpBtOIdCwpSCYdi/PYTwj4N
 8Kk4qPIjtuht+cEJDJQXa9wRQoI5fQi2BEXUhsftoi+5yfx4bqTh2MgrfmCj2hIZtfPN4W1Qzvh
 0kcxtQUH+O21ksVE=
X-Received: by 2002:a05:6214:ace:b0:635:dfe1:c1f2 with SMTP id
 g14-20020a0562140ace00b00635dfe1c1f2mr10571765qvi.0.1690833987312; 
 Mon, 31 Jul 2023 13:06:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4GMtqz0USRZjnLv495nLtmKYMXfPXC3Wmp4GzYizVt/qSOq66t4TmuRyrJsOjB5+yf9/DzA==
X-Received: by 2002:a05:6214:ace:b0:635:dfe1:c1f2 with SMTP id
 g14-20020a0562140ace00b00635dfe1c1f2mr10571753qvi.0.1690833987023; 
 Mon, 31 Jul 2023 13:06:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d19-20020a0cf0d3000000b0063d31b493e1sm4004361qvl.99.2023.07.31.13.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 13:06:26 -0700 (PDT)
Date: Mon, 31 Jul 2023 16:06:24 -0400
From: Peter Xu <peterx@redhat.com>
To: gudkov.andrei@huawei.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 eblake@redhat.com, armbru@redhat.com, Yong Huang <huangy81@chinatelecom.cn>
Subject: Re: [PATCH] migration/calc-dirty-rate: millisecond precision period
Message-ID: <ZMgUQGN+fOiSE5qE@x1n>
References: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
 <ZKcUv1Ge/RVBHJKT@x1n>
 <ZK1NOmUVc/eUivhV@DESKTOP-0LHM7NF.china.huawei.com>
 <ZLWRtU3sXDreCFxO@x1n>
 <ZMfKhYPyeO74BJoP@DESKTOP-0LHM7NF.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMfKhYPyeO74BJoP@DESKTOP-0LHM7NF.china.huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi, Andrei,

On Mon, Jul 31, 2023 at 05:51:49PM +0300, gudkov.andrei@huawei.com wrote:
> On Mon, Jul 17, 2023 at 03:08:37PM -0400, Peter Xu wrote:
> > On Tue, Jul 11, 2023 at 03:38:18PM +0300, gudkov.andrei@huawei.com wrote:
> > > On Thu, Jul 06, 2023 at 03:23:43PM -0400, Peter Xu wrote:
> > > > On Thu, Jun 29, 2023 at 11:59:03AM +0300, Andrei Gudkov wrote:
> > > > > Introduces alternative argument calc-time-ms, which is the
> > > > > the same as calc-time but accepts millisecond value.
> > > > > Millisecond precision allows to make predictions whether
> > > > > migration will succeed or not. To do this, calculate dirty
> > > > > rate with calc-time-ms set to max allowed downtime, convert
> > > > > measured rate into volume of dirtied memory, and divide by
> > > > > network throughput. If the value is lower than max allowed
> > > > > downtime, then migration will converge.
> > > > > 
> > > > > Measurement results for single thread randomly writing to
> > > > > a 24GiB region:
> > > > > +--------------+--------------------+
> > > > > | calc-time-ms | dirty-rate (MiB/s) |
> > > > > +--------------+--------------------+
> > > > > |          100 |               1880 |
> > > > > |          200 |               1340 |
> > > > > |          300 |               1120 |
> > > > > |          400 |               1030 |
> > > > > |          500 |                868 |
> > > > > |          750 |                720 |
> > > > > |         1000 |                636 |
> > > > > |         1500 |                498 |
> > > > > |         2000 |                423 |
> > > > > +--------------+--------------------+
> > > > 
> > > > Do you mean the dirty workload is constant?  Why it differs so much with
> > > > different calc-time-ms?
> > > 
> > > Workload is as constant as it could be. But the naming is misleading.
> > > What is named "dirty-rate" in fact is not "rate" at all.
> > > calc-dirty-rate measures number of *uniquely* dirtied pages, i.e. each
> > > page can contribute to the counter only once during measurement period.
> > > That's why the values are decreasing. Consider also ad infinitum argument:
> > > since VM has fixed number of pages and each page can be dirtied only once,
> > > dirty-rate=number-of-dirtied-pages/calc-time -> 0 as calc-time -> inf.
> > > It would make more sense to report number as "dirty-volume" --
> > > without dividing it by calc-time.
> > > 
> > > Note that number of *uniquely* dirtied pages in given amount of time is
> > > exactly what we need for doing migration-related predictions. There is
> > > no error here.
> > 
> > Is calc-time-ms the duration of the measurement?
> > 
> > Taking the 1st line as example, 1880MB/s * 0.1s = 188MB.
> > For the 2nd line, 1340MB/s * 0.2s = 268MB.
> > Even for the longest duration of 2s, that's 846MB in total.
> > 
> > The range is 24GB.  In this case, most of the pages should only be written
> > once even if random for all these test durations, right?
> > 
> 
> Yes, I messed with load generator.
> The effective memory region was much smaller than 24GiB.
> I performed more testing (after fixing load generator),
> now with different memory sizes and different modes.
> 
> +--------------+-----------------------------------------------+
> | calc-time-ms |                dirty rate MiB/s               |
> |              +----------------+---------------+--------------+
> |              | theoretical    | page-sampling | dirty-bitmap |
> |              | (at 3M wr/sec) |               |              |
> +--------------+----------------+---------------+--------------+
> |                             1GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |           6996 |          7100 |         3192 |
> |          200 |           4606 |          4660 |         2655 |
> |          300 |           3305 |          3280 |         2371 |
> |          400 |           2534 |          2525 |         2154 |
> |          500 |           2041 |          2044 |         1871 |
> |          750 |           1365 |          1341 |         1358 |
> |         1000 |           1024 |          1052 |         1025 |
> |         1500 |            683 |           678 |          684 |
> |         2000 |            512 |           507 |          513 |
> +--------------+----------------+---------------+--------------+
> |                             4GiB                             |
> +--------------+----------------+---------------+--------------+
> |          100 |          10232 |          8880 |         4070 |
> |          200 |           8954 |          8049 |         3195 |
> |          300 |           7889 |          7193 |         2881 |
> |          400 |           6996 |          6530 |         2700 |
> |          500 |           6245 |          5772 |         2312 |
> |          750 |           4829 |          4586 |         2465 |
> |         1000 |           3865 |          3780 |         2178 |
> |         1500 |           2694 |          2633 |         2004 |
> |         2000 |           2041 |          2031 |         1789 |
> +--------------+----------------+---------------+--------------+
> |                             24GiB                            |
> +--------------+----------------+---------------+--------------+
> |          100 |          11495 |          8640 |         5597 |
> |          200 |          11226 |          8616 |         3527 |
> |          300 |          10965 |          8386 |         2355 |
> |          400 |          10713 |          8370 |         2179 |
> |          500 |          10469 |          8196 |         2098 |
> |          750 |           9890 |          7885 |         2556 |
> |         1000 |           9354 |          7506 |         2084 |
> |         1500 |           8397 |          6944 |         2075 |
> |         2000 |           7574 |          6402 |         2062 |
> +--------------+----------------+---------------+--------------+
> 
> Theoretical values are computed according to the following formula:
> size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),

Thanks for more testings and the statistics.

I had a feeling that this formula may or may not be accurate, but that's
less of an issue here.

> where size is in bytes, time is in seconds, and wps is number of
> writes per second (I measured approximately 3000000 on my system).
> 
> Theoretical values and values obtained with page-sampling are
> approximately close (<=25%). Dirty-bitmap values are much lower,
> likely because the majority of writes cause page faults. Even though
> dirty-bitmap logic is closer to what is happening during live
> migration, I still favor page sampling because the latter doesn't
> impact the performance of VM too much.

Do you really use page samplings in production?  I don't remember I
mentioned it anywhere before, but it will provide very wrong number when
the memory updates has a locality, afaik.  For example, when 4G VM only has
1G actively updated, the result can be 25% of reality iiuc, seeing that the
rest 3G didn't even change.  It works only well with very distributed
memory updates.

> 
> Whether calc-time < 1sec is meaningful or not depends on the size
> of memory region with active writes.
> 1. If we have big VM and writes are evenly spread over the whole
>    address space, then almost all writes will go into unique pages.
>    In this case number of dirty pages will grow approximately
>    linearly with time for small calc-time values.
> 2. But if memory region with active writes is small enough, then many
>    writes will go to the same page, and the number of dirty pages
>    will grow sublinearly even for small calc-time values. Note that
>    the second scenario can happen even VM RAM is big. For example,
>    imagine 128GiB VM with in-memory database that is used for reading.
>    Although VM size is big, the memory region with active writes is
>    just the application stack.

No issue here to support small calc-time.  I think as long as it'll be
worthwhile in any use case I'd be fine with it (rather than working for all
use cases).  Not a super high bar to maintain the change.

I copied Yong too, he just volunteered to look after the dirtyrate stuff.

Thanks,

-- 
Peter Xu


