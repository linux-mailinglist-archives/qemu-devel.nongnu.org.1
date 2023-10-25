Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B108B7D6797
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaYx-0003vJ-4i; Wed, 25 Oct 2023 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaYp-0003ib-9V
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaYm-0006pG-7z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698227538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sbtOVOU3HfVHXVlL4f0OK42TI0tCRmnsmNb0qicuJmg=;
 b=Dw/XuLKROStENTiWcZ/RLgqfluI6YrAconYpZOltWOmU74v3OCMm8UC028/ZI4pN3idi0E
 JXd1JI52nOKyTLEUFvMROZJlt//ov2Mp27Z6D+l3+gGPX1FJfMlJTZZqPux3eMvh95+jcK
 Ls09MdWt2VORGL8PrqUW6F+sV6k9F0I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-qfOqD2BQPJq52ENBaa-U2g-1; Wed, 25 Oct 2023 05:52:06 -0400
X-MC-Unique: qfOqD2BQPJq52ENBaa-U2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7AD7101A52D;
 Wed, 25 Oct 2023 09:52:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 859BD1C060AE;
 Wed, 25 Oct 2023 09:52:04 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:52:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 19/29] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <ZTjlQsw9AvA19+QO@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-20-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:35:58PM -0300, Fabiano Rosas wrote:
> Allow multifd to open file-backed channels. This will be used when
> enabling the fixed-ram migration stream format which expects a
> seekable transport.
> 
> The QIOChannel read and write methods will use the preadv/pwritev
> versions which don't update the file offset at each call so we can
> reuse the fd without re-opening for every channel.
> 
> Note that this is just setup code and multifd cannot yet make use of
> the file channels.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 64 +++++++++++++++++++++++++++++++++++++++++--
>  migration/file.h      | 10 +++++--
>  migration/migration.c |  2 +-
>  migration/multifd.c   | 14 ++++++++--
>  migration/options.c   |  7 +++++
>  migration/options.h   |  1 +
>  6 files changed, 90 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index cf5b1bf365..93b9b7bf5d 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -17,6 +17,12 @@

> +void file_send_channel_create(QIOTaskFunc f, void *data)
> +{
> +    QIOChannelFile *ioc;
> +    QIOTask *task;
> +    Error *errp = NULL;
> +
> +    ioc = qio_channel_file_new_path(outgoing_args.fname,
> +                                    outgoing_args.flags,
> +                                    outgoing_args.mode, &errp);
> +    if (!ioc) {
> +        file_migration_cancel(errp);
> +        return;
> +    }
> +
> +    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
> +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
> +                           (gpointer)data, NULL, NULL);
> +}
> +
>  void file_start_outgoing_migration(MigrationState *s, const char *filespec,
>                                     Error **errp)
>  {
> -    g_autofree char *filename = g_strdup(filespec);
>      g_autoptr(QIOChannelFile) fioc = NULL;
> +    g_autofree char *filename = g_strdup(filespec);
>      uint64_t offset = 0;
>      QIOChannel *ioc;
> +    int flags = O_CREAT | O_TRUNC | O_WRONLY;
> +    mode_t mode = 0660;
>  
>      trace_migration_file_outgoing(filename);
>  
> @@ -50,12 +105,15 @@ void file_start_outgoing_migration(MigrationState *s, const char *filespec,
>          return;
>      }
>  
> -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> -                                     0600, errp);
> +    fioc = qio_channel_file_new_path(filename, flags, mode, errp);

So this initially opens the file with O_CREAT|O_TRUNC which
makes sense.

>      if (!fioc) {
>          return;
>      }
>  
> +    outgoing_args.fname = g_strdup(filename);
> +    outgoing_args.flags = flags;
> +    outgoing_args.mode = mode;

We're passing on O_CREAT|O_TRUNC to all the multifd threads too. This
doesn't make sense to me - the file should already exist and be truncated
by the time the threads open it. I would think they should only be using
O_WRONLY and no mode at all.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


