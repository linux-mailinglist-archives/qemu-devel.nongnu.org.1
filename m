Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE177709B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 08:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTzMw-0007hd-Td; Thu, 10 Aug 2023 02:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qTzMt-0007hU-SM
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:41:59 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qTzMp-0007b5-Uf
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:41:59 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a3efebcc24so457269b6e.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691649594; x=1692254394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95mg+vDcOyoYLIrn5/y3Gj6RuB8iCK3XtKpsXrNO5ac=;
 b=rxYnTxjaXSiYAARLRPn0KtZXSnExYQgIK2Zj23dXKVA58AOp5lqjoy2+5rugiSTktk
 XW/tFywGRN4MqKAiDEKQBRWgGygXgTjxSflGLcw5GhYMKTVVqEtH8P9jQzA8MOsbh7wg
 MpTeFQ3t9odd9ycqqOcFR5MlDAWDcsHf5oMq4x6r7XQlyckVb3vgXZwZsttbaSuOXIDP
 cULHPUZoftNiozESI1OOqLtilbhU8J3TEo4LXEOU2gQuxnRkg4Pc/8rITjpBsHDANGsm
 /h049U3Nw3NinvwqfY+l3h8S+igLyfRF/q1E9+vzcrushSIEON85+mYRuGP7sJMW1mUt
 OixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691649594; x=1692254394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95mg+vDcOyoYLIrn5/y3Gj6RuB8iCK3XtKpsXrNO5ac=;
 b=bOPa+j7IGLY86/EC8kKm4GOhXZvVC1WD9XSAzXwEutScvI3NqnI5vy35lyAJTyqsMN
 GEebq+GZFbaVbWSVBiIG9X+hfTgpaP1QMR/3rNBFCzsD3zl+cOo8B30e7aNCqEMrwWaz
 BrPRHQVaaPByrqvUu8z2lXYzvAV+ARlZPJQiNaqtNbZcQstFjbD+h1EQ2mVOV4mqDLF2
 nSnJRyfaanTM23S1nuoz12oBDzodfN5HyMVpLxDkFDRAzrn29YNG9eKrpnonmkoB6WQk
 z+YuSRJdjK7/HjSQ8AVGcEiBhsR3VL526fgK2PIwRkf4MN4bnnmUz+S/LNiHNlYbMgyk
 ASow==
X-Gm-Message-State: AOJu0YyymgchcXOpq72p4kO2N3lFijRb2k8EZEsvli87/WQJRca1fxKu
 XuTcbxrUB8l+vGMfmAUBW0Tj/zbpPLt1BkX5Z0UTHQ==
X-Google-Smtp-Source: AGHT+IHersPRfFRJDbTVD4t5vz+6QdhyCyzPRvAaU3yCAr4uvodZamgmBDOV2qadngoUGiCY18NXaGx3mWuRgsnUXrA=
X-Received: by 2002:a54:4e94:0:b0:3a7:8e05:1699 with SMTP id
 c20-20020a544e94000000b003a78e051699mr1566909oiy.37.1691649593939; Wed, 09
 Aug 2023 23:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 <CAK9dgmbnBL2sSoUm0cgdySsA0PqAJc0yR1750-yp1eVssQ-UMw@mail.gmail.com>
 <ZNOqnLFaD/At4poY@DESKTOP-0LHM7NF.china.huawei.com>
In-Reply-To: <ZNOqnLFaD/At4poY@DESKTOP-0LHM7NF.china.huawei.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 10 Aug 2023 14:39:37 +0800
Message-ID: <CAK9dgmY6WKr67UM1gNaMKey+cMC-pG=PTafBerDuoMqWqbyBkA@mail.gmail.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
To: gudkov.andrei@huawei.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
Content-Type: multipart/alternative; boundary="00000000000021aff806028bdd82"
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000021aff806028bdd82
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 11:03=E2=80=AFPM <gudkov.andrei@huawei.com> wrote:

