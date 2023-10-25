Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59C7D6829
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:19:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvayF-0004dP-DP; Wed, 25 Oct 2023 06:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvay1-0004co-0S
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaxk-0002j4-CR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698229085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7VjKh1y8lTdBc+ySQGALgpsk7qgR+xafGl6mAyQ1Vao=;
 b=gKmgOHVR31/opJr4QZOiT3HCANvFvwoXZc5CrKhwSBpi980QqRdDnwbW0RQ0alZ/ihf7S6
 8/3Q+5j413WHmDVYhVQCCpprAM0LkvktAaMrPNFaVMs9LMeKQ8lZTy06Qa/iFMhzXB+7tE
 amtZN7ydnaRlO20O8+Z8a2oQf9uBtR4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-BfWVOPrpMpq7a53EPwAcTQ-1; Wed,
 25 Oct 2023 06:18:02 -0400
X-MC-Unique: BfWVOPrpMpq7a53EPwAcTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 394B2282380A;
 Wed, 25 Oct 2023 10:18:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E03D492BFA;
 Wed, 25 Oct 2023 10:18:00 +0000 (UTC)
Date: Wed, 25 Oct 2023 11:17:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/29] tests/qtest: Move QTestMigrationState to libqtest
Message-ID: <ZTjrVt3IrUZa7P2u@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-3-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:35:41PM -0300, Fabiano Rosas wrote:
> Move the QTestMigrationState into QTestState so we don't have to pass
> it around to the wait_for_* helpers anymore. Since QTestState is
> private to libqtest.c, move the migration state struct to libqtest.h
> and add a getter.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/libqtest.c          | 14 ++++++++++
>  tests/qtest/libqtest.h          | 23 ++++++++++++++++
>  tests/qtest/migration-helpers.c | 18 +++++++++++++
>  tests/qtest/migration-helpers.h |  8 +++---
>  tests/qtest/migration-test.c    | 47 +++++++++------------------------
>  5 files changed, 72 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index f33a210861..f7e85486dc 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -87,6 +87,7 @@ struct QTestState
>      GList *pending_events;
>      QTestQMPEventCallback eventCB;
>      void *eventData;
> +    QTestMigrationState *migration_state;

It feels wrong to have something called MigrationState in the
general qtest code. In the end there's nothing particularly
migration related about this though.

With that in mind, we could just rename it to "QTestEventState"
instead.

