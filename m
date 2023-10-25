Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7A7D6725
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaQF-00085X-Ut; Wed, 25 Oct 2023 05:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaQ6-00085C-7V
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qvaQ4-0004qw-43
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698226999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=19a7FzOiIY3m9ur6lBRHVjSnc11ZSDNq7q7+r6FxrYA=;
 b=CBqY8y5IO69BDsKlkILmMSFo1KkthmsrmlxHqEyvnw2Gty44L6xy072AJoMWlm5nBkbYpK
 6lFc/9w27qaAnZ9ZFhXjLcyWB/On5nS+OOW3i/hBI/Wcx+j1n1GlKXFb/lOcjZQdtlWvcG
 1wSVOve9YopL7eEKa0xv1y8jFfV8OVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-4BLLFRNHNkCTDcniKlX2xg-1; Wed, 25 Oct 2023 05:43:17 -0400
X-MC-Unique: 4BLLFRNHNkCTDcniKlX2xg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AE26811E7E;
 Wed, 25 Oct 2023 09:43:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F64492BD9;
 Wed, 25 Oct 2023 09:43:16 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:43:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZTjjMiMkmnPMccjq@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-17-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

On Mon, Oct 23, 2023 at 05:35:55PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
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
> (farosas) reused more of the common code by making the fixed-ram
> function take only one ramblock and calling it from inside
> parse_ramblock.
> ---
>  migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 152a03604f..cea6971ab2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3032,6 +3032,32 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>  }
>  
> +static int fixed_ram_read_header(QEMUFile *file, struct FixedRamHeader *header)
> +{
> +    size_t ret, header_size = sizeof(struct FixedRamHeader);
> +
> +    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
> +    if (ret != header_size) {
> +        return -1;
> +    }
> +
> +    /* migration stream is big-endian */
> +    be32_to_cpus(&header->version);
> +
> +    if (header->version > FIXED_RAM_HDR_VERSION) {
> +        error_report("Migration fixed-ram capability version mismatch (expected %d, got %d)",
> +                     FIXED_RAM_HDR_VERSION, header->version);
> +        return -1;
> +    }
> +
> +    be64_to_cpus(&header->page_size);
> +    be64_to_cpus(&header->bitmap_offset);
> +    be64_to_cpus(&header->pages_offset);
> +
> +
> +    return 0;
> +}
> +
>  /*
>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>   * long-running RCU critical section.  When rcu-reclaims in the code
> @@ -3932,6 +3958,68 @@ void colo_flush_ram_cache(void)
>      trace_colo_flush_ram_cache_end();
>  }
>  
> +static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
> +                                    long num_pages, unsigned long *bitmap)
> +{
> +    unsigned long set_bit_idx, clear_bit_idx;
> +    unsigned long len;
> +    ram_addr_t offset;
> +    void *host;
> +    size_t read, completed, read_len;
> +
> +    for (set_bit_idx = find_first_bit(bitmap, num_pages);
> +         set_bit_idx < num_pages;
> +         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
> +
> +        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> +
> +        len = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
> +        offset = set_bit_idx << TARGET_PAGE_BITS;
> +
> +        for (read = 0, completed = 0; completed < len; offset += read) {
> +            host = host_from_ram_block_offset(block, offset);
> +            read_len = MIN(len, TARGET_PAGE_SIZE);
> +
> +            read = qemu_get_buffer_at(f, host, read_len,
> +                                      block->pages_offset + offset);
> +            completed += read;
> +        }
> +    }
> +}
> +
> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> +{
> +    g_autofree unsigned long *bitmap = NULL;
> +    struct FixedRamHeader header;
> +    size_t bitmap_size;
> +    long num_pages;
> +    int ret = 0;
> +
> +    ret = fixed_ram_read_header(f, &header);
> +    if (ret < 0) {
> +        error_report("Error reading fixed-ram header");
> +        return -EINVAL;
> +    }
> +
> +    block->pages_offset = header.pages_offset;

Do you think it is worth sanity checking that 'pages_offset' is aligned
in some way.

It is nice that we have flexibility to change the alignment in future
if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
check htere. Perhaps we could at least sanity check for alignment at
TARGET_PAGE_SIZE, to detect a gross data corruption problem ?

> +    num_pages = length / header.page_size;
> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
> +
> +    bitmap = g_malloc0(bitmap_size);
> +    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> +                           header.bitmap_offset) != bitmap_size) {
> +        error_report("Error parsing dirty bitmap");

s/parsing/reading/ since we're not actually parsing any semantic
info here.

> +        return -EINVAL;
> +    }
> +
> +    read_ramblock_fixed_ram(f, block, num_pages, bitmap);
> +
> +    /* Skip pages array */
> +    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
> +
> +    return ret;
> +}
> +
>  static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  {
>      int ret = 0;
> @@ -3940,6 +4028,10 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>  
>      assert(block);
>  
> +    if (migrate_fixed_ram()) {
> +        return parse_ramblock_fixed_ram(f, block, length);
> +    }
> +
>      if (!qemu_ram_is_migratable(block)) {
>          error_report("block %s should not be migrated !", block->idstr);
>          return -EINVAL;
> @@ -4142,6 +4234,7 @@ static int ram_load_precopy(QEMUFile *f)
>                  migrate_multifd_flush_after_each_section()) {
>                  multifd_recv_sync_main();
>              }
> +
>              break;

Spurious whitespace


>          case RAM_SAVE_FLAG_HOOK:
>              ret = rdma_registration_handle(f);
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


