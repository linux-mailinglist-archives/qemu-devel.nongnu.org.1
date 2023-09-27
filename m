Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374957B0EC6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 00:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlcfg-0003LB-Hr; Wed, 27 Sep 2023 18:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlcff-0003L2-4F
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 18:06:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlcfd-0003Aq-DF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 18:06:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8191F894;
 Wed, 27 Sep 2023 22:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695852371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvUMazw78ySbTi86UQlAAZ1U2vCFW520Owx4U/2j0gk=;
 b=V1INGF6f/mm/T3ADoBK2rYciwGyQFva16YT+QRHOlJQzfMcuyV7taaXISDCAACKxeKEtyT
 8f7i7J2+JE0Q5e2IM0qTJ6uwVG6VLF1/hCVDam/72sxTV+PCk5xgSYOJ75hTnxQR3ACINW
 972OwzYH7iCtWmQ0j1NSph3Rd5DPPaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695852371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvUMazw78ySbTi86UQlAAZ1U2vCFW520Owx4U/2j0gk=;
 b=eshzfzVDXzr/DK1RMxu4W++AlaJooS9Ey7gAyPUi1X6yheGoof1X9Nle5NkHGi4A1jaHmK
 IsyAnrBxkb9i98CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30EED13479;
 Wed, 27 Sep 2023 22:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YzFrO1KnFGWTKwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 27 Sep 2023 22:06:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
In-Reply-To: <20230927214756.14117-1-farosas@suse.de>
References: <20230927214756.14117-1-farosas@suse.de>
Date: Wed, 27 Sep 2023 19:06:08 -0300
Message-ID: <87msx7qnjj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Fabiano Rosas <farosas@suse.de> writes:

> Add a smoke test that migrates to a file and gives it to the
> script. It should catch the most annoying errors such as changes in
> the ram flags.
>
> After code has been merged it becomes way harder to figure out what is
> causing the script to fail, the person making the change is the most
> likely to know right away what the problem is.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> I know this adds a python dependency to qtests and I'm not sure how
> much we care about this script, but on the other hand it would be nice
> to catch these errors early on.
>
> This would also help with future work that touches the migration
> stream (moving multifd out of ram.c and fixed-ram).
>
> Let me know what you think.
> ---
>  tests/qtest/meson.build      |  6 +++++
>  tests/qtest/migration-test.c | 51 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 1fba07f4ed..d2511b3227 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -301,6 +301,10 @@ if gnutls.found()
>    endif
>  endif
>=20=20
> +configure_file(input: meson.project_source_root() / 'scripts/analyze-mig=
ration.py',
> +               output: 'analyze-migration.py',
> +               configuration: configuration_data())
> +
>  qtests =3D {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
>    'cdrom-test': files('boot-sector.c'),
> @@ -356,6 +360,8 @@ foreach dir : target_dirs
>      test_deps +=3D [qsd]
>    endif
>=20=20
> +  qtest_env.set('PYTHON', python.full_path())
> +
>    foreach test : target_qtests
>      # Executables are shared across targets, declare them only the first=
 time we
>      # encounter them
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 1b43df5ca7..122089522f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -66,6 +66,8 @@ static bool got_dst_resume;
>   */
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>=20=20
> +#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -1486,6 +1488,52 @@ static void test_baddest(void)
>      test_migrate_end(from, to, false);
>  }
>=20=20
> +#ifndef _WIN32
> +static void test_analyze_script(void)
> +{
> +    MigrateStart args =3D {};
> +    QTestState *from, *to;
> +    g_autofree char *uri =3D NULL;
> +    g_autofree char *file =3D NULL;
> +    int pid, wstatus;
> +    const char *python =3D g_getenv("PYTHON");
> +
> +    if (!python) {
> +        g_test_skip("PYTHON variable not set");
> +        return;
> +    }
> +
> +    /* dummy url */
> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
> +        return;
> +    }
> +
> +    file =3D g_strdup_printf("%s/migfile", tmpfs);
> +    uri =3D g_strdup_printf("exec:cat > %s", file);
> +
> +    migrate_ensure_converge(from);
> +    migrate_qmp(from, uri, "{}");
> +    wait_for_migration_complete(from);
> +
> +    pid =3D fork();
> +    if (!pid) {
> +        close(1);
> +        open("/dev/null", O_WRONLY);
> +        execl(python, python, ANALYZE_SCRIPT,
> +              "-f", file, NULL);
> +        g_assert_not_reached();
> +    }
> +
> +    assert(waitpid(pid, &wstatus, 0) =3D=3D pid);
> +    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
> +        g_test_message("Failed to analyze the migration stream");
> +        g_test_fail();

I just noticed that this is really nice because it fails the test
without aborting, so we get a nice line in the output like this:

=E2=96=B6  44/355 /x86_64/migration/analyze-script  FAIL

which means that if we could replace some asserts with g_test_fail in
the migration code we would actually see what failed without having to
look at the "ok" line in the log and guess what the next test was.

> +    }
> +    test_migrate_end(from, to, false);
> +    cleanup("migfile");
> +}
> +#endif
> +
>  static void test_precopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -2828,6 +2876,9 @@ int main(int argc, char **argv)
>      }
>=20=20
>      qtest_add_func("/migration/bad_dest", test_baddest);
> +#ifndef _WIN32
> +    qtest_add_func("/migration/analyze-script", test_analyze_script);
> +#endif
>      qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_pl=
ain);
>      qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_x=
bzrle);
>      /*

