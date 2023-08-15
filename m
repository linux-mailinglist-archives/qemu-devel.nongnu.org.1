Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030377D6A9
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 01:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW3T8-0002Ku-50; Tue, 15 Aug 2023 19:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW3T5-0002KX-T4
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 19:28:55 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW3T3-0007Bq-Im
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 19:28:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 079FF2199B;
 Tue, 15 Aug 2023 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692142132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyUkU70pu7iTvM4HcFkXXU+Lyh5db4+WXFxJkoe7Elg=;
 b=1xjKBdlIh2zT9iDN0ZP9jQVwq0414nV8zSgwXwCGO2qRCDR2TFntfQjuJFfLVnudWQqYwj
 q0OGMYaWvV37fhFN7RxAhsVVJkv+0PGn7/5kpD2cAiZCXrDGU9Nj1jQ640e6UcrucqDFmx
 mGGwN79xgBlji40PC+M32Hd+tM/u9Ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692142132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyUkU70pu7iTvM4HcFkXXU+Lyh5db4+WXFxJkoe7Elg=;
 b=HAPYhEbJRMXYUci7+Q75fyRGu1ev2/0rBVXlvHgzV63pMmB19mvdNG6m6MpySt1A3nlERL
 zH5JtecLhpTF2xAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DFDF1353E;
 Tue, 15 Aug 2023 23:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IA5ZFjMK3GQ/RgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 23:28:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 5/5] migration/ram: Merge save_zero_page functions
In-Reply-To: <ZNv86AwQoEzJ5eY6@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-6-farosas@suse.de> <ZNv86AwQoEzJ5eY6@x1n>
Date: Tue, 15 Aug 2023 20:28:49 -0300
Message-ID: <87zg2rlwb2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Tue, Aug 15, 2023 at 11:38:28AM -0300, Fabiano Rosas wrote:
>> We don't need to do this in two pieces. One single function makes it
>> easier to grasp, specially since it removes the indirection on the
>> return value handling.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/ram.c | 41 +++++++++++------------------------------
>>  1 file changed, 11 insertions(+), 30 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 8ec38f69e8..13935ead1c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1128,32 +1128,6 @@ void ram_release_page(const char *rbname, uint64_t offset)
>>      ram_discard_range(rbname, offset, TARGET_PAGE_SIZE);
>>  }
>>  
>> -/**
>> - * save_zero_page_to_file: send the zero page to the file
>> - *
>> - * Returns the size of data written to the file, 0 means the page is not
>> - * a zero page
>> - *
>> - * @pss: current PSS channel
>> - * @block: block that contains the page we want to send
>> - * @offset: offset inside the block for the page
>> - */
>> -static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
>> -                                  ram_addr_t offset)
>> -{
>> -    uint8_t *p = block->host + offset;
>> -    QEMUFile *file = pss->pss_channel;
>> -    int len = 0;
>> -
>> -    if (buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>> -        len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
>> -        qemu_put_byte(file, 0);
>> -        len += 1;
>> -        ram_release_page(block->idstr, offset);
>> -    }
>> -    return len;
>> -}
>> -
>>  /**
>>   * save_zero_page: send the zero page to the stream
>>   *
>> @@ -1167,12 +1141,19 @@ static int save_zero_page_to_file(PageSearchStatus *pss, RAMBlock *block,
>>  static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>>                            ram_addr_t offset)
>>  {
>> -    int len = save_zero_page_to_file(pss, block, offset);
>> +    uint8_t *p = block->host + offset;
>> +    QEMUFile *file = pss->pss_channel;
>> +    int len = 0;
>>  
>> -    if (!len) {
>> -        return -1;
>> +    if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>> +        return 0;
>>      }
>>  
>> +    len += save_page_header(pss, file, block, offset | RAM_SAVE_FLAG_ZERO);
>> +    qemu_put_byte(file, 0);
>> +    len += 1;
>> +    ram_release_page(block->idstr, offset);
>> +
>>      stat64_add(&mig_stats.zero_pages, 1);
>>      ram_transferred_add(len);
>>  
>> @@ -1186,7 +1167,7 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>>          XBZRLE_cache_unlock();
>>      }
>>  
>> -    return 1;
>> +    return len;
>
> I don't think it's correct.. We need to keep the retval definition (how
> many pages were sent) rather than returning num of bytes, I think.
>
> I'm curious how did this pass any form of test.. because I think we did
> assert that:
>
>             /* Be strict to return code; it must be 1, or what else? */
>             if (migration_ops->ram_save_target_page(rs, pss) != 1) {
>                 error_report_once("%s: ram_save_target_page failed", __func__);
>                 ret = -1;
>                 goto out;
>             }
>
> Did I miss something?

Kind of, this code is correct. It's just that I made save_zero_page()
return bytes like save_zero_page_to_file() used to do and made
ram_save_target_page() return 1 instead of passing the value from
save_zero_page() along.

But there's a bug in patch 3 because what I described above should only
happen in this patch 5.



