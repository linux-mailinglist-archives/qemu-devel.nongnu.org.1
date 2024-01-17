Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BFB830C79
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 19:09:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQALk-0001wg-Dq; Wed, 17 Jan 2024 13:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQALj-0001wX-0X
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:09:15 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQALg-00036N-Q0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 13:09:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 512031FCE4;
 Wed, 17 Jan 2024 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705514951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDtsT6ATYzm1xqoOi4krpoaJ4Z6HmrzCVOZIu1i9RwM=;
 b=ytMFBNyMepAvB+Vdcn6bXxyt6IhfnR8fj2KoRAtuoDCeErrEFJ/2Fw6WLB/o5W9uEIhZzM
 BqQeaX726q3RCGw+MhfanH5GaZGMl5+9dOXw0v1oXW/2yZ7zwuhPlLUjeMg0ua4214ALLQ
 ZM5XK7f0Ui1WgAh59UaESa6HvkwJqjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705514951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDtsT6ATYzm1xqoOi4krpoaJ4Z6HmrzCVOZIu1i9RwM=;
 b=bywc2KULHpD42sum8f1mLLaU5L3Ix4bX28ZtSkcQ5pQNRYniOm9tEvGaOGZUnTqcgDO91j
 MtQULqve18OU01Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705514949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDtsT6ATYzm1xqoOi4krpoaJ4Z6HmrzCVOZIu1i9RwM=;
 b=hfiM+H3CgYSOVeu30QnTEEHgjLO1vRZHzZaUVzHqkfT0/t1tJi9LjqOFKIKO/NWeK1bcB8
 LjIp0NG8G6w3/b0/ZImH8oEA/+1/m6FVlRAVAiTQ/qkDbmyKqVsy58YZuAnfWXwIbifCFH
 KJzdZVBLF56tG9Q706SdpjK2ZMwqw2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705514949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDtsT6ATYzm1xqoOi4krpoaJ4Z6HmrzCVOZIu1i9RwM=;
 b=gkzW6p88YwN3DMuOEcgXd3Xs7dNdLZ8XAukt/KovLRhIenqplfWRovA1X0KfLZitqCPD7U
 hy6RAl0bRpY2JcDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF1D013751;
 Wed, 17 Jan 2024 18:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mkjwJMQXqGX9SwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 18:09:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Claudio Fontana
 <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that
 takes a discontiguous iovec
In-Reply-To: <Zafjzq5YDTfbYzV-@redhat.com>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de> <ZafKft029nRUKC4z@redhat.com>
 <Zafjzq5YDTfbYzV-@redhat.com>
