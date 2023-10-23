Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07077D3724
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuL5-0002nc-3G; Mon, 23 Oct 2023 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quuKo-0002XL-Cx
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1quuKk-0003h9-QX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698065221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=btvW6KMmZAkCTGZo87KJbtFPguGbmIS3uolm+ASrD6k=;
 b=ahLdeSAkQAI27scBUV6ABevdxavbLRQeo9E4/NPbPdVPmyHwX0kw1P+xA6+aK8aZGPIL+W
 IfCxKG4kWXSgZ1zw9o2b1mtV7hdC2X9+dwt8hWiMG4zO8ihfYnu9fQYx5kdw501e83i6Cw
 cmyDU7VsPhTbKlTGeckJpy/XMzRvq0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ui7RXRLdPE2wJP3K6obe6A-1; Mon, 23 Oct 2023 08:46:58 -0400
X-MC-Unique: ui7RXRLdPE2wJP3K6obe6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0161B85C1A5;
 Mon, 23 Oct 2023 12:46:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D67DF503B;
 Mon, 23 Oct 2023 12:46:56 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:46:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1 2/4] migration: per-mode blockers
Message-ID: <ZTZrOb0XqOWPwFQj@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 19, 2023 at 01:47:44PM -0700, Steve Sistare wrote:
> Extend the blocker interface so that a blocker can be registered for
> one or more migration modes.  The existing interfaces register a
> blocker for all modes, and the new interfaces take a varargs list
> of modes.
> 
> Internally, maintain a separate blocker list per mode.  The same Error
> object may be added to multiple lists.  When a block is deleted, it is
> removed from every list, and the Error is freed.

I'm not sure that assocating blockers with migration modes is
the optimal way to model this.

IIUC, some of the migration blockers exist because the feature
relies on state that only exists on the current host.

This isn't a problem with CPR since the migration is within
the same host.  At the time though, these blockers should
likely be redundant for a normal migration that uses "localhost".

We can't express the distinction between localhost-migrate
and cross-host-migrate historically, but we should have done.
This new patch largely enables that I think which is good.

What I think this means is that we shouldn't tie blockers
to modes, but rather have different types of blockers as
a bit set

  enum MigrationBlockerType {
     MIGRATION_BLOCKER_LOCAL_HOST = (1 << 0),
     MIGRATION_BLOCKER_CROSS_HOST = (1 << 1),
  };

  #define MIGRATION_BLOCKER_ALL 0xff


Cpr would check for blockers with MIGRATION_BLOCKER_LOCAL_HOST
set only.

Normal migration within localhost only would similarly only
check MIGRATION_BLOCKER_LOCAL_HOST

Normal migration between arbitrary host would check for
MIGRATION_BLOCKER_LOCAL_HOST and MIGRATION_BLOCKER_CROSS_HOST



