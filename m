Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFF76D8BE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 22:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIeA-00050x-8S; Wed, 02 Aug 2023 16:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRIe8-00050X-Lh
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRIe6-0002i8-T5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 16:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691008836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQA8qu9myT+BbSFxtkowormFua9HdfPFBiKZTpmC9hU=;
 b=IBiIA0shGx6ZjT/70C2lO2QhJ/9NMUZ1glh2IWFGp3CxUqOUIAVRDQIBxLHVA68Ik8fSjW
 6burKLWfnMzaVMUopKynF1gP+w6HFRyujBQ6yv58Ov5Ppm33hh/I/Mm2rygujlhWrkeW6m
 kWXD439O+08TUoUpg/Gq48H6a/cf2zc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-HIlMrqnFPA6Y-sg0l8HD1w-1; Wed, 02 Aug 2023 16:40:35 -0400
X-MC-Unique: HIlMrqnFPA6Y-sg0l8HD1w-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fa24ab5c8so733121cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 13:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691008835; x=1691613635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQA8qu9myT+BbSFxtkowormFua9HdfPFBiKZTpmC9hU=;
 b=kSau7Df3aBeq/i5i6EynfV4hRhdoyzwybb7wq/WdIoKS7KYMhgnAu5CmpI2PH3aeom
 XKum+VGgtzP74GoOgU0ISEWSzmoKTlDLuU3saZ9LNB2yWO3C2TH7YL7tvwSUdEvQK2bn
 p/WKNeImSD9UQR9F7+suwXQw9i9Poy02EwvdcXA7nCVZVGNP8z6i2UvUj0NYwZYx5Qug
 I/USyGXixK2UfRvPnI0i/ZgqnWm0CecZsc3u/HfZoTSKviipP5ZaUZu+UcY1E++oBby4
 EtmCWRM7Q79RzXLQ+45ssZpI6tPIWZE8n1QfHc/jg5lu9pNN1p8h8ziUdyfGefTC9Gqk
 VoXw==
X-Gm-Message-State: ABy/qLaHPUom6sK/izuKOZdDwvYC0wFAHqVuwvQ1sSW6dfbrvfUuUT3V
 9i6F5ThK+thrFEcJ07Rl7ZYlNkZpMAB51G3kN+5YC57RfU3M2SGAryObtlzCaavJeM2Lp+cin8q
 J3JrZovB4dbdkDA4=
X-Received: by 2002:a05:622a:1a02:b0:403:59f8:25d9 with SMTP id
 f2-20020a05622a1a0200b0040359f825d9mr18398477qtb.2.1691008835059; 
 Wed, 02 Aug 2023 13:40:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFM00b94byNJXq8i1YMzHBTth6+2kOtda/uiRQ5A0SYYxkjkLJqBdwfexX3N2Qk/8IEfsv7lw==
X-Received: by 2002:a05:622a:1a02:b0:403:59f8:25d9 with SMTP id
 f2-20020a05622a1a0200b0040359f825d9mr18398461qtb.2.1691008834741; 
 Wed, 02 Aug 2023 13:40:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u11-20020a05622a17cb00b004053dc8365esm5545875qtk.23.2023.08.02.13.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 13:40:34 -0700 (PDT)
Date: Wed, 2 Aug 2023 16:40:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Message-ID: <ZMq/QKI+qYSw4gPN@x1n>
References: <20230802143644.7534-1-farosas@suse.de>
 <20230802143644.7534-2-farosas@suse.de> <ZMqCFIXONOxUCeSE@x1n>
 <874jlhcj2p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jlhcj2p.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 02, 2023 at 04:58:38PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Aug 02, 2023 at 11:36:43AM -0300, Fabiano Rosas wrote:
> >> This function currently has a straight-forward part which is waiting
> >> for the thread to join and a complicated part which is doing a
> >> qemu_file_shutdown() on the return path file.
> >> 
> >> The shutdown is tricky because all calls to qemu_file_shutdown() set
> >> f->last_error to -EIO, which means we can never know if an error is an
> >> actual error or if we cleanly shutdown the file previously.
> >> 
> >> This is particularly bothersome for postcopy because it would send the
> >> return path thread into the retry routine which would wait on the
> >> postcopy_pause_rp_sem and consequently block the main thread. We
> >> haven't had reports of this so I must presume we never reach here with
> >> postcopy.
> >> 
> >> The shutdown call is also racy because since it doesn't take the
> >> qemu_file_lock, it could NULL-dereference if the return path thread
> >> happens to be in the middle of the critical region at
> >> migration_release_dst_files().
> >
> > After you rework the thread model on resume, shall we move
> > migration_release_dst_files() into the migration thread to be after the
> > pthread_join()?  I assume then we don't even need a mutex to protect it?
> >
> 
> I just need to figure out if it's ok to move the postcopy_qemufile_src
> cleanup along. No idea why it is there in the first place. I see you
> moved it from postcopy_pause and we're about to move it back to the
> exact same place =D

It was there because the old postcopy-preempt was sending data via
postcopy_qemufile_src from the migration thread, while postcopy_pause is
also the migration thread context.

Then we had 9358982744 ("migration: Send requested page directly in
rp-return thread") where we moved that "send page" operation into the
return path thread to reduce latencies.  After moving there it also means
the file handle can be accessed in >1 threads, so I just moved it over to
operate that always in the return path thread, then no race should happen.

With your change, return path will vanish before migration thread accesses
it later (so as mentioned above, it must be after pthread_join()
succeeded), then I assume it'll be fine too to have it back in migration
thread.

Or perhaps just take the file lock?

> 
> >> 
> >> Move this more complicated part of the code to a separate routine so
> >> we can wait on the thread without all of this baggage.
> >
> > I think you mentioned "some nuance" on having mark_source_rp_bad() in
> > await_return_path_close_on_source(), I did remember I tried to look into
> > that "nuance" too a long time ago but I just forgot what was that.  Great
> > if you can share some details.
> >
> 
> Well, mark_source_rp_bad() at await_return_path_close_on_source() is
> basically useless:
> 
> - We only call mark_source_rp_bad() if s->to_dst_file has an error and the
>   migration_completion() already checks that condition and fails the
>   migration anyway.
> 
> - If to_dst_file has an error, chances are the destination already did
>   cleanup by this point, so from_dst_file would already have an errno,
>   due to that. At qemu_fill_buffer(), the len == 0 case basically means
>   "the other end finished cleanly". We still set -EIO in that case, I
>   don't know why. Possibly because not all backends will have the same
>   semantics for len == 0.

I don't know either, but I checked it's from a555b8092a ("qemu-file: Don't
do IO after shutdown").  Maybe there's better way to do so we could
identify the difference, but yes can be for later.

> 
> - If the above doesn't happen, then due to the shutdown, from_dst_file
>   will already have an error again set by qemu_file_shutdown().
> 
> Not to mention that mark_source_rp_bad() is in a race with the return
> path thread which could clear the error during postcopy retry.
> 
> As this patch tries to convey, this whole shutdown routine is weird. We
> don't have any documentation explaining when it could happen, so we're
> left with wanting to call it always. Except that doesn't work because in
> postcopy we'd trigger the retry logic and that hangs, and because of the
> "shutdown means -EIO" issue we'd be eating up whatever error happened
> before (it's all -EIO, so there's no way to tell them apart).
> 
> Given all of that, I thought just moving this aside would be better for
> the time being than to try to rationalise all of this. This series fixes
> a reproducible bug while everything I said above is just code inspection
> and some artificial testing of mine.

Yeah we can leave that for later.  Actually my other series removed that (I
totally forgot it, until I just noticed and checked).  But that'll conflict
with yours.  I think this series should in earlier if it fixes a possible
race, so I'll just rebase when it lands.

Thanks,

-- 
Peter Xu


