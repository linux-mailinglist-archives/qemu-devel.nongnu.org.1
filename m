Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065CC722C2F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CjO-0004Zi-7n; Mon, 05 Jun 2023 12:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6CjM-0004Yu-A0
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6CjK-0005zD-AR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685981208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVUWZSkzlBAYYLRNnQILknuvkVe/JknV6xmZ/ryV7AY=;
 b=NmGd/gJ+AdmlPTgkB548M3n154tfJLv0zXJdBI7ajDRUL07B3XsFjlWZMC9WCalgfhgCxC
 0wx29wGWtJNbcwYy7Vewqe0UgblC1iSxHpwIQsWKqU3xHuoa2fydK1zaWuPdxPaWADJppr
 qqtoMbGc9IoxGVCMSn803q4smuanSk8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-tQHMqyHfOyeaEynV8LPo5A-1; Mon, 05 Jun 2023 12:06:47 -0400
X-MC-Unique: tQHMqyHfOyeaEynV8LPo5A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f6c58d57adso7437921cf.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685981207; x=1688573207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVUWZSkzlBAYYLRNnQILknuvkVe/JknV6xmZ/ryV7AY=;
 b=hz7NpZaf25qPC7Z5oUPgAmA/7JtQRb3RlMMZMfFqN6LzyiMX4lnRJm4fVL3/AzpXtA
 xihBOJfO50CRBkZZBiThD5/9+7QFBHvDUtB/9GVNBM4F2Y5zK1ODPPM+TogQHgm8Ddob
 02xW/IZQ9L+Q0tRDlQm6fJbhqmdM82IntGaLVtUWsjwab6nozbwgLNWOBbqFqU8ObiI3
 e2NB0ftcXlPja78Ek1A1cqbgREsKBN1814shDw5GW3NY9hVcuQdvDioChx/6CCJA10oO
 c/yb8yT6K03EwFY8/01/kANMQxJ6uvwaxo7pC+ItgIwX4AkcHyWbKC7wOesHqfbRiwTo
 f7xA==
X-Gm-Message-State: AC+VfDwDPkuLZVJB7Zb6lB1jxBW268bf0jQZt86R5K2305fgWIB959+R
 SLuLv7UaKqxpvA5iwQmwOjcjvqs71+OMfqQXLV/RBvIxNuzmslBJswYG1pVYDdotMlcVYu1HRgD
 tWGcCsfGljl2j8SY=
X-Received: by 2002:a05:622a:102:b0:3f6:b493:8ef5 with SMTP id
 u2-20020a05622a010200b003f6b4938ef5mr27278796qtw.0.1685981206837; 
 Mon, 05 Jun 2023 09:06:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Og+rh2B1TgejWg7jsSaX5aZxC61JkWezBsCsZ9eZH1i/k0McGEybhk+j/n/KYn6Bbt5OT1g==
X-Received: by 2002:a05:622a:102:b0:3f6:b493:8ef5 with SMTP id
 u2-20020a05622a010200b003f6b4938ef5mr27278758qtw.0.1685981206371; 
 Mon, 05 Jun 2023 09:06:46 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x9-20020ac87ec9000000b003f6b50c12a7sm3303780qtj.7.2023.06.05.09.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 09:06:45 -0700 (PDT)
Date: Mon, 5 Jun 2023 12:06:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH 1/2] migration: switchover-hold parameter
Message-ID: <ZH4IFK7tq47Ympze@x1n>
References: <20230602144715.249002-1-peterx@redhat.com>
 <20230602144715.249002-2-peterx@redhat.com>
 <0c459f0c-1a04-f460-2b51-e8c3f997370d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c459f0c-1a04-f460-2b51-e8c3f997370d@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 05, 2023 at 03:27:53PM +0300, Avihai Horon wrote:
> Hi Peter,
> 
> On 02/06/2023 17:47, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Add a new migration parameter switchover-hold which can block src qemu
> > migration from switching over to dest from running.
> > 
> > One can set this flag to true so src qemu will keep iterating the VM data,
> > not switching over to dest even if it can.
> > 
> > It means now live migration works somehow like COLO; we keep syncing data
> > from src to dst without stopping.
> > 
> > When the user is ready for the switchover, one can set the parameter from
> > true->false.  That'll contain a implicit kick to migration thread to be
> > alive and re-evaluate the switchover decision.
> > 
> > This can be used in two cases so far in my mind:
> > 
> >    (1) One can use this parameter to start pre-heating migration (but not
> >        really migrating, so a migrate-cancel will cancel the preheat).  When
> >        the user wants to really migrate, just clear the flag.  It'll in most
> >        cases migrate immediately because most pages are already synced.
> > 
> >    (2) Can also be used as a clean way to do qtest, in many of the precopy
> >        tests we have requirement to run after 1 iteration without completing
> >        the precopy migration.  Before that we have either set bandwidth to
> >        ridiculous low value, or tricks on detecting guest memory change over
> >        some adhoc guest memory position.  Now we can simply set this flag
> >        then we know precopy won't complete and will just keep going.
> > 
> > Here we leveraged a sem to make sure migration thread won't busy spin on a
> > physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
> > its best to sync with dest QEMU from time to time.  Note that the sem is
> > prone to outdated counts but it's benign, please refer to the comment above
> > the semaphore definition for more information.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   qapi/migration.json            | 25 +++++++++++++--
> >   migration/migration.h          | 16 ++++++++++
> >   migration/migration-hmp-cmds.c |  3 ++
> >   migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
> >   migration/options.c            | 17 +++++++++++
> >   5 files changed, 111 insertions(+), 6 deletions(-)
> > 
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 179af0c4d8..1d0059d125 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -779,6 +779,15 @@
> >   #     Nodes are mapped to their block device name if there is one, and
> >   #     to their node name otherwise.  (Since 5.2)
> >   #
> > +# @switchover-hold: Whether we should hold-off precopy switchover from src
> > +#     to dest QEMU, even if we can finish migration in the downtime
> > +#     specified.  By default off, so precopy migration will complete as
> > +#     soon as possible.  One can set it to explicitly keep iterating during
> > +#     precopy migration until set the flag to false again to kick off the
> > +#     final switchover.  Note, this does not affect postcopy switchover,
> > +#     because the user can control that using "migrate-start-postcopy"
> > +#     command explicitly. (Since 8.1)
> > +#
> 
> I think this should wrap at col 70, and need double space before (Since
> 8.1).
> Also in other places below.

I don't know that rule; anywhere documented?  It seems true for qapi/.

Obviously I forgot to copy Markus and Eric at least, since this is qmp stuff.