> On Sun, Aug 06, 2023 at 02:16:34PM +0800, Yong Huang wrote:
> > On Fri, Aug 4, 2023 at 11:03=E2=80=AFPM Andrei Gudkov <gudkov.andrei@hu=
awei.com>
> > wrote:
> >
> > > Introduces alternative argument calc-time-ms, which is the
> > > the same as calc-time but accepts millisecond value.
> > > Millisecond granularity allows to make predictions whether
> > > migration will succeed or not. To do this, calculate dirty
> > > rate with calc-time-ms set to max allowed downtime, convert
> > > measured rate into volume of dirtied memory, and divide by
> > > network throughput. If the value is lower than max allowed
> > >
> > Not for the patch, I'm just curious about how the predication
> > decides the network throughput, I mean QEMU predicts
> > if migration will converge based on how fast it sends the data,
> > not the actual bandwidth of the interface, which one the
> > prediction uses?
> >
> Currently I use network nominal bandwidth, e.g. 1gbps. It would
> be nice, of course, to use measured throughput since it can take
> into account network headers overhead (as Wang Lei previously
> mentioned), compression, etc., but it looks too complicated to
> implement outside of migration process.
>
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
> > >  migration/dirtyrate.c | 81 +++++++++++++++++++++++++----------------=
--
> > >  3 files changed, 67 insertions(+), 40 deletions(-)
> > >
> > > [...]
> >
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
> > >
> > Does there need an extra comment to emphasize that calc-time shows
> > zero if the calc-time-ms is lower than 1000?
> >
> > > +#
> > > +# @calc-time-ms: actual time period for which dirty page rate was
> > > +#     measured (in milliseconds).  Value may be larger than requeste=
d
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
> > >  #     dirty during @calc-time period, further writes to this page wi=
ll
> > >  #     not increase dirty page rate anymore.
> > >  #
> > > +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> > > +#    two arguments are mutually exclusive.  Exactly one of them must
> > > +#    be specified. (Since 8.1)
> > > +#
> > >  # @sample-pages: number of sampled pages per each GiB of guest memor=
y.
> > >  #     Default value is 512.  For 4KiB guest pages this corresponds t=
o
> > >  #     sampling ratio of 0.2%.  This argument is used only in page
> > > @@ -1925,7 +1934,8 @@
> > >  #                                                 'sample-pages':
> 512} }
> > >  # <- { "return": {} }
> > >  ##
> > > -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> > > +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> > > +                                         '*calc-time-ms': 'int64',
> > >                                           '*sample-pages': 'int',
> > >                                           '*mode':
> 'DirtyRateMeasureMode'}
> > > }
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
> > > -    int64_t sample_period_seconds; /* time duration between two
> sampling
> > > */
> > > +    int64_t calc_time_ms; /* desired calculation time (in
> milliseconds) */
> > >      DirtyRateMeasureMode mode; /* mode of dirtyrate measurement */
> > >  };
> > >
> > > @@ -73,7 +75,7 @@ typedef struct SampleVMStat {
> > >  struct DirtyRateStat {
> > >      int64_t dirty_rate; /* dirty rate in MB/s */
> > >      int64_t start_time; /* calculation start time in units of second
> */
> > > -    int64_t calc_time; /* time duration of two sampling in units of
> > > second */
> > > +    int64_t calc_time_ms; /* actual calculation time (in
> milliseconds) */
> > >      uint64_t sample_pages; /* sample pages per GB */
> > >      union {
> > >          SampleVMStat page_sampling;
> >
> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > > index 84f1b0fb20..90fb336329 100644
> > > --- a/migration/dirtyrate.c
> > > +++ b/migration/dirtyrate.c
> > > @@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_=
t
> > > initial_time)
> > >          msec =3D current_time - initial_time;
> > >      } else {
> > >          g_usleep((msec + initial_time - current_time) * 1000);
> > > +        /* g_usleep may overshoot */
> > > +        msec =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - initial_ti=
me;
> > >
> > The optimization could be a standalone commit along with the content
> > below(see the following comment)?
> >
> OK, I will move it into separate commit.
>
> > >      }
> > >
> > >      return msec;
> > > @@ -77,9 +79,12 @@ static int64_t
> do_calculate_dirtyrate(DirtyPageRecord
> > > dirty_pages,
> > >  {
> > >      uint64_t increased_dirty_pages =3D
> > >          dirty_pages.end_pages - dirty_pages.start_pages;
> > > -    uint64_t memory_size_MiB =3D
> > > qemu_target_pages_to_MiB(increased_dirty_pages);
> > > -
> > > -    return memory_size_MiB * 1000 / calc_time_ms;
> > > +    /*
> > > +     * multiply by 1000ms/s _before_ converting down to megabytes
> > > +     * to avoid losing precision
> > > +     */
> > > +    return qemu_target_pages_to_MiB(increased_dirty_pages * 1000) /
> > > +        calc_time_ms;
> > >
> > Code optimization, could be in a standalone commit.
> >
> OK, but note that it is an important optimization. Imagine that
> calc_time_ms=3D100 and increased_dirty_pages=3D1000. If we compute withou=
t
> this optimization, we will get only 1000/(2^8)*1000/100=3D30. With
> optmization: 1000*1000/(2^8)/100=3D39.
>
> Good work, and thanks for this patch. :)


> > >  }
> > >
> > >  void global_dirty_log_change(unsigned int flag, bool start)
> > > @@ -183,10 +188,9 @@ retry:
> > >      return duration;
> > >  }
> > >
> > > -static bool is_sample_period_valid(int64_t sec)
> > > +static bool is_calc_time_valid(int64_t msec)
> > >  {
> > > -    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
> > > -        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
> > > +    if ((msec < MIN_CALC_TIME_MS) || (msec > MAX_CALC_TIME_MS)) {
> > >          return false;
> > >      }
> > >
> > > @@ -219,7 +223,8 @@ static struct DirtyRateInfo
> > > *query_dirty_rate_info(void)
> > >
> > >      info->status =3D CalculatingState;
> > >      info->start_time =3D DirtyStat.start_time;
> > > -    info->calc_time =3D DirtyStat.calc_time;
> > > +    info->calc_time_ms =3D DirtyStat.calc_time_ms;
> > > +    info->calc_time =3D DirtyStat.calc_time_ms / 1000;
> > >      info->sample_pages =3D DirtyStat.sample_pages;
> > >      info->mode =3D dirtyrate_mode;
> > >
> > > @@ -258,7 +263,7 @@ static void init_dirtyrate_stat(int64_t start_tim=
e,
> > >  {
> > >      DirtyStat.dirty_rate =3D -1;
> > >      DirtyStat.start_time =3D start_time;
> > > -    DirtyStat.calc_time =3D config.sample_period_seconds;
> > > +    DirtyStat.calc_time_ms =3D config.calc_time_ms;
> > >      DirtyStat.sample_pages =3D config.sample_pages_per_gigabytes;
> > >
> > >      switch (config.mode) {
> > > @@ -568,7 +573,6 @@ static inline void
> dirtyrate_manual_reset_protect(void)
> > >
> > >  static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig
> > > config)
> > >  {
> > > -    int64_t msec =3D 0;
> > >      int64_t start_time;
> > >      DirtyPageRecord dirty_pages;
> > >
> > > @@ -596,9 +600,7 @@ static void calculate_dirtyrate_dirty_bitmap(stru=
ct
> > > DirtyRateConfig config)
> > >      start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > >      DirtyStat.start_time =3D start_time / 1000;
> > >
> > > -    msec =3D config.sample_period_seconds * 1000;
> > > -    msec =3D dirty_stat_wait(msec, start_time);
> > > -    DirtyStat.calc_time =3D msec / 1000;
> > > +    DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_ms,
> > > start_time);
> > >
> > >      /*
> > >       * do two things.
> > > @@ -609,12 +611,12 @@ static void
> calculate_dirtyrate_dirty_bitmap(struct
> > > DirtyRateConfig config)
> > >
> > >      record_dirtypages_bitmap(&dirty_pages, false);
> > >
> > > -    DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages, mse=
c);
> > > +    DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages,
> > > +
> DirtyStat.calc_time_ms);
> > >  }
> > >
> > >  static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig
> config)
> > >  {
> > > -    int64_t duration;
> > >      uint64_t dirtyrate =3D 0;
> > >      uint64_t dirtyrate_sum =3D 0;
> > >      int i =3D 0;
> > > @@ -625,12 +627,10 @@ static void calculate_dirtyrate_dirty_ring(stru=
ct
> > > DirtyRateConfig config)
> > >      DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) =
/
> 1000;
> > >
> > >      /* calculate vcpu dirtyrate */
> > > -    duration =3D vcpu_calculate_dirtyrate(config.sample_period_secon=
ds *
> > > 1000,
> > > -                                        &DirtyStat.dirty_ring,
> > > -                                        GLOBAL_DIRTY_DIRTY_RATE,
> > > -                                        true);
> > > -
> > > -    DirtyStat.calc_time =3D duration / 1000;
> > > +    DirtyStat.calc_time_ms =3D
> vcpu_calculate_dirtyrate(config.calc_time_ms,
> > > +
> > > &DirtyStat.dirty_ring,
> > > +
> > > GLOBAL_DIRTY_DIRTY_RATE,
> > > +                                                      true);
> > >
> > >      /* calculate vm dirtyrate */
> > >      for (i =3D 0; i < DirtyStat.dirty_ring.nvcpu; i++) {
> > > @@ -646,7 +646,6 @@ static void calculate_dirtyrate_sample_vm(struct
> > > DirtyRateConfig config)
> > >  {
> > >      struct RamblockDirtyInfo *block_dinfo =3D NULL;
> > >      int block_count =3D 0;
> > > -    int64_t msec =3D 0;
> > >      int64_t initial_time;
> > >
> > >      rcu_read_lock();
> > > @@ -656,17 +655,16 @@ static void calculate_dirtyrate_sample_vm(struc=
t
> > > DirtyRateConfig config)
> > >      }
> > >      rcu_read_unlock();
> > >
> > > -    msec =3D config.sample_period_seconds * 1000;
> > > -    msec =3D dirty_stat_wait(msec, initial_time);
> > > +    DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_ms,
> > > +                                             initial_time);
> > >      DirtyStat.start_time =3D initial_time / 1000;
> > > -    DirtyStat.calc_time =3D msec / 1000;
> > >
> > >      rcu_read_lock();
> > >      if (!compare_page_hash_info(block_dinfo, block_count)) {
> > >          goto out;
> > >      }
> > >
> > > -    update_dirtyrate(msec);
> > > +    update_dirtyrate(DirtyStat.calc_time_ms);
> > >
> > >  out:
> > >      rcu_read_unlock();
> > > @@ -711,7 +709,10 @@ void *get_dirtyrate_thread(void *arg)
> > >      return NULL;
> > >  }
> > >
> > > -void qmp_calc_dirty_rate(int64_t calc_time,
> > > +void qmp_calc_dirty_rate(bool has_calc_time,
> > > +                         int64_t calc_time,
> > > +                         bool has_calc_time_ms,
> > > +                         int64_t calc_time_ms,
> > >                           bool has_sample_pages,
> > >                           int64_t sample_pages,
> > >                           bool has_mode,
> > > @@ -731,10 +732,21 @@ void qmp_calc_dirty_rate(int64_t calc_time,
> > >          return;
> > >      }
> > >
> > > -    if (!is_sample_period_valid(calc_time)) {
> > > -        error_setg(errp, "calc-time is out of range[%d, %d].",
> > > -                         MIN_FETCH_DIRTYRATE_TIME_SEC,
> > > -                         MAX_FETCH_DIRTYRATE_TIME_SEC);
> > > +    if ((int)has_calc_time + (int)has_calc_time_ms !=3D 1) {
> > > +        error_setg(errp, "Exactly one of calc-time and calc-time-ms
> must"
> > > +                         " be specified");
> > > +        return;
> > > +    }
> > > +    if (has_calc_time) {
> > > +        /*
> > > +         * The worst thing that can happen due to overflow is that
> > > +         * invalid value will become valid.
> > > +         */
> > > +        calc_time_ms =3D calc_time * 1000;
> > > +    }
> > > +    if (!is_calc_time_valid(calc_time_ms)) {
> > > +        error_setg(errp, "Calculation time is out of range[%dms,
> %dms].",
> > > +                         MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);
> > >          return;
> > >      }
> > >
> > > @@ -781,7 +793,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
> > >          return;
> > >      }
> > >
> > > -    config.sample_period_seconds =3D calc_time;
> > > +    config.calc_time_ms =3D calc_time_ms;
> > >      config.sample_pages_per_gigabytes =3D sample_pages;
> > >      config.mode =3D mode;
> > >
> > > @@ -867,8 +879,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDi=
ct
> > > *qdict)
> > >          mode =3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING;
> > >      }
> > >
> > > -    qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, true,
> > > -                        mode, &err);
> > > +    qmp_calc_dirty_rate(true, sec, /* calc_time */
> > > +                        false, 0, /* calc_time_ms */
> > > +                        has_sample_pages, sample_pages,
> > > +                        true, mode,
> > > +                        &err);
> > >      if (err) {
> > >          hmp_handle_error(mon, err);
> > >          return;
> > > --
> > > 2.30.2
> > >
> > > The patch set works for me, and I'm inclined to split it into two
> commits
> > as I point out above.
> >
> > Thanks
> >
> > Yong
> >
> > --
> > Best regards
>


--=20
Best regards

--00000000000021aff806028bdd82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 9, 202=
3 at 11:03=E2=80=AFPM &lt;<a href=3D"mailto:gudkov.andrei@huawei.com">gudko=
v.andrei@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Sun, Aug 06=
, 2023 at 02:16:34PM +0800, Yong Huang wrote:<br>
&gt; On Fri, Aug 4, 2023 at 11:03=E2=80=AFPM Andrei Gudkov &lt;<a href=3D"m=
ailto:gudkov.andrei@huawei.com" target=3D"_blank">gudkov.andrei@huawei.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Introduces alternative argument calc-time-ms, which is the<br>
&gt; &gt; the same as calc-time but accepts millisecond value.<br>
&gt; &gt; Millisecond granularity allows to make predictions whether<br>
&gt; &gt; migration will succeed or not. To do this, calculate dirty<br>
&gt; &gt; rate with calc-time-ms set to max allowed downtime, convert<br>
&gt; &gt; measured rate into volume of dirtied memory, and divide by<br>
&gt; &gt; network throughput. If the value is lower than max allowed<br>
&gt; &gt;<br>
&gt; Not for the patch, I&#39;m just curious about how the predication<br>
&gt; decides the network throughput, I mean QEMU predicts<br>
&gt; if migration will converge based on how fast it sends the data,<br>
&gt; not the actual bandwidth of the interface, which one the<br>
&gt; prediction uses?<br>
&gt; <br>
Currently I use network nominal bandwidth, e.g. 1gbps. It would<br>
be nice, of course, to use measured throughput since it can take<br>
into account network headers overhead (as Wang Lei previously<br>
mentioned), compression, etc., but it looks too complicated to<br>
implement outside of migration process.<br>
<br>
&gt; &gt; downtime, then migration will converge.<br>
&gt; &gt;<br>
&gt; &gt; Measurement results for single thread randomly writing to<br>
&gt; &gt; a 1/4/24GiB memory region:<br>
&gt; &gt;<br>
&gt; &gt; +--------------+-----------------------------------------------+<=
br>
&gt; &gt; | calc-time-ms |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dirty rate MiB/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------------=
--+---------------+--------------+<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | theoretical=
=C2=A0 =C2=A0 | page-sampling | dirty-bitmap |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (at 3M wr/sec=
) |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7100 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A03192 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04606 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4660 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02655 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A03305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3280 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02371 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02534 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2525 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02154 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2044 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01871 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A01365 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1341 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01358 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1052 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01025 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0678 |=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 684 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 512 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0507 |=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 513 |<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 10232 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8880 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A04070 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A08954 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8049 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A03195 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07889 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7193 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02881 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6530 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02700 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A06245 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5772 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02312 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04829 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4586 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02465 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A03865 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3780 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02178 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02694 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2633 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02004 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2031 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01789 |<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 11495 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8640 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A05597 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 11226 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8616 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A03527 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 10965 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8386 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02355 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 10713 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8370 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02179 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 10469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8196 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02098 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A09890 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7885 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02556 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A09354 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7506 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02084 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A08397 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6944 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02075 |<br>
&gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A07574 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6402 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02062 |<br>
&gt; &gt; +--------------+----------------+---------------+--------------+<=
br>
&gt; &gt;<br>
&gt; &gt; Theoretical values are computed according to the following formul=
a:<br>
&gt; &gt; size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),<br>
&gt; &gt; where size is in bytes, time is in seconds, and wps is number of<=
br>
&gt; &gt; writes per second.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@=
huawei.com" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0| 14 ++++++--<br>
&gt; &gt;=C2=A0 migration/dirtyrate.h | 12 ++++---<br>
&gt; &gt;=C2=A0 migration/dirtyrate.c | 81 +++++++++++++++++++++++++-------=
-----------<br>
&gt; &gt;=C2=A0 3 files changed, 67 insertions(+), 40 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; [...]<br>
&gt; <br>
&gt; &gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; &gt; index 8843e74b59..82493d6a57 100644<br>
&gt; &gt; --- a/qapi/migration.json<br>
&gt; &gt; +++ b/qapi/migration.json<br>
&gt; &gt; @@ -1849,7 +1849,11 @@<br>
&gt; &gt;=C2=A0 # @start-time: start time in units of second for calculatio=
n<br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt;=C2=A0 # @calc-time: time period for which dirty page rate was mea=
sured<br>
&gt; &gt; -#=C2=A0 =C2=A0 =C2=A0(in seconds)<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0(rounded down to seconds).<br>
&gt; &gt;<br>
&gt; Does there need an extra comment to emphasize that calc-time shows<br>
&gt; zero if the calc-time-ms is lower than 1000?<br>
&gt; <br>
&gt; &gt; +#<br>
&gt; &gt; +# @calc-time-ms: actual time period for which dirty page rate wa=
s<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0measured (in milliseconds).=C2=A0 Value may=
 be larger than requested<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0time period due to measurement overhead.<br=
