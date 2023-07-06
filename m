Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C52749E42
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPRS-00071C-NA; Thu, 06 Jul 2023 09:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHPRN-0006z3-Vc
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHPRM-0001sI-0s
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688651675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ss9TOwCw1p5n7ogcrUo80uRxuTUvaddwS6sx57JEybY=;
 b=WCwfWfPq3S1itlGWAzscrPeD28QOjbjqXKVkfsqqU+esAnmFNTA6K13J4Z28dnDw0K3zrx
 bLv95JUbgRl4YUzjCY7QxGaQN4Cn4wMS8UkRvNNkFhGZtCfQftTje0kIIGKvAYA0Mp4U8Q
 3i8kvuzrLyAGrL2WqiscAvJDrIHoKSc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-IXPv0A8xOFK0FpayeRvJqg-1; Thu, 06 Jul 2023 09:54:34 -0400
X-MC-Unique: IXPv0A8xOFK0FpayeRvJqg-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-47ce83d97a8so25546e0c.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688651673; x=1689256473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ss9TOwCw1p5n7ogcrUo80uRxuTUvaddwS6sx57JEybY=;
 b=VLkpGuUG2GhyO+T7EqNgjNCgzFAnxqfLAq/njGMmwiene5v93v6bJQp7MLaJbyYvu9
 RoCqnWvLcgc1TT1KBwYIG04eECa3wlnk5VGAtCbbbbp+qSSm0bwwFbKA7wByXbll5B+R
 SkIZYRzaFQANX9hnfZ9eaVlxmrPurvQsf9OAbug/qQE1B/IFbIc6nU7cgh7DghYdGY8q
 kTuW/e3kokFDZXsk+O/px4spFpvdAK6uJTNXQSasuN056f/uIY1eoeD7kxAK0dzfmrRG
 0zs/NYNFI+9ZgKmKMXzjWcy43dFM8gz/zKsKj19JCFeSMt1qSKuI+ht6dHeeF6HipyoA
 DAVQ==
X-Gm-Message-State: ABy/qLZAGD4r+2Q40ke90lEzrUtfs8GMSJWC1x+z+3dZ7elFzhjYO8Ex
 DzZelEGWvGL4BM661AmC2aiX7mkE0fo9p274qfisIGFzReU8Qawq8Ma1KAXfkUG6Gk9BS+Qv0OR
 BHRd7hTH6AhRdyuw=
X-Received: by 2002:a05:6122:20a5:b0:47e:7350:269d with SMTP id
 i37-20020a05612220a500b0047e7350269dmr981548vkd.1.1688651673138; 
 Thu, 06 Jul 2023 06:54:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGyUVJxEPdXvEF9gmaWPEY31rm/3Nk+k2lzUe9pNe7Lt5T73DyBWkrOgendHDauZfQfrxh0Dg==
X-Received: by 2002:a05:6122:20a5:b0:47e:7350:269d with SMTP id
 i37-20020a05612220a500b0047e7350269dmr981533vkd.1.1688651672801; 
 Thu, 06 Jul 2023 06:54:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f29-20020ac840dd000000b0040223cef736sm634227qtm.21.2023.07.06.06.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:54:32 -0700 (PDT)
Date: Thu, 6 Jul 2023 09:54:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 1/2] migration: switchover-hold parameter
Message-ID: <ZKbHl7uKI/NOAfMQ@x1n>
References: <20230706124331.377939-1-peterx@redhat.com>
 <20230706124331.377939-2-peterx@redhat.com>
 <87v8exqhx6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8exqhx6.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi, Markus,

On Thu, Jul 06, 2023 at 03:38:13PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Add a new migration parameter switchover-hold which can block src qemu
> > migration from switching over to dest from running.
> >
> > One can set this flag to true so src qemu will keep iterating the VM data,
> > not switching over to dest even if it can.
> >
> > It means now live migration works somehow like COLO; we keep syncing data
> > from src to dst without stopping.
> 
> Out of curiosity: does it share code with COLO?

