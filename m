Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4D8269AF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:41:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMlB7-0007Dc-VM; Mon, 08 Jan 2024 03:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMlB6-0007Ct-HR
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMlB3-0001u9-7p
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704703207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IV3ToQuYjHzqVoJGUjWjGh0E0YEBwsUexLvkftgAoXs=;
 b=evpraTwo4KxD9nHdZyh/VCUtN9CnoIpRo5GBBxWFRWMGU2+LA6lfSGuLQOogTwW0vQBLJL
 IzAB+j1A9TfGCRXSO1/job3/GSMEZ7w1h7VFilmik0V7ZvdQhkIAepwkXkMlKP+iFqBNAz
 LoJzDK5DU+vlEChYCTxiVkQkdXZV6Jk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-qIFCWyvhMdWdzOPhNkfQnA-1; Mon, 08 Jan 2024 03:40:05 -0500
X-MC-Unique: qIFCWyvhMdWdzOPhNkfQnA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso92832b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704703204; x=1705308004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IV3ToQuYjHzqVoJGUjWjGh0E0YEBwsUexLvkftgAoXs=;
 b=VD6Ou5tte0rKMVEKF6FdqKnrY6FBOVrbc8Ca1F04E5ybRQT2O+ticUR5lZ0K6pU4ZR
 VbZspTNoeTU9IogQ1jOCfIejnXZF5J1Nnc9QQonWrJgO2k5j24KOsiX0k86uVeNZAI7z
 TOqk9jryCrKc2pRLMvwRAuaSKvKh54tBv3JlDBKUuBG+Lm74m+SKK1JQVMei1pyjM3IA
 8VoOyjLj+ibFt2aNaiBXA2RSb/JEqywgeEoM8olg+Yq1gOE60xow67KGhMaVx0459Y1t
 Nv5tcY7HBfWT+133spSxp/AoBHB9S1bmkfIaBTONCxRc+xxwRC8GHy753wlwOU4DmFlw
 2KZQ==
X-Gm-Message-State: AOJu0YyPIdlvCE6M551dTK7PLcSJOydIAvIVZbaCbysVD637uZoArjVq
 Zw+G2FGpSIUKfSrJxNg2uCdkLu1h0N9KwluY8QT3yVfJ4INp0pFiyay1Jzc1tqiKLdIjaNUqDd2
 BBdyLht851VF8bCihpUT0K5I=
X-Received: by 2002:a05:6a00:4b0c:b0:6d9:edd1:4ede with SMTP id
 kq12-20020a056a004b0c00b006d9edd14edemr6955763pfb.2.1704703204440; 
 Mon, 08 Jan 2024 00:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYs5AMR2kWZNa8CEiMnWOWvDNaYsFedrjLfhV/sLhsvjs9Ba2vnZ1rUNs+KwWlHiJL072Qrg==
X-Received: by 2002:a05:6a00:4b0c:b0:6d9:edd1:4ede with SMTP id
 kq12-20020a056a004b0c00b006d9edd14edemr6955740pfb.2.1704703204039; 
 Mon, 08 Jan 2024 00:40:04 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ks13-20020a056a004b8d00b006d9b93ca5e2sm5620152pfb.146.2024.01.08.00.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 00:40:03 -0800 (PST)
Date: Mon, 8 Jan 2024 16:39:55 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/qtest/migration: Add infrastructure to skip
 tests on older QEMUs
