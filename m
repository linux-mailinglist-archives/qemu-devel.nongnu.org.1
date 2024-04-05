Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A436899608
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Apr 2024 08:57:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsdVP-0007P5-HE; Fri, 05 Apr 2024 02:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rsdVN-0007Ow-5o
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 02:56:53 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rsdV9-0000YA-A3
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 02:56:52 -0400
Received: from [10.12.10.172] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id 74B314076735;
 Fri,  5 Apr 2024 06:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 74B314076735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1712300196;
 bh=tNcRi1/5tlwm+2DyquaIgvriK5FOHldO1s2F0sDZgjU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=stjESF3WopvRsiTFP8reYGwg5GbLchlVNMIE2GsAS9zkIQ/Zb83/Jaaa6o8vREy+o
 KId2YzqOO7d7e7lNDDxh7mpNTb6VPUFPezBg2Ev1eZQAWByo6dyKq8q26kB6Hi3OOo
 KHQ8hnWUbOurtErjmEVmMweKzhW2gjP+KEoUkBdM=
Message-ID: <9a91fde9-e851-41e5-a51b-ad4f617ecba7@ispras.ru>
Date: Fri, 5 Apr 2024 09:56:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/24] replay: simple auto-snapshot mode for record
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-21-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240318154621.2361161-21-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 18.03.2024 18:46, Nicholas Piggin wrote:
> record makes an initial snapshot when the machine is created, to enable
> reverse-debugging. Often the issue being debugged appears near the end of
> the trace, so it is important for performance to keep snapshots close to
> the end.
> 
> This implements a periodic snapshot mode that keeps a rolling set of
> recent snapshots. This could be done by the debugger or other program
> that talks QMP, but for setting up simple scenarios and tests, this is
> more convenient.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   docs/system/replay.rst   |  5 ++++
>   include/sysemu/replay.h  | 11 ++++++++
>   replay/replay-snapshot.c | 57 ++++++++++++++++++++++++++++++++++++++++
>   replay/replay.c          | 27 +++++++++++++++++--
>   system/vl.c              |  9 +++++++
>   qemu-options.hx          |  9 +++++--
>   6 files changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/replay.rst b/docs/system/replay.rst
> index ca7c17c63d..1ae8614475 100644
> --- a/docs/system/replay.rst
> +++ b/docs/system/replay.rst
> @@ -156,6 +156,11 @@ for storing VM snapshots. Here is the example of the command line for this:
>   ``empty.qcow2`` drive does not connected to any virtual block device and used
>   for VM snapshots only.
>   
> +``rrsnapmode`` can be used to select just an initial snapshot or periodic
> +snapshots, with ``rrsnapcount`` specifying the number of periodic snapshots
> +to maintain, and ``rrsnaptime`` the amount of run time in seconds between
> +periodic snapshots.
> +
>   .. _network-label:
>   
>   Network devices
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 8102fa54f0..92fa82842b 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -48,6 +48,17 @@ typedef enum ReplayCheckpoint ReplayCheckpoint;
>   
>   typedef struct ReplayNetState ReplayNetState;
>   
> +enum ReplaySnapshotMode {
> +    REPLAY_SNAPSHOT_MODE_INITIAL,
> +    REPLAY_SNAPSHOT_MODE_PERIODIC,
> +};
> +typedef enum ReplaySnapshotMode ReplaySnapshotMode;
> +
> +extern ReplaySnapshotMode replay_snapshot_mode;
> +
> +extern uint64_t replay_snapshot_periodic_delay;
> +extern int replay_snapshot_periodic_nr_keep;

Please put the internal variables and enum into the replay-internal.h

