Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3217B8713
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:57:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo673-00057k-Lk; Wed, 04 Oct 2023 13:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo670-000528-SJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo66z-0002Ft-3p
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696442200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5gClMKl3e0ID9u6UMhmsytgUaZNhBLwf+u9p0u2vhQ=;
 b=C3NORYD4m4cmH5xxmab6YNcbrq2gQozou4gGB8lI/BtzHVRfQzAAkU0tVhr0ZIuuRtK95V
 d8U8PbTKgZ4T/SIdB37CNlGV8S48q5eHJwmCneKmP/MYOzynuyXTrWzPQIdyeEwBnzvwb6
 IYk3c/hnIFpqlkUpcxv6ZI3ppgvThKY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-xmLq5x9mMhuG99aDy9NUnA-1; Wed, 04 Oct 2023 13:56:39 -0400
X-MC-Unique: xmLq5x9mMhuG99aDy9NUnA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3af603daa10so143859b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442198; x=1697046998;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5gClMKl3e0ID9u6UMhmsytgUaZNhBLwf+u9p0u2vhQ=;
 b=eIUwsnAT1UcAQVZJie4jkLmAAeMO7MTyYv0EYdJYWziRFHG+JUmlJIcnIBYF9aIxQz
 qPvF8ZGC3rDbXBLo4Azqql8MQYL1DXcqj5N3hTV5cOCWHttgr5mTxibUcl3UVSnsmcv6
 76eP4smMxYi99LnWEvf6B8MLGkdushninWNg7zsR3xkzFcJH74ViyiwQdZPmTghpJw65
 5LK7kmfGWatg2KBRHlr5zZtvOaZNCg7weh1ZdslwnV5L8wrbKPYUGIJI6qoTR2j9tMQH
 xYL9rnEoOtPjwbHsNl0uBUSWewFwpEfVD54fJjEJf6/zmI8VYyNhcpbVaGvv32K1t489
 AnaQ==
X-Gm-Message-State: AOJu0Yzy82TTLQ1A5kWEvefEkfwloXZXQfc/oByizrEFvU2FZQQwVG1P
 RqFkokHOjXw7uEfR8VtPQlJ/Wwq7bbymR/Xx7Vr2+PqCpHjI9c35aCIIhGuLbyssBN73sb/D8OG
 EJCZtw7Uk71I4x2M=
X-Received: by 2002:a05:6870:a99a:b0:1d5:c417:503e with SMTP id
 ep26-20020a056870a99a00b001d5c417503emr3159762oab.57.1696442198556; 
 Wed, 04 Oct 2023 10:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHPftd+OidC9NtqvqBLc8I7t8VhUO/UQoMb4Rup4Hzau1iNifvpKm+W0XL1hhvJshEuJRauA==
X-Received: by 2002:a05:6870:a99a:b0:1d5:c417:503e with SMTP id
 ep26-20020a056870a99a00b001d5c417503emr3159748oab.57.1696442198292; 
 Wed, 04 Oct 2023 10:56:38 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 h6-20020a37c446000000b007759a81d88esm1416929qkm.50.2023.10.04.10.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:56:37 -0700 (PDT)
Message-ID: <11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com>
Date: Wed, 4 Oct 2023 19:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
 <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: Wshadow: Better name for 'optarg'?
In-Reply-To: <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 04/10/2023 19.43, Philippe Mathieu-Daudé wrote:
> On 4/10/23 19:35, Thomas Huth wrote:
>> On 04/10/2023 19.23, Richard Henderson wrote:
>>> On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
>>>
>>> I thought things like this is why we were trying -Wshadow=local.
>>>
>>> I think it's unlikely that we'll be able to prevent all such cases.
>>
>> Given the broad range of operating systems and libraries that we support 
>> in QEMU, I agree with Richard - it will likely be impossible to enable 
>> that option without =local by default without risking that compilation 
>> breaks on some exotic systems or new versions of various libraries.
> 
> -Wshadow=local doesn't seem to work here which is why I switched
> to -Wshadow. I probably misunderstood something from Markus cover
> letter. My setup is:
> 
> C compiler for the host machine: clang (clang 14.0.3 "Apple clang version 
> 14.0.3 (clang-1403.0.22.14.1)")
> 
> I suppose we'll figure that out when eventually enabling -Wshadow=local
> on CI. Meanwhile I already cleaned the 'optarg' warnings that were
> bugging me, see:
> https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
> I'll try to get -Wshadow=local, but the other series still seems a
> good cleanup, as I used more meaningful variable names.

If I got that right, -Wshadow=local only works with gcc and not with clang 
yet, so we'll need a check in configure or meson.build and will be able to 
only use it when it's available.

If we could use "-Wshadow" to check global variables, too, that would be 
great, but given my experience with some other project, it's very unlikely 
that you can get it running reliably everywhere, since there is often a bad 
library header somewhere that declares some global variable(s) that spoil 
your plans (IIRC I've once seen a bad library that even declared a global 
variable called "x" ... and you certainly don't want to rename all 
occurances of "x" in the QEMU source code just because of a bad library ... 
however, that's been many years ago, though, maybe the situation got better 
nowadays, so if you like, feel free to continue your quest - just be aware 
that it might not be solvable at the end).

  Thomas


