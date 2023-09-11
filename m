Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AEE79AAA5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfl8k-0003il-CE; Mon, 11 Sep 2023 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfl8i-0003iX-4C
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qfl8f-0000iD-N6
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694454956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJIorHTBqrJ9wNzw1jBsJskLbTrcCbV0Ztf1pU2z2XI=;
 b=O0fJcCjcrmbr04UHbynh9/qwxCbdVa1uZe/54x8wSai8OG8x1PIVvBVqy6AqbytHSPH3tC
 ODdLSlbTE0WO/+HicymbDqjq9N/ptpmqmLGt+taJBRqNVut5aLkhtlsV0YuP5VaxKfxLna
 zTZ0M3ofPBNumkPdUJ7mf5coKDoK1Gw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-0FirFKuyPfSxtlyoKhCMOg-1; Mon, 11 Sep 2023 13:55:54 -0400
X-MC-Unique: 0FirFKuyPfSxtlyoKhCMOg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so3392543f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 10:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694454954; x=1695059754;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJIorHTBqrJ9wNzw1jBsJskLbTrcCbV0Ztf1pU2z2XI=;
 b=O55OdRSrvWqm7oNwR1cC4vJ26WMRDtjj67lHxKGu13EPYwXZkwojsrJ7Vpjl8lCEc6
 rcMrijX7rcyV2ScBLgNMZDRDblV1up7nBSRx+tZlQYRl03PhPBF/e3Eg43yRevRTlAU3
 ZnO9DTdLldEEuUlZSFAzx7xJ3Iyra3Ew5cQ3pw0HEFVPc882pXnAT4kNzuu+wMWyTHLy
 HeLIg2IMenKz6vAqONUF7JuvtRd6JtsAkcbdiurfgi3Y8HarOvtEQ/elxoFjYMEgO3lb
 3Ea4xeG9uC3hSnEOxCP5t8+FzXxRFbsgpVAy2ON22EijHeoNEhwHgT0gjgjVeQ/VhfoF
 o+3g==
X-Gm-Message-State: AOJu0YwxchJTnNWirbzQsvYwAEJiJNlxObYJcwRCu/POXPlXA4goEc7b
 AAWw3nhxdgUeFDc08sG9oGY7GaLhDVBQmAX7dkTU4JwaHZ0HzwH3XLHMCgKzVTFWxsMW0/j+aQN
 nk8l1/sTSH2uali3SK7DkM4A=
X-Received: by 2002:adf:a418:0:b0:31f:b36b:6d45 with SMTP id
 d24-20020adfa418000000b0031fb36b6d45mr1095998wra.52.1694454953770; 
 Mon, 11 Sep 2023 10:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt1BZ8F4NqpCYfWJkg69kgZ+ePgw9yng+VYU7d5UGuFa+jQEtlkPrdIBFGu+NshLftDieLBQ==
X-Received: by 2002:adf:a418:0:b0:31f:b36b:6d45 with SMTP id
 d24-20020adfa418000000b0031fb36b6d45mr1095983wra.52.1694454953421; 
 Mon, 11 Sep 2023 10:55:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f?
 (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de.
 [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a5d6b01000000b0031f300a4c26sm10604583wrw.93.2023.09.11.10.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 10:55:52 -0700 (PDT)
Message-ID: <6841f996-497a-3420-9447-524295179535@redhat.com>
Date: Mon, 11 Sep 2023 19:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2,1/1] memory: avoid updating ioeventfds for some
 address_space
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, hongmainquan <hongmianquan@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20230830032906.12488-1-hongmianquan@bytedance.com>
 <499fe9b1-54f5-4d0f-ae2b-165cb0f3e6b3@bytedance.com> <ZP9AIScw8GrKZNlR@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZP9AIScw8GrKZNlR@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11.09.23 18:28, Peter Xu wrote:
> On Mon, Sep 04, 2023 at 08:51:43PM +0800, hongmainquan wrote:
>>
>> Friendly ping...
>> Hello, this patch has already received a R-b from PeterXu. Could you please
>> help me review it as well and see if there are any issues? If everything is
>> fine, could you please consider merging it? Thank you!
> 
> Paolo, wanna pick this one up?
> 
> David, I know you're preparing a pull with a lot of memory changes, if you
> like to pick this up it'll be good too.

I queued it to

https://github.com/davidhildenbrand/qemu.git mem-next

If nobody beats me to it (or requests me to drop it), I'll send it 
upstream next week.

-- 
Cheers,

David / dhildenb


