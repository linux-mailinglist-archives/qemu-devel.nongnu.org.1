Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4877D671C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaN4-0006Me-Eu; Wed, 25 Oct 2023 05:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaMy-0006MN-IJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaMw-00040I-7H
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698226804;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DDVvz4A6aFOClrfBCbakUVyVJH0P1QRjoM/8EAzndQ0=;
 b=e0Q7oSqC+ww/F6EBaX8O1Kr6nlZBhpVWVB1a9LgXrsUT5sxIN2hp6VL74jdiwSqdn2rvM+
 Qrn2FZaPKX6z8ogSR6mRqdIVWQyBnsMxyjpFK2CoaZiSDsgE5lJMn1D8pagRuV311VIiWZ
 sRmxXqAfV7Vfq/C+MNf8nU5R5Ypz9eM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-Odarfo2LMIWl6ZraWHQm_w-1; Wed,
 25 Oct 2023 05:40:02 -0400
X-MC-Unique: Odarfo2LMIWl6ZraWHQm_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDBA3813F2C;
 Wed, 25 Oct 2023 09:40:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53ECEC15BBC;
 Wed, 25 Oct 2023 09:40:00 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:39:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZTjiblfeOCTY56e4@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-16-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 05:35:54PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Implement the outgoing migration side for the 'fixed-ram' capability.
> 
> A bitmap is introduced to track which pages have been written in the
> migration file. Pages are written at a fixed location for every
> ramblock. Zero pages are ignored as they'd be zero in the destination
> migration as well.
> 
> The migration stream is altered to put the dirty pages for a ramblock
> after its header instead of having a sequential stream of pages that
> follow the ramblock headers. Since all pages have a fixed location,
> RAM_SAVE_FLAG_EOS is no longer generated on every migration iteration.
> 
> Without fixed-ram (current):
> 
> ramblock 1 header|ramblock 2 header|...|RAM_SAVE_FLAG_EOS|stream of
>  pages (iter 1)|RAM_SAVE_FLAG_EOS|stream of pages (iter 2)|...

Clearer to diagram this vertically I think

 ---------------------
 | ramblock 1 header |
 ---------------------
 | ramblock 2 header |
 ---------------------
 | ...               |
 ---------------------
 | ramblock n header |
 ---------------------
 | RAM_SAVE_FLAG_EOS |
 ---------------------
 | stream of pages   |
 | (iter 1)          |
 | ...               |
 ---------------------
 | RAM_SAVE_FLAG_EOS |
 ---------------------
 | stream of pages   |
 | (iter 2)          |
 | ...               |
 ---------------------
 | ...               |
 ---------------------
 

> 
> With fixed-ram (new):
> 
> ramblock 1 header|ramblock 1 fixed-ram header|ramblock 1 pages (fixed
>  offsets)|ramblock 2 header|ramblock 2 fixed-ram header|ramblock 2
>  pages (fixed offsets)|...|RAM_SAVE_FLAG_EOS

If I'm reading the code correctly the new format has some padding
such that each "ramblock pages" region starts on a 1 MB boundary.

eg so we get:

 --------------------------------
 | ramblock 1 header            |
 --------------------------------
 | ramblock 1 fixed-ram header  |
 --------------------------------
 | padding to next 1MB boundary |
 | ...                          |
 --------------------------------
 | ramblock 1 pages             |
 | ...                          |
 --------------------------------
 | ramblock 2 header            |
 --------------------------------
 | ramblock 2 fixed-ram header  |
 --------------------------------
 | padding to next 1MB boundary |
 | ...                          |
 --------------------------------
 | ramblock 2 pages             |
 | ...                          |
 --------------------------------
 | ...                          |
 --------------------------------
 | RAM_SAVE_FLAG_EOS            |
 --------------------------------
 | ...                          |
 -------------------------------

