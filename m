Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E38467CB27C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 20:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsSHI-0002KD-0H; Mon, 16 Oct 2023 14:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsSH7-0002IC-R1; Mon, 16 Oct 2023 14:25:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsSH4-00036k-Bb; Mon, 16 Oct 2023 14:25:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4A7F1FEC6;
 Mon, 16 Oct 2023 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697480703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfpQIp1vsxHq6jrkG/+153UzkggXUVmFcaClmVM/j2c=;
 b=pYOQQcM2vzZXTkH5ej+J7PAfPokyGEbej92WXArtOwZePDvMpMQ9mH52R7rJ7pXxQpGnJo
 Fwnvn52bkixCXQ4sJoKivAy61Ko8ZurYINYnGlGcP1U1HQNRPcZHTBydgLa5ujhad4BsLL
 ApCkU9/SptVjrjTHeHAQH6RH70TWQqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697480703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfpQIp1vsxHq6jrkG/+153UzkggXUVmFcaClmVM/j2c=;
 b=Q1dbZ+ArT5fg/dciOtG3haHzwQQ+UOFzBjER4KRF4wi+F56OF8nFf630JBPdbLMCUyv2hZ
 /jvmWgjubXAsD8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36245138EF;
 Mon, 16 Oct 2023 18:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p//3AP9/LWUBXgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 16 Oct 2023 18:25:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Fam Zheng
 <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>, Eric Blake
 <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Peter Xu
 <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow
 <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 11/38] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <20231016100706.2551-12-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
 <20231016100706.2551-12-quintela@redhat.com>
Date: Mon, 16 Oct 2023 15:25:00 -0300
Message-ID: <87sf6azapv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.09
X-Spamd-Result: default: False [-7.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-2.99)[-0.997];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[17];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> From: Fabiano Rosas <farosas@suse.de>
>
> Add basic tests for file-based migration.
>
> Note that we cannot use test_precopy_common because that routine
> expects it to be possible to run the migration live. With the file
> transport there is no live migration because we must wait for the
> source to finish writing the migration data to the file before the
> destination can start reading. Add a new migration function
> specifically to handle the file migration.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20230712190742.22294-7-farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 147 +++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index cef5081f8c..da02b6d692 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -68,6 +68,10 @@ static bool got_dst_resume;
>  
>  #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
>  
> +#define QEMU_VM_FILE_MAGIC 0x5145564d
> +#define FILE_TEST_FILENAME "migfile"
> +#define FILE_TEST_OFFSET 0x1000
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -884,6 +888,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      cleanup("migsocket");
>      cleanup("src_serial");
>      cleanup("dest_serial");
> +    cleanup(FILE_TEST_FILENAME);
>  }
>  
>  #ifdef CONFIG_GNUTLS
> @@ -1667,6 +1672,70 @@ finish:
>      test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
>  }
>  
> +static void test_file_common(MigrateCommon *args, bool stop_src)
> +{
> +    QTestState *from, *to;
> +    void *data_hook = NULL;
> +    g_autofree char *connect_uri = g_strdup(args->connect_uri);
> +
> +    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +        return;
> +    }
> +
> +    /*
> +     * File migration is never live. We can keep the source VM running
> +     * during migration, but the destination will not be running
> +     * concurrently.
> +     */
> +    g_assert_false(args->live);
> +
> +    if (args->start_hook) {
> +        data_hook = args->start_hook(from, to);
> +    }
> +
> +    migrate_ensure_converge(from);
> +    wait_for_serial("src_serial");
> +
> +    if (stop_src) {
> +        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> +        if (!got_src_stop) {
> +            qtest_qmp_eventwait(from, "STOP");
> +        }
> +    }
> +
> +    if (args->result == MIG_TEST_QMP_ERROR) {
> +        migrate_qmp_fail(from, connect_uri, "{}");
> +        goto finish;
> +    }
> +
> +    migrate_qmp(from, connect_uri, "{}");
> +    wait_for_migration_complete(from);
> +
> +    /*
> +     * We need to wait for the source to finish before starting the
> +     * destination.
> +     */
> +    migrate_incoming_qmp(to, connect_uri, "{}");
> +    wait_for_migration_complete(to);
> +
> +    if (stop_src) {
> +        qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
> +    }
> +
> +    if (!got_dst_resume) {
> +        qtest_qmp_eventwait(to, "RESUME");
> +    }
> +
> +    wait_for_serial("dest_serial");
> +
> +finish:
> +    if (args->finish_hook) {
> +        args->finish_hook(from, to, data_hook);
> +    }
> +
> +    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
> +}
> +
>  static void test_precopy_unix_plain(void)
>  {
>      g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> @@ -1862,6 +1931,76 @@ static void test_precopy_unix_compress_nowait(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_precopy_file(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +    };
> +
> +    test_file_common(&args, true);
> +}
> +
> +static void file_offset_finish_hook(QTestState *from, QTestState *to,
> +                                    void *opaque)
> +{
> +#if defined(__linux__)
> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> +    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
> +    uintptr_t *addr, *p;
> +    int fd;
> +
> +    fd = open(path, O_RDONLY);
> +    g_assert(fd != -1);
> +    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
> +    g_assert(addr != MAP_FAILED);
> +
> +    /*
> +     * Ensure the skipped offset contains zeros and the migration
> +     * stream starts at the right place.
> +     */
> +    p = addr;
> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> +        g_assert(*p == 0);
> +        p++;
> +    }
> +    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);

This truncates to 32-bits, so it breaks on a BE host. We need this:

-->8--
From ea0c2d1c988add48d9754891a9fc7f6854a9718a Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Mon, 16 Oct 2023 15:21:49 -0300
Subject: [PATCH] fixup! tests/qtest: migration-test: Add tests for file-based
 migration

---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index da02b6d692..e1c110537b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1966,7 +1966,7 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
         g_assert(*p == 0);
         p++;
     }
-    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
+    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
 
     munmap(addr, size);
     close(fd);
-- 
2.35.3