>  };
>  
>  static GHookList abrt_hooks;
> @@ -500,6 +501,8 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>          s->irq_level[i] = false;
>      }
>  
> +    s->migration_state = g_new0(QTestMigrationState, 1);
> +
>      /*
>       * Stopping QEMU for debugging is not supported on Windows.
>       *
> @@ -601,6 +604,7 @@ void qtest_quit(QTestState *s)
>      close(s->fd);
>      close(s->qmp_fd);
>      g_string_free(s->rx, true);
> +    g_free(s->migration_state);
>  
>      for (GList *it = s->pending_events; it != NULL; it = it->next) {
>          qobject_unref((QDict *)it->data);
> @@ -854,6 +858,11 @@ void qtest_qmp_set_event_callback(QTestState *s,
>      s->eventData = opaque;
>  }
>  
> +void qtest_qmp_set_migration_callback(QTestState *s, QTestQMPEventCallback cb)
> +{
> +    qtest_qmp_set_event_callback(s, cb, s->migration_state);
> +}
> +
>  QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
>  {
>      while (s->pending_events) {
> @@ -1906,3 +1915,8 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
>  
>      return ret && !err;
>  }
> +
> +QTestMigrationState *qtest_migration_state(QTestState *s)
> +{
> +    return s->migration_state;
> +}
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 6e3d3525bf..0421a1da24 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -23,6 +23,20 @@
>  
>  typedef struct QTestState QTestState;
>  
> +struct QTestMigrationState {
> +    bool stop_seen;
> +    bool resume_seen;
> +};
> +typedef struct QTestMigrationState QTestMigrationState;
> +
> +/**
> + * qtest_migration_state:
> + * @s: #QTestState instance to operate on.
> + *
> + * Returns: #QTestMigrationState instance.
> + */
> +QTestMigrationState *qtest_migration_state(QTestState *s);
> +
>  /**
>   * qtest_initf:
>   * @fmt: Format for creating other arguments to pass to QEMU, formatted
> @@ -288,6 +302,15 @@ typedef bool (*QTestQMPEventCallback)(QTestState *s, const char *name,
>  void qtest_qmp_set_event_callback(QTestState *s,
>                                    QTestQMPEventCallback cb, void *opaque);
>  
> +/**
> + * qtest_qmp_set_migration_callback:
> + * @s: #QTestSTate instance to operate on
> + * @cb: callback to invoke for events
> + *
> + * Like qtest_qmp_set_event_callback, but includes migration state events
> + */
> +void qtest_qmp_set_migration_callback(QTestState *s, QTestQMPEventCallback cb);
> +
>  /**
>   * qtest_qmp_eventwait:
>   * @s: #QTestState instance to operate on.
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index fd3b94efa2..cffa525c81 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -92,6 +92,24 @@ void migrate_set_capability(QTestState *who, const char *capability,
>                               capability, value);
>  }
>  
> +void wait_for_stop(QTestState *who)
> +{
> +    QTestMigrationState *state = qtest_migration_state(who);
> +
> +    if (!state->stop_seen) {
> +        qtest_qmp_eventwait(who, "STOP");
> +    }
> +}
> +
> +void wait_for_resume(QTestState *who)
> +{
> +    QTestMigrationState *state = qtest_migration_state(who);
> +
> +    if (!state->resume_seen) {
> +        qtest_qmp_eventwait(who, "RESUME");
> +    }
> +}

I'd be included to put them into the libqtest.c file too eg

  qtest_wait_for_resume/qtst_wait_for_stop

> +
>  void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>  {
>      va_list ap;
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index c1d4c84995..7297f1ff2c 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -15,13 +15,13 @@
>  
>  #include "libqtest.h"
>  
> -typedef struct QTestMigrationState {
> -    bool stop_seen, resume_seen;
> -} QTestMigrationState;
> -
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
> +
> +void wait_for_stop(QTestState *who);
> +void wait_for_resume(QTestState *who);
> +
>  G_GNUC_PRINTF(3, 4)
>  void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
>  
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 0425d1d527..88e611e98f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -43,8 +43,6 @@
>  unsigned start_address;
>  unsigned end_address;
>  static bool uffd_feature_thread_id;
> -static QTestMigrationState src_state;
> -static QTestMigrationState dst_state;
>  
>  /*
>   * An initial 3 MB offset is used as that corresponds
> @@ -230,13 +228,6 @@ static void wait_for_serial(const char *side)
>      } while (true);
>  }
>  
> -static void wait_for_stop(QTestState *who, QTestMigrationState *state)
> -{
> -    if (!state->stop_seen) {
> -        qtest_qmp_eventwait(who, "STOP");
> -    }
> -}
> -
>  /*
>   * It's tricky to use qemu's migration event capability with qtest,
>   * events suddenly appearing confuse the qmp()/hmp() responses.
> @@ -290,8 +281,9 @@ static void read_blocktime(QTestState *who)
>  static void wait_for_migration_pass(QTestState *who)
>  {
>      uint64_t pass, prev_pass = 0, changes = 0;
> +    QTestMigrationState *state = qtest_migration_state(who);
>  
> -    while (changes < 2 && !src_state.stop_seen) {
> +    while (changes < 2 && !state->stop_seen) {
>          usleep(1000);
>          pass = get_migration_pass(who);
>          changes += (pass != prev_pass);
> @@ -622,7 +614,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  {
>      qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
>  
> -    wait_for_stop(from, &src_state);
> +    wait_for_stop(from);
>      qtest_qmp_eventwait(to, "RESUME");
>  }
>  
> @@ -757,9 +749,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          }
>      }
>  
> -    dst_state = (QTestMigrationState) { };
> -    src_state = (QTestMigrationState) { };
> -
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          memory_size = "150M";
>  
> @@ -849,9 +838,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   ignore_stderr);
>      if (!args->only_target) {
>          *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
> -        qtest_qmp_set_event_callback(*from,
> -                                     migrate_watch_for_events,
> -                                     &src_state);
> +        qtest_qmp_set_migration_callback(*from, migrate_watch_for_events);
>      }
>  
>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> @@ -870,9 +857,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
>      *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
> -    qtest_qmp_set_event_callback(*to,
> -                                 migrate_watch_for_events,
> -                                 &dst_state);
> +    qtest_qmp_set_migration_callback(*to, migrate_watch_for_events);
>  
>      /*
>       * Remove shmem file immediately to avoid memory leak in test failed case.
> @@ -1622,7 +1607,7 @@ static void test_precopy_common(MigrateCommon *args)
>           */
>          if (args->result == MIG_TEST_SUCCEED) {
>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> -            wait_for_stop(from, &src_state);
> +            wait_for_stop(from);
>              migrate_ensure_converge(from);
>          }
>      }
> @@ -1668,7 +1653,7 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> -            wait_for_stop(from, &src_state);
> +            wait_for_stop(from);
>  
>          } else {
>              wait_for_migration_complete(from);
> @@ -1682,10 +1667,7 @@ static void test_precopy_common(MigrateCommon *args)
>              qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>          }
>  
> -        if (!dst_state.resume_seen) {
> -            qtest_qmp_eventwait(to, "RESUME");
> -        }
> -
> +        wait_for_resume(to);
>          wait_for_serial("dest_serial");
>      }
>  
> @@ -1723,7 +1705,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>  
>      if (stop_src) {
>          qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> -        wait_for_stop(from, &src_state);
> +        wait_for_stop(from);
>      }
>  
>      if (args->result == MIG_TEST_QMP_ERROR) {
> @@ -1745,10 +1727,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>          qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>      }
>  
> -    if (!dst_state.resume_seen) {
> -        qtest_qmp_eventwait(to, "RESUME");
> -    }
> -
> +    wait_for_resume(to);
>      wait_for_serial("dest_serial");
>  
>  finish:
> @@ -1866,7 +1845,7 @@ static void test_ignore_shared(void)
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> -    wait_for_stop(from, &src_state);
> +    wait_for_stop(from);
>  
>      qtest_qmp_eventwait(to, "RESUME");
>  
> @@ -2376,7 +2355,7 @@ static void test_migrate_auto_converge(void)
>              break;
>          }
>          usleep(20);
> -        g_assert_false(src_state.stop_seen);
> +        g_assert_false(qtest_migration_state(from)->stop_seen);
>      } while (true);
>      /* The first percentage of throttling should be at least init_pct */
>      g_assert_cmpint(percentage, >=, init_pct);
> @@ -2715,7 +2694,7 @@ static void test_multifd_tcp_cancel(void)
>  
>      migrate_ensure_converge(from);
>  
> -    wait_for_stop(from, &src_state);
> +    wait_for_stop(from);
>      qtest_qmp_eventwait(to2, "RESUME");
>  
>      wait_for_serial("dest_serial");
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


