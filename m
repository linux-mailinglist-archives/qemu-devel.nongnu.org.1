Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAEA82D604
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJHS-0000eC-AK; Mon, 15 Jan 2024 04:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJHP-0000dv-Sd
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJHN-0006bz-Mm
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705310952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3g/0qT38nDwa1kN/UnhZh7iMIzDhg8Y1EzI2js7dwys=;
 b=Gsmz5WO2H/bFLOf3agvJS/jh0Ct7lTvegimsOOUWJpNLgohAjecnE8z5H0dGn3jBesfqeN
 b3lq+GBOap+fK+/6nacgDHXGvrM4DO94M17I8TJ9a8WLFKJabhq8o8vBMyw7AhW3+qDKzQ
 5CQ//kkcsHZt3YLkzseUPScgzGstaYE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-loqkXW3JMKSWWTDd2teMbg-1; Mon, 15 Jan 2024 04:29:10 -0500
X-MC-Unique: loqkXW3JMKSWWTDd2teMbg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59880f09eeaso882705eaf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705310949; x=1705915749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g/0qT38nDwa1kN/UnhZh7iMIzDhg8Y1EzI2js7dwys=;
 b=njPlf5yB9Fqc8uJTz/1wqr/si+ezdENLNxg0+u+/8eFOiB0ivLooUoKyxO+w5IatJt
 //3y5SurmN+AlaHln54e0KeTu2jZVAV74xlHCiH9bVHbYJfWr62InwYu5HM3DE4IAy/M
 wo0PB+rfny1c+NQ8oVrpJXqmWXTkO8WBTUmgTfY+wCDSYBG2M8QqhU/QrFJu6RCqVmn+
 aXtka9FEGIsyoDon3bgQ5r/OVEw5rU5A8klLdfusquwcCvsdYnyl2ORu/3qUyjpFsQUl
 mx7HZH5MJwP2g+skqhifvHmjT3FRv58XvwG7E/6pHNVRhtjaQiohIs0M9h5TEMkQDoqi
 B7Sw==
X-Gm-Message-State: AOJu0YzFdmgivg71hB8VeRGTZQIPQHHSbs8enCNpSO4Zj7ZGW6qgXS+F
 lMSnfTJXZ+7QV5inKMqXmUIKYVYkgSqO8ex2qlJTBy0QLquXuH1mvrk2Xskt+vOZJcW4oMVL8og
 ubspY/+Vh8hhhzsP+GTotxio=
X-Received: by 2002:a05:6358:9190:b0:175:c51c:bfa2 with SMTP id
 j16-20020a056358919000b00175c51cbfa2mr10205881rwa.0.1705310949495; 
 Mon, 15 Jan 2024 01:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeMshCM3Wo/8jhDmWLv64hbnnV92VYZYcxOTBN8dLY4LF/LN2XZMMfAsv0wQVF1gFdAx8chA==
X-Received: by 2002:a05:6358:9190:b0:175:c51c:bfa2 with SMTP id
 j16-20020a056358919000b00175c51cbfa2mr10205872rwa.0.1705310949095; 
 Mon, 15 Jan 2024 01:29:09 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 du21-20020a056a002b5500b006dadc436071sm7150108pfb.36.2024.01.15.01.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 01:29:08 -0800 (PST)
Date: Mon, 15 Jan 2024 17:28:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH v3 08/30] migration/ram: Add outgoing 'fixed-ram'
 migration
Message-ID: <ZaT62Ssg6dhSgTV_@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 05:25:50PM -0300, Fabiano Rosas wrote:
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
> Without fixed-ram (current):        With fixed-ram (new):
> 
>  ---------------------               --------------------------------
>  | ramblock 1 header |               | ramblock 1 header            |
>  ---------------------               --------------------------------
>  | ramblock 2 header |               | ramblock 1 fixed-ram header  |
>  ---------------------               --------------------------------
>  | ...               |               | padding to next 1MB boundary |
>  ---------------------               | ...                          |
>  | ramblock n header |               --------------------------------
>  ---------------------               | ramblock 1 pages             |
>  | RAM_SAVE_FLAG_EOS |               | ...                          |
>  ---------------------               --------------------------------
>  | stream of pages   |               | ramblock 2 header            |
>  | (iter 1)          |               --------------------------------
>  | ...               |               | ramblock 2 fixed-ram header  |
>  ---------------------               --------------------------------
>  | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
>  ---------------------               | ...                          |
>  | stream of pages   |               --------------------------------
>  | (iter 2)          |               | ramblock 2 pages             |
>  | ...               |               | ...                          |
>  ---------------------               --------------------------------
>  | ...               |               | ...                          |
>  ---------------------               --------------------------------
>                                      | RAM_SAVE_FLAG_EOS            |
>                                      --------------------------------
>                                      | ...                          |
>                                      --------------------------------
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
> - used a macro for alignment value
> - documented alignment assumptions
> - moved shadow_bmap debug code to multifd patch
> - did NOT use used_length for bmap, it breaks dirty page tracking somehow
> - uncommented the capability enabling
> - accounted for the bitmap size with ram_transferred_add()
> ---
>  include/exec/ramblock.h |   8 +++
>  migration/ram.c         | 121 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 120 insertions(+), 9 deletions(-)
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

