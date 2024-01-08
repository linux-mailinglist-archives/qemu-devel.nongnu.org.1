Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A18271D1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:50:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqx1-0001RH-M7; Mon, 08 Jan 2024 09:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMqwr-0001Qx-2r
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:49:54 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMqwo-00072a-Tc
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:49:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1E5021D46;
 Mon,  8 Jan 2024 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704725389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajwB5165l4lbJLa14ItHOsGKHQgUauAFRq2uG//Zwww=;
 b=Tvbcfze6AFgePytfNZ8z+B5Nqh3BKKjXxBDkvCcs+0zmuEibFAOvVmHEq7yMQwzvQxthkD
 NRl2kdqvyU79+A0qvUyF/SuSqQ+gIxoFjt+9/8a0q7cKckGdq4qItvU3pNhqYcrNMjHDYR
 iQW6CYXM0HzjQYPil7XOgTYdVz35ZJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704725389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajwB5165l4lbJLa14ItHOsGKHQgUauAFRq2uG//Zwww=;
 b=BckO9XWFr5Aw/cGAFJKuVnwbplJcrkLT2ahf45W9YF+OdfmXhCXbXWOZaOesIALvAjxBCY
 aXe6a1lhqmWrlzDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704725388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajwB5165l4lbJLa14ItHOsGKHQgUauAFRq2uG//Zwww=;
 b=Koe+a3vLgQ/wDFbkohdniwET3J7z8jyuV1bDCi8ONJ3ZKXQTDgm9X3cwsw1rERWm/Qyqvs
 SaF88mx3MBaDDtJzF2KdGqANwQz8xEdYWQieTDT0lbQc7PTnRc7tZNw1CM2ZOkeOYlZxT0
 U2I+LMQMHCqNsrtt/Z3pcRNmbqksmpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704725388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajwB5165l4lbJLa14ItHOsGKHQgUauAFRq2uG//Zwww=;
 b=bCNyYE786ul3ZIYMqclEj3N+BZPBGwPPHK1xRNGQNmcJg3a1eor/yoC7cK65kEvZd8pFa/
 QbRwjsscOg/boVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BF041392C;
 Mon,  8 Jan 2024 14:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pF7SBIwLnGW7NAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jan 2024 14:49:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/qtest/migration: Add infrastructure to
 skip tests on older QEMUs
In-Reply-To: <ZZuulnlKscT1ULS7@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-3-farosas@suse.de> <ZZuulnlKscT1ULS7@x1n>
Date: Mon, 08 Jan 2024 11:49:45 -0300
Message-ID: <87a5pf3mnq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Koe+a3vL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bCNyYE78
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-8.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -8.01
X-Rspamd-Queue-Id: C1E5021D46
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 05, 2024 at 03:04:47PM -0300, Fabiano Rosas wrote:
>> We can run the migration tests with two different QEMU binaries to
>> test migration compatibility between QEMU versions. This means we'll
>> be running the tests with an older QEMU in either source or
>> destination.
>> 
>> We need to avoid trying to test functionality that is unknown to the
>> older QEMU. This could mean new features, bug fixes, error message
>> changes, QEMU command line changes, migration API changes, etc.
>> 
>> Add a 'since' argument to the tests that inform when the functionality
>> that is being test has been added to QEMU so we can skip the test on
>> older versions.
>> 
>> Also add a version comparison function so we can adapt test code
>> depending on the QEMU binary version being used.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.h |  1 +
>>  tests/qtest/migration-helpers.c | 48 +++++++++++++++++++++++++++++++++
>>  tests/qtest/migration-test.c    | 29 ++++++++++++++++++++
>>  3 files changed, 78 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>> index e31dc85cc7..7b4f8e851e 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>>                                    const char *var2);
>>  char *resolve_machine_version(const char *alias, const char *var1,
>>                                const char *var2);
>> +int migration_vercmp(QTestState *who, const char *tgt_version);
>>  #endif /* MIGRATION_HELPERS_H */
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 24fb7b3525..bc4fd93e8c 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -292,3 +292,51 @@ char *resolve_machine_version(const char *alias, const char *var1,
>>  
>>      return find_common_machine_version(machine_name, var1, var2);
>>  }
>> +
>> +int migration_vercmp(QTestState *who, const char *tgt_version)
>> +{
>> +    g_autofree char *version = g_strdup(tgt_version);
>> +    int major = 0, minor = 0, micro = 0;
>> +    int tgt_major = 0, tgt_minor = 0, tgt_micro = 0;
>> +    const char *delim = ".";
>> +    char *tok;
>> +
>> +    qtest_query_version(who, &major, &minor, &micro);
>> +
>> +    tok = strtok(version, delim);
>> +    assert(tok);
>> +    tgt_major = atoi(tok);
>> +    assert(tgt_major);
>
> I'd consider dropping this.  But I don't think "since: 0.8" is valid. :)
> More like a nitpick.
>
>> +
>> +    if (major > tgt_major) {
>> +        return -1;
>
> This means the QEMU version is newer, the function will return negative.
> Is this what we want?  It seems it's inverted.

The return "points" to which once is the more recent:

QEMU version | since: version
-1           0         1

> In all cases, document this function with retval would be helpful too.
>

Ok.

>> +    }
>> +    if (major < tgt_major) {
>> +        return 1;
>> +    }
>
> Instead of all these, I'm wondering whether we can allow "since" to be an
> array of integers, like [8, 2, 0].  Would that be much easier?

