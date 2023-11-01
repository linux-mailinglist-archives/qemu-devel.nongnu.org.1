Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C517DE4B9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyEDm-0002vv-Tg; Wed, 01 Nov 2023 12:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyEDd-0002sF-86
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyEDa-0006sW-PC
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698856640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hD9nxLS5PLtRGMrPuTmLB4CIFlmd0wsewQcnfp+cJME=;
 b=BEEyM7d5hFPCGrQKWivh+6eIlTioY897+DAxESHmavLFfLel7efA0RkaOmfsmzdRpK+R6f
 5SUWHfhyx7BDqxc2vnYOZvHJVs2cmVVF5AlNx9LGGjfRaUaVr/S7VlGiWQMx/PW2fgZsRP
 G+0v6DqlCAL4XYhT/+6244Ryq0u864E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-QdgFrKvePKme15GaAqtYmg-1; Wed, 01 Nov 2023 12:37:17 -0400
X-MC-Unique: QdgFrKvePKme15GaAqtYmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CEFF882080;
 Wed,  1 Nov 2023 16:37:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4DBE134;
 Wed,  1 Nov 2023 16:37:14 +0000 (UTC)
Date: Wed, 1 Nov 2023 16:37:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZUJ+uMRAnZFOoPID@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de>
 <ZTjiblfeOCTY56e4@redhat.com> <ZUJteaz84IYy1LC6@x1n>
 <ZUJ0MhujevGlKFbo@redhat.com> <ZUJ7tuCj3MTWFSKN@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUJ7tuCj3MTWFSKN@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 01, 2023 at 12:24:22PM -0400, Peter Xu wrote:
> On Wed, Nov 01, 2023 at 03:52:18PM +0000, Daniel P. Berrangé wrote:
> > On Wed, Nov 01, 2023 at 11:23:37AM -0400, Peter Xu wrote:
> > > On Wed, Oct 25, 2023 at 10:39:58AM +0100, Daniel P. Berrangé wrote:
> > > > If I'm reading the code correctly the new format has some padding
> > > > such that each "ramblock pages" region starts on a 1 MB boundary.
> > > > 
> > > > eg so we get:
> > > > 
> > > >  --------------------------------
> > > >  | ramblock 1 header            |
> > > >  --------------------------------
> > > >  | ramblock 1 fixed-ram header  |
> > > >  --------------------------------
> > > >  | padding to next 1MB boundary |
> > > >  | ...                          |
> > > >  --------------------------------
> > > >  | ramblock 1 pages             |
> > > >  | ...                          |
> > > >  --------------------------------
> > > >  | ramblock 2 header            |
> > > >  --------------------------------
> > > >  | ramblock 2 fixed-ram header  |
> > > >  --------------------------------
> > > >  | padding to next 1MB boundary |
> > > >  | ...                          |
> > > >  --------------------------------
> > > >  | ramblock 2 pages             |
> > > >  | ...                          |
> > > >  --------------------------------
> > > >  | ...                          |
> > > >  --------------------------------
> > > >  | RAM_SAVE_FLAG_EOS            |
> > > >  --------------------------------
> > > >  | ...                          |
> > > >  -------------------------------
> > > 
> > > When reading the series, I was thinking one more thing on whether fixed-ram
> > > would like to leverage compression in the future?
> > 
> > Libvirt currently supports compression of saved state images, so yes,
> > I think compression is a desirable feature.
> 
> Ah, yeah this will work too; one more copy as you mentioned below, but
> assume that's not a major concern so far (or.. will it?).
> 
> > 
> > Due to libvirt's architecture it does compression on the stream and
> > the final step in the sequence bounc buffers into suitably aligned
> > memory required for O_DIRECT.
> > 
> > > To be exact, not really fixed-ram as a feature, but non-live snapshot as
> > > the real use case.  More below.
> > > 
> > > I just noticed that compression can be a great feature to have for such use
> > > case, where the image size can be further shrinked noticeably.  In this
> > > case, speed of savevm may not matter as much as image size (as compression
> > > can take some more cpu overhead): VM will be stopped anyway.
> > > 
> > > With current fixed-ram layout, we probably can't have compression due to
> > > two reasons:
> > > 
> > >   - We offset each page with page alignment in the final image, and that's
> > >     where fixed-ram as the term comes from; more fundamentally,
> > > 
> > >   - We allow src VM to run (dropping auto-pause as the plan, even if we
> > >     plan to guarantee it not run; QEMU still can't take that as
> > >     guaranteed), then we need page granule on storing pages, and then it's
> > >     hard to know the size of each page after compressed.
> > > 
> > > If with the guarantee that VM is stopped, I think compression should be
> > > easy to get?  Because right after dropping the page-granule requirement, we
> > > can compress in chunks, storing binary in the image, one page written once.
> > > We may lose O_DIRECT but we can consider the hardware accelerators on
> > > [de]compress if necessary.
> > 
> > We can keep O_DIRECT if we buffer in QEMU between compressor output
> > and disk I/O, which is what libvirt does. QEMU would still be saving
> > at least one extra copy compared to libvirt
> > 
> > 
> > The fixed RAM layout was primarily intended to allow easy parallel
> > I/O without needing any synchronization between threads. In theory
> > fixed RAM layout even allows you todo something fun like
> > 
> >    maped_addr = mmap(save-stat-fd, offset, ramblocksize);
> >    memcpy(ramblock, maped_addr, ramblocksize)
> >    munmap(maped_addr)
> > 
> > which would still be buffered I/O without O_DIRECT, but might be better
> > than many writes() as you avoid 1000's of syscalls.
> > 
> > Anyway back to compression, I think if you wanted to allow for parallel
> > I/O, then it would require a different "fixed ram" approach, where each
> > multifd  thread requested use of a 64 MB region, compressed until that
> > was full, then asked for another 64 MB region, repeat until done.
> 
> Right, we need a constant buffer per-thread if so.
> 
> > 
> > The reason we didn't want to break up the file format into regions like
> > this is because we wanted to allow for flexbility into configuration on
> > save / restore. eg  you might save using 7 threads, but restore using
> > 3 threads. We didn't want the on-disk layout to have any structural
> > artifact that was related to the number of threads saving data, as that
> > would make restore less efficient. eg 2 threads would process 2 chunks
> > each and  and 1 thread would process 3 chunks, which is unbalanced.
> 
> I didn't follow on why the image needs to contain thread number
> information.

It doesn't contain thread number information directly, but it can
be implicit from the data layout.

If you want parallel I/O, each thread has to know it is the only
one reading/writing to a particular region of the file. With the
fixed RAM layout in this series, the file offset directly maps
to the memory region. So if a thread has been given a guest page
to save it knows it will be the only thing writing to the file
at that offset. There is no relationship at all between the
number of threads and the file layout.

If you can't directly map pages to file offsets, then you need
some other way to lay out date such that each thread can safely
write. If you split up a file based on fixed size chunks, then
the number of chunks you end up with in the file is likely to be
a multiple of the number of threads you had saving data.

This means if you restore using a different number of threads,
you can't evenly assign file chunks to each restore thread.

There's no info about thread IDs in the file, but the data layout
reflects how mcuh threads were doing work.

> Assuming decompress can do the same by assigning different chunks to each
> decompress thread, no matter how many are there.
> 
> Would that work?

Again you get uneven workloads if the number of restore threads is
different than the save threads, as some threads will have to process
more chunks than other threads. If the chunks are small this might
not matter, if they are big it could matter.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


