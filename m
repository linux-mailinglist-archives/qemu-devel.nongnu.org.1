Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 996E87713BA
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 08:20:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSX6V-0001z8-1A; Sun, 06 Aug 2023 02:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qSX6S-0001yb-5b
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:19:00 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qSX6N-0001gj-Km
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:18:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-26837895fbbso2433362a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 23:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691302611; x=1691907411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HwRp0iQ9VC/T26qCFrCFgI4AHBhG5tzKaJpRzIWjz90=;
 b=0aCTBv8iAhhBMcIXdnLHWOigTc2y43FBY09/tnAnnNQrXUn/p5Pp3Rwf3hMc8oQ23z
 E8lJul4YU6Tr5ijJs0czbFflHGwDMqoi50A2gKYg4lsFZx+lFITUHVFcdiAtUWst5Oop
 +nRQLA8GZijgw2+ErU8A3y3DNzRe7bQ0T4KrfduIn/OCLrZiOUiPuxwqogUhDdGB4Tpo
 uhaMRFpKuDF684Ay+WtjvzFTDqBueD/ElvZrRs0ZWahWuTJm8Y2eRwqQHywNP3MyW1hQ
 syIRsOgXQ4ywMcwdiGdW8Od37SrE9u4ruvlptiHraak2O9/UTjRyI9vvrS7Ba80KraML
 IV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691302611; x=1691907411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HwRp0iQ9VC/T26qCFrCFgI4AHBhG5tzKaJpRzIWjz90=;
 b=aTQiFwr2p04ZnRijjZykkPONUbtitcQ1MWHMBHHJ6+YSPOPLuw/FwtZF3gah461lJr
 q5INZeyP4jdbWN3YWoT2rPyO1MZbfxVSpQSukQuRIoTcqQ0nG/gCN7sVAJlIyV5g7jLK
 C79bxyTjJAS/MZy2tSoNEvt3JFooswKNQQzDeWr1383UquLt1/yPr9rB5OxptUERj0sn
 y58AqquCazsJs1Sd4NydhiXnNL5DQhiKiZ4zLUFFgOh6/VX7+J+PsbSHzZnKt8PKD8EL
 EfPTKH1fTCP7Zm2sP0oHb2mI61vrMZO6xbVKWpp6WT+Okid2OGUAQwCwkVUFzmQLcATQ
 Qh/g==
X-Gm-Message-State: AOJu0YwBRrfPutEBn7wASmqqpUSeiSOg4A0nM4XKUHya93CvtXPiGt9v
 mfGLjLUFgCImK+srx+b5/PacKZsN0WOatPDMcqge1g==
X-Google-Smtp-Source: AGHT+IGM09emoQmm0WPR839Az/kHvc5loRbZNkMz5CpJOoxMvCerH0r7yqNAMDzTVBruqNA1Vnvn3qfpeP8vixeXoyI=
X-Received: by 2002:a17:90b:4f48:b0:268:b64b:f684 with SMTP id
 pj8-20020a17090b4f4800b00268b64bf684mr5649797pjb.33.1691302611058; Sat, 05
 Aug 2023 23:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
In-Reply-To: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 6 Aug 2023 14:16:34 +0800
Message-ID: <CAK9dgmbnBL2sSoUm0cgdySsA0PqAJc0yR1750-yp1eVssQ-UMw@mail.gmail.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005719b806023b1386"
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102a.google.com
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

--0000000000005719b806023b1386
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 4, 2023 at 11:03=E2=80=AFPM Andrei Gudkov <gudkov.andrei@huawei=
.com>
wrote:

> Introduces alternative argument calc-time-ms, which is the
> the same as calc-time but accepts millisecond value.
> Millisecond granularity allows to make predictions whether
> migration will succeed or not. To do this, calculate dirty
> rate with calc-time-ms set to max allowed downtime, convert
> measured rate into volume of dirtied memory, and divide by
> network throughput. If the value is lower than max allowed
>
Not for the patch, I'm just curious about how the predication
decides the network throughput, I mean QEMU predicts
if migration will converge based on how fast it sends the data,
not the actual bandwidth of the interface, which one the
prediction uses?

