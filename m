Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D882DDCF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:45:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQ43-0003sD-Uf; Mon, 15 Jan 2024 11:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPQ41-0003ro-P7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:43:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPQ3z-0007w9-Qg
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:43:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B089D221B7;
 Mon, 15 Jan 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705337028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgBRoaXwyeomq8YMp0pkyYyyiXcqA8mL/hAs+Zfr6sI=;
 b=hXAa5X6RQEZPy6rHKTAfNKlkCsPZMkQigMY/aHXqV7LEa/Y7ad2ZvbcW8iX984xje0UnoO
 F6psp1YAiZSh13CB8UzlbN/CxccUnk1TjemgFyGONnEC2/x5qj86hUApeJhW0wRYx/Wxdn
 QnDO26Nr0ICDJ0BAKurFC/QatIMUurU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705337028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgBRoaXwyeomq8YMp0pkyYyyiXcqA8mL/hAs+Zfr6sI=;
 b=++PPNWcVjlyurEbWEIhAtw85wDi/l163v6XJq2htTkKvnjSyYAtkDdrgH3SF/s24KcHDa6
 2kz84wcrqRXKjwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705337027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgBRoaXwyeomq8YMp0pkyYyyiXcqA8mL/hAs+Zfr6sI=;
 b=j7xAT45VI3tfaHvaHE7wiQ3W5xWC0d51bAguwX0lOx0yW3RVsSoFvIdr/x5NXP9gEW+yBv
 1y0T0s0T1iDEuWoji6mbrXDMRRkcFvcG/yJkfp6sV9rv+x9TqNBkWoEc0bbMwheD7rlmLW
 oaIl0MIv+pFjUZfxaeRcjikydEDlefA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705337027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgBRoaXwyeomq8YMp0pkyYyyiXcqA8mL/hAs+Zfr6sI=;
 b=Ru0LD01I/4YNAl5ToHW+Cw1wi+ULgXV7i4jUSRKBlXHKRWEKsIOwop6soCor4PsshYnCJE
 vSBFfdR2ZeDgoGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A36F132FA;
 Mon, 15 Jan 2024 16:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gUCxAMNgpWWEHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Jan 2024 16:43:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 09/30] migration/ram: Add incoming 'fixed-ram'
 migration
