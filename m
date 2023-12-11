Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A378A80DB0A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:45:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCmCP-0006dT-SU; Mon, 11 Dec 2023 14:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCmCM-0006dL-5q
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:44:14 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rCmCJ-0002pu-TY
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:44:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 812F31FBB3;
 Mon, 11 Dec 2023 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702323849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMFdQ5u+ehE4PH5a78kJqLHJ4ydiE1wfOGrEBtyzHns=;
 b=jvom0vdx/AlF+tyIWJflXeefDl7RRQy6HDOH7pWqNW38hZK0vztnlmhuwelK5A3BqsOnxC
 VH7U7geTe2OmoeIeBr/WKr0GvvC3z4fEKs3+eYMxjY3+3XyTAmKdWpJy5t+uzgTXCQq4Wc
 eFmQufMshRnj+cIrHb7eMQozr1tg45o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702323849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMFdQ5u+ehE4PH5a78kJqLHJ4ydiE1wfOGrEBtyzHns=;
 b=SXjAbkZqZf095okqYptfSmyfoiVR/mLUOPwhVMHU9zO0x3kgbTMmHlJyKzf3asAZHTLidK
 VcoHVdgmEA5IKJAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702323849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMFdQ5u+ehE4PH5a78kJqLHJ4ydiE1wfOGrEBtyzHns=;
 b=jvom0vdx/AlF+tyIWJflXeefDl7RRQy6HDOH7pWqNW38hZK0vztnlmhuwelK5A3BqsOnxC
 VH7U7geTe2OmoeIeBr/WKr0GvvC3z4fEKs3+eYMxjY3+3XyTAmKdWpJy5t+uzgTXCQq4Wc
 eFmQufMshRnj+cIrHb7eMQozr1tg45o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702323849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FMFdQ5u+ehE4PH5a78kJqLHJ4ydiE1wfOGrEBtyzHns=;
 b=SXjAbkZqZf095okqYptfSmyfoiVR/mLUOPwhVMHU9zO0x3kgbTMmHlJyKzf3asAZHTLidK
 VcoHVdgmEA5IKJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C48D132DA;
 Mon, 11 Dec 2023 19:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id giUKMYhmd2U7DAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Dec 2023 19:44:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 12/20] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <20231114054032.1192027-13-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-13-hao.xiang@bytedance.com>
Date: Mon, 11 Dec 2023 16:44:06 -0300
Message-ID: <87wmtkle2h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: 7.06
X-Spamd-Result: default: False [-12.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 R_SPF_SOFTFAIL(0.00)[~all:c]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+];
 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
 RCPT_COUNT_SEVEN(0.00)[8]; MX_GOOD(-0.01)[];
 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 WHITELIST_DMARC(-7.00)[suse.de:D:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 812F31FBB3
X-Spam-Score: -12.01
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jvom0vdx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SXjAbkZq;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de; 
 dmarc=pass (policy=none) header.from=suse.de
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration:
>
> multifd-dsa-accel="[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pathX]"
>
> This feature is turned off by default.

This patch breaks make check:

 43/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/test-hmp               ERROR           0.52s
 79/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test         ERROR           3.59s
167/357 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-cmd-test ERROR           3.68s

Make sure you run make check before posting. Ideally also run the series
through the Gitlab CI on your personal fork.

> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/migration-hmp-cmds.c |  8 ++++++++
>  migration/options.c            | 28 ++++++++++++++++++++++++++++
>  migration/options.h            |  1 +
>  qapi/migration.json            | 17 ++++++++++++++---
>  scripts/meson-buildoptions.sh  |  6 +++---
>  5 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 86ae832176..d9451744dd 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -353,6 +353,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: '%s'\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
>              params->tls_authz);
> +        monitor_printf(mon, "%s: %s\n",

Use '%s' here.

> +            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL),
> +            params->multifd_dsa_accel);
>  
>          if (params->has_block_bitmap_mapping) {
>              const BitmapMigrationNodeAliasList *bmnal;
> @@ -615,6 +618,11 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_block_incremental = true;
>          visit_type_bool(v, param, &p->block_incremental, &err);
>          break;
> +    case MIGRATION_PARAMETER_MULTIFD_DSA_ACCEL:
> +        p->multifd_dsa_accel = g_new0(StrOrNull, 1);
> +        p->multifd_dsa_accel->type = QTYPE_QSTRING;
> +        visit_type_str(v, param, &p->multifd_dsa_accel->u.s, &err);
> +        break;
>      case MIGRATION_PARAMETER_MULTIFD_CHANNELS:
>          p->has_multifd_channels = true;
>          visit_type_uint8(v, param, &p->multifd_channels, &err);
> diff --git a/migration/options.c b/migration/options.c
> index 97d121d4d7..6e424b5d63 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -179,6 +179,8 @@ Property migration_properties[] = {
>      DEFINE_PROP_MIG_MODE("mode", MigrationState,
>                        parameters.mode,
>                        MIG_MODE_NORMAL),
> +    DEFINE_PROP_STRING("multifd-dsa-accel", MigrationState,
> +                       parameters.multifd_dsa_accel),
>  
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> @@ -901,6 +903,13 @@ const char *migrate_tls_creds(void)
>      return s->parameters.tls_creds;
>  }
>  
> +const char *migrate_multifd_dsa_accel(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +
> +    return s->parameters.multifd_dsa_accel;
> +}
> +
>  const char *migrate_tls_hostname(void)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1025,6 +1034,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>      params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
>      params->has_mode = true;
>      params->mode = s->parameters.mode;
> +    params->multifd_dsa_accel = s->parameters.multifd_dsa_accel;
>  
>      return params;
>  }
> @@ -1033,6 +1043,7 @@ void migrate_params_init(MigrationParameters *params)
>  {
>      params->tls_hostname = g_strdup("");
>      params->tls_creds = g_strdup("");
> +    params->multifd_dsa_accel = g_strdup("");
>  
>      /* Set has_* up only for parameter checks */
>      params->has_compress_level = true;
> @@ -1362,6 +1373,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_mode) {
>          dest->mode = params->mode;
>      }
> +
> +    if (params->multifd_dsa_accel) {
> +        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
> +        dest->multifd_dsa_accel = params->multifd_dsa_accel->u.s;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> @@ -1506,6 +1522,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>      if (params->has_mode) {
>          s->parameters.mode = params->mode;
>      }
> +
> +    if (params->multifd_dsa_accel) {
> +        g_free(s->parameters.multifd_dsa_accel);
> +        assert(params->multifd_dsa_accel->type == QTYPE_QSTRING);
> +        s->parameters.multifd_dsa_accel = g_strdup(params->multifd_dsa_accel->u.s);
> +    }
>  }
>  
>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> @@ -1531,6 +1553,12 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>          params->tls_authz->type = QTYPE_QSTRING;
>          params->tls_authz->u.s = strdup("");
>      }
> +    if (params->multifd_dsa_accel
> +        && params->multifd_dsa_accel->type == QTYPE_QNULL) {
> +        qobject_unref(params->multifd_dsa_accel->u.n);
> +        params->multifd_dsa_accel->type = QTYPE_QSTRING;
> +        params->multifd_dsa_accel->u.s = strdup("");
> +    }
>  
>      migrate_params_test_apply(params, &tmp);
>  
> diff --git a/migration/options.h b/migration/options.h
> index c901eb57c6..56100961a9 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -94,6 +94,7 @@ const char *migrate_tls_authz(void);
>  const char *migrate_tls_creds(void);
>  const char *migrate_tls_hostname(void);
>  uint64_t migrate_xbzrle_cache_size(void);
> +const char *migrate_multifd_dsa_accel(void);
>  
>  /* parameters setters */
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9783289bfc..a8e3b66d6f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -879,6 +879,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#                     certain memory operations. (since 8.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -902,7 +905,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'cpu-throttle-tailslow',
>             'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
> -           'avail-switchover-bandwidth', 'downtime-limit',
> +           'avail-switchover-bandwidth', 'downtime-limit', 'multifd-dsa-accel',
>             { 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
>             { 'name': 'block-incremental', 'features': [ 'deprecated' ] },
>             'multifd-channels',
> @@ -1067,6 +1070,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#                     certain memory operations. (since 8.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1120,7 +1126,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*multifd-dsa-accel': 'StrOrNull'} }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1295,6 +1302,9 @@
>  # @mode: Migration mode. See description in @MigMode. Default is 'normal'.
>  #        (Since 8.2)
>  #
> +# @multifd-dsa-accel: If enabled, use DSA accelerator offloading for
> +#                     certain memory operations. (since 8.2)
> +#
>  # Features:
>  #
>  # @deprecated: Member @block-incremental is deprecated.  Use
> @@ -1345,7 +1355,8 @@
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
>                                              'features': [ 'unstable' ] },
>              '*vcpu-dirty-limit': 'uint64',
> -            '*mode': 'MigMode'} }
> +            '*mode': 'MigMode',
> +            '*multifd-dsa-accel': 'str'} }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index bf139e3fb4..35222ab63e 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -32,6 +32,7 @@ meson_options_help() {
>    printf "%s\n" '  --enable-debug-stack-usage'
>    printf "%s\n" '                           measure coroutine stack usage'
>    printf "%s\n" '  --enable-debug-tcg       TCG debugging'
> +  printf "%s\n" '  --enable-enqcmd          MENQCMD optimizations'
>    printf "%s\n" '  --enable-fdt[=CHOICE]    Whether and how to find the libfdt library'
>    printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
>    printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
> @@ -93,7 +94,6 @@ meson_options_help() {
>    printf "%s\n" '  avx2            AVX2 optimizations'
>    printf "%s\n" '  avx512bw        AVX512BW optimizations'
>    printf "%s\n" '  avx512f         AVX512F optimizations'
> -  printf "%s\n" '  enqcmd          ENQCMD optimizations'
>    printf "%s\n" '  blkio           libblkio block device driver'
>    printf "%s\n" '  bochs           bochs image format support'
>    printf "%s\n" '  bpf             eBPF support'
> @@ -241,8 +241,6 @@ _meson_option_parse() {
>      --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
>      --enable-avx512f) printf "%s" -Davx512f=enabled ;;
>      --disable-avx512f) printf "%s" -Davx512f=disabled ;;
> -    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
> -    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
>      --enable-gcov) printf "%s" -Db_coverage=true ;;
>      --disable-gcov) printf "%s" -Db_coverage=false ;;
>      --enable-lto) printf "%s" -Db_lto=true ;;
> @@ -309,6 +307,8 @@ _meson_option_parse() {
>      --disable-docs) printf "%s" -Ddocs=disabled ;;
>      --enable-dsound) printf "%s" -Ddsound=enabled ;;
>      --disable-dsound) printf "%s" -Ddsound=disabled ;;
> +    --enable-enqcmd) printf "%s" -Denqcmd=true ;;
> +    --disable-enqcmd) printf "%s" -Denqcmd=false ;;
>      --enable-fdt) printf "%s" -Dfdt=enabled ;;
>      --disable-fdt) printf "%s" -Dfdt=disabled ;;
>      --enable-fdt=*) quote_sh "-Dfdt=$2" ;;