> +
>   /* Name of the initial VM snapshot */
>   extern char *replay_snapshot;
>   
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index ccb4d89dda..762555feaa 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -70,6 +70,53 @@ void replay_vmstate_register(void)
>       vmstate_register(NULL, 0, &vmstate_replay, &replay_state);
>   }
>   
> +static QEMUTimer *replay_snapshot_timer;
> +static int replay_snapshot_count;
> +
> +static void replay_snapshot_timer_cb(void *opaque)
> +{
> +    Error *err = NULL;
> +    char *name;
> +
> +    if (!replay_can_snapshot()) {
> +        /* Try again soon */
> +        timer_mod(replay_snapshot_timer,
> +                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> +                  replay_snapshot_periodic_delay / 10);
> +        return;
> +    }
> +
> +    name = g_strdup_printf("%s-%d", replay_snapshot, replay_snapshot_count);
> +    if (!save_snapshot(name,
> +                       true, NULL, false, NULL, &err)) {
> +        error_report_err(err);
> +        error_report("Could not create periodic snapshot "
> +                     "for icount record, disabling");
> +        g_free(name);
> +        return;
> +    }
> +    g_free(name);
> +    replay_snapshot_count++;
> +
> +    if (replay_snapshot_periodic_nr_keep >= 1 &&
> +        replay_snapshot_count > replay_snapshot_periodic_nr_keep) {
> +        int del_nr;
> +
> +        del_nr = replay_snapshot_count - replay_snapshot_periodic_nr_keep - 1;
> +        name = g_strdup_printf("%s-%d", replay_snapshot, del_nr);
> +        if (!delete_snapshot(name, false, NULL, &err)) {
> +            error_report_err(err);
> +            error_report("Could not delete periodic snapshot "
> +                         "for icount record");
> +        }
> +        g_free(name);
> +    }
> +
> +    timer_mod(replay_snapshot_timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> +              replay_snapshot_periodic_delay);
> +}
> +
>   void replay_vmstate_init(void)
>   {
>       Error *err = NULL;
> @@ -82,6 +129,16 @@ void replay_vmstate_init(void)
>                   error_report("Could not create snapshot for icount record");
>                   exit(1);
>               }
> +
> +            if (replay_snapshot_mode == REPLAY_SNAPSHOT_MODE_PERIODIC) {
> +                replay_snapshot_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> +                                                     replay_snapshot_timer_cb,
> +                                                     NULL);
> +                timer_mod(replay_snapshot_timer,
> +                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> +                          replay_snapshot_periodic_delay);
> +            }
> +
>           } else if (replay_mode == REPLAY_MODE_PLAY) {
>               if (!load_snapshot(replay_snapshot, NULL, false, NULL, &err)) {
>                   error_report_err(err);
> diff --git a/replay/replay.c b/replay/replay.c
> index 895fa6b67a..c916e71d30 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -29,6 +29,10 @@
>   ReplayMode replay_mode = REPLAY_MODE_NONE;
>   char *replay_snapshot;
>   
> +ReplaySnapshotMode replay_snapshot_mode;
> +uint64_t replay_snapshot_periodic_delay;
> +int replay_snapshot_periodic_nr_keep;
> +
>   /* Name of replay file  */
>   static char *replay_filename;
>   ReplayState replay_state;
> @@ -424,6 +428,27 @@ void replay_configure(QemuOpts *opts)
>       }
>   
>       replay_snapshot = g_strdup(qemu_opt_get(opts, "rrsnapshot"));
> +    if (replay_snapshot && mode == REPLAY_MODE_RECORD) {
> +        const char *snapmode;
> +
> +        snapmode = qemu_opt_get(opts, "rrsnapmode");
> +        if (!snapmode || !strcmp(snapmode, "initial")) {
> +            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_INITIAL;
> +        } else if (!strcmp(snapmode, "periodic")) {
> +            replay_snapshot_mode = REPLAY_SNAPSHOT_MODE_PERIODIC;
> +        } else {
> +            error_report("Invalid rrsnapmode option: %s", snapmode);
> +            exit(1);
> +        }
> +
> +        /* Default 10 host seconds of machine runtime per snapshot. */
> +        replay_snapshot_periodic_delay =
> +                           qemu_opt_get_number(opts, "rrsnaptime", 10) * 1000;
> +
> +        /* Default 2, to cover at least the last 10 host seconds of runtime. */
> +        replay_snapshot_periodic_nr_keep =
> +                           qemu_opt_get_number(opts, "rrsnapcount", 2);
> +    }
>       replay_vmstate_register();
>       replay_enable(fname, mode);
>   
> @@ -446,8 +471,6 @@ void replay_start(void)
>           exit(1);
>       }
>   
> -    /* Timer for snapshotting will be set up here. */
> -
>       replay_enable_events();
>   }
>   
> diff --git a/system/vl.c b/system/vl.c
> index 70f4cece7f..8070cee6da 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -447,6 +447,15 @@ static QemuOptsList qemu_icount_opts = {
>           }, {
>               .name = "rrsnapshot",
>               .type = QEMU_OPT_STRING,
> +        }, {
> +            .name = "rrsnapmode",
> +            .type = QEMU_OPT_STRING,
> +        }, {
> +            .name = "rrsnaptime",
> +            .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "rrsnapcount",
> +            .type = QEMU_OPT_NUMBER,
>           },
>           { /* end of list */ }
>       },
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 7fd1713fa8..51f2498f12 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4665,13 +4665,13 @@ SRST
>   ERST
>   
>   DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
> -    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>]]\n" \
> +    "-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=<filename>[,rrsnapshot=<snapshot>][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]\n" \
>       "                enable virtual instruction counter with 2^N clock ticks per\n" \
>       "                instruction, enable aligning the host and virtual clocks\n" \
>       "                or disable real time cpu sleeping, and optionally enable\n" \
>       "                record-and-replay mode\n", QEMU_ARCH_ALL)
>   SRST
> -``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot]]``
> +``-icount [shift=N|auto][,align=on|off][,sleep=on|off][,rr=record|replay,rrfile=filename[,rrsnapshot=snapshot][,rrsnapmode=initial|periodic][,rrsnaptime=secs][,rrsnapcount=N]]``
>       Enable virtual instruction counter. The virtual cpu will execute one
>       instruction every 2^N ns of virtual time. If ``auto`` is specified
>       then the virtual cpu speed will be automatically adjusted to keep
> @@ -4713,6 +4713,11 @@ SRST
>       name. In record mode, a new VM snapshot with the given name is created
>       at the start of execution recording. In replay mode this option
>       specifies the snapshot name used to load the initial VM state.
> +    ``rrsnapmode=periodic`` will additionally cause a periodic snapshot to
> +    be created after ``rrsnaptime=secs`` seconds of real runtime. The last
> +    ``rrsnapcount=N`` periodic snapshots (not including the initial) will
> +    be kept (0 for infinite). Periodic snapshots are useful to speed
> +    reverse debugging operations near the end of the recorded trace.
>   ERST
>   
>   DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \


