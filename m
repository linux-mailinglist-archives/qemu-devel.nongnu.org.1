Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA38BB50B
	for <lists+qemu-devel@lfdr.de>; Fri,  3 May 2024 22:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2zqi-0001rh-NS; Fri, 03 May 2024 16:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2zqf-0001rP-SI
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:49:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2zqb-0000iu-3N
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:49:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 293F733CFA;
 Fri,  3 May 2024 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714769375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sce7HrNOhUJdDp6p96pcte9MF5aX4MoQc31iYnuuyEw=;
 b=biJaSPqQea1H7W7CkahyRQklTib9P6FrPaAGYTZqYHDo2BVuLOpO6mDaC6li4YEi5Y8x3X
 0TXIgreDbwFlNzHbJpGat6rU2hzxlM9zNnp/W+M5c/GlqEy4Gss5rJDrcqduqk8TEi+HQd
 EOGqorkLdkVTgfzshpFrUTEXMyKZJ9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714769375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sce7HrNOhUJdDp6p96pcte9MF5aX4MoQc31iYnuuyEw=;
 b=5XzDkxLFNRwDNXKE4x3sT3YlET0P/M/Zl847cCGkjm6SA1lwBQRymdxEQFrBjDFx5Dj/36
 Fi9GqjSTkYp0c9Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=biJaSPqQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5XzDkxLF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714769375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sce7HrNOhUJdDp6p96pcte9MF5aX4MoQc31iYnuuyEw=;
 b=biJaSPqQea1H7W7CkahyRQklTib9P6FrPaAGYTZqYHDo2BVuLOpO6mDaC6li4YEi5Y8x3X
 0TXIgreDbwFlNzHbJpGat6rU2hzxlM9zNnp/W+M5c/GlqEy4Gss5rJDrcqduqk8TEi+HQd
 EOGqorkLdkVTgfzshpFrUTEXMyKZJ9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714769375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sce7HrNOhUJdDp6p96pcte9MF5aX4MoQc31iYnuuyEw=;
 b=5XzDkxLFNRwDNXKE4x3sT3YlET0P/M/Zl847cCGkjm6SA1lwBQRymdxEQFrBjDFx5Dj/36
 Fi9GqjSTkYp0c9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A66CC13991;
 Fri,  3 May 2024 20:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PkzKG95NNWaHCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 20:49:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH 4/9] migration: Add direct-io parameter
In-Reply-To: <ZjUnghSvdy-wWtnN@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-5-farosas@suse.de> <ZjUnghSvdy-wWtnN@x1n>
Date: Fri, 03 May 2024 17:49:32 -0300
Message-ID: <871q6ioc2r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 293F733CFA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Fri, Apr 26, 2024 at 11:20:37AM -0300, Fabiano Rosas wrote:
>> Add the direct-io migration parameter that tells the migration code to
>> use O_DIRECT when opening the migration stream file whenever possible.
>> 
>> This is currently only used with the mapped-ram migration that has a
>> clear window guaranteed to perform aligned writes.
>> 
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/qemu/osdep.h           |  2 ++
>>  migration/migration-hmp-cmds.c | 11 +++++++++++
>>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>  migration/options.h            |  1 +
>>  qapi/migration.json            | 18 +++++++++++++++---
>>  util/osdep.c                   |  9 +++++++++
>>  6 files changed, 68 insertions(+), 3 deletions(-)
>> 
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index c7053cdc2b..645c14a65d 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -612,6 +612,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
>>  bool qemu_has_ofd_lock(void);
>>  #endif
>>  
>> +bool qemu_has_direct_io(void);
>> +
>>  #if defined(__HAIKU__) && defined(__i386__)
>>  #define FMT_pid "%ld"
>>  #elif defined(WIN64)
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 7e96ae6ffd..8496a2b34e 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -397,6 +397,13 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>          monitor_printf(mon, "%s: %s\n",
>>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>>              qapi_enum_lookup(&MigMode_lookup, params->mode));
>> +
>> +        if (params->has_direct_io) {
>> +            monitor_printf(mon, "%s: %s\n",
>> +                           MigrationParameter_str(
>> +                               MIGRATION_PARAMETER_DIRECT_IO),
>> +                           params->direct_io ? "on" : "off");
>> +        }
>
> This will be the first parameter to optionally display here.  I think it's
> a sign of misuse of has_direct_io field..
>
> IMHO has_direct_io should be best to be kept as "whether direct_io field is
> valid" and that's all of it.  It hopefully shouldn't contain more
> information than that, or otherwise it'll be another small challenge we
> need to overcome when we can remove all these has_* fields, and can also be
> easily overlooked.

I don't think I understand why we have those has_* fields. I thought my
usage of 'params->has_direct_io = qemu_has_direct_io()' was the correct
one, i.e. checking whether QEMU has any support for that parameter. Can
you help me out here?

