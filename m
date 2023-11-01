Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36A7DE48D
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 17:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyE2B-0005rY-5a; Wed, 01 Nov 2023 12:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyE28-0005qV-Ij
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyE26-0004q6-9t
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 12:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698855928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lV0lZ/cuKTzK6ZGPzgxQhzShraSWRWjAi5HDooYYPOQ=;
 b=JUBthhbSVJl6zjKzJLxDCS5hgD55RCG9cQI/TADj2bNd5qkI7uQief7Y1RiRv8TIMtiSE5
 BHOrBuEr0GmZDBubcae2wBfz2ufXKr9xchhgIlZAUGRYoklPAOEa0en57f2FsuKtoZNaZS
 sm+9x7xtjQ36tWD7C28E0OI4AiyAse4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-5Fv3mp3hMRqQZsypzuctug-1; Wed, 01 Nov 2023 12:25:27 -0400
X-MC-Unique: 5Fv3mp3hMRqQZsypzuctug-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77a02ceef95so116034285a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698855926; x=1699460726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lV0lZ/cuKTzK6ZGPzgxQhzShraSWRWjAi5HDooYYPOQ=;
 b=VCuKHGJc4qllAslI5AGh0gf23ZChKxemmwRHPy2O09D+pu8gD24dgLznr4+NYfPVEb
 sd6GY4mJa5p/ahlxju113u/q6rwysrRpPDVPbhCiq7vLCnP37C9PMMDJ3EurqSFtCh1a
 Nt40Wa7zMTnQ0MkcWw+9o57x6epgmjjJh32G+fYAr92xbypdR64bCC736LnSSQ7e6tq4
 9c1hguKGNb+PCxOkfG1e6hzop94IELv55JS1mV7TFlSCG+dQch963dOo+i1B8MFodTtg
 iGtPXENFm28dXzgAhjA7zaD3Hi9hZ/nX90Vn3knD7yb3ay7YqESWzuXOys7VSpB4LWNV
 6PKA==
X-Gm-Message-State: AOJu0Yx2tNYdkhTpggd1QKKtYSRMPE3YkxN/+hpRA+86F22wn0yMoeWz
 fD965UDZPialdIL8gJ4+d/ChAqMRHse8g92pLtmYs2ZeUQZPCKOMCXPciuJQLHU/ShOC0FELfmn
 4iipICvTVpz625cw=
X-Received: by 2002:a05:620a:2b43:b0:76d:95d3:800f with SMTP id
 dp3-20020a05620a2b4300b0076d95d3800fmr16160868qkb.3.1698855926466; 
 Wed, 01 Nov 2023 09:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3ww5IklR2SuIzER2oa3ZCustCSjNHi9lEGRGC9E/lnJK0BfsZMPtg1eSzA6PMKb5HjHE8XQ==
X-Received: by 2002:a05:620a:2b43:b0:76d:95d3:800f with SMTP id
 dp3-20020a05620a2b4300b0076d95d3800fmr16160844qkb.3.1698855926127; 
 Wed, 01 Nov 2023 09:25:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y6-20020a05620a0e0600b0076e672f535asm1535760qkm.57.2023.11.01.09.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:25:25 -0700 (PDT)
Date: Wed, 1 Nov 2023 12:24:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZUJ7tuCj3MTWFSKN@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de>
 <ZTjiblfeOCTY56e4@redhat.com> <ZUJteaz84IYy1LC6@x1n>
 <ZUJ0MhujevGlKFbo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUJ0MhujevGlKFbo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Wed, Nov 01, 2023 at 03:52:18PM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 01, 2023 at 11:23:37AM -0400, Peter Xu wrote:
> > On Wed, Oct 25, 2023 at 10:39:58AM +0100, Daniel P. Berrangé wrote:
> > > If I'm reading the code correctly the new format has some padding
> > > such that each "ramblock pages" region starts on a 1 MB boundary.
> > > 
> > > eg so we get:
> > > 
> > >  --------------------------------
> > >  | ramblock 1 header            |
> > >  --------------------------------
> > >  | ramblock 1 fixed-ram header  |
> > >  --------------------------------
> > >  | padding to next 1MB boundary |
> > >  | ...                          |
> > >  --------------------------------
> > >  | ramblock 1 pages             |
> > >  | ...                          |
> > >  --------------------------------
> > >  | ramblock 2 header            |
> > >  --------------------------------
> > >  | ramblock 2 fixed-ram header  |
> > >  --------------------------------
> > >  | padding to next 1MB boundary |
> > >  | ...                          |
> > >  --------------------------------
> > >  | ramblock 2 pages             |
> > >  | ...                          |
> > >  --------------------------------
> > >  | ...                          |
> > >  --------------------------------
> > >  | RAM_SAVE_FLAG_EOS            |
> > >  --------------------------------
> > >  | ...                          |
> > >  -------------------------------
> > 
> > When reading the series, I was thinking one more thing on whether fixed-ram
> > would like to leverage compression in the future?
> 
> Libvirt currently supports compression of saved state images, so yes,
> I think compression is a desirable feature.

