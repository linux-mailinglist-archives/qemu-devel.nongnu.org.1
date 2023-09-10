Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B2799EE2
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 17:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfMmx-0006Le-DT; Sun, 10 Sep 2023 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qfMmv-0006LW-29
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 11:55:53 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qfMmp-0007Fs-Dz
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 11:55:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5774b3de210so451453a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694361223; x=1694966023;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3uuXnASuwdNHG77C1RWFBUq64X8HHguFfZ5OvRgPWw=;
 b=AFLFoZVnmI04BybnwcThCOUG/shjqkvx96YX2RyWoWs6bsiGINvds9VKoOMLePdl2y
 c9LKA9qUWZJ0LrLrIQXsCunZTEv5HuyZHStxQl3Wcfnr63E6q/zirEpB0HQdlTDt0pef
 raRyc4l65VJqkGWO4+fc29uKBOzqCVkE5Cu8sadjPuNO66S3UZg7QNehOwWBBg1u+ZgP
 QAParyx5IDgBi7iZVJMamggm9M22RAffsaWhEZOTmI50sAdTGaDyuXuMg0iTXFZuK5Zc
 Xw6TuST63jX9udlJe5w3czxQ8DfNHgfWkeu6XlmOhmeWQHmfyD1b5AgHBcIsZrbzq6+w
 Fu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694361223; x=1694966023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3uuXnASuwdNHG77C1RWFBUq64X8HHguFfZ5OvRgPWw=;
 b=sJ5cTxtbLAW/rqpCH5sRyhWTb1zq0izmtdUbhTygioQdg/VbMHwweEbE/hs1yweqwn
 /UCtunREj5r9Ly1IctLZ7TerC/UJ5QeZZbcDLv2yW4JplOb0YsKiupPTejwqn8H1G8/g
 qgCYRyr3DlU1r+fmD3ub84mg0PBxuI5/CGp7z2uff8ml1cunLwsBn6yhPSTORAR1F58G
 DRTq6+BE4QiOwpJAahOXmzGg9ZUOSbj/mneHV11yaZiG/GFJLRxj4ZiBHoNFcLCcBmOa
 w5qlJ+H/Im6J5DIvmD5gO5/sOaRuG84Kkt+WaCLMkX7rH6L+NLBKUIKJkwPKmPAOe2ML
 lXDQ==
X-Gm-Message-State: AOJu0YwS+iemV5TTxP/zV1TZ0gUdroEhmtaRTaUVjQNRjcOaxVby9Hp3
 Oi8uEIAdS3YOdvHE1eSP5Otg4VMF+YsEW+0U+JTKwA==
X-Google-Smtp-Source: AGHT+IG9q4MUdLlpx+kRzbvhwRGgfttUlRBK749a7DBYoX5LtzD6/p+G55ZckEwc5QZlUeiLR2Lgh2XLk94KGieg47M=
X-Received: by 2002:a05:6a21:6da8:b0:14d:fefd:a2eb with SMTP id
 wl40-20020a056a216da800b0014dfefda2ebmr7384370pzb.22.1694361223059; Sun, 10
 Sep 2023 08:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <d802e6b8053eb60fbec1a784cf86f67d9528e0a8.1693895970.git.gudkov.andrei@huawei.com>
In-Reply-To: <d802e6b8053eb60fbec1a784cf86f67d9528e0a8.1693895970.git.gudkov.andrei@huawei.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 10 Sep 2023 23:53:26 +0800
Message-ID: <CAK9dgmYTDKVb5vT_7Nj_gpFpgNRnTh6=uGf2ffs-3oEPSzh=nw@mail.gmail.com>
Subject: Re: [PATCH v3] migration/calc-dirty-rate: millisecond-granularity
 period
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d276310605033687"
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
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

--000000000000d276310605033687
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 5, 2023 at 3:06=E2=80=AFPM Andrei Gudkov <gudkov.andrei@huawei.=
com>
wrote:

