Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFB7FA51B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:46:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dnE-0001JN-Cy; Mon, 27 Nov 2023 10:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7dnC-0001Ib-3z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:45:02 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7dnA-0005pI-B9
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:45:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 208B021B6C;
 Mon, 27 Nov 2023 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701099896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z40TZaYkcYiQpdli9J2Gg/hunRGtQ96x9fIM0bWQ7eU=;
 b=uXeP+qfDbAKo/naH7KRz8TH2x6PSUCSm9xX2TaDx17BDt71U7HVE4PPpXBx2/f4evU5Nis
 LlCm4wjZCNJXwdl6Uj6biX/VeSALhDOOoY2c1DLZhGHQhuNGbvcWrfflxZ5dQmIjMXLYVQ
 zXrcWCnBbKeVjpfgWF0x0OshzWWWy8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701099896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z40TZaYkcYiQpdli9J2Gg/hunRGtQ96x9fIM0bWQ7eU=;
 b=h4Mu2sbrgDOa5hZZw1LGQ7wDGeeTyla+kAfHBeDVIVe92BhsqttPCfcAe1Ut+6tJxWLssY
 knPwSOGQ+Q20S/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A09181379A;
 Mon, 27 Nov 2023 15:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CGrGXe5ZGUQSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 15:44:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 6/7] tests/qtest/migration: Add a wrapper to print
 test names
In-Reply-To: <ZWStsHj23pCbuGPP@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-7-farosas@suse.de> <ZWStsHj23pCbuGPP@x1n>
Date: Mon, 27 Nov 2023 12:44:53 -0300
Message-ID: <87y1ej2oay.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Fri, Nov 24, 2023 at 01:14:31PM -0300, Fabiano Rosas wrote:
>> Our usage of gtest results in us losing the very basic functionality
>> of "knowing which test failed". The issue is that gtest only prints
>> test names ("paths" in gtest parlance) once the test has finished, but
>> we use asserts in the tests and crash gtest itself before it can print
>> anything. We also use a final abort when the result of g_test_run is
>> not 0.
>> 
>> Depending on how the test failed/broke we can see the function that
>> trigged the abort, which may be representative of the test, but it
>> could also just be some generic function.
>> 
>> We have been relying on the primitive method of looking at the name of
>> the previous successful test and then looking at the code to figure
>> out which test should have come next.
>> 
>> Add a wrapper to the test registration that does the job of printing
>> the test name before running.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-helpers.c | 32 ++++++++++++++++++++++++++++++++
>>  tests/qtest/migration-helpers.h |  1 +
>>  2 files changed, 33 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index f1106128a9..164e09c299 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -298,3 +298,35 @@ char *resolve_machine_version(const char *alias, const char *var1,
>>  
>>      return find_common_machine_version(machine_name, var1, var2);
>>  }
>> +
>> +typedef struct {
>> +    char *name;
>> +    void (*func)(void);
>> +} MigrationTest;
>> +
>> +static void migration_test_destroy(gpointer data)
>> +{
>> +    MigrationTest *test = (MigrationTest *)data;
>> +
>> +    g_free(test->name);
>> +    g_free(test);
>> +}
>> +
>> +static void migration_test_wrapper(const void *data)
>> +{
>> +    MigrationTest *test = (MigrationTest *)data;
>> +
>> +    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
>
> /%s/%s?

The test name contains a leading slash.

