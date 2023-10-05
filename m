Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081117B9D4F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOLr-0006lf-0b; Thu, 05 Oct 2023 09:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoOLn-0006lW-Hi
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:25:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoOLg-0008OP-GY
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:25:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E55891F74D;
 Thu,  5 Oct 2023 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696512296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QFYtCDxppgzV7F2xVOHyWPZ9UJz/bSxfa9ulzMi4XA=;
 b=kQYJzAL6spaYaZy8Zvz7LdmYhp/Ws0UGS7/6hlh8N+fvTVHakMncFdsrG9+8BhpmVErrN/
 Tw585iwEOr6jtLmhqS5mlwwFfNFUgZFSzFnOua3FC/oja7DQ1PynpQaA3uhYWSFnmjqVzy
 ADosLOwUOd7lS9x/pgw0PiH2UPCYUSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696512296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QFYtCDxppgzV7F2xVOHyWPZ9UJz/bSxfa9ulzMi4XA=;
 b=1wB1iYe9hXwQEYsAk57GPmBF4ecyu+fCjmt7ziDkCW7Ua4SK1a6je44gTZb5RdjC9N98fG
 MD9cOgz4vwSEIzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F79213438;
 Thu,  5 Oct 2023 13:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1Wb9Dii5HmUCCwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 13:24:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <20231004220240.167175-11-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com>
Date: Thu, 05 Oct 2023 10:24:54 -0300
Message-ID: <87edi9fbh5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Xu <peterx@redhat.com> writes:

> From: Fabiano Rosas <farosas@suse.de>
>
> To do so, create two paired sockets, but make them not providing real data.
> Feed those fake sockets to src/dst QEMUs for recovery to let them go into
> RECOVER stage without going out.  Test that we can always kick it out and
> recover again with the right ports.
>
> This patch is based on Fabiano's version here:
>
> https://lore.kernel.org/r/877cowmdu0.fsf@suse.de
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> [peterx: write commit message, remove case 1, fix bugs, and more]
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-test.c | 94 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 46f1c275a2..fb7a3765e4 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -729,6 +729,7 @@ typedef struct {
>      /* Postcopy specific fields */
>      void *postcopy_data;
>      bool postcopy_preempt;
> +    bool postcopy_recovery_test_fail;
>  } MigrateCommon;
>  
>  static int test_migrate_start(QTestState **from, QTestState **to,
> @@ -1381,6 +1382,78 @@ static void test_postcopy_preempt_tls_psk(void)
>  }
>  #endif
>  
> +static void wait_for_postcopy_status(QTestState *one, const char *status)
> +{
> +    wait_for_migration_status(one, status,
> +                              (const char * []) { "failed", "active",
> +                                                  "completed", NULL });
> +}
> +
> +static void postcopy_recover_fail(QTestState *from, QTestState *to)
> +{
> +    int ret, pair1[2], pair2[2];
> +    char c;
> +
> +    /* Create two unrelated socketpairs */
> +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
> +    g_assert_cmpint(ret, ==, 0);
> +
> +    /*
> +     * Give the guests unpaired ends of the sockets, so they'll all blocked
> +     * at reading.  This mimics a wrong channel established.
> +     */
> +    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
> +                                 "{ 'execute': 'getfd',"
> +                                 "  'arguments': { 'fdname': 'fd-mig' }}");
> +
> +    /*
> +     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
> +     * emulate the 1st byte of a real recovery, but stops from there to
> +     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
> +     * the recover process on dest QEMU (by triggering the G_IO_IN event).
> +     *
> +     * NOTE: this trick is not needed on src QEMUs, because src doesn't
> +     * rely on an pre-existing G_IO_IN event, so it will always trigger the
> +     * upcoming recovery anyway even if it can read nothing.
> +     */
> +#define QEMU_VM_COMMAND              0x08
> +    c = QEMU_VM_COMMAND;
> +    ret = send(pair2[1], &c, 1, 0);
> +    g_assert_cmpint(ret, ==, 1);
> +
> +    migrate_recover(to, "fd:fd-mig");
> +    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
> +
> +    /*
> +     * Make sure both QEMU instances will go into RECOVER stage, then test
> +     * kicking them out using migrate-pause.
> +     */
> +    wait_for_postcopy_status(from, "postcopy-recover");
> +    wait_for_postcopy_status(to, "postcopy-recover");

Is this wait out of place? I think we're trying to resume too fast after
migrate_recover():

# {                        
#     "error": {                                                                                                                                                                               
#         "class": "GenericError",                                                                                                                                                             
#         "desc": "Cannot resume if there is no paused migration"
#     }                                                                                                                                                                                        
# }  

> +
> +    /*
> +     * This would be issued by the admin upon noticing the hang, we should
> +     * make sure we're able to kick this out.
> +     */
> +    migrate_pause(from);
> +    wait_for_postcopy_status(from, "postcopy-paused");
> +
> +    /* Do the same test on dest */
> +    migrate_pause(to);
> +    wait_for_postcopy_status(to, "postcopy-paused");
> +
> +    close(pair1[0]);
> +    close(pair1[1]);
> +    close(pair2[0]);
> +    close(pair2[1]);
> +}
> +
>  static void test_postcopy_recovery_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -1420,6 +1493,15 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>                                (const char * []) { "failed", "active",
>                                                    "completed", NULL });
>  
> +    if (args->postcopy_recovery_test_fail) {
> +        /*
> +         * Test when a wrong socket specified for recover, and then the
> +         * ability to kick it out, and continue with a correct socket.
> +         */
> +        postcopy_recover_fail(from, to);
> +        /* continue with a good recovery */
> +    }
> +
>      /*
>       * Create a new socket to emulate a new channel that is different
>       * from the broken migration channel; tell the destination to
> @@ -1459,6 +1541,15 @@ static void test_postcopy_recovery_compress(void)
>      test_postcopy_recovery_common(&args);
>  }
>  
> +static void test_postcopy_recovery_double_fail(void)
> +{
> +    MigrateCommon args = {
> +        .postcopy_recovery_test_fail = true,
> +    };
> +
> +    test_postcopy_recovery_common(&args);
> +}
> +
>  #ifdef CONFIG_GNUTLS
>  static void test_postcopy_recovery_tls_psk(void)
>  {
> @@ -2841,6 +2932,9 @@ int main(int argc, char **argv)
>              qtest_add_func("/migration/postcopy/recovery/compress/plain",
>                             test_postcopy_recovery_compress);
>          }
> +        qtest_add_func("/migration/postcopy/recovery/double-failures",
> +                       test_postcopy_recovery_double_fail);
> +
>      }
>  
>      qtest_add_func("/migration/bad_dest", test_baddest);

