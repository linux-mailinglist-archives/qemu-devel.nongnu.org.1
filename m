Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E78C153F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 21:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s59Em-0008LJ-96; Thu, 09 May 2024 15:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s59EM-0008Gn-Jg
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:15:03 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s59EK-0003vy-DG
 for qemu-devel@nongnu.org; Thu, 09 May 2024 15:15:02 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6198E38BE1;
 Thu,  9 May 2024 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715282096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+dGz2QiGLGEwEfVAB3NOijkj00HVUYwIWG54J/ooIJ8=;
 b=PKj//6JxNcW9xufJmJk3DvsYSvh+N1ohjm+c7hoRj/FPDTDSkCeEJZPpnkQFn/OBLWuFhb
 hM9b7jSgecnJrJj1DRi4aHeReGo8e2m1+f7jzD/rH4JbbtN5sbp5ZaKErbpTwDHOd5f5Wj
 axxguUMbcvz0EHdvE97+dtuLHag3S6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715282096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+dGz2QiGLGEwEfVAB3NOijkj00HVUYwIWG54J/ooIJ8=;
 b=vSCq4YRMomYOWtRtei4YCejlFRdK9PfwOTf4blydqGbllPKeUeezUMtHl6KCp7oAYhqZhq
 kfVPx/+vR/7Q7hAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PKj//6Jx";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vSCq4YRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715282096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+dGz2QiGLGEwEfVAB3NOijkj00HVUYwIWG54J/ooIJ8=;
 b=PKj//6JxNcW9xufJmJk3DvsYSvh+N1ohjm+c7hoRj/FPDTDSkCeEJZPpnkQFn/OBLWuFhb
 hM9b7jSgecnJrJj1DRi4aHeReGo8e2m1+f7jzD/rH4JbbtN5sbp5ZaKErbpTwDHOd5f5Wj
 axxguUMbcvz0EHdvE97+dtuLHag3S6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715282096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+dGz2QiGLGEwEfVAB3NOijkj00HVUYwIWG54J/ooIJ8=;
 b=vSCq4YRMomYOWtRtei4YCejlFRdK9PfwOTf4blydqGbllPKeUeezUMtHl6KCp7oAYhqZhq
 kfVPx/+vR/7Q7hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2A1913A24;
 Thu,  9 May 2024 19:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tpA5Jq8gPWYPUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 May 2024 19:14:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 26/26] migration: only-migratable-modes
In-Reply-To: <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
Date: Thu, 09 May 2024 16:14:53 -0300
Message-ID: <87ikzmkdaq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6198E38BE1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add the only-migratable-modes option as a generalization of only-migratable.
> Only devices that support all requested modes are allowed.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h       |  3 +++
>  include/sysemu/sysemu.h        |  1 -
>  migration/migration-hmp-cmds.c | 26 +++++++++++++++++++++++++-
>  migration/migration.c          | 22 +++++++++++++++++-----
>  migration/savevm.c             |  2 +-
>  qemu-options.hx                | 16 ++++++++++++++--
>  system/globals.c               |  1 -
>  system/vl.c                    | 13 ++++++++++++-
>  target/s390x/cpu_models.c      |  4 +++-
>  9 files changed, 75 insertions(+), 13 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 5b963ba..3ad2cd9 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -119,6 +119,9 @@ bool migration_incoming_postcopy_advised(void);
>  /* True if background snapshot is active */
>  bool migration_in_bg_snapshot(void);
>  
> +void migration_set_required_mode(MigMode mode);
> +bool migration_mode_required(MigMode mode);
> +
>  /* migration/block-dirty-bitmap.c */
>  void dirty_bitmap_mig_init(void);
>  
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 5b4397e..0a9c4b4 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -8,7 +8,6 @@
>  
>  /* vl.c */
>  
> -extern int only_migratable;
>  extern const char *qemu_name;
>  extern QemuUUID qemu_uuid;
>  extern bool qemu_uuid_set;
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 414c7e8..ca913b7 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "block/qapi.h"
>  #include "migration/snapshot.h"
> +#include "migration/misc.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
>  #include "qapi/error.h"
> @@ -33,6 +34,28 @@
>  #include "options.h"
>  #include "migration.h"
>  
> +static void migration_dump_modes(Monitor *mon)
> +{
> +    int mode, n = 0;
> +
> +    monitor_printf(mon, "only-migratable-modes: ");
> +
> +    for (mode = 0; mode < MIG_MODE__MAX; mode++) {
> +        if (migration_mode_required(mode)) {
> +            if (n++) {
> +                monitor_printf(mon, ",");
> +            }
> +            monitor_printf(mon, "%s", MigMode_str(mode));
> +        }
> +    }
> +
> +    if (!n) {
> +        monitor_printf(mon, "none\n");
> +    } else {
> +        monitor_printf(mon, "\n");
> +    }
> +}
> +
>  static void migration_global_dump(Monitor *mon)
>  {
>      MigrationState *ms = migrate_get_current();
> @@ -41,7 +64,7 @@ static void migration_global_dump(Monitor *mon)
>      monitor_printf(mon, "store-global-state: %s\n",
>                     ms->store_global_state ? "on" : "off");
>      monitor_printf(mon, "only-migratable: %s\n",
> -                   only_migratable ? "on" : "off");
> +                   migration_mode_required(MIG_MODE_NORMAL) ? "on" : "off");
>      monitor_printf(mon, "send-configuration: %s\n",
>                     ms->send_configuration ? "on" : "off");
>      monitor_printf(mon, "send-section-footer: %s\n",
> @@ -50,6 +73,7 @@ static void migration_global_dump(Monitor *mon)
>                     ms->decompress_error_check ? "on" : "off");
>      monitor_printf(mon, "clear-bitmap-shift: %u\n",
>                     ms->clear_bitmap_shift);
> +    migration_dump_modes(mon);
>  }
>  
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> diff --git a/migration/migration.c b/migration/migration.c
> index 4984dee..5535b84 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1719,17 +1719,29 @@ static bool is_busy(Error **reasonp, Error **errp)
>      return false;
>  }
>  
> -static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
> +static int migration_modes_required;
> +
> +void migration_set_required_mode(MigMode mode)
> +{
> +    migration_modes_required |= BIT(mode);
> +}
> +
> +bool migration_mode_required(MigMode mode)
> +{
> +    return !!(migration_modes_required & BIT(mode));
> +}
> +
> +static bool modes_are_required(Error **reasonp, Error **errp, int modes)
>  {
>      ERRP_GUARD();
>  
> -    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
> +    if (migration_modes_required & modes) {
>          error_propagate_prepend(errp, *reasonp,
> -                                "disallowing migration blocker "
> -                                "(--only-migratable) for: ");
> +                                "-only-migratable{-modes}  specified, but: ");

extra space before 'specified'

>          *reasonp = NULL;
>          return true;
>      }
> +
>      return false;
>  }
>  
> @@ -1783,7 +1795,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
>      modes = get_modes(mode, ap);
>      va_end(ap);
>  
> -    if (is_only_migratable(reasonp, errp, modes)) {
> +    if (modes_are_required(reasonp, errp, modes)) {
>          return -EACCES;
>      } else if (is_busy(reasonp, errp)) {
>          return -EBUSY;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 6087c3a..e53ac84 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3585,7 +3585,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
>  bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>  {
>      /* check needed if --only-migratable is specified */
> -    if (!only_migratable) {
> +    if (!migration_mode_required(MIG_MODE_NORMAL)) {
>          return true;
>      }
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f0dfda5..946d731 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4807,8 +4807,20 @@ DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>      "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
>  SRST
>  ``-only-migratable``
> -    Only allow migratable devices. Devices will not be allowed to enter
> -    an unmigratable state.
> +    Only allow devices that can migrate using normal mode. Devices will not
> +    be allowed to enter an unmigratable state.

What's a "normal" mode is what people will ask. I don't think we need to
expose this. This option never had anything to do with "modes" and I
think we can keep it this way. See below...

> +ERST
> +
> +DEF("only-migratable-modes", HAS_ARG, QEMU_OPTION_only_migratable_modes, \
> +    "-only-migratable-modes mode1[,...]\n"
> +    "                allow only devices that are migratable using mode(s)\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-only-migratable-modes mode1[,...]``
> +    Only allow devices which are migratable using all modes in the list,
> +    which guarantees that migration will not fail due to a blocker.
> +    If both only-migratable-modes and only-migratable are specified,
> +    or are specified multiple times, then the required modes accumulate.
>  ERST
>  
>  DEF("nodefaults", 0, QEMU_OPTION_nodefaults, \
> diff --git a/system/globals.c b/system/globals.c
> index e353584..fdc263e 100644
> --- a/system/globals.c
> +++ b/system/globals.c
> @@ -48,7 +48,6 @@ const char *qemu_name;
>  unsigned int nb_prom_envs;
>  const char *prom_envs[MAX_PROM_ENVS];
>  uint8_t *boot_splash_filedata;
> -int only_migratable; /* turn it off unless user states otherwise */
>  int icount_align_option;
>  
>  /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
> diff --git a/system/vl.c b/system/vl.c
> index b76881e..7e73be9 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3458,7 +3458,18 @@ void qemu_init(int argc, char **argv)
>                  incoming = optarg;
>                  break;
>              case QEMU_OPTION_only_migratable:
> -                only_migratable = 1;
> +                migration_set_required_mode(MIG_MODE_NORMAL);

...from the point of view of user intent, I think this should be
MIG_MODE_ALL. If I have this option set I never want to see a blocker,
period. That's not a change in behavior because the mode has to be
explicitly selected anyway.

> +                break;
> +            case QEMU_OPTION_only_migratable_modes:
> +                {
> +                    int i, mode;
> +                    g_autofree char **words = g_strsplit(optarg, ",", -1);
> +                    for (i = 0; words[i]; i++) {
> +                        mode = qapi_enum_parse(&MigMode_lookup, words[i], -1,
> +                                               &error_fatal);
> +                        migration_set_required_mode(mode);

This option can be used to refine the modes being considered, it should
take precedence if both are present.

> +                    }
> +                }
>                  break;
>              case QEMU_OPTION_nodefaults:
>                  has_defaults = 0;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 8ed3bb6..42ad160 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -16,6 +16,7 @@
>  #include "kvm/kvm_s390x.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qapi/visitor.h"
> @@ -526,7 +527,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>      }
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
> +    if (migration_mode_required(MIG_MODE_NORMAL) &&
> +        test_bit(S390_FEAT_UNPACK, model->features)) {
>          error_setg(errp, "The unpack facility is not compatible with "
>                     "the --only-migratable option. You must remove either "
>                     "the 'unpack' facility or the --only-migratable option");

