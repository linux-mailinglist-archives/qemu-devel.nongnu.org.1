Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94462756CD6
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:10:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTaU-0005g5-42; Mon, 17 Jul 2023 15:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qLTaT-0005fx-2v
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qLTaR-0004WL-70
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689620925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RqeEEjBbk+Wkc94b7VsoBTyFmt5TZQWWHAX1wnWW/w=;
 b=TMI69h+m1TtZ0Iv45sn1AE73N13xb5tAxVG5LjCwz+0MUqXxTDgbCLUHM4+TMLTw4IhDZv
 QCKvgDbIRzG2L93QD/eZPBrtThm5Jr0BC5JLBnaWEzC2iy++2okDLhDlurAC7WvSQtq+XI
 ViO0Hkumey9F/YjLqIeisodavbKAZJM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-SvuQl_vUMVqgvNjJcrcEqQ-1; Mon, 17 Jul 2023 15:08:41 -0400
X-MC-Unique: SvuQl_vUMVqgvNjJcrcEqQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-79466ad7738so70072241.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689620921; x=1690225721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RqeEEjBbk+Wkc94b7VsoBTyFmt5TZQWWHAX1wnWW/w=;
 b=Nf7IKIVMf04yqaFIP+8f2dS8cmOfdHliGVV17Ew5R4fIhQZWOl200wUyFTyWmoweSg
 uqB9H9LHR9zcD3twExOAK61h4GhRv++Kv2g7O5b84g+kgp5HkTrpQgmvnQdh/7ETGIYa
 uV2IiRtCYTk6oa3nnHIxN3AM4klYF4Qu1/yQ1BYqRKKJE2mRQHiM4odYB6SOtaN8XRMB
 qk18Nxv0jpbiVVNZSHg5vulAG5q5etwFlrN9b4OuGxOKx6738UL6iaMu74WvnDqHDP+0
 MHQzj5FWGGvJmDYWMYwOszUVkNEdIe1LQLmB4+SKsGAjb93tuQFupKlHVwaX7NRhNTYS
 X+SQ==
X-Gm-Message-State: ABy/qLaUf6EEg8dvSfEvlO+38qxswoo2paxBUn86MQA+C9GRG8E6S1m5
 M8VEkgGQWywIowlJrhl489b7ma4y6xffir1n+Z+HEl+Qxf4mPtecZl2zmH1i0B8TP84aLDyd0xG
 X99gQ8YOxaQsxS4o=
X-Received: by 2002:a05:6102:e8e:b0:440:b96f:d146 with SMTP id
 l14-20020a0561020e8e00b00440b96fd146mr1844696vst.3.1689620921159; 
 Mon, 17 Jul 2023 12:08:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8be19loqMnyoiI2EfefJpYbHKVgZkGHZoV8Q1hqsD+1GhjN72zE7MkH/HMJOP25Hau+CLjg==
X-Received: by 2002:a05:6102:e8e:b0:440:b96f:d146 with SMTP id
 l14-20020a0561020e8e00b00440b96fd146mr1844685vst.3.1689620920777; 
 Mon, 17 Jul 2023 12:08:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c3-20020a0cf2c3000000b00635ef3a34ebsm122953qvm.48.2023.07.17.12.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 12:08:40 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:08:37 -0400
From: Peter Xu <peterx@redhat.com>
To: gudkov.andrei@huawei.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH] migration/calc-dirty-rate: millisecond precision period
Message-ID: <ZLWRtU3sXDreCFxO@x1n>
References: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
 <ZKcUv1Ge/RVBHJKT@x1n>
 <ZK1NOmUVc/eUivhV@DESKTOP-0LHM7NF.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZK1NOmUVc/eUivhV@DESKTOP-0LHM7NF.china.huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 11, 2023 at 03:38:18PM +0300, gudkov.andrei@huawei.com wrote:
> On Thu, Jul 06, 2023 at 03:23:43PM -0400, Peter Xu wrote:
> > On Thu, Jun 29, 2023 at 11:59:03AM +0300, Andrei Gudkov wrote:
> > > Introduces alternative argument calc-time-ms, which is the
> > > the same as calc-time but accepts millisecond value.
> > > Millisecond precision allows to make predictions whether
> > > migration will succeed or not. To do this, calculate dirty
> > > rate with calc-time-ms set to max allowed downtime, convert
> > > measured rate into volume of dirtied memory, and divide by
> > > network throughput. If the value is lower than max allowed
> > > downtime, then migration will converge.
> > > 
> > > Measurement results for single thread randomly writing to
> > > a 24GiB region:
> > > +--------------+--------------------+
> > > | calc-time-ms | dirty-rate (MiB/s) |
> > > +--------------+--------------------+
> > > |          100 |               1880 |
> > > |          200 |               1340 |
> > > |          300 |               1120 |
> > > |          400 |               1030 |
> > > |          500 |                868 |
> > > |          750 |                720 |
> > > |         1000 |                636 |
> > > |         1500 |                498 |
> > > |         2000 |                423 |
> > > +--------------+--------------------+
> > 
> > Do you mean the dirty workload is constant?  Why it differs so much with
> > different calc-time-ms?
> 
> Workload is as constant as it could be. But the naming is misleading.
> What is named "dirty-rate" in fact is not "rate" at all.
> calc-dirty-rate measures number of *uniquely* dirtied pages, i.e. each
> page can contribute to the counter only once during measurement period.
> That's why the values are decreasing. Consider also ad infinitum argument:
> since VM has fixed number of pages and each page can be dirtied only once,
> dirty-rate=number-of-dirtied-pages/calc-time -> 0 as calc-time -> inf.
> It would make more sense to report number as "dirty-volume" --
> without dividing it by calc-time.
> 
> Note that number of *uniquely* dirtied pages in given amount of time is
> exactly what we need for doing migration-related predictions. There is
> no error here.

