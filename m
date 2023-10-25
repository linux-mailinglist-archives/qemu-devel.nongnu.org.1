Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFAF7D6E97
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvelm-0002x5-LU; Wed, 25 Oct 2023 10:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvele-0002ua-EI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:21:56 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvela-0001Yb-AZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:21:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D26471FF65;
 Wed, 25 Oct 2023 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698243703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vC5GX6ObTzx39u+URDw80MEIvdKnYFDiljcwBcmK9bI=;
 b=OSehQ7mg/Li6F3oQYq8YkDSQbI+wYDXCBQk/+lyZN8Ln+05dX5qWYbtmOLrUyKzKPx1BDx
 T63s+5s5efymY3u3iimkZ+yU/dPGwMUt7S9Zo3e9NL8GsI1E5De6HHF/eYjaLMSAHIf7H8
 Jq+MW3ryhoSgfGPw6CuYiSy6mP92HOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698243703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vC5GX6ObTzx39u+URDw80MEIvdKnYFDiljcwBcmK9bI=;
 b=f63pOPObm58fsHNe4oXf6lxCEMtVh6K6z1lL+Fr42RgJpwfqB21q05X1FLmAkfkjvYnFN2
 VlFpG8BCuJ9fpNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6210B138E9;
 Wed, 25 Oct 2023 14:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rXS3C3ckOWXOGgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:21:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 25/29] migration/multifd: Support outgoing fixed-ram
 stream format
In-Reply-To: <ZTjegrKXycbsbImz@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-26-farosas@suse.de> <ZTjegrKXycbsbImz@redhat.com>
Date: Wed, 25 Oct 2023 11:21:41 -0300
Message-ID: <87h6meeqa2.fsf@suse.de>
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
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

