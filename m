Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC37DD6DD
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:02:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxuv1-0001Kw-Ii; Tue, 31 Oct 2023 16:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxuuv-0001KT-Ae
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:00:49 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxuut-0000M1-0A
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:00:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C16E215D5;
 Tue, 31 Oct 2023 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698782444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vuiTvZzKieQXaQeBQbgcgBkHYseaw/GY09394/qbLZM=;
 b=F2RsFN4NBvzqWskKpf3YPlEBE09iBCqAqW598ME7nEpNcUpt8AJ00tQEyLMDIhYqwIfzS+
 lgJ5/UAotMHnVqUzSfF4H6XlYNAc3WPXRYNrrfXK52sp8TmSk2cJfrmI5cT+YYZwHiwf8K
 Vp27RKsz0PEBpQGKOU6TwOUOzela5G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698782444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vuiTvZzKieQXaQeBQbgcgBkHYseaw/GY09394/qbLZM=;
 b=EUeSPqgsgBTrAxiXOL5BJg7f4NjBxZ0q93HeUeNqjwrRDwekAy0fLChneKJ3hR9EItkuiB
 um8cqrDZbvx23nDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CC851391B;
 Tue, 31 Oct 2023 20:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8JNGOutcQWVrOwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 20:00:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
In-Reply-To: <ZUFRBeFV8yF2SVLy@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de> <ZUFRBeFV8yF2SVLy@x1n>
Date: Tue, 31 Oct 2023 17:00:41 -0300
Message-ID: <87ttq6d0k6.fsf@suse.de>
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

> On Mon, Oct 23, 2023 at 05:35:55PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>> 
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
>> (farosas) reused more of the common code by making the fixed-ram
>> function take only one ramblock and calling it from inside
>> parse_ramblock.
>> ---
>>  migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 152a03604f..cea6971ab2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3032,6 +3032,32 @@ static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>>  }
>>  
>> +static int fixed_ram_read_header(QEMUFile *file, struct FixedRamHeader *header)
>> +{
>> +    size_t ret, header_size = sizeof(struct FixedRamHeader);
>> +
>> +    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
>> +    if (ret != header_size) {
>> +        return -1;
>> +    }
>> +
>> +    /* migration stream is big-endian */
>> +    be32_to_cpus(&header->version);
>> +
>> +    if (header->version > FIXED_RAM_HDR_VERSION) {
>> +        error_report("Migration fixed-ram capability version mismatch (expected %d, got %d)",
>> +                     FIXED_RAM_HDR_VERSION, header->version);
>
> I know it doesn't matter a lot for now, but it'll be good to start using
> Error** in new codes?

This whole series was written before the many discussions we had about
error handling. Thanks for pointing that out, I'll revise and change
where appropriate.

>> +        return -1;
>> +    }
>> +
>> +    be64_to_cpus(&header->page_size);
>> +    be64_to_cpus(&header->bitmap_offset);
>> +    be64_to_cpus(&header->pages_offset);
>> +
>> +
>> +    return 0;
>> +}
>> +
>>  /*
>>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>>   * long-running RCU critical section.  When rcu-reclaims in the code
>> @@ -3932,6 +3958,68 @@ void colo_flush_ram_cache(void)
>>      trace_colo_flush_ram_cache_end();
>>  }
>>  
>> +static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>> +                                    long num_pages, unsigned long *bitmap)
>> +{
>> +    unsigned long set_bit_idx, clear_bit_idx;
>> +    unsigned long len;
>> +    ram_addr_t offset;
>> +    void *host;
>> +    size_t read, completed, read_len;
>> +
>> +    for (set_bit_idx = find_first_bit(bitmap, num_pages);
>> +         set_bit_idx < num_pages;
>> +         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
>> +
>> +        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
>> +
>> +        len = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
>> +        offset = set_bit_idx << TARGET_PAGE_BITS;
>> +
>> +        for (read = 0, completed = 0; completed < len; offset += read) {
>> +            host = host_from_ram_block_offset(block, offset);
>> +            read_len = MIN(len, TARGET_PAGE_SIZE);
>
> Why MIN()?  I didn't read qemu_get_buffer_at() yet, but shouldn't len
> always be multiple of target page size or zero?
>

Hmm, this is not my code. The original code had MIN(len, BUFSIZE) with
BUFSIZE being defined at 4M. I think the idea might have been to cap the
amount of pages read.

So it seems I have made a mistake here and this could be reading more
pages at a time.


