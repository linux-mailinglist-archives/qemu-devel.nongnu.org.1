Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B551F7D5B1E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 21:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvMju-0007Ex-8u; Tue, 24 Oct 2023 15:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMjn-0007EY-Kc
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 15:06:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvMjk-0007Sp-Ie
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 15:06:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37BE8218F3;
 Tue, 24 Oct 2023 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698174402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCkeBTSNjn2FO2y6JGJ1WcUDy/s3FNDHZrUq8G/x6P4=;
 b=y4iU3CsE/UDREIykcl8iMLFupumsLmqpyAMx08T97IG+OPnmQMgNbVAGO3knM429PXiyEb
 iTv86yZzmJgq3PtI9iib6b6nKyKCfktYr6TQyc1lzeUQGVawUtw6Nwr6ecHkC9M314lfHy
 /Uvp2Iw4uhgEXAoJRrTp2BSN8d6KiBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698174402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCkeBTSNjn2FO2y6JGJ1WcUDy/s3FNDHZrUq8G/x6P4=;
 b=FYkk99MgBVd4FuRq4SGo9d8O4gG62lF01M9WEHMqY2GzRUSKAvjZbeCws7oS33gkmKRCpD
 2DmTWAl4FGce9OBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCBEC134F5;
 Tue, 24 Oct 2023 19:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EaEgIsEVOGUQNQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 19:06:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Nikolay Borisov
 <nborisov@suse.com>
Subject: Re: [PATCH v2 10/29] io: Add generic pwritev/preadv interface
In-Reply-To: <ZTd97Eb9RwLrsJsN@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-11-farosas@suse.de> <ZTd97Eb9RwLrsJsN@redhat.com>
Date: Tue, 24 Oct 2023 16:06:39 -0300
Message-ID: <87pm13dem8.fsf@suse.de>
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
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

> On Mon, Oct 23, 2023 at 05:35:49PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>=20
>> Introduce basic pwritev/preadv support in the generic channel layer.
>> Specific implementation will follow for the file channel as this is
>> required in order to support migration streams with fixed location of
>> each ram page.
>>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/io/channel.h | 82 ++++++++++++++++++++++++++++++++++++++++++++
>>  io/channel.c         | 58 +++++++++++++++++++++++++++++++
>>  2 files changed, 140 insertions(+)
>>=20
>> diff --git a/include/io/channel.h b/include/io/channel.h
>> index fcb19fd672..a8181d576a 100644
>> --- a/include/io/channel.h
>> +++ b/include/io/channel.h
>> @@ -131,6 +131,16 @@ struct QIOChannelClass {
>>                             Error **errp);
>>=20=20
>>      /* Optional callbacks */
>> +    ssize_t (*io_pwritev)(QIOChannel *ioc,
>> +                          const struct iovec *iov,
>> +                          size_t niov,
>> +                          off_t offset,
>> +                          Error **errp);
>> +    ssize_t (*io_preadv)(QIOChannel *ioc,
>> +                         const struct iovec *iov,
>> +                         size_t niov,
>> +                         off_t offset,
>> +                         Error **errp);
>>      int (*io_shutdown)(QIOChannel *ioc,
>>                         QIOChannelShutdown how,
>>                         Error **errp);
>> @@ -529,6 +539,78 @@ void qio_channel_set_follow_coroutine_ctx(QIOChanne=
l *ioc, bool enabled);
>>  int qio_channel_close(QIOChannel *ioc,
>>                        Error **errp);
>>=20=20
>> +/**
>> + * qio_channel_pwritev_full
>> + * @ioc: the channel object
>> + * @iov: the array of memory regions to write data from
>> + * @niov: the length of the @iov array
>> + * @offset: offset in the channel where writes should begin
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Not all implementations will support this facility, so may report
>> + * an error. To avoid errors, the caller may check for the feature
>> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
>> + *
>> + * Behaves as qio_channel_writev_full, apart from not supporting
>> + * sending of file handles as well as beginning the write at the
>> + * passed @offset
>> + *
>> + */
>> +ssize_t qio_channel_pwritev_full(QIOChannel *ioc, const struct iovec *i=
ov,
>> +                                 size_t niov, off_t offset, Error **err=
p);
>
> In terms of naming this should be  just "_pwritev".
>
> We don't support FD passing, so the "_full" suffix is not
> appropriate
>
>> +
>> +/**
>> + * qio_channel_pwritev
>> + * @ioc: the channel object
>> + * @buf: the memory region to write data into
>> + * @buflen: the number of bytes to @buf
>> + * @offset: offset in the channel where writes should begin
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Not all implementations will support this facility, so may report
>> + * an error. To avoid errors, the caller may check for the feature
>> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
>> + *
>> + */
>> +ssize_t qio_channel_pwritev(QIOChannel *ioc, char *buf, size_t buflen,
>> +                            off_t offset, Error **errp);
>
> This isn't passing a vector of buffers, so it should be just
> "pwrite", not "pwritev".
>
>> +
>> +/**
>> + * qio_channel_preadv_full
>> + * @ioc: the channel object
>> + * @iov: the array of memory regions to read data into
>> + * @niov: the length of the @iov array
>> + * @offset: offset in the channel where writes should begin
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Not all implementations will support this facility, so may report
>> + * an error.  To avoid errors, the caller may check for the feature
>> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
>> + *
>> + * Behaves as qio_channel_readv_full, apart from not supporting
>> + * receiving of file handles as well as beginning the read at the
>> + * passed @offset
>> + *
>> + */
>> +ssize_t qio_channel_preadv_full(QIOChannel *ioc, const struct iovec *io=
v,
>> +                                size_t niov, off_t offset, Error **errp=
);
>
> "preadv"
>
>
>> +
>> +/**
>> + * qio_channel_preadv
>> + * @ioc: the channel object
>> + * @buf: the memory region to write data into
>> + * @buflen: the number of bytes to @buf
>> + * @offset: offset in the channel where writes should begin
>> + * @errp: pointer to a NULL-initialized error object
>> + *
>> + * Not all implementations will support this facility, so may report
>> + * an error.  To avoid errors, the caller may check for the feature
>> + * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
>> + *
>> + */
>> +ssize_t qio_channel_preadv(QIOChannel *ioc, char *buf, size_t buflen,
>> +                           off_t offset, Error **errp);
>
> "pread"
>
>
> With regards,
> Daniel

I'll fix all instances.

Thanks

