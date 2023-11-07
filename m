Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DE7E371B
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:03:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Hyx-0003F2-TP; Tue, 07 Nov 2023 04:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0Hyv-0003EQ-FD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0Hyt-0005N0-4y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699347762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kb+lu9zrlWjhNc+vPH6OmajV9Put/c16nno0WtQ+heE=;
 b=W7/prImjFcPWSm6rHU3qgDQRsHa4qL26r/yrf+0GDr/exD4AQwjWj5Blk+Sclmppq0J0rg
 yTQgTqHUfXZUK1BNCwoBiD4+XJh7eh4YOcYNiuEuSERoPONmiJyw4lYi2mjsSnet4BeN7m
 5c7REDHlow3tpwoYp9qFb3L8j8u+DAc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-3SqgLHeLMwGP01aQLC6RlQ-1; Tue,
 07 Nov 2023 04:02:38 -0500
X-MC-Unique: 3SqgLHeLMwGP01aQLC6RlQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B8BF1C04327;
 Tue,  7 Nov 2023 09:02:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0EB3492BFC;
 Tue,  7 Nov 2023 09:02:36 +0000 (UTC)
Date: Tue, 7 Nov 2023 09:02:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZUn9Kjd3mpuQHLM1@redhat.com>
References: <20231023203608.26370-17-farosas@suse.de>
 <ZTjjMiMkmnPMccjq@redhat.com> <87r0lieqxm.fsf@suse.de>
 <ZUFPlqgFx/2MeCj8@x1n> <ZUIZ1g5UahLu4pXh@redhat.com>
 <ZUJe0xb2Q0HgzBX+@x1n> <ZUJgiHa2gTCdhWZ1@redhat.com>
 <ZUJn/5GuRXcudsiF@x1n> <871qd3dnqs.fsf@suse.de>
 <ZUlT8aIc+QdTIRnR@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUlT8aIc+QdTIRnR@x1n>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Mon, Nov 06, 2023 at 04:00:33PM -0500, Peter Xu wrote:
> On Mon, Nov 06, 2023 at 10:18:03AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Wed, Nov 01, 2023 at 02:28:24PM +0000, Daniel P. Berrangé wrote:
> > >> On Wed, Nov 01, 2023 at 10:21:07AM -0400, Peter Xu wrote:
> > >> > On Wed, Nov 01, 2023 at 09:26:46AM +0000, Daniel P. Berrangé wrote:
> > >> > > On Tue, Oct 31, 2023 at 03:03:50PM -0400, Peter Xu wrote:
> > >> > > > On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
> > >> > > > > >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> > >> > > > > >> +{
> > >> > > > > >> +    g_autofree unsigned long *bitmap = NULL;
> > >> > > > > >> +    struct FixedRamHeader header;
> > >> > > > > >> +    size_t bitmap_size;
> > >> > > > > >> +    long num_pages;
> > >> > > > > >> +    int ret = 0;
> > >> > > > > >> +
> > >> > > > > >> +    ret = fixed_ram_read_header(f, &header);
> > >> > > > > >> +    if (ret < 0) {
> > >> > > > > >> +        error_report("Error reading fixed-ram header");
> > >> > > > > >> +        return -EINVAL;
> > >> > > > > >> +    }
> > >> > > > > >> +
> > >> > > > > >> +    block->pages_offset = header.pages_offset;
> > >> > > > > >
> > >> > > > > > Do you think it is worth sanity checking that 'pages_offset' is aligned
> > >> > > > > > in some way.
> > >> > > > > >
> > >> > > > > > It is nice that we have flexibility to change the alignment in future
> > >> > > > > > if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> > >> > > > > > check htere. Perhaps we could at least sanity check for alignment at
> > >> > > > > > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
> > >> > > > > >
> > >> > > > > 
> > >> > > > > I don't see why not. I'll add it.
> > >> > > > 
> > >> > > > Is there any explanation on why that 1MB offset, and how the number is
> > >> > > > chosen?  Thanks,
> > >> > > 
> > >> > > The fixed-ram format is anticipating the use of O_DIRECT.
> > >> > > 
> > >> > > With O_DIRECT both the buffers in memory, and the file handle offset
> > >> > > have alignment requirements. The buffer alignments are usually page
> > >> > > sized, and QEMU RAM blocks will trivially satisfy those.
> > >> > > 
> > >> > > The file handle offset alignment varies per filesystem. While you can
> > >> > > query the alignment for the FS holding the file with statx(), that is
> > >> > > not appropriate todo. If a user saves/restores QEMU state to file, we
> > >> > > must assume there is a chance the user will copy the saved state to a
> > >> > > different filesystem.
> > >> > > 
> > >> > > IOW, we want alignment to satisfy the likely worst case.
> > >> > > 
> > >> > > Picking 1 MB is a nice round number that is large enough that it is
> > >> > > almost certainly going to satisfy any filesystem alignment. In fact
> > >> > > it is likely massive overkill. None the less 1 MB is also still tiny
> > >> > 
> > >> > Is that calculated by something like max of possible host (small) page
> > >> > sizes?  I've no idea what's it for all archs, the max small page size I'm
> > >> > aware of is 64K, but I don't know a lot archs.
> > >> 
> > >> It wasn't anything as precise as that. It is literally just "1MB" looks
> > >> large enough that we don't need to spend time to investigate per arch
> > >> page sizes.
> > >
> > > IMHO we need that precision on reasoning and document it, even if not on
> > > the exact number we prefer, which can be prone to change later.  Otherwise
> > > that value will be a pure magic soon after a few years or even less, it'll
> > > be more of a challenge later to figure things out.
> > >
> > >> 
> > >> Having said that I'm now having slight self-doubt wrt huge pages, though
> > >> I swear we investigated it last year when first discussing this feature.
> > >> The guest memory will of course already be suitably aligned, but I'm
> > >> wondering if the filesystem I/O places any offset alignment constraints
> > >> related to non-default page size.
> > >
> > > AFAIU direct IO is about pinning the IO buffers, playing the role of fs
> > > cache instead.  If my understanding is correct, huge pages shouldn't be a
> > > problem for such pinning, because it's legal to pin partial of a huge page.
> > >
> > > After the partial huge pages pinned, they should be treated as normal fs
> > > buffers when doing block IO.  And then the offset of file should, per my
> > > understanding, not relevant to what is the type of backend of that user
> > > buffer anymore that triggers read()/write().
> > >
> > > But maybe I missed something, if so that will need to be part of
> > > documentation of 1MB magic value, IMHO.  We may want to double check with
> > > that by doing fixed-ram migration on e.g. 1GB hugetlb memory-backend-file
> > > with 1MB file offset per-ramblock.
> > 
> > Does anyone have any indication that we need to relate the aligment to
> > the page size? All I find online points to device block size being the
> > limiting factor for filesystems. There's also raw_probe_alignment() at
> > file-posix.c which seems to check up to 4k and recommend to disable
> > O_DIRECT if an alignment is not found.
> 
> Right, it should be more relevant to block size.
> 
> > 
> > Note that we shouldn't have any problems changing the alignment we
> > choose since we have a pointer to the start of the aligned region which
> > goes along with the fixed-ram header. We could even do some probing like
> > the block layer does if we wanted.
> 
> Having 1MB offset is fine, especially as you said we keep recv side fetch
> that in the headers always.
> 
> Perhaps we make that 1MB a macro, and add a comment explaining whatever we
> have on understanding how that 1MB come from?  I think we can also
> reference raw_probe_alignment() in the comment.
> 
> Meanwhile now I'm wondering whether that 1MB is too conservative.  Only a
> problem if there can be tons of ramblocks (e.g. 1000 ramblock means
> 1MB*1000=1G for the headers).  I can't think of any, though..  We can
> definitely leave that for later.

NB, the space won't actually be consumed on disk. By seeking to ramblock
offset, the file simply gets an allocation hole on disk. IOW, with 1000
ramblocks we will have 1 GB of holes.

Apps just have to be aware to preserve sparseness if they copy the
file around. This is probably a good docs point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


