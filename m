Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5492A2C7A9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Feb 2025 16:47:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQYV-0001b8-7L; Fri, 07 Feb 2025 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgQYP-0001Zo-Bu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgQYN-0001TZ-9t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738943162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CS0d8uBQT8PP1QW4QnkEiAb4SzxGxDxlkJXxY6iWoQQ=;
 b=dUAaXBt2LWZNSfgQ6228f4OZVb5xahUpl1yb5I4DipVpcrsGkgiicagyHiHbs41zHTzDea
 G7kXhWJHCJuXrzRfD35CkAzZQJYSVbUXcTaPiYR01xgmZz7fhM5DdJb41Vmx5N3IzpCr1k
 ta6qHFknTsAj2yIHF68y32ueklX9Z+Q=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-K81PLfmQMRuU5qIoTwhOQQ-1; Fri, 07 Feb 2025 10:46:01 -0500
X-MC-Unique: K81PLfmQMRuU5qIoTwhOQQ-1
X-Mimecast-MFC-AGG-ID: K81PLfmQMRuU5qIoTwhOQQ
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5f9e4a639acso1885046eaf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943158; x=1739547958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CS0d8uBQT8PP1QW4QnkEiAb4SzxGxDxlkJXxY6iWoQQ=;
 b=An0TX/RDlxFRAmtMBlWouVFp2zBLMNYRuKQGQk+LNFY1lihULDrBPbJJXH426NbBLp
 1ph5Ft9UsrlT/Ro7wgGzv3Qcx6S3BoTYfXOx4btV1t5qYEgnaVOw/8hRQbt/xGfj4juu
 ZaRo3orqJOlpuKrpZgGo2OOaa9+gjlP7cyK4OiFZ5AWH3HV+2OmE4JVpimSiIcdS5T1Y
 WqVVYt2E75oGyHUfyzd5tQuOyhQnaUss/y3UDzGeRWy/oWbVp17iDerxuuqVchhKX2y/
 hQ9sivhOt/2pWMxZ8xfHvW/uokG5DFrKRWy1sTirxAW79h1Qan/JfNCYdPX2Gs3aoT8f
 jS9Q==
X-Gm-Message-State: AOJu0YyRlL6RH9hpfYA6XunsZkEi5nJcAUUNu+PQ6GfaETaJ/33GrQ/7
 Kwd5hc/UYIciDITx5AdWFFCSCrgacYr3tOyY/wAa/jBVf685ujwDZdM1JPYZ9mvMYCnxzR4bS+X
 i3sgSoYvpj65eKvOByYV38AL2Jnruk1uzSSjb6zrY8GzqgZqM5WBU
X-Gm-Gg: ASbGncvVstBL8wwSetn6YptnWZ1Rv3KFecP1ZXjWbxzYdr7u3TGVRteFVhMg3v0NT60
 aHWOXL7kZ3ZLPHXOh/MjVRQeCtrvqBfomlznFgaMqwn27atSpq9cCxa0aC3FVRtP4546rL1jgqI
 cJw8cBCWev6TuyPdxBGAsFooEh59r/nifdyWVtYzMwpQt4zJzYLg1zDLWjSpWk+FR4ZT80Lwwp9
 cfFYYSMo2G2MqUdx7jXMO5t1h+ewXqGEdFgTWo+F/rX2783IifCm/bCeldTZEKcyY5fpEu7mwKf
 p+rH3GPTByN9Wr8FS9oV/5I9V4PFhInmjADLuJdbCoYpcHQe
X-Received: by 2002:a05:6820:1803:b0:5f8:89bd:b99b with SMTP id
 006d021491bc7-5fc5e746f98mr2531392eaf.8.1738943157874; 
 Fri, 07 Feb 2025 07:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnwb/nzfWVYfZfRnUPx4o2LFx5AXEp7Zmrt3hFJdSES+E7zALVHQXw4zPMZqjsmWjDkNv+tg==
