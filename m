Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAF17DD7C0
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:29:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxwHn-0007ZZ-Nd; Tue, 31 Oct 2023 17:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxwHd-0007Xh-OZ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxwHb-0007y3-Tf
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698787698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1x9xHSmWTCJdct9wnUSjFgYZc9gnX6ULnfTmtwJOeY=;
 b=WK6hS35ujYDf5WO75K8iM9tNOjgRCL8/uEwmmOIrsUknfGMx8P0ViNOOPBuKE+iJZtg7nC
 zMUPdaX0I+eKx3pDAetxX4tPUfCQU579hyIPtu1t4lMaTkNPkgFVhjnPN7eKiFX84yPX6t
 eqzOK9EYELCoE7DN1fIDVlhmcDPvji8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-K9eZgNRDPIOFvK4QdRyuvg-1; Tue, 31 Oct 2023 17:28:11 -0400
X-MC-Unique: K9eZgNRDPIOFvK4QdRyuvg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7789cde7421so63738885a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698787691; x=1699392491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1x9xHSmWTCJdct9wnUSjFgYZc9gnX6ULnfTmtwJOeY=;
 b=flX3HE8tSoYZ7RPhMLtUEiXuWSnygoUF6qpY/UTEiS73liEn3YnuVH90cNFGwrJCyx
 YHYlhC9VEuAqoowaPWsXs+b5We81a1v+yVMNSP9jcUc9xruS/JEuqFhrlPoLpuame4px
 4BvcIWMsrxiXBUlkhBUQRy3kKFYKf4C9TwmId0D1sNPv7BIbbGtKLbTA1Qiiv9EO5WL5
 /GbmY9M1bSTOvqokOakh2Ok9A455yXFlrz4RiebCE+XYGW6cJefwkkV7lr5fIYewVTte
 ggXi57e8rKPNZ08zweBJ4UnwM7tis47Q3Bx1H4kdak4Ipufs/+X8LdVPKEcTLrOQYfeL
 /GXQ==
X-Gm-Message-State: AOJu0Yy/tJsDzesgTJ3wANlYdx8R+738Q8cXuODGR2VS9xDaWhq3FucJ
 Izflm2zYVWlGnWtEvqoNuVUAKodK7tcP8wBef6XHN8pfpwRI4Ih7cI6ApNIGMvM6z2em1ITDcq7
 xKkWFpPvy9bgOEzo=
X-Received: by 2002:a05:620a:1910:b0:76f:1118:9b62 with SMTP id
 bj16-20020a05620a191000b0076f11189b62mr16372312qkb.3.1698787691151; 
 Tue, 31 Oct 2023 14:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnxJ6/oqBxdmyjs+JaIxrh82G73bypfq8iDT38xevDGmOI2DC1hQhymNbZJQYnBPhfI+ruVw==
X-Received: by 2002:a05:620a:1910:b0:76f:1118:9b62 with SMTP id
 bj16-20020a05620a191000b0076f11189b62mr16372299qkb.3.1698787690759; 
 Tue, 31 Oct 2023 14:28:10 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w15-20020a05620a148f00b007757f6558b3sm841244qkj.95.2023.10.31.14.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 14:28:10 -0700 (PDT)
Date: Tue, 31 Oct 2023 17:28:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 20/29] migration/multifd: Add incoming QIOChannelFile
 support
Message-ID: <ZUFxaFzT+DiYBzPV@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-21-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Can we already return with *errp set?  Why still need the error_report()?

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
> +
> +out:
> +    if (!fioc) {
> +        error_report("Error creating migration incoming channel");
>          return;
>      }
> -    qio_channel_set_name(QIO_CHANNEL(ioc), "migration-file-incoming");
> -    qio_channel_add_watch_full(ioc, G_IO_IN,
> -                               file_accept_incoming_migration,
> -                               NULL, NULL,
> -                               g_main_context_get_thread_default());
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index ba806cea55..5fa726f6d4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -756,6 +756,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          }
>  
>          default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
> +    } else if (migrate_multifd() && migrate_fixed_ram()) {
> +        default_channel = multifd_recv_first_channel();

Is this check required?  IIUC you wanted to set default_channel only when
the 1st time trigger this function, but then IIUC that's exactly what:

        default_channel = !mis->from_src_file;

is about?

I think it may be clearer to add "migrate_multifd_packets()" too in the
previous "if" check to make sure fixed-ram won't peak it.

IIUC now it won't fall into that now only because file URI doesn't yet
support QIO_CHANNEL_FEATURE_READ_MSG_PEEK, however AFAIU it'll be fairly
easy to add it, and even more reasonable than a socket, when adding.

Fundamentally that trick can only work with multifd init packets, that
matches with what migrate_multifd_packets() means.

>      } else {
>          default_channel = !mis->from_src_file;
>      }
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 75a17ea8ab..ad51210f13 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1242,6 +1242,11 @@ int multifd_load_setup(Error **errp)
>      return 0;
>  }
>  
> +bool multifd_recv_first_channel(void)
> +{
> +    return !multifd_recv_state;
> +}
> +
>  bool multifd_recv_all_channels_created(void)
>  {
>      int thread_count = migrate_multifd_channels();
> @@ -1284,7 +1289,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>          /* initial packet */
>          num_packets = 1;
>      } else {
> -        id = 0;
> +        id = qatomic_read(&multifd_recv_state->count);

I was quite confused on the previous "id=0" and now it answers..

Can we merge the two patches somehow?

>      }
>  
>      p = &multifd_recv_state->params[id];
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a835643b48..a112ec7ac6 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -18,6 +18,7 @@ void multifd_save_cleanup(void);
>  int multifd_load_setup(Error **errp);
>  void multifd_load_cleanup(void);
>  void multifd_load_shutdown(void);
> +bool multifd_recv_first_channel(void);
>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


