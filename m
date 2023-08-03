Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4496A76EE56
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaQ8-0004xj-MR; Thu, 03 Aug 2023 11:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRaQ6-0004xL-VE
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRaQ4-0005S0-8X
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691077159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6qdnqNZ6EB4D47z5zTefDOyo1HvzohVDVB39/jc66s=;
 b=ZlqI5n2UqB+0EJtBPVIP8jQXl/qXS7Jw/+UV1kL2ddjWl3SzjakitejTi1E15LZ8qwIR30
 lttNKHAP8HAUHbLkFX2uSGmNyOTFEGzY99wUEruEBcAhbM95VaEI1rm5rzFDNDhLUQ8qG/
 oDucgTc+vdp3wy0dBmK52YCadayweMw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-I0gcd2bkNoipTxfTheJ5lQ-1; Thu, 03 Aug 2023 11:39:17 -0400
X-MC-Unique: I0gcd2bkNoipTxfTheJ5lQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76cd4e1628eso21703485a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691077157; x=1691681957;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6qdnqNZ6EB4D47z5zTefDOyo1HvzohVDVB39/jc66s=;
 b=BZMbjaw/CgWgt5OCZU8JZKiewJnHM9qolZpyMIjAd52vKhMvDvvZMHIqRJXs4u4W3G
 qTbEdHv5IVK40uLjO6JuONxdaSfmXYg/Bvej+7iPEk+MTegmORR9N6okja2vT6NO7jWR
 DpZpmo+9Lf9vMongmGLyC3h+uwcaSNTWKuP05dKOqTYLOjv94k0dwta3ipID6x7dilg6
 x8nZNy9jd3mefeP3PHiFX1R/i+sXYVLLVhq/BmhrFLWesBCcyFC25XaGI6Yvdqz41p8A
 icFv8l70QhRMfN0o8VRsHcYBcOBlVQco0VH2a9AjiwJY0bYvzeYYesosF3KGeylxA2Uq
 +x7w==
X-Gm-Message-State: ABy/qLbH+ol5LMo56EPNbXsyx5Vg7+zniuoGmBFF2iNOJgMjI3FzkLEH
 NM0ewe3hOFP7qy1yyK/poAKXAw0GoKXj5O0k7liwPi0chqjezyssJOBwGOsneSWyDNP99YWItQk
 hPteDJEBW6xIWNEDx+p7/avA=
X-Received: by 2002:a05:620a:1a28:b0:76c:cd9d:5edf with SMTP id
 bk40-20020a05620a1a2800b0076ccd9d5edfmr6303673qkb.6.1691077156918; 
 Thu, 03 Aug 2023 08:39:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7QBLW2RtorGb1wIxwPNxXWcGZGGyOUfvofSqHG8Kn0BEhPFFlCRBlNl33h2COPsK9EhhWKw==
X-Received: by 2002:a05:620a:1a28:b0:76c:cd9d:5edf with SMTP id
 bk40-20020a05620a1a2800b0076ccd9d5edfmr6303653qkb.6.1691077156626; 
 Thu, 03 Aug 2023 08:39:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05620a149500b00767e62bcf0csm5928198qkj.65.2023.08.03.08.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:39:16 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:39:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Message-ID: <ZMvKIyur0DbBGOuy@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
 <874jlhcj2p.fsf@suse.de> <ZMq/QKI+qYSw4gPN@x1n>
 <87y1isb2wd.fsf@suse.de> <ZMvEnbQzPEqIROlD@x1n>
 <ZMvGoD61XG/Lr3jI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMvGoD61XG/Lr3jI@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 03, 2023 at 04:24:16PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 03, 2023 at 11:15:41AM -0400, Peter Xu wrote:
> > On Thu, Aug 03, 2023 at 11:45:38AM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > On Wed, Aug 02, 2023 at 04:58:38PM -0300, Fabiano Rosas wrote:
> > > >> Peter Xu <peterx@redhat.com> writes:
> > > >> 
> > > >> > On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
> > > >> >> This function currently has a straight-forward part which is waiting
> > > >> >> for the thread to join and a complicated part which is doing a
> > > >> >> qemu_file_shutdown() on the return path file.
> > > >> >> 
> > > >> >> The shutdown is tricky because all calls to qemu_file_shutdown() set
> > > >> >> f->last_error to -EIO, which means we can never know if an error is an
> > > >> >> actual error or if we cleanly shutdown the file previously.
> > > >> >> 
> > > >> >> This is particularly bothersome for postcopy because it would send the
> > > >> >> return path thread into the retry routine which would wait on the
> > > >> >> postcopy_pause_rp_sem and consequently block the main thread. We
> > > >> >> haven't had reports of this so I must presume we never reach here with
> > > >> >> postcopy.
> > > >> >> 
> > > >> >> The shutdown call is also racy because since it doesn't take the
> > > >> >> qemu_file_lock, it could NULL-dereference if the return path thread
> > > >> >> happens to be in the middle of the critical region at
> > > >> >> migration_release_dst_files().
> > > >> >
> > > >> > After you rework the thread model on resume, shall we move
> > > >> > migration_release_dst_files() into the migration thread to be after the
> > > >> > pthread_join()?  I assume then we don't even need a mutex to protect it?
> > > >> >
> > > >> 
> > > >> I just need to figure out if it's ok to move the postcopy_qemufile_src
> > > >> cleanup along. No idea why it is there in the first place. I see you
> > > >> moved it from postcopy_pause and we're about to move it back to the
> > > >> exact same place =D
> > > >
> > > > It was there because the old postcopy-preempt was sending data via
> > > > postcopy_qemufile_src from the migration thread, while postcopy_pause is
> > > > also the migration thread context.
> > > >
> > > > Then we had 9358982744 ("migration: Send requested page directly in
> > > > rp-return thread") where we moved that "send page" operation into the
> > > > return path thread to reduce latencies.  After moving there it also means
> > > > the file handle can be accessed in >1 threads, so I just moved it over to
> > > > operate that always in the return path thread, then no race should happen.
> > > >
> > > 
> > > Thanks for the context.
> > > 
> > > > With your change, return path will vanish before migration thread accesses
> > > > it later (so as mentioned above, it must be after pthread_join()
> > > > succeeded), then I assume it'll be fine too to have it back in migration
> > > > thread.
> > > >
> > > > Or perhaps just take the file lock?
> > > >
> > > 
> > > There's also migrate_fd_cleanup and migrate_fd_cancel that can touch
> > > these files. We might need to lock anyway, let's see.
> > 
> > The cancel path shouldn't clear the QEMUFile*, then I assume it's fine.
> > That's based on the assumption that qemu_file_shutdown() is actually thread
> > safe (say, shutdown() syscall is thread-safe for sockets).
> 
> The shutdown() syscall and qio_channel_shutdown() method are intended
> to be safe to call from any thread *PROVIDED* you can ensure no other
> thread is concurrently going to call close() on the FD (or unref the
> QIOChannel object).
> 
> There is no locking in qemu_file_shutdown() to guarantee this, but
> maybe something else in migration code is guaranteeing that the
> QIOChannel object is not going to be closed (or unref'd), while a
> thread is invoking qemu_file_shutdown().

It should currently be guaranteed by the qemu_file_lock I think.

> 
> IOW, in theory qemu_file_shutdown() could be safe to use but
> I'm not seeing a clearly expressed guarantee of safety in the
> code. If it is safe, the reasons are very subtle and rationale
> ought to be documented in the comment for qemu_file_shutdown

I agree.

For now for this specific use case of the migration qemufile, we can simply
always take the mutex.

Thanks,

-- 
Peter Xu


