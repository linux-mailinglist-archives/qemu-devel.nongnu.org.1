Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B985D79D9B4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:41:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9FM-00028q-Fd; Tue, 12 Sep 2023 15:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qg9FI-00028L-GV
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:40:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qg9FG-0008E4-98
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 15:40:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 327282183A;
 Tue, 12 Sep 2023 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694547618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lo6LU52sc3kFf72aF3nYGNmnf3hKrCF7sxHlUNpC2uI=;
 b=IxVg885E0YBmH7Zfedc6GPXir8UfHDQvzW3/T+7BFGFW9wXVPV69UQqun7ieIVmpegYLBT
 iNSwx+5akX4lxFgq1DYBqOP5JahexdxQVqpH2VyBr5lIty5yywSOg+Elw/fpk5aUkbV1RF
 4znl4ISyUeiRQYKhRzw8uedus0kbpt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694547618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lo6LU52sc3kFf72aF3nYGNmnf3hKrCF7sxHlUNpC2uI=;
 b=A3Vcg85Kc9JYqmXji6mPK1Ap0oT1vcNu87s6O004JNzNHBpDmZTnSEHrVC1eRWNOMEi/Zo
 T6miqscLdXAuuADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EC0113A39;
 Tue, 12 Sep 2023 19:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +juVF6G+AGXraAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 12 Sep 2023 19:40:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 2/9] migration: Let migrate_set_error() take ownership
In-Reply-To: <20230829214235.69309-3-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-3-peterx@redhat.com>
Date: Tue, 12 Sep 2023 16:40:14 -0300
Message-ID: <87cyynkwo1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

> migrate_set_error() used one error_copy() so it always copy an error.
> However that's not the major use case - the major use case is one would
> like to pass the error to migrate_set_error() without further touching the
> error.
>
> It can be proved if we see most of the callers are freeing the error
> explicitly right afterwards.  There're a few outliers (only if when the
> caller) where we can use error_copy() explicitly there.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h    |  4 ++--
>  migration/channel.c      |  1 -
>  migration/migration.c    | 22 ++++++++++++++++------
>  migration/multifd.c      | 10 ++++------
>  migration/postcopy-ram.c |  1 -
>  migration/ram.c          |  1 -
>  6 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 6eea18db36..76e35a5ecf 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -465,7 +465,7 @@ bool  migration_has_all_channels(void);
>  
>  uint64_t migrate_max_downtime(void);
>  
> -void migrate_set_error(MigrationState *s, const Error *error);
> +void migrate_set_error(MigrationState *s, Error *error);
>  
>  void migrate_fd_connect(MigrationState *s, Error *error_in);
>  
> @@ -510,7 +510,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>  void migration_make_urgent_request(void);
>  void migration_consume_urgent_request(void);
>  bool migration_rate_limit(void);
> -void migration_cancel(const Error *error);
> +void migration_cancel(Error *error);
>  
>  void populate_vfio_info(MigrationInfo *info);
>  void reset_vfio_bytes_transferred(void);
> diff --git a/migration/channel.c b/migration/channel.c
> index ca3319a309..48b3f6abd6 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -90,7 +90,6 @@ void migration_channel_connect(MigrationState *s,
>          }
>      }
>      migrate_fd_connect(s, error);
> -    error_free(error);
>  }
>  
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index c60064d48e..0f3ca168ed 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -162,7 +162,7 @@ void migration_object_init(void)
>      dirty_bitmap_mig_init();
>  }
>  
> -void migration_cancel(const Error *error)
> +void migration_cancel(Error *error)
>  {
>      if (error) {
>          migrate_set_error(current_migration, error);
> @@ -1218,11 +1218,22 @@ static void migrate_fd_cleanup_bh(void *opaque)
>      object_unref(OBJECT(s));
>  }
>  
> -void migrate_set_error(MigrationState *s, const Error *error)
> +/*
> + * Set error for current migration state.  The `error' ownership will be
> + * moved from the caller to MigrationState, so the caller doesn't need to
> + * free the error.
> + *
> + * If the caller still needs to reference the `error' passed in, one should
> + * use error_copy() explicitly.
> + */
> +void migrate_set_error(MigrationState *s, Error *error)
>  {
>      QEMU_LOCK_GUARD(&s->error_mutex);
>      if (!s->error) {
> -        s->error = error_copy(error);
> +        /* Record the first error triggered */
> +        s->error = error;
> +    } else {
> +        error_free(error);

This will conflict logically with 908927db28 ("migration: Update error
description whenever migration fails") which does:

+            migrate_set_error(s, local_err);
+            error_report_err(local_err);

both functions may now try to free the error.


I'm working on top of this series to try to get rid of all of those
qemu_file_set_error() we have. I'm trying to use migrate_set_error()
whenever possible and only set f->last_error at the very bottom IO
functions.


