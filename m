Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D777945B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUx3-0004kw-Gu; Fri, 11 Aug 2023 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUUwz-0004ke-0w
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qUUwx-0004pE-Iu
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691771118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ju7ON+ETZpXkq8IKR65B0ss2WH8bt7/yQEqZxQkl3hk=;
 b=TvPpe0TFrkoNg2NUBBstimc7vl+xAaDMzliv3Owub9pei6eOq9oggLmlzP8uey+CJM5lam
 siWGfswtsBoDOnodbfaKGs3pmft/BTohBJrowmeGJ0IrJ9x+jwnzYUmV/ARPMmYWi0OtDS
 2KTpeNH7kBCpeQnad2C56Gn6MJ5JuXc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-_Vu9LxeRMKGbC9lgT5Jw2Q-1; Fri, 11 Aug 2023 12:25:17 -0400
X-MC-Unique: _Vu9LxeRMKGbC9lgT5Jw2Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3175b757bbfso1290056f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691771116; x=1692375916;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ju7ON+ETZpXkq8IKR65B0ss2WH8bt7/yQEqZxQkl3hk=;
 b=l+Go8NYy3UKK4MYQF7ck5RleXx0w2dzQjk0BW6wesbU4bzmIhlYLmOFZtihxOMlqOO
 2LsskIcQidL5ogwXtIHN/s/RG2HykEgah9yeHheG/q+nlCDRo3seL5TW/9QHgqEcvI7d
 jdP3FPuU3kNavBRLSCBlETHltz6kh0sGlguyRlNTjRi1eI6bZCCu6vsgybiXFAH6triS
 /RSFqhx48e0uttq9lMr27ZoD4n533wOQG1EQ1sN9zEU6IsKvDgjQE0SsTM4UcOybN3wR
 Izu6wCU1MFdbAsX9fPY5zQvuGLnb3HzZogxHPpeoSl4hluMIfb9In0fHi3xWR3mLgLi1
 9wjQ==
X-Gm-Message-State: AOJu0YybaZpodGuwIPYfSICNj/Rxu15OLd6S7j0K8TKj/tCvHwbE5B7o
 IY+jjEY5UUqL1H2cSklwoeu1/q4Z6i79pF6D9cLRWX6hca5knenqWjHWsD9ieiqVtaSYlDgvhvr
 Ahs4slD/ZxcLRhNI=
X-Received: by 2002:a5d:5584:0:b0:317:58eb:1e33 with SMTP id
 i4-20020a5d5584000000b0031758eb1e33mr1873699wrv.8.1691771115918; 
 Fri, 11 Aug 2023 09:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpJpAcI5+X3CrNWtA5rALoP6ZmdD8PwOJqmrDMeey8ww8qmHcCFvAQNPTATDjjvc87nOa8ng==
X-Received: by 2002:a5d:5584:0:b0:317:58eb:1e33 with SMTP id
 i4-20020a5d5584000000b0031758eb1e33mr1873686wrv.8.1691771115570; 
 Fri, 11 Aug 2023 09:25:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20?
 (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de.
 [2003:cb:c71a:3000:973c:c367:3012:8b20])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a5d6dc2000000b00317f70240afsm5881819wrz.27.2023.08.11.09.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 09:25:15 -0700 (PDT)
Message-ID: <b1630542-475a-f5de-bf79-f6519e01a350@redhat.com>
Date: Fri, 11 Aug 2023 18:25:14 +0200
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
References: <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n> <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com> <ZNZez9ICBBf+D/d2@x1n>
 <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com> <ZNZgRq22IXyqpun7@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZNZgRq22IXyqpun7@x1n>
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

On 11.08.23 18:22, Peter Xu wrote:
> On Fri, Aug 11, 2023 at 06:17:05PM +0200, David Hildenbrand wrote:
>> We wouldn't touch "-mem-path".
> 
> But still the same issue when someone uses -object memory-backend-file for
> hugetlb, mapping privately, expecting ram discard to work?
> 
> Basically I see that example as, "hugetlb" in general made the private
> mapping over RW file usable, so forbidden that anywhere may take a risk.

These users can be directed to using hugetlb

a) using MAP_SHARED
b) using memory-backend-memfd, if MAP_PRIVATE is desired

Am I missing any important use case? Are we being a bit to careful about 
virtio-balloon and postcopy simply not being available for these corner 
cases?

-- 
Cheers,

David / dhildenb


