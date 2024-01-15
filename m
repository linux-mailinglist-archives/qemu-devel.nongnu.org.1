Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CEB82D657
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:51:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJbs-0005LA-5t; Mon, 15 Jan 2024 04:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJbl-0005Jl-9H
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJbh-0002Jf-9R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705312206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kh33BNX0Ru3coNCpkZjbju1AzDrWwALZHGZ0rjhats=;
 b=fqtnZ0NZDuj1f4mCvAC8KobrVsnBKh1Cs1/QdyGOxgO1a2mXCX9Yj2go95Z7P5V/XzFgpg
 +UeLcA0wtfGbuAtLKkUQRxL+o9rpZEpFm4Q2K1ScP9ZsyMtsu+qeO81zfl5q33qTPnmEhQ
 hReeJsOkNSW+Z55A+mmrFXivt9Nlzvs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-qrv2ppxGOgu9s375cGprFw-1; Mon, 15 Jan 2024 04:50:04 -0500
X-MC-Unique: qrv2ppxGOgu9s375cGprFw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d40e8aff1eso18067895ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705312203; x=1705917003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kh33BNX0Ru3coNCpkZjbju1AzDrWwALZHGZ0rjhats=;
 b=EypKlAEqGjUD0vWl+jhebMUzC2x4VLQLrWCu2yC4oOJ5Y/up7yoQUH/HVH/5Mk7Ing
 hRxqLhOzOdMm8738M/i7KpeteVo2FLXRnElWjwx++An+t23urEnwnDrKt7FoWhbmjqqa
 Bx+KeH4HmIZ7SHD9LG5u59vkaIIXqbD3W0SZXnTrVy/FMy7XSFT0g8sc1dqmRGamDaNu
 TYnSHm4z/HCL8ryg2jxN3V+CG2DOp8ruLmr6quCFXKEQ5rIPdBf2oiGNDURCL9t1KKLK
 en0ifqUmc6OzK2tm9EkexnB1DzPgpzRczl+8YvaqWGPL86V4Q4yDCiJP8NTxKpDpmNKE
 mibw==
X-Gm-Message-State: AOJu0YzxHeRqPFyKaG3rZNoBDVX7RrgpOMrFHc3LATJH5XHrrQgsxWIY
 uJUzrNAUD6iKrTrpZf5l7U5jxtnBUaW6tEHkvNeo/iT3XrUO6DZXYH7eFJcBHRbSLdSvU1NVbXE
 vQOopV/rFKp42ldpmXfIzaD4=
X-Received: by 2002:a17:902:aa8d:b0:1d4:bd3f:4d2e with SMTP id
 d13-20020a170902aa8d00b001d4bd3f4d2emr11959189plr.0.1705312203204; 
 Mon, 15 Jan 2024 01:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu5wYTanoF9qP5rBlb+QyzhvtxgcQy9uaDJeSlM4N+yeOUJJQdht0tOvWJYSFvY7RvPNVssw==
X-Received: by 2002:a17:902:aa8d:b0:1d4:bd3f:4d2e with SMTP id
 d13-20020a170902aa8d00b001d4bd3f4d2emr11959173plr.0.1705312202749; 
 Mon, 15 Jan 2024 01:50:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ld16-20020a170902fad000b001d4b5e444d2sm7312922plb.48.2024.01.15.01.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 01:50:02 -0800 (PST)
Date: Mon, 15 Jan 2024 17:49:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 09/30] migration/ram: Add incoming 'fixed-ram'
 migration
Message-ID: <ZaT_wLbb9fZVauia@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-10-farosas@suse.de>
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

