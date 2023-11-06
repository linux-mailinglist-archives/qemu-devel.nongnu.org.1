Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC57E2E83
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:01:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r06iK-0001CP-FS; Mon, 06 Nov 2023 16:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r06iJ-0001CB-4Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:00:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r06iH-0003LT-7w
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699304448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2LNWdoBeKCRDUhBCq/4DAu6rfOuK5ZJ7MTzYNxPZAc=;
 b=GPzQUO9Xhb7r7oDvqyHYsSNSd8OiPmIb6K1lpxik34M7JEHkX++JOY6esTmayxZcRLDHF/
 8smTCF9rSCv9HQ52K9UvUb5i4XvR+xO1GAMFziEu5dklHnuY8sBZIgvHBvSdgDOpF7Y+gH
 ff0MvW4kpe+JFNmSLJNW/wSCOFI6W+A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-zBE3z8TVMxOL3hvBpVGAeA-1; Mon, 06 Nov 2023 16:00:36 -0500
X-MC-Unique: zBE3z8TVMxOL3hvBpVGAeA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d7b75c854so9878116d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304436; x=1699909236;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+2LNWdoBeKCRDUhBCq/4DAu6rfOuK5ZJ7MTzYNxPZAc=;
 b=fTOgPWsedplSW5ftZTqb5PUihYNR6RYvAh2gsHKqkVQNUs5lP74zn+3VaxdeSKtD3I
 7BKe4mDCXtEQwLRD6dU3f9EXHiHPft/fcMwfYA1CZye1P3znAprxDlFpD+dbHhpDpqxH
 PUpXIdXDSNWo6I5zH0n3436hGO8kmZ7/fVwOzMa+K/0WtlwC6XjRLkPLX+M5I53mOlWq
 POWjqkHhCKqc7E4uygIJ8JMFbP4KACX841FgxK6M5IMU8i7BKrwwutHSD9MManXyONdC
 +G9JUSBMKp7pP9/D4uOwQpV5o+SEDdiQLLeUoJaZq4GVhzRpxGtV5OY9bv+GCQLph+eX
 5tTg==
X-Gm-Message-State: AOJu0YxU0HMx/B7TX9CD4lxqxt9xwiNKKTw0NaoGbz8x627rVN/6vkGh
 wCc6yl41yv0latZw5GvRH2orftTENscZ4L899qGWf0AE8BRBF/HHQwJcYMHC2/o1nivuCrgFThf
 T9mBtOwXxMBjzeWY=
X-Received: by 2002:a0c:e845:0:b0:670:d117:1f9e with SMTP id
 l5-20020a0ce845000000b00670d1171f9emr27085147qvo.2.1699304436242; 
 Mon, 06 Nov 2023 13:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyq6m1Au7rYGBuYeF6AxYaeEo6Mf2c+RdyRYnoOJYPV84FtyQjm7Eak4y5pdBsES84G0gVPA==
X-Received: by 2002:a0c:e845:0:b0:670:d117:1f9e with SMTP id
 l5-20020a0ce845000000b00670d1171f9emr27085130qvo.2.1699304435889; 
 Mon, 06 Nov 2023 13:00:35 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 mx1-20020a0562142e0100b0066d0ab215b5sm3790683qvb.13.2023.11.06.13.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 13:00:35 -0800 (PST)
Date: Mon, 6 Nov 2023 16:00:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZUlT8aIc+QdTIRnR@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de>
 <ZTjjMiMkmnPMccjq@redhat.com> <87r0lieqxm.fsf@suse.de>
 <ZUFPlqgFx/2MeCj8@x1n> <ZUIZ1g5UahLu4pXh@redhat.com>
 <ZUJe0xb2Q0HgzBX+@x1n> <ZUJgiHa2gTCdhWZ1@redhat.com>
 <ZUJn/5GuRXcudsiF@x1n> <871qd3dnqs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qd3dnqs.fsf@suse.de>
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