>
&gt; &gt;=C2=A0 #<br>
&gt; &gt;=C2=A0 # @sample-pages: number of sampled pages per GiB of guest m=
emory.<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Valid only in page-sampling mode (Sinc=
e 6.1)<br>
&gt; &gt; @@ -1866,6 +1870,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;status&#39;: =
&#39;DirtyRateStatus&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;start-time&#3=
9;: &#39;int64&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time&#39=
;: &#39;int64&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time-ms&#39;:=
 &#39;int64&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&=
#39;: &#39;uint64&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mode&#39;: &#=
39;DirtyRateMeasureMode&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*vcpu-dirty-r=
ate&#39;: [ &#39;DirtyRateVcpu&#39; ] } }<br>
&gt; &gt; @@ -1908,6 +1913,10 @@<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0dirty during @calc-time period, furthe=
r writes to this page will<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0not increase dirty page rate anymore.<=
br>
&gt; &gt;=C2=A0 #<br>
&gt; &gt; +# @calc-time-ms: the same as @calc-time but in milliseconds.=C2=
=A0 These<br>
&gt; &gt; +#=C2=A0 =C2=A0 two arguments are mutually exclusive.=C2=A0 Exact=
ly one of them must<br>
&gt; &gt; +#=C2=A0 =C2=A0 be specified. (Since 8.1)<br>
&gt; &gt; +#<br>
&gt; &gt;=C2=A0 # @sample-pages: number of sampled pages per each GiB of gu=
est memory.<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Default value is 512.=C2=A0 For 4KiB g=
uest pages this corresponds to<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0sampling ratio of 0.2%.=C2=A0 This arg=
ument is used only in page<br>
&gt; &gt; @@ -1925,7 +1934,8 @@<br>
&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;: 512} }=
<br>
&gt; &gt;=C2=A0 # &lt;- { &quot;return&quot;: {} }<br>
&gt; &gt;=C2=A0 ##<br>
&gt; &gt; -{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: =
{&#39;calc-time&#39;: &#39;int64&#39;,<br>
&gt; &gt; +{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: =
{&#39;*calc-time&#39;: &#39;int64&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;*calc-time-ms&#39;: &#39;int64&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;*sample-pages&#39;: &#39;int&#39;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;*mode&#39;: &#39;DirtyRateMeasureMode&#39;}<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h<br>
&gt; &gt; index 594a5c0bb6..869c060941 100644<br>
&gt; &gt; --- a/migration/dirtyrate.h<br>
&gt; &gt; +++ b/migration/dirtyrate.h<br>
&gt; &gt; @@ -31,10 +31,12 @@<br>
&gt; &gt;=C2=A0 #define MIN_RAMBLOCK_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0128<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 /*<br>
&gt; &gt; - * Take 1s as minimum time for calculation duration<br>
&gt; &gt; + * Allowed range for dirty page rate calculation (in millisecond=
s).<br>
&gt; &gt; + * Lower limit relates to the smallest realistic downtime it<br>
&gt; &gt; + * makes sense to impose on migration.<br>
&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt; -#define MIN_FETCH_DIRTYRATE_TIME_SEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 1<br>
&gt; &gt; -#define MAX_FETCH_DIRTYRATE_TIME_SEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 60<br>
&gt; &gt; +#define MIN_CALC_TIME_MS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 50<br>
&gt; &gt; +#define MAX_CALC_TIME_MS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060000<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 /*<br>
&gt; &gt;=C2=A0 =C2=A0* Take 1/16 pages in 1G as the maxmum sample page cou=
nt<br>
&gt; &gt; @@ -44,7 +46,7 @@<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct DirtyRateConfig {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t sample_pages_per_gigabytes; /* sampl=
e pages per GB */<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t sample_period_seconds; /* time duration be=
tween two sampling<br>
&gt; &gt; */<br>
&gt; &gt; +=C2=A0 =C2=A0 int64_t calc_time_ms; /* desired calculation time =
(in milliseconds) */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyRateMeasureMode mode; /* mode of dirtyra=
te measurement */<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt; @@ -73,7 +75,7 @@ typedef struct SampleVMStat {<br>
&gt; &gt;=C2=A0 struct DirtyRateStat {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int64_t dirty_rate; /* dirty rate in MB/s */<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int64_t start_time; /* calculation start time=
 in units of second */<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t calc_time; /* time duration of two samplin=
g in units of<br>
&gt; &gt; second */<br>
&gt; &gt; +=C2=A0 =C2=A0 int64_t calc_time_ms; /* actual calculation time (=
in milliseconds) */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t sample_pages; /* sample pages per GB=
 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 union {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SampleVMStat page_sampling;<br>
&gt; <br>
&gt; diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
&gt; &gt; index 84f1b0fb20..90fb336329 100644<br>
&gt; &gt; --- a/migration/dirtyrate.c<br>
&gt; &gt; +++ b/migration/dirtyrate.c<br>
&gt; &gt; @@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, in=
t64_t<br>
&gt; &gt; initial_time)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msec =3D current_time - initial=
_time;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_usleep((msec + initial_time -=
 current_time) * 1000);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* g_usleep may overshoot */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 msec =3D qemu_clock_get_ms(QEMU_CLOC=
K_REALTIME) - initial_time;<br>
&gt; &gt;<br>
&gt; The optimization could be a standalone commit along with the content<b=
r>
&gt; below(see the following comment)?<br>
&gt; <br>
OK, I will move it into separate commit.<br>
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return msec;<br>
&gt; &gt; @@ -77,9 +79,12 @@ static int64_t do_calculate_dirtyrate(DirtyPag=
eRecord<br>
&gt; &gt; dirty_pages,<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t increased_dirty_pages =3D<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirty_pages.end_pages - dirty_p=
ages.start_pages;<br>
&gt; &gt; -=C2=A0 =C2=A0 uint64_t memory_size_MiB =3D<br>
&gt; &gt; qemu_target_pages_to_MiB(increased_dirty_pages);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 return memory_size_MiB * 1000 / calc_time_ms;<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* multiply by 1000ms/s _before_ converting d=
own to megabytes<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* to avoid losing precision<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 return qemu_target_pages_to_MiB(increased_dirty_pa=
ges * 1000) /<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_time_ms;<br>
&gt; &gt;<br>
&gt; Code optimization, could be in a standalone commit.<br>
&gt; <br>
OK, but note that it is an important optimization. Imagine that<br>
calc_time_ms=3D100 and increased_dirty_pages=3D1000. If we compute without<=
br>
this optimization, we will get only 1000/(2^8)*1000/100=3D30. With<br>
optmization: 1000*1000/(2^8)/100=3D39.<br>
<br></blockquote><div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">Good work, and thanks for this patch. :)=
</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-=
left-color:rgb(204,204,204);padding-left:1ex">
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 void global_dirty_log_change(unsigned int flag, bool start)=
<br>
&gt; &gt; @@ -183,10 +188,9 @@ retry:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return duration;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -static bool is_sample_period_valid(int64_t sec)<br>
&gt; &gt; +static bool is_calc_time_valid(int64_t msec)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 if (sec &lt; MIN_FETCH_DIRTYRATE_TIME_SEC ||<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sec &gt; MAX_FETCH_DIRTYRATE_TIME_SE=
C) {<br>
&gt; &gt; +=C2=A0 =C2=A0 if ((msec &lt; MIN_CALC_TIME_MS) || (msec &gt; MAX=
_CALC_TIME_MS)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -219,7 +223,8 @@ static struct DirtyRateInfo<br>
&gt; &gt; *query_dirty_rate_info(void)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;status =3D CalculatingState;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;start_time =3D DirtyStat.start_time;=
<br>
&gt; &gt; -=C2=A0 =C2=A0 info-&gt;calc_time =3D DirtyStat.calc_time;<br>
&gt; &gt; +=C2=A0 =C2=A0 info-&gt;calc_time_ms =3D DirtyStat.calc_time_ms;<=
br>
&gt; &gt; +=C2=A0 =C2=A0 info-&gt;calc_time =3D DirtyStat.calc_time_ms / 10=
00;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;sample_pages =3D DirtyStat.sample_pa=
ges;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;mode =3D dirtyrate_mode;<br>
&gt; &gt;<br>
&gt; &gt; @@ -258,7 +263,7 @@ static void init_dirtyrate_stat(int64_t start=
_time,<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.dirty_rate =3D -1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.start_time =3D start_time;<br>
&gt; &gt; -=C2=A0 =C2=A0 DirtyStat.calc_time =3D config.sample_period_secon=
ds;<br>
&gt; &gt; +=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D config.calc_time_ms;<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.sample_pages =3D config.sample_page=
s_per_gigabytes;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (config.mode) {<br>
&gt; &gt; @@ -568,7 +573,6 @@ static inline void dirtyrate_manual_reset_pro=
tect(void)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void calculate_dirtyrate_dirty_bitmap(struct DirtyRa=
teConfig<br>
&gt; &gt; config)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int64_t start_time;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyPageRecord dirty_pages;<br>
&gt; &gt;<br>
&gt; &gt; @@ -596,9 +600,7 @@ static void calculate_dirtyrate_dirty_bitmap(=
struct<br>
&gt; &gt; DirtyRateConfig config)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 start_time =3D qemu_clock_get_ms(QEMU_CLOCK_R=
EALTIME);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.start_time =3D start_time / 1000;<b=
r>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 msec =3D config.sample_period_seconds * 1000;<br>
&gt; &gt; -=C2=A0 =C2=A0 msec =3D dirty_stat_wait(msec, start_time);<br>
&gt; &gt; -=C2=A0 =C2=A0 DirtyStat.calc_time =3D msec / 1000;<br>
&gt; &gt; +=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D dirty_stat_wait(config.=
calc_time_ms,<br>
&gt; &gt; start_time);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* do two things.<br>
&gt; &gt; @@ -609,12 +611,12 @@ static void calculate_dirtyrate_dirty_bitma=
p(struct<br>
&gt; &gt; DirtyRateConfig config)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 record_dirtypages_bitmap(&amp;dirty_pages, fa=
lse);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 DirtyStat.dirty_rate =3D do_calculate_dirtyrate(di=
rty_pages, msec);<br>
&gt; &gt; +=C2=A0 =C2=A0 DirtyStat.dirty_rate =3D do_calculate_dirtyrate(di=
rty_pages,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DirtyStat.calc_time_ms);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void calculate_dirtyrate_dirty_ring(struct DirtyRate=
Config config)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t duration;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t dirtyrate =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint64_t dirtyrate_sum =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int i =3D 0;<br>
&gt; &gt; @@ -625,12 +627,10 @@ static void calculate_dirtyrate_dirty_ring(=
struct<br>
&gt; &gt; DirtyRateConfig config)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QE=
MU_CLOCK_REALTIME) / 1000;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* calculate vcpu dirtyrate */<br>
&gt; &gt; -=C2=A0 =C2=A0 duration =3D vcpu_calculate_dirtyrate(config.sampl=
e_period_seconds *<br>
&gt; &gt; 1000,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;DirtyStat.dirty_ring,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GLOBAL_DIRTY_DIRTY_RATE,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 true);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 DirtyStat.calc_time =3D duration / 1000;<br>
&gt; &gt; +=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D vcpu_calculate_dirtyrat=
e(config.calc_time_ms,<br>
&gt; &gt; +<br>
&gt; &gt; &amp;DirtyStat.dirty_ring,<br>
&gt; &gt; +<br>
&gt; &gt; GLOBAL_DIRTY_DIRTY_RATE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* calculate vm dirtyrate */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; DirtyStat.dirty_ring.nvc=
pu; i++) {<br>
&gt; &gt; @@ -646,7 +646,6 @@ static void calculate_dirtyrate_sample_vm(str=
uct<br>
&gt; &gt; DirtyRateConfig config)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 struct RamblockDirtyInfo *block_dinfo =3D NUL=
L;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int block_count =3D 0;<br>
&gt; &gt; -=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int64_t initial_time;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 rcu_read_lock();<br>
&gt; &gt; @@ -656,17 +655,16 @@ static void calculate_dirtyrate_sample_vm(s=
truct<br>
&gt; &gt; DirtyRateConfig config)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 rcu_read_unlock();<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 msec =3D config.sample_period_seconds * 1000;<br>
&gt; &gt; -=C2=A0 =C2=A0 msec =3D dirty_stat_wait(msec, initial_time);<br>
&gt; &gt; +=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D dirty_stat_wait(config.=
calc_time_ms,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0initial_time);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 DirtyStat.start_time =3D initial_time / 1000;=
<br>
&gt; &gt; -=C2=A0 =C2=A0 DirtyStat.calc_time =3D msec / 1000;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 rcu_read_lock();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!compare_page_hash_info(block_dinfo, bloc=
k_count)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 update_dirtyrate(msec);<br>
&gt; &gt; +=C2=A0 =C2=A0 update_dirtyrate(DirtyStat.calc_time_ms);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 out:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 rcu_read_unlock();<br>
&gt; &gt; @@ -711,7 +709,10 @@ void *get_dirtyrate_thread(void *arg)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -void qmp_calc_dirty_rate(int64_t calc_time,<br>
&gt; &gt; +void qmp_calc_dirty_rate(bool has_calc_time,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t calc_time,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_calc_time_ms,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t calc_time_ms,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_sample_pages,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t sample_pages,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_mode,<br>
&gt; &gt; @@ -731,10 +732,21 @@ void qmp_calc_dirty_rate(int64_t calc_time,=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 if (!is_sample_period_valid(calc_time)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;calc-time is =
out of range[%d, %d].&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MIN_FETCH_DIRTYRATE_TIME_SEC,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MAX_FETCH_DIRTYRATE_TIME_SEC);<br>
&gt; &gt; +=C2=A0 =C2=A0 if ((int)has_calc_time + (int)has_calc_time_ms !=
=3D 1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Exactly one o=
f calc-time and calc-time-ms must&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; be specified&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 if (has_calc_time) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The worst thing that can hap=
pen due to overflow is that<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* invalid value will become va=
lid.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_time_ms =3D calc_time * 1000;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!is_calc_time_valid(calc_time_ms)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Calculation t=
ime is out of range[%dms, %dms].&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -781,7 +793,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 config.sample_period_seconds =3D calc_time;<br>
&gt; &gt; +=C2=A0 =C2=A0 config.calc_time_ms =3D calc_time_ms;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 config.sample_pages_per_gigabytes =3D sample_=
pages;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 config.mode =3D mode;<br>
&gt; &gt;<br>
&gt; &gt; @@ -867,8 +879,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const=
 QDict<br>
&gt; &gt; *qdict)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D DIRTY_RATE_MEASURE_MOD=
E_DIRTY_RING;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 qmp_calc_dirty_rate(sec, has_sample_pages, sample_=
pages, true,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 mode, &amp;err);<br>
&gt; &gt; +=C2=A0 =C2=A0 qmp_calc_dirty_rate(true, sec, /* calc_time */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 false, 0, /* calc_time_ms */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 has_sample_pages, sample_pages,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 true, mode,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hmp_handle_error(mon, err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; --<br>
&gt; &gt; 2.30.2<br>
&gt; &gt;<br>
&gt; &gt; The patch set works for me, and I&#39;m inclined to split it into=
 two commits<br>
&gt; as I point out above.<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
&gt; Yong<br>
&gt; <br>
&gt; -- <br>
&gt; Best regards<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000021aff806028bdd82--

