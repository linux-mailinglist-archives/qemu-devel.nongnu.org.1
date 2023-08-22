Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8245B784098
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQM4-0006f7-V0; Tue, 22 Aug 2023 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQLo-0006ch-3W
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:19:13 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQLl-0000Nu-8L
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:19:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9433222C44;
 Tue, 22 Aug 2023 12:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692706747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixFgzf8Xbl6ZCZF0vUgoBoOB+aFPEF9+8z78Uc88FcE=;
 b=z6vRIoKd/AZ0wFEtRn/HeNy83b1F+kQ9Di8Woi9dY8tLQLFtNaGI9UeHNb5rkE/EiKbVWl
 EiXflh2r/o6Df0qDsGLOD9gbTwDB/VYxEdxmrH9JqZtXm2pzAVzJtwKygm7nuA7ZHIRKt2
 K9C8u4LMrbcV03IiC0w9jShLPVi+M7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692706747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixFgzf8Xbl6ZCZF0vUgoBoOB+aFPEF9+8z78Uc88FcE=;
 b=famVpwin36P0H9Hd+sWVyUbU9ysneSxci9myCMbBX0mOoSqQ8S+5m3T26ZWkWIbfRPbG27
 pKnrkjy73X/VrkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54E6113919;
 Tue, 22 Aug 2023 12:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id edQgE7un5GQJYAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 12:19:07 +0000
Message-ID: <8a1d2d16-c736-1090-8a9e-d1967c6cd6f3@suse.de>
Date: Tue, 22 Aug 2023 14:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 4/4] migration/ram: Merge save_zero_page functions
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230816182817.17590-1-farosas@suse.de>
 <20230816182817.17590-5-farosas@suse.de>
 <1ef1bbbe-299f-c32d-bb93-804d1aa3b421@suse.de>
In-Reply-To: <1ef1bbbe-299f-c32d-bb93-804d1aa3b421@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Apologies, already reviewed, will ping for the merge of the series momentarily,

Claudio

On 8/22/23 14:18, Claudio Fontana wrote:
> Hello,
> 
> this patch would still need a review,
> 
> and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
> when migrating to disk, since Peter Xu already reviewed PATCH 1, 2, 3, maybe it makes sense to look at 4 too?
> 
> Thanks,
> 
> Claudio
> 
> On 8/16/23 20:28, Fabiano Rosas wrote:
>> We don't need to do this in two pieces. One single function makes it
>> easier to grasp, specially since it removes the indirection on the
>> return value handling.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/ram.c | 46 +++++++++++++---------------------------------
>>  1 file changed, 13 insertions(+), 33 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 82ff53beec..13935ead1c 100644
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
>>  }
>>  
>>  /*
>> @@ -2154,9 +2135,8 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>>          return 1;
>>      }
>>  
>> -    res = save_zero_page(rs, pss, block, offset);
>> -    if (res > 0) {
>> -        return res;
>> +    if (save_zero_page(rs, pss, block, offset)) {
>> +        return 1;
>>      }
>>  
>>      /*
> 


