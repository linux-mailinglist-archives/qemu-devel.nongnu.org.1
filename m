Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753476EDDE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRa50-0003F6-EJ; Thu, 03 Aug 2023 11:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRa4x-0003Ct-Vm
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:17:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRa4v-00068O-RP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691075848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BgEtc2PdLfN5c/6ws4SjyDv+135l31FwS+nsoySHQGE=;
 b=fm2ufAV6eWoBfGJd1tazJHcF6Z82tXc8U3oNDCdT/B+LGPqedMiJJTBGcGfAvu4LBHE7yE
 FUQ99LZlZpgZez34pEANg4SHRs2nQmOFp0KiJVW7FK1SA9CNJZdWE7+5+FqXlSl4lb6LMX
 qEeCx1J24IrGstBU/fdMkS1WUVanbdk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-ZHgg30TzONShDKZHeNmRAA-1; Thu, 03 Aug 2023 11:15:52 -0400
X-MC-Unique: ZHgg30TzONShDKZHeNmRAA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cb292df12so27086185a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691075744; x=1691680544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgEtc2PdLfN5c/6ws4SjyDv+135l31FwS+nsoySHQGE=;
 b=FQQ5Dn4h3T1LAtI53WYtj2EsvuupxjP//cmFHiihdVw9Fov7lK5e7SnF0toHpGnNcy
 urTePsfYW0UagiPBc3yU5k7lxcKQLFlOwzujG1wh5c6ABqkjxVFHPsfvSAyODQ1QBmhl
 Per7N57h2y63P5FEHdf/q9/H7qf3QRZ/x9m/6HZnjqp1M0rmnjnmyPw6YOpzrsfH5rhT
 z6C+RGk1Hv5JTssKejnuH//fuZjnUKqsnEIL3WsMSrxMK6zol8LNShVzZbj2ekN64StT
 kafBA4saggTzKlEC+EpBXCYNap8QudynU6wdaVBdPyqkoVwXN2mtFOHLVi/bfcgOFEIg
 TdhA==
X-Gm-Message-State: ABy/qLZ1Yq0BgLEeSdg9mhFVpfdVt5+ct+rNVw/TBxxMMILxI+4pfbVO
 ht4tf8W2GwlXic4DVZ8i6wtWkm4qGi7+zr4jYwYXW9HM+gbdISXqVQ4WU51OWZLeL+vPe0l1VFP
 fFmViazh5FqhbOr8=
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr16030755qkb.3.1691075743719; 
 Thu, 03 Aug 2023 08:15:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEoJt+di//Az1elhkRZZweLlS5J3P7TQl1PXJly0DZHQVfaH9djIO3tHX3GLMO1kGO0QMRB5w==
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr16030736qkb.3.1691075743318; 
 Thu, 03 Aug 2023 08:15:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x9-20020ae9f809000000b0076cddd12aa4sm708652qkh.77.2023.08.03.08.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 08:15:43 -0700 (PDT)
Date: Thu, 3 Aug 2023 11:15:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Message-ID: <ZMvEnbQzPEqIROlD@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
 <874jlhcj2p.fsf@suse.de> <ZMq/QKI+qYSw4gPN@x1n>
 <87y1isb2wd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1isb2wd.fsf@suse.de>
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