> 
> where:
>  - ramblock header: the generic information for a ramblock, such as
>    idstr, used_len, etc.
> 
>  - ramblock fixed-ram header: the new information added by this
>    feature: bitmap of pages written, bitmap size and offset of pages
>    in the migration file.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/exec/ramblock.h |  8 ++++
>  migration/options.c     |  3 --
>  migration/ram.c         | 98 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 96 insertions(+), 13 deletions(-)
> 
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 69c6a53902..e0e3f16852 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -44,6 +44,14 @@ struct RAMBlock {
>      size_t page_size;
>      /* dirty bitmap used during migration */
>      unsigned long *bmap;
> +    /* shadow dirty bitmap used when migrating to a file */
> +    unsigned long *shadow_bmap;
> +    /*
> +     * offset in the file pages belonging to this ramblock are saved,
> +     * used only during migration to a file.
> +     */
> +    off_t bitmap_offset;
> +    uint64_t pages_offset;
>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
>  
> diff --git a/migration/options.c b/migration/options.c
> index 2622d8c483..9f693d909f 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -271,12 +271,9 @@ bool migrate_events(void)
>  
>  bool migrate_fixed_ram(void)
>  {
> -/*
>      MigrationState *s = migrate_get_current();
>  
>      return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
> -*/
> -    return false;
>  }
>  
>  bool migrate_ignore_shared(void)
> diff --git a/migration/ram.c b/migration/ram.c
> index 92769902bb..152a03604f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1157,12 +1157,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
>          return 0;
>      }
>  
> +    stat64_add(&mig_stats.zero_pages, 1);
> +
> +    if (migrate_fixed_ram()) {
> +        /* zero pages are not transferred with fixed-ram */
> +        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
> +        return 1;
> +    }
> +
>      len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
>      qemu_put_byte(file, 0);
>      len += 1;
>      ram_release_page(pss->block->idstr, offset);
> -
> -    stat64_add(&mig_stats.zero_pages, 1);
>      ram_transferred_add(len);
>  
>      /*
> @@ -1220,14 +1226,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
>  {
>      QEMUFile *file = pss->pss_channel;
>  
> -    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
> -                                         offset | RAM_SAVE_FLAG_PAGE));
> -    if (async) {
> -        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
> -                              migrate_release_ram() &&
> -                              migration_in_postcopy());
> +    if (migrate_fixed_ram()) {
> +        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
> +                           block->pages_offset + offset);
> +        set_bit(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
>      } else {
> -        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
> +        ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
> +                                             offset | RAM_SAVE_FLAG_PAGE));
> +        if (async) {
> +            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
> +                                  migrate_release_ram() &&
> +                                  migration_in_postcopy());
> +        } else {
> +            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
> +        }
>      }
>      ram_transferred_add(TARGET_PAGE_SIZE);
>      stat64_add(&mig_stats.normal_pages, 1);
> @@ -2475,6 +2487,8 @@ static void ram_save_cleanup(void *opaque)
>          block->clear_bmap = NULL;
>          g_free(block->bmap);
>          block->bmap = NULL;
> +        g_free(block->shadow_bmap);
> +        block->shadow_bmap = NULL;
>      }
>  
>      xbzrle_cleanup();
> @@ -2842,6 +2856,7 @@ static void ram_list_init_bitmaps(void)
>               */
>              block->bmap = bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> +            block->shadow_bmap = bitmap_new(block->used_length >> TARGET_PAGE_BITS);
>              block->clear_bmap_shift = shift;
>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
>          }
> @@ -2979,6 +2994,44 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>      }
>  }
>  
> +#define FIXED_RAM_HDR_VERSION 1
> +struct FixedRamHeader {
> +    uint32_t version;
> +    uint64_t page_size;
> +    uint64_t bitmap_offset;
> +    uint64_t pages_offset;
> +    /* end of v1 */
> +} QEMU_PACKED;
> +
> +static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
> +{
> +    g_autofree struct FixedRamHeader *header;
> +    size_t header_size, bitmap_size;
> +    long num_pages;
> +
> +    header = g_new0(struct FixedRamHeader, 1);
> +    header_size = sizeof(struct FixedRamHeader);
> +
> +    num_pages = block->used_length >> TARGET_PAGE_BITS;
> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +
> +    /*
> +     * Save the file offsets of where the bitmap and the pages should
> +     * go as they are written at the end of migration and during the
> +     * iterative phase, respectively.
> +     */
> +    block->bitmap_offset = qemu_get_offset(file) + header_size;
> +    block->pages_offset = ROUND_UP(block->bitmap_offset +
> +                                   bitmap_size, 0x100000);

The 0x100000 gives us our 1 MB alignment.

This is quite an important thing, so can we put a nice clear
constant at the top of the file:

  /* Align fixed-ram pages data to the next 1 MB boundary */
  #define FIXED_RAM_PAGE_OFFSET_ALIGNMENT 0x100000

> @@ -3179,7 +3252,6 @@ out:
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>          qemu_fflush(f);
>          ram_transferred_add(8);
> -
>          ret = qemu_file_get_error(f);
>      }
>      if (ret < 0) {

Supurious whitspace change, possibly better in whatever patch
introduced it, or dropped ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