> downtime, then migration will converge.
>
> Measurement results for single thread randomly writing to
> a 1/4/24GiB memory region:
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
> where size is in bytes, time is in seconds, and wps is number of
> writes per second.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/migration.json   | 14 ++++++--
>  migration/dirtyrate.h | 12 ++++---
>  migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
>  3 files changed, 67 insertions(+), 40 deletions(-)
>
> [...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59..82493d6a57 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1849,7 +1849,11 @@
>  # @start-time: start time in units of second for calculation
>  #
>  # @calc-time: time period for which dirty page rate was measured
> -#     (in seconds)
> +#     (rounded down to seconds).
>
Does there need an extra comment to emphasize that calc-time shows
zero if the calc-time-ms is lower than 1000?

> +#
> +# @calc-time-ms: actual time period for which dirty page rate was
> +#     measured (in milliseconds).  Value may be larger than requested
> +#     time period due to measurement overhead.
>  #
>  # @sample-pages: number of sampled pages per GiB of guest memory.
>  #     Valid only in page-sampling mode (Since 6.1)
> @@ -1866,6 +1870,7 @@
>             'status': 'DirtyRateStatus',
>             'start-time': 'int64',
>             'calc-time': 'int64',
> +           'calc-time-ms': 'int64',
>             'sample-pages': 'uint64',
>             'mode': 'DirtyRateMeasureMode',
>             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> @@ -1908,6 +1913,10 @@
>  #     dirty during @calc-time period, further writes to this page will
>  #     not increase dirty page rate anymore.
>  #
> +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> +#    two arguments are mutually exclusive.  Exactly one of them must
> +#    be specified. (Since 8.1)
> +#
>  # @sample-pages: number of sampled pages per each GiB of guest memory.
>  #     Default value is 512.  For 4KiB guest pages this corresponds to
>  #     sampling ratio of 0.2%.  This argument is used only in page
> @@ -1925,7 +1934,8 @@
>  #                                                 'sample-pages': 512} }
>  # <- { "return": {} }
>  ##
> -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> +                                         '*calc-time-ms': 'int64',
>                                           '*sample-pages': 'int',
>                                           '*mode': 'DirtyRateMeasureMode'=
}
> }
>
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

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 84f1b0fb20..90fb336329 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_t
> initial_time)
>          msec =3D current_time - initial_time;
>      } else {
>          g_usleep((msec + initial_time - current_time) * 1000);
> +        /* g_usleep may overshoot */
> +        msec =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - initial_time;
>
The optimization could be a standalone commit along with the content
below(see the following comment)?

>      }
>
>      return msec;
> @@ -77,9 +79,12 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord
> dirty_pages,
>  {
>      uint64_t increased_dirty_pages =3D
>          dirty_pages.end_pages - dirty_pages.start_pages;
> -    uint64_t memory_size_MiB =3D
> qemu_target_pages_to_MiB(increased_dirty_pages);
> -
> -    return memory_size_MiB * 1000 / calc_time_ms;
> +    /*
> +     * multiply by 1000ms/s _before_ converting down to megabytes
> +     * to avoid losing precision
> +     */
> +    return qemu_target_pages_to_MiB(increased_dirty_pages * 1000) /
> +        calc_time_ms;
>
Code optimization, could be in a standalone commit.

>  }
>
>  void global_dirty_log_change(unsigned int flag, bool start)
> @@ -183,10 +188,9 @@ retry:
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
> @@ -219,7 +223,8 @@ static struct DirtyRateInfo
> *query_dirty_rate_info(void)
>
>      info->status =3D CalculatingState;
>      info->start_time =3D DirtyStat.start_time;
> -    info->calc_time =3D DirtyStat.calc_time;
> +    info->calc_time_ms =3D DirtyStat.calc_time_ms;
> +    info->calc_time =3D DirtyStat.calc_time_ms / 1000;
>      info->sample_pages =3D DirtyStat.sample_pages;
>      info->mode =3D dirtyrate_mode;
>
> @@ -258,7 +263,7 @@ static void init_dirtyrate_stat(int64_t start_time,
>  {
>      DirtyStat.dirty_rate =3D -1;
>      DirtyStat.start_time =3D start_time;
> -    DirtyStat.calc_time =3D config.sample_period_seconds;
> +    DirtyStat.calc_time_ms =3D config.calc_time_ms;
>      DirtyStat.sample_pages =3D config.sample_pages_per_gigabytes;
>
>      switch (config.mode) {
> @@ -568,7 +573,6 @@ static inline void dirtyrate_manual_reset_protect(voi=
d)
>
>  static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig
> config)
>  {
> -    int64_t msec =3D 0;
>      int64_t start_time;
>      DirtyPageRecord dirty_pages;
>
> @@ -596,9 +600,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct
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
> @@ -609,12 +611,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct
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
> @@ -625,12 +627,10 @@ static void calculate_dirtyrate_dirty_ring(struct
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
> @@ -646,7 +646,6 @@ static void calculate_dirtyrate_sample_vm(struct
> DirtyRateConfig config)
>  {
>      struct RamblockDirtyInfo *block_dinfo =3D NULL;
>      int block_count =3D 0;
> -    int64_t msec =3D 0;
>      int64_t initial_time;
>
>      rcu_read_lock();
> @@ -656,17 +655,16 @@ static void calculate_dirtyrate_sample_vm(struct
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
> @@ -711,7 +709,10 @@ void *get_dirtyrate_thread(void *arg)
>      return NULL;
>  }
>
> -void qmp_calc_dirty_rate(int64_t calc_time,
> +void qmp_calc_dirty_rate(bool has_calc_time,
> +                         int64_t calc_time,
> +                         bool has_calc_time_ms,
> +                         int64_t calc_time_ms,
>                           bool has_sample_pages,
>                           int64_t sample_pages,
>                           bool has_mode,
> @@ -731,10 +732,21 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>          return;
>      }
>
> -    if (!is_sample_period_valid(calc_time)) {
> -        error_setg(errp, "calc-time is out of range[%d, %d].",
> -                         MIN_FETCH_DIRTYRATE_TIME_SEC,
> -                         MAX_FETCH_DIRTYRATE_TIME_SEC);
> +    if ((int)has_calc_time + (int)has_calc_time_ms !=3D 1) {
> +        error_setg(errp, "Exactly one of calc-time and calc-time-ms must=
"
> +                         " be specified");
> +        return;
> +    }
> +    if (has_calc_time) {
> +        /*
> +         * The worst thing that can happen due to overflow is that
> +         * invalid value will become valid.
> +         */
> +        calc_time_ms =3D calc_time * 1000;
> +    }
> +    if (!is_calc_time_valid(calc_time_ms)) {
> +        error_setg(errp, "Calculation time is out of range[%dms, %dms]."=
,
> +                         MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);
>          return;
>      }
>
> @@ -781,7 +793,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>          return;
>      }
>
> -    config.sample_period_seconds =3D calc_time;
> +    config.calc_time_ms =3D calc_time_ms;
>      config.sample_pages_per_gigabytes =3D sample_pages;
>      config.mode =3D mode;
>
> @@ -867,8 +879,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict
> *qdict)
>          mode =3D DIRTY_RATE_MEASURE_MODE_DIRTY_RING;
>      }
>
> -    qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, true,
> -                        mode, &err);
> +    qmp_calc_dirty_rate(true, sec, /* calc_time */
> +                        false, 0, /* calc_time_ms */
> +                        has_sample_pages, sample_pages,
> +                        true, mode,
> +                        &err);
>      if (err) {
>          hmp_handle_error(mon, err);
>          return;
> --
> 2.30.2
>
> The patch set works for me, and I'm inclined to split it into two commits
as I point out above.

Thanks

Yong

--=20
Best regards

--0000000000005719b806023b1386
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 4, 202=
3 at 11:03=E2=80=AFPM Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@hua=
wei.com">gudkov.andrei@huawei.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
Introduces alternative argument calc-time-ms, which is the<br>
the same as calc-time but accepts millisecond value.<br>
Millisecond granularity allows to make predictions whether<br>
migration will succeed or not. To do this, calculate dirty<br>
rate with calc-time-ms set to max allowed downtime, convert<br>
measured rate into volume of dirtied memory, and divide by<br>
network throughput. If the value is lower than max allowed<br></blockquote>=
<div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">Not for the patch, I&#39;m just curious about how the predicat=
ion</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">decides the network throughput, I mean QEMU predicts<=
/div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif">if migration will converge based on how fast it sends the=
 data,</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">not the actual bandwidth of the interface, which o=
ne the</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif">prediction uses?</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
downtime, then migration will converge.<br>
<br>
Measurement results for single thread randomly writing to<br>
a 1/4/24GiB memory region:<br>
<br>
+--------------+-----------------------------------------------+<br>
| calc-time-ms |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dir=
ty rate MiB/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +----------------+-------=
--------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | theoretical=C2=A0 =C2=
=A0 | page-sampling | dirty-bitmap |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (at 3M wr/sec) |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7100 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A03192 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A04606 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4660 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02655 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A03305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3280 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02371 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A02534 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2525 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02154 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2044 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01871 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01365 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1341 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01358 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1052 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01025 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0678 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 684 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 512 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0507 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 513 |<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 10232 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8880 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A04070 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A08954 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8049 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A03195 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A07889 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7193 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02881 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6530 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02700 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A06245 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5772 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02312 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A04829 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4586 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02465 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A03865 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3780 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02178 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A02694 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2633 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02004 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2031 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01789 |<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
+--------------+----------------+---------------+--------------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 11495 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8640 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05597 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 11226 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8616 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03527 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 10965 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8386 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02355 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 10713 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8370 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02179 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 10469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8196 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02098 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A09890 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7885 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02556 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A09354 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7506 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02084 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A08397 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6944 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02075 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A07574 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6402 |=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02062 |<br>
+--------------+----------------+---------------+--------------+<br>
<br>
Theoretical values are computed according to the following formula:<br>
size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),<br>
where size is in bytes, time is in seconds, and wps is number of<br>
writes per second.<br>
<br>
Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huawei.com=
" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
---<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0| 14 ++++++--<br>
=C2=A0migration/dirtyrate.h | 12 ++++---<br>
=C2=A0migration/dirtyrate.c | 81 +++++++++++++++++++++++++-----------------=
-<br>
=C2=A03 files changed, 67 insertions(+), 40 deletions(-)<br>
<br></blockquote><div><span style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif">[...]</span>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 8843e74b59..82493d6a57 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -1849,7 +1849,11 @@<br>
=C2=A0# @start-time: start time in units of second for calculation<br>
=C2=A0#<br>
=C2=A0# @calc-time: time period for which dirty page rate was measured<br>
-#=C2=A0 =C2=A0 =C2=A0(in seconds)<br>
+#=C2=A0 =C2=A0 =C2=A0(rounded down to seconds).<br></blockquote><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Does there need an extra comment to emphasize that calc-time shows</div>=
<div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;=
,sans-serif">zero if the calc-time-ms is lower than 1000?</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
+#<br>
+# @calc-time-ms: actual time period for which dirty page rate was<br>
+#=C2=A0 =C2=A0 =C2=A0measured (in milliseconds).=C2=A0 Value may be larger=
 than requested<br>
+#=C2=A0 =C2=A0 =C2=A0time period due to measurement overhead.<br>
=C2=A0#<br>
=C2=A0# @sample-pages: number of sampled pages per GiB of guest memory.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Valid only in page-sampling mode (Since 6.1)<br>
@@ -1866,6 +1870,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;status&#39;: &#39;DirtyRateS=
tatus&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;start-time&#39;: &#39;int64&=
#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;calc-time&#39;: &#39;int64&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time-ms&#39;: &#39;int6=
4&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;sample-pages&#39;: &#39;uint=
64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mode&#39;: &#39;DirtyRateMea=
sureMode&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vcpu-dirty-rate&#39;: [ &#3=
9;DirtyRateVcpu&#39; ] } }<br>
@@ -1908,6 +1913,10 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0dirty during @calc-time period, further writes t=
o this page will<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0not increase dirty page rate anymore.<br>
=C2=A0#<br>
+# @calc-time-ms: the same as @calc-time but in milliseconds.=C2=A0 These<b=
r>
+#=C2=A0 =C2=A0 two arguments are mutually exclusive.=C2=A0 Exactly one of =
them must<br>
+#=C2=A0 =C2=A0 be specified. (Since 8.1)<br>
+#<br>
=C2=A0# @sample-pages: number of sampled pages per each GiB of guest memory=
.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Default value is 512.=C2=A0 For 4KiB guest pages=
 this corresponds to<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0sampling ratio of 0.2%.=C2=A0 This argument is u=
sed only in page<br>
@@ -1925,7 +1934,8 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;: 512} }<br>
=C2=A0# &lt;- { &quot;return&quot;: {} }<br>
=C2=A0##<br>
-{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: {&#39;calc=
-time&#39;: &#39;int64&#39;,<br>
+{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: {&#39;*cal=
c-time&#39;: &#39;int64&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#=
39;*calc-time-ms&#39;: &#39;int64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;*sample-pages&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;*mode&#39;: &#39;DirtyRateMeasureMode&#39;} }<br>
<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SampleVMStat page_sampling;</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pa=
dding-left:1ex">
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 84f1b0fb20..90fb336329 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -57,6 +57,8 @@ static int64_t dirty_stat_wait(int64_t msec, int64_t init=
ial_time)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msec =3D current_time - initial_time;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_usleep((msec + initial_time - current_t=
ime) * 1000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* g_usleep may overshoot */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msec =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME=
) - initial_time;<br></blockquote><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">The optimization could be a =
standalone commit along with the content below(see the following comment)?<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return msec;<br>
@@ -77,9 +79,12 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord di=
rty_pages,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t increased_dirty_pages =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirty_pages.end_pages - dirty_pages.start=
_pages;<br>
-=C2=A0 =C2=A0 uint64_t memory_size_MiB =3D qemu_target_pages_to_MiB(increa=
sed_dirty_pages);<br>
-<br>
-=C2=A0 =C2=A0 return memory_size_MiB * 1000 / calc_time_ms;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* multiply by 1000ms/s _before_ converting down to meg=
abytes<br>
+=C2=A0 =C2=A0 =C2=A0* to avoid losing precision<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return qemu_target_pages_to_MiB(increased_dirty_pages * 1000=
) /<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_time_ms;<br></blockquote><div class=3D"gm=
ail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Cod=
e optimization, could be in a standalone commit.</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0void global_dirty_log_change(unsigned int flag, bool start)<br>
@@ -183,10 +188,9 @@ retry:<br>
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
@@ -219,7 +223,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;status =3D CalculatingState;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;start_time =3D DirtyStat.start_time;<br>
-=C2=A0 =C2=A0 info-&gt;calc_time =3D DirtyStat.calc_time;<br>
+=C2=A0 =C2=A0 info-&gt;calc_time_ms =3D DirtyStat.calc_time_ms;<br>
+=C2=A0 =C2=A0 info-&gt;calc_time =3D DirtyStat.calc_time_ms / 1000;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;sample_pages =3D DirtyStat.sample_pages;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;mode =3D dirtyrate_mode;<br>
<br>
@@ -258,7 +263,7 @@ static void init_dirtyrate_stat(int64_t start_time,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.dirty_rate =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.start_time =3D start_time;<br>
-=C2=A0 =C2=A0 DirtyStat.calc_time =3D config.sample_period_seconds;<br>
+=C2=A0 =C2=A0 DirtyStat.calc_time_ms =3D config.calc_time_ms;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.sample_pages =3D config.sample_pages_per_giga=
bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (config.mode) {<br>
@@ -568,7 +573,6 @@ static inline void dirtyrate_manual_reset_protect(void)=
<br>
<br>
=C2=A0static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig c=
onfig)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t start_time;<br>
=C2=A0 =C2=A0 =C2=A0DirtyPageRecord dirty_pages;<br>
<br>
@@ -596,9 +600,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct Dir=
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
@@ -609,12 +611,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct D=
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
@@ -625,12 +627,10 @@ static void calculate_dirtyrate_dirty_ring(struct Dir=
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
@@ -646,7 +646,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyR=
ateConfig config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct RamblockDirtyInfo *block_dinfo =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int block_count =3D 0;<br>
-=C2=A0 =C2=A0 int64_t msec =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t initial_time;<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
@@ -656,17 +655,16 @@ static void calculate_dirtyrate_sample_vm(struct Dirt=
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
@@ -711,7 +709,10 @@ void *get_dirtyrate_thread(void *arg)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-void qmp_calc_dirty_rate(int64_t calc_time,<br>
+void qmp_calc_dirty_rate(bool has_calc_time,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int64_t calc_time,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool has_calc_time_ms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int64_t calc_time_ms,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool has_sample_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int64_t sample_pages,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bool has_mode,<br>
@@ -731,10 +732,21 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
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
+=C2=A0 =C2=A0 if ((int)has_calc_time + (int)has_calc_time_ms !=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Exactly one of calc-tim=
e and calc-time-ms must&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot; be specified&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (has_calc_time) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The worst thing that can happen due to=
 overflow is that<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* invalid value will become valid.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 calc_time_ms =3D calc_time * 1000;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!is_calc_time_valid(calc_time_ms)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Calculation time is out=
 of range[%dms, %dms].&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MIN_CALC_TIME_MS, MAX_CALC_TIME_MS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -781,7 +793,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 config.sample_period_seconds =3D calc_time;<br>
+=C2=A0 =C2=A0 config.calc_time_ms =3D calc_time_ms;<br>
=C2=A0 =C2=A0 =C2=A0config.sample_pages_per_gigabytes =3D sample_pages;<br>
=C2=A0 =C2=A0 =C2=A0config.mode =3D mode;<br>
<br>
@@ -867,8 +879,11 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict *qd=
ict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode =3D DIRTY_RATE_MEASURE_MODE_DIRTY_RI=
NG;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qmp_calc_dirty_rate(sec, has_sample_pages, sample_pages, tru=
e,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mode, &amp;err);<br>
+=C2=A0 =C2=A0 qmp_calc_dirty_rate(true, sec, /* calc_time */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 false, 0, /* calc_time_ms */<br>
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
</blockquote></div><div class=3D"gmail_default" style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">The patch set works for me, and I&#39;m inc=
lined to split it into two commits as I point out above.=C2=A0</div><br cle=
ar=3D"all"><div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">Thanks</div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Yong</div><br></div><span class=3D"gmail_signature_prefix">-- </span><br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"=
comic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000005719b806023b1386--

