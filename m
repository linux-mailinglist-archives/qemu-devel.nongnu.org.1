Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C95197DBC90
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 16:28:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxU9w-0000ag-Lh; Mon, 30 Oct 2023 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxU9v-0000Zz-3V
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:26:31 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxU9t-00050t-Du
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 11:26:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19E7E1F38C;
 Mon, 30 Oct 2023 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698679588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5aIaw0YnKbOg+jZ1UiuQ562hiqOwVu4dKQm51i+xXG4=;
 b=Afj71PRa5d6lVFeSYTdmPjuQ/87I7/OZ3tzz1/9fSJFJHjgcTE0IrIBZkFJDvNioTJVdAE
 +AoJHnZwI9HZLqFj3ee2Io7LS66LK70zhcb3JTiqWEnURklP1RdjxwsVRIoadXcTYqMYqr
 4EBfp4q9e/Smd7YsepNrvK/ipugDSm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698679588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5aIaw0YnKbOg+jZ1UiuQ562hiqOwVu4dKQm51i+xXG4=;
 b=y8S+QNLa5pfG9A3Uo+15WOZYq50+Gt4uD21SweMSrai2fhwh8tCsHln57VODq4rsh7E3+4
 +N84VQXMbj06d1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1DAB138EF;
 Mon, 30 Oct 2023 15:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iRj/GiPLP2X1ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 15:26:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 16/16] migration/multifd: Add integration tests for
 multifd with Intel DSA offloading.
In-Reply-To: <20231025193822.2813204-17-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-17-hao.xiang@bytedance.com>
Date: Mon, 30 Oct 2023 12:26:25 -0300
Message-ID: <877cn4nnby.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> * Add test case to start and complete multifd live migration with DSA
> offloading enabled.
> * Add test case to start and cancel multifd live migration with DSA
> offloading enabled.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  tests/qtest/migration-test.c | 66 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8eb2053dbb..f22d39e72e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -631,6 +631,12 @@ typedef struct {
>      const char *opts_target;
>  } MigrateStart;
>  
> +/*
> + * It requires separate steps to configure and enable DSA device.
> + * This test assumes that the configuration is done already.
> + */
> +static const char* dsa_dev_path = "/dev/dsa/wq4.0";

Hmm, this is tricky. No developer is going to have this setup neither
will our CI. So it might be that this test just sits there and never
gets executed. I have to think more about this.

Nonetheless, you should check that the file exists and skip the test if
it doesn't.

> +
>  /*
>   * A hook that runs after the src and dst QEMUs have been
>   * created, but before the migration is started. This can
> @@ -2431,7 +2437,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
>   *
>   *  And see that it works
>   */
> -static void test_multifd_tcp_cancel(void)
> +static void test_multifd_tcp_cancel_common(bool use_dsa)
>  {
>      MigrateStart args = {
>          .hide_stderr = true,
> @@ -2452,6 +2458,10 @@ static void test_multifd_tcp_cancel(void)
>      migrate_set_capability(from, "multifd", true);
>      migrate_set_capability(to, "multifd", true);
>  
> +    if (use_dsa) {
> +        migrate_set_parameter_str(from, "multifd-dsa-accel", dsa_dev_path);
> +    }
> +
>      /* Start incoming migration from the 1st socket */
>      migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>  
> @@ -2508,6 +2518,48 @@ static void test_multifd_tcp_cancel(void)
>      test_migrate_end(from, to2, true);
>  }
>  
> +/*
> + * This test does:
> + *  source               target
> + *                       migrate_incoming
> + *     migrate
> + *     migrate_cancel
> + *                       launch another target
> + *     migrate
> + *
> + *  And see that it works
> + */
> +static void test_multifd_tcp_cancel(void)
> +{
> +    test_multifd_tcp_cancel_common(false);
> +}
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +static void *test_migrate_precopy_tcp_multifd_start_dsa(QTestState *from,
> +                                                        QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "multifd-dsa-accel", dsa_dev_path);
> +    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
> +}
> +
> +static void test_multifd_tcp_none_dsa(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_start_dsa,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +static void test_multifd_tcp_cancel_dsa(void)
> +{
> +    test_multifd_tcp_cancel_common(true);
> +}
> +
> +#endif
> +
>  static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
>  {
>      qtest_qmp_assert_success(who,
> @@ -2921,6 +2973,18 @@ int main(int argc, char **argv)
>      }
>      qtest_add_func("/migration/multifd/tcp/plain/none",
>                     test_multifd_tcp_none);
> +
> +#ifdef CONFIG_DSA_OPT
> +    if (g_str_equal(arch, "x86_64")) {
> +        qtest_add_func("/migration/multifd/tcp/plain/none/dsa",
> +                       test_multifd_tcp_none_dsa);
> +    }
> +    if (getenv("QEMU_TEST_FLAKY_TESTS")) {

It's safe to not use FLAKY here. This test already requires special
setup.

We have also fixed the cancel test a while back. We will remove the
flaky tag from it soon.


