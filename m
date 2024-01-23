Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BCE839233
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:11:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIQb-0004XM-Ep; Tue, 23 Jan 2024 10:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rSIQY-0004Wq-MD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:11:02 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rSIQW-00022j-Mq
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:11:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F5755D6D2;
 Tue, 23 Jan 2024 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706022658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiA1OgvheX1GGmnyJEyVfdgtL4Sti/9P54WV2ZpVRCY=;
 b=aaijZnkxMsqrdQgm0UW7xHrNVqUNjFM1BoazlXRBX7vfxJ3XgKpgnSpL0unFO5zNlaTLJg
 0phwsxOkmK7xR5rGhlYcMnl1aKDMvGxpRkzDZauWRQvWC8c7gQa0w6Ct+ygSZHNg6ZjTT7
 gbXDVk0Z+0uMsh8aD7xV1jdNsW6Hyrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706022658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiA1OgvheX1GGmnyJEyVfdgtL4Sti/9P54WV2ZpVRCY=;
 b=8sLogjEGOnabDAyTDDOWUjjz9OnPekTrPuI6v4SGywWv7WA6WKqiGvFqwdM2ByHRGtANuL
 dWDBBuslO9wUTEDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706022658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiA1OgvheX1GGmnyJEyVfdgtL4Sti/9P54WV2ZpVRCY=;
 b=aaijZnkxMsqrdQgm0UW7xHrNVqUNjFM1BoazlXRBX7vfxJ3XgKpgnSpL0unFO5zNlaTLJg
 0phwsxOkmK7xR5rGhlYcMnl1aKDMvGxpRkzDZauWRQvWC8c7gQa0w6Ct+ygSZHNg6ZjTT7
 gbXDVk0Z+0uMsh8aD7xV1jdNsW6Hyrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706022658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiA1OgvheX1GGmnyJEyVfdgtL4Sti/9P54WV2ZpVRCY=;
 b=8sLogjEGOnabDAyTDDOWUjjz9OnPekTrPuI6v4SGywWv7WA6WKqiGvFqwdM2ByHRGtANuL
 dWDBBuslO9wUTEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0216513786;
 Tue, 23 Jan 2024 15:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zCbILgHXr2W6cAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Jan 2024 15:10:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, Shivam Kumar
 <shivam.kumar1@nutanix.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [External] Re: [PATCH v3 01/20] multifd: Add capability to
 enable/disable zero_page
In-Reply-To: <CAAYibXjw42iB=5YgKsXy4erj6RsGuqDqFnhuOZxkfBit7S5TtA@mail.gmail.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
 <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
 <CAAYibXjw42iB=5YgKsXy4erj6RsGuqDqFnhuOZxkfBit7S5TtA@mail.gmail.com>
Date: Tue, 23 Jan 2024 12:10:55 -0300
Message-ID: <8734uof5kw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.10
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Sun, Jan 14, 2024 at 10:02=E2=80=AFPM Shivam Kumar <shivam.kumar1@nuta=
nix.com> wrote:
>>
>>
>>
>> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
>> >
>> > From: Juan Quintela <quintela@redhat.com>
>> >
>> > We have to enable it by default until we introduce the new code.
>> >
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>> > ---
>> > migration/options.c | 15 +++++++++++++++
>> > migration/options.h |  1 +
>> > qapi/migration.json |  8 +++++++-
>> > 3 files changed, 23 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/migration/options.c b/migration/options.c
>> > index 8d8ec73ad9..0f6bd78b9f 100644
>> > --- a/migration/options.c
>> > +++ b/migration/options.c
>> > @@ -204,6 +204,8 @@ Property migration_properties[] =3D {
>> >     DEFINE_PROP_MIG_CAP("x-switchover-ack",
>> >                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
>> >     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LI=
MIT),
>> > +    DEFINE_PROP_MIG_CAP("main-zero-page",
>> > +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
>> >     DEFINE_PROP_END_OF_LIST(),
>> > };
>> >
>> > @@ -284,6 +286,19 @@ bool migrate_multifd(void)
>> >     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
>> > }
>> >
>> > +bool migrate_use_main_zero_page(void)
>> > +{
>> > +    /* MigrationState *s; */
>> > +
>> > +    /* s =3D migrate_get_current(); */
>> > +
>> > +    /*
>> > +     * We will enable this when we add the right code.
>> > +     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_=
PAGE];
>> > +     */
>> > +    return true;
>> > +}
>> > +
>> > bool migrate_pause_before_switchover(void)
>> > {
>> >     MigrationState *s =3D migrate_get_current();
>> > diff --git a/migration/options.h b/migration/options.h
>> > index 246c160aee..c901eb57c6 100644
>> > --- a/migration/options.h
>> > +++ b/migration/options.h
>> > @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
>> > MultiFDCompression migrate_multifd_compression(void);
>> > int migrate_multifd_zlib_level(void);
>> > int migrate_multifd_zstd_level(void);
>> > +bool migrate_use_main_zero_page(void);
>> > uint8_t migrate_throttle_trigger_threshold(void);
>> > const char *migrate_tls_authz(void);
>> > const char *migrate_tls_creds(void);
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index eb2f883513..80c4b13516 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -531,6 +531,12 @@
>> > #     and can result in more stable read performance.  Requires KVM
>> > #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>> > #
>> > +#
>> > +# @main-zero-page: If enabled, the detection of zero pages will be
>> > +#                  done on the main thread.  Otherwise it is done on
>> > +#                  the multifd threads.
>> > +#                  (since 8.2)
>> > +#
>> Should the capability name be something like "zero-page-detection" or ju=
st =E2=80=9Czero-page=E2=80=9D?
>> CC: Fabiano Rosas
>
> I think the same concern was brought up last time Juan sent out the
> original patchset. Right now, the zero page detection is done in the
> main migration thread and it is always "ON". This change added a
> functionality to move the zero page detection from the main thread to
> the multifd sender threads. Now "main-zero-page" is turned "OFF" by
> default, and zero page checking is done in the multifd sender thread
> (much better performance). If user wants to run the zero page
> detection in the main thread (keep current behavior), user can change
> "main-zero-page" to "ON".
>
> Renaming it to "zero-page-detection" or just =E2=80=9Czero-page=E2=80=9D =
can not
> differentiate the old behavior and the new behavior.

Yes, the main point here is what happens when we try to migrate from
different QEMU versions that have/don't have this code. We need some way
to maintain the compatibility. In this case Juan chose to keep this
capability with the semantics of "old behavior" so that we can enable it
on the new QEMU to match with the old binary that doesn't expect to see
zero pages on the packet/stream.

> Here are the options:
> 1) Keep the current behavior. "main-zero-page" is OFF by default and
> zero page detection runs on the multifd thread by default. User can
> turn the switch to "ON" if they want old behavior.
> 2) Make "main-zero-page" switch ON as default. This would keep the
> current behavior by default. User can set it to "OFF" for better
> performance.

3) Make multifd-zero-page ON by default. User can set it to OFF to get
the old behavior. There was some consideration about how libvirt works
that would make this one unusable, but I don't understand what's that
about.

I would make this a default ON parameter instead of a capability.

>> > # Features:
>> > #
>> > # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
>> > @@ -555,7 +561,7 @@
>> >            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>> >            'validate-uuid', 'background-snapshot',
>> >            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> > -           'dirty-limit'] }
>> > +           'dirty-limit', 'main-zero-page'] }
>> >
>> > ##
>> > # @MigrationCapabilityStatus:
>> > --
>> > 2.30.2
>> >
>> >
>> >
>>