> 
> >   # Features:
> >   #
> >   # @unstable: Member @x-checkpoint-delay is experimental.
> > @@ -800,7 +809,7 @@
> >              'xbzrle-cache-size', 'max-postcopy-bandwidth',
> >              'max-cpu-throttle', 'multifd-compression',
> >              'multifd-zlib-level' ,'multifd-zstd-level',
> > -           'block-bitmap-mapping' ] }
> > +           'block-bitmap-mapping', 'switchover-hold' ] }
> > 
> >   ##
> >   # @MigrateSetParameters:
> > @@ -935,6 +944,10 @@
> >   #     Nodes are mapped to their block device name if there is one, and
> >   #     to their node name otherwise.  (Since 5.2)
> >   #
> > +# @switchover-hold: Whether we should hold-off precopy switchover from src
> > +#     to dest QEMU.  For more details, please refer to MigrationParameter
> > +#     entry of the same field. (Since 8.1)
> > +#
> >   # Features:
> >   #
> >   # @unstable: Member @x-checkpoint-delay is experimental.
> > @@ -972,7 +985,8 @@
> >               '*multifd-compression': 'MultiFDCompression',
> >               '*multifd-zlib-level': 'uint8',
> >               '*multifd-zstd-level': 'uint8',
> > -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> > +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> > +            '*switchover-hold': 'bool' } }
> > 
> >   ##
> >   # @migrate-set-parameters:
> > @@ -1127,6 +1141,10 @@
> >   #     Nodes are mapped to their block device name if there is one, and
> >   #     to their node name otherwise.  (Since 5.2)
> >   #
> > +# @switchover-hold: Whether we should hold-off precopy switchover from src
> > +#     to dest QEMU.  For more details, please refer to MigrationParameter
> > +#     entry of the same field. (Since 8.1)
> > +#
> >   # Features:
> >   #
> >   # @unstable: Member @x-checkpoint-delay is experimental.
> > @@ -1161,7 +1179,8 @@
> >               '*multifd-compression': 'MultiFDCompression',
> >               '*multifd-zlib-level': 'uint8',
> >               '*multifd-zstd-level': 'uint8',
> > -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> > +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> > +            '*switchover-hold': 'bool' } }
> > 
> >   ##
> >   # @query-migrate-parameters:
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 30c3e97635..721b1c9473 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -440,6 +440,22 @@ struct MigrationState {
> > 
> >       /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
> >       JSONWriter *vmdesc;
> > +    /*
> > +     * Only migration thread will wait on it when switchover_hold==true.
> > +     *
> > +     * Only qmp set param will kick it when switching switchover_hold from
> > +     * true->false.
> > +     *
> > +     * NOTE: outdated sem count here is benign.  E.g., when this is posted,
> > +     * the 1st migration got cancelled, then start the 2nd migration, or
> > +     * when someone sets the flag from true->false->true->false.. because
> > +     * any outdated sem count will only let the migration thread to run one
> > +     * more loop (timedwait() will eat the outdated count) when reaching
> > +     * the completion phase, then in the next loop it'll sleep again.  The
> > +     * important thing here OTOH is when the migration thread is sleeping
> > +     * we can always kick it out of the sleep, which we will always do.
> > +     */
> > +    QemuSemaphore switchover_hold_sem;
> >   };
> > 
> >   void migrate_set_state(int *state, int old_state, int new_state);
> > diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> > index 9885d7c9f7..63a2c8a4a3 100644
> > --- a/migration/migration-hmp-cmds.c
> > +++ b/migration/migration-hmp-cmds.c
> > @@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
> >           monitor_printf(mon, "%s: '%s'\n",
> >               MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
> >               params->tls_authz);
> > +        monitor_printf(mon, "%s: %s\n",
> > +            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
> > +            params->switchover_hold ? "on" : "off");
> > 
> >           if (params->has_block_bitmap_mapping) {
> >               const BitmapMigrationNodeAliasList *bmnal;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index dc05c6f6ea..076c9f1372 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2693,6 +2693,55 @@ static void migration_update_counters(MigrationState *s,
> >                                 bandwidth, s->threshold_size);
> >   }
> > 
> > +static bool
> > +migration_should_complete(MigrationState *s, uint64_t pending_size)
> > +{
> > +    /* We still have large pending data to send? */
> > +    if (pending_size && (pending_size >= s->threshold_size)) {
> 
> The parenthesis here are redundant.
> 
> > +        return false;
> > +    }
> > +
> > +    /* The user doesn't want us to switchover yet */
> > +    if (s->parameters.switchover_hold) {
> 
> Should we check this only if we are in precopy? I.e., skip this check if
> postcopy is active?
> 
> I thought that this parameter is all about precopy switchover, and the fact
> that it prevents stopcopy from reaching migration_completion() is just an
> undesired side effect.
> As I see it, if this parameter is set then precopy switchover is hold off,
> and if on top of that a user starts postcopy then this parameter is not
> relevant anymore - we should start postcopy and ignore it for the rest of
> migration.
> 
> Does it make sense?

Yes, it matches more with the doc update indeed.

I didn't bother with that and added flag=false in the postcopy tests in the
follow up patch because logically a postcopy user shouldn't even use it
(also per the doc), but I can also make it strict here as you said.

Thanks for taking a look!

-- 
Peter Xu