Nop, it is still purely the migration path.

> 
> > When the user is ready for the switchover, one can set the parameter from
> > true->false.  That'll contain a implicit kick to migration thread to be
> > alive and re-evaluate the switchover decision.
> >
> > This can be used in two cases so far in my mind:
> >
> >   (1) One can use this parameter to start pre-heating migration (but not
> >       really migrating, so a migrate-cancel will cancel the preheat).  When
> >       the user wants to really migrate, just clear the flag.  It'll in most
> >       cases migrate immediately because most pages are already synced.
> >
> >   (2) Can also be used as a clean way to do qtest, in many of the precopy
> >       tests we have requirement to run after 1 iteration without completing
> >       the precopy migration.  Before that we have either set bandwidth to
> >       ridiculous low value, or tricks on detecting guest memory change over
> >       some adhoc guest memory position.  Now we can simply set this flag
> >       then we know precopy won't complete and will just keep going.
> >
> > Here we leveraged a sem to make sure migration thread won't busy spin on a
> > physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
> > its best to sync with dest QEMU from time to time.  Note that the sem is
> > prone to outdated counts but it's benign, please refer to the comment above
> > the semaphore definition for more information.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json            | 25 ++++++++++--
> >  migration/migration.h          | 17 +++++++++
> >  migration/migration-hmp-cmds.c |  7 ++++
> >  migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
> >  migration/options.c            | 17 +++++++++
> >  5 files changed, 128 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 47dfef0278..c050081555 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -789,6 +789,15 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > +# @switchover-hold: Whether we should hold-off precopy switchover from
> > +#     src to dest QEMU, even if we can finish migration in the
> 
> Spell out "source" and "destination", please.
> 
> Recommend to spell it out in the commit message, too.

Will do.

> 
> > +#     downtime specified.  By default off, so precopy migration will
> > +#     complete as soon as possible.  One can set it to explicitly keep
> > +#     iterating during precopy migration until set the flag to false
> > +#     again to kick off the final switchover.  Note, this does not
> 
> "until the flag is set to false again"
> 
> or
> 
> "until the flag is cleared".

Will do.

> 
> > +#     affect postcopy switchover, because the user can control that
> > +#     using "migrate-start-postcopy" command explicitly.  (Since 8.1)
> > +#
> >  # Features:
> >  #
> >  # @unstable: Member @x-checkpoint-delay is experimental.
> > @@ -810,7 +819,7 @@
> >             'xbzrle-cache-size', 'max-postcopy-bandwidth',
> >             'max-cpu-throttle', 'multifd-compression',
> >             'multifd-zlib-level' ,'multifd-zstd-level',
> > -           'block-bitmap-mapping' ] }
> > +           'block-bitmap-mapping', 'switchover-hold' ] }
> >  
> >  ##
> >  # @MigrateSetParameters:
> > @@ -945,6 +954,10 @@
> >  #     Nodes are mapped to their block device name if there is one, and
> >  #     to their node name otherwise.  (Since 5.2)
> >  #
> > +# @switchover-hold: Whether we should hold-off precopy switchover from
> > +#     src to dest QEMU.  For more details, please refer to
> > +#     MigrationParameter entry of the same field.  (Since 8.1)
> 
> We normally duplicate the documentation.  This would be the first
> instance where we reference instead.  Do we want that?

Personally I'd hope to try avoid any form of duplication if possible.  We
have some structure duplications that I cannot avoid (not until someone,
including myself, can dedup it..), so I tried to not duplicate exactly same
thing in the documents at least, instead to put such a reference.

But I agree only referencing other docs in this flag is special.  We may
want to do at least the same across all the parameters.  I have no strong
opinion either, so if we want to keep full descriptions in multiple places
I'll do that in the new spin. It's more QAPI stuff IMHO; I'll just follow
your advise.

Thanks for taking a look!

-- 
Peter Xu


