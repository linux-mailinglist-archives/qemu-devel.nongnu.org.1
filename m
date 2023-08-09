Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574D77638A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkuh-0000jr-BN; Wed, 09 Aug 2023 11:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTkuI-0000hR-51
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:15:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTkuF-0000Vr-TV
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691594126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZugeCaq9wQIS6w8G/hCXsv3Rv8DA5BbiPEOPDnUwQ2E=;
 b=F9rTuVBwtk49g2mzFQRVXsWPOJ1lKlgcDRz+yiB/TgrpI7BabVgIED+1Ul8wqWRIu6owBv
 aFUbmAyiVZmSw+mrQcHGgTT8hpTdN7/qcPyirBn+npfyswBRFnseCeBUl4OcZfT5rieLfj
 Aja17BZcgssLmjrQ2xpY5jumcCpsvGs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Z-elQp66Pn6_1JCZyhRAKw-1; Wed, 09 Aug 2023 11:15:25 -0400
X-MC-Unique: Z-elQp66Pn6_1JCZyhRAKw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-637948b24bdso17211826d6.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691594125; x=1692198925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZugeCaq9wQIS6w8G/hCXsv3Rv8DA5BbiPEOPDnUwQ2E=;
 b=bnhMu1v8znHcvPBsVdjWiP56zp/b8D+auJ7Gy/onET6dJJ1Q5Ctj68kpY2CxvicHql
 LY/j9E6wIpjKu+Er8QFLoD103d4R9siXJoa6RFRgQ2ZcJVMe86WJHSO0sOPqlAJx/Fz+
 MDkIpbh+z/MrU2IxImkngMiQ2AjJU/Ow7Q/Tsw1W4/LCiZl+ntoDmDwRQpuDZ5X1XGM6
 xrGDbuSvPa7H4cw4ql7T5rfyFAQP5aYsLUjOCp5r/kPnoTp16YQPP9Isdi8AW3qtEJxK
 MPN4xAEMGfcal+P+6YYlocKOS0Ramu9+6dX3zRIK+7x7qFTgN5GRSAD1Gwey8c8pSdsX
 PLSg==
X-Gm-Message-State: AOJu0Yxnl2n9XW7LjENcXOfnkuU7fdEbdsTtznqNZ4+c856Qpq9Z31js
 tdXmLBhIOeL/H/7vkIhRYfF+0mJzLIbyxX8s1jI2O6NYRUWsedMIZ33Fxn7vTClhrc3TdKynBZ7
 97SRqfRa0fxavlrE=
X-Received: by 2002:a05:620a:4052:b0:76c:b369:22e4 with SMTP id
 i18-20020a05620a405200b0076cb36922e4mr3481801qko.4.1691594124917; 
 Wed, 09 Aug 2023 08:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6mNjgHQZXX1XZGZdZ8JZffWvUn70QtkC1712AY+i6yEkJQN5Lme2yd8KDqKC49TCURrypvQ==
X-Received: by 2002:a05:620a:4052:b0:76c:b369:22e4 with SMTP id
 i18-20020a05620a405200b0076cb36922e4mr3481778qko.4.1691594124533; 
 Wed, 09 Aug 2023 08:15:24 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 q7-20020a05620a038700b00767db6f47bbsm4037747qkm.73.2023.08.09.08.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:15:24 -0700 (PDT)
Date: Wed, 9 Aug 2023 11:15:23 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNOti1OKN79t68jP@x1n>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 09, 2023 at 11:20:11AM +0200, David Hildenbrand wrote:
> Hi Peter!

Hi, David,

