Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B37779428
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:17:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUpF-00081y-A9; Fri, 11 Aug 2023 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUUp6-0007z1-KF
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUUp5-0002me-5w
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZloaO5cXz04O9tEq8dKPGanbIiR3+4SgTSMNTeP0hU=;
 b=bk7pF0TdHX1BAcFATe2yj7xeI0glTz8oRE2hwvCODXhpZMQ7mKNVHsmrpZveE0xJ5f++y3
 +HlWn+9nD3OXOhDoMkLTtGW7bHiPRtH6atVnRdKFIdo8DzAyxBT2nXgcDiniG1ctE8FPwS
 kqvcTcoGMyzTq3izodVz0PMRFd03C00=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-KULoogivNkStZj9Fpg4_PA-1; Fri, 11 Aug 2023 12:17:08 -0400
X-MC-Unique: KULoogivNkStZj9Fpg4_PA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe175fc1f8so14254695e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770627; x=1692375427;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZloaO5cXz04O9tEq8dKPGanbIiR3+4SgTSMNTeP0hU=;
 b=gm3kWbpTw6lojjxzWfKs5J3wUzJVwvdzfcvagLXGxN4LQoAo4u/p1EkwReRIXalNB+
 /zuecpxyxN7WzEuj45M4sT7CIa16pptIbTLiVh7ZlFqUiV6HX8zMyCPYds0LJ9xHl3mK
 LrX7uQsbvUqajB6rYqt9Y7kHEr47UMqIqXGRe3uCve8q7Qq2nF6kFshxyuhGtc6Iy/e5
 o+5Ma4FnwjlnITrdMrLVTW1cikrsqTyIj8V6TuUhtmALn1ENNjxWtrkbutJhek5vQkDY
 HtzKyfVCZT4cHyd6LIhgpLQtAqP8jGpkhYP8HoC8FBvAWqaXV5+Qxs5SPrcD1onFulKX
 D9EQ==
X-Gm-Message-State: AOJu0YwoV4j9vjqV9DBGMJS1Sf5j7SzzpuKYZOGSuCMW79nw5tS4s8Bb
 TYFVQT7cbxKqqFL1Mw6lPTYKxCLkDSBrtGgbjEto8Xxn6t46eVryjzKDhMQtuQIbX7i6DntD7lL
 wFT5dpgsH9X5KHO8=
X-Received: by 2002:a7b:cd0f:0:b0:3fe:16d3:7d60 with SMTP id
 f15-20020a7bcd0f000000b003fe16d37d60mr1978399wmj.9.1691770627180; 
 Fri, 11 Aug 2023 09:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA1lzQoh/wfwieXUMVfYP7oX2DxdxocoNYyvQ9yX22Q4+PfyZ/a8raI2rXWUNQQY+HeL8PqQ==
X-Received: by 2002:a7b:cd0f:0:b0:3fe:16d3:7d60 with SMTP id
 f15-20020a7bcd0f000000b003fe16d37d60mr1978384wmj.9.1691770626838; 
 Fri, 11 Aug 2023 09:17:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b003fc01189b0dsm5595142wmh.42.2023.08.11.09.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:17:06 -0700 (PDT)
Message-ID: <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com>
Date: Fri, 11 Aug 2023 18:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n> <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com> <ZNZez9ICBBf+D/d2@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZNZez9ICBBf+D/d2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11.08.23 18:16, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 05:26:24PM +0200, David Hildenbrand wrote:
>> I just started looking into the origins of "-mem-path".
>>
>> Originally c902760fb2 ("Add option to use file backed guest memory"):
>>
>> * Without MAP_POPULATE support, we use MAP_PRIVATE
>> * With MAP_POPULATE support we use MAP_PRIVATE if mem_prealloc was not
>>    defined.
>>
>> It was only used for hugetlb. The shared memory case didn't really matter:
>> they just needed a way to get hugetlb pages into the VM. Opening the file
>> R/W even with MAP_PRIVATE kind-of made sense in that case, it was an
>> exclusive owner.
>>
>> Discarding of RAM was not very popular back then I guess: virtio-mem didn't
>> exist, virtio-balloon doesn't even handle hugetlb today really, postcopy
>> didn't exist.
>>
>>
>> I guess that's why nobody really cared about "-mem-path" MAP_PRIVATE vs.
>> MAP_SHARED semantics: just get hugetlb pages into the VM somehow.
>>
>> Nowadays, "-mem-path" always defaults to MAP_PRIVATE. For the original
>> hugetlb use case, it's still good enough. For anything else, I'm not so
>> sure.
> 
> Ok this answers my other question then on the compat bit.. thanks.  Feel
> free to ignore there.
> 
> But then I'd lean back towards simply adding a fdperm=; that seems the
> simplest, since even if with a compat bit, we still face risk of breaking
> -mem-path users for anyone using new machine types.

We wouldn't touch "-mem-path".

-- 
Cheers,

David / dhildenb


