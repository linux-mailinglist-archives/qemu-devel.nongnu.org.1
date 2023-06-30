Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A9743E40
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFgh-0000yu-Rn; Fri, 30 Jun 2023 11:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFgg-0000yX-6U
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:05:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFFge-0005wo-9d
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:05:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6C691F8C2;
 Fri, 30 Jun 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688137526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeyYzjutx8qWK9OddIbWYQ3F3CRuLRwPUTR0yLKqY5s=;
 b=WqVypzoXEOP+fT5Kkdp3XYrlEH6Vva9rN7hNU4yevmkx4Sqy526D1/1yFnY+t84mjdrvGl
 1+YcM3QU7WlKn0xnpAw0uZSfo+R9D5MN8VFb0gZY5HqnGzWdVjH2bwE4PMoXhPRunuuLQa
 AMrP3+7fUysQ1pQs7YinB0JZ+hNSIBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688137526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeyYzjutx8qWK9OddIbWYQ3F3CRuLRwPUTR0yLKqY5s=;
 b=pH2qIhWqQuT6ZUtd6niSZIlx3yWpjzL4iV5esQDW4jaHTKDVyvykdF7llraKokI1X0OWmd
 ekHo44fLQhPAfOBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56BE113915;
 Fri, 30 Jun 2023 15:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Yn2ECDbvnmREEwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 15:05:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <ZJ35d0yqB5YD+8IH@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-7-farosas@suse.de> <ZJ35d0yqB5YD+8IH@x1n>
Date: Fri, 30 Jun 2023 12:05:23 -0300
Message-ID: <874jmpq9cc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Wed, Jun 28, 2023 at 01:55:42PM -0300, Fabiano Rosas wrote:
>> Add basic tests for file-based migration.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 104 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index acb778a8cd..b3019f54de 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -52,6 +52,10 @@ static bool got_dst_resume;
>>   */
>>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>>  
>> +#define QEMU_VM_FILE_MAGIC 0x5145564d
>> +#define FILE_TEST_FILENAME "migfile"
>> +#define FILE_TEST_OFFSET 0x1000
>> +
>>  #if defined(__linux__)
>>  #include <sys/syscall.h>
>>  #include <sys/vfs.h>
>> @@ -763,6 +767,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>>      cleanup("migsocket");
>>      cleanup("src_serial");
>>      cleanup("dest_serial");
>> +    cleanup(FILE_TEST_FILENAME);
>>  }
>>  
>>  #ifdef CONFIG_GNUTLS
>> @@ -1460,11 +1465,28 @@ static void test_precopy_common(MigrateCommon *args)
>>               */
>>              wait_for_migration_complete(from);
>>  
>> +            /*
>> +             * For file based migration the target must begin its
>> +             * migration after the source has finished.
>> +             */
>> +            if (strstr(connect_uri, "file:")) {
>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>> +            }
>> +
>>              if (!got_src_stop) {
>>                  qtest_qmp_eventwait(from, "STOP");
>>              }
>>          } else {
>>              wait_for_migration_complete(from);
>> +
>> +            /*
>> +             * For file based migration the target must begin its
>> +             * migration after the source has finished.
>> +             */
>> +            if (strstr(connect_uri, "file:")) {
>> +                migrate_incoming_qmp(to, connect_uri, "{}");
>> +            }
>> +
>>              /*
>>               * Must wait for dst to finish reading all incoming
>>               * data on the socket before issuing 'cont' otherwise
>> @@ -1682,6 +1704,78 @@ static void test_precopy_unix_compress_nowait(void)
>>      test_precopy_common(&args);
>>  }
>>  
>> +static void test_precopy_file(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>> +                                           FILE_TEST_FILENAME);
>> +    MigrateCommon args = {
>> +        .connect_uri = uri,
>> +        .listen_uri = "defer",
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>> +
>> +#if defined(__linux__)
>> +static void file_offset_finish_hook(QTestState *from, QTestState *to, void *opaque)
>> +{
>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
>> +    uintptr_t *addr, *p;
>> +    int fd;
>> +
>> +    fd = open(path, O_RDONLY);
>> +    g_assert(fd != -1);
>> +    addr = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
>
> Not something that matters a lot, but RO mapping a file with private is a
> bit weird.  Maybe just use MAP_SHARED?
>

Yep

>> +    g_assert(addr != MAP_FAILED);
>> +
>> +    /*
>> +     * Ensure the skipped offset contains zeros and the migration
>> +     * stream starts at the right place.
>> +     */
>> +    p = addr;
>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>> +        g_assert(*p == 0);
>> +        p++;
>> +    }
>> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
>> +
>> +    munmap(addr, size);
>> +    close(fd);
>> +}
>> +
>> +static void test_precopy_file_offset(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
>> +                                           FILE_TEST_FILENAME,
>> +                                           FILE_TEST_OFFSET);
>
> Is it intended to also only run this test with linux?  IIUC it should also
> work for others. Maybe only file_offset_finish_hook() is optional?  Or am i
> wrong?
>

Yes, only the hook is linux-specific. I'll change it.

>> +    MigrateCommon args = {
>> +        .connect_uri = uri,
>> +        .listen_uri = "defer",
>> +        .finish_hook = file_offset_finish_hook,
>> +    };
>> +
>> +    test_precopy_common(&args);
>> +}
>> +#endif
>> +
>> +static void test_precopy_file_offset_bad(void)
>> +{
>> +    /* using a value not supported by qemu_strtosz() */
>> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",
>> +                                           tmpfs);
>> +    MigrateCommon args = {
>> +        .connect_uri = uri,
>> +        .listen_uri = "defer",
>> +        .error_str = g_strdup(
>> +            "file URI has bad offset 0x20M: Unknown error -22"),
>
> "Unknown error" may imply that in Steve's patch the errno is inverted..
>
> Shall we not rely on the string in the test?  It might be too strict, I
> worry, because error strings should be defined for human readers, and we
> may not want some e.g. grammar / trivial change to break a test.
>

Well, you just caught an issue with the errno by looking at the string,
so maybe testing it is a good thing?

I'd expect anyone changing the string to run the test and catch the
mismatch before sending a patch anyway.

I don't have a strong opinion about it, though. I can remove the
error_str.