> 
> No functional change until a new mode is added.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/blocker.h | 44 +++++++++++++++++++--
>  migration/migration.c       | 95 ++++++++++++++++++++++++++++++++++++++-------
>  stubs/migr-blocker.c        | 10 +++++
>  3 files changed, 132 insertions(+), 17 deletions(-)
> 
> diff --git a/include/migration/blocker.h b/include/migration/blocker.h
> index b048f30..a687ac0 100644
> --- a/include/migration/blocker.h
> +++ b/include/migration/blocker.h
> @@ -14,8 +14,12 @@
>  #ifndef MIGRATION_BLOCKER_H
>  #define MIGRATION_BLOCKER_H
>  
> +#include "qapi/qapi-types-migration.h"
> +
> +#define MIG_MODE_ALL MIG_MODE__MAX
> +
>  /**
> - * @migrate_add_blocker - prevent migration from proceeding
> + * @migrate_add_blocker - prevent all modes of migration from proceeding
>   *
>   * @reasonp - address of an error to be returned whenever migration is attempted
>   *
> @@ -30,8 +34,8 @@
>  int migrate_add_blocker(Error **reasonp, Error **errp);
>  
>  /**
> - * @migrate_add_blocker_internal - prevent migration from proceeding without
> - *                                 only-migrate implications
> + * @migrate_add_blocker_internal - prevent all modes of migration from
> + *                                 proceeding, but ignore -only-migratable
>   *
>   * @reasonp - address of an error to be returned whenever migration is attempted
>   *
> @@ -50,7 +54,7 @@ int migrate_add_blocker(Error **reasonp, Error **errp);
>  int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>  
>  /**
> - * @migrate_del_blocker - remove a blocking error from migration and free it.
> + * @migrate_del_blocker - remove a migration blocker from all modes and free it.
>   *
>   * @reasonp - address of the error blocking migration
>   *
> @@ -58,4 +62,36 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp);
>   */
>  void migrate_del_blocker(Error **reasonp);
>  
> +/**
> + * @migrate_add_blocker_normal - prevent normal migration mode from proceeding
> + *
> + * @reasonp - address of an error to be returned whenever migration is attempted
> + *
> + * @errp - [out] The reason (if any) we cannot block migration right now.
> + *
> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free @reasonp, except by
> + *   calling migrate_del_blocker.
> + */
> +int migrate_add_blocker_normal(Error **reasonp, Error **errp);
> +
> +/**
> + * @migrate_add_blocker_modes - prevent some modes of migration from proceeding
> + *
> + * @reasonp - address of an error to be returned whenever migration is attempted
> + *
> + * @errp - [out] The reason (if any) we cannot block migration right now.
> + *
> + * @mode - one or more migration modes to be blocked.  The list is terminated
> + *         by -1 or MIG_MODE_ALL.  For the latter, all modes are blocked.
> + *
> + * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
> + *
> + * *@reasonp is freed and set to NULL if failure is returned.
> + * On success, the caller must not free *@reasonp before the blocker is removed.
> + */
> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 67547eb..b8b54e6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -92,7 +92,7 @@ enum mig_rp_message_type {
>  static MigrationState *current_migration;
>  static MigrationIncomingState *current_incoming;
>  
> -static GSList *migration_blockers;
> +static GSList *migration_blockers[MIG_MODE__MAX];
>  
>  static bool migration_object_check(MigrationState *ms, Error **errp);
>  static int migration_maybe_pause(MigrationState *s,
> @@ -1011,7 +1011,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>  {
>      MigrationState *s = migrate_get_current();
>      int state = qatomic_read(&s->state);
> -    GSList *cur_blocker = migration_blockers;
> +    GSList *cur_blocker = migration_blockers[migrate_mode()];
>  
>      info->blocked_reasons = NULL;
>  
> @@ -1475,38 +1475,105 @@ int migrate_init(MigrationState *s, Error **errp)
>      return 0;
>  }
>  
> -int migrate_add_blocker_internal(Error **reasonp, Error **errp)
> +static bool is_busy(Error **reasonp, Error **errp)
>  {
> +    ERRP_GUARD();
> +
>      /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
>      if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
>          error_propagate_prepend(errp, *reasonp,
>                                  "disallowing migration blocker "
>                                  "(migration/snapshot in progress) for: ");
>          *reasonp = NULL;
> -        return -EBUSY;
> +        return true;
>      }
> -
> -    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
> -    return 0;
> +    return false;
>  }
>  
> -int migrate_add_blocker(Error **reasonp, Error **errp)
> +static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
>  {
> -    if (only_migratable) {
> +    ERRP_GUARD();
> +
> +    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
>          error_propagate_prepend(errp, *reasonp,
>                                  "disallowing migration blocker "
>                                  "(--only-migratable) for: ");
>          *reasonp = NULL;
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static int get_modes(MigMode mode, va_list ap)
> +{
> +    int modes = 0;
> +
> +    while (mode != -1 && mode != MIG_MODE_ALL) {
> +        assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
> +        modes |= BIT(mode);
> +        mode = va_arg(ap, MigMode);
> +    }
> +    if (mode == MIG_MODE_ALL) {
> +        modes = BIT(MIG_MODE__MAX) - 1;
> +    }
> +    return modes;
> +}
> +
> +static int add_blockers(Error **reasonp, Error **errp, int modes)
> +{
> +    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> +        if (modes & BIT(mode)) {
> +            migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
> +                                                       *reasonp);
> +        }
> +    }
> +    return 0;
> +}
> +
> +int migrate_add_blocker(Error **reasonp, Error **errp)
> +{
> +    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_ALL);
> +}
> +
> +int migrate_add_blocker_normal(Error **reasonp, Error **errp)
> +{
> +    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
> +}
> +
> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
> +{
> +    int modes;
> +    va_list ap;
> +
> +    va_start(ap, mode);
> +    modes = get_modes(mode, ap);
> +    va_end(ap);
> +
> +    if (is_only_migratable(reasonp, errp, modes)) {
>          return -EACCES;
> +    } else if (is_busy(reasonp, errp)) {
> +        return -EBUSY;
>      }
> +    return add_blockers(reasonp, errp, modes);
> +}
>  
> -    return migrate_add_blocker_internal(reasonp, errp);
> +int migrate_add_blocker_internal(Error **reasonp, Error **errp)
> +{
> +    int modes = BIT(MIG_MODE__MAX) - 1;
> +
> +    if (is_busy(reasonp, errp)) {
> +        return -EBUSY;
> +    }
> +    return add_blockers(reasonp, errp, modes);
>  }
>  
>  void migrate_del_blocker(Error **reasonp)
>  {
>      if (*reasonp) {
> -        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
> +        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> +            migration_blockers[mode] = g_slist_remove(migration_blockers[mode],
> +                                                      *reasonp);
> +        }
>          error_free(*reasonp);
>          *reasonp = NULL;
>      }
> @@ -1602,12 +1669,14 @@ void qmp_migrate_pause(Error **errp)
>  
>  bool migration_is_blocked(Error **errp)
>  {
> +    GSList *blockers = migration_blockers[migrate_mode()];
> +
>      if (qemu_savevm_state_blocked(errp)) {
>          return true;
>      }
>  
> -    if (migration_blockers) {
> -        error_propagate(errp, error_copy(migration_blockers->data));
> +    if (blockers) {
> +        error_propagate(errp, error_copy(blockers->data));
>          return true;
>      }
>  
> diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
> index 17a5dbf..11cbff2 100644
> --- a/stubs/migr-blocker.c
> +++ b/stubs/migr-blocker.c
> @@ -6,6 +6,16 @@ int migrate_add_blocker(Error **reasonp, Error **errp)
>      return 0;
>  }
>  
> +int migrate_add_blocker_normal(Error **reasonp, Error **errp)
> +{
> +    return 0;
> +}
> +
> +int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
> +{
> +    return 0;
> +}
> +
>  void migrate_del_blocker(Error **reasonp)
>  {
>  }
> -- 
> 1.8.3.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