On Mon, Nov 27, 2023 at 05:25:51PM -0300, Fabiano Rosas wrote:
> Add the necessary code to parse the format changes for the 'fixed-ram'
> capability.
> 
> One of the more notable changes in behavior is that in the 'fixed-ram'
> case ram pages are restored in one go rather than constantly looping
> through the migration stream.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - added sanity check for pages_offset alignment
> - s/parsing/reading
> - used Error
> - fixed buffer size computation, now allowing an arbitrary limit
> - fixed dereference of pointer to packed struct member in endianness
>   conversion
> ---
>  migration/ram.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4a0ab8105f..08604222f2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -106,6 +106,12 @@
>   */
>  #define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
>  
> +/*
> + * When doing fixed-ram migration, this is the amount we read from the
> + * pages region in the migration file at a time.
> + */
> +#define FIXED_RAM_LOAD_BUF_SIZE 0x100000
> +
>  XBZRLECacheStats xbzrle_counters;
>  
>  /* used by the search for pages to send */
> @@ -2996,6 +3002,35 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>  }
>  
> +static bool fixed_ram_read_header(QEMUFile *file, FixedRamHeader *header,
> +                                  Error **errp)
> +{
> +    size_t ret, header_size = sizeof(FixedRamHeader);
> +
> +    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
> +    if (ret != header_size) {
> +        error_setg(errp, "Could not read whole fixed-ram migration header "
> +                   "(expected %zd, got %zd bytes)", header_size, ret);
> +        return false;
> +    }
> +
> +    /* migration stream is big-endian */
> +    header->version = be32_to_cpu(header->version);
> +
> +    if (header->version > FIXED_RAM_HDR_VERSION) {
> +        error_setg(errp, "Migration fixed-ram capability version mismatch "
> +                   "(expected %d, got %d)", FIXED_RAM_HDR_VERSION,
> +                   header->version);
> +        return false;
> +    }
> +
> +    header->page_size = be64_to_cpu(header->page_size);
> +    header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
> +    header->pages_offset = be64_to_cpu(header->pages_offset);
> +
> +    return true;
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> @@ -3892,6 +3927,80 @@ void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> +static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
> +                                    long num_pages, unsigned long *bitmap)
> +{
> +    unsigned long set_bit_idx, clear_bit_idx;
> +    ram_addr_t offset;
> +    void *host;
> +    size_t read, unread, size, buf_size = FIXED_RAM_LOAD_BUF_SIZE;
> +
> +    for (set_bit_idx = find_first_bit(bitmap, num_pages);
> +         set_bit_idx < num_pages;
> +         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
> +
> +        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> +
> +        unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
> +        offset = set_bit_idx << TARGET_PAGE_BITS;
> +
> +        while (unread > 0) {
> +            host = host_from_ram_block_offset(block, offset);
> +            size = MIN(unread, buf_size);

Use the macro directly?  buf_size can be dropped then.

> +
> +            read = qemu_get_buffer_at(f, host, size,
> +                                      block->pages_offset + offset);

Error detection missing?  qemu_get_buffer_at() returns 0 if error, then it
dead loops.

> +            offset += read;
> +            unread -= read;
> +        }
> +    }
> +}
> +
> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
> +                                    ram_addr_t length, Error **errp)

For new code, start to keep using boolean as retval when Error** exists?

> +{
> +    g_autofree unsigned long *bitmap = NULL;
> +    FixedRamHeader header;
> +    size_t bitmap_size;
> +    long num_pages;
> +
> +    if (!fixed_ram_read_header(f, &header, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    block->pages_offset = header.pages_offset;
> +
> +    /*
> +     * Check the alignment of the file region that contains pages. We
> +     * don't enforce FIXED_RAM_FILE_OFFSET_ALIGNMENT to allow that
> +     * value to change in the future. Do only a sanity check with page
> +     * size alignment.
> +     */
> +    if (!QEMU_IS_ALIGNED(block->pages_offset, TARGET_PAGE_SIZE)) {
> +        error_setg(errp,
> +                   "Error reading ramblock %s pages, region has bad alignment",
> +                   block->idstr);
> +        return -EINVAL;
> +    }
> +
> +    num_pages = length / header.page_size;
> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +
> +    bitmap = g_malloc0(bitmap_size);
> +    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> +                           header.bitmap_offset) != bitmap_size) {
> +        error_setg(errp, "Error reading dirty bitmap");
> +        return -EINVAL;
> +    }
> +
> +    read_ramblock_fixed_ram(f, block, num_pages, bitmap);

Detect error and fail properly?

> +
> +    /* Skip pages array */
> +    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
> +
> +    return 0;
> +}
> +
>  static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  {
>      int ret = 0;
> @@ -3900,6 +4009,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  
>      assert(block);
>  
> +    if (migrate_fixed_ram()) {
> +        Error *local_err = NULL;
> +
> +        ret = parse_ramblock_fixed_ram(f, block, length, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +        return ret;

We can optionally add one pre-requisite patch to convert parse_ramblock()
to return boolean too.  I remember it was done somewhere before, but maybe
not merged.

> +    }
> +
>      if (!qemu_ram_is_migratable(block)) {
>          error_report("block %s should not be migrated !", block->idstr);
>          return -EINVAL;
> -- 
> 2.35.3
> 

-- 
Peter Xu