Ah, yeah this will work too; one more copy as you mentioned below, but
assume that's not a major concern so far (or.. will it?).

> 
> Due to libvirt's architecture it does compression on the stream and
> the final step in the sequence bounc buffers into suitably aligned
> memory required for O_DIRECT.
> 
> > To be exact, not really fixed-ram as a feature, but non-live snapshot as
> > the real use case.  More below.
> > 
> > I just noticed that compression can be a great feature to have for such use
> > case, where the image size can be further shrinked noticeably.  In this
> > case, speed of savevm may not matter as much as image size (as compression
> > can take some more cpu overhead): VM will be stopped anyway.
> > 
> > With current fixed-ram layout, we probably can't have compression due to
> > two reasons:
> > 
> >   - We offset each page with page alignment in the final image, and that's
> >     where fixed-ram as the term comes from; more fundamentally,
> > 
> >   - We allow src VM to run (dropping auto-pause as the plan, even if we
> >     plan to guarantee it not run; QEMU still can't take that as
> >     guaranteed), then we need page granule on storing pages, and then it's
> >     hard to know the size of each page after compressed.
> > 
> > If with the guarantee that VM is stopped, I think compression should be
> > easy to get?  Because right after dropping the page-granule requirement, we
> > can compress in chunks, storing binary in the image, one page written once.
> > We may lose O_DIRECT but we can consider the hardware accelerators on
> > [de]compress if necessary.
> 
> We can keep O_DIRECT if we buffer in QEMU between compressor output
> and disk I/O, which is what libvirt does. QEMU would still be saving
> at least one extra copy compared to libvirt
> 
> 
> The fixed RAM layout was primarily intended to allow easy parallel
> I/O without needing any synchronization between threads. In theory
> fixed RAM layout even allows you todo something fun like
> 
>    maped_addr = mmap(save-stat-fd, offset, ramblocksize);
>    memcpy(ramblock, maped_addr, ramblocksize)
>    munmap(maped_addr)
> 
> which would still be buffered I/O without O_DIRECT, but might be better
> than many writes() as you avoid 1000's of syscalls.
> 
> Anyway back to compression, I think if you wanted to allow for parallel
> I/O, then it would require a different "fixed ram" approach, where each
> multifd  thread requested use of a 64 MB region, compressed until that
> was full, then asked for another 64 MB region, repeat until done.

Right, we need a constant buffer per-thread if so.

> 
> The reason we didn't want to break up the file format into regions like
> this is because we wanted to allow for flexbility into configuration on
> save / restore. eg  you might save using 7 threads, but restore using
> 3 threads. We didn't want the on-disk layout to have any structural
> artifact that was related to the number of threads saving data, as that
> would make restore less efficient. eg 2 threads would process 2 chunks
> each and  and 1 thread would process 3 chunks, which is unbalanced.

I didn't follow on why the image needs to contain thread number
information.

Can the sub-header for each compressed chunk be described as (assuming
under specific ramblock header, so ramblock is known):

  - size of compressed data
  - (start_offset, end_offset) of pages this chunk of data represents

Then when saving, we assign 64M to each thread no matter how many are
there, for each thread it first compresses 64M into binary, knowing the
size, then request for a writeback to image, with the chunk header and
binary flushed.

Then the final image will be a sequence of chunks for each ramblock.

Assuming decompress can do the same by assigning different chunks to each
decompress thread, no matter how many are there.

Would that work?

To go back to the original topic: I think it's fine if Libvirt will do the
compression, that is more flexible indeed to do per-file with whatever
compression algorithm the uesr wants, and even cover non-RAM data.

I think such considerations / thoughts over compression solution may also
be nice to be documented in the docs/ under this feature.

Thanks,

-- 
Peter Xu