Message-ID: <ZZu021Il_jVdwFb0@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-3-farosas@suse.de> <ZZuulnlKscT1ULS7@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZuulnlKscT1ULS7@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jan 08, 2024 at 04:13:10PM +0800, Peter Xu wrote:
> On Fri, Jan 05, 2024 at 03:04:47PM -0300, Fabiano Rosas wrote:
> > We can run the migration tests with two different QEMU binaries to
> > test migration compatibility between QEMU versions. This means we'll
> > be running the tests with an older QEMU in either source or
> > destination.
> > 
> > We need to avoid trying to test functionality that is unknown to the
> > older QEMU. This could mean new features, bug fixes, error message
> > changes, QEMU command line changes, migration API changes, etc.
> > 
> > Add a 'since' argument to the tests that inform when the functionality
> > that is being test has been added to QEMU so we can skip the test on
> > older versions.
> > 
> > Also add a version comparison function so we can adapt test code
> > depending on the QEMU binary version being used.
> > 
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  tests/qtest/migration-helpers.h |  1 +
> >  tests/qtest/migration-helpers.c | 48 +++++++++++++++++++++++++++++++++
> >  tests/qtest/migration-test.c    | 29 ++++++++++++++++++++
> >  3 files changed, 78 insertions(+)
> > 
> > diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> > index e31dc85cc7..7b4f8e851e 100644
> > --- a/tests/qtest/migration-helpers.h
> > +++ b/tests/qtest/migration-helpers.h
> > @@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
> >                                    const char *var2);
> >  char *resolve_machine_version(const char *alias, const char *var1,
> >                                const char *var2);
> > +int migration_vercmp(QTestState *who, const char *tgt_version);
> >  #endif /* MIGRATION_HELPERS_H */
> > diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> > index 24fb7b3525..bc4fd93e8c 100644
> > --- a/tests/qtest/migration-helpers.c
> > +++ b/tests/qtest/migration-helpers.c
> > @@ -292,3 +292,51 @@ char *resolve_machine_version(const char *alias, const char *var1,
> >  
> >      return find_common_machine_version(machine_name, var1, var2);
> >  }
> > +
> > +int migration_vercmp(QTestState *who, const char *tgt_version)
> > +{
> > +    g_autofree char *version = g_strdup(tgt_version);
> > +    int major = 0, minor = 0, micro = 0;
> > +    int tgt_major = 0, tgt_minor = 0, tgt_micro = 0;
> > +    const char *delim = ".";
> > +    char *tok;
> > +
> > +    qtest_query_version(who, &major, &minor, &micro);
> > +
> > +    tok = strtok(version, delim);
> > +    assert(tok);
> > +    tgt_major = atoi(tok);
> > +    assert(tgt_major);
> 
> I'd consider dropping this.  But I don't think "since: 0.8" is valid. :)
> More like a nitpick.
> 
> > +
> > +    if (major > tgt_major) {
> > +        return -1;
> 
> This means the QEMU version is newer, the function will return negative.
> Is this what we want?  It seems it's inverted.
> 
> In all cases, document this function with retval would be helpful too.
> 
> > +    }
> > +    if (major < tgt_major) {
> > +        return 1;
> > +    }
> 
> Instead of all these, I'm wondering whether we can allow "since" to be an
> array of integers, like [8, 2, 0].  Would that be much easier?

I meant something like:

struct Version { int major, minor, micro; };

#define QEMU_VER(major, minor, micro) \
  ((struct Verion){.major = major, .minor = minor, .micro = micro})

Then:

   ...
   struct Version since;
   ...

   ...
   .since = QEMU_VER(8, 2, 0),
   ...

> 
> > +
> > +    tok = strtok(NULL, delim);
> > +    assert(tok);
> > +    tgt_minor = atoi(tok);
> > +
> > +    if (minor > tgt_minor) {
> > +        return -1;
> > +    }
> > +    if (minor < tgt_minor) {
> > +        return 1;
> > +    }
> > +
> > +    tok = strtok(NULL, delim);
> > +    if (tok) {
> > +        tgt_micro = atoi(tok);
> > +    }
> > +
> > +    if (micro > tgt_micro) {
> > +        return -1;
> > +    }
> > +    if (micro < tgt_micro) {
> > +        return 1;
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index d520c587f7..001470238b 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -637,6 +637,12 @@ typedef struct {
> >      bool use_dirty_ring;
> >      const char *opts_source;
> >      const char *opts_target;
> > +    /*
> > +     * If a test checks against new functionality that might not be
> > +     * present in older QEMUs this needs to be set so we can skip
> > +     * running it when doing compatibility testing.
> > +     */
> > +    const char *since;
> >  } MigrateStart;
> >  
> >  /*
> > @@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >          qtest_qmp_set_event_callback(*from,
> >                                       migrate_watch_for_stop,
> >                                       &got_src_stop);
> > +
> > +        if (args->since && migration_vercmp(*from, args->since) < 0) {
> > +            g_autofree char *msg = NULL;
> > +
> > +            msg = g_strdup_printf("Test requires at least QEMU version %s",
> > +                                  args->since);
> > +            g_test_skip(msg);
> > +            qtest_quit(*from);
> > +
> > +            return -1;
> > +        }
> >      }
> >  
> >      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
> > @@ -872,6 +889,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >                                   migrate_watch_for_resume,
> >                                   &got_dst_resume);
> >  
> > +    if (args->since && migration_vercmp(*to, args->since) < 0) {
> > +        g_autofree char *msg = NULL;
> > +
> > +        msg = g_strdup_printf("Test requires at least QEMU version %s",
> > +                              args->since);
> > +        g_test_skip(msg);
> > +        qtest_quit(*to);
> > +        qtest_quit(*from);
> > +
> > +        return -1;
> 
> Nitpick: you can do both check here, then avoid duplicating some code, and
> always free from+to.
> 
> > +    }
> > +
> >      /*
> >       * Remove shmem file immediately to avoid memory leak in test failed case.
> >       * It's valid because QEMU has already opened this file
> > -- 
> > 2.35.3
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


