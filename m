Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708078D7C0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 19:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbOZ3-0004Y5-B3; Wed, 30 Aug 2023 13:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOYu-0004XY-2j
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbOYr-0006Ea-CH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693414855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebz9NGAa4aEubbZ8tN708KaoQfL2ZIhvmG/EcN9+JYs=;
 b=QZJgnZxaib6qHGGhZsVWUa4HQhO41L1u2dE73J5vWaN00AN6RuVjlaB9+Mlv6mMhkNL02C
 IoKbaD/hULDN6BBtqRtxJVzzaPDoF9FpIR7AdPfovZWgz5+BT/QID0SLLppfF2o1g7cvFd
 6ND4WSixUv+wcMlIRo7028qlsgF0U6I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-pM4aEH77O-uvPGG7tO4JpA-1; Wed, 30 Aug 2023 13:00:51 -0400
X-MC-Unique: pM4aEH77O-uvPGG7tO4JpA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76f191e26f5so74084885a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 10:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693414846; x=1694019646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebz9NGAa4aEubbZ8tN708KaoQfL2ZIhvmG/EcN9+JYs=;
 b=WlbgWm147ZJ5afiUIUkq+ICDMH7q8VNiWlkaYg6MVzBPw0Ss0t28zL5o65sotNGuBa
 eeBr5eRD30bhme1aqGAu8cM5EBjU7ogA8sAMzNQ8eZHMa8LNfO5yvX+BS2UCWu4kCBbg
 QwOhCKf97s5iqEOBFpcF5TnyGvc9vSNflk02zYw2K39rzjkSwC5tt/sHYG32FexPv8iT
 36L/vTIV8D5JsXIIZQX+gMPpqLLGQShUOo+A4rKVluhd8IXbNl8a2sTiMDySVQbcRhmQ
 krLQ7bQFXqkXQt0QdjOa1Wlk8yzu6kFlQCHqBmEJe/AwB9apHI2Loj//3tLxWdn7v8wh
 u9Kw==
X-Gm-Message-State: AOJu0Yz/AA87W/WCOzzAJZAplawLU5e3/7pxvyb4/Gx7X2Fv6g3qeogA
 tqI54TTlU0PBoeUxM+UArXo3NHLT7QiNRwmlV4ulBT9NW4rDiVCg1Zq3txl2Ht+dCrJKx01OmSV
 bREq/uP2+HaLlwGk=
X-Received: by 2002:a05:620a:190c:b0:76d:cf08:5e5f with SMTP id
 bj12-20020a05620a190c00b0076dcf085e5fmr2863348qkb.1.1693414845979; 
 Wed, 30 Aug 2023 10:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK8qedNcvqNu7BeI0wGZii4o5YBCn16P8kB7nBOg6NW1Fd8IhBqYyK4jzepqczzYohmDoskQ==
X-Received: by 2002:a05:620a:190c:b0:76d:cf08:5e5f with SMTP id
 bj12-20020a05620a190c00b0076dcf085e5fmr2863323qkb.1.1693414845639; 
 Wed, 30 Aug 2023 10:00:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a135500b0076ce5622df1sm3886765qkl.3.2023.08.30.10.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 10:00:44 -0700 (PDT)
