Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37FE76EE08
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:25:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaBe-0000Tq-9e; Thu, 03 Aug 2023 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRaBc-0000TO-MF
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRaBa-0000Ql-AN
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691076261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=z6GouVEc03aBS7Ye1mCgDPU1PiFLIdY6kAMEysbnuKs=;
 b=EB6OlxzShRxdDe44MGxLusBYkgCVOJ0qw0pg/uWeW1aoJP884FGciqREvS/UG6eYEqvVbS
 yvZUuahxyz/qTfpxf89+DbKVUnZpKXt6VG/v4AEODOGRY2kQUk1VMn8l2p2G5Ky1+aVOYI
 R/hxM+59/7a64YoYSeDU0icNQEeJQI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-_7OGcFbjPAGksxhtQMnz2A-1; Thu, 03 Aug 2023 11:24:19 -0400
X-MC-Unique: _7OGcFbjPAGksxhtQMnz2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F5178DC669;
 Thu,  3 Aug 2023 15:24:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A101454142;
 Thu,  3 Aug 2023 15:24:18 +0000 (UTC)
Date: Thu, 3 Aug 2023 16:24:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Message-ID: <ZMvGoD61XG/Lr3jI@redhat.com>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
 <874jlhcj2p.fsf@suse.de> <ZMq/QKI+qYSw4gPN@x1n>
 <87y1isb2wd.fsf@suse.de> <ZMvEnbQzPEqIROlD@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMvEnbQzPEqIROlD@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 03, 2023 at 11:15:41AM -0400, Peter Xu wrote:
> On Thu, Aug 03, 2023 at 11:45:38AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Wed, Aug 02, 2023 at 04:58:38PM -0300, Fabiano Rosas wrote:
> > >> Peter Xu <peterx@redhat.com> writes:
> > >> 
> > >> > On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
> > >> >> This function currently has a straight-forward part which is waiting
> > >> >> for the thread to join and a complicated part which is doing a
> > >> >> qemu_file_shutdown() on the return path file.
> > >> >> 
> > >> >> The shutdown is tricky because all calls to qemu_file_shutdown() set
> > >> >> f->last_error to -EIO, which means we can never know if an error is an
> > >> >> actual error or if we cleanly shutdown the file previously.
> > >> >> 
> > >> >> This is particularly bothersome for postcopy because it would send the
> > >> >> return path thread into the retry routine which would wait on the
> > >> >> postcopy_pause_rp_sem and consequently block the main thread. We
> > >> >> haven't had reports of this so I must presume we never reach here with
> > >> >> postcopy.
> > >> >> 
> > >> >> The shutdown call is also racy because since it doesn't take the
> > >> >> qemu_file_lock, it could NULL-dereference if the return path thread
> > >> >> happens to be in the middle of the critical region at
> > >> >> migration_release_dst_files().
> > >> >
> > >> > After you rework the thread model on resume, shall we move
> > >> > migration_release_dst_files() into the migration thread to be after the
> > >> > pthread_join()?  I assume then we don't even need a mutex to protect it?
> > >> >
> > >> 
> > >> I just need to figure out if it's ok to move the postcopy_qemufile_src
> > >> cleanup along. No idea why it is there in the first place. I see you
> > >> moved it from postcopy_pause and we're about to move it back to the
> > >> exact same place =D
> > >
> > > It was there because the old postcopy-preempt was sending data via
> > > postcopy_qemufile_src from the migration thread, while postcopy_pause is
> > > also the migration thread context.
> > >
> > > Then we had 9358982744 ("migration: Send requested page directly in
> > > rp-return thread") where we moved that "send page" operation into the
> > > return path thread to reduce latencies.  After moving there it also means
> > > the file handle can be accessed in >1 threads, so I just moved it over to
> > > operate that always in the return path thread, then no race should happen.
> > >
> > 
> > Thanks for the context.
> > 
> > > With your change, return path will vanish before migration thread accesses
> > > it later (so as mentioned above, it must be after pthread_join()
> > > succeeded), then I assume it'll be fine too to have it back in migration
> > > thread.
> > >
> > > Or perhaps just take the file lock?
> > >
> > 
> > There's also migrate_fd_cleanup and migrate_fd_cancel that can touch
> > these files. We might need to lock anyway, let's see.
> 
> The cancel path shouldn't clear the QEMUFile*, then I assume it's fine.
> That's based on the assumption that qemu_file_shutdown() is actually thread
> safe (say, shutdown() syscall is thread-safe for sockets).

The shutdown() syscall and qio_channel_shutdown() method are intended
to be safe to call from any thread *PROVIDED* you can ensure no other
thread is concurrently going to call close() on the FD (or unref the
QIOChannel object).

There is no locking in qemu_file_shutdown() to guarantee this, but
maybe something else in migration code is guaranteeing that the
QIOChannel object is not going to be closed (or unref'd), while a
thread is invoking qemu_file_shutdown().

IOW, in theory qemu_file_shutdown() could be safe to use but
I'm not seeing a clearly expressed guarantee of safety in the
code. If it is safe, the reasons are very subtle and rationale
ought to be documented in the comment for qemu_file_shutdown


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