> This patch allows to measure dirty page rate for
> sub-second intervals of time. An optional argument is
> introduced -- calc-time-unit. For example:
> {"execute": "calc-dirty-rate", "arguments":
>   {"calc-time": 500, "calc-time-unit": "millisecond"} }
>
> Millisecond granularity allows to make predictions whether
> migration will succeed or not. To do this, calculate dirty
> rate with calc-time set to max allowed downtime (e.g. 300ms),
> convert measured rate into volume of dirtied memory,
> and divide by network throughput. If the value is lower
> than max allowed downtime, then migration will converge.
>
> Measurement results for single thread randomly writing to
> a 1/4/24GiB memory region:
>
> +----------------+-----------------------------------------------+
> | calc-time      |                dirty rate MiB/s               |
> | (milliseconds) +----------------+---------------+--------------+
> |                | theoretical    | page-sampling | dirty-bitmap |
> |                | (at 3M wr/sec) |               |              |
> +----------------+----------------+---------------+--------------+
> |                               1GiB                             |
> +----------------+----------------+---------------+--------------+
> |            100 |           6996 |          7100 |         3192 |
> |            200 |           4606 |          4660 |         2655 |
> |            300 |           3305 |          3280 |         2371 |
> |            400 |           2534 |          2525 |         2154 |
> |            500 |           2041 |          2044 |         1871 |
> |            750 |           1365 |          1341 |         1358 |
> |           1000 |           1024 |          1052 |         1025 |
> |           1500 |            683 |           678 |          684 |
> |           2000 |            512 |           507 |          513 |
> +----------------+----------------+---------------+--------------+
> |                               4GiB                             |
> +----------------+----------------+---------------+--------------+
> |            100 |          10232 |          8880 |         4070 |
> |            200 |           8954 |          8049 |         3195 |
> |            300 |           7889 |          7193 |         2881 |
> |            400 |           6996 |          6530 |         2700 |
> |            500 |           6245 |          5772 |         2312 |
> |            750 |           4829 |          4586 |         2465 |
> |           1000 |           3865 |          3780 |         2178 |
> |           1500 |           2694 |          2633 |         2004 |
> |           2000 |           2041 |          2031 |         1789 |
> +----------------+----------------+---------------+--------------+
> |                               24GiB                            |
> +----------------+----------------+---------------+--------------+
> |            100 |          11495 |          8640 |         5597 |
> |            200 |          11226 |          8616 |         3527 |
> |            300 |          10965 |          8386 |         2355 |
> |            400 |          10713 |          8370 |         2179 |
> |            500 |          10469 |          8196 |         2098 |
> |            750 |           9890 |          7885 |         2556 |
> |           1000 |           9354 |          7506 |         2084 |
> |           1500 |           8397 |          6944 |         2075 |
> |           2000 |           7574 |          6402 |         2062 |
> +----------------+----------------+---------------+--------------+
>
> Theoretical values are computed according to the following formula:
> size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> where size is in bytes, time is in seconds, and wps is number of
> writes per second.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/migration.json   |  58 ++++++++++++++++++-----
>  migration/dirtyrate.h |  12 +++--
>  migration/dirtyrate.c | 107 +++++++++++++++++++++++++++++-------------
>  3 files changed, 128 insertions(+), 49 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59..1717aa4bbd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1836,6 +1836,21 @@
>  { 'enum': 'DirtyRateMeasureMode',
>    'data': ['page-sampling', 'dirty-ring', 'dirty-bitmap'] }
>
> +##
> +# @TimeUnit:
> +#
> +# Specifies unit in which time-related value is specified.
> +#
> +# @second: value is in seconds
> +#
> +# @millisecond: value is in milliseconds
> +#
> +# Since 8.2
> +#
> +##
> +{ 'enum': 'TimeUnit',
> +  'data': ['second', 'millisecond'] }
> +
>  ##
>  # @DirtyRateInfo:
>  #
> @@ -1848,8 +1863,10 @@
>  #
>  # @start-time: start time in units of second for calculation
>  #
> -# @calc-time: time period for which dirty page rate was measured
> -#     (in seconds)
> +# @calc-time: time period for which dirty page rate was measured,
> +#     expressed and rounded down to @calc-time-unit.
> +#
> +# @calc-time-unit: time unit of @calc-time  (Since 8.2)
>  #
>  # @sample-pages: number of sampled pages per GiB of guest memory.
>  #     Valid only in page-sampling mode (Since 6.1)
> @@ -1866,6 +1883,7 @@
>             'status': 'DirtyRateStatus',
>             'start-time': 'int64',
>             'calc-time': 'int64',
> +           'calc-time-unit': 'TimeUnit',
>             'sample-pages': 'uint64',
>             'mode': 'DirtyRateMeasureMode',
>             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> @@ -1901,12 +1919,16 @@
>  #    This mode tracks page modification per each vCPU separately.  It
>  #    requires that KVM accelerator property "dirty-ring-size" is set.
>  #
> -# @calc-time: time period in units of second for which dirty page rate
> -#     is calculated.  Note that larger @calc-time values will
> -#     typically result in smaller dirty page rates because page
> -#     dirtying is a one-time event.  Once some page is counted as
> -#     dirty during @calc-time period, further writes to this page will
> -#     not increase dirty page rate anymore.
> +# @calc-time: time period for which dirty page rate is calculated.
> +#     By default it is specified in seconds, but the unit can be set
> +#     explicitly with @calc-time-unit.  Note that larger @calc-time
> +#     values will typically result in smaller dirty page rates because
> +#     page dirtying is a one-time event.  Once some page is counted
> +#     as dirty during @calc-time period, further writes to this page
> +#     will not increase dirty page rate anymore.
> +#
> +# @calc-time-unit: time unit in which @calc-time is specified.
> +#     By default it is seconds. (Since 8.2)
>  #
>  # @sample-pages: number of sampled pages per each GiB of guest memory.
>  #     Default value is 512.  For 4KiB guest pages this corresponds to
> @@ -1924,8 +1946,16 @@
>  # -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
>  #                                                 'sample-pages': 512} }
>  # <- { "return": {} }
> +#
> +# Measure dirty rate using dirty bitmap for 500 milliseconds:
> +#
> +# -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 500,
> +#     "calc-time-unit": "millisecond", "mode": "dirty-bitmap"} }
> +#
> +# <- { "return": {} }
>  ##
>  { 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> +                                         '*calc-time-unit': 'TimeUnit',
>                                           '*sample-pages': 'int',
>                                           '*mode': 'DirtyRateMeasureMode'=
}
> }
>
> @@ -1934,6 +1964,9 @@
>  #
>  # Query results of the most recent invocation of @calc-dirty-rate.
>  #
> +# @calc-time-unit: time unit in which to report calculation time.
> +#     By default it is reported in seconds. (Since 8.2)
> +#
>  # Since: 5.2
>  #
>  # Examples:
> @@ -1941,14 +1974,17 @@
>  # 1. Measurement is in progress:
>  #
>  # <- {"status": "measuring", "sample-pages": 512,
> -#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
> +#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
> +#     "calc-time-unit": "second"}
>  #
>  # 2. Measurement has been completed:
>  #
>  # <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
> -#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
> +#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10,
> +#     "calc-time-unit": "second"}
>  ##
> -{ 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
> +{ 'command': 'query-dirty-rate', 'data': {'*calc-time-unit': 'TimeUnit' =
},
> +                                 'returns': 'DirtyRateInfo' }
>
>  ##
>  # @DirtyLimitInfo:
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 594a5c0bb6..869c060941 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -31,10 +31,12 @@
>  #define MIN_RAMBLOCK_SIZE                         128
>
>  /*
> - * Take 1s as minimum time for calculation duration
> + * Allowed range for dirty page rate calculation (in milliseconds).
> + * Lower limit relates to the smallest realistic downtime it
> + * makes sense to impose on migration.
>   */
> -#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
> -#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
> +#define MIN_CALC_TIME_MS                          50
> +#define MAX_CALC_TIME_MS                       60000
>
>  /*
>   * Take 1/16 pages in 1G as the maxmum sample page count
> @@ -44,7 +46,7 @@
>
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> -    int64_t sample_period_seconds; /* time duration between two sampling
> */
> +    int64_t calc_time_ms; /* desired calculation time (in milliseconds) =
*/
>      DirtyRateMeasureMode mode; /* mode of dirtyrate measurement */
>  };
>
> @@ -73,7 +75,7 @@ typedef struct SampleVMStat {
>  struct DirtyRateStat {
>      int64_t dirty_rate; /* dirty rate in MB/s */
>      int64_t start_time; /* calculation start time in units of second */
> -    int64_t calc_time; /* time duration of two sampling in units of
> second */
> +    int64_t calc_time_ms; /* actual calculation time (in milliseconds) *=
/
>      uint64_t sample_pages; /* sample pages per GB */
>      union {
>          SampleVMStat page_sampling;
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bccb3515e3..a461b28bb5 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -189,10 +189,9 @@ retry:
>      return duration;
>  }
>
> -static bool is_sample_period_valid(int64_t sec)
> +static bool is_calc_time_valid(int64_t msec)
>  {
> -    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
> -        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
> +    if ((msec < MIN_CALC_TIME_MS) || (msec > MAX_CALC_TIME_MS)) {
>          return false;
>      }
>
> @@ -216,7 +215,39 @@ static int dirtyrate_set_state(int *state, int
> old_state, int new_state)
>      }
>  }
>
> -static struct DirtyRateInfo *query_dirty_rate_info(void)
> +/* Decimal power of given time unit relative to one second */
> +static int time_unit_to_power(TimeUnit time_unit)
> +{
> +    switch (time_unit) {
> +    case TIME_UNIT_SECOND:
> +        return 0;
> +    case TIME_UNIT_MILLISECOND:
> +        return -3;
> +    default:
> +        assert(false); /* unreachable */
> +        return 0;
> +    }
> +}
> +
> +static int64_t convert_time_unit(int64_t value, TimeUnit unit_from,
> +                                 TimeUnit unit_to)
> +{
> +    int power =3D time_unit_to_power(unit_from) -
> +                time_unit_to_power(unit_to);
> +    while (power < 0) {
> +        value /=3D 10;
> +        power +=3D 1;
> +    }
> +    while (power > 0) {
> +        value *=3D 10;
> +        power -=3D 1;
> +    }
> +    return value;
> +}
> +
> +
> +static struct DirtyRateInfo *
> +query_dirty_rate_info(TimeUnit calc_time_unit)
>  {
>      int i;
>      int64_t dirty_rate =3D DirtyStat.dirty_rate;
> @@ -225,7 +256,10 @@ static struct DirtyRateInfo
> *query_dirty_rate_info(void)
>
>      info->status =3D CalculatingState;
>      info->start_time =3D DirtyStat.start_time;
> -    info->calc_time =3D DirtyStat.calc_time;
> +    info->calc_time =3D convert_time_unit(DirtyStat.calc_time_ms,
> +                                        TIME_UNIT_MILLISECOND,
> +                                        calc_time_unit);
> +    info->calc_time_unit =3D calc_time_unit;
>      info->sample_pages =3D DirtyStat.sample_pages;
>      info->mode =3D dirtyrate_mode;
>
> @@ -264,7 +298,7 @@ static void init_dirtyrate_stat(int64_t start_time,
>  {
>      DirtyStat.dirty_rate =3D -1;
>      DirtyStat.start_time =3D start_time;
> -    DirtyStat.calc_time =3D config.sample_period_seconds;
> +    DirtyStat.calc_time_ms =3D config.calc_time_ms;
>      DirtyStat.sample_pages =3D config.sample_pages_per_gigabytes;
>
>      switch (config.mode) {
> @@ -574,7 +608,6 @@ static inline void dirtyrate_manual_reset_protect(voi=
d)
>
>  static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig
> config)
>  {
> -    int64_t msec =3D 0;
>      int64_t start_time;
>      DirtyPageRecord dirty_pages;
>
> @@ -602,9 +635,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct
> DirtyRateConfig config)
>      start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      DirtyStat.start_time =3D start_time / 1000;
>
> -    msec =3D config.sample_period_seconds * 1000;
> -    msec =3D dirty_stat_wait(msec, start_time);
> -    DirtyStat.calc_time =3D msec / 1000;
> +    DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_ms,
> start_time);
>
>      /*
>       * do two things.
> @@ -615,12 +646,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct
> DirtyRateConfig config)
>
>      record_dirtypages_bitmap(&dirty_pages, false);
>
> -    DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages, msec);
> +    DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages,
> +                                                  DirtyStat.calc_time_ms=
);
>  }
>
>  static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig config=
)
>  {
> -    int64_t duration;
>      uint64_t dirtyrate =3D 0;
>      uint64_t dirtyrate_sum =3D 0;
>      int i =3D 0;
> @@ -631,12 +662,10 @@ static void calculate_dirtyrate_dirty_ring(struct
> DirtyRateConfig config)
>      DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 10=
00;
>
>      /* calculate vcpu dirtyrate */
> -    duration =3D vcpu_calculate_dirtyrate(config.sample_period_seconds *
> 1000,
> -                                        &DirtyStat.dirty_ring,
> -                                        GLOBAL_DIRTY_DIRTY_RATE,
> -                                        true);
> -
> -    DirtyStat.calc_time =3D duration / 1000;
> +    DirtyStat.calc_time_ms =3D vcpu_calculate_dirtyrate(config.calc_time=
_ms,
> +
> &DirtyStat.dirty_ring,
> +
> GLOBAL_DIRTY_DIRTY_RATE,
> +                                                      true);
>
>      /* calculate vm dirtyrate */
>      for (i =3D 0; i < DirtyStat.dirty_ring.nvcpu; i++) {
> @@ -652,7 +681,6 @@ static void calculate_dirtyrate_sample_vm(struct
> DirtyRateConfig config)
>  {
>      struct RamblockDirtyInfo *block_dinfo =3D NULL;
>      int block_count =3D 0;
> -    int64_t msec =3D 0;
>      int64_t initial_time;
>
>      rcu_read_lock();
> @@ -662,17 +690,16 @@ static void calculate_dirtyrate_sample_vm(struct
> DirtyRateConfig config)
>      }
>      rcu_read_unlock();
>
> -    msec =3D config.sample_period_seconds * 1000;
> -    msec =3D dirty_stat_wait(msec, initial_time);
> +    DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_ms,
> +                                             initial_time);
>      DirtyStat.start_time =3D initial_time / 1000;
> -    DirtyStat.calc_time =3D msec / 1000;
>
>      rcu_read_lock();
>      if (!compare_page_hash_info(block_dinfo, block_count)) {
>          goto out;
>      }
>
> -    update_dirtyrate(msec);
> +    update_dirtyrate(DirtyStat.calc_time_ms);
>
>  out:
>      rcu_read_unlock();
> @@ -718,6 +745,8 @@ void *get_dirtyrate_thread(void *arg)
>  }
>
>  void qmp_calc_dirty_rate(int64_t calc_time,
> +                         bool has_calc_time_unit,
> +                         TimeUnit calc_time_unit,
>                           bool has_sample_pages,
>                           int64_t sample_pages,
>                           bool has_mode,
> @@ -737,10 +766,15 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>          return;
>      }
>
> -    if (!is_sample_period_valid(calc_time)) {
> -        error_setg(errp, "calc-time is out of range[%d, %d].",
> -                         MIN_FETCH_DIRTYRATE_TIME_SEC,
> -                         MAX_FETCH_DIRTYRATE_TIME_SEC);
> +    int64_t calc_time_ms =3D convert_time_unit(
> +        calc_time,
> +        has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND,
> +        TIME_UNIT_MILLISECOND
> +    );
> +
> +    if (!is_calc_time_valid(calc_time_ms)) {
> +        error_setg(errp, "Calculation time is out of range [%dms, %dms].=
",
> +                         MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);
>          return;
>      }
>
> @@ -787,7 +821,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>          return;
>      }
>
> -    config.sample_period_seconds =3D calc_time;
> +    config.calc_time_ms =3D calc_time_ms;
>      config.sample_pages_per_gigabytes =3D sample_pages;
>      config.mode =3D mode;
>
> @@ -806,14 +840,18 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>                         (void *)&config, QEMU_THREAD_DETACHED);
>  }
>
> -struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)
> +
> +struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
> +                                           TimeUnit calc_time_unit,
> +                                           Error **errp)
>  {
> -    return query_dirty_rate_info();
> +    return query_dirty_rate_info(
> +        has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND);
>  }
>
>  void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)
>  {
> -    DirtyRateInfo *info =3D query_dirty_rate_info();
> +    DirtyRateInfo *info =3D query_dirty_rate_info(TIME_UNIT_SECOND);
>
>      monitor_printf(mon, "Status: %s\n",
>                     DirtyRateStatus_str(info->status));
> @@ -873,8 +911,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict
> *qdict)
>          mode =3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING;
>      }
>
> -    qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, true,
> -                        mode, &err);
> +    qmp_calc_dirty_rate(sec, /* calc-time */
> +                        false, TIME_UNIT_SECOND, /* calc-time-unit */
> +                        has_sample_pages, sample_pages,
> +                        true, mode,
> +                        &err);
>      if (err) {
>          hmp_handle_error(mon, err);
>          return;
> --
> 2.30.2
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--000000000000d276310605033687
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 5, 202=
3 at 3:06=E2=80=AFPM Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huaw=
ei.com">gudkov.andrei@huawei.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
This patch allows to measure dirty page rate for<br>
sub-second intervals of time. An optional argument is<br>
introduced -- calc-time-unit. For example:<br>
{&quot;execute&quot;: &quot;calc-dirty-rate&quot;, &quot;arguments&quot;:<b=
r>
=C2=A0 {&quot;calc-time&quot;: 500, &quot;calc-time-unit&quot;: &quot;milli=
second&quot;} }<br>
<br>
Millisecond granularity allows to make predictions whether<br>
migration will succeed or not. To do this, calculate dirty<br>
rate with calc-time set to max allowed downtime (e.g. 300ms),<br>
convert measured rate into volume of dirtied memory,<br>
and divide by network throughput. If the value is lower<br>
than max allowed downtime, then migration will converge.<br>
<br>
Measurement results for single thread randomly writing to<br>
a 1/4/24GiB memory region:<br>
<br>
+----------------+-----------------------------------------------+<br>
| calc-time=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dirty rate MiB/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>
| (milliseconds) +----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | theoretical=C2=
=A0 =C2=A0 | page-sampling | dirty-bitmap |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (at 3M wr/sec) |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7100 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A03192 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A04606 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4660 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02655 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A03305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3280 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02371 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02534 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2525 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02154 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2044 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01871 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01365 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1341 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01358 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1052 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01025 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0678 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 684 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 512 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0507 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 513 |<br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10232 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8880 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A04070 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A08954 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8049 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A03195 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A07889 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7193 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02881 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6530 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02700 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A06245 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5772 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02312 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A04829 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4586 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02465 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A03865 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3780 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02178 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02694 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2633 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02004 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2031 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01789 |<br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
+----------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 11495 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8640 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A05597 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 11226 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8616 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A03527 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10965 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8386 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02355 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10713 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8370 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02179 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8196 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A02098 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A09890 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7885 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02556 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A09354 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7506 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02084 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A08397 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6944 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02075 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A07574 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6402 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02062 |<br>
+----------------+----------------+---------------+--------------+<br>
<br>
Theoretical values are computed according to the following formula:<br>
size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),<br>
where size is in bytes, time is in seconds, and wps is number of<br>
writes per second.<br>
<br>
Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huawei.com=
" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
---<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0|=C2=A0 58 ++++++++++++++++++-----<br=
>
=C2=A0migration/dirtyrate.h |=C2=A0 12 +++--<br>
=C2=A0migration/dirtyrate.c | 107 +++++++++++++++++++++++++++++------------=
-<br>
=C2=A03 files changed, 128 insertions(+), 49 deletions(-)<br>
<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 8843e74b59..1717aa4bbd 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -1836,6 +1836,21 @@<br>
=C2=A0{ &#39;enum&#39;: &#39;DirtyRateMeasureMode&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: [&#39;page-sampling&#39;, &#39;dirty-ring&#39;=
, &#39;dirty-bitmap&#39;] }<br>
<br>
+##<br>
+# @TimeUnit:<br>
+#<br>
+# Specifies unit in which time-related value is specified.<br>
+#<br>
+# @second: value is in seconds<br>
+#<br>
+# @millisecond: value is in milliseconds<br>
+#<br>
+# Since 8.2<br>
+#<br>
+##<br>
+{ &#39;enum&#39;: &#39;TimeUnit&#39;,<br>
+=C2=A0 &#39;data&#39;: [&#39;second&#39;, &#39;millisecond&#39;] }<br>
+<br>
=C2=A0##<br>
=C2=A0# @DirtyRateInfo:<br>
=C2=A0#<br>
@@ -1848,8 +1863,10 @@<br>
=C2=A0#<br>
=C2=A0# @start-time: start time in units of second for calculation<br>
=C2=A0#<br>
-# @calc-time: time period for which dirty page rate was measured<br>
-#=C2=A0 =C2=A0 =C2=A0(in seconds)<br>
+# @calc-time: time period for which dirty page rate was measured,<br>
+#=C2=A0 =C2=A0 =C2=A0expressed and rounded down to @calc-time-unit.<br>
+#<br>
+# @calc-time-unit: time unit of @calc-time=C2=A0 (Since 8.2)<br>
=C2=A0#<br>
=C2=A0# @sample-pages: number of sampled pages per GiB of guest memory.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Valid only in page-sampling mode (Since 6.1)<br>
@@ -1866,6 +1883,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;DirtyRateS=
tatus&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;start-time&#39;: &#39;int64&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;calc-time&#39;: &#39;int64&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time-unit&#39;: &#39;Ti=
meUnit&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;sample-pages&#39;: &#39;uint=
64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mode&#39;: &#39;DirtyRateMea=
sureMode&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vcpu-dirty-rate&#39;: [ &#3=
9;DirtyRateVcpu&#39; ] } }<br>
@@ -1901,12 +1919,16 @@<br>
=C2=A0#=C2=A0 =C2=A0 This mode tracks page modification per each vCPU separ=
ately.=C2=A0 It<br>
=C2=A0#=C2=A0 =C2=A0 requires that KVM accelerator property &quot;dirty-rin=
g-size&quot; is set.<br>
=C2=A0#<br>
-# @calc-time: time period in units of second for which dirty page rate<br>
-#=C2=A0 =C2=A0 =C2=A0is calculated.=C2=A0 Note that larger @calc-time valu=
es will<br>
-#=C2=A0 =C2=A0 =C2=A0typically result in smaller dirty page rates because =
page<br>
-#=C2=A0 =C2=A0 =C2=A0dirtying is a one-time event.=C2=A0 Once some page is=
 counted as<br>
-#=C2=A0 =C2=A0 =C2=A0dirty during @calc-time period, further writes to thi=
s page will<br>
-#=C2=A0 =C2=A0 =C2=A0not increase dirty page rate anymore.<br>
+# @calc-time: time period for which dirty page rate is calculated.<br>
+#=C2=A0 =C2=A0 =C2=A0By default it is specified in seconds, but the unit c=
an be set<br>
+#=C2=A0 =C2=A0 =C2=A0explicitly with @calc-time-unit.=C2=A0 Note that larg=
er @calc-time<br>
+#=C2=A0 =C2=A0 =C2=A0values will typically result in smaller dirty page ra=
tes because<br>
+#=C2=A0 =C2=A0 =C2=A0page dirtying is a one-time event.=C2=A0 Once some pa=
ge is counted<br>
+#=C2=A0 =C2=A0 =C2=A0as dirty during @calc-time period, further writes to =
this page<br>
+#=C2=A0 =C2=A0 =C2=A0will not increase dirty page rate anymore.<br>
+#<br>
+# @calc-time-unit: time unit in which @calc-time is specified.<br>
+#=C2=A0 =C2=A0 =C2=A0By default it is seconds. (Since 8.2)<br>
=C2=A0#<br>
=C2=A0# @sample-pages: number of sampled pages per each GiB of guest memory=
.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Default value is 512.=C2=A0 For 4KiB guest pages=
 this corresponds to<br>
@@ -1924,8 +1946,16 @@<br>
=C2=A0# -&gt; {&quot;execute&quot;: &quot;calc-dirty-rate&quot;, &quot;argu=
ments&quot;: {&quot;calc-time&quot;: 1,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;: 512} }<br>
=C2=A0# &lt;- { &quot;return&quot;: {} }<br>
+#<br>
+# Measure dirty rate using dirty bitmap for 500 milliseconds:<br>
+#<br>
+# -&gt; {&quot;execute&quot;: &quot;calc-dirty-rate&quot;, &quot;arguments=
&quot;: {&quot;calc-time&quot;: 500,<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;calc-time-unit&quot;: &quot;millisecond&quot;, =
&quot;mode&quot;: &quot;dirty-bitmap&quot;} }<br>
+#<br>
+# &lt;- { &quot;return&quot;: {} }<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: {&#39=
;calc-time&#39;: &#39;int64&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#=
39;*calc-time-unit&#39;: &#39;TimeUnit&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;*sample-pages&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;*mode&#39;: &#39;DirtyRateMeasureMode&#39;} }<br>
<br>
@@ -1934,6 +1964,9 @@<br>
=C2=A0#<br>
=C2=A0# Query results of the most recent invocation of @calc-dirty-rate.<br=
>
=C2=A0#<br>
+# @calc-time-unit: time unit in which to report calculation time.<br>
+#=C2=A0 =C2=A0 =C2=A0By default it is reported in seconds. (Since 8.2)<br>
+#<br>
=C2=A0# Since: 5.2<br>
=C2=A0#<br>
=C2=A0# Examples:<br>
@@ -1941,14 +1974,17 @@<br>
=C2=A0# 1. Measurement is in progress:<br>
=C2=A0#<br>
=C2=A0# &lt;- {&quot;status&quot;: &quot;measuring&quot;, &quot;sample-page=
s&quot;: 512,<br>
-#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10}<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10,<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;calc-time-unit&quot;: &quot;second&quot;}<br>
=C2=A0#<br>
=C2=A0# 2. Measurement has been completed:<br>
=C2=A0#<br>
=C2=A0# &lt;- {&quot;status&quot;: &quot;measured&quot;, &quot;sample-pages=
&quot;: 512, &quot;dirty-rate&quot;: 108,<br>
-#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10}<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10,<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;calc-time-unit&quot;: &quot;second&quot;}<br>
=C2=A0##<br>
-{ &#39;command&#39;: &#39;query-dirty-rate&#39;, &#39;returns&#39;: &#39;D=
irtyRateInfo&#39; }<br>
+{ &#39;command&#39;: &#39;query-dirty-rate&#39;, &#39;data&#39;: {&#39;*ca=
lc-time-unit&#39;: &#39;TimeUnit&#39; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;returns&#39;: &#39;DirtyR=
ateInfo&#39; }<br>
<br>
=C2=A0##<br>
=C2=A0# @DirtyLimitInfo:<br>
diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h<br>
index 594a5c0bb6..869c060941 100644<br>
--- a/migration/dirtyrate.h<br>
+++ b/migration/dirtyrate.h<br>
@@ -31,10 +31,12 @@<br>
=C2=A0#define MIN_RAMBLOCK_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0128<br>
<br>
=C2=A0/*<br>
- * Take 1s as minimum time for calculation duration<br>
+ * Allowed range for dirty page rate calculation (in milliseconds).<br>
+ * Lower limit relates to the smallest realistic downtime it<br>
+ * makes sense to impose on migration.<br>
=C2=A0 */<br>
-#define MIN_FETCH_DIRTYRATE_TIME_SEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 1<br>
-#define MAX_FETCH_DIRTYRATE_TIME_SEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 60<br>
+#define MIN_CALC_TIME_MS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 50<br>
+#define MAX_CALC_TIME_MS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060000<br>
<br>
=C2=A0/*<br>
=C2=A0 * Take 1/16 pages in 1G as the maxmum sample page count<br>
@@ -44,7 +46,7 @@<br>
<br>
=C2=A0struct DirtyRateConfig {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sample_pages_per_gigabytes; /* sample pages pe=
r GB */<br>
-=C2=A0 =C2=A0 int64_t sample_period_seconds; /* time duration between two =
sampling */<br>
+=C2=A0 =C2=A0 int64_t calc_time_ms; /* desired calculation time (in millis=
econds) */<br>
=C2=A0 =C2=A0 =C2=A0DirtyRateMeasureMode mode; /* mode of dirtyrate measure=
ment */<br>
=C2=A0};<br>
<br>
@@ -73,7 +75,7 @@ typedef struct SampleVMStat {<br>
=C2=A0struct DirtyRateStat {<br>
=C2=A0 =C2=A0 =C2=A0int64_t dirty_rate; /* dirty rate in MB/s */<br>
=C2=A0 =C2=A0 =C2=A0int64_t start_time; /* calculation start time in units =
of second */<br>
-=C2=A0 =C2=A0 int64_t calc_time; /* time duration of two sampling in units=
 of second */<br>
+=C2=A0 =C2=A0 int64_t calc_time_ms; /* actual calculation time (in millise=
conds) */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sample_pages; /* sample pages per GB */<br>
=C2=A0 =C2=A0 =C2=A0union {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SampleVMStat page_sampling;<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index bccb3515e3..a461b28bb5 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -189,10 +189,9 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0return duration;<br>
=C2=A0}<br>
<br>
-static bool is_sample_period_valid(int64_t sec)<br>
+static bool is_calc_time_valid(int64_t msec)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (sec &lt; MIN_FETCH_DIRTYRATE_TIME_SEC ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sec &gt; MAX_FETCH_DIRTYRATE_TIME_SEC) {<br>
+=C2=A0 =C2=A0 if ((msec &lt; MIN_CALC_TIME_MS) || (msec &gt; MAX_CALC_TIME=
_MS)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -216,7 +215,39 @@ static int dirtyrate_set_state(int *state, int old_sta=
te, int new_state)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static struct DirtyRateInfo *query_dirty_rate_info(void)<br>
+/* Decimal power of given time unit relative to one second */<br>
+static int time_unit_to_power(TimeUnit time_unit)<br>
+{<br>
+=C2=A0 =C2=A0 switch (time_unit) {<br>
+=C2=A0 =C2=A0 case TIME_UNIT_SECOND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 case TIME_UNIT_MILLISECOND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -3;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(false); /* unreachable */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static int64_t convert_time_unit(int64_t value, TimeUnit unit_from,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TimeUnit unit_to)<br>
+{<br>
+=C2=A0 =C2=A0 int power =3D time_unit_to_power(unit_from) -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_unit_to_power=
(unit_to);<br>
+=C2=A0 =C2=A0 while (power &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value /=3D 10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 power +=3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 while (power &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value *=3D 10;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 power -=3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return value;<br>
+}<br>
+<br>
+<br>
+static struct DirtyRateInfo *<br>
+query_dirty_rate_info(TimeUnit calc_time_unit)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0int64_t dirty_rate =3D DirtyStat.dirty_rate;<br>
@@ -225,7 +256,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(voi=
d)<br>
<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;status =3D CalculatingState;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;start_time =3D DirtyStat.start_time;<br>
-=C2=A0 =C2=A0 info-&gt;calc_time =3D DirtyStat.calc_time;<br>
+=C2=A0 =C2=A0 info-&gt;calc_time =3D convert_time_unit(DirtyStat.calc_time=
_ms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TIME_UNI=
T_MILLISECOND,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_tim=
e_unit);<br>
+=C2=A0 =C2=A0 info-&gt;calc_time_unit =3D calc_time_unit;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;sample_pages =3D DirtyStat.sample_pages;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;mode =3D dirtyrate_mode;<br>
<br>
@@ -264,7 +298,7 @@ static void init_dirtyrate_stat(int64_t start_time,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.dirty_rate =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.start_time =3D start_time;<br>
-=C2=A0 =C2=A0 DirtyStat.calc_time =3D config.sample_period_seconds;<br>
+=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D config.calc_time_ms;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.sample_pages =3D config.sample_pages_per_giga=
bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (config.mode) {<br>
@@ -574,7 +608,6 @@ static inline void dirtyrate_manual_reset_protect(void)=
<br>
<br>
=C2=A0static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig c=
onfig)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t start_time;<br>
=C2=A0 =C2=A0 =C2=A0DirtyPageRecord dirty_pages;<br>
<br>
@@ -602,9 +635,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct Dir=
tyRateConfig config)<br>
=C2=A0 =C2=A0 =C2=A0start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);<=
br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.start_time =3D start_time / 1000;<br>
<br>
-=C2=A0 =C2=A0 msec =3D config.sample_period_seconds * 1000;<br>
-=C2=A0 =C2=A0 msec =3D dirty_stat_wait(msec, start_time);<br>
-=C2=A0 =C2=A0 DirtyStat.calc_time =3D msec / 1000;<br>
+=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_=
ms, start_time);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * do two things.<br>
@@ -615,12 +646,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct D=
irtyRateConfig config)<br>
<br>
=C2=A0 =C2=A0 =C2=A0record_dirtypages_bitmap(&amp;dirty_pages, false);<br>
<br>
-=C2=A0 =C2=A0 DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages,=
 msec);<br>
+=C2=A0 =C2=A0 DirtyStat.dirty_rate =3D do_calculate_dirtyrate(dirty_pages,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DirtyStat.calc_time_ms);<br>
=C2=A0}<br>
<br>
=C2=A0static void calculate_dirtyrate_dirty_ring(struct DirtyRateConfig con=
fig)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int64_t duration;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t dirtyrate =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t dirtyrate_sum =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
@@ -631,12 +662,10 @@ static void calculate_dirtyrate_dirty_ring(struct Dir=
tyRateConfig config)<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_R=
EALTIME) / 1000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* calculate vcpu dirtyrate */<br>
-=C2=A0 =C2=A0 duration =3D vcpu_calculate_dirtyrate(config.sample_period_s=
econds * 1000,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;Dir=
tyStat.dirty_ring,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GLOBAL_D=
IRTY_DIRTY_RATE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true);<b=
r>
-<br>
-=C2=A0 =C2=A0 DirtyStat.calc_time =3D duration / 1000;<br>
+=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D vcpu_calculate_dirtyrate(config.c=
alc_time_ms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;DirtyStat.dirty_ring,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GLOBAL_DIRTY_DIRTY_RATE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* calculate vm dirtyrate */<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; DirtyStat.dirty_ring.nvcpu; i++) {=
<br>
@@ -652,7 +681,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyR=
ateConfig config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct RamblockDirtyInfo *block_dinfo =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int block_count =3D 0;<br>
-=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t initial_time;<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
@@ -662,17 +690,16 @@ static void calculate_dirtyrate_sample_vm(struct Dirt=
yRateConfig config)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
<br>
-=C2=A0 =C2=A0 msec =3D config.sample_period_seconds * 1000;<br>
-=C2=A0 =C2=A0 msec =3D dirty_stat_wait(msec, initial_time);<br>
+=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D dirty_stat_wait(config.calc_time_=
ms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0initial_time);<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.start_time =3D initial_time / 1000;<br>
-=C2=A0 =C2=A0 DirtyStat.calc_time =3D msec / 1000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0if (!compare_page_hash_info(block_dinfo, block_count)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 update_dirtyrate(msec);<br>
+=C2=A0 =C2=A0 update_dirtyrate(DirtyStat.calc_time_ms);<br>
<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
@@ -718,6 +745,8 @@ void *get_dirtyrate_thread(void *arg)<br>
=C2=A0}<br>
<br>
=C2=A0void qmp_calc_dirty_rate(int64_t calc_time,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool has_calc_time_unit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TimeUnit calc_time_unit,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool has_sample_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int64_t sample_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool has_mode,<br>
@@ -737,10 +766,15 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!is_sample_period_valid(calc_time)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;calc-time is out of ran=
ge[%d, %d].&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MIN_FETCH_DIRTYRATE_TIME_SEC,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MAX_FETCH_DIRTYRATE_TIME_SEC);<br>
+=C2=A0 =C2=A0 int64_t calc_time_ms =3D convert_time_unit(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_time,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_calc_time_unit ? calc_time_unit : TIME_UNI=
T_SECOND,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TIME_UNIT_MILLISECOND<br>
+=C2=A0 =C2=A0 );<br>
+<br>
+=C2=A0 =C2=A0 if (!is_calc_time_valid(calc_time_ms)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Calculation time is out=
 of range [%dms, %dms].&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -787,7 +821,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 config.sample_period_seconds =3D calc_time;<br>
+=C2=A0 =C2=A0 config.calc_time_ms =3D calc_time_ms;<br>
=C2=A0 =C2=A0 =C2=A0config.sample_pages_per_gigabytes =3D sample_pages;<br>
=C2=A0 =C2=A0 =C2=A0config.mode =3D mode;<br>
<br>
@@ -806,14 +840,18 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (void *)&amp;config, QEMU_THREAD_DETACHED);<br>
=C2=A0}<br>
<br>
-struct DirtyRateInfo *qmp_query_dirty_rate(Error **errp)<br>
+<br>
+struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0TimeUnit calc_time_unit,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return query_dirty_rate_info();<br>
+=C2=A0 =C2=A0 return query_dirty_rate_info(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_calc_time_unit ? calc_time_unit : TIME_UNI=
T_SECOND);<br>
=C2=A0}<br>
<br>
=C2=A0void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DirtyRateInfo *info =3D query_dirty_rate_info();<br>
+=C2=A0 =C2=A0 DirtyRateInfo *info =3D query_dirty_rate_info(TIME_UNIT_SECO=
ND);<br>
<br>
=C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;Status: %s\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Dirty=
RateStatus_str(info-&gt;status));<br>
@@ -873,8 +911,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict *qd=
ict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D DIRTY_RATE_MEASURE_MODE_DIRTY_RI=
NG;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, tru=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mode, &amp;err);<br>
+=C2=A0 =C2=A0 qmp_calc_dirty_rate(sec, /* calc-time */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 false, TIME_UNIT_SECOND, /* calc-time-unit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 has_sample_pages, sample_pages,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 true, mode,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hmp_handle_error(mon, err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Reviewed-by: Hyman H=
uang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a>=
&gt;</div></div><div><br></div><span class=3D"gmail_signature_prefix">-- </=
span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000d276310605033687--