Date: Wed, 17 Jan 2024 15:09:06 -0300
Message-ID: <87cytzde7x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hfiM+H3C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gkzW6p88
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[libvirt.org:url,entangle-photo.org:url,instagram.com:url,suse.de:dkim,suse.de:email,berrange.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 512031FCE4
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jan 17, 2024 at 12:39:26PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Nov 27, 2023 at 05:25:57PM -0300, Fabiano Rosas wrote:
>> > For the upcoming support to fixed-ram migration with multifd, we need
>> > to be able to accept an iovec array with non-contiguous data.
>> >=20
>> > Add a pwritev and preadv version that splits the array into contiguous
>> > segments before writing. With that we can have the ram code continue
>> > to add pages in any order and the multifd code continue to send large
>> > arrays for reading and writing.
>> >=20
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> > - split the API that was merged into a single function
>> > - use uintptr_t for compatibility with 32-bit
>> > ---
>> >  include/io/channel.h | 26 ++++++++++++++++
>> >  io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 96 insertions(+)
>> >=20
>> > diff --git a/include/io/channel.h b/include/io/channel.h
>> > index 7986c49c71..25383db5aa 100644
>> > --- a/include/io/channel.h
>> > +++ b/include/io/channel.h
>> > @@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
>> >  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>> >                              size_t niov, off_t offset, Error **errp);
>> >=20=20
>> > +/**
>> > + * qio_channel_pwritev_all:
>> > + * @ioc: the channel object
>> > + * @iov: the array of memory regions to write data from
>> > + * @niov: the length of the @iov array
>> > + * @offset: the iovec offset in the file where to write the data
>> > + * @errp: pointer to a NULL-initialized error object
>> > + *
>> > + * Returns: 0 if all bytes were written, or -1 on error
>> > + */
>> > +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
>> > +                            size_t niov, off_t offset, Error **errp);
>> > +
>> >  /**
>> >   * qio_channel_pwrite
>> >   * @ioc: the channel object
>> > @@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char =
*buf, size_t buflen,
>> >  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>> >                             size_t niov, off_t offset, Error **errp);
>> >=20=20
>> > +/**
>> > + * qio_channel_preadv_all:
>> > + * @ioc: the channel object
>> > + * @iov: the array of memory regions to read data to
>> > + * @niov: the length of the @iov array
>> > + * @offset: the iovec offset in the file from where to read the data
>> > + * @errp: pointer to a NULL-initialized error object
>> > + *
>> > + * Returns: 0 if all bytes were read, or -1 on error
>> > + */
>> > +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
>> > +                           size_t niov, off_t offset, Error **errp);
>> > +
>> >  /**
>> >   * qio_channel_pread
>> >   * @ioc: the channel object
>> > diff --git a/io/channel.c b/io/channel.c
>> > index a1f12f8e90..2f1745d052 100644
>> > --- a/io/channel.c
>> > +++ b/io/channel.c
>> > @@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, cons=
t struct iovec *iov,
>> >      return klass->io_pwritev(ioc, iov, niov, offset, errp);
>> >  }
>> >=20=20
>> > +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
>> > +                                                 const struct iovec *=
iov,
>> > +                                                 size_t niov, off_t o=
ffset,
>> > +                                                 bool is_write, Error=
 **errp)
>> > +{
>> > +    ssize_t ret =3D -1;
>> > +    int i, slice_idx, slice_num;
>> > +    uintptr_t base, next, file_offset;
>> > +    size_t len;
>> > +
>> > +    slice_idx =3D 0;
>> > +    slice_num =3D 1;
>> > +
>> > +    /*
>> > +     * If the iov array doesn't have contiguous elements, we need to
>> > +     * split it in slices because we only have one (file) 'offset' for
>> > +     * the whole iov. Do this here so callers don't need to break the
>> > +     * iov array themselves.
>> > +     */
>> > +    for (i =3D 0; i < niov; i++, slice_num++) {
>> > +        base =3D (uintptr_t) iov[i].iov_base;
>> > +
>> > +        if (i !=3D niov - 1) {
>> > +            len =3D iov[i].iov_len;
>> > +            next =3D (uintptr_t) iov[i + 1].iov_base;
>> > +
>> > +            if (base + len =3D=3D next) {
>> > +                continue;
>> > +            }
>> > +        }
>> > +
>> > +        /*
>> > +         * Use the offset of the first element of the segment that
>> > +         * we're sending.
>> > +         */
>> > +        file_offset =3D offset + (uintptr_t) iov[slice_idx].iov_base;
>> > +
>> > +        if (is_write) {
>> > +            ret =3D qio_channel_pwritev(ioc, &iov[slice_idx], slice_n=
um,
>> > +                                      file_offset, errp);
>> > +        } else {
>> > +            ret =3D qio_channel_preadv(ioc, &iov[slice_idx], slice_nu=
m,
>> > +                                     file_offset, errp);
>> > +        }
>>=20
>> iov_base is the address of a pointer in RAM, so could be
>> potentially any 64-bit value.
>>=20
>> We're assigning file_offset to this pointer address with an
>> user supplied offset, and then using it as an offset on disk.
>> First this could result in 64-bit overflow when 'offset' is
>> added to 'iov_base', and second this could result in a file
>> that's 16 Exabytes in size (with holes of course).
>>=20
>> I don't get how this is supposed to work, or be used ?
>
> I feel like this whole method might become clearer if we separated
> out the logic for merging memory adjacent iovecs.
>
> How about adding a 'iov_collapse' method in iov.h / iov.c to do
> the merging and then let the actual I/O code be simpler ?

I think if we add a migration-specific wrapper like we're discussing
with Peter earlier in the thread (on this same message), that would be
enough to keep the migration assumptions contained and not have to
pollute the IO code with any of this logic.

>>=20
>> > +
>> > +        if (ret < 0) {
>> > +            break;
>> > +        }
>> > +
>> > +        slice_idx +=3D slice_num;
>> > +        slice_num =3D 0;
>> > +    }
>> > +
>> > +    return (ret < 0) ? -1 : 0;
>> > +}
>
>
>
>> > +
>> > +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
>> > +                            size_t niov, off_t offset, Error **errp)
>> > +{
>> > +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
>> > +                                                 offset, true, errp);
>> > +}
>> > +
>> >  ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
>> >                             off_t offset, Error **errp)
>> >  {
>> > @@ -501,6 +564,13 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const=
 struct iovec *iov,
>> >      return klass->io_preadv(ioc, iov, niov, offset, errp);
>> >  }
>> >=20=20
>> > +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
>> > +                           size_t niov, off_t offset, Error **errp)
>> > +{
>> > +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
>> > +                                                 offset, false, errp);
>> > +}
>> > +
>> >  ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
>> >                            off_t offset, Error **errp)
>> >  {
>> > --=20
>> > 2.35.3
>> >=20
>>=20
>> With regards,
>> Daniel
>> --=20
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberra=
nge :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.=
com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberra=
nge :|
>>=20
>>=20
>
> With regards,
> Daniel

