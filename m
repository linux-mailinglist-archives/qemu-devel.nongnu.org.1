Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E516182B4E8
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 19:50:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO076-0005yn-AG; Thu, 11 Jan 2024 13:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rO072-0005qc-PE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:49:08 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rO070-0003jS-IW
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 13:49:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CBAD220C2;
 Thu, 11 Jan 2024 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704998945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfdOa9VY7oAhAy+a6KbNl4CsOIwl9YJCGMyEp0voWJo=;
 b=wO+sTcdi/74jPmpSwCdif31z9BecH9bowgy+dsnosq+dBp7OFh89E+gHNZXfTEik/h0y1a
 swSyPHpaOUVbd53+DcoGUJUVsQdW0DYqvfdy0eovsQ7zLtY5WRvGmHlqVacyiURMISiBd6
 PiR/Jco6KFsnY0LHJMc00PTIPtlA75A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704998945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfdOa9VY7oAhAy+a6KbNl4CsOIwl9YJCGMyEp0voWJo=;
 b=8e8fhvyEQv4UiZdyF/DAw6i/t0hLtlEtrFc8/oPfU9zq3gvk0NI31eGX+IIRtjaGesdpQE
 KZGA00h/pvVgIJDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704998945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfdOa9VY7oAhAy+a6KbNl4CsOIwl9YJCGMyEp0voWJo=;
 b=wO+sTcdi/74jPmpSwCdif31z9BecH9bowgy+dsnosq+dBp7OFh89E+gHNZXfTEik/h0y1a
 swSyPHpaOUVbd53+DcoGUJUVsQdW0DYqvfdy0eovsQ7zLtY5WRvGmHlqVacyiURMISiBd6
 PiR/Jco6KFsnY0LHJMc00PTIPtlA75A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704998945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfdOa9VY7oAhAy+a6KbNl4CsOIwl9YJCGMyEp0voWJo=;
 b=8e8fhvyEQv4UiZdyF/DAw6i/t0hLtlEtrFc8/oPfU9zq3gvk0NI31eGX+IIRtjaGesdpQE
 KZGA00h/pvVgIJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D34132CF;
 Thu, 11 Jan 2024 18:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 81F5HSA4oGUnegAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jan 2024 18:49:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 05/30] migration/qemu-file: add utility methods
 for working with seekable channels