X-Received: by 2002:a05:6820:1803:b0:5f8:89bd:b99b with SMTP id
 006d021491bc7-5fc5e746f98mr2531376eaf.8.1738943157505; 
 Fri, 07 Feb 2025 07:45:57 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc545d6246sm778057eaf.33.2025.02.07.07.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:45:56 -0800 (PST)
Date: Fri, 7 Feb 2025 10:45:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6YqstgG2bSY45dM@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 07, 2025 at 04:02:44PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Fri, 7 Feb 2025 at 04:46, Peter Xu <peterx@redhat.com> wrote:
> > > +/* Migration channel types */
> > > +enum { CH_DEFAULT, CH_MULTIFD, CH_POSTCOPY };
> >
> > Maybe s/DEFAULT/MAIN/?
> 
> * Okay.
> 
> > > -    if (migrate_multifd() && !migrate_mapped_ram() &&

[b]

> > > -        !migrate_postcopy_ram() &&
> > > -        qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> > > +    if (!migration_should_start_incoming(channel)) {
> >
> > This says "if we assume this is the main channel, and if we shouldn't start
> > incoming migration, then we should peek at the buffers".
> > Could you help explain?
> 
> * New migration starts only when the main channel and if 'multifd' is
> enabled all multifd channels are established. So, if 'main' and
> 'multifd' channels are _not_ established then migration should _not_
> start. And in that case, incoming connection is likely for one of
> those channels and so we should peek at the buffers, because both
> 'main' and 'multifd' channels send magic values.
> 
> * migration_should_start_incoming() function returns 'true' only when
> 'main' and 'multifd' channels are being established. For 'postcopy'
> channel it returns false.

This is not easy to follow neither with the current name, nor that you
"assumed this is main channel" and test it.  I think you may want to split
migration_has_all_channels() into migration_has_essential_channels() which
only covers main and multifd cases.  Then you can check if (!has_esential)
here.  You'd better also add a comment that all "essential channels" can be
peeked.

You may also want to bypass a few things, e.g. "postcopy paused stage" here
rather than inside, because postcopy-recover only happens:

  - First with a main channel, that is not peekable as no header when resume
  - Then with preempt channel, that is also not peekable

[a]

You may also need to keep the mapped-ram check.  They also don't support
peek.

> 
> 
> > > +            } else if (!mis->from_src_file
> > > +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > > +                /* reconnect default channel for postcopy recovery */
> > > +                channel = CH_DEFAULT;
> >
> > This is still in the big "peek buffer" if condition.
> > IMHO we can skip peeking buffer when postcopy paused, because in this stage
> > the channel must be (1) main channel first, then (2) preempt channel next.
> 
> * It is in the big 'peek buffer' condition because the 'main' channel
> (= CH_DEFAULT) is being established here. Ideally, all channels should
> send magic values to be consistent. The 'main' channel sends magic
> value when it is established before starting migration, but the same
> 'main' channel does not send magic value when it is established during
> postcopy recovery, that is an inconsistency (a bug) here. Ideal fix is

For a reconnection we could do better to define a header format indeed for
such extensions.  I can't say it's a bug.

> to send a magic value every time the 'main' channel is established,
> irrespective of when it is established.
> 
> * Adding conditionals to check if it is _POSTCOPY_PAUSED state then
> don't peek will only lead to complicated 'if' conditionals. This
> channel handling code is already complex and non-intuitive enough.

Please see above [a].

> 
> > > +        } else if (mis->from_src_file
> > > +            && (!strcmp(ioc->name, "migration-tls-incoming")
> > > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
> > > +            channel = CH_MULTIFD;
> >
> > Confused here too.  Why do we need to check ioc name? Shouldn't multifd has
> > the headers?
> 
> * Because they are not 'multifd' channels, tls/file channels don't
> send magic values, but are still handled by

It might be because you have a bug where you removed mapped-ram check at
[b] above.  I think we need to keep it.

Why TLS channels don't send magic?

> 'multifd_recv_new_channel()' function.
> ===
>     ...
>     if (default_channel) {
>         migration_incoming_setup(f);
>     } else {
>         if (migrate_multifd()) {
>             multifd_recv_new_channel(ioc, &local_err);
>         } else {
>             postcopy_preempt_new_channel(mis, f);
>         }
> ===
> In the code above, if 'default_channel==false' and multifd() is
> enabled, all incoming connections are handled by
> 'multifd_recv_new_channel()', irrespective of whether it is a
> 'multifd' channel or not. While creating multifd channels, there is no
> check for channel type like: if(channel == CH_MULTIFD).
> 
> * IMHO, if we make all channels behave with consistency, ie. either
> they all send magic value or none sends magic value, that'll simplify
> this code a lot.
> 
> > > -        assert(migration_needs_multiple_sockets());
> > Could I ask why removal?
> 
> * Because that function returns migrate_multifd() =>
> migrate_multifd() || migrate_postcopy_preempt();
> * And the very following check is also migrate_multifd(), as below:
> 
> > >          if (migrate_multifd()) {
> > >              multifd_recv_new_channel(ioc, &local_err);
> 
> 
> > It might be better to avoid such "ret && XXX" nested check.  E.g. do you
> > think below easier to read?
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 74c50cc72c..9eb2f3fdeb 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1064,12 +1064,14 @@ bool migration_has_all_channels(void)
> >          return false;
> >      }
> >
> > -    if (migrate_multifd()) {
> > -        return multifd_recv_all_channels_created();
> > +    if (migrate_multifd() &&
> > +        !multifd_recv_all_channels_created()) {
> > +        return false;
> >      }
> >
> > -    if (migrate_postcopy_preempt()) {
> > -        return mis->postcopy_qemufile_dst != NULL;
> > +    if (migrate_postcopy_preempt() &&
> > +        mis->postcopy_qemufile_dst == NULL) {
> > +        return false;
> >      }
> >
> >      return true;
> 
> * Will try it.
> 
> > > -    if (!migrate_multifd()) {
> > > +    if (!migrate_multifd() || migration_in_postcopy()) {
> > >          return 0;
> > >      }
> >
> > [1]
> >
> > >
> > >      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index f2326788de..bdba7abe73 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -1295,7 +1295,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
> > >          pss->page = 0;
> > >          pss->block = QLIST_NEXT_RCU(pss->block, next);
> > >          if (!pss->block) {
> > > -            if (multifd_ram_sync_per_round()) {
> > > +            if (multifd_ram_sync_per_round() && !migration_in_postcopy()) {
> >
> > If you have above[1], why need this?
> 
> * True, I tried with just [1] above first, but it was failing for some
> reason. Will try again.

Another approach (cleaner at least to me..) is we check in_postcopy in
multifd_ram_sync_per_*() functions.

> 
> > This patch still did nothing for multifd in postcopy_start().  I'm not sure
> > it's safe.
> >
> > What happens if some multifd pages were sent, then we start postcopy, dest
> > vcpu threads running, then during postcopy some multifd pages finally
> > arrived and modifying the guest pages during vcpus running?
> 
> * ram_save_target_page() function saves multifd pages only when
> (..!migration_in_postcopy()) not in postcopy mode. Case of 'multifd'
> page arriving late on destination and 'postcopy' starting before that
> is strange, because if multifd page is getting late, that network
> latency should affect 'postcopy' channel too, no? But still if it is

I don't think so.  postcopy doesn't use any multifd channels.

> possible, do we want to call - multifd_ram_flush_and_sync() before
> postcopy_start()? Will that help?  I'll check if/how it works.

Note that all things flushed may or may not be enough, because IIUC the
flush only makes sure all threads are synced.  It may not make sure the
order of things to happen in multifd threads and postcopy thread.  The
latter is what we need - we need to make sure no page land in postcopy
threads.

That's why I was requesting to add an assert() in multifd recv thread to
make sure we will never receive a page during postcopy.

This part is the most important change of the whole series, please take
your time to understand the workflow and let's make sure it won't happen.

Thanks,

-- 
Peter Xu