Date: Wed, 30 Aug 2023 13:00:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V4 07/11] tests/qtest: migration events
Message-ID: <ZO91uYBncX3VE0D6@x1n>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-8-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1693333086-392798-8-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 29, 2023 at 11:18:02AM -0700, Steve Sistare wrote:
> Define a state object to capture events seen by migration tests, to allow
> more events to be captured in a subsequent patch, and simplify event
> checking in wait_for_migration_pass.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 24 +++++----------
>  tests/qtest/migration-helpers.h |  8 +++--
>  tests/qtest/migration-test.c    | 68 +++++++++++++++++++----------------------
>  3 files changed, 44 insertions(+), 56 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index be00c52..b541108 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -23,26 +23,16 @@
>   */
>  #define MIGRATION_STATUS_WAIT_TIMEOUT 120
>  
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque)
> -{
> -    bool *seen = opaque;
> -
> -    if (g_str_equal(name, "STOP")) {
> -        *seen = true;
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque)
>  {
> -    bool *seen = opaque;
> +    QTestMigrationState *state = opaque;
>  
> -    if (g_str_equal(name, "RESUME")) {
> -        *seen = true;
> +    if (g_str_equal(name, "STOP")) {
> +        state->stop_seen = true;
> +        return true;
> +    } else if (g_str_equal(name, "RESUME")) {
> +        state->resume_seen = true;
>          return true;
>      }
>  
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 009e250..59fbb83 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -15,9 +15,11 @@
>  
>  #include "libqtest.h"
>  
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque);
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +typedef struct QTestMigrationState {
> +    bool stop_seen, resume_seen;
> +} QTestMigrationState;
> +
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
>  G_GNUC_PRINTF(3, 4)
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 62d3f37..526a1b7 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -43,8 +43,8 @@
>  unsigned start_address;
>  unsigned end_address;
>  static bool uffd_feature_thread_id;
> -static bool got_src_stop;
> -static bool got_dst_resume;
> +static QTestMigrationState src_state;
> +static QTestMigrationState dst_state;
>  
>  /*
>   * An initial 3 MB offset is used as that corresponds
> @@ -188,6 +188,13 @@ static void wait_for_serial(const char *side)
>      } while (true);
>  }
>  
> +static void wait_for_stop(QTestState *who, QTestMigrationState *state)
> +{
> +    if (!state->stop_seen) {
> +        qtest_qmp_eventwait(who, "STOP");
> +    }
> +}
> +
>  /*
>   * It's tricky to use qemu's migration event capability with qtest,
>   * events suddenly appearing confuse the qmp()/hmp() responses.
> @@ -235,21 +242,19 @@ static void read_blocktime(QTestState *who)
>      qobject_unref(rsp_return);
>  }
>  
> +/*
> + * Wait for two changes in the migration pass count, but bail if we stop.
> + */
>  static void wait_for_migration_pass(QTestState *who)
>  {
> -    uint64_t initial_pass = get_migration_pass(who);
> -    uint64_t pass;
> +    uint64_t pass, prev_pass = 0, changes = 0;
>  
> -    /* Wait for the 1st sync */
> -    while (!got_src_stop && !initial_pass) {
> -        usleep(1000);
> -        initial_pass = get_migration_pass(who);
> -    }
> -
> -    do {
> +    while (changes < 2 && !src_state.stop_seen) {
>          usleep(1000);
>          pass = get_migration_pass(who);
> -    } while (pass == initial_pass && !got_src_stop);
> +        changes += (pass != prev_pass);
> +        prev_pass = pass;
> +    }

Here won't it start to wait for 2 iterations every time instead of 1?

Note that previously we only wait for 1 iteration as long as not the
initial pass.  And I think the change will double the counts for below..

            while (args->iterations > 1) {
                wait_for_migration_pass(from);
                args->iterations--;
            }

The event-related changes are all fine, but maybe leave this piece as before?

>  }
>  
>  static void check_guests_ram(QTestState *who)
> @@ -586,10 +591,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
>  {
>      qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
>  
> -    if (!got_src_stop) {
> -        qtest_qmp_eventwait(from, "STOP");
> -    }
> -
> +    wait_for_stop(from, &src_state);
>      qtest_qmp_eventwait(to, "RESUME");
>  }
>  
> @@ -720,8 +722,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          }
>      }
>  
> -    got_src_stop = false;
> -    got_dst_resume = false;
> +    dst_state = (QTestMigrationState) { };
> +    src_state = (QTestMigrationState) { };
> +
>      bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          /* the assembled x86 boot sector should be exactly one sector large */
> @@ -801,8 +804,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      if (!args->only_target) {
>          *from = qtest_init(cmd_source);
>          qtest_qmp_set_event_callback(*from,
> -                                     migrate_watch_for_stop,
> -                                     &got_src_stop);
> +                                     migrate_watch_for_events,
> +                                     &src_state);
>      }
>  
>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> @@ -821,8 +824,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   ignore_stderr);
>      *to = qtest_init(cmd_target);
>      qtest_qmp_set_event_callback(*to,
> -                                 migrate_watch_for_resume,
> -                                 &got_dst_resume);
> +                                 migrate_watch_for_events,
> +                                 &dst_state);
>  
>      /*
>       * Remove shmem file immediately to avoid memory leak in test failed case.
> @@ -1516,9 +1519,7 @@ static void test_precopy_common(MigrateCommon *args)
>           */
>          if (args->result == MIG_TEST_SUCCEED) {
>              qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> -            if (!got_src_stop) {
> -                qtest_qmp_eventwait(from, "STOP");
> -            }
> +            wait_for_stop(from, &src_state);
>              migrate_ensure_converge(from);
>          }
>      }
> @@ -1560,9 +1561,8 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> -            if (!got_src_stop) {
> -                qtest_qmp_eventwait(from, "STOP");
> -            }
> +            wait_for_stop(from, &src_state);
> +
>          } else {
>              wait_for_migration_complete(from);
>              /*
> @@ -1575,7 +1575,7 @@ static void test_precopy_common(MigrateCommon *args)
>              qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
>          }
>  
> -        if (!got_dst_resume) {
> +        if (!dst_state.resume_seen) {
>              qtest_qmp_eventwait(to, "RESUME");
>          }
>  
> @@ -1696,9 +1696,7 @@ static void test_ignore_shared(void)
>  
>      migrate_wait_for_dirty_mem(from, to);
>  
> -    if (!got_src_stop) {
> -        qtest_qmp_eventwait(from, "STOP");
> -    }
> +    wait_for_stop(from, &src_state);
>  
>      qtest_qmp_eventwait(to, "RESUME");
>  
> @@ -2139,7 +2137,7 @@ static void test_migrate_auto_converge(void)
>              break;
>          }
>          usleep(20);
> -        g_assert_false(got_src_stop);
> +        g_assert_false(src_state.stop_seen);
>      } while (true);
>      /* The first percentage of throttling should be at least init_pct */
>      g_assert_cmpint(percentage, >=, init_pct);
> @@ -2481,9 +2479,7 @@ static void test_multifd_tcp_cancel(void)
>  
>      migrate_ensure_converge(from);
>  
> -    if (!got_src_stop) {
> -        qtest_qmp_eventwait(from, "STOP");
> -    }
> +    wait_for_stop(from, &src_state);
>      qtest_qmp_eventwait(to2, "RESUME");
>  
>      wait_for_serial("dest_serial");
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


