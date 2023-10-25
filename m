Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3227D6E91
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveiV-0000M0-GS; Wed, 25 Oct 2023 10:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveiS-0000Li-6B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:18:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveiQ-0000sU-4z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:18:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2DC21FF66;
 Wed, 25 Oct 2023 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698243512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMb5hLXjGOx0fLlVZzzD+OHZOYVm+e7gON7ylwoRGDo=;
 b=hdSC9xmjc3nfO/pPlLnuIYgAFyj3sarZ1cR6Bw1atqysBwD4gLtD7SWB6wpc0o6dbrhEfT
 6oc37J4WNzq79Iy3XsdfV5+Csf1BAORBAFtDcCiQ/IBqbZ7mSJL6T9TQupAucTSoadt1Kz
 3ax5NZl3p1InP/pWQmW4WdVT8Uw+0hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698243512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMb5hLXjGOx0fLlVZzzD+OHZOYVm+e7gON7ylwoRGDo=;
 b=L0FHt2cwx1DjJRC4qV2B2xLxAIAuKsMCgZaTGdCM0anEFPuvh0Vnfc4SB5Etkoq53khFa0
 5pecoQtTpjgnwfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 467B7138E9;
 Wed, 25 Oct 2023 14:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YKz2BLgjOWUNGQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:18:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 20/29] migration/multifd: Add incoming QIOChannelFile
 support
In-Reply-To: <ZTjt+WB9FJmPjaVw@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-21-farosas@suse.de> <ZTjt+WB9FJmPjaVw@redhat.com>
Date: Wed, 25 Oct 2023 11:18:29 -0300
Message-ID: <87lebqeqfe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 23, 2023 at 05:35:59PM -0300, Fabiano Rosas wrote:
>> On the receiving side we don't need to differentiate between main
>> channel and threads, so whichever channel is defined first gets to be
>> the main one. And since there are no packets, use the atomic channel
>> count to index into the params array.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/file.c      | 39 +++++++++++++++++++++++++++++----------
>>  migration/migration.c |  2 ++
>>  migration/multifd.c   |  7 ++++++-
>>  migration/multifd.h   |  1 +
>>  4 files changed, 38 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/migration/file.c b/migration/file.c
>> index 93b9b7bf5d..ad75225f43 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -6,13 +6,15 @@
>>   */
>>=20=20
>>  #include "qemu/osdep.h"
>> -#include "qemu/cutils.h"
>>  #include "qapi/error.h"
>> +#include "qemu/cutils.h"
>> +#include "qemu/error-report.h"
>>  #include "channel.h"
>>  #include "file.h"
>>  #include "migration.h"
>>  #include "io/channel-file.h"
>>  #include "io/channel-util.h"
>> +#include "options.h"
>>  #include "trace.h"
>>=20=20
>>  #define OFFSET_OPTION ",offset=3D"
>> @@ -136,7 +138,8 @@ void file_start_incoming_migration(const char *files=
pec, Error **errp)
>>      g_autofree char *filename =3D g_strdup(filespec);
>>      QIOChannelFile *fioc =3D NULL;
>>      uint64_t offset =3D 0;
>> -    QIOChannel *ioc;
>> +    int channels =3D 1;
>> +    int i =3D 0, fd;
>>=20=20
>>      trace_migration_file_incoming(filename);
>>=20=20
>> @@ -146,16 +149,32 @@ void file_start_incoming_migration(const char *fil=
espec, Error **errp)
>>=20=20
>>      fioc =3D qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
>>      if (!fioc) {
>> -        return;
>> +        goto out;
>> +    }
>> +
>> +    if (migrate_multifd()) {
>> +        channels +=3D migrate_multifd_channels();
>>      }
>>=20=20
>> -    ioc =3D QIO_CHANNEL(fioc);
>> -    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0)=
 {
>> +    fd =3D fioc->fd;
>> +
>> +    do {
>> +        QIOChannel *ioc =3D QIO_CHANNEL(fioc);
>> +
>> +        if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) =
< 0) {
>> +            return;
>> +        }
>> +
>> +        qio_channel_set_name(ioc, "migration-file-incoming");
>> +        qio_channel_add_watch_full(ioc, G_IO_IN,
>> +                                   file_accept_incoming_migration,
>> +                                   NULL, NULL,
>> +                                   g_main_context_get_thread_default());
>> +    } while (++i < channels && (fioc =3D qio_channel_file_new_fd(fd)));
>
> IIUC, this loop is failing to call qio_channel_io_seek to set
> the offset on the last 'fioc' that is created.
>

Ah, this is actually bogus. We don't need to offset the secondary
channels. That does nothing since we carry pointers to everything in the
fixed-ram header. This should be out of the loop.


