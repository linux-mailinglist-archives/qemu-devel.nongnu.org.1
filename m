Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E774FAF0
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 00:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJLpn-00012o-2f; Tue, 11 Jul 2023 18:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJLpl-00012g-FO
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 18:27:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJLpj-0004ib-TO
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 18:27:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 634A41FD9C;
 Tue, 11 Jul 2023 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689114465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzhEtB8uhxX6N6qULd1nEoHqLRVbmxqvItSuO5zmbgY=;
 b=lNCF0FBz/AlpTgxddQh453d4BnPQVNRTa4zwtdHP0QdLeCoOFhHnrmD1zMT2MwA+0pE+G5
 Au6TUGdTsBIidEx58Szt/FZDmmGYwkE1oYMTW4qfA6WjAlKr8/+X7hrrelBJ+BndhnMsEa
 tebZyb1lvsPlfDibGpbvY0HjR4inuzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689114465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzhEtB8uhxX6N6qULd1nEoHqLRVbmxqvItSuO5zmbgY=;
 b=DZWK2Ky3es5axOiMw4Lmq+EgwGtB4dS/Y4OTcaJJgobmu/E+YAr052OcVorhpFdSLOKzC+
 SlWe8zC0tlDfi4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E02A41390F;
 Tue, 11 Jul 2023 22:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jd6/KWDXrWTFUAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 11 Jul 2023 22:27:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Leonardo Bras <leobras@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v4 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
In-Reply-To: <20230706201927.15442-7-farosas@suse.de>
References: <20230706201927.15442-1-farosas@suse.de>
 <20230706201927.15442-7-farosas@suse.de>
Date: Tue, 11 Jul 2023 19:27:42 -0300
Message-ID: <87jzv6jd7l.fsf@suse.de>
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

Fabiano Rosas <farosas@suse.de> writes:

> Add basic tests for file-based migration.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-test.c | 99 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 2fdf6a115e..c052dbe1f1 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -52,6 +52,10 @@ static bool got_dst_resume;
>   */
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
> +#define QEMU_VM_FILE_MAGIC 0x5145564d
> +#define FILE_TEST_FILENAME "migfile"
> +#define FILE_TEST_OFFSET 0x1000
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -762,6 +766,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      cleanup("migsocket");
>      cleanup("src_serial");
>      cleanup("dest_serial");
> +    cleanup(FILE_TEST_FILENAME);
>  }
>  
>  #ifdef CONFIG_GNUTLS
> @@ -1459,11 +1464,28 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> +            /*
> +             * For file based migration the target must begin its
> +             * migration after the source has finished.
> +             */
> +            if (strstr(connect_uri, "file:")) {
> +                migrate_incoming_qmp(to, connect_uri, "{}");
> +            }
> +

This is now broken since we merged commit e02f56e3de ("tests/qtest:
massively speed up migration-test").

We cannot monitor the destination while the source is still running
because we need the source to have finished writing to the file before
we can start the destination. I'll have to think of another way of
testing a migration that is done with a live source but asynchronous
incoming migration.

Any suggestions are welcome.