I don't see why push the complexity towards the person writing the
tests. The string is much more natural to specify.

>> +
>> +    tok = strtok(NULL, delim);
>> +    assert(tok);
>> +    tgt_minor = atoi(tok);
>> +
>> +    if (minor > tgt_minor) {
>> +        return -1;
>> +    }
>> +    if (minor < tgt_minor) {
>> +        return 1;
>> +    }
>> +
>> +    tok = strtok(NULL, delim);
>> +    if (tok) {
>> +        tgt_micro = atoi(tok);
>> +    }
>> +
>> +    if (micro > tgt_micro) {
>> +        return -1;
>> +    }
>> +    if (micro < tgt_micro) {
>> +        return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index d520c587f7..001470238b 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -637,6 +637,12 @@ typedef struct {
>>      bool use_dirty_ring;
>>      const char *opts_source;
>>      const char *opts_target;
>> +    /*
>> +     * If a test checks against new functionality that might not be
>> +     * present in older QEMUs this needs to be set so we can skip
>> +     * running it when doing compatibility testing.
>> +     */
>> +    const char *since;
>>  } MigrateStart;
>>  
>>  /*
>> @@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>          qtest_qmp_set_event_callback(*from,
>>                                       migrate_watch_for_stop,
>>                                       &got_src_stop);
>> +
>> +        if (args->since && migration_vercmp(*from, args->since) < 0) {
>> +            g_autofree char *msg = NULL;
>> +
>> +            msg = g_strdup_printf("Test requires at least QEMU version %s",
>> +                                  args->since);
>> +            g_test_skip(msg);
>> +            qtest_quit(*from);
>> +
>> +            return -1;
>> +        }
>>      }
>>  
>>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
>> @@ -872,6 +889,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                   migrate_watch_for_resume,
>>                                   &got_dst_resume);
>>  
>> +    if (args->since && migration_vercmp(*to, args->since) < 0) {
>> +        g_autofree char *msg = NULL;
>> +
>> +        msg = g_strdup_printf("Test requires at least QEMU version %s",
>> +                              args->since);
>> +        g_test_skip(msg);
>> +        qtest_quit(*to);
>> +        qtest_quit(*from);
>> +
>> +        return -1;
>
> Nitpick: you can do both check here, then avoid duplicating some code, and
> always free from+to.
>

Hm.. I think I had a good reason for doing it this way. I don't remember
now. I'll double check and apply your suggestion if it works.

>> +    }
>> +
>>      /*
>>       * Remove shmem file immediately to avoid memory leak in test failed case.
>>       * It's valid because QEMU has already opened this file
>> -- 
>> 2.35.3
>> 

