Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD27DE291
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 16:02:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyCip-0002tQ-JK; Wed, 01 Nov 2023 11:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyCin-0002t2-RU
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyCik-00079w-Pl
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698850885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY2CtCiq6Ws4cZqNlnxr6IP9yyfO0iL1vm2JrrhNOws=;
 b=JuE4293uuC1W7pIrSuzVAkeysaTI2gaX++f1upRhN0PrIBGkI+3wANK+mUtcdu2PX76EoU
 fkSHAuKZsmr9G2IDpMiTss7PoUZJiqEm977Mharx0o5qVp0f+LGOA+TfEZkVWeIp3IXSFD
 iuqgZv2OyP0J9Kzkn3qzQ7ZzdlbSOwY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-w8Y5-oRhOKSfIfUYr5_OkQ-1; Wed, 01 Nov 2023 11:01:23 -0400
X-MC-Unique: w8Y5-oRhOKSfIfUYr5_OkQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77a02ceef95so113765185a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 08:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698850882; x=1699455682;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IY2CtCiq6Ws4cZqNlnxr6IP9yyfO0iL1vm2JrrhNOws=;
 b=LUHN8GKWHgmXmQwGv0SNDZAyPWWyye1p9u4yCKBLmiERYGCvWg6Qoeuvksdn8PkpKT
 uPHbdiiquZXnmBy1iE7h3UAXPFYgDV+Nr3IWul6lntaep8H3I8jWwcxlZRlVKBLlwEfc
 W0UulUDG2ZTrJ+5a7I2ffCooxK81BRInLpEkDuzypOs4Mm6yucEbHm+O3lrFhTxquktg
 GeRvxCBDU5UO4DsMn2X5hGzxRHZ7h865iEG/BC5hg0BUEmUtH6KSDe7JZT1jUSUvZXzc
 M6eCP2JtslEq3o6fYqJydt/nwx6B15GlXf7sp+DEgkDcDP3NC4svGyUa7GGZa7qmsQwy
 pFog==
X-Gm-Message-State: AOJu0YxUOT3yL/hYxid4f0FYv8JI0tcjhgMQQ4KHIqp5i+JKMe4B0Qk2
 1er0diG0TEo/2PxXAYOJIF27OKEaDD1MwH9ck/mYCR21m63w82ozGoisxxGxK+j0ndQv3GKbLZz
 aD+kxhlsZquS/hGo=
X-Received: by 2002:a05:620a:2608:b0:76f:167a:cc4d with SMTP id
 z8-20020a05620a260800b0076f167acc4dmr15252698qko.2.1698850882506; 
 Wed, 01 Nov 2023 08:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgnJIqkie/2kwd9BGcykrBmBKB45MZgDsaXMR9t3tigqMrk/6Rv+uOWYvxCyfyx7TMAaZAxg==
X-Received: by 2002:a05:620a:2608:b0:76f:167a:cc4d with SMTP id
 z8-20020a05620a260800b0076f167acc4dmr15252667qko.2.1698850882087; 
 Wed, 01 Nov 2023 08:01:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w1-20020a05620a094100b0076d6a08ac98sm1484743qkw.76.2023.11.01.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 08:01:21 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:00:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZUJn/5GuRXcudsiF@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de>
 <ZTjjMiMkmnPMccjq@redhat.com> <87r0lieqxm.fsf@suse.de>
 <ZUFPlqgFx/2MeCj8@x1n> <ZUIZ1g5UahLu4pXh@redhat.com>
 <ZUJe0xb2Q0HgzBX+@x1n> <ZUJgiHa2gTCdhWZ1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUJgiHa2gTCdhWZ1@redhat.com>
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

On Wed, Nov 01, 2023 at 02:28:24PM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 01, 2023 at 10:21:07AM -0400, Peter Xu wrote:
> > On Wed, Nov 01, 2023 at 09:26:46AM +0000, Daniel P. Berrangé wrote:
> > > On Tue, Oct 31, 2023 at 03:03:50PM -0400, Peter Xu wrote:
> > > > On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
> > > > > >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> > > > > >> +{
> > > > > >> +    g_autofree unsigned long *bitmap = NULL;
> > > > > >> +    struct FixedRamHeader header;
> > > > > >> +    size_t bitmap_size;
> > > > > >> +    long num_pages;
> > > > > >> +    int ret = 0;
> > > > > >> +
> > > > > >> +    ret = fixed_ram_read_header(f, &header);
> > > > > >> +    if (ret < 0) {
> > > > > >> +        error_report("Error reading fixed-ram header");
> > > > > >> +        return -EINVAL;
> > > > > >> +    }
> > > > > >> +
> > > > > >> +    block->pages_offset = header.pages_offset;
> > > > > >
> > > > > > Do you think it is worth sanity checking that 'pages_offset' is aligned
> > > > > > in some way.
> > > > > >
> > > > > > It is nice that we have flexibility to change the alignment in future
> > > > > > if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> > > > > > check htere. Perhaps we could at least sanity check for alignment at
> > > > > > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
> > > > > >
> > > > > 
> > > > > I don't see why not. I'll add it.
> > > > 
> > > > Is there any explanation on why that 1MB offset, and how the number is
> > > > chosen?  Thanks,
> > > 
> > > The fixed-ram format is anticipating the use of O_DIRECT.
> > > 
> > > With O_DIRECT both the buffers in memory, and the file handle offset
> > > have alignment requirements. The buffer alignments are usually page
> > > sized, and QEMU RAM blocks will trivially satisfy those.
> > > 
> > > The file handle offset alignment varies per filesystem. While you can
> > > query the alignment for the FS holding the file with statx(), that is
> > > not appropriate todo. If a user saves/restores QEMU state to file, we
> > > must assume there is a chance the user will copy the saved state to a
> > > different filesystem.
> > > 
> > > IOW, we want alignment to satisfy the likely worst case.
> > > 
> > > Picking 1 MB is a nice round number that is large enough that it is
> > > almost certainly going to satisfy any filesystem alignment. In fact
> > > it is likely massive overkill. None the less 1 MB is also still tiny
> > 
> > Is that calculated by something like max of possible host (small) page
> > sizes?  I've no idea what's it for all archs, the max small page size I'm
> > aware of is 64K, but I don't know a lot archs.
> 
> It wasn't anything as precise as that. It is literally just "1MB" looks
> large enough that we don't need to spend time to investigate per arch
> page sizes.

IMHO we need that precision on reasoning and document it, even if not on
the exact number we prefer, which can be prone to change later.  Otherwise
that value will be a pure magic soon after a few years or even less, it'll
be more of a challenge later to figure things out.

> 
> Having said that I'm now having slight self-doubt wrt huge pages, though
> I swear we investigated it last year when first discussing this feature.
> The guest memory will of course already be suitably aligned, but I'm
> wondering if the filesystem I/O places any offset alignment constraints
> related to non-default page size.

AFAIU direct IO is about pinning the IO buffers, playing the role of fs
cache instead.  If my understanding is correct, huge pages shouldn't be a
problem for such pinning, because it's legal to pin partial of a huge page.

After the partial huge pages pinned, they should be treated as normal fs
buffers when doing block IO.  And then the offset of file should, per my
understanding, not relevant to what is the type of backend of that user
buffer anymore that triggers read()/write().

But maybe I missed something, if so that will need to be part of
documentation of 1MB magic value, IMHO.  We may want to double check with
that by doing fixed-ram migration on e.g. 1GB hugetlb memory-backend-file
with 1MB file offset per-ramblock.

Thanks,

-- 
Peter Xu