Is calc-time-ms the duration of the measurement?

Taking the 1st line as example, 1880MB/s * 0.1s = 188MB.
For the 2nd line, 1340MB/s * 0.2s = 268MB.
Even for the longest duration of 2s, that's 846MB in total.

The range is 24GB.  In this case, most of the pages should only be written
once even if random for all these test durations, right?

> 
> > 
> > I also doubt usefulness on huge vms the ms accuracy won't matter much
> > because enable/disable dirty logging overhead can already be ms level for
> > those.
> > 
> The goal is to measure volume of dirtied memory corresponding to desired
> downtime, which is typically order of 100-300ms. I think that error of
> +/-10ms won't make any big difference. Maybe I should've called this 
> "millisecond granularity" and not "millisecond precision".
> 
> > > 
> > > Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> > > ---
> > >  qapi/migration.json   | 15 ++++++--
> > >  migration/dirtyrate.h | 12 ++++---
> > >  migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
> > >  3 files changed, 68 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 5bb5ab82a0..dd1afe1982 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -1778,7 +1778,12 @@
> > >  #
> > >  # @start-time: start time in units of second for calculation
> > >  #
> > > -# @calc-time: time in units of second for sample dirty pages
> > > +# @calc-time: time period for which dirty page rate was measured
> > > +#     (rounded down to seconds).
> > > +#
> > > +# @calc-time-ms: actual time period for which dirty page rate was
> > > +#     measured (in milliseconds).  Value may be larger than requested
> > > +#     time period due to measurement overhead.
> > >  #
> > >  # @sample-pages: page count per GB for sample dirty pages the default
> > >  #     value is 512 (since 6.1)
> > > @@ -1796,6 +1801,7 @@
> > >             'status': 'DirtyRateStatus',
> > >             'start-time': 'int64',
> > >             'calc-time': 'int64',
> > > +           'calc-time-ms': 'int64',
> > >             'sample-pages': 'uint64',
> > >             'mode': 'DirtyRateMeasureMode',
> > >             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> > > @@ -1807,6 +1813,10 @@
> > >  #
> > >  # @calc-time: time in units of second for sample dirty pages
> > >  #
> > > +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> > > +#    two arguments are mutually exclusive.  Exactly one of them must
> > > +#    be specified. (Since 8.1)
> > > +#
> > >  # @sample-pages: page count per GB for sample dirty pages the default
> > >  #     value is 512 (since 6.1)
> > >  #
> > > @@ -1821,7 +1831,8 @@
> > >  #                                                 'sample-pages': 512} }
> > >  # <- { "return": {} }
> > >  ##
> > > -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> > > +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> > > +                                         '*calc-time-ms': 'int64',
> > >                                           '*sample-pages': 'int',
> > >                                           '*mode': 'DirtyRateMeasureMode'} }
> > >  
> > > diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> > > index 594a5c0bb6..869c060941 100644
> > > --- a/migration/dirtyrate.h
> > > +++ b/migration/dirtyrate.h
> > > @@ -31,10 +31,12 @@
> > >  #define MIN_RAMBLOCK_SIZE                         128
> > >  
> > >  /*
> > > - * Take 1s as minimum time for calculation duration
> > > + * Allowed range for dirty page rate calculation (in milliseconds).
> > > + * Lower limit relates to the smallest realistic downtime it
> > > + * makes sense to impose on migration.
> > >   */
> > > -#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
> > > -#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
> > > +#define MIN_CALC_TIME_MS                          50
> > > +#define MAX_CALC_TIME_MS                       60000
> > >  
> > >  /*
> > >   * Take 1/16 pages in 1G as the maxmum sample page count
> > > @@ -44,7 +46,7 @@
> > >  
> > >  struct DirtyRateConfig {
> > >      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> > > -    int64_t sample_period_seconds; /* time duration between two sampling */
> > > +    int64_t calc_time_ms; /* desired calculation time (in milliseconds) */
> > >      DirtyRateMeasureMode mode; /* mode of dirtyrate measurement */
> > >  };
> > >  
> > > @@ -73,7 +75,7 @@ typedef struct SampleVMStat {
> > >  struct DirtyRateStat {
> > >      int64_t dirty_rate; /* dirty rate in MB/s */
> > >      int64_t start_time; /* calculation start time in units of second */
> > > -    int64_t calc_time; /* time duration of two sampling in units of second */
> > > +    int64_t calc_time_ms; /* actual calculation time (in milliseconds) */
> > >      uint64_t sample_pages; /* sample pages per GB */
> > >      union {
> > >          SampleVMStat page_sampling;
> > > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > > index 84f1b0fb20..90fb336329 100644
> > > --- a/migration/dirtyrate.c
> > > +++ b/migration/dirtyrate.c
> > > @@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_t initial_time)
> > >          msec = current_time - initial_time;
> > >      } else {
> > >          g_usleep((msec + initial_time - current_time) * 1000);
> > > +        /* g_usleep may overshoot */
> > > +        msec = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - initial_time;
> > 
> > This removes the g_usleep(), is it intended?  I thought it was the code to
> > do the delay.  What is the solution to g_usleep() then?
> > 
> It is still there -- just above the comment. What I added is
> qemu_clock_get_ms() call after the g_usleep. It sets msec variable
> to the true amount of time elapsed between measurements. Previously
> I detected that actually slept time may be slightly longer than
> requested value.

Ouch.. please ignore that.  I don't know how did I read that.

The impl is pretty much straightforward and fine by me, I just want to make
sure I still understand those numbers you provided in the commit message,
and making sure measuring in small duration can at least make sense in
majority cases.

Thanks,

-- 
Peter Xu