In-Reply-To: <ZZ-7ehYiGcvlHQmz@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-6-farosas@suse.de> <ZZ-7ehYiGcvlHQmz@x1n>
Date: Thu, 11 Jan 2024 15:49:01 -0300
Message-ID: <87ttnjn1sy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.10
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Nov 27, 2023 at 05:25:47PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>=20
>> Add utility methods that will be needed when implementing 'fixed-ram'
>> migration capability.
>>=20
>> qemu_file_is_seekable
>> qemu_put_buffer_at
>> qemu_get_buffer_at
>> qemu_set_offset
>> qemu_get_offset
>>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>>  include/migration/qemu-file-types.h |  2 +
>>  migration/qemu-file.c               | 82 +++++++++++++++++++++++++++++
>>  migration/qemu-file.h               |  6 +++
>>  3 files changed, 90 insertions(+)
>>=20
>> diff --git a/include/migration/qemu-file-types.h b/include/migration/qem=
u-file-types.h
>> index 9ba163f333..adec5abc07 100644
>> --- a/include/migration/qemu-file-types.h
>> +++ b/include/migration/qemu-file-types.h
>> @@ -50,6 +50,8 @@ unsigned int qemu_get_be16(QEMUFile *f);
>>  unsigned int qemu_get_be32(QEMUFile *f);
>>  uint64_t qemu_get_be64(QEMUFile *f);
>>=20=20
>> +bool qemu_file_is_seekable(QEMUFile *f);
>> +
>>  static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
>>  {
>>      qemu_put_be64(f, *pv);
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 94231ff295..faf6427b91 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -33,6 +33,7 @@
>>  #include "options.h"
>>  #include "qapi/error.h"
>>  #include "rdma.h"
>> +#include "io/channel-file.h"
>>=20=20
>>  #define IO_BUF_SIZE 32768
>>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
>> @@ -255,6 +256,10 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>      memset(f->may_free, 0, sizeof(f->may_free));
>>  }
>>=20=20
>> +bool qemu_file_is_seekable(QEMUFile *f)
>> +{
>> +    return qio_channel_has_feature(f->ioc, QIO_CHANNEL_FEATURE_SEEKABLE=
);
>> +}
>>=20=20
>>  /**
>>   * Flushes QEMUFile buffer
>> @@ -447,6 +452,83 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *bu=
f, size_t size)
>>      }
>>  }
>>=20=20
>> +void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>> +                        off_t pos)
>> +{
>> +    Error *err =3D NULL;
>> +
>> +    if (f->last_error) {
>> +        return;
>> +    }
>> +
>> +    qemu_fflush(f);
>> +    qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
>
> Partial writes won't set err.  Do we want to check the retval here too and
> fail properly if detected partial writes?
>

Yep.

>> +
>> +    if (err) {
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +    } else {
>> +        stat64_add(&mig_stats.qemu_file_transferred, buflen);
>
> buflen is only accurate if with above, iiuc.
>
>> +    }
>> +
>> +    return;
>> +}
>> +
>> +
>> +size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t bufle=
n,
>> +                          off_t pos)
>> +{
>> +    Error *err =3D NULL;
>> +    ssize_t ret;
>> +
>> +    if (f->last_error) {
>> +        return 0;
>> +    }
>> +
>> +    ret =3D qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
>
> Same question here.
>
>> +    if (ret =3D=3D -1 || err) {
>> +        goto error;
>> +    }
>> +
>> +    return (size_t)ret;
>> +
>> + error:
>> +    qemu_file_set_error_obj(f, -EIO, err);
>> +    return 0;
>> +}
>> +
>> +void qemu_set_offset(QEMUFile *f, off_t off, int whence)
>> +{
>> +    Error *err =3D NULL;
>> +    off_t ret;
>> +
>> +    qemu_fflush(f);
>> +
>> +    if (!qemu_file_is_writable(f)) {
>> +        f->buf_index =3D 0;
>> +        f->buf_size =3D 0;
>> +    }
>
> There's the qemu_file_is_writable() check after all, then put qemu_fflush=
()
> into condition too?
>
>   if (qemu_file_is_writable(f)) {
>       qemu_fflush(f);
>   } else {
>      /* Drop all the cached buffers if existed; will trigger a re-fill la=
ter */
>      f->buf_index =3D 0;
>      f->buf_size =3D 0;
>   }
>

Could be. I'll change it.

>> +
>> +    ret =3D qio_channel_io_seek(f->ioc, off, whence, &err);
>> +    if (ret =3D=3D (off_t)-1) {
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +    }
>> +}
>> +
>> +off_t qemu_get_offset(QEMUFile *f)
>> +{
>> +    Error *err =3D NULL;
>> +    off_t ret;
>> +
>> +    qemu_fflush(f);
>> +
>> +    ret =3D qio_channel_io_seek(f->ioc, 0, SEEK_CUR, &err);
>> +    if (ret =3D=3D (off_t)-1) {
>> +        qemu_file_set_error_obj(f, -EIO, err);
>> +    }
>> +    return ret;
>> +}
>> +
>> +
>>  void qemu_put_byte(QEMUFile *f, int v)
>>  {
>>      if (f->last_error) {
>> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>> index 8aec9fabf7..32fd4a34fd 100644
>> --- a/migration/qemu-file.h
>> +++ b/migration/qemu-file.h
>> @@ -75,6 +75,12 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>>  int qemu_fflush(QEMUFile *f);
>>  void qemu_file_set_blocking(QEMUFile *f, bool block);
>>  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
>> +void qemu_set_offset(QEMUFile *f, off_t off, int whence);
>> +off_t qemu_get_offset(QEMUFile *f);
>> +void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>> +                        off_t pos);
>> +size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t bufle=
n,
>> +                          off_t pos);
>>=20=20
>>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
>>=20=20
>> --=20
>> 2.35.3
>>=20

