Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 299037DD5B7
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:00:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxt1T-0001Va-96; Tue, 31 Oct 2023 13:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxt1Q-0001VR-Sf
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxt1N-0003n4-Oo
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698775160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cmcowLa/LjHTrWfAxDuOgETWjdlTs65cBLGfH1AG8UA=;
 b=gDspkxBogXgOKvpOHdkAawKqWxpYg0r+OMrsRvCo5I7VuWBMQCkgSOd+prg2aaF0x/dbRO
 K3WkanrWKB4rrLcTq1j2LdI9xHIXGDnVMsWh9KV6c7Udsq/8IcK3dgkK7j3lnjUwSn7UAz
 rpMFVIZwy3pLwC73KtToyzGQeyfbY7w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-ublUbnilNKuTYDFU5r_t-A-1; Tue, 31 Oct 2023 13:59:07 -0400
X-MC-Unique: ublUbnilNKuTYDFU5r_t-A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d3f71f49cso14055626d6.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 10:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698775147; x=1699379947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmcowLa/LjHTrWfAxDuOgETWjdlTs65cBLGfH1AG8UA=;
 b=H8JA2zi/HqOfhbouNeflPe0CdwPaUqUHBv3gUYstTUF9oNeoKUOfIJhNSWcAQOlLGW
 +JuYnx3PLdHLqFft/xdXhmMqRv0vQkVH8C478bt1/tBbw2f8RR6qzi2LZAeHG8svujwu
 Ck/aRwTTmRBJfPjJ4kMo2fq6hphGe2Q7jc6CcpFY2MEFAoBA3iMMI7t3IH0h1Y3Yszy8
 qDo0DqAoLhLhFhY/P8akf6Mw4Up5lOE+1js6RIcfnIsCsFXpPd/EW2EgmwwEkz6sXdE3
 6G40RjLB2v1gIS+6HMQ6UFkVwj167ImC2FKfKhZU3urtA7F572MpqJx5p3dZ1AtSF3om
 rF5w==
X-Gm-Message-State: AOJu0YzVy2wwA6lq+rX3BCsrP6ywcyo0EBzaDx2rIiMPplPAINDu++/E
 I+j6xLPVj/GFMwjQhslP4ehXl0Ic1uPv07YYV4lWJIr3/dEjYAuKjCaHlOvC0yIbkSXobUQYjB4
 Dvi3Q8+w7/EAvao4=
X-Received: by 2002:a05:6214:4a4f:b0:66d:5d31:999b with SMTP id
 ph15-20020a0562144a4f00b0066d5d31999bmr14121196qvb.3.1698775146745; 
 Tue, 31 Oct 2023 10:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGu4tQE83uZaDicXt86/QHRi9RMle+QkTh3KlX7NQLMRTXCdaDxBXAy0t2bFFe3qQgH+H8fg==
X-Received: by 2002:a05:6214:4a4f:b0:66d:5d31:999b with SMTP id
 ph15-20020a0562144a4f00b0066d5d31999bmr14121181qvb.3.1698775146332; 
 Tue, 31 Oct 2023 10:59:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c4-20020a0ceb44000000b0066d5220d860sm733523qvq.18.2023.10.31.10.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:59:06 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:59:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZUFAZ9BZ8nUVqTqX@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de> <ZUEw5OW1D585tud9@x1n>
 <87zfzyd7e7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfzyd7e7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Tue, Oct 31, 2023 at 02:33:04PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Oct 23, 2023 at 05:35:54PM -0300, Fabiano Rosas wrote:
> >> From: Nikolay Borisov <nborisov@suse.com>
> >> 
> >> Implement the outgoing migration side for the 'fixed-ram' capability.
> >> 
> >> A bitmap is introduced to track which pages have been written in the
> >> migration file. Pages are written at a fixed location for every
> >> ramblock. Zero pages are ignored as they'd be zero in the destination
> >> migration as well.
> >> 
> >> The migration stream is altered to put the dirty pages for a ramblock
> >> after its header instead of having a sequential stream of pages that
> >> follow the ramblock headers. Since all pages have a fixed location,
> >> RAM_SAVE_FLAG_EOS is no longer generated on every migration iteration.
> >> 
> >> Without fixed-ram (current):
> >> 
> >> ramblock 1 header|ramblock 2 header|...|RAM_SAVE_FLAG_EOS|stream of
> >>  pages (iter 1)|RAM_SAVE_FLAG_EOS|stream of pages (iter 2)|...
> >> 
> >> With fixed-ram (new):
> >> 
> >> ramblock 1 header|ramblock 1 fixed-ram header|ramblock 1 pages (fixed
> >>  offsets)|ramblock 2 header|ramblock 2 fixed-ram header|ramblock 2
> >>  pages (fixed offsets)|...|RAM_SAVE_FLAG_EOS
> >> 
> >> where:
> >>  - ramblock header: the generic information for a ramblock, such as
> >>    idstr, used_len, etc.
> >> 
> >>  - ramblock fixed-ram header: the new information added by this
> >>    feature: bitmap of pages written, bitmap size and offset of pages
> >>    in the migration file.
> >> 
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  include/exec/ramblock.h |  8 ++++
> >>  migration/options.c     |  3 --
> >>  migration/ram.c         | 98 ++++++++++++++++++++++++++++++++++++-----
> >>  3 files changed, 96 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> >> index 69c6a53902..e0e3f16852 100644
> >> --- a/include/exec/ramblock.h
> >> +++ b/include/exec/ramblock.h
> >> @@ -44,6 +44,14 @@ struct RAMBlock {
> >>      size_t page_size;
> >>      /* dirty bitmap used during migration */
> >>      unsigned long *bmap;
> >> +    /* shadow dirty bitmap used when migrating to a file */
> >> +    unsigned long *shadow_bmap;
> >> +    /*
> >> +     * offset in the file pages belonging to this ramblock are saved,
> >> +     * used only during migration to a file.
> >> +     */
> >> +    off_t bitmap_offset;
> >> +    uint64_t pages_offset;
> >>      /* bitmap of already received pages in postcopy */
> >>      unsigned long *receivedmap;
> >>  
> >> diff --git a/migration/options.c b/migration/options.c
> >> index 2622d8c483..9f693d909f 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -271,12 +271,9 @@ bool migrate_events(void)
> >>  
> >>  bool migrate_fixed_ram(void)
> >>  {
> >> -/*
> >>      MigrationState *s = migrate_get_current();
> >>  
> >>      return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
> >> -*/
> >> -    return false;

One more thing: maybe we can avoid this and just assume nobody will only
apply the previous patch and cause trouble.

> >>  }
> >>  
> >>  bool migrate_ignore_shared(void)
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 92769902bb..152a03604f 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -1157,12 +1157,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
> >>          return 0;
> >>      }
> >>  
> >> +    stat64_add(&mig_stats.zero_pages, 1);
> >
> > Here we keep zero page accounting, but..
> >
> >> +
> >> +    if (migrate_fixed_ram()) {
> >> +        /* zero pages are not transferred with fixed-ram */
> >> +        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
> >> +        return 1;
> >> +    }
> >> +
> >>      len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
> >>      qemu_put_byte(file, 0);
> >>      len += 1;
> >>      ram_release_page(pss->block->idstr, offset);
> >> -
> >> -    stat64_add(&mig_stats.zero_pages, 1);
> >>      ram_transferred_add(len);
> >>  
> >>      /*
> >> @@ -1220,14 +1226,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
> >>  {
> >>      QEMUFile *file = pss->pss_channel;
> >>  
> >> -    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
> >> -                                         offset | RAM_SAVE_FLAG_PAGE));
> >> -    if (async) {
> >> -        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
> >> -                              migrate_release_ram() &&
> >> -                              migration_in_postcopy());
> >> +    if (migrate_fixed_ram()) {
> >> +        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
> >> +                           block->pages_offset + offset);
> >> +        set_bit(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
> >>      } else {
> >> -        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
> >> +        ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
> >> +                                             offset | RAM_SAVE_FLAG_PAGE));
> >
> > .. here we ignored normal page accounting.
> >
> > I think we should have the same behavior on both, perhaps keep them always?
> >
> 
> This is the accounting for the header only if I'm not mistaken.
> 
> >> +        if (async) {
> >> +            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
> >> +                                  migrate_release_ram() &&
> >> +                                  migration_in_postcopy());
> >> +        } else {
> >> +            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
> >> +        }
> >>      }
> >>      ram_transferred_add(TARGET_PAGE_SIZE);
> >>      stat64_add(&mig_stats.normal_pages, 1);
> 
> Here's the page accounting.

Oh, that's okay then.

> 
> >> @@ -2475,6 +2487,8 @@ static void ram_save_cleanup(void *opaque)
> >>          block->clear_bmap = NULL;
> >>          g_free(block->bmap);
> >>          block->bmap = NULL;
> >> +        g_free(block->shadow_bmap);
> >> +        block->shadow_bmap = NULL;
> >>      }
> >>  
> >>      xbzrle_cleanup();
> >> @@ -2842,6 +2856,7 @@ static void ram_list_init_bitmaps(void)
> >>               */
> >>              block->bmap = bitmap_new(pages);
> >>              bitmap_set(block->bmap, 0, pages);
> >> +            block->shadow_bmap = bitmap_new(block->used_length >> TARGET_PAGE_BITS);
> >
> > AFAICT bmap should also use used_length.  How about adding one more patch
> > to change that, then you can use "pages" here?
> 
> It uses max_length. I don't know what are the effects of that
> change. I'll look into it.
> 
> > See ram_mig_ram_block_resized() where we call migration_cancel() if resized.
> >
> >>              block->clear_bmap_shift = shift;
> >>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> >>          }
> >> @@ -2979,6 +2994,44 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
> >>      }
> >>  }
> >>  
> >> +#define FIXED_RAM_HDR_VERSION 1
> >> +struct FixedRamHeader {
> >> +    uint32_t version;
> >> +    uint64_t page_size;
> >> +    uint64_t bitmap_offset;
> >> +    uint64_t pages_offset;
> >> +    /* end of v1 */
> >> +} QEMU_PACKED;
> >> +
> >> +static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
> >> +{
> >> +    g_autofree struct FixedRamHeader *header;
> >> +    size_t header_size, bitmap_size;
> >> +    long num_pages;
> >> +
> >> +    header = g_new0(struct FixedRamHeader, 1);
> >> +    header_size = sizeof(struct FixedRamHeader);
> >> +
> >> +    num_pages = block->used_length >> TARGET_PAGE_BITS;
> >> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> >> +
> >> +    /*
> >> +     * Save the file offsets of where the bitmap and the pages should
> >> +     * go as they are written at the end of migration and during the
> >> +     * iterative phase, respectively.
> >> +     */
> >> +    block->bitmap_offset = qemu_get_offset(file) + header_size;
> >> +    block->pages_offset = ROUND_UP(block->bitmap_offset +
> >> +                                   bitmap_size, 0x100000);
> >> +
> >> +    header->version = cpu_to_be32(FIXED_RAM_HDR_VERSION);
> >> +    header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
> >
> > This is the "page size" for the shadow bitmap, right?  Shall we state it
> > somewhere (e.g. explaining why it's not block->page_size)?
> 
> Ok.
> 
> > It's unfortunate that we already have things like:
> >
> >             if (migrate_postcopy_ram() && block->page_size !=
> >                                           qemu_host_page_size) {
> >                 qemu_put_be64(f, block->page_size);
> >             }
> >
> > But indeed we can't merge them because they seem to service different
> > purpose.
> >
> >> +    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
> >> +    header->pages_offset = cpu_to_be64(block->pages_offset);
> >> +
> >> +    qemu_put_buffer(file, (uint8_t *) header, header_size);
> >> +}
> >> +
> >>  /*
> >>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
> >>   * long-running RCU critical section.  When rcu-reclaims in the code
> >> @@ -3028,6 +3081,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >>              if (migrate_ignore_shared()) {
> >>                  qemu_put_be64(f, block->mr->addr);
> >>              }
> >> +
> >> +            if (migrate_fixed_ram()) {
> >> +                fixed_ram_insert_header(f, block);
> >> +                /* prepare offset for next ramblock */
> >> +                qemu_set_offset(f, block->pages_offset + block->used_length, SEEK_SET);
> >> +            }
> >>          }
> >>      }
> >>  
> >> @@ -3061,6 +3120,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >>      return 0;
> >>  }
> >>  
> >> +static void ram_save_shadow_bmap(QEMUFile *f)
> >> +{
> >> +    RAMBlock *block;
> >> +
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> +        long num_pages = block->used_length >> TARGET_PAGE_BITS;
> >> +        long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> >> +        qemu_put_buffer_at(f, (uint8_t *)block->shadow_bmap, bitmap_size,
> >> +                           block->bitmap_offset);
> >> +        /* to catch any thread late sending pages */
> >> +        block->shadow_bmap = NULL;
> >
> > What is this for?  Wouldn't this leak the buffer already?
> >
> 
> Ah this is debug code. It's because of multifd. In this series I don't
> use sem_sync because there's no packets. But doing so causes
> multifd_send_sync_main() to return before the multifd channel has sent
> all its pages. This is here so the channel crashes when writing the
> bitmap.
> 
> I think it's worth it to keep it but I'd have to move it to the multifd
> patch and free the bitmap properly.

Ok, I'll keep reading.

-- 
Peter Xu


