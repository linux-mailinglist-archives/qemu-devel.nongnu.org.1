Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C4824772
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:26:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRUO-0008V6-UO; Thu, 04 Jan 2024 12:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLRUH-0008Uh-MX
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLRUF-0001Un-Tj
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704389191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DC211mF23giQhXuNf6TeOfXoofzT0i4Q0a6IZ408oUk=;
 b=bvC1M8npfAw26OkjXvGwNMdffxY+TMyj0hQo1nigeDwPuyse3UolOOJ02wrC8AVw3HZsBy
 UoRFUKjFpB6K6el7x8MxRHFnkLe/+4hbo0EOicOKOZYGV2E3DVTLoS1H52ezSVSZqI3xjn
 VOe4sXyC43ccVDr8UASx15MAlBaBfj8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-2vLNTgvQNoO0E7-VgdJaCA-1; Thu,
 04 Jan 2024 12:26:29 -0500
X-MC-Unique: 2vLNTgvQNoO0E7-VgdJaCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 415023CBDFA9;
 Thu,  4 Jan 2024 17:26:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E691E1121306;
 Thu,  4 Jan 2024 17:26:26 +0000 (UTC)
Date: Thu, 4 Jan 2024 17:26:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/qtest/migration: Add infrastructure to skip
 tests on older QEMUs
Message-ID: <ZZbqQJxdfJDLXmXz@redhat.com>
References: <20240104171857.20108-1-farosas@suse.de>
 <20240104171857.20108-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104171857.20108-3-farosas@suse.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jan 04, 2024 at 02:18:55PM -0300, Fabiano Rosas wrote:
> We can run the migration tests with two different QEMU binaries to
> test migration compatibility between QEMU versions. This means we'll
> be running the tests with an older QEMU in either source or
> destination.
> 
> We need to avoid trying to test functionality that is unknown to the
> older QEMU. This could mean new features, bug fixes, error message
> changes, QEMU command line changes, migration API changes, etc.
> 
> Add a 'since' argument to the tests that inform when the functionality
> that is being test has been added to QEMU so we can skip the test on
> older versions.
> 
> Also add a version comparison function so we can adapt test code
> depending on the QEMU binary version being used.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-helpers.c | 11 +++++++++++
>  tests/qtest/migration-helpers.h |  1 +
>  tests/qtest/migration-test.c    | 29 +++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 24fb7b3525..20220bfda0 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -292,3 +292,14 @@ char *resolve_machine_version(const char *alias, const char *var1,
>  
>      return find_common_machine_version(machine_name, var1, var2);
>  }
> +
> +int migration_vercmp(QTestState *who, const char *tgt_version)
> +{
> +    int major, minor, micro;
> +    g_autofree char *version = NULL;
> +
> +    qtest_query_version(who, &major, &minor, &micro);
> +    version = g_strdup_printf("%d.%d", major, minor + !!micro);
> +
> +    return strcmp(version, tgt_version);

Alphabetical version comparison will fail in 2025 when we
hit QEMU 10.0, as 10.0 will compare older than 9.0

> +}
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index e31dc85cc7..7b4f8e851e 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>                                    const char *var2);
>  char *resolve_machine_version(const char *alias, const char *var1,
>                                const char *var2);
> +int migration_vercmp(QTestState *who, const char *tgt_version);
>  #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index d520c587f7..001470238b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -637,6 +637,12 @@ typedef struct {
>      bool use_dirty_ring;
>      const char *opts_source;
>      const char *opts_target;
> +    /*
> +     * If a test checks against new functionality that might not be
> +     * present in older QEMUs this needs to be set so we can skip
> +     * running it when doing compatibility testing.
> +     */
> +    const char *since;
>  } MigrateStart;
>  
>  /*
> @@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          qtest_qmp_set_event_callback(*from,
>                                       migrate_watch_for_stop,
>                                       &got_src_stop);
> +
> +        if (args->since && migration_vercmp(*from, args->since) < 0) {
> +            g_autofree char *msg = NULL;
> +
> +            msg = g_strdup_printf("Test requires at least QEMU version %s",
> +                                  args->since);
> +            g_test_skip(msg);
> +            qtest_quit(*from);
> +
> +            return -1;
> +        }
>      }
>  
>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> @@ -872,6 +889,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>                                   migrate_watch_for_resume,
>                                   &got_dst_resume);
>  
> +    if (args->since && migration_vercmp(*to, args->since) < 0) {
> +        g_autofree char *msg = NULL;
> +
> +        msg = g_strdup_printf("Test requires at least QEMU version %s",
> +                              args->since);
> +        g_test_skip(msg);
> +        qtest_quit(*to);
> +        qtest_quit(*from);
> +
> +        return -1;
> +    }
> +
>      /*
>       * Remove shmem file immediately to avoid memory leak in test failed case.
>       * It's valid because QEMU has already opened this file
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


