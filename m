Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5410C749784
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKPC-0000cr-Jb; Thu, 06 Jul 2023 04:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKP9-0000X6-VC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKP8-0006Sf-C9
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTbYL5J9ud8oAX/7GEIyHPJBB5SCYp7KoFhZEk9r3DY=;
 b=RzKlzjCiq9CcXtFBUJovKb0uYPctbmfxKPsgaVjNYWyCS4Iq8Rpr84Vuc8JVoGgmG7xh3p
 jwNv43P4co5g0eq6y+Z3aigUsJtUCze8nYVojuuzrMAoLNFlzlk1kOp0VCRkaabhKTzqX4
 2JgNRM8Q621HbOFP4Wr1vQhXd0ePmGA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-bztd6O_ENuCfpVcupvDhcg-1; Thu, 06 Jul 2023 04:31:56 -0400
X-MC-Unique: bztd6O_ENuCfpVcupvDhcg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb87c48aceso383098e87.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688632315; x=1691224315;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTbYL5J9ud8oAX/7GEIyHPJBB5SCYp7KoFhZEk9r3DY=;
 b=gy136GuIGQa7bvOUqbh4S1DD2qoN9Nj0EtzHJQHnzyH8RbDlosHkyWOc3Th0wF2Z0T
 XbvDHHJFhaFv5gAZlSWtVda9nW36GW1z/sb+suAJWO4MZjbqQWiHY8bdf7yWuVn6hMFR
 z9ZBaMGY7Re/llMQ3jckzOFPeKqoD12yHc3DuLJqvwzgv4mAIO7t4q0o4LOGImDORfNK
 8RGC9OraGWm7cPVfxpV4wbUE7xWnZevo0KmdjUhALSS1OUxXPPYOV0c3K/YbCFOsOBgu
 qh0ub8jocYv0IMgNsYo7qOPncdLfyrkvxn5RldeyQP2Rus6Dd+acTkhFfYPBZrnFE/iD
 kV6A==
X-Gm-Message-State: ABy/qLZZ4DCFNtsw7n0pvzp1CTQiNChMF7tkuF4ZfHPu0Ow2EDSu9zn1
 eZDp2ocm2MQpHQ0PDld3OL+p3zoizQdIPbkdNW2tJz1waJJLLMKwFgGZ3OFdsshZYgD1kYkW6nR
 4YvCtQvgYU1UUgrw=
X-Received: by 2002:ac2:4da1:0:b0:4f9:56b8:45de with SMTP id
 h1-20020ac24da1000000b004f956b845demr1034839lfe.38.1688632314915; 
 Thu, 06 Jul 2023 01:31:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH4nui4FMMnjSopUWEYcJqRWWNYIGjXXvJ2/rReE44drJPBiThGQIdGyL7EVkMlWSTunwWzxg==
X-Received: by 2002:ac2:4da1:0:b0:4f9:56b8:45de with SMTP id
 h1-20020ac24da1000000b004f956b845demr1034823lfe.38.1688632314515; 
 Thu, 06 Jul 2023 01:31:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d6084000000b00314374145e0sm1216161wrt.67.2023.07.06.01.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:31:54 -0700 (PDT)
Message-ID: <6cceb935-1830-2984-7529-59d1f8881d34@redhat.com>
Date: Thu, 6 Jul 2023 10:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com> <87jzvdbgv1.fsf@secure.mitica>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
In-Reply-To: <87jzvdbgv1.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06.07.23 10:10, Juan Quintela wrote:
> David Hildenbrand <david@redhat.com> wrote:
>> ram_block_discard_range() cannot possibly do the right thing in
>> MAP_PRIVATE file mappings in the general case.
>>
>> To achieve the documented semantics, we also have to punch a hole into
>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>> of such a file.
>>
>> For example, using VM templating -- see commit b17fbbe55cba ("migration:
>> allow private destination ram with x-ignore-shared") -- in combination with
>> any mechanism that relies on discarding of RAM is problematic. This
>> includes:
>> * Postcopy live migration
>> * virtio-balloon inflation/deflation or free-page-reporting
>> * virtio-mem
>>
>> So at least warn that there is something possibly dangerous is going on
>> when using ram_block_discard_range() in these cases.
>>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> (at least we give a warning)
> 
> But I wonder if we can do better and test that:
>   * Postcopy live migration
> 
>     We can check if we are on postcopy, or put a marker so we know that
>     postcopy can have problems when started.
> 
>   * virtio-balloon inflation/deflation or free-page-reporting
> 
>     We can check if we have ever used virtio-balloon.
> 
>   * virtio-mem
> 
>     We can check if we have used virtio-men
> 
> 
> I am just wondering if that is even possible?

Now we warn when any of these features actually tries discarding RAM 
(calling ram_block_discard_range()).

As these features trigger discarding of RAM, once we reach this point we 
know that they are getting used. (in comparison to default libvirt 
attaching a virtio-balloon device without anybody ever using it)


The alternative would be checking the RAM for compatibility when 
configuring each features. I decided to warn at a central place for now, 
which covers any users.

Thanks!

-- 
Cheers,

David / dhildenb