On Thu, Aug 03, 2023 at 11:45:38AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Aug 02, 2023 at 04:58:38PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
> >> >> This function currently has a straight-forward part which is waiting
> >> >> for the thread to join and a complicated part which is doing a
> >> >> qemu_file_shutdown() on the return path file.
> >> >> 
> >> >> The shutdown is tricky because all calls to qemu_file_shutdown() set
> >> >> f->last_error to -EIO, which means we can never know if an error is an
> >> >> actual error or if we cleanly shutdown the file previously.
> >> >> 
> >> >> This is particularly bothersome for postcopy because it would send the
> >> >> return path thread into the retry routine which would wait on the
> >> >> postcopy_pause_rp_sem and consequently block the main thread. We
> >> >> haven't had reports of this so I must presume we never reach here with
> >> >> postcopy.
> >> >> 
> >> >> The shutdown call is also racy because since it doesn't take the
> >> >> qemu_file_lock, it could NULL-dereference if the return path thread
> >> >> happens to be in the middle of the critical region at
> >> >> migration_release_dst_files().
> >> >
> >> > After you rework the thread model on resume, shall we move
> >> > migration_release_dst_files() into the migration thread to be after the
> >> > pthread_join()?  I assume then we don't even need a mutex to protect it?
> >> >
> >> 
> >> I just need to figure out if it's ok to move the postcopy_qemufile_src
> >> cleanup along. No idea why it is there in the first place. I see you
> >> moved it from postcopy_pause and we're about to move it back to the
> >> exact same place =D
> >
> > It was there because the old postcopy-preempt was sending data via
> > postcopy_qemufile_src from the migration thread, while postcopy_pause is
> > also the migration thread context.
> >
> > Then we had 9358982744 ("migration: Send requested page directly in
> > rp-return thread") where we moved that "send page" operation into the
> > return path thread to reduce latencies.  After moving there it also means
> > the file handle can be accessed in >1 threads, so I just moved it over to
> > operate that always in the return path thread, then no race should happen.
> >
> 
> Thanks for the context.
> 
> > With your change, return path will vanish before migration thread accesses
> > it later (so as mentioned above, it must be after pthread_join()
> > succeeded), then I assume it'll be fine too to have it back in migration
> > thread.
> >
> > Or perhaps just take the file lock?
> >
> 
> There's also migrate_fd_cleanup and migrate_fd_cancel that can touch
> these files. We might need to lock anyway, let's see.

The cancel path shouldn't clear the QEMUFile*, then I assume it's fine.
That's based on the assumption that qemu_file_shutdown() is actually thread
safe (say, shutdown() syscall is thread-safe for sockets).

But yeah that depends on some more knowledge, it'll be good as you said
below to just always take the lock because that shouldn't hurt.

> 
> In general I'd like to drop all of these "ok not to lock, because...",
> it's too easy for code to change and the assumptions to stop being
> true. IMHO it's not worth it to gain performance by not taking a lock
> when the data is still shared and there's nothing stopping someone in
> the future from accessing it concurrently.

Yes I agree with you.

If you want we can move that from rp thread to migration thread, but with
the lock added altogether.  Then rp thread can always guarantee to have the
file there which should still be helpful; sometimes even with a lock there
we still need to take care of when QEMUFile*==NULL, but then not needed to
care for rp thread.

> 
> >> 
> >> >> 
> >> >> Move this more complicated part of the code to a separate routine so
> >> >> we can wait on the thread without all of this baggage.
> >> >
> >> > I think you mentioned "some nuance" on having mark_source_rp_bad() in
> >> > await_return_path_close_on_source(), I did remember I tried to look into
> >> > that "nuance" too a long time ago but I just forgot what was that.  Great
> >> > if you can share some details.
> >> >
> >> 
> >> Well, mark_source_rp_bad() at await_return_path_close_on_source() is
> >> basically useless:
> >> 
> >> - We only call mark_source_rp_bad() if s->to_dst_file has an error and the
> >>   migration_completion() already checks that condition and fails the
> >>   migration anyway.
> >> 
> >> - If to_dst_file has an error, chances are the destination already did
> >>   cleanup by this point, so from_dst_file would already have an errno,
> >>   due to that. At qemu_fill_buffer(), the len == 0 case basically means
> >>   "the other end finished cleanly". We still set -EIO in that case, I
> >>   don't know why. Possibly because not all backends will have the same
> >>   semantics for len == 0.
> >
> > I don't know either, but I checked it's from a555b8092a ("qemu-file: Don't
> > do IO after shutdown").  Maybe there's better way to do so we could
> > identify the difference, but yes can be for later.
> >
> 
> That is not the -EIO I'm talking about, but I'm glad you mentioned it,
> because I just noticed we might need to revert ac7d25b816 ("qemu-file:
> remove shutdown member").
> 
> It did a purely logical change which is to drop the f->shutdown flag,
> but that has the side-effect that now we cannot differentiate an orderly
> shutdown from an IO error.
> 
> I get that perhaps ideally all of the code would be resilient to be able
> to handle a shutdown in the same way as an IO error, but I'm not sure we
> are prepared for that.
> 
> 
> Now, the actual -EIO I was mentioning is this one in qemu-file.c:
> 
> static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
> {
>     ...
>     ...
>     do {
>         len = qio_channel_read(f->ioc,
>                                (char *)f->buf + pending,
>                                IO_BUF_SIZE - pending,
>                                &local_error);
>         if (len == QIO_CHANNEL_ERR_BLOCK) {
>             if (qemu_in_coroutine()) {
>                 qio_channel_yield(f->ioc, G_IO_IN);
>             } else {
>                 qio_channel_wait(f->ioc, G_IO_IN);
>             }
>         } else if (len < 0) {
>             len = -EIO;
>         }
>     } while (len == QIO_CHANNEL_ERR_BLOCK);
> 
>     if (len > 0) {
>         f->buf_size += len;
>         f->total_transferred += len;
>     } else if (len == 0) {
>         qemu_file_set_error_obj(f, -EIO, local_error); <---- THIS
>     } else {
>         qemu_file_set_error_obj(f, len, local_error);
>     }
> 
>     return len;
> }
> 
> the recvmsg manual says:
> 
>   "When a stream socket peer has performed an orderly shutdown, the return
>   value will be 0 (the traditional "end-of-file" return)."
> 
> So both issues combined put us in a situation where there's never an
> "orderly shutdown", everything is an error. I wouldn't say that's wrong,
> but it's not clear to me whether we consciously made that design
> decision.

Here when reaching qemu_fill_buffer() it normally means we expect something
already (it can originates from a qemu_fill_buffer() where we're waiting
for a header byte to come, for example), so _maybe_ it still makes sense to
error out because even if the other side does close() safely, it still
doesn't do it at the right time.

But I also agree this should not be part of a failure in the qemufile layer
(which is the transport only), instead it should be in the upper layer
(migration protocol) that set this error instead.  But I guess we have a
closer bind than expected on these two layers.

The qemufile layer is just not well designed IMHO, starting from
qemu_get_byte() directly return the byte without being able to fail at
all.  IOW one needs to call qemu_get_byte() then qemu_file_get_error() to
know whether the get_byte() is legal.

That gets a bit too far because qemufile is another level of issue, but for
now I think if you have solid idea on reviving f->shutdown and makes
"migration is cancelled" different from any other kinds of errors, feel
free to go; that looks reasonable to me so far.

Thanks,

-- 
Peter Xu


