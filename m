Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B09787CD566
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 09:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt0ky-0004PB-12; Wed, 18 Oct 2023 03:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0kv-0004P0-Fj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 03:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt0kt-0008GV-OF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 03:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697613251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQX3kPf6xf4u7jNwA07UViHI5z7DRZzumN0hZn2kqkk=;
 b=RcEqD7bjtgzMUf2WTtX8zeU9E02UwlswoucH8177p9bJFeRqoWAdbOYi7AmdUO1dIegWnL
 ANAednpCDrGOXfOHV9VojacM+ykeXPcKcXSs2cIeaSPvnGiUfih50yrPXxNUgy84svu5kZ
 F/d/qkHeeTwbw2WVW5zG3OiiBGW1JHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-e_1teE3JPtuZuqHLeYLhng-1; Wed, 18 Oct 2023 03:13:59 -0400
X-MC-Unique: e_1teE3JPtuZuqHLeYLhng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A60185A79B;
 Wed, 18 Oct 2023 07:13:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27EDD2166B26;
 Wed, 18 Oct 2023 07:13:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B77321E6A1F; Wed, 18 Oct 2023 09:13:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 libvir-list@redhat.com,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 5/7] migration: Deprecate old compression method
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-6-quintela@redhat.com>
 <878r815otk.fsf@pond.sub.org> <875y35yxul.fsf@secure.mitica>
Date: Wed, 18 Oct 2023 09:13:58 +0200
In-Reply-To: <875y35yxul.fsf@secure.mitica> (Juan Quintela's message of "Tue, 
 17 Oct 2023 19:15:14 +0200")
Message-ID: <87lec0xv0p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>
>
>>>  # @deprecated: Member @disk is deprecated because block migration is.
>>> +#     Member @compression is deprecated because it is unreliable and
>>> +#     untested. It is recommended to use multifd migration, which
>>> +#     offers an alternative compression implementation that is
>>> +#     reliable and tested.
>>
>> Two spaces between sentences for consistency, please.
>
> I have reviewed all the patches again.  Let's hope that I didn't miss
> one.
>
>>>  # @announce-step: Increase in delay (in milliseconds) between
>>>  #     subsequent packets in the announcement (Since 4.0)
>>>  #
>>> -# @compress-level: compression level
>>> +# @compress-level: compression level.
>>>  #
>>> -# @compress-threads: compression thread count
>>> +# @compress-threads: compression thread count.
>>>  #
>>>  # @compress-wait-thread: Controls behavior when all compression
>>>  #     threads are currently busy.  If true (default), wait for a free
>>>  #     compression thread to become available; otherwise, send the page
>>> -#     uncompressed.  (Since 3.1)
>>> +#     uncompressed. (Since 3.1)
>>>  #
>>> -# @decompress-threads: decompression thread count
>>> +# @decompress-threads: decompression thread count.
>>>  #
>>>  # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>>>  #     bytes_xfer_period to trigger throttling.  It is expressed as
>>
>> Unrelated.
>
> Rebases are bad for you O:-)
>
>>> @@ -1023,7 +1036,9 @@
>>>  # Features:
>>>  #
>>>  # @deprecated: Member @block-incremental is deprecated. Use
>>> -#     blockdev-mirror with NBD instead.
>>> +#     blockdev-mirror with NBD instead. Members @compress-level,
>>> +#     @compress-threads, @decompress-threads and @compress-wait-thread
>>> +#     are deprecated because @compression is deprecated.
>>
>> Two spaces between sentences for consistency, please.
>
> Done.
>>> @@ -1078,7 +1097,7 @@
>>>  # Example:
>>>  #
>>>  # -> { "execute": "migrate-set-parameters" ,
>>> -#      "arguments": { "compress-level": 1 } }
>>> +#      "arguments": { "multifd-channels": 5 } }
>>>  # <- { "return": {} }
>>>  ##
>>
>> Thanks for taking care of updating the example!
>
> You are welcome.  grep for all occurences of compress-level and friends
> has its advantages.
>
>>>  # @compress-wait-thread: Controls behavior when all compression
>>>  #     threads are currently busy.  If true (default), wait for a free
>>>  #     compression thread to become available; otherwise, send the page
>>> -#     uncompressed.  (Since 3.1)
>>> +#     uncompressed. (Since 3.1)
>>>  #
>>> -# @decompress-threads: decompression thread count
>>> +# @decompress-threads: decompression thread count.
>>>  #
>>>  # @throttle-trigger-threshold: The ratio of bytes_dirty_period and
>>>  #     bytes_xfer_period to trigger throttling.  It is expressed as
>>
>> Unrelated.
>
> I have removed the periods.
>
> But I have a question, why the descriptions that are less than one line
> don't have period and the other have it.

When the description consists of multiple sentences, we obviously need
to end them with punctuation.

Sometimes the description isn't a sentence, just a phrase,
e.g. "decompression thread count".  No punctuation then.

Sometimes it's a single sentence.  Then we roll dice.

>>>      if (params->has_compress_level) {
>>> +        warn_report("Old compression is deprecated. "
>>> +                    "Use multifd compression methods instead.");
>>>          s->parameters.compress_level = params->compress_level;
>>>      }
>>>  
>>>      if (params->has_compress_threads) {
>>> +        warn_report("Old compression is deprecated. "
>>> +                    "Use multifd compression methods instead.");
>>>          s->parameters.compress_threads = params->compress_threads;
>>>      }
>>>  
>>>      if (params->has_compress_wait_thread) {
>>> +        warn_report("Old compression is deprecated. "
>>> +                    "Use multifd compression methods instead.");
>>>          s->parameters.compress_wait_thread = params->compress_wait_thread;
>>>      }
>>>  
>>>      if (params->has_decompress_threads) {
>>> +        warn_report("Old compression is deprecated. "
>
> Once here, I did s/Old/old/
>
> as all your examples of description start with lowercase.

Yes, please.

>>> +                    "Use multifd compression methods instead.");
>>>          s->parameters.decompress_threads = params->decompress_threads;
>>>      }
>>
>> Other than that
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks for your patience.


