Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6181586CBAA
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 15:35:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhUW-0004vh-Nu; Thu, 29 Feb 2024 09:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfhUO-0004tq-IG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:34:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfhUM-0008Cw-Ke
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709217259;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MVYHrVeU9oNfbyTSVSnir8b6q4TVAjW+f/IOg5tGrRs=;
 b=KP4aOs5kpiRRTcjtbeMuZiDwrp7FzGtSIsKAaa0tAmZnOgaxo0XB3nwAmffl1MVB7w5t3W
 grkeRjM1rnJ9NQq/YzteUhGVIFGZT/RoIfzR6EeYSAYKGDolpWgTmK3iBIJgrcXOAuo9pb
 1kR/1X2Etd+gRsimL5LBqgseFNkqlQY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-7RiELA5FOTaqDONbnE9eDA-1; Thu,
 29 Feb 2024 09:34:16 -0500
X-MC-Unique: 7RiELA5FOTaqDONbnE9eDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ADBA1C05138;
 Thu, 29 Feb 2024 14:34:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70B43C185C0;
 Thu, 29 Feb 2024 14:34:15 +0000 (UTC)
Date: Thu, 29 Feb 2024 14:34:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 17/23] migration/multifd: Add outgoing QIOChannelFile
 support
Message-ID: <ZeCV5dVQCOLol9pO@redhat.com>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-18-farosas@suse.de> <Zd_vhfonAX5gIcJl@x1n>
 <Zd_67kAJ3OcDFNjC@x1n> <87msrjz6ov.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msrjz6ov.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Feb 29, 2024 at 11:27:44AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Feb 29, 2024 at 10:44:21AM +0800, Peter Xu wrote:
> >> On Wed, Feb 28, 2024 at 12:21:21PM -0300, Fabiano Rosas wrote:
> >> > Allow multifd to open file-backed channels. This will be used when
> >> > enabling the mapped-ram migration stream format which expects a
> >> > seekable transport.
> >> > 
> >> > The QIOChannel read and write methods will use the preadv/pwritev
> >> > versions which don't update the file offset at each call so we can
> >> > reuse the fd without re-opening for every channel.
> >> > 
> >> > Contrary to the socket migration, the file migration doesn't need an
> >> > asynchronous channel creation process, so expose
> >> > multifd_channel_connect() and call it directly.
> >> > 
> >> > Note that this is just setup code and multifd cannot yet make use of
> >> > the file channels.
> >> > 
> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> > ---
> >> > - moved flags change to another patch
> >> > - removed channels_created assert
> >> > ---
> >> >  migration/file.c    | 41 +++++++++++++++++++++++++++++++++++++++--
> >> >  migration/file.h    |  4 ++++
> >> >  migration/multifd.c | 18 +++++++++++++++---
> >> >  migration/multifd.h |  1 +
> >> >  4 files changed, 59 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/migration/file.c b/migration/file.c
> >> > index 22d052a71f..83328a7a1b 100644
> >> > --- a/migration/file.c
> >> > +++ b/migration/file.c
> >> > @@ -12,12 +12,17 @@
> >> >  #include "channel.h"
> >> >  #include "file.h"
> >> >  #include "migration.h"
> >> > +#include "multifd.h"
> >> >  #include "io/channel-file.h"
> >> >  #include "io/channel-util.h"
> >> >  #include "trace.h"
> >> >  
> >> >  #define OFFSET_OPTION ",offset="
> >> >  
> >> > +static struct FileOutgoingArgs {
> >> > +    char *fname;
> >> > +} outgoing_args;
> >> > +
> >> >  /* Remove the offset option from @filespec and return it in @offsetp. */
> >> >  
> >> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> >> > @@ -37,6 +42,36 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> >> >      return 0;
> >> >  }
> >> >  
> >> > +void file_cleanup_outgoing_migration(void)
> >> > +{
> >> > +    g_free(outgoing_args.fname);
> >> > +    outgoing_args.fname = NULL;
> >> > +}
> >> > +
> >> > +bool file_send_channel_create(gpointer opaque, Error **errp)
> >> > +{
> >> > +    QIOChannelFile *ioc;
> >> > +    int flags = O_WRONLY;
> >> > +    bool ret = true;
> >> > +
> >> > +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
> >> > +    if (!ioc) {
> >> > +        ret = false;
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
> >> > +
> >> > +out:
> >> > +    /*
> >> > +     * File channel creation is synchronous. However posting this
> >> > +     * semaphore here is simpler than adding a special case.
> >> > +     */
> >> > +    multifd_send_channel_created();
> >> > +
> >> > +    return ret;
> >> > +}
> >> > +
> >> >  void file_start_outgoing_migration(MigrationState *s,
> >> >                                     FileMigrationArgs *file_args, Error **errp)
> >> >  {
> >> > @@ -47,12 +82,14 @@ void file_start_outgoing_migration(MigrationState *s,
> >> >  
> >> >      trace_migration_file_outgoing(filename);
> >> >  
> >> > -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
> >> > -                                     0600, errp);
> >> > +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_TRUNC | O_WRONLY,
> >> > +                                     0660, errp);
> >> 
> >> It seems this is still leftover?
> >> 
> >> >      if (!fioc) {
> >> >          return;
> >> >      }
> >> >  
> >> > +    outgoing_args.fname = g_strdup(filename);
> >> > +
> >> >      ioc = QIO_CHANNEL(fioc);
> >> >      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
> >> >          return;
> >> > diff --git a/migration/file.h b/migration/file.h
> >> > index 37d6a08bfc..4577f9efdd 100644
> >> > --- a/migration/file.h
> >> > +++ b/migration/file.h
> >> > @@ -9,10 +9,14 @@
> >> >  #define QEMU_MIGRATION_FILE_H
> >> >  
> >> >  #include "qapi/qapi-types-migration.h"
> >> > +#include "io/task.h"
> >> > +#include "channel.h"
> >> >  
> >> >  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
> >> >  
> >> >  void file_start_outgoing_migration(MigrationState *s,
> >> >                                     FileMigrationArgs *file_args, Error **errp);
> >> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
> >> > +void file_cleanup_outgoing_migration(void);
> >> > +bool file_send_channel_create(gpointer opaque, Error **errp);
> >> >  #endif
> >> > diff --git a/migration/multifd.c b/migration/multifd.c
> >> > index 3574fd3953..f155223303 100644
> >> > --- a/migration/multifd.c
> >> > +++ b/migration/multifd.c
> >> > @@ -17,6 +17,7 @@
> >> >  #include "exec/ramblock.h"
> >> >  #include "qemu/error-report.h"
> >> >  #include "qapi/error.h"
> >> > +#include "file.h"
> >> >  #include "ram.h"
> >> >  #include "migration.h"
> >> >  #include "migration-stats.h"
> >> > @@ -28,6 +29,7 @@
> >> >  #include "threadinfo.h"
> >> >  #include "options.h"
> >> >  #include "qemu/yank.h"
> >> > +#include "io/channel-file.h"
> >> >  #include "io/channel-socket.h"
> >> >  #include "yank_functions.h"
> >> >  
> >> > @@ -694,6 +696,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> >> >  {
> >> >      if (p->c) {
> >> >          migration_ioc_unregister_yank(p->c);
> >> > +        qio_channel_close(p->c, NULL);
> >> 
> >> s/NULL/&error_abort/?
> >
> > Or we can drop this line?  IIUC iochannel finalize() will always close it,
> > or it could be a separate bug.
> >
> 
> We need it so the fsync happens. The finalize() will be a noop because
> the qio_channel_file_close() will clear the fd. Not the cleanest, but it
> works.

It is always wise to explicitly call 'close'.

If something still has a GSource watch registered against
the QIOChannel, that GSource will be holding a reference
on the QIOChannel and will thus prevent finalize() ever
running.

By calling close() you guarantee the channel is closed,
even if you've mistakenly leaked a GSource somewhere.
Finalize still won't run in that case, but at least the
FD is gone, and the HUP might cause the GSource callback
to trigger correct cleanup;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


