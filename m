Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B87DD4BB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 18:34:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxscC-0007QG-0O; Tue, 31 Oct 2023 13:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxsc3-0007Mq-D5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:33:11 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxsc1-0007T4-2V
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 13:33:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8EA5221860;
 Tue, 31 Oct 2023 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698773587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cvll5GTO4AbGGAbEz9bmtDak+3k2PB8nFuOFhphtn2I=;
 b=T+00n6JUCyaWZ6V2FDqh0b5Py1JI4yPdNy3A05J+YNKsDwN6a1qD8hbqyNJGW3TSm+8CYq
 DTn0ArnfRtO4DEEi8Oixcj9p0CIguCVt64Pz3+tS3zxx6z2I1nUoNaDgtNZDidO12biFT5
 uwlNMh9tbfeDy+xzFrNt78jc5gnMRak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698773587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cvll5GTO4AbGGAbEz9bmtDak+3k2PB8nFuOFhphtn2I=;
 b=O7y79zVcNCjjaxYwuUEiEx0/e0YBbHgaR5l7URR5iKDy4U3nxufZu2FtaFpXsfuEaIMhlD
 dg6ZdLP9jE9tm2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B89D1391B;
 Tue, 31 Oct 2023 17:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kZIWNlI6QWW4dQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 17:33:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
In-Reply-To: <ZUEw5OW1D585tud9@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de> <ZUEw5OW1D585tud9@x1n>
Date: Tue, 31 Oct 2023 14:33:04 -0300
Message-ID: <87zfzyd7e7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Oct 23, 2023 at 05:35:54PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>> 
>> Implement the outgoing migration side for the 'fixed-ram' capability.
>> 
>> A bitmap is introduced to track which pages have been written in the
>> migration file. Pages are written at a fixed location for every
>> ramblock. Zero pages are ignored as they'd be zero in the destination
>> migration as well.
>> 
>> The migration stream is altered to put the dirty pages for a ramblock
>> after its header instead of having a sequential stream of pages that
>> follow the ramblock headers. Since all pages have a fixed location,
>> RAM_SAVE_FLAG_EOS is no longer generated on every migration iteration.
>> 
>> Without fixed-ram (current):
>> 
>> ramblock 1 header|ramblock 2 header|...|RAM_SAVE_FLAG_EOS|stream of
>>  pages (iter 1)|RAM_SAVE_FLAG_EOS|stream of pages (iter 2)|...
>> 
>> With fixed-ram (new):
>> 
>> ramblock 1 header|ramblock 1 fixed-ram header|ramblock 1 pages (fixed
>>  offsets)|ramblock 2 header|ramblock 2 fixed-ram header|ramblock 2
>>  pages (fixed offsets)|...|RAM_SAVE_FLAG_EOS
>> 
>> where:
>>  - ramblock header: the generic information for a ramblock, such as
>>    idstr, used_len, etc.
>> 
>>  - ramblock fixed-ram header: the new information added by this
>>    feature: bitmap of pages written, bitmap size and offset of pages
>>    in the migration file.
>> 
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/exec/ramblock.h |  8 ++++
>>  migration/options.c     |  3 --
>>  migration/ram.c         | 98 ++++++++++++++++++++++++++++++++++++-----
>>  3 files changed, 96 insertions(+), 13 deletions(-)
>> 
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 69c6a53902..e0e3f16852 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -44,6 +44,14 @@ struct RAMBlock {
>>      size_t page_size;
>>      /* dirty bitmap used during migration */
>>      unsigned long *bmap;
>> +    /* shadow dirty bitmap used when migrating to a file */
>> +    unsigned long *shadow_bmap;
>> +    /*
>> +     * offset in the file pages belonging to this ramblock are saved,
>> +     * used only during migration to a file.
>> +     */
>> +    off_t bitmap_offset;
>> +    uint64_t pages_offset;
>>      /* bitmap of already received pages in postcopy */
>>      unsigned long *receivedmap;
>>  
>> diff --git a/migration/options.c b/migration/options.c
>> index 2622d8c483..9f693d909f 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -271,12 +271,9 @@ bool migrate_events(void)
>>  
>>  bool migrate_fixed_ram(void)
>>  {
>> -/*
>>      MigrationState *s = migrate_get_current();
>>  
>>      return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
>> -*/
>> -    return false;
>>  }
>>  
>>  bool migrate_ignore_shared(void)
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 92769902bb..152a03604f 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1157,12 +1157,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>>          return 0;
>>      }
>>  
>> +    stat64_add(&mig_stats.zero_pages, 1);
>
> Here we keep zero page accounting, but..
>
>> +
>> +    if (migrate_fixed_ram()) {
>> +        /* zero pages are not transferred with fixed-ram */
>> +        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
>> +        return 1;
>> +    }
>> +
>>      len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
>>      qemu_put_byte(file, 0);
>>      len += 1;
>>      ram_release_page(pss->block->idstr, offset);
>> -
>> -    stat64_add(&mig_stats.zero_pages, 1);
>>      ram_transferred_add(len);
>>  
>>      /*
>> @@ -1220,14 +1226,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
>>  {
>>      QEMUFile *file = pss->pss_channel;
>>  
>> -    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
>> -                                         offset | RAM_SAVE_FLAG_PAGE));
>> -    if (async) {
>> -        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
>> -                              migrate_release_ram() &&
>> -                              migration_in_postcopy());
>> +    if (migrate_fixed_ram()) {
>> +        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
>> +                           block->pages_offset + offset);
>> +        set_bit(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
>>      } else {
>> -        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
>> +        ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
>> +                                             offset | RAM_SAVE_FLAG_PAGE));
>
> .. here we ignored normal page accounting.
>
> I think we should have the same behavior on both, perhaps keep them always?
>

This is the accounting for the header only if I'm not mistaken.

>> +        if (async) {
>> +            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
>> +                                  migrate_release_ram() &&
>> +                                  migration_in_postcopy());
>> +        } else {
>> +            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
>> +        }
>>      }
>>      ram_transferred_add(TARGET_PAGE_SIZE);
>>      stat64_add(&mig_stats.normal_pages, 1);

Here's the page accounting.

>> @@ -2475,6 +2487,8 @@ static void ram_save_cleanup(void *opaque)
>>          block->clear_bmap = NULL;
>>          g_free(block->bmap);
>>          block->bmap = NULL;
>> +        g_free(block->shadow_bmap);
>> +        block->shadow_bmap = NULL;
>>      }
>>  
>>      xbzrle_cleanup();
>> @@ -2842,6 +2856,7 @@ static void ram_list_init_bitmaps(void)
>>               */
>>              block->bmap = bitmap_new(pages);
>>              bitmap_set(block->bmap, 0, pages);
>> +            block->shadow_bmap = bitmap_new(block->used_length >> TARGET_PAGE_BITS);
>
> AFAICT bmap should also use used_length.  How about adding one more patch
> to change that, then you can use "pages" here?