> On Mon, Oct 23, 2023 at 05:36:04PM -0300, Fabiano Rosas wrote:
>> The new fixed-ram stream format uses a file transport and puts ram
>> pages in the migration file at their respective offsets and can be
>> done in parallel by using the pwritev system call which takes iovecs
>> and an offset.
>>=20
>> Add support to enabling the new format along with multifd to make use
>> of the threading and page handling already in place.
>>=20
>> This requires multifd to stop sending headers and leaving the stream
>> format to the fixed-ram code. When it comes time to write the data, we
>> need to call a version of qio_channel_write that can take an offset.
>>=20
>> Usage on HMP is:
>>=20
>> (qemu) stop
>> (qemu) migrate_set_capability multifd on
>> (qemu) migrate_set_capability fixed-ram on
>> (qemu) migrate_set_parameter max-bandwidth 0
>> (qemu) migrate_set_parameter multifd-channels 8
>> (qemu) migrate file:migfile
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/qemu/bitops.h | 13 ++++++++++
>>  migration/multifd.c   | 55 +++++++++++++++++++++++++++++++++++++++++--
>>  migration/options.c   |  6 -----
>>  migration/ram.c       |  2 +-
>>  4 files changed, 67 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
>> index cb3526d1f4..2c0a2fe751 100644
>> --- a/include/qemu/bitops.h
>> +++ b/include/qemu/bitops.h
>> @@ -67,6 +67,19 @@ static inline void clear_bit(long nr, unsigned long *=
addr)
>>      *p &=3D ~mask;
>>  }
>>=20=20
>> +/**
>> + * clear_bit_atomic - Clears a bit in memory atomically
>> + * @nr: Bit to clear
>> + * @addr: Address to start counting from
>> + */
>> +static inline void clear_bit_atomic(long nr, unsigned long *addr)
>> +{
>> +    unsigned long mask =3D BIT_MASK(nr);
>> +    unsigned long *p =3D addr + BIT_WORD(nr);
>> +
>> +    return qatomic_and(p, ~mask);
>> +}
>> +
>>  /**
>>   * change_bit - Toggle a bit in memory
>>   * @nr: Bit to change
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 20e8635740..3f95a41ee9 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -260,6 +260,19 @@ static void multifd_pages_clear(MultiFDPages_t *pag=
es)
>>      g_free(pages);
>>  }
>>=20=20
>> +static void multifd_set_file_bitmap(MultiFDSendParams *p)
>> +{
>> +    MultiFDPages_t *pages =3D p->pages;
>> +
>> +    if (!pages->block) {
>> +        return;
>> +    }
>> +
>> +    for (int i =3D 0; i < p->normal_num; i++) {
>> +        ramblock_set_shadow_bmap_atomic(pages->block, pages->offset[i]);
>> +    }
>> +}
>> +
>>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>>  {
>>      MultiFDPacket_t *packet =3D p->packet;
>> @@ -606,6 +619,29 @@ int multifd_send_sync_main(QEMUFile *f)
>>          }
>>      }
>>=20=20
>> +    if (!migrate_multifd_packets()) {
>> +        /*
>> +         * There's no sync packet to send. Just make sure the sending
>> +         * above has finished.
>> +         */
>> +        for (i =3D 0; i < migrate_multifd_channels(); i++) {
>> +            qemu_sem_wait(&multifd_send_state->channels_ready);
>> +        }
>> +
>> +        /* sanity check and release the channels */
>> +        for (i =3D 0; i < migrate_multifd_channels(); i++) {
>> +            MultiFDSendParams *p =3D &multifd_send_state->params[i];
>> +
>> +            qemu_mutex_lock(&p->mutex);
>> +            assert(!p->pending_job || p->quit);
>> +            qemu_mutex_unlock(&p->mutex);
>> +
>> +            qemu_sem_post(&p->sem);
>> +        }
>> +
>> +        return 0;
>> +    }
>> +
>>      /*
>>       * When using zero-copy, it's necessary to flush the pages before a=
ny of
>>       * the pages can be sent again, so we'll make sure the new version =
of the
>> @@ -689,6 +725,8 @@ static void *multifd_send_thread(void *opaque)
>>=20=20
>>          if (p->pending_job) {
>>              uint32_t flags;
>> +            uint64_t write_base;
>> +
>>              p->normal_num =3D 0;
>>=20=20
>>              if (!use_packets || use_zero_copy_send) {
>> @@ -713,6 +751,16 @@ static void *multifd_send_thread(void *opaque)
>>              if (use_packets) {
>>                  multifd_send_fill_packet(p);
>>                  p->num_packets++;
>> +                write_base =3D 0;
>> +            } else {
>> +                multifd_set_file_bitmap(p);
>> +
>> +                /*
>> +                 * If we subtract the host page now, we don't need to
>> +                 * pass it into qio_channel_write_full_all() below.
>> +                 */
>> +                write_base =3D p->pages->block->pages_offset -
>> +                    (uint64_t)p->pages->block->host;
>>              }
>>=20=20
>>              flags =3D p->flags;
>> @@ -738,8 +786,9 @@ static void *multifd_send_thread(void *opaque)
>>                  p->iov[0].iov_base =3D p->packet;
>>              }
>>=20=20
>> -            ret =3D qio_channel_writev_full_all(p->c, p->iov, p->iovs_n=
um, NULL,
>> -                                              0, p->write_flags, &local=
_err);
>> +            ret =3D qio_channel_write_full_all(p->c, p->iov, p->iovs_nu=
m,
>> +                                             write_base, NULL, 0,
>> +                                             p->write_flags, &local_err=
);
>>              if (ret !=3D 0) {
>>                  break;
>>              }
>> @@ -969,6 +1018,8 @@ int multifd_save_setup(Error **errp)
>>=20=20
>>          if (migrate_zero_copy_send()) {
>>              p->write_flags =3D QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
>> +        } else if (!use_packets) {
>> +            p->write_flags |=3D QIO_CHANNEL_WRITE_FLAG_WITH_OFFSET;
>>          } else {
>>              p->write_flags =3D 0;
>>          }
>
> Ah, so this is why you had the wierd overloaded design for
> qio_channel_write_full_all in patch 22 that I queried. I'd
> still prefer the simpler design at the QIO level, and just
> calling the appropriate function above.=20

Yes, I didn't want to have multifd choosing between different IO
functions during (multifd) runtime. Here we set the flag at setup time
and forget about it.

I now understand multifd a bit more so I'm more confident changing the
code, let's see how your suggestion looks like.


>
> With regards,
> Daniel

