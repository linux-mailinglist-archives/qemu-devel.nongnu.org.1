Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289A7D5B1D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 21:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMjO-00077O-Qe; Tue, 24 Oct 2023 15:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMjM-000770-Lx
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 15:06:20 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMjK-0007OH-Tv
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 15:06:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D3DF218F3;
 Tue, 24 Oct 2023 19:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698174377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7vwc5zd0ide69Os4Ak/qOs09grdf55wLsc82Koc4Co=;
 b=Z0+JEoOsuKHy6rAQqnjgEFvhfidV4w5WS8ozZHT71ZrqCq/BhAjYeJP7wboiqI4JI0NddE
 eJqvdUE4KtRqKl0QB8Zlx5DzDMWI5omhQOBQSDQPX5nraKLcfEH252N/F+Nyf2ZxapbF3j
 z7xN7MEO1BGFEwX1AC2dXSfEWohIZdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698174377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7vwc5zd0ide69Os4Ak/qOs09grdf55wLsc82Koc4Co=;
 b=Y4l20fB+rNjy4b1OTfm4YGcZBJ/nKXMc5mFpRolmkbV7pSJsScZr0uUQ/8vfRLn/BMV9dd
 jsz1xA3Go4YRTkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DDAE134F5;
 Tue, 24 Oct 2023 19:06:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8xzUMqgVOGXrNAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 19:06:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZTeBXtOGmOzT79xF@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <ZTeBXtOGmOzT79xF@redhat.com>
Date: Tue, 24 Oct 2023 16:06:14 -0300
Message-ID: <87sf5zdemx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 23, 2023 at 05:36:07PM -0300, Fabiano Rosas wrote:
>> Add the direct-io migration parameter that tells the migration code to
>> use O_DIRECT when opening the migration stream file whenever possible.
>>=20
>> This is currently only used for the secondary channels of fixed-ram
>> migration, which can guarantee that writes are page aligned.
>>=20
>> However the parameter could be made to affect other types of
>> file-based migrations in the future.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/qemu/osdep.h           |  2 ++
>>  migration/file.c               | 15 ++++++++++++---
>>  migration/migration-hmp-cmds.c | 10 ++++++++++
>>  migration/options.c            | 30 ++++++++++++++++++++++++++++++
>>  migration/options.h            |  1 +
>>  qapi/migration.json            | 17 ++++++++++++++---
>>  util/osdep.c                   |  9 +++++++++
>>  7 files changed, 78 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index 475a1c62ff..ea5d29ab9b 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -597,6 +597,8 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t=
 len, bool exclusive);
