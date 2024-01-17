Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF6830149
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:29:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1Hw-0002c4-V2; Wed, 17 Jan 2024 03:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ1Hv-0002bw-Bu
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ1Ht-0007E9-L6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705480121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7XCl4b+g4DUpnCNb3lzH5T5CT8nGGTljoWo7lym+PU=;
 b=FANahHwO6y1qXxYBNY4mUBgoS7WK668xR8tcoMnB6Nm0/onzaXF3gCGEJaf3BslfxaqQnO
 H2tOnoQmmAze9T3n5tnrk7iD5eIODIAyQF5tTwCGwElhDC1fV+TveEZfeziRaLYVbI0hcu
 cis5GEBwUyW9zh2HRpuge2BuQlJ5zfY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-bJNgVrykOiy0D2XQ50ZdkQ-1; Wed, 17 Jan 2024 03:28:39 -0500
X-MC-Unique: bJNgVrykOiy0D2XQ50ZdkQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d724647a7fso1892801b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480118; x=1706084918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7XCl4b+g4DUpnCNb3lzH5T5CT8nGGTljoWo7lym+PU=;
 b=J0oNnE5M688WMysHmOYXrx6Ahr7BGwaevgQZ3mwcBYzEEvogFXCT4/UJhCXqfZyIRE
 KG4bPCMkejRL4nTOJr0q7lGZp802iGW04BlPckhkLt62oY4MaUF0g3W5ZvxzCye7onba
 t7h5KrFUTJAL5OBmVIkKjEvu7toRAcytDNGegZNWr4BPgYcLqcu6L5Cp/rkqq/5c331r
 EUVw43ahnDMtUdblWEpNFrjgD7xwe7GVQE2f+ULY2waA0XznXFbKIjHu89YcPNUgd1q+
 SRx2QuWHdbmZmpHivEtjayYF9oCT4V4YTXXEMP+KUFAwW6vzZ5QRwJozBSZ/c1HvVGy4
 dyoA==
X-Gm-Message-State: AOJu0Yw1T/Ud75aZv8rMQTorVNgS67mymgsfc77KeGEXeZNpOZy5wCDS
 IdwXsrAwquNQVvvthlPwipv0rGTDzlVbQ704qaH25dHHl8ml2xU4hTZMsxdwK+073PEsEYnlsgZ
 14qmt2Sz8JG1JBdBLwh8TcwI=
X-Received: by 2002:a05:6a00:2e20:b0:6d9:6081:602d with SMTP id
 fc32-20020a056a002e2000b006d96081602dmr14142804pfb.3.1705480118581; 
 Wed, 17 Jan 2024 00:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6EkfYIBz20awNithIzbIVYy4O6+I2EfnADFQjWsDeiDAlMMjees+OhMYvSLpgE14q7Wx1UA==
X-Received: by 2002:a05:6a00:2e20:b0:6d9:6081:602d with SMTP id
 fc32-20020a056a002e2000b006d96081602dmr14142795pfb.3.1705480118216; 
 Wed, 17 Jan 2024 00:28:38 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j3-20020a056a00130300b006d9c216a9e6sm853931pfu.56.2024.01.17.00.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 00:28:37 -0800 (PST)
Date: Wed, 17 Jan 2024 16:28:33 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 13/30] migration/multifd: Add outgoing
 QIOChannelFile support
Message-ID: <ZaePsW2Q90se0gi3@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-14-farosas@suse.de> <ZaYApbyD5iexbYYW@x1n>
 <87bk9lxutv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk9lxutv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 16, 2024 at 10:37:48AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Nov 27, 2023 at 05:25:55PM -0300, Fabiano Rosas wrote:
> >> Allow multifd to open file-backed channels. This will be used when
> >> enabling the fixed-ram migration stream format which expects a
> >> seekable transport.
> >> 
> >> The QIOChannel read and write methods will use the preadv/pwritev
> >> versions which don't update the file offset at each call so we can
> >> reuse the fd without re-opening for every channel.
> >> 
> >> Note that this is just setup code and multifd cannot yet make use of
> >> the file channels.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >> - open multifd channels with O_WRONLY and no mode
> >> - stop cancelling migration and propagate error via qio_task
> >> ---
> >>  migration/file.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
> >>  migration/file.h      |  5 +++++
> >>  migration/multifd.c   | 14 +++++++++++--
> >>  migration/options.c   |  7 +++++++
> >>  migration/options.h   |  1 +
> >>  migration/qemu-file.h |  1 -
> >>  6 files changed, 70 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/migration/file.c b/migration/file.c
> >> index 5d4975f43e..67d6f42da7 100644
> >> --- a/migration/file.c
> >> +++ b/migration/file.c
> >> @@ -17,6 +17,10 @@
> >>  
> >>  #define OFFSET_OPTION ",offset="
> >>  
> >> +static struct FileOutgoingArgs {
> >> +    char *fname;
> >> +} outgoing_args;
> >> +
> >>  /* Remove the offset option from @filespec and return it in @offsetp. */
> >>  
> >>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> >> @@ -36,6 +40,42 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
> >>      return 0;
> >>  }
> >>  
> >> +static void qio_channel_file_connect_worker(QIOTask *task, gpointer opaque)
> >> +{
> >> +    /* noop */
> >> +}
> >> +
> >> +int file_send_channel_destroy(QIOChannel *ioc)
> >> +{
> >> +    if (ioc) {
> >> +        qio_channel_close(ioc, NULL);
> >> +        object_unref(OBJECT(ioc));
> >> +    }
> >> +    g_free(outgoing_args.fname);
> >> +    outgoing_args.fname = NULL;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +void file_send_channel_create(QIOTaskFunc f, void *data)
> >> +{
> >> +    QIOChannelFile *ioc;
> >> +    QIOTask *task;
> >> +    Error *err = NULL;
> >> +    int flags = O_WRONLY;
> >> +
> >> +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, &err);
> >> +
> >> +    task = qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
> >> +    if (!ioc) {
> >> +        qio_task_set_error(task, err);
> >> +        return;
> >> +    }
> >> +
> >> +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
> >> +                           (gpointer)data, NULL, NULL);
> >
> > This is pretty weird.  This invokes a thread, but it'll run a noop.  It
> > seems meaningless to me.
> >
> 
> That's QIOTask weirdness isn't it? It will run the worker in the thread,
> but it also schedules the completion function as a glib event. So that's
> when multifd_new_send_channel_async() will run. The crucial aspect here
> is that it gets dispatched by glib on the main loop. I'm just keeping
> the model, except that I don't have work to do during the "connection"
> phase.

The question is why do we need that if "file:" can be done synchronously.
Please see below.

> 
> > I assume you wanted to keep using the same async model as the socket typed
> > multifd, but I don't think that works anyway, because file open blocks at
> > qio_channel_file_new_path() so it's sync anyway.
> 
> It's async regarding multifd_channel_connect(). The connections will be
> happening while multifd_save_setup() continues execution, IIUC.

Yes.  But I'm wondering whether we can start to simplify at least the
"file:" for this process.  We all know that we _may_ have created too many
threads each doing very light work, which might not be needed.  We haven't
yet resolved the "how to kill a thread along this process if migration
cancels during when one thread got blocked in a syscall" issue.  We'll need
to start recording tids for every thread, and that'll be a mess for sure
when there're tons of threads.

> 
> >
> > AFAICT we still share the code, as long as the file path properly invokes
> > multifd_channel_connect() after the iochannel is setup.
> >
> 
> I don't see the point in moving any of that logic into the URI
> implementation. We already have the TLS handshake code which can also
> call multifd_channel_connect() and that is a mess. IMO we should be
> keeping the interface between multifd and the frontends as boilerplate
> as possible.

Hmm, I don't think it's a mess?  At least multifd_channel_connect(). AFAICT
multifd_channel_connect() can be called in any context.

multifd_channel_connect() always creates yet another thread, no matter it's
for tls handshake, or it's one of the multifd send thread.

Here this series already treat file/socket differently:

static void multifd_new_send_channel_create(gpointer opaque)
{
    if (migrate_to_file()) {
        file_send_channel_create(multifd_new_send_channel_async, opaque);
    } else {
        socket_send_channel_create(multifd_new_send_channel_async, opaque);
    }
}

What I am thinking is it could be much simpler if
multifd_new_send_channel_create() can create the multifd channels
synchronously here, then directly call multifd_channel_connect(), further
that'll create threads for whatever purposes.

When TLS is not enabled, I'd expect if with that change and with a "file:"
URI, after multifd_save_setup() completes, all send threads will be created
already.

I think multifd_new_send_channel_create() can already take
"MultiFDSendParams *p" as parameter, then:

static void multifd_new_send_channel_create(MultiFDSendParams *p)
{
    if (migrate_to_file()) {
        file_send_channel_create(p);
    } else {
        socket_send_channel_create(multifd_new_send_channel_async, p);
    }
}

Where file_send_channel_create() can call multifd_channel_connect()
directly upon the ioc created.

Would that work for us, and much cleaner?

-- 
Peter Xu