> 
> > > -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
> > > -                       errp);
> > > +    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
> > > +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
> > > +        /*
> > > +         * We can have a writable MAP_PRIVATE mapping of a readonly file.
> > > +         * However, some operations like ftruncate() or fallocate() might fail
> > > +         * later, let's warn the user.
> > > +         */
> > > +        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
> > > +        if (fd >= 0) {
> > > +            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
> > > +                        " readonly because the file is not writable", mem_path);
> > 
> > I can understand the use case, but this will be slightly unwanted,
> > especially the user doesn't yet have a way to predict when will it happen.
> 
> Users can set the file permissions accordingly I guess. If they don't want
> the file to never ever be modified via QEMU, set it R/O.
> 
> > 
> > Meanwhile this changes the behavior, is it a concern that someone may want
> > to rely on current behavior of failing?
> 
> The scenario would be that someone passes a readonly file to "-mem-path" or
> "-object memory-backend-file,share=off,readonly=off", with the expectation
> that it would currently fail.
> 
> If it now doesn't fail (and we warn instead), what would happen is:
> * In file_ram_alloc() we won't even try ftruncate(), because the file
>   already had a size > 0. So ftruncate() is not a concern as I now
>   realize.
> * fallocate might fail later. AFAIKS, that only applies to
>   ram_block_discard_range().
>  -> virtio-mem performs an initial ram_block_discard_range() check and
>     fails gracefully early.
>  -> virtio-ballooon ignores any errors
>  -> ram_discard_range() in migration code fails early for postcopy in
>     init_range() and loadvm_postcopy_ram_handle_discard(), handling it
>     gracefully.
> 
> So mostly nothing "bad" would happen, it might just be undesirable, and we
> properly warn.

Indeed, all of them can fail gracefully, while balloon one is harmless.
Definitely good news.

> 
> Most importantly, we won't be corrupting/touching the original file in any
> case, because it is R/O.
> 
> If we really want to be careful, we could clue that behavior to compat
> machines. I'm not really sure yet if we really have to go down that path.
> 
> Any other alternatives? I'd like to avoid new flags where not really
> required.

I was just thinking of a new flag. :) So have you already discussed that
possibility and decided that not a good idea?

The root issue to me here is we actually have two resources (memory map of
the process, and the file) but we only have one way to describe the
permissions upon the two objects.  I'd think it makes a lot more sense if a
new flag is added, when there's a need to differentiate the two.

Consider if you see a bunch of qemu instances with:

  -mem-path $RAM_FILE

On the same host, which can be as weird as it could be to me.. At least
'-mem-path' looks still like a way to exclusively own a ram file for an
instance. I hesitate the new fallback can confuse people too, while that's
so far not the major use case.

Nobody may really rely on any existing behavior of the failure, but
changing existing behavior is just always not wanted.  The guideline here
to me is: whether we want existing "-mem-path XXX" users to start using the
fallback in general?  If it's "no", then maybe it implies a new flag is
better?

> 
> > 
> > To think from a higher level of current use case, the ideal solution seems
> > to me that if the ram file can be put on a file system that supports CoW
> > itself (like btrfs), we can snapshot that ram file and make it RW for the
> > qemu instance. Then here it'll be able to open the file.  We'll be able to
> > keep the interface working as before, meanwhile it'll work with fallocate
> > or truncations too I assume.
> > 
> > Would that be better instead of changing QEMU?
> 
> As I recently learned, using file-backed VMs (on real ssd/disks, not
> shmem/hugetlb) is usually undesired, because the dirtied pages will
> constantly get rewritten to disk by background writeback threads, eventually
> resulting in bad performance and SSD wear.
> 
> So while using a COW filesystem sounds cleaner in theory, it's not
> applicable in practice -- unless one disables any background writeback,
> which has different side effects because it cannot be configured on a
> per-file basis.
> 
> So for VM templating, it makes sense to capture the guest RAM and store it
> in a file, to then use a COW (MAP_PRIVATE) mapping. Using a read-only file
> makes perfect sense in that scenario IMHO.

Valid point.

> 
> [I'm curious at what point a filesystem will actually break COW. if it's
> wired up to the writenotify infrastructure, it would happen when actually
> writing to a page, not at mmap time. I know that filesystems use writenotify
> for lazy allocation of disk blocks on file holes, maybe they also do that
> for lazy allocation of disk blocks on COW]

I don't know either, but it definitely looks more promising and reasonable
if the CoW only happens until being written, rather than being mapped RW.

Thanks,

-- 
Peter Xu