>>  bool qemu_has_ofd_lock(void);
>>  #endif
>>=20=20
>> +bool qemu_has_direct_io(void);
>> +
>>  #if defined(__HAIKU__) && defined(__i386__)
>>  #define FMT_pid "%ld"
>>  #elif defined(WIN64)
>> diff --git a/migration/file.c b/migration/file.c
>> index ad75225f43..3d3c58ecad 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -11,9 +11,9 @@
>>  #include "qemu/error-report.h"
>>  #include "channel.h"
>>  #include "file.h"
>> -#include "migration.h"
>>  #include "io/channel-file.h"
>>  #include "io/channel-util.h"
>> +#include "migration.h"
>>  #include "options.h"
>>  #include "trace.h"
>>=20=20
>> @@ -77,9 +77,18 @@ void file_send_channel_create(QIOTaskFunc f, void *da=
ta)
>>      QIOChannelFile *ioc;
>>      QIOTask *task;
>>      Error *errp =3D NULL;
>> +    int flags =3D outgoing_args.flags;
>>=20=20
>> -    ioc =3D qio_channel_file_new_path(outgoing_args.fname,
>> -                                    outgoing_args.flags,
>> +    if (migrate_direct_io() && qemu_has_direct_io()) {
>> +        /*
>> +         * Enable O_DIRECT for the secondary channels. These are used
>> +         * for sending ram pages and writes should be guaranteed to be
>> +         * aligned to at least page size.
>> +         */
>> +        flags |=3D O_DIRECT;
>> +    }
>
> IMHO we should not be silently ignoring the user's request for
> direct I/O if we've been comiled for a platform which can't
> support it. We should fail the setting of the direct I/O
> parameter
>

Good point.

> Also this is referencing O_DIRECT without any #ifdef check.
>

Ack.

>> +
>> +    ioc =3D qio_channel_file_new_path(outgoing_args.fname, flags,
>>                                      outgoing_args.mode, &errp);
>>      if (!ioc) {
>>          file_migration_cancel(errp);
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cm=
ds.c
>> index a82597f18e..eab5ac3588 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -387,6 +387,12 @@ void hmp_info_migrate_parameters(Monitor *mon, cons=
t QDict *qdict)
>>          monitor_printf(mon, "%s: %" PRIu64 " MB/s\n",
>>              MigrationParameter_str(MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT=
),
>>              params->vcpu_dirty_limit);
>> +
>> +        if (params->has_direct_io) {
>> +            monitor_printf(mon, "%s: %s\n",
>> +                           MigrationParameter_str(MIGRATION_PARAMETER_D=
IRECT_IO),
>> +                           params->direct_io ? "on" : "off");
>> +        }
>>      }
>>=20=20
>>      qapi_free_MigrationParameters(params);
>> @@ -661,6 +667,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
>>          p->has_vcpu_dirty_limit =3D true;
>>          visit_type_size(v, param, &p->vcpu_dirty_limit, &err);
>>          break;
>> +    case MIGRATION_PARAMETER_DIRECT_IO:
>> +        p->has_direct_io =3D true;
>> +        visit_type_bool(v, param, &p->direct_io, &err);
>> +        break;
>>      default:
>>          assert(0);
>>      }
>> diff --git a/migration/options.c b/migration/options.c
>> index 2193d69e71..6d0e3c26ae 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -817,6 +817,22 @@ int migrate_decompress_threads(void)
>>      return s->parameters.decompress_threads;
>>  }
>>=20=20
>> +bool migrate_direct_io(void)
>> +{
>> +    MigrationState *s =3D migrate_get_current();
>> +
>> +    /* For now O_DIRECT is only supported with fixed-ram */
>> +    if (!s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM]) {
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
>>      MigrationState *s =3D migrate_get_current();
>> @@ -1025,6 +1041,11 @@ MigrationParameters *qmp_query_migrate_parameters=
(Error **errp)
>>      params->has_vcpu_dirty_limit =3D true;
>>      params->vcpu_dirty_limit =3D s->parameters.vcpu_dirty_limit;
>>=20=20
>> +    if (s->parameters.has_direct_io) {
>> +        params->has_direct_io =3D true;
>> +        params->direct_io =3D s->parameters.direct_io;
>> +    }
>> +
>>      return params;
>>  }
>>=20=20
>> @@ -1059,6 +1080,7 @@ void migrate_params_init(MigrationParameters *para=
ms)
>>      params->has_announce_step =3D true;
>>      params->has_x_vcpu_dirty_limit_period =3D true;
>>      params->has_vcpu_dirty_limit =3D true;
>> +    params->has_direct_io =3D qemu_has_direct_io();
>>  }
>>=20=20
>>  /*
>> @@ -1356,6 +1378,10 @@ static void migrate_params_test_apply(MigrateSetP=
arameters *params,
>>      if (params->has_vcpu_dirty_limit) {
>>          dest->vcpu_dirty_limit =3D params->vcpu_dirty_limit;
>>      }
>> +
>> +    if (params->has_direct_io) {
>> +        dest->direct_io =3D params->direct_io;
>> +    }
>>  }
>>=20=20
>>  static void migrate_params_apply(MigrateSetParameters *params, Error **=
errp)
>> @@ -1486,6 +1512,10 @@ static void migrate_params_apply(MigrateSetParame=
ters *params, Error **errp)
>>      if (params->has_vcpu_dirty_limit) {
>>          s->parameters.vcpu_dirty_limit =3D params->vcpu_dirty_limit;
>>      }
>> +
>> +    if (params->has_direct_io) {
>
> #ifndef O_DIRECT
>      error_setg(errp, "Direct I/O is not supported on this platform");
> #endif=20=20=20=20=20
>
> Should also be doing a check for the 'fixed-ram' capability being
> set at this point.
>

Ok.