>
> IMHO what we should do is assert has_direct_io==true here too, meanwhile...
>
>>      }
>>  
>>      qapi_free_MigrationParameters(params);
>> @@ -690,6 +697,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>          p->has_mode = true;
>>          visit_type_MigMode(v, param, &p->mode, &err);
>>          break;
>> +    case MIGRATION_PARAMETER_DIRECT_IO:
>> +        p->has_direct_io = true;
>> +        visit_type_bool(v, param, &p->direct_io, &err);
>> +        break;
>>      default:
>>          assert(0);
>>      }
>> diff --git a/migration/options.c b/migration/options.c
>> index 239f5ecfb4..ae464aa4f2 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -826,6 +826,22 @@ int migrate_decompress_threads(void)
>>      return s->parameters.decompress_threads;
>>  }
>>  
>> +bool migrate_direct_io(void)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +
>> +    /* For now O_DIRECT is only supported with mapped-ram */
>> +    if (!s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM]) {
>> +        return false;
>> +    }
>> +
>> +    if (s->parameters.has_direct_io) {
>> +        return s->parameters.direct_io;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>  uint64_t migrate_downtime_limit(void)
>>  {
>>      MigrationState *s = migrate_get_current();
>> @@ -1061,6 +1077,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
>>      params->has_zero_page_detection = true;
>>      params->zero_page_detection = s->parameters.zero_page_detection;
>>  
>> +    if (s->parameters.has_direct_io) {
>> +        params->has_direct_io = true;
>> +        params->direct_io = s->parameters.direct_io;
>> +    }
>> +
>>      return params;
>>  }
>>  
>> @@ -1097,6 +1118,7 @@ void migrate_params_init(MigrationParameters *params)
>>      params->has_vcpu_dirty_limit = true;
>>      params->has_mode = true;
>>      params->has_zero_page_detection = true;
>> +    params->has_direct_io = qemu_has_direct_io();
>>  }
>>  
>>  /*
>> @@ -1416,6 +1438,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>      if (params->has_zero_page_detection) {
>>          dest->zero_page_detection = params->zero_page_detection;
>>      }
>> +
>> +    if (params->has_direct_io) {
>> +        dest->direct_io = params->direct_io;
>
> .. do proper check here to make sure the current QEMU is built with direct
> IO support, then fail QMP migrate-set-parameters otherwise when someone
> tries to enable it on a QEMU that doesn't support it.

I'm already checking at migrate_params_init() with
qemu_has_direct_io(). But ok, you want to move it here... Is this
function the correct one instead of migrate_params_check()? I see these
TODO comments mentioning QAPI_CLONE(), we can't clone the object if this
one parameter needs special treatment. I might be getting all this
wrong, bear with me.

>
> Always displaying direct_io parameter also helps when we simply want to
> check qemu version and whether it supports this feature in general.
>

Makes sense.

>> +    }
>>  }
>>  
>>  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>> @@ -1570,6 +1596,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>      if (params->has_zero_page_detection) {
>>          s->parameters.zero_page_detection = params->zero_page_detection;
>>      }
>> +
>> +    if (params->has_direct_io) {
>> +        s->parameters.direct_io = params->direct_io;
>> +    }
>>  }
>>  
>>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>> diff --git a/migration/options.h b/migration/options.h
>> index ab8199e207..aa5509cd2a 100644
>> --- a/migration/options.h
>> +++ b/migration/options.h
>> @@ -76,6 +76,7 @@ uint8_t migrate_cpu_throttle_increment(void);
>>  uint8_t migrate_cpu_throttle_initial(void);
>>  bool migrate_cpu_throttle_tailslow(void);
>>  int migrate_decompress_threads(void);
>> +bool migrate_direct_io(void);
>>  uint64_t migrate_downtime_limit(void);
>>  uint8_t migrate_max_cpu_throttle(void);
>>  uint64_t migrate_max_bandwidth(void);
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 8c65b90328..1a8a4b114c 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -914,6 +914,9 @@
>>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>  #     (since 9.0)
>>  #
>> +# @direct-io: Open migration files with O_DIRECT when possible. This
>> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
>
> Here it seems to imply setting direct-io=true will fail if mapped-ram not
> enabled, but in reality it's fine, it'll just be ignored.  I think that's
> the right thing to do to reduce correlation effects between params/caps
> (otherwise, when unset mapped-ram cap, we'll need to double check again to
> unset direct-io too; just cumbersome).
>
> I suggest we state the fact, that this field is ignored when mapped-ram
> capability is not enabled, rather than "requires mapped-ram".  Same to all
> the rest two places in qapi doc.
>

Ok.

>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -948,7 +951,8 @@
>>             { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
>>             'vcpu-dirty-limit',
>>             'mode',
>> -           'zero-page-detection'] }
>> +           'zero-page-detection',
>> +           'direct-io'] }
>>  
>>  ##
>>  # @MigrateSetParameters:
>> @@ -1122,6 +1126,9 @@
>>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>  #     (since 9.0)
>>  #
>> +# @direct-io: Open migration files with O_DIRECT when possible. This
>> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1176,7 +1183,8 @@
>>                                              'features': [ 'unstable' ] },
>>              '*vcpu-dirty-limit': 'uint64',
>>              '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection'} }
>> +            '*zero-page-detection': 'ZeroPageDetection',
>> +            '*direct-io': 'bool' } }
>>  
>>  ##
>>  # @migrate-set-parameters:
>> @@ -1354,6 +1362,9 @@
>>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>>  #     (since 9.0)
>>  #
>> +# @direct-io: Open migration files with O_DIRECT when possible. This
>> +#     requires that the @mapped-ram capability is enabled. (since 9.1)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block-incremental is deprecated.  Use
>> @@ -1405,7 +1416,8 @@
>>                                              'features': [ 'unstable' ] },
>>              '*vcpu-dirty-limit': 'uint64',
>>              '*mode': 'MigMode',
>> -            '*zero-page-detection': 'ZeroPageDetection'} }
>> +            '*zero-page-detection': 'ZeroPageDetection',
>> +            '*direct-io': 'bool' } }
>>  
>>  ##
>>  # @query-migrate-parameters:
>> diff --git a/util/osdep.c b/util/osdep.c
>> index e996c4744a..d0227a60ab 100644
>> --- a/util/osdep.c
>> +++ b/util/osdep.c
>> @@ -277,6 +277,15 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
>>  }
>>  #endif
>>  
>> +bool qemu_has_direct_io(void)
>> +{
>> +#ifdef O_DIRECT
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>>  static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
>>  {
>>      int ret;
>> -- 
>> 2.35.3
>> 

