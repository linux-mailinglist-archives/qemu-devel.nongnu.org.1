Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF47D687F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvb8n-0003IP-C1; Wed, 25 Oct 2023 06:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvb8d-0003HD-Ex
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvb8b-0004hk-L1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 06:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698229760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5g8UeZ355411YNy9GMKRpUE884D6x5hf7K8vyVrfNMY=;
 b=RZipuYW6EPdvD7Fyzo858/xCdAT1sVeD08jGVjuL5PAsVcw/MuYr/iW4dQc8xEibIQfgCU
 F5l16XHtmm3I6w/EeU9JdqnWdhBh2YvC1AqzSUp4yHtUiNxTnINHCRW3/wGZ3tRXg6TCpU
 W536FFXzpkh4Nny0hhbihDj7S+7RLDA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-hmS2z-KTN5qxP97-KuBpcw-1; Wed,
 25 Oct 2023 06:29:17 -0400
X-MC-Unique: hmS2z-KTN5qxP97-KuBpcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB312280017A;
 Wed, 25 Oct 2023 10:29:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D26372026D4C;
 Wed, 25 Oct 2023 10:29:15 +0000 (UTC)
Date: Wed, 25 Oct 2023 11:29:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 20/29] migration/multifd: Add incoming QIOChannelFile
 support
Message-ID: <ZTjt+WB9FJmPjaVw@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-21-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On Mon, Oct 23, 2023 at 05:35:59PM -0300, Fabiano Rosas wrote:
> On the receiving side we don't need to differentiate between main
> channel and threads, so whichever channel is defined first gets to be
> the main one. And since there are no packets, use the atomic channel
> count to index into the params array.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/file.c      | 39 +++++++++++++++++++++++++++++----------
>  migration/migration.c |  2 ++
>  migration/multifd.c   |  7 ++++++-
>  migration/multifd.h   |  1 +
>  4 files changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/file.c b/migration/file.c
> index 93b9b7bf5d..ad75225f43 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -6,13 +6,15 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/cutils.h"
>  #include "qapi/error.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
>  #include "channel.h"
>  #include "file.h"
>  #include "migration.h"
>  #include "io/channel-file.h"
>  #include "io/channel-util.h"
> +#include "options.h"
>  #include "trace.h"
>  
>  #define OFFSET_OPTION ",offset="
> @@ -136,7 +138,8 @@ void file_start_incoming_migration(const char *filespec, Error **errp)
>      g_autofree char *filename = g_strdup(filespec);
>      QIOChannelFile *fioc = NULL;
>      uint64_t offset = 0;
> -    QIOChannel *ioc;
> +    int channels = 1;
> +    int i = 0, fd;
>  
>      trace_migration_file_incoming(filename);
>  
> @@ -146,16 +149,32 @@ void file_start_incoming_migration(const char *filespec, Error **errp)
>  
>      fioc = qio_channel_file_new_path(filename, O_RDONLY, 0, errp);
>      if (!fioc) {
> -        return;
> +        goto out;
> +    }
> +
> +    if (migrate_multifd()) {
> +        channels += migrate_multifd_channels();
>      }
>  
> -    ioc = QIO_CHANNEL(fioc);
> -    if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> +    fd = fioc->fd;
> +
> +    do {
> +        QIOChannel *ioc = QIO_CHANNEL(fioc);
> +
> +        if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> +            return;
> +        }
> +
> +        qio_channel_set_name(ioc, "migration-file-incoming");
> +        qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                   file_accept_incoming_migration,
> +                                   NULL, NULL,
> +                                   g_main_context_get_thread_default());
> +    } while (++i < channels && (fioc = qio_channel_file_new_fd(fd)));

IIUC, this loop is failing to call qio_channel_io_seek to set
the offset on the last 'fioc' that is created.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