It uses max_length. I don't know what are the effects of that
change. I'll look into it.

> See ram_mig_ram_block_resized() where we call migration_cancel() if resized.
>
>>              block->clear_bmap_shift = shift;
>>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
>>          }
>> @@ -2979,6 +2994,44 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>>      }
>>  }
>>  
>> +#define FIXED_RAM_HDR_VERSION 1
>> +struct FixedRamHeader {
>> +    uint32_t version;
>> +    uint64_t page_size;
>> +    uint64_t bitmap_offset;
>> +    uint64_t pages_offset;
>> +    /* end of v1 */
>> +} QEMU_PACKED;
>> +
>> +static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>> +{
>> +    g_autofree struct FixedRamHeader *header;
>> +    size_t header_size, bitmap_size;
>> +    long num_pages;
>> +
>> +    header = g_new0(struct FixedRamHeader, 1);
>> +    header_size = sizeof(struct FixedRamHeader);
>> +
>> +    num_pages = block->used_length >> TARGET_PAGE_BITS;
>> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>> +
>> +    /*
>> +     * Save the file offsets of where the bitmap and the pages should
>> +     * go as they are written at the end of migration and during the
>> +     * iterative phase, respectively.
>> +     */
>> +    block->bitmap_offset = qemu_get_offset(file) + header_size;
>> +    block->pages_offset = ROUND_UP(block->bitmap_offset +
>> +                                   bitmap_size, 0x100000);
>> +
>> +    header->version = cpu_to_be32(FIXED_RAM_HDR_VERSION);
>> +    header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
>
> This is the "page size" for the shadow bitmap, right?  Shall we state it
> somewhere (e.g. explaining why it's not block->page_size)?

Ok.

> It's unfortunate that we already have things like:
>
>             if (migrate_postcopy_ram() && block->page_size !=
>                                           qemu_host_page_size) {
>                 qemu_put_be64(f, block->page_size);
>             }
>
> But indeed we can't merge them because they seem to service different
> purpose.
>
>> +    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
>> +    header->pages_offset = cpu_to_be64(block->pages_offset);
>> +
>> +    qemu_put_buffer(file, (uint8_t *) header, header_size);
>> +}
>> +
>>  /*
>>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>>   * long-running RCU critical section.  When rcu-reclaims in the code
>> @@ -3028,6 +3081,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>              if (migrate_ignore_shared()) {
>>                  qemu_put_be64(f, block->mr->addr);
>>              }
>> +
>> +            if (migrate_fixed_ram()) {
>> +                fixed_ram_insert_header(f, block);
>> +                /* prepare offset for next ramblock */
>> +                qemu_set_offset(f, block->pages_offset + block->used_length, SEEK_SET);
>> +            }
>>          }
>>      }
>>  
>> @@ -3061,6 +3120,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>      return 0;
>>  }
>>  
>> +static void ram_save_shadow_bmap(QEMUFile *f)
>> +{
>> +    RAMBlock *block;
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        long num_pages = block->used_length >> TARGET_PAGE_BITS;
>> +        long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>> +        qemu_put_buffer_at(f, (uint8_t *)block->shadow_bmap, bitmap_size,
>> +                           block->bitmap_offset);
>> +        /* to catch any thread late sending pages */
>> +        block->shadow_bmap = NULL;
>
> What is this for?  Wouldn't this leak the buffer already?
>

Ah this is debug code. It's because of multifd. In this series I don't
use sem_sync because there's no packets. But doing so causes
multifd_send_sync_main() to return before the multifd channel has sent
all its pages. This is here so the channel crashes when writing the
bitmap.

I think it's worth it to keep it but I'd have to move it to the multifd
patch and free the bitmap properly.

Thanks!


