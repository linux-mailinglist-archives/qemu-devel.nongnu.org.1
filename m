Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08F7DE1B2
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:36:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBMk-000761-Mb; Wed, 01 Nov 2023 09:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyBMi-00075e-AF
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:34:36 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyBMg-000728-K2
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:34:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A022E21855;
 Wed,  1 Nov 2023 13:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698845671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=80Q1oGloF9rtgM7l5udSrvR4I6GL9FAONOTeXJAszuc=;
 b=TyQg2XA+bkGziPOAIfhfMl7GJkRWC7yyAO+qmvWYDCEKbqKGo4L/kCua3+P0S4RUqXkTWQ
 AstSRXaZ0488BTYctN14xKvW16/NFp+k8q6G2Pp/0D8sk2UdrO/asdlA8MMfn4Kjz4WDgm
 kGHeHnT3TKb9GZYtZpeSI3nYrSRbHVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698845671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=80Q1oGloF9rtgM7l5udSrvR4I6GL9FAONOTeXJAszuc=;
 b=eizOQASNoggdYvb81rRprtFIOnzBTmYnjsPU2JQatt2JTkofxueR+fYx4hkPl2G65RFFfa
 8jroi2cxSlw01OBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 300B513460;
 Wed,  1 Nov 2023 13:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7jaHOeZTQmWkcgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 13:34:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 6/6] tests/qtest: migration: add reboot mode test
In-Reply-To: <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-7-git-send-email-steven.sistare@oracle.com>
Date: Wed, 01 Nov 2023 10:34:28 -0300
Message-ID: <87ttq5fvh7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e1c1105..de29fc5 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2001,6 +2001,31 @@ static void test_precopy_file_offset_bad(void)
>      test_file_common(&args, false);
>  }
>  
> +static void *test_mode_reboot_start(QTestState *from, QTestState *to)
> +{
> +    migrate_set_parameter_str(from, "mode", "cpr-reboot");
> +    migrate_set_parameter_str(to, "mode", "cpr-reboot");
> +
> +    migrate_set_capability(from, "x-ignore-shared", true);
> +    migrate_set_capability(to, "x-ignore-shared", true);
> +
> +    return NULL;
> +}
> +
> +static void test_mode_reboot(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .start.use_shmem = true,
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = test_mode_reboot_start
> +    };
> +
> +    test_file_common(&args, true);
> +}
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -3056,6 +3081,8 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/precopy/file/offset/bad",
>                     test_precopy_file_offset_bad);
>  
> +    qtest_add_func("/migration/mode/reboot", test_mode_reboot);
> +
>  #ifdef CONFIG_GNUTLS
>      qtest_add_func("/migration/precopy/unix/tls/psk",
>                     test_precopy_unix_tls_psk);

We have an issue with this test on CI:

$ df -h /dev/shm
Filesystem      Size  Used Avail Use% Mounted on
shm              64M     0   64M   0% /dev/shm

These are shared CI runners, so AFAICT there's no way to increase the
shared memory size.

Reducing the memory for this single test also wouldn't work because we
can run migration-test for different archs in parallel + there's the
ivshmem_test which uses 4M.

Maybe just leave it out of CI? Laptops will probably have enough shared
memory to not hit this. If we add a warning comment to the test, might
be enough.