On Mon, Nov 06, 2023 at 10:18:03AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Nov 01, 2023 at 02:28:24PM +0000, Daniel P. Berrangé wrote:
> >> On Wed, Nov 01, 2023 at 10:21:07AM -0400, Peter Xu wrote:
> >> > On Wed, Nov 01, 2023 at 09:26:46AM +0000, Daniel P. Berrangé wrote:
> >> > > On Tue, Oct 31, 2023 at 03:03:50PM -0400, Peter Xu wrote:
> >> > > > On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
> >> > > > > >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> >> > > > > >> +{
> >> > > > > >> +    g_autofree unsigned long *bitmap = NULL;
> >> > > > > >> +    struct FixedRamHeader header;
> >> > > > > >> +    size_t bitmap_size;
> >> > > > > >> +    long num_pages;
> >> > > > > >> +    int ret = 0;
> >> > > > > >> +
> >> > > > > >> +    ret = fixed_ram_read_header(f, &header);
> >> > > > > >> +    if (ret < 0) {
> >> > > > > >> +        error_report("Error reading fixed-ram header");
> >> > > > > >> +        return -EINVAL;
> >> > > > > >> +    }
> >> > > > > >> +
> >> > > > > >> +    block->pages_offset = header.pages_offset;
> >> > > > > >
> >> > > > > > Do you think it is worth sanity checking that 'pages_offset' is aligned
> >> > > > > > in some way.
> >> > > > > >
> >> > > > > > It is nice that we have flexibility to change the alignment in future
> >> > > > > > if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> >> > > > > > check htere. Perhaps we could at least sanity check for alignment at
> >> > > > > > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
> >> > > > > >
> >> > > > > 
> >> > > > > I don't see why not. I'll add it.
> >> > > > 
> >> > > > Is there any explanation on why that 1MB offset, and how the number is
> >> > > > chosen?  Thanks,
> >> > > 
> >> > > The fixed-ram format is anticipating the use of O_DIRECT.
> >> > > 
> >> > > With O_DIRECT both the buffers in memory, and the file handle offset
> >> > > have alignment requirements. The buffer alignments are usually page
> >> > > sized, and QEMU RAM blocks will trivially satisfy those.
> >> > > 
> >> > > The file handle offset alignment varies per filesystem. While you can
> >> > > query the alignment for the FS holding the file with statx(), that is
> >> > > not appropriate todo. If a user saves/restores QEMU state to file, we
> >> > > must assume there is a chance the user will copy the saved state to a
> >> > > different filesystem.
> >> > > 
> >> > > IOW, we want alignment to satisfy the likely worst case.
> >> > > 
> >> > > Picking 1 MB is a nice round number that is large enough that it is
> >> > > almost certainly going to satisfy any filesystem alignment. In fact
> >> > > it is likely massive overkill. None the less 1 MB is also still tiny
> >> > 
> >> > Is that calculated by something like max of possible host (small) page
> >> > sizes?  I've no idea what's it for all archs, the max small page size I'm
> >> > aware of is 64K, but I don't know a lot archs.
> >> 
> >> It wasn't anything as precise as that. It is literally just "1MB" looks
> >> large enough that we don't need to spend time to investigate per arch
> >> page sizes.
> >
> > IMHO we need that precision on reasoning and document it, even if not on
> > the exact number we prefer, which can be prone to change later.  Otherwise
> > that value will be a pure magic soon after a few years or even less, it'll
> > be more of a challenge later to figure things out.
> >
> >> 
> >> Having said that I'm now having slight self-doubt wrt huge pages, though
> >> I swear we investigated it last year when first discussing this feature.
> >> The guest memory will of course already be suitably aligned, but I'm
> >> wondering if the filesystem I/O places any offset alignment constraints
> >> related to non-default page size.
> >
> > AFAIU direct IO is about pinning the IO buffers, playing the role of fs
> > cache instead.  If my understanding is correct, huge pages shouldn't be a
> > problem for such pinning, because it's legal to pin partial of a huge page.
> >
> > After the partial huge pages pinned, they should be treated as normal fs
> > buffers when doing block IO.  And then the offset of file should, per my
> > understanding, not relevant to what is the type of backend of that user
> > buffer anymore that triggers read()/write().
> >
> > But maybe I missed something, if so that will need to be part of
> > documentation of 1MB magic value, IMHO.  We may want to double check with
> > that by doing fixed-ram migration on e.g. 1GB hugetlb memory-backend-file
> > with 1MB file offset per-ramblock.
> 
> Does anyone have any indication that we need to relate the aligment to
> the page size? All I find online points to device block size being the
> limiting factor for filesystems. There's also raw_probe_alignment() at
> file-posix.c which seems to check up to 4k and recommend to disable
> O_DIRECT if an alignment is not found.

Right, it should be more relevant to block size.

> 
> Note that we shouldn't have any problems changing the alignment we
> choose since we have a pointer to the start of the aligned region which
> goes along with the fixed-ram header. We could even do some probing like
> the block layer does if we wanted.

Having 1MB offset is fine, especially as you said we keep recv side fetch
that in the headers always.

Perhaps we make that 1MB a macro, and add a comment explaining whatever we
have on understanding how that 1MB come from?  I think we can also
reference raw_probe_alignment() in the comment.

Meanwhile now I'm wondering whether that 1MB is too conservative.  Only a
problem if there can be tons of ramblocks (e.g. 1000 ramblock means
1MB*1000=1G for the headers).  I can't think of any, though..  We can
definitely leave that for later.

Thanks,

-- 
Peter Xu