What is a "shadow dirty bitmap"?  It's pretty unclear to me.

AFAICT it's actually a "page present" bitmap, while taking zero pages as
"not present", no?

> +    /*
> +     * offset in the file pages belonging to this ramblock are saved,
> +     * used only during migration to a file.
> +     */
> +    off_t bitmap_offset;
> +    uint64_t pages_offset;

Let's have a section to put fixed-ram data?

  /*
   * Below fields are only used by fixed-ram migration.
   */
  ...

>      /* bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 8c7886ab79..4a0ab8105f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -94,6 +94,18 @@
>  #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
>  /* We can't use any flag that is bigger than 0x200 */
>  
> +/*
> + * fixed-ram migration supports O_DIRECT, so we need to make sure the
> + * userspace buffer, the IO operation size and the file offset are
> + * aligned according to the underlying device's block size. The first
> + * two are already aligned to page size, but we need to add padding to
> + * the file to align the offset.  We cannot read the block size
> + * dynamically because the migration file can be moved between
> + * different systems, so use 1M to cover most block sizes and to keep
> + * the file offset aligned at page size as well.
> + */
> +#define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
> +
>  XBZRLECacheStats xbzrle_counters;
>  
>  /* used by the search for pages to send */
> @@ -1127,12 +1139,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
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
> @@ -1190,14 +1208,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
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
> @@ -2413,6 +2437,8 @@ static void ram_save_cleanup(void *opaque)
>          block->clear_bmap = NULL;
>          g_free(block->bmap);
>          block->bmap = NULL;
> +        g_free(block->shadow_bmap);
> +        block->shadow_bmap = NULL;
>      }
>  
>      xbzrle_cleanup();
> @@ -2780,6 +2806,7 @@ static void ram_list_init_bitmaps(void)
>               */
>              block->bmap = bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> +            block->shadow_bmap = bitmap_new(pages);

We can avoid creating this bitmap if !fixed-ram.

>              block->clear_bmap_shift = shift;
>              block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
>          }
> @@ -2917,6 +2944,58 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
>      }
>  }
>  
> +#define FIXED_RAM_HDR_VERSION 1
> +struct FixedRamHeader {
> +    uint32_t version;
> +    /*
> +     * The target's page size, so we know how many pages are in the
> +     * bitmap.
> +     */
> +    uint64_t page_size;
> +    /*
> +     * The offset in the migration file where the pages bitmap is
> +     * found.

s/found/stored/?

> +     */
> +    uint64_t bitmap_offset;
> +    /*
> +     * The offset in the migration file where the actual pages (data)
> +     * are found.

same?

> +     */
> +    uint64_t pages_offset;
> +    /* end of v1 */

I think we can drop this.

> +} QEMU_PACKED;
> +typedef struct FixedRamHeader FixedRamHeader;
> +
> +static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
> +{
> +    g_autofree FixedRamHeader *header;

Let's either inline the g_new0() or initialize it to NULL? Just in case.

> +    size_t header_size, bitmap_size;
> +    long num_pages;
> +
> +    header = g_new0(FixedRamHeader, 1);
> +    header_size = sizeof(FixedRamHeader);
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
> +                                   bitmap_size,
> +                                   FIXED_RAM_FILE_OFFSET_ALIGNMENT);
> +
> +    header->version = cpu_to_be32(FIXED_RAM_HDR_VERSION);
> +    header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
> +    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
> +    header->pages_offset = cpu_to_be64(block->pages_offset);
> +
> +    qemu_put_buffer(file, (uint8_t *) header, header_size);
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> @@ -2966,6 +3045,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>              if (migrate_ignore_shared()) {
>                  qemu_put_be64(f, block->mr->addr);
>              }
> +
> +            if (migrate_fixed_ram()) {
> +                fixed_ram_insert_header(f, block);
> +                /* prepare offset for next ramblock */
> +                qemu_set_offset(f, block->pages_offset + block->used_length,
> +                                SEEK_SET);

How about moving this line into fixed_ram_insert_header()?  Perhaps also
rename to fixed_ram_setup_ramblock()?

> +            }
>          }
>      }
>  
> @@ -2999,6 +3085,19 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      return qemu_fflush(f);
>  }
>  
> +static void ram_save_shadow_bmap(QEMUFile *f)

[may need a rename after we decide a better name for the bitmap; "shadow"
 is probably not the one..]

> +{
> +    RAMBlock *block;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        long num_pages = block->used_length >> TARGET_PAGE_BITS;
> +        long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +        qemu_put_buffer_at(f, (uint8_t *)block->shadow_bmap, bitmap_size,
> +                           block->bitmap_offset);

We may want to check for IO errors, either here, or (if too frequent) maybe
once and for all right before the final completion of migration?  If the
latter, we may want to keep a comment around here explaining on error conditions.

> +        ram_transferred_add(bitmap_size);
> +    }
> +}
> +
>  /**
>   * ram_save_iterate: iterative stage for migration
>   *
> @@ -3188,6 +3287,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> +    if (migrate_fixed_ram()) {
> +        ram_save_shadow_bmap(f);
> +    }
> +
>      if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>      }
> -- 
> 2.35.3
> 

-- 
Peter Xu