In-Reply-To: <ZaT_wLbb9fZVauia@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-10-farosas@suse.de> <ZaT_wLbb9fZVauia@x1n>
Date: Mon, 15 Jan 2024 13:43:44 -0300
Message-ID: <875xzu5yyn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j7xAT45V;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ru0LD01I
X-Spamd-Result: default: False [-4.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B089D221B7
X-Spam-Score: -4.31
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, Nov 27, 2023 at 05:25:51PM -0300, Fabiano Rosas wrote:
>> Add the necessary code to parse the format changes for the 'fixed-ram'
>> capability.
>> 
>> One of the more notable changes in behavior is that in the 'fixed-ram'
>> case ram pages are restored in one go rather than constantly looping
>> through the migration stream.
>> 
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> - added sanity check for pages_offset alignment
>> - s/parsing/reading
>> - used Error
>> - fixed buffer size computation, now allowing an arbitrary limit
>> - fixed dereference of pointer to packed struct member in endianness
>>   conversion
>> ---
>>  migration/ram.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 119 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4a0ab8105f..08604222f2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -106,6 +106,12 @@
>>   */
>>  #define FIXED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
>>  
>> +/*
>> + * When doing fixed-ram migration, this is the amount we read from the
>> + * pages region in the migration file at a time.
>> + */
>> +#define FIXED_RAM_LOAD_BUF_SIZE 0x100000
>> +
>>  XBZRLECacheStats xbzrle_counters;
>>  
>>  /* used by the search for pages to send */
>> @@ -2996,6 +3002,35 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>>  }
>>  
>> +static bool fixed_ram_read_header(QEMUFile *file, FixedRamHeader *header,
>> +                                  Error **errp)
>> +{
>> +    size_t ret, header_size = sizeof(FixedRamHeader);
>> +
>> +    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
>> +    if (ret != header_size) {
>> +        error_setg(errp, "Could not read whole fixed-ram migration header "
>> +                   "(expected %zd, got %zd bytes)", header_size, ret);
>> +        return false;
>> +    }
>> +
>> +    /* migration stream is big-endian */
>> +    header->version = be32_to_cpu(header->version);
>> +
>> +    if (header->version > FIXED_RAM_HDR_VERSION) {
>> +        error_setg(errp, "Migration fixed-ram capability version mismatch "
>> +                   "(expected %d, got %d)", FIXED_RAM_HDR_VERSION,
>> +                   header->version);
>> +        return false;
>> +    }
>> +
>> +    header->page_size = be64_to_cpu(header->page_size);
>> +    header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
>> +    header->pages_offset = be64_to_cpu(header->pages_offset);
>> +
>> +    return true;
>> +}
>> +
>>  /*
>>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>>   * long-running RCU critical section.  When rcu-reclaims in the code
>> @@ -3892,6 +3927,80 @@ void colo_flush_ram_cache(void)
>>      trace_colo_flush_ram_cache_end();
>>  }
>>  
>> +static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>> +                                    long num_pages, unsigned long *bitmap)
>> +{
>> +    unsigned long set_bit_idx, clear_bit_idx;
>> +    ram_addr_t offset;
>> +    void *host;
>> +    size_t read, unread, size, buf_size = FIXED_RAM_LOAD_BUF_SIZE;
>> +
>> +    for (set_bit_idx = find_first_bit(bitmap, num_pages);
>> +         set_bit_idx < num_pages;
>> +         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
>> +
>> +        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
>> +
>> +        unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
>> +        offset = set_bit_idx << TARGET_PAGE_BITS;
>> +
>> +        while (unread > 0) {
>> +            host = host_from_ram_block_offset(block, offset);
>> +            size = MIN(unread, buf_size);
>
> Use the macro directly?  buf_size can be dropped then.
>

Ok. We only need it later when multifd support is added to this
function.

>> +
>> +            read = qemu_get_buffer_at(f, host, size,
>> +                                      block->pages_offset + offset);
>
> Error detection missing?  qemu_get_buffer_at() returns 0 if error, then it
> dead loops.
>

Ah right, I was expecting we'd have a direction on how to improve the
qemu-file error handling before I sent this version and ended up
forgetting to do something about it.

>> +            offset += read;
>> +            unread -= read;
>> +        }
>> +    }
>> +}
>> +
>> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>> +                                    ram_addr_t length, Error **errp)
>
> For new code, start to keep using boolean as retval when Error** exists?
>

Yep.

>> +{
>> +    g_autofree unsigned long *bitmap = NULL;
>> +    FixedRamHeader header;
>> +    size_t bitmap_size;
>> +    long num_pages;
>> +
>> +    if (!fixed_ram_read_header(f, &header, errp)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    block->pages_offset = header.pages_offset;
>> +
>> +    /*
>> +     * Check the alignment of the file region that contains pages. We
>> +     * don't enforce FIXED_RAM_FILE_OFFSET_ALIGNMENT to allow that
>> +     * value to change in the future. Do only a sanity check with page
>> +     * size alignment.
>> +     */
>> +    if (!QEMU_IS_ALIGNED(block->pages_offset, TARGET_PAGE_SIZE)) {
>> +        error_setg(errp,
>> +                   "Error reading ramblock %s pages, region has bad alignment",
>> +                   block->idstr);
>> +        return -EINVAL;
>> +    }
>> +
>> +    num_pages = length / header.page_size;
>> +    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>> +
>> +    bitmap = g_malloc0(bitmap_size);
>> +    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
>> +                           header.bitmap_offset) != bitmap_size) {
>> +        error_setg(errp, "Error reading dirty bitmap");
>> +        return -EINVAL;
>> +    }
>> +
>> +    read_ramblock_fixed_ram(f, block, num_pages, bitmap);
>
> Detect error and fail properly?
>

Ok.

>> +
>> +    /* Skip pages array */
>> +    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
>> +
>> +    return 0;
>> +}
>> +
>>  static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>>  {
>>      int ret = 0;
>> @@ -3900,6 +4009,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>>  
>>      assert(block);
>>  
>> +    if (migrate_fixed_ram()) {
>> +        Error *local_err = NULL;
>> +
>> +        ret = parse_ramblock_fixed_ram(f, block, length, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +        }
>> +        return ret;
>
> We can optionally add one pre-requisite patch to convert parse_ramblock()
> to return boolean too.  I remember it was done somewhere before, but maybe
> not merged.
>

I don't think we changed the return type. There was only a refactoring
at commit 2f5ced5b. I'll change to boolean if possible.

>> +    }
>> +
>>      if (!qemu_ram_is_migratable(block)) {
>>          error_report("block %s should not be migrated !", block->idstr);
>>          return -EINVAL;
>> -- 
>> 2.35.3
>> 

