Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E6753B5F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIML-0003Zl-G0; Fri, 14 Jul 2023 08:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKIMD-0003Wy-Ak
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:57:14 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qKIMA-0008OU-Vk
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:57:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F360B22132;
 Fri, 14 Jul 2023 12:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689339429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ap+lBBv26KckwMVVRm33ciSuFBwox7j3PT0PnQjS+wQ=;
 b=RToxDvJipIybzxjdlerEFmpSH9N6GromYzZezFCOuj09B2MI/bthMvw3GCtUp8MQwYgf4U
 eHCBB3cA6eeb33xCFHpCrt2pIX5Hd4fJhz1xtq/S3N2Btre6qcKGEavuICMvOYe44i/CQ3
 OaWyLvoajLefrV8oPxq4QhtAucOvyGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689339429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ap+lBBv26KckwMVVRm33ciSuFBwox7j3PT0PnQjS+wQ=;
 b=WRn0c4QDr6tSGXCgnMA4U0RrgVf2igrcPlhQPf8tJodZz0DZQ8pm8Z/QEDB/NyRy0WFyOF
 +RCE1iA1Fys76jAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85EEA13A15;
 Fri, 14 Jul 2023 12:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AudFFCRGsWQkYgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 14 Jul 2023 12:57:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 06/10] tests/qtest: migration events
In-Reply-To: <1688132988-314397-7-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
 <1688132988-314397-7-git-send-email-steven.sistare@oracle.com>
Date: Fri, 14 Jul 2023 09:57:06 -0300
Message-ID: <87v8emirbx.fsf@suse.de>
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

> Define a state object to capture events seen by migration tests, to allow
> more events to be captured in a subsequent patch, and simplify event
> checking in wait_for_migration_pass.  No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I'm working on top of this patch in another series and it works
fine. I have a patch adding the migration events to it (setup, active,
completed, etc).

> ---
>  tests/qtest/migration-helpers.c | 24 +++++----------
>  tests/qtest/migration-helpers.h |  8 +++--
>  tests/qtest/migration-test.c    | 68 +++++++++++++++++++----------------------
>  3 files changed, 44 insertions(+), 56 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index be00c52..b541108 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -23,26 +23,16 @@
>   */
>  #define MIGRATION_STATUS_WAIT_TIMEOUT 120
>  
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque)
> -{
> -    bool *seen = opaque;
> -
> -    if (g_str_equal(name, "STOP")) {
> -        *seen = true;
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque)
>  {
> -    bool *seen = opaque;
> +    QTestMigrationState *state = opaque;
>  
> -    if (g_str_equal(name, "RESUME")) {
> -        *seen = true;
> +    if (g_str_equal(name, "STOP")) {
> +        state->stop_seen = true;
> +        return true;
> +    } else if (g_str_equal(name, "RESUME")) {
> +        state->resume_seen = true;
>          return true;
>      }
>  
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 009e250..59fbb83 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -15,9 +15,11 @@
>  
>  #include "libqtest.h"
>  
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque);
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +typedef struct QTestMigrationState {
> +    bool stop_seen, resume_seen;
> +} QTestMigrationState;
> +
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
>  G_GNUC_PRINTF(3, 4)
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index b0c355b..2dde3af 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -43,8 +43,8 @@
>  unsigned start_address;
>  unsigned end_address;
>  static bool uffd_feature_thread_id;
> -static bool got_src_stop;
> -static bool got_dst_resume;
> +static QTestMigrationState src_state;
> +static QTestMigrationState dst_state;

It's a bit cumbersome though to have the QTestMigrationState in
migration-test.c and having to pass it around. Could we maybe move it
inside QTestState? That way it is easily reachable from
migrate-helpers.c and we could move all the wait* functions there.


